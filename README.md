# Report:
**DESCRIPTION**
In our application:
User Registration & Authentication:
Users must create an account before accessing the quizzes.
Registration Firebase Authentication will be used
Then,
Quiz Dashboard:
After logging in, users will be presented with a dashboard showing a list of available quizzes.
Then,
Quiz Gameplay:
Each quiz comprises multiple flashcards, with each flashcard showing a question and multiple-choice answers. The questions and options will be fetched in real-time from the Firebase Cloud store.
Then lastly,
Result & Analysis:
Once the user completes the quiz, their answers are submitted and compared with the correct answers stored in the database. The user is then presented with their score.
<br>**Data Storage**
<br>Firebase cloud Storage is used due to it is  online quiz
<br>**Issues and Bugs Encountered and Resolved during Development**
<br>Severe bugs were encounterd during Development some are,
<br>First bug was encountring that data were not be fatched from DataBase due to Rule there i choiced standard which make it false to write or read data so have to modify it.
<br>Another bug was that after one login when we close application after again opening we have to login again it was tackled by using firebase active conncetion function to check if still conncection go directly to dashboard
<br>Another was after login or signup we have to wait due to verification there user still can use application which may cause error so we have used circular progress indicator
<br>Another was data took some time to be fetched so it show red null exception for some seconds so there again we use circular progress indicator.

<br>**Responsive Screens**
![WhatsApp Image 2023-10-06 at 23 20 35_14a351e1](https://github.com/zami-dot/MAD/assets/80031450/43170cca-149e-4618-b8d5-bb81270ecd16)

![WhatsApp Image 2023-10-06 at 23 20 35_59d347a0](https://github.com/zami-dot/MAD/assets/80031450/dfb5e10c-4842-41d1-9738-ace9220c3efe)

![WhatsApp Image 2023-10-08 at 00 46 46_bfdab344](https://github.com/zami-dot/MAD/assets/80031450/8dd63e1b-75cf-4a66-b4fa-4717fbb7934a)


![WhatsApp Image 2023-10-08 at 00 46 47_39d07e34](https://github.com/zami-dot/MAD/assets/80031450/d998f31d-af1d-44e9-94a0-be6444138aff)


![WhatsApp Image 2023-10-08 at 00 46 46_c638fbb0](https://github.com/zami-dot/MAD/assets/80031450/fa10c920-25b2-4f7d-ad99-3868fa8f0301)

