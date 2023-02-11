import asyncio
import os
import time
import requests

#
# Mod: _http
# Developed by DoktorSAS
#
# Description:
# The python script is what handle the http request, it read from request and generate
# the response files. 

# By default you need to put this file inside the useraw folder, if you want move your script change the path
SERVER_FOLDERS_LOCATION = "./scriptdata/"

def handleRequests(net_port):
    print(f"Listening to: {net_port}") 
    changed_time = os.stat(SERVER_FOLDERS_LOCATION + net_port + "/requests/").st_mtime
    while( 1 ):
        # Observe folder changes such as add file and edit file
        st_mtime = os.stat(SERVER_FOLDERS_LOCATION + net_port + "/requests/").st_mtime
        while changed_time == st_mtime:
            st_mtime = os.stat(SERVER_FOLDERS_LOCATION + net_port + "/requests/").st_mtime
            time.sleep(0.05)
        changed_time = os.stat(SERVER_FOLDERS_LOCATION + net_port + "/requests/").st_mtime

        # Handle requests
        reqs = [name for name in os.listdir(SERVER_FOLDERS_LOCATION + net_port + "/requests/") if name != "junk.txt" and os.path.isfile(os.path.join(SERVER_FOLDERS_LOCATION + net_port + "/requests/", name))]
        if len(reqs) > 0:
            print(f"Requests to handle for {net_port} listed: {reqs}") 
            for file_req in reqs:
                f_path_request = SERVER_FOLDERS_LOCATION + net_port + "/requests/" + file_req
                f_path_response = SERVER_FOLDERS_LOCATION + net_port + "/responses/" + file_req
                file_r = open(f_path_request, "r")  
                content = file_r.read()
                file_r.close()
                print(f"\tRequest {f_path_request}: {content}")

                try: # If success
                    req = requests.get(url = content, timeout=15)
                    print(f"\tResponse {f_path_request}: {req.text}")
                    f = open(f_path_response, "w")
                    f.write(req.text)
                    f.close()
                    os.remove(f_path_request)
                except: # If failed gsc will handle it
                    print(f"\tResponse {f_path_request}: Failed!")

async def handleServers():
    print("httpRequest handler for iw4x running...")
    
    servers_folders = [name for name in os.listdir(SERVER_FOLDERS_LOCATION) if os.path.isdir(os.path.join(SERVER_FOLDERS_LOCATION, name + "/requests/"))]
    print(f"Servers listed: {servers_folders}") 
    while( 1 ):
        await asyncio.sleep(0.2)
        for server_folder in servers_folders:
                print(server_folder)
                asyncio.to_thread(handleRequests(server_folder))
                   
def run():
    print("httpRequest handler for iw4x starting...")
    if( not os.path.exists(SERVER_FOLDERS_LOCATION) ):
        print("\tSERVER_FOLDERS_LOCATION: [X]")
        raise SystemError("Error: Invalid path")
    elif( not os.path.isdir(SERVER_FOLDERS_LOCATION)):
        print("\tSERVER_FOLDERS_LOCATION: [X]")
        raise SystemError("Error: Invalid path")
    print("\tSERVER_FOLDERS_LOCATION: [V]")

    loop = asyncio.get_event_loop()
    loop.run_until_complete(handleServers())
    loop.close()

run()
