echo "⚙️  Creación de máquina virtual en VirtualBox"

# Solicitar datos al usuario
read -p "Nombre de la máquina virtual: " VM_NAME
read -p "Número de CPUs: " CPUS
read -p "Tamaño de RAM (en MB): " RAM
read -p "Tamaño de VRAM (en MB): " VRAM
read -p "Tamaño del disco duro (en GB): " DISK_SIZE_GB
read -p "Nombre simbólico para el controlador SATA: " SATA_CTRL
read -p "Nombre simbólico para el controlador IDE: " IDE_CTRL

# Crear la VM
VBoxManage createvm --name "$VM_NAME" --ostype "Linux" --register

# Establecer CPUs y RAM
VBoxManage modifyvm "$VM_NAME" --cpus $CPUS --memory $RAM --vram $VRAM

# Crear el disco duro virtual
DISK_PATH="$HOME/VirtualBox VMs/$VM_NAME/${VM_NAME}.vdi"
VBoxManage createmedium disk --filename "$DISK_PATH" --size $(($DISK_SIZE_GB * 1024)) --format VDI

# Crear y asociar el controlador SATA
VBoxManage storagectl "$VM_NAME" --name "$SATA_CTRL" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "$SATA_CTRL" --port 0 --device 0 --type hdd --medium "$DISK_PATH"

# Crear y asociar el controlador IDE (para CD/DVD)
VBoxManage storagectl "$VM_NAME" --name "$IDE_CTRL" --add ide
VBoxManage storageattach "$VM_NAME" --storagectl "$IDE_CTRL" --port 0 --device 0 --type dvddrive --medium emptydrive

# Mostrar resumen
echo -e "\n✅ Máquina virtual creada con éxito:"
echo "  - Nombre: $VM_NAME"
echo "  - CPUs: $CPUS"
echo "  - RAM: ${RAM} MB"
echo "  - VRAM: ${VRAM} MB"
echo "  - Disco duro: ${DISK_SIZE_GB} GB"
echo "  - Controlador SATA: $SATA_CTRL"
echo "  - Controlador IDE: $IDE_CTRL"
echo "  - Ruta del disco: $DISK_PATH"
