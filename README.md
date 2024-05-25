# coastpay-infra-exercise

A rest service is deployed to a container in AWS ECS in private endpoint and exposed it through internet with Alb . To achieve this following tools utilized.

1) Terraform IAC to deploy resources into AWS
2) AWS as a cloud environmet
3) Github actions to build docker images on a self hosted runner

Running a command from Linux terminal will print below Output

Using a curl command 
curl --header "Favorite-Color: Purple" --data "param1=value1&param2=value2" http://coastpay-alb-dev-2038467726.us-east-1.elb.amazonaws.com/
POST / HTTP/1.1
X-Forwarded-For: 96.235.31.20
X-Forwarded-Proto: http
X-Forwarded-Port: 80
Host: coastpay-alb-dev-2038467726.us-east-1.elb.amazonaws.com
X-Amzn-Trace-Id: Root=1-66515603-2afdf6c446b335934b131585
Content-Length: 27
User-Agent: curl/7.81.0
Accept: */*
Favorite-Color: Purple
Content-Type: application/x-www-form-urlencoded
