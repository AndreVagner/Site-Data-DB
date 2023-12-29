import pathlib
import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow.keras.utils import image_dataset_from_directory
from tensorflow.keras import layers, models
from sklearn.metrics import confusion_matrix
import seaborn as sns
from tensorflow.keras.models import load_model

#dataset je ke stažení zde: https://www.kaggle.com/datasets/a2015003713/militaryaircraftdetectiondataset

directory = "./data/crop/"
path_for_data = pathlib.Path(directory)

train_df = image_dataset_from_directory(path_for_data,
                                        image_size=(128, 128),
                                        validation_split=0.3,
                                        subset="training",
                                        shuffle=True,
                                        batch_size=25,
                                        seed=123)

validation_df = image_dataset_from_directory(path_for_data,
                                             image_size=(128, 128),
                                             validation_split=0.35,
                                             subset="validation",
                                             shuffle=True,
                                             batch_size=25,
                                             seed=123)

print("There is {} images in the training dataset".format(len(train_df)))
print("There is {} images in the validation dataset".format(len(validation_df)))

validation_batches = tf.data.experimental.cardinality(validation_df)
# take validation batches for the test set
test_df = validation_df.take(validation_batches // 5)
# skip validation batches for the validation set
validation_df = validation_df.skip(validation_batches // 5)

class_names = train_df.class_names

# Load the model
model = load_model('C:/Users/vagne/OneDrive/Desktop/skola/site/model.h5')

# Extract true labels from the test dataset
true_labels = np.concatenate([y for _, y in test_df])

# Make predictions on the test set
predictions = model.predict(test_df)
predicted_labels = np.argmax(predictions, axis=1)

# Assuming 'true_labels' and 'predicted_labels' are obtained as described before
cm = confusion_matrix(true_labels, predicted_labels)

# Create a heatmap
plt.figure(figsize=(10, 8))
sns.heatmap(cm, annot=True, fmt='d', cmap='viridis', xticklabels=class_names, yticklabels=class_names)
plt.xlabel('Predicted')
plt.ylabel('True')
plt.title('Confusion Matrix')
plt.show()


# Get the indices of incorrectly classified images
incorrect_indices = np.where(true_labels != predicted_labels)[0]

# Display up to 10 incorrectly classified images
num_display = min(10, len(incorrect_indices))

plt.figure(figsize=(15, 6))
displayed_count = 0
i = 0

while displayed_count < num_display and i < len(incorrect_indices):
    index = incorrect_indices[i]

    # Fetch the image and true label
    image, true_label = test_df.unbatch().skip(index).take(1).as_numpy_iterator().next()

    # Make a prediction
    predicted_label = model.predict(np.expand_dims(image, axis=0))
    predicted_class_index = np.argmax(predicted_label)

    # Convert indices to class names
    true_class_name = class_names[true_label]
    predicted_class_name = class_names[predicted_class_index]

    # If the true and predicted classes are different, display the image
    if true_class_name != predicted_class_name:
        plt.subplot(2, 5, displayed_count + 1)
        plt.imshow(image.astype("uint8"))
        plt.title(f'True: {true_class_name}, Predicted: {predicted_class_name}')
        plt.axis('off')
        displayed_count += 1

    i += 1

plt.show()
