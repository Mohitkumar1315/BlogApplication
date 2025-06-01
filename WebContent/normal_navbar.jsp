<html>
<head>
    <title>Tech Blog</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="CSS/style.css" rel='stylesheet'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        /* Make the navbar fixed at the top */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000; /* Ensures it stays above other content */
        }

        /* Add some padding to the body to prevent content from overlapping with the navbar */
        body {
            padding-top: 56px; /* Same height as the navbar */
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="index.jsp">
        <span class="fa fa-american-sign-language-interpreting"></span> Tech Blog
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">
                    <span class="fa fa-home"></span> Home <span class="sr-only">(current)</span>
                </a>
            </li>

            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="fa fa-check-square-o"></span> Category
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="#">Programming Language</a>
                    <a class="dropdown-item" href="#">Project Implementation</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Data Structure</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <span class="fa fa-link"></span> More...
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="contact.jsp">
                    <span class="fa fa-address-book-o fa fa-address-card"></span> Contact
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="login_page.jsp">
                    <span class="fa fa-user-o"></span> Login
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="register_page.jsp">
                    <span class="fa fa-user-plus"></span> Register Here
                </a>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
    </div>
</nav>
</body>
</html>
