# Conference Organization
Minizinc script for a conference organization.

## Model
The file under src folder is Mnizinc model for this project.

## Dataset
The file under datasets folder are the dataset. You can customize or create a new file in order to obtain your personal dataset.
A dataset template is like this:
'''
NSESSIONS = 4;
NROOMS = 3;
NDAYS = 2;
NPEOPLE = 4;
CAPACITY = 4;
MAX_SESSIONS_PER_PERSON = 3;

% PxS initializazion
pxs = [|true,true,false,false,
       |false,true,false,true,
       |false,true,true,false,
       |false,false,true,true|];
'''
The matrix pxs has dimensions '''NPEOPLE * NSESSIONS''' and is '''true''' when the person i want to see the session j.

## How to run
First, install [minizinc](https://www.minizinc.org/) on your machine.

Clone this repo and then run
'''
minizinc --solver Gecode src/conference_organization.mzn datasets/dataset2.dzn
'''
