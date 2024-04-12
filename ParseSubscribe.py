from ast import If
from logging import config
from os import write
from time import sleep
from more_itertools import last
import requests
from urllib.parse import quote
import os

config_dir = './configs/'

#----------Your need modification place------

# Your subscription conversion server
# Don't need to change if you wille use the default doker-compse.yml
conversion_url_path = 'http://127.0.0.1:15051/sub?'
#-------------------------------------------------






# Tranform target type(The out put type that you want)
target_list = [
    "clash",
    "clashr",
    "quan",
    "quanx",
    "loon",
    "mellow",
    "ss",
    "sssub",
    "ssd",
    "ssr",
    "surfboard",
    "surge&ver=2",
    "surge&ver=3",
    "surge&ver=4",
    "trojan",
    "v2ray",
    "mixed",
    "auto"
]

    

def transtorm(req_url,file_name):
    '''
    Function: send you req_url to your local conversion server for transform.
    Input: 
        req_url:your complete subscription.
        file_name:your output config path(include file name.e.g. /xxx/xx/abc.yaml)
    '''
    res = requests.get(req_url)
    if res.ok and res.content:
        with open(file_name,mode='wb') as fd:
            fd.write(res.content)
        print(f"Download Done! {file_name}")
    else:
        print(f"{res}:failed downdload {os.path.basename(file_name)}")
        
   # I don't know why must encode url for excluding symbols like '/?:'
   # But our tranform server need it,so just do it. 
def url_encode(raw_url): 
    '''
    Function: encode your url,you will get a url that don't include any symbols. All symbols will be replace.
    Input: 
        raw_rul:Subscription url with token
    Ouput: return a url that don't have symbols 
    '''
    encoded_url = quote(raw_url,safe='')
    return encoded_url


def parse_url(sub_url):
    '''
    Fn:parse rule the save to file
    Input:
        sub_url: your subcription
    '''
    encoded_url = url_encode(sub_url)
    for item in target_list:
        # if you want get all target result file try to comment the if clause.
        # if don't know you target type ,comment it get all result.
        if item == 'clash':
            req_url=f"{conversion_url_path}target={item}&url={encoded_url}"
            transtorm(req_url,config_dir+item+'.yaml')
            break

def change_clash_contrl_args():
    '''
    Fn: chage mixed-port, external-controller ,password
    Just for clash
    '''
    with open(config_dir+"clash.yaml",mode='r') as f:
        lines = f.readlines()
    # Attention  I directly use fixed number as position for locate action.
    # Just a simple script,I don't want to make it complex. I'm too lazy !
    lines[0]='mixed-port: 7890\n'
    del lines[1]
    lines[4]="external-controller: '0.0.0.0:9090'\nsecret: '12341234'\n"
    with open(config_dir+"clash.yaml",mode='w') as f:
        f.writelines(lines)

    
    
if __name__ == "__main__":
    # Read your Subscription from your file,that need you create by your hand.
    with open(".secret",mode='r') as f:    
        sub_url= f.readline().strip()
    parse_url(sub_url)
    
    change_clash_contrl_args()
