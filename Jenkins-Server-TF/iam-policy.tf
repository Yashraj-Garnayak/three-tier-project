resource "aws_iam_role_policy_attachment" "iam-policy" {
  role = aws_iam_role.iam-role.name
  # Least privilege: the Jenkins pipelines only need to log in to ECR and push images.
  # Creating the EKS cluster (eksctl) needs broader rights: run that from a separate
  # admin identity, not from this instance role.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}