FROM pytorch/pytorch:1.5.1-cuda10.1-cudnn7-runtime

WORKDIR /workspace
COPY . /workspace

# 프로젝트 의존성만 설치 (torch/torchvision은 이미 이미지에 포함되어 있으니 설치 금지)
RUN python -m pip install --upgrade pip "setuptools<70" "wheel<0.41"
RUN python -m pip install -r requirements.txt --no-deps || true
RUN python -m pip install "scipy<1.11" pillow tensorboard tqdm

# 설치 확인(빌드 타임 체크)
RUN python - <<'PY'
import torch, torchvision
print("torch:", torch.__version__)
print("torchvision:", torchvision.__version__)
print("CUDA available:", torch.cuda.is_available())
PY

CMD ["bash"]