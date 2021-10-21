#!/bin/bash
#Submit to GPU


MODEL_PATH=../model_zoo/baseline
SAVE_PATH=/local_workspace/caccmatt/HingeSPR/logs/hinge_test/new/
DATA_PATH=/local_workspace/caccmatt/Cifar100_code/data


######################################
# ResNet56, CIFAR100, ratio = 0.5, svd2
######################################
MODEL=Hinge_ResNet_Basic_SVD
RATIO=0.5
LR=0.1
LR_RATIO=0.01
LR_FACTOR=1
REGULARIZER=l1d2
REG_FACTOR=4e-4
ANNEAL=2
INIT_METHOD=svd2
THRESHOLD=5e-3
STOP_LIMIT=0.1
EPOCH=300
STEP=hingestep-150-225
CHECKPOINT=${MODEL}_CIFAR10_L56_LR${LR}r${LR_RATIO}f${LR_FACTOR}_${INIT_METHOD}_R${REG_FACTOR}_T${THRESHOLD}_S${STOP_LIMIT}_A${ANNEAL}_E${EPOCH}_${REGULARIZER}_Ratio${RATIO}_Same_Balance_Dis
echo $CHECKPOINT
CUDA_VISIBLE_DEVICES=3 python ../main_hinge.py --save $CHECKPOINT --template ResNet --model ${MODEL} --depth 56 --batch_size 64 --downsample_type A \
--epochs ${EPOCH} --decay ${STEP} --lr ${LR} --lr_ratio ${LR_RATIO} --lr_factor ${LR_FACTOR} --optimizer PG --ratio ${RATIO} \
--sparsity_regularizer ${REGULARIZER} --regularization_factor ${REG_FACTOR} --init_method ${INIT_METHOD} --threshold ${THRESHOLD} --annealing_factor ${ANNEAL} \
--stop_limit ${STOP_LIMIT} --p1_p2_same_ratio --layer_balancing --distillation \
--teacher ${MODEL_PATH}/resnet56_b128e164.pt \
--pretrain ${MODEL_PATH}/resnet56_b128e164.pt \
--dir_save ${SAVE_PATH} \
--dir_data ${DATA_PATH}



