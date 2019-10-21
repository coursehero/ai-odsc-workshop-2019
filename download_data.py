"""
Utility Function for downloading/reading and formatting workshop data.
"""
import pandas as pd
import requests
from os import path, mkdir

train_url = "https://cogcomp.seas.upenn.edu/Data/QA/QC/train_5500.label"
test_url = "https://cogcomp.seas.upenn.edu/Data/QA/QC/TREC_10.label"


def format_trec_data(text):
    """
    Convert the whitespace-delimited text format of TREC data to a Pandas
    DataFrame, with the labels processed into fine- and coarse-grained
    alternatives.

    Parameters
    ----------
    text: str
        The full text of the TREC data. Each line consists of the fine-grained
        label (eg "NUM:date") followed by a space and the question text.

    Returns
    -------
    pd.DataFrame
        Pandas DataFrame with three columns: 'question', 'label', and
        'coarse_label'.

    """
    data = [line for line in text.split('\n') if line]
    labels, questions = zip(*[line.split(' ', 1) for line in data])
    coarse_labels = [label.split(':')[0] for label in labels]
    df = pd.DataFrame({"question": questions,
                       "label": labels,
                       "coarse_label": coarse_labels})
    return df


def main(path_to_train=None, path_to_test=None):
    """
    This function obtains the TREC question classifier data, formats it, and
    writes it as a .csv file with three columns:
        'question',
        'label' (aka fine-grained label), and
        'coarse_label' (aka coarse-grained label)

    If filepaths are provided, text will be read from there. Otherwise it uses
    the urls to download the original data.

    Parameters
    ----------
    path_to_train: str or None
        If the data has already been downloaded, this is the path to the
        train file. If None, the data is downloaded.

    path_to_test: str of None.
        If the data has already been downloaded, this is the path to the
        test file. If None, the data is downloaded.

    Returns
    -------
    tuple (pd.DataFrame, pd.DataFrame)
        This function writes the formatted data to .csv files, and then returns
        it as a tuple of pandas DataFrames (train, test).
    """
    data_dir_name = 'data'
    try:
        mkdir(data_dir_name)
        print("Directory '{}' created".format(data_dir_name))
    except FileExistsError:
        print("Directory '{}' already exists".format(data_dir_name))
    if path_to_train is not None:
        with open(path_to_train) as train_f:
            train_df = format_trec_data(train_f.read())
    else:
        data = requests.get(train_url).text
        train_df = format_trec_data(data)

    if path_to_test is not None:
        with open(path_to_test) as test_f:
            test_df = format_trec_data(test_f.read())
    else:
        data = requests.get(test_url).text
        test_df = format_trec_data(data)

    train_df.to_csv(path.join(data_dir_name, "train.csv"), index=False)
    test_df.to_csv(path.join(data_dir_name, "test.csv"), index=False)

    return train_df, test_df


if __name__ == '__main__':
    _, _ = main()
