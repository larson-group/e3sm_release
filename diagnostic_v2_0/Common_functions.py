#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 10 13:24:40 2017
Modified on Oct 14 2019
@author: bogenschutz1
         zhunguo  : guozhun@lasg.iap.ac.cn; guozhun@uwm.edu
"""

from netCDF4 import Dataset
import tarfile
import numpy as np
import os

def area_avg(data_orig, weight, is_SE):

    #TO DO: take into account missing values
    if data_orig.dtype == np.float32:
        data=data_orig.astype(np.float64)
    else:
        data=data_orig[:]
    if (is_SE == True):
        a = np.average(data, weights=weight)
    else: #FV
        #a = wgt_areaave(data, weight, 1.0, 1)
        #weights are for lat
        a_lat = np.average(data,axis=0, weights=weight)
        a = np.average(a_lat)
    return a

def makevarlist(datadir,filelist,dimtest,varstoplot):

    numfiles=len(filelist)
    for f in range(0,numfiles):
        filename=filelist[f]
        file=datadir+filename

        print(file)
        fh=Dataset(file,mode='r')

        varsinfile=fh.variables.keys()
        numvars=len(varsinfile)

        dimtest_rev=dimtest

        dimsinfile=fh.dimensions.keys()
        if (dimsinfile[0] == "ncol"):
            dimtest_rev=dimtest-1

        for v in range(0,numvars):
            varname=varsinfile[v]
            if (varname not in varstoplot):
                vartotest=fh.variables[varname][:]
                if (vartotest.ndim == dimtest_rev):
                    theshape=np.shape(vartotest)
                    if (theshape[vartotest.ndim - 1] == 1):
                        varstoplot.append(varname)

    return varstoplot


def replace_string(infile, outfile, replacements):

    with open(infile) as fin:
        with open(outfile, 'w') as fout:
            for line in fin:
                for src,target in replacements.items():
                    line = line.replace(src,target)
                fout.write(line)

    return outfile

def make_tarfile(output_filename,source_dir):
    with tarfile.open(output_filename, "w:gz") as tar:
        tar.add(source_dir, arcname=os.path.basename(source_dir))

    return make_tarfile
