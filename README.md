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
A17a | Res50 | 20% |  | 1.704757 | 2.0534 | 2.0630 | 0.505 | 5x4 + 2x4 epochs
A17b | Res50 | 5% |  | 1.557469 | 1.7175 | 1.7443 | 0.608 | 5x4 + 2x4 epochs
A17c | Res50 | 4% | 1 | 1.508805 | 1.5011 | 1.5479 | 0.644 | 5x4 + 2x4 epochs
A17d | Dense201 | 4% |  |  | 1.6602 | 1.6641 |  | 40/3/3 + 4/4 epochs
A17e | Dense201 | 5% |  |  | 1.6966 | 1.6734 |  | 40/3/3 + 4/4 epochs
A17f | Dense201 | 20% | 1 |  | 1.4364 | 1.4142 |  | 40/3/3 + 4/4 epochs
A17g | Dense201 | 20% |  |  | 1.8094 | 1.8955 |  | 40/3/3 + 4/4 / 224 sz
A17h | Dense201 | 20% |   |  | 1.7007 | 1.6625 |  | 40/3/3 + 4/4 / 224
A17i | Dense201 | 15% |   | 1.436444 | 1.6371 | 1.5662 | 0.658 | 40/3/3 + 4/4 / 224
A17j | Dense201 | 10% |   | 1.623672 | 1.8975 | 1.8367 | 0.682 | 40/3/3 + 4/4 / 224
A17k | Dense201 | 10% | 1 | 1.516132 | 1.5614 | 1.5571 | 0.642 | 40/3/3 + 4/4 / 224
A18a | Dense201 | 10% | 1 | 1.428791 | 1.4793 | 1.5615 | 0.665 | 40/3/3 + 4/4 / 224
A18b | Dense201 | 10% | 1 | 1.551246 | 1.4845 | 1.5356 | 0.636 | 20 + 6/4 / 224
A18c | Dense201 | 15% |   | 1.360785 | 1.6585 | 1.5945 | 0.681 | 30 

