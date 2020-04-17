# zindi-fowl-escapades
Zindi Fowl Escapades competition
https://zindi.africa/competitions/fowl-escapades

The final solution uses a chain of pre-processing, FastAI modeling, and blending of various runs.

Pre-processing is handled one time through this notebook:
repro-fowl-data-creation.ipynb

A series of similar models are then run.
For me personally, this was an opportunity to work on reproducibility.
Each notebook mentions it, but jupyter must be started in this way to reproduce the precise predictions:
`env PYTHONHASHSEED=42 jupyter notebook`
Everything else is taken care of within the notebook, and this was tested until back-to-back runs were identical.
Those two runs are shown here: `repro-fowl-A17a.ipynb` and `repro-fowl-A17a-v2.ipynb`
It might also be relevant that this was run on Ubuntu 16.04 with a TitanXP.

I've also added some R code I experimented with to try and subdivide the rather long bird calls into smaller segments.
These tactics appeared to show promise, yet I never completed the work and actually exported smaller cuts.
I did so within the python, but only with simple 5 second cuts, rather than detecting logical splits within the calls, as the R code was attempting and met with reasonable success (visually, at least). And the initial models I ran with those 5 second cuts were so bad, I never went back to try.
So what appears is a slightly deeper attempt at what Johnowhitaker started everybody off with:
https://zindi.africa/competitions/fowl-escapades/discussions/675
Thanks to him for getting this going. And I hope that since my scores have been worse than his all along, he has implemented some of his own suggestions that I did not get around to :-)

Model Table
NB | Model | Val | Wt | Final CV | Pub. LB | Priv LB | Acc | Notes
--- | --- | --- | --- | --- | ---- | --- | --- | ---
A17a | Res50 | 20% | ? | 1.704757 | 2.0534 | ? | 0.505 | 5x4 + 2x4 epochs
A17b | Res50 | 5% | ? | 1.557469 | 1.7175 | ? | 0.608 | 5x4 + 2x4 epochs
A17c | Res50 | 4% | ? | 1.508805 | 1.5011 | ? | 0.644 | 5x4 + 2x4 epochs
A17d | Dense201 | 4% | ? |  |  | ? |  | 40/3/3 + 4/4 epochs
