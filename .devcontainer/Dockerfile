# ===----------------------------------------------------------------------=== #
# Copyright (c) 2023, Modular Inc. All rights reserved.
#
# Licensed under the Apache License v2.0 with LLVM Exceptions:
# https://llvm.org/LICENSE.txt
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# The Dockerfile is provided as reference. Please review the redistribution
# terms of the Mojo license in Section 1 (https://www.modular.com/legal/mojo)
# prior to distributing pre-built container images.
# ===----------------------------------------------------------------------=== #

# Example command line:
# Use no-cache to force docker to rebuild layers of the image by downloading the SDK from the repos
# ./build-image.sh --auth-key <your-modular-auth-key>
#

FROM ubuntu:22.04

ARG DEFAULT_TZ=America/Los_Angeles
ENV DEFAULT_TZ=$DEFAULT_TZ

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive TZ=$DEFAULT_TZ apt-get install -y \
	tzdata \
	vim \
	nano \
	sudo \
	curl \
	wget \
    python3-pip \
	git && \
	rm -rf /var/lib/apt/lists/*


# Download the latest version of minicoda py3.8 for linux x86/x64.
# RUN curl -fsSL https://repo.anaconda.com/miniconda/$( wget -O - https://repo.anaconda.com/miniconda/ 2>/dev/null | grep -o 'Miniconda3-py38_[^"]*-Linux-x86_64.sh' | head -n 1) > /tmp/miniconda.sh \
# 	&& chmod +x /tmp/miniconda.sh \
# 	&& /tmp/miniconda.sh -b -p /opt/conda

# RUN mkdir -p ~/miniconda3 \
# 	&& wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh \
# 	&& bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 \
# 	&& rm -rf ~/miniconda3/miniconda.sh

# ENV PATH=~/miniconda3/bin/conda:$PATH
# RUN conda init

RUN pip install \
    pytest \
    git+https://github.com/guidorice/mojo-pytest.git

# RUN pip install \
# 	jupyterlab \
# 	ipykernel \
# 	matplotlib \
# 	ipywidgets

RUN curl -ssL https://magic.modular.com | bash
# RUN curl https://get.modular.com | sh -
# # RUN modular auth examples && modular install nightly/mojo
# RUN modular auth examples && modular install mojo

# ARG MODULAR_HOME="/root/.modular"
# ENV MODULAR_HOME=$MODULAR_HOME
# # ENV PATH="$PATH:$MODULAR_HOME/pkg/packages.modular.com_nightly_mojo/bin"
# ENV PATH="$PATH:$MODULAR_HOME/pkg/packages.modular.com_mojo/bin"

# Change permissions to allow for Apptainer/Singularity containers
RUN chmod -R a+rwX /root

# CMD ["jupyter", "lab", "--ip='*'", "--NotebookApp.token=''", "--NotebookApp.password=''","--allow-root"]