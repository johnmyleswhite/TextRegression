#!/bin/bash

rm TextRegression_*.tar.gz
rm -rf TextRegression_.Rcheck
R CMD BUILD .
R CMD CHECK TextRegression_*.tar.gz
rm -rf TextRegression.Rcheck
R CMD INSTALL TextRegression_*.tar.gz
