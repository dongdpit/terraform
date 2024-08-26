resource "null_resource" "ansible-run" { 
  provisioner "local-exec" {  
    command = "ansible-playbook -i /root/ansible/inventory.yaml /root/ansible/playbook.yaml" 
  } 
} 
