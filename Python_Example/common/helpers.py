import datetime
import logging

def get_utc_time(current_time = str(datetime.datetime.utcnow()), offset = None):
    try:
        my_time = datetime.datetime.fromisoformat(current_time)
        if offset:
            my_time = my_time + datetime.timedelta(hours=offset)
    except Exception as e:
        logging.debug(e)
        my_time = datetime.datetime.utcnow()

    return my_time.strftime('%Y-%m-%dT%H:%M:%SZ')