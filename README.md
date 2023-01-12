# Conference Organization
Minizinc script for a conference organization.

## Model
The src folder contains the Minizinc model for this project.

## Dataset
Under datasets folder there are dataset files. You can customize or create a new one in order to create your personal dataset.
A dataset template is something like this:
```
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
```
The matrix pxs has dimensions ```NPEOPLE * NSESSIONS``` and is ```true``` when the person i want to sees the session j.

## How to run
First of all, please install [Minizinc](https://www.minizinc.org/) on your machine.

Then clone this repo and run
```
minizinc --solver Gecode src/conference_organization.mzn datasets/dataset2.dzn
```
Otherwise you can open the model and the dataset in the Minizinc IDE and then run attaching the dataset.
