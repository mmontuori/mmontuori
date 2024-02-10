import pandas as pd
import numpy as np

year_start = 1990
year_end = 2021

for year in range(year_start, year_end+1):

    outfile = 'vaers' + str(year) + '.csv'

    print('processing CSV files for year ' + str(year) + '...')

    print('reading csv files...')
    dfvax = pd.read_csv('/mnt/c/temp/vaers/' + str(year) + 'VAERSVAX.csv', encoding ='latin1', keep_default_na=False)
    dfsym = pd.read_csv('/mnt/c/temp/vaers/' + str(year) + 'VAERSSYMPTOMS.csv', encoding ='latin1', keep_default_na=False)
    dfdata = pd.read_csv('/mnt/c/temp/vaers/' + str(year) + 'VAERSDATA.csv', encoding ='latin1', keep_default_na=False)

    #print(dfvax)
    #print(dfsym)
    #print(dfdata)

    vax_data = {}
    sym_data = {}
    data_data = {}

    print('building VAX data...')
    for vax_row in dfvax.itertuples():
        vaers_id=getattr(vax_row ,'VAERS_ID')
        vax_data[vaers_id] = vax_row

    print('building SYM data...')
    for sym_row in dfsym.itertuples():
        vaers_id=getattr(sym_row ,'VAERS_ID')
        sym_data[vaers_id] = sym_row

    print('building DATA data...')
    for data_row in dfdata.itertuples():
        vaers_id=getattr(data_row ,'VAERS_ID')
        data_data[vaers_id] = data_row

    print('size of VAX data:' + str(len(vax_data)))
    print('size of SYM data:' + str(len(sym_data)))
    print('size of DATA data:' + str(len(data_data)))

    dfvax_columns = dfvax.columns
    dfsym_columns = dfsym.columns
    dfdata_columns = dfdata.columns

    cnt=0
    total_cnt=0
    first_comma=True

    csv_file = ''

    for dfdata_column in dfdata_columns:
        if first_comma is True:
            first_comma = False
        else:
            csv_file += ','
        csv_file += dfdata_column 
    for dfvax_column in dfvax_columns:
        if first_comma is True:
            first_comma = False
        else:
            csv_file += ','
        csv_file += 'vax_' + dfvax_column 
    for dfsym_column in dfsym_columns:
        if first_comma is True:
            first_comma = False
        else:
            csv_file += ','
        csv_file += 'sym_' + dfsym_column 

    csv_file += "\r\n"

    data_keys = data_data.keys()

    for data_key in data_keys:
        data_row = data_data[data_key]
        vax_row = None
        try:
            vax_row = vax_data[data_key]
        except:
            vax_row = None
        sym_row = None
        try:
            sym_row = sym_data[data_key]
        except:
            sym_row = None

        #print(data_row)
        #print(vax_row)
        #print(sym_row)

        first_comma=True

        for dfdata_column in dfdata_columns:
            attr = getattr(data_row, dfdata_column)
            #print('data column:' + dfdata_column + ', value:' + str(attr))
            if first_comma is True:
                first_comma = False
            else:
                csv_file += ','
            csv_file += '"' + str(attr) + '"'

        for dfvax_column in dfvax_columns:
            if vax_row != None:
                attr = getattr(vax_row, dfvax_column)
                #print('vax column:' + dfvax_column + ', value:' + str(attr))
                if first_comma is True:
                    first_comma = False
                else:
                    csv_file += ','
                csv_file += '"' + str(attr) + '"'
            else:
                if first_comma is True:
                    first_comma = False
                else:
                    csv_file += ','
                csv_file += '""'

        for dfsym_column in dfsym_columns:
            if sym_row != None:
                attr = getattr(sym_row, dfsym_column)
                #print('sym column:' + dfsym_column + ', value:' + str(attr))
                if first_comma is True:
                    first_comma = False
                else:
                    csv_file += ','
                csv_file += '"' + str(attr) + '"'
            else:
                if first_comma is True:
                    first_comma = False
                else:
                    csv_file += ','
                csv_file += '""'

        csv_file += '\r\n'

    print('writing output CSV file ' + outfile)
    f = open(outfile, "w")
    f.write(csv_file)
    f.flush()
    f.close()

quit()


for data_row in dfdata.itertuples():
    vaers_id=getattr(data_row ,'VAERS_ID')
    #total_cnt += 1
    vax_row=dfvax[dfvax['VAERS_ID']==vaers_id]
    sym_row=dfsym[dfsym['VAERS_ID']==vaers_id]

    print(data_row)
    print(vax_row.values)
    print(sym_row.values)

    for dfdata_column in dfdata_columns:
        attr = getattr(data_row, dfdata_column)
        print('data column:' + dfdata_column + ', value:' + str(attr))
        csv_file += '"' + str(attr) + '",'

    for dfvax_value in np.nditer(vax_row.values):
        print('value:' + str(dfvax_value))
        #print('value:' + str(attr))
        #print('after')
        #csv_file += '"' + str(attr) + '",'
        
    for dfsym_column in dfsym_columns:
        attr = sym_row[dfsym_column]
        print('sym column:' + dfsym_column + ', value:' + str(attr))
        csv_file += '"' + str(attr) + '",'

    cnt += 1
    if cnt > 1:
        #print(csv_file)
        quit()


    #print('-------------------------------------------')
    #print(data_row.to_csv(header=False) + ',' + vax_row.to_csv(header=False) + ',' + sym_row.to_csv(header=False))

#    if data_row['DIED'] == 'Y':
#        print(vax_row.to_csv(header=False))
        #print('-------------------------------------------')
        #print(data_row)
        #print('===========================================')
        #print(str(vax_row['VAX_TYPE']))
        #print('===========================================')
        #print(sym_row)
#        if 'COVID19' in str(vax_row['VAX_TYPE']):
#            cnt+=1
            #print('1 more dead:' + str(cnt) + ', total record count:' + str(total_cnt))

    
#print('dead:' + str(cnt) + ', total record count:' + str(total_cnt))

# LOOP DATA
# FIND ID in SYM and VAX
# COMBINE INFO
# WRITE NEW FILE

#print(len(df.values))
#for index, row in df.iterrows():
    #print("--------------------------------")
    #print(index)
    #print(row)

#quit()

#print(len(df.values))

#print(df.size)
