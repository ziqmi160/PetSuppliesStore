<!DOCTYPE html>
<html>
<head>
    <title>CSS Test</title>
    <style>
        .test { color: red; font-size: 24px; }
        
        .card {
            background-color: yellow !important;
            border: 3px solid blue !important;
            padding: 15px !important;
            margin: 10px !important;
            border-radius: 8px !important;
            width: 300px;
        }

        .card-body {
            background-color: lightgreen !important;
            padding: 10px !important;
        }

        .card-title {
            color: red !important;
            font-size: 20px !important;
        }

        .btn {
            background-color: purple !important;
            color: white !important;
            padding: 8px 16px !important;
            border: none !important;
            border-radius: 4px !important;
            text-decoration: none;
            display: inline-block;
        }
    </style>
</head>
<body>
    <h1 class="test">This should be red if inline CSS works</h1>
    <div class="card">
        <div class="card-body">
            <h3 class="card-title">This should have styling now</h3>
            <p class="card-text">This card should have a blue border and yellow background.</p>
            <a href="#" class="btn">Button should be purple</a>
        </div>
    </div>
</body>
</html>