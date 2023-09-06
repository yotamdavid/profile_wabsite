# CI/CD Project

Using the Jenkins.file the building, testing, deploying the profile website using ansible and AWS. <br />

## AWS Environment
![image](https://github.com/yotamdavid/profile_wabsite/blob/8bd09de2c3dde6190e947283ee94037998f318dd/aws-env.jpg)

**Vpc**: Set up your vpc - go to vpc to your vpcs and create a new vpc, you will also need to create internet gatweyas and link it to your vpc.

**Security Group**: Define a new security group for the vpc you created and include in it everything your application needs in terms of Inbound rules and Outbound rules.

**Subnets**: Go to subnets and create subnets in different areas and associate them with the vpc you created, you also need to create a route table and link it to your subnets.

**Ec2-instances**: Go to ec2 instances and create two instances when you create them, don't forget to connect them to the vpc you created and each of them will connect to a subnet in a different area you created (one of the instances to a subnet in zone A and one to a subnet in zone B)

**ELB**: Go to ELB and define a target group, connect it to your vpc and open the relevant ports for your application, after you've done that, create an elb and connect it to the target group you created and open the port from which you want them to be able to enter it.

