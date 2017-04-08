# Docker for Jupyter and Pandas

This is docker image for Python3, Jupyter and Pandas, based on alpine linux


### Run

You can run the command below:

```bash
docker run -d --name jupyter -p 8888:8888 -v YOU_VOL_FOLDER:/opt playniuniu/jupyter-pandas
```

and visit [http://localhost:8888](http://localhost:8888) for jupyter notebook

### Plot

You can use the command in jupyter to plot images

```python
%matplot notebook
import matplotlib.pyplot as plt
plt.plot([1,2,3])
```

and you can see the imags below:
![screenshot](screenshot.png)
