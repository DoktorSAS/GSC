
# HTTP Get 
This scripts allow the iw4x client servers to send http request. 

### How it work

The script work by generating a file named with a request id called r_id (`r_id = self.guid + "_" + self._requests;`) where self._requests is a counter that at each request it will increase) and then the `handleRequests.py` will read the file placed in the folder `<path>/<net_port>/requests` and then send the http request. The answer will be placed in in the folder `<path>/<net_port>/responses` and will be named with the same r_id genarated before.

Once the `handleRequests.py` read the request file it will remove it and then place the response in the responses folder.

Once the `_http.gsc` read the response file it will remove it.

## Usage
1. Download the files from the git and put `_http.gsc`
2. Place the file in the folder `userraw\scripts`
3. Copy the `handleRequests.py` and put it into `userraw` folder.
   or
   Put the `handleRequests.py` where you want but remeber to change the  `SERVER_FOLDERS_LOCATION` to the rigth path



