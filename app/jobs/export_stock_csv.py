import sys
import pandas_datareader.data as web
import pandas as pd

l = sys.argv
f = web.DataReader([str(item) + '.JP' for index, item in enumerate(l) if index != 0], 'stooq')
df = pd.DataFrame(f["Close"].unstack(0))
latest_date = pd.DataFrame(f["Close"].unstack(0)).tail(1).index[0][1].strftime('%Y-%m-%d %H:%M:%S')
df.query('Date == "' + latest_date + '"').to_csv('tmp/stooq_csv/stock_list.csv')
