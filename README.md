# GPU Batch Grayscale Image Conversion with CUDA

This project performs GPU-accelerated grayscale conversion on a collection of TIFF images using CUDA.

## Project Description

The program processes a batch of aerial TIFF images and converts each RGB image to an 8-bit grayscale image.

Image loading and saving are handled on the CPU using libtiff, while the actual pixel conversion is performed on an NVIDIA GPU using a custom CUDA kernel.

The CUDA kernel assigns GPU threads to image pixels and computes the grayscale value using:

`0.30 * R + 0.59 * G + 0.11 * B`

## Dataset

The project uses 38 aerial TIFF images from the USC-SIPI Image Database.

The dataset contains tens of large images and therefore satisfies the assignment requirement for processing a large amount of image data.

Input images are stored in:

`images/`

GPU-generated grayscale images are stored in:

`gray_out/`

## GPU Computation

GPU computation is implemented in `convert_batch.cu`.

The program:

1. Loads each TIFF image into host memory.
2. Allocates CUDA device memory using `cudaMalloc`.
3. Copies the image from host memory to GPU memory using `cudaMemcpy`.
4. Launches the `rgb2grayKernel` CUDA kernel.
5. Processes image pixels in parallel on the GPU.
6. Copies the grayscale result back to host memory.
7. Writes the resulting grayscale TIFF image to disk.

The CUDA kernel is launched using CUDA grid and block execution:

`rgb2grayKernel<<<blocks, threadsPerBlock>>>(...)`

This project therefore performs the main image-processing operation using GPU computation rather than CPU-only processing.

## Requirements

- NVIDIA CUDA-capable GPU
- CUDA Toolkit / `nvcc`
- C++17
- libtiff
- make

On Ubuntu:

```bash
sudo apt-get install libtiff-dev
```

## Build

```bash
make clean
make
```

## Run

```bash
mkdir -p gray_out
./convert_batch images gray_out -t 512
```

To save execution output:

```bash
mkdir -p proof
./convert_batch images gray_out -t 512 | tee proof/execution.log
```

## Results

The CUDA program successfully processed all 38 TIFF input images and generated 38 grayscale TIFF output images.

Execution was performed using an NVIDIA GPU in Google Colab.

Proof of execution is included in:

- `proof/execution.log`
- `proof/execution.png`

Example generated images can be found in the `gray_out/` directory.

## Source Code

- `convert_batch.cu` — CUDA implementation and batch image-processing logic
- `convert_batch.hpp` — declarations
- `Makefile` — CUDA build configuration

## Dataset Source

USC-SIPI Image Database — Aerials image collection.
