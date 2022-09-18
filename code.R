library(RCurl)
library(jsonlite)

#token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2OTQyODcyMjQsIm5iZiI6MTY2MzE4NTAyNCwiaWF0IjoxNjYzMTgzMjI0LCJqdGkiOiJDTTpjYXRfbWF0Y2g6bHQxMjM0NTYiLCJvcGVuX2lkIjoiIiwidWlkIjoyOTUxMzE3NSwiZGVidWciOiIiLCJsYW5nIjoiIn0.CHtCkoz5Y38IiEuA5HUah-ikI-dn-8uQPmvkP4oJnSE'

uid = 43400952 #你的游戏id
num = 20     #通关次数
times = 60     #通关时间（秒）
sltime = 0     #间隔时间（秒/默认为0）

addsheep <- function(uid,times,num,sltime){
curl <- getCurlHandle()
urlo = paste("https://cat-match.easygame2021.com/sheep/v1/game/user_info?uid=",uid,"&t=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2OTQ0NzgwMTAsIm5iZiI6MTY2MzM3NTgxMCwiaWF0IjoxNjYzMzc0MDEwLCJqdGkiOiJDTTpjYXRfbWF0Y2g6bHQxMjM0NTYiLCJvcGVuX2lkIjoiIiwidWlkIjo0ODUwNDY1MCwiZGVidWciOiIiLCJsYW5nIjoiIn0.IEjNoHJiJPqlh86DqDS3-SMTwErTCatQF6ykZk4o-Yc",sep="")
tuuid = try(code <- getURL(url=urlo,curl = curl),silent=FALSE)

if('try-error' %in% class(tuuid))
{
  print("获取超时") 
}else{
  uuid=fromJSON(tuuid)$data$wx_open_id
  print(uuid)
  temp = try(token <- postForm("https://cat-match.easygame2021.com/sheep/v1/user/login_oppo",uid=uuid,nick_name='baidu',avatar='https://www.baidu.com/favicon.ico',sex=1),silent=FALSE)
  #print(token)
  #token = fromJSON(postForm("https://cat-match.easygame2021.com/sheep/v1/user/login_tourist",uuid=uuid))$data$token
  if('try-error' %in% class(temp))
  {
    print("获取token失败")
    token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2OTQ1NzA3NzEsIm5iZiI6MTY2MzQ2ODU3MSwiaWF0IjoxNjYzNDY2NzcxLCJqdGkiOiJDTTpjYXRfbWF0Y2g6bHQxMjM0NTYiLCJvcGVuX2lkIjoiIiwidWlkIjo4NDUzMjY2LCJkZWJ1ZyI6IiIsImxhbmciOiIifQ.xyqHgYEk0ylmgNhFRzqLKp9gxBMsgNsGadpMtya-0t8'
    
  }
  else{
    token = fromJSON(token)$data$token
  }
}
if (!is.na(token)){
url = paste('https://cat-match.easygame2021.com/sheep/v1/game/game_over?t=',token,'&rank_score=1&rank_state=1&rank_time=',times,'&rank_role=0&skin=1',sep="")
i = 1
while(i <= num){
  Sys.sleep(sltime)
  temp <- try(code <- getURL(url=url,curl = curl),silent=FALSE)
  if('try-error' %in% class(temp))
  {
    response.code  = 0 
  }
  else{
     response.code <- getCurlInfo(curl)$response.code
   } 
    #code <- getURL(url=url,curl = curl)
    
    
    print(response.code)

  if(response.code!=200){
     print("通关失败，参数失效或者服务器崩溃")
  }
  else{
    print(paste("通关成功，第",i,"次",sep=""))
    i=i+1
    }
   }
  }
}
#for(uid in 1000001:99999999){
addsheep(uid=uid,times=times,num=num,sltime=sltime)
#}
