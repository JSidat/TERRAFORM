output "vpc_1" {
    value = aws_vpc.AprilDevOpsVPC.id
}

output "subnet_A_id" {
    value = aws_subnet.AprilDevOpsPubnetA.id
}


output "subnet_B_id" {
    value = aws_subnet.AprilDevOpsPubnetB.id
}
