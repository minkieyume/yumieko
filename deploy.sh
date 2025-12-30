#!/bin/bash
git pull
git add .
git commit -m "自动提交"
git push
hugo
cd public/
git pull
git add .
git commit -m "自动提交"
git push
cd ../
