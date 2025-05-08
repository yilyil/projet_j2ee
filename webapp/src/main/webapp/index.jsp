<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Informations DevOps</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }
        
        .container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 80%;
            max-width: 600px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 10px;
            background: linear-gradient(90deg, #ff8a00, #e52e71, #1e90ff);
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 30px;
            font-weight: 600;
            position: relative;
        }
        
        h1::after {
            content: "";
            display: block;
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, #ff8a00, #e52e71);
            margin: 10px auto;
            border-radius: 3px;
        }
        
        .info-item {
            background: rgba(255, 255, 255, 0.8);
            margin: 15px 0;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            text-align: left;
            border-left: 4px solid #1e90ff;
        }
        
        .info-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }
        
        .label {
            font-weight: 600;
            color: #e52e71;
            display: block;
            margin-bottom: 5px;
        }
        
        .value {
            color: #2c3e50;
            font-size: 1.1em;
        }
        
        .classes {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .class-chip {
            background: #1e90ff;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .footer {
            margin-top: 30px;
            font-size: 0.9em;
            color: #7f8c8d;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Informations Académiques</h1>
        
        <div class="info-item">
            <span class="label">École d'ingénieur</span>
            <span class="value">Efrei Paris</span>
        </div>
        
        <div class="info-item">
            <span class="label">Classes</span>
            <div class="classes">
                <span class="class-chip">RS1</span>
                <span class="class-chip">RS2</span>
                <span class="class-chip">RS3</span>
            </div>
        </div>
        
        <div class="info-item">
            <span class="label">Année universitaire</span>
            <span class="value">2024/2025</span>
        </div>
        
        <div class="info-item">
            <span class="label">Matière</span>
            <span class="value">DevOps</span>
        </div>
        
        <div class="info-item">
            <span class="label">Enseignant</span>
            <span class="value">Abdelbaki BOUZAYEN</span>
        </div>
        
        <div class="footer">
            Page générée le <%= new java.util.Date() %>
        </div>
    </div>
</body>
</html>
