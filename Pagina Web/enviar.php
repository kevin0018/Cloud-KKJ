<?php

/****************************************************************
Recibe los datos ingresados
 ****************************************************************/
$nombre = $_POST['nombre'];
$email = $_POST['email'];
$asunto = $_POST['asunto'];
$comentario = $_POST['mensaje'];

if (empty($nombre) || empty($email) || empty($asunto) || empty($comentario)) {

    $error = true;
}


/****************************************************************
Aquí debes ingresar el asunto del mail
 ****************************************************************/
$subject = 'Contacto desde internet de ' . $nombre;
$comentario = stripcslashes($comentario);



/****************************************************************
Aquí se genera el cuerpo del mensaje
 ****************************************************************/
$mensaje = "De: $nombre \n
E-mail: $email \n
Asunto: $asunto \n
Mensaje: $comentario \n
\n";

$from = "From: $email\r\n";





if (!$error) {
    mail("cloudkkj.info@gmail.com", $subject, $mensaje, $from);
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contacto</title>

    <link rel="stylesheet" href="header.css">
    <link rel="stylesheet" href="Footer.css">
    <link rel="stylesheet" href="acerca.css">
    <link rel="shortcut icon" href="favicon.png">

</head>

<body>

    <div class="header"></div>
    <input type="checkbox" class="openSidebarMenu" id="openSidebarMenu">
    <label for="openSidebarMenu" class="sidebarIconToggle">
        <div class="spinner diagonal part-1"></div>
        <div class="spinner horizontal"></div>
        <div class="spinner diagonal part-2"></div>
    </label>
    <div id="sidebarMenu">
        <ul class="sidebarMenuInner">
            <li><a href="Index.html">Inicio</a></li>
            <li><a href="Productos.html">Planes y precios</a></li>
            <li><a href="Acerca.HTML">Acerca</a></li>
            <li><a href="Contacto.html">Contacto</a></li>
        </ul>
    </div>

    <div class="main">
        <div class="mainInner">
            <section>

                <div class="formulario">

                    <?php if ($error) { ?>

                        <div class="alerta">
                            Hubo un error, por favor completa todos los campos.
                        </div>

                        <form action="enviar.php" method="post">

                            <label for="nombre">Nombre:</label>
                            <input type="text" id="nombre" name="nombre" placeholder="¿Cómo te llamas?" required />

                            <label for="email">Email:</label>
                            <input type="text" id="email" name="email" placeholder="¿A dónde debería responderte?" required />

                            <label for="asunto">Asunto:</label>
                            <input type="text" id="asunto" name="asunto" placeholder="¿Sobre qué quieres conversar?" required />

                            <label for="mensaje">Mensaje:</label>
                            <textarea id="mensaje" name="mensaje" rows="8" placeholder="Deja aquí tu comentario..." required></textarea>

                            <input type="submit" value="Enviar mensaje" class="btn" />

                        </form>


                    <?php } else { ?>

                        <p>Gracias por contactarte con nosotros, responderemos lo más pronto posible :)</p>

                    <?php } ?>

                </div>
        </div>


        <footer class="footer">
            <div class="l-footer">
                <img src="fotologo.png" alt="logo">
            </div>
            <ul class="r-footer">
                <li>
                    <h2 class="footer-h2">Productos</h2>

                    <ul class="box">
                        <li><a href="#" class="a-box">Precios</a></li>
                        <li><a href="#" class="a-box">Planes</a></li>
                    </ul>
                </li>

                <li class="features">
                    <h2 class="footer-h2">Acerca</h2>

                    <ul class="box">
                        <li><a href="#" class="a-box">Más sobre CloudKKJ</a></li>
                    </ul>
                </li>

                <li>
                    <h2 class="footer-h2">Contacto</h2>

                    <ul class="box">
                        <li><a href="#" class="a-box">Email</a></li>
                    </ul>
                </li>
            </ul>

            <div class="b-footer">
                <p class="p-footer">All rights reserved by &copy;CloudKKJ 2020</p>
            </div>
        </footer>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="header.js"></script>

</body>

</html>