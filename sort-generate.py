from __future__ import print_function

import random
import sys

import boto3
import hashlib
import pywren

if __name__ == "__main__":
    import logging
    import subprocess
    import gc
    import time


    def run_command(key):
        pywren.wrenlogging.default_config()
        logger = logging.getLogger(__name__)

        m = hashlib.md5()
        genpart = str(random.choice(range(50)))
        m.update(genpart.encode('utf-8'))
        #genfile = m.hexdigest()[:8] + "-gensort-" + genpart
        genfile="gensort"
        client = boto3.client('s3', 'us-west-2')
        client.download_file('yupengtang-pywren-891', genfile, '/tmp/gensort')
        subprocess.check_output(["chmod", "a+x", "/tmp/gensort"])

        for i in range(0, 5):
            number_of_records = 1000 * 1000
            begin = key * number_of_records
            data = subprocess.check_output(["/tmp/gensort",
                                            "-b" + str(begin),
                                            str(number_of_records),
                                            "/dev/stdout"])
            keyname = "input/part-" + str(key)
            m = hashlib.md5()
            m.update(keyname.encode('utf-8'))
            randomized_keyname = "input/" + m.hexdigest()[:8] + "-part-" + str(key)
            put_start = time.time()
            client.put_object(Body=data, Bucket="yupengtang-pywren-891", Key=randomized_keyname)
            put_end = time.time()
            logger.info(str(key) + " th object uploaded using " + str(put_end - put_start) + " seconds.")
            gc.collect()
            key = key + 1


    wrenexec = pywren.default_executor()
    num_of_files = int(sys.argv[1])
    print("Generating " + str(100 * int(num_of_files)) + " Mb input dataset.")
    passed_tasks = range(0, num_of_files, 5)

    fut = wrenexec.map(run_command, passed_tasks)

    pywren.wait(fut)
    res = [f.result() for f in fut]
    print(res)
