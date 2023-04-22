# drg-histology-segmentation
Contains scripts for working up immunofluorescence images from histology of dorsal root ganglion cells. Requires [cellpose2.0](https://github.com/mouseland/cellpose) for segmentation. 

Original images were saved in .vsi format with 3 channels, in the order of nuclear stain (blue), immunostaining (green) channel, fluorescence (virus expression, red) channel. The imageJ script can be used to extract each individual relevant .tif (at the highest resolution) and reorder them to be consistent with cellpose2.0 coloring schemes (RGB). (Only the red/virus channel is necessary for segmentation.)

Segmentation was performed on a GPU-enabled system with the command

```
py -m cellpose --dir "tif-image-directory" --chan 1 --pretrained_model CP --save_png --verbose --use_gpu --flow_threshold 0 --cellprob_threshold 0
```

The masks were cleaned up with "DRG histology segmentation.ipynb" via 3-level otsu thresholding. The 'DRG data analysis.ipynb' notebook can be used to further filter masks by properties such as area, solidity, etc and also for visualization. (Requires [statannot](https://github.com/webermarcolivier/statannot).)

It is theoretically possible to finetune the pretrained cellpose models to achieve better segmentation performance, but since the base CP model worked well enough with additional basic filtering, the time cost for manual annotation was not worth it.
