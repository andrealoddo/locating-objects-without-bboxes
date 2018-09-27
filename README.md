# Object locator

## Table of Contents
1. [Using Conda (recommended)](#conda)
    1. [Installation](#installation)
    2. [Usage](#usage)
        1. [Test/evaluate](#test)
        2. [Train](#train)
    3. [Uninstall](#uninstall)
2. [Using Docker](#docker)


## Using Conda (recommended) <a name="conda"></a>
<a name="installation"></a>
### Installation 

<ol>
<li>Download and install Anaconda as described in <a href="https://docs.anaconda.com/anaconda/install/">https://docs.anaconda.com/anaconda/install</a></li>
<li>Get the code from this git repository (or download the tool from <a href="https://github.rcac.purdue.edu/jprat/object-locator/archive/v1.3.1.zip">this link</a>, and decompress the zip).
<li>(Optional) Check out a non-development version (such as `git checkout v1.3.1`).
<li>Open the terminal in Linux/MacOS. In Windows, open the Anaconda Prompt.</li>
<li>"cd" into the decompressed directory</li>
<li>Download the trained models from <a href="https://lorenz.ecn.purdue.edu/~jprat/plant_locator/checkpoints">here</a> and put them in 
<pre>object-locator-1.3.1/object-locator/checkpoints</pre>


<li>Install the dependencies:</li>
<pre>
conda env create
</pre>

<li>Activate the environment:</li>

<ul>
<li>In Linux/MacOS:</li>
<pre>
source activate object-locator
</pre>
<li>In Windows:</li>
<pre>
activate object-locator
</pre>
</ul>
   

<li>Install the tool:</li>
<pre>
pip install .
</pre>

<li>
Download some example data from <a href="https://lorenz.ecn.purdue.edu/~jprat/plant_locator/sorghum_data.zip">here</a> and decompress it wherever you want.
</li>


<a name="usage"></a>
### Usage  


Activate the environment:

<ul>
<li>In Linux/MacOS:</li>
<pre>
source activate object-locator
</pre>
<li>In Windows:</li>
<pre>
activate object-locator
</pre>
</ul>

<a name="test"></a>
#### Test/evaluate
To use a pre-trained model/checkpoint.

Run this to get help (usage instructions):
<pre>
python -m object-locator.locate -h
</pre>

Example:

<pre>
python -m object-locator.locate \
       --dataset DIRECTORY \
       --out DIRECTORY \
       --model CHECKPOINTS \
       --evaluate \
       --no-gpu \
       --radius 5
</pre>



<a name="train"></a>

#### Train (optional)
If you do not want to use one of the provided pretrained models, you can train your own model. Run the following command to get the full help message on how to train, with an explanation of all available training parameters.
You need to have a NVIDIA card and CUDA 8 installed to train your own model. This depends greatly on the specific model of your NVIDIA card and operating system.

Run this to get help (usage instructions):
<pre>
python -m object-locator.train -h
</pre>

Example:

<pre>
python -m object-locator.train \
       --train-dir ~/data/20160613_F54_training_256x256 \
       --batch-size 32 \
       --env-name sorghum \
       --lr 1e-3 \
       --val-dir ~/data/plant_counts_random_patches/20160613_F54_validation_256x256 \
       --optim Adam \
       --save unet_model.ckpt
</pre>


### Uninstall <a name="uninstall"></a>

<ul>
<li>In Linux/MacOS:</li>
<pre>
source deactivate object-locator
</pre>
<li>In Windows:</li>
<pre>
deactivate object-locator
</pre>
</ul>

<pre>
conda env remove --name object-locator
</pre>

<a name="docker"></a>
## Using Docker 


(only for expert users)

1. Install docker-ce as described in https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository
2. Install NVIDIA drivers
3. Run the following commands
<pre><code>
docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
sudo apt-get purge -y nvidia-docker
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
</code></pre>
You can get more details at https://github.com/NVIDIA/nvidia-docker

