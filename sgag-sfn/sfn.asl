{
    "Comment": "Applying the Saga pattern with AWS Lambda and Step Functions",
    "StartAt": "BookHotel",
    "States": {
        "BookHotel": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:us-east-1:{AccountID}:function:lambda-saga-dev-book-hotel",
            "Catch": [
                {
                    "ErrorEquals": [
                        "States.ALL"
                    ],
                    "ResultPath": "$.BookHotelError",
                    "Next": "CancelHotel"
                }
            ],
            "ResultPath": "$.BookHotelResult",
            "Next": "BookFlight"
        },
        "BookFlight": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:us-east-1:{AccountID}:function:lambda-saga-dev-book-flight",
            "Catch": [
                {
                    "ErrorEquals": [
                        "States.ALL"
                    ],
                    "ResultPath": "$.BookFlightError",
                    "Next": "CancelFlight"
                }
            ],
            "ResultPath": "$.BookFlightResult",
            "Next": "BookRental"
        },
        "BookRental": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:us-east-1:{AccountID}:function:lambda-saga-dev-book-rental",
            "Catch": [
                {
                    "ErrorEquals": [
                        "States.ALL"
                    ],
                    "ResultPath": "$.BookRentalError",
                    "Next": "CancelRental"
                }
            ],
            "ResultPath": "$.BookRentalResult",
            "End": true
        },
        "CancelHotel": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:us-east-1:{AccountID}:function:lambda-saga-dev-cancel-hotel",
            "Catch": [
                {
                    "ErrorEquals": [
                        "States.ALL"
                    ],
                    "ResultPath": "$.CancelHotelError",
                    "Next": "CancelHotel"
                }
            ],
            "ResultPath": "$.CancelHotelResult",
            "Next": "Fail"
        },
        "CancelFlight": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:us-east-1:{AccountID}:function:lambda-saga-dev-cancel-flight",
            "Catch": [
                {
                    "ErrorEquals": [
                        "States.ALL"
                    ],
                    "ResultPath": "$.CancelFlightError",
                    "Next": "CancelFlight"
                }
            ],
            "ResultPath": "$.CancelFlightResult",
            "Next": "CancelHotel"
        },
        "CancelRental": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:us-east-1:{AccountID}:function:lambda-saga-dev-cancel-rental",
            "Catch": [
                {
                    "ErrorEquals": [
                        "States.ALL"
                    ],
                    "ResultPath": "$.CancelRentalError",
                    "Next": "CancelRental"
                }
            ],
            "ResultPath": "$.CancelRentalResult",
            "Next": "CancelFlight"
        },
        "Fail": {
            "Type": "Fail"
        }
    }
}