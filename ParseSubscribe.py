from ast import If
from logging import config
from os import write
from time import sleep
from more_itertools import last
import requests
from urllib.parse import quote
import os

root_path = '/home/vv/clash/configs/'
local_url = 'http://127.0.0.1:15051/sub?'
target = [
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
with open(".secrete",mode='r') as f:    
    token = f.readline()
            
sub_url= "https://efshop.cc/api/v1/client/subscribe?token="+token

def transtorm(req_url,file_name):
    res = requests.get(req_url)
    if res.ok and res.content:
        with open(file_name,mode='wb') as fd:
            fd.write(res.content)
        print(f"Download Done! {file_name}")
    else:
        print(f"{res}:failed downdload {os.path.basename(file_name)}")
        
def url_encode(raw_url): 
    encoded_url = quote(raw_url,safe='')
    # print(encoded_url)
    return encoded_url

def parse_url():
    encoded_url = url_encode(sub_url)
    for item in target:
        if item == 'clash':
            req_url=f"{local_url}target={item}&url={encoded_url}"
            transtorm(req_url,root_path+item+'.yaml')
            break

def change_calsh_contrl_args():
    with open(root_path+"clash.yaml",mode='r') as f:
        lines = f.readlines()
    # attion I'm too lazy to use fixed number as position.!
    lines[0]='mixed-port: 7890\n'
    del lines[1]
    lines[4]="external-controller: '0.0.0.0:9090'\nsecret: '12341234'\n"
    with open(root_path+"clash.yaml",mode='w') as f:
        f.writelines(lines)

    
    
if __name__ == "__main__":
    parse_url()
    change_calsh_contrl_args()
