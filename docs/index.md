# Project Hermes

Welcome to the homepage & documentation website for **Project Hermes**.

## What Is It?

!!! question "TL;DR"

    An open-source service, website, and mobile app that simplifies checking in on friends and/or family based on a User-provided interval/schedule.

More specifically, it's a project that consists of 3 major components:

- API
- Mobile App
- Website

### API

The API is what handles the heavy lifting of the project. It has endpoints for checkins, friends, and users.

For example, when a User provided schedule is triggered then it will hit this API, specifically the `/checkins` route triggering the following actions:

1. Hermes will first start by creating a new object in the `checkins` Collection with the following properties:
   - `_id` — The unique identifier of the Check In, in the form of an `ObjectID`.
   - `userId` — The unique identifier of the User who initiated the Check In, in the form of an `ObjectID`.
   - `friendId` — The unique identifier of the Friend who's being checked on, in the form of an `ObjectID`.
   - `success` — Whether or not the Check In was successful and a message was sent to the Friend.
     - Defaults to `false`.
   - `createdDate` — The date-time of when the Check In was started.
     - Defaults to the current date-time of when the Check-In started.
2. Hermes will then send a request to the OpenAI API and request it to generate a message based on the `messagePrompt` property of the specified Friend.
3. The generated message is then sent back to the User for approval.
   1. If the User approves of the message then it's sent to the Friend.
   2. If the User does _not_ approve of the message then Hermes will generate a new message and request approval up to `messageAttempts` property of the specified Friend, which defaults to `3`, amount of times.
4. Once the message has successfully been sent Hermes will update the `CheckIn` object from step 1 with the following new properties/values:
   - `success` — Will be set to true.
   - `lastModifiedDate` — The date-time of when the Check In was completed.
     - Defaults to the current date-time of when the Check-In started.

### Mobile App

### Website

