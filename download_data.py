import pandas as pd
import requests
from os import path, mkdir

train_url = "https://cogcomp.seas.upenn.edu/Data/QA/QC/train_5500.label"
test_url = "https://cogcomp.seas.upenn.edu/Data/QA/QC/TREC_10.label"


def download_and_load_data(url):
    """
    Download the dataset for the given url, and return it as a pandas DataFrame.
    """
    data = requests.get(url).text
    data = [line for line in data.split('\n') if line]
    labels, questions = zip(*[line.split(' ', 1) for line in data])
    coarse_labels = [label.split(':')[0] for label in labels] 
    df = pd.DataFrame({"question": questions, "label": labels, "coarse_label": coarse_labels})
    return df

def main():
    data_dir_name = 'data'
    try:
        mkdir(data_dir_name)
        print("Directory '{}' created".format(data_dir_name))
    except FileExistsError:
        print("Directory '{}' already exists".format(data_dir_name))

    train_df = download_and_load_data(train_url)
    train_df.to_csv(path.join(data_dir_name, "train.csv"), index=False)
    test_df = download_and_load_data(test_url)
    test_df.to_csv(path.join(data_dir_name, "test.csv"), index=False)


if __name__ == '__main__':
    main()
