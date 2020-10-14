python -m object-locator.train \
       --train-dir /home/server/Datasets/Mall/training_set \
       --val-dir /home/server/Datasets/Mall/validation_set \
       --batch-size 32 \
       --lr 1e-4 \
       --optim Adam \
       --save saved_model.ckpt