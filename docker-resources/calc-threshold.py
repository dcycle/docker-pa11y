import os
import datetime

def var(var):
    try:
        return os.environ[var]
    except:
        raise Exception('please set ' + var + ' as an environment variable; see readme')

def verbose(string):
    if (os.environ['verbose'] == 1):
        print(string)

verbose('**************************************')
verbose('Calculating error threshold acceptance')

start = datetime.datetime.strptime(var('start_date'), '%Y-%m-%d')
verbose('start date is ' + str(start))
end = datetime.datetime.strptime(var('end_date'), '%Y-%m-%d')
verbose('end date is ' + str(end))
now = datetime.datetime.now()
verbose('today is ' + str(now))
verbose('start threshold is ' + str(var('start_threshold')))
verbose('end threshold is ' + str(var('end_threshold')))

if (end < start):
    raise Exception('end date must be on or after start date');

elif (now <= start):
    verbose('Now is before or on the start date, so we are returing the start threshold.')
    print(var('start_threshold'))

elif (now >= end):
    verbose('Now is after or on the start date, so we are returing the end threshold.')
    print(var('end_threshold'))

else:
    totaldays = (end - start).days
    verbose('There are ' + str(totaldays) + ' days between the start and end dates.')
    daystoday = (now - start).days
    verbose('There are ' + str(daystoday) + ' days between the start and today.')
    delta = int(var('end_threshold')) - int(var('start_threshold'))
    verbose('There are ' + str(delta) + ' steps between the start and end thresholds.')
    verbose('Calculating error threshold')
    print(int(var('start_threshold')) + delta * daystoday / totaldays)

verbose('**************************************')
