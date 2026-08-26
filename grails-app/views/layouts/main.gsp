<!doctype html>
<html lang="en" class="no-js">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <title>
        <g:layoutTitle default="Car Rental"/>
    </title>

    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <asset:link
        rel="icon"
        href="favicon.ico"
        type="image/x-ico"/>

    <asset:stylesheet src="application.css"/>

    <g:layoutHead/>
</head>

<body>


<!-- Navbar -->
<nav class="navbar navbar-expand-lg bg-body-tertiary shadow-sm">

    <div class="container-fluid">

        <!-- Logo / Home -->
        <g:link
            controller="car"
            action="index"
            class="navbar-brand d-flex align-items-center">

            <asset:image
                src="grails.svg"
                alt="Car Rental"
                width="45"/>

            <span class="ms-2 fw-bold">
                Car Rental
            </span>

        </g:link>


        <!-- Mobile Button -->
        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarContent"
            aria-controls="navbarContent"
            aria-expanded="false"
            aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>

        </button>


        <!-- Navbar Content -->
        <div
            class="collapse navbar-collapse"
            id="navbarContent">


            <!-- Left Side -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <sec:ifLoggedIn>


                    <!-- ADMIN -->
                    <sec:ifAllGranted roles="ROLE_ADMIN">

                        <!-- Dashboard -->
                        <li class="nav-item">

                            <g:link
                                controller="dashboard"
                                action="index"
                                class="nav-link">

                                Dashboard

                            </g:link>

                        </li>


                        <!-- Cars -->
                        <li class="nav-item">

                            <g:link
                                controller="car"
                                action="index"
                                class="nav-link">

                                Cars

                            </g:link>

                        </li>


                        <!-- Rentals -->
                        <li class="nav-item">

                            <g:link
                                controller="rental"
                                action="index"
                                class="nav-link">

                                Rentals

                            </g:link>

                        </li>

                    </sec:ifAllGranted>


                    <!-- CUSTOMER -->
                    <sec:ifAllGranted roles="ROLE_CUSTOMER">

                        <!-- Browse Cars -->
                        <li class="nav-item">

                            <g:link
                                controller="car"
                                action="index"
                                class="nav-link">

                                Browse Cars

                            </g:link>

                        </li>


                        <!-- My Rentals -->
                        <li class="nav-item">

                            <g:link
                                controller="rental"
                                action="index"
                                class="nav-link">

                                My Rentals

                            </g:link>

                        </li>

                    </sec:ifAllGranted>


                </sec:ifLoggedIn>


                <g:pageProperty name="page.nav"/>

            </ul>


            <!-- Right Side -->
            <sec:ifLoggedIn>

                <div class="d-flex align-items-center gap-3">

                    <!-- Logged User -->
                    <span class="text-muted">

                        Signed in as

                        <strong>
                            <sec:username/>
                        </strong>

                    </span>


                    <!-- Logout -->
                    <form
                        action="${createLink(uri: '/logout')}"
                        method="POST"
                        class="d-inline">

                        <button
                            type="submit"
                            class="btn btn-outline-danger btn-sm">

                            Logout

                        </button>

                    </form>

                </div>

            </sec:ifLoggedIn>

        </div>

    </div>

</nav>


<!-- Page Content -->
<g:layoutBody/>


<!-- Footer -->
<div class="footer mt-5" role="contentinfo">

    <div class="container-fluid">

        <div class="row">


            <!-- Grails Guides -->
            <div class="card border-0 col-12 col-md">

                <div class="card-body">

                    <h6 class="card-title">

                        <a
                            class="link-underline link-underline-opacity-0"
                            href="https://guides.grails.org"
                            target="_blank">

                            <asset:image
                                src="advancedgrails.svg"
                                alt="Grails Guides"
                                class="me-2"
                                width="34"/>

                            Grails Guides

                        </a>

                    </h6>

                    <p class="card-text">

                        Building your first Grails app?
                        Looking to add security, or create a Single-Page-App?

                        Check out the

                        <a
                            href="https://guides.grails.org"
                            target="_blank">

                            Grails Guides

                        </a>

                        for step-by-step tutorials.

                    </p>

                </div>

            </div>


            <!-- Documentation -->
            <div class="card border-0 col-12 col-md">

                <div class="card-body">

                    <h6 class="card-title">

                        <a
                            class="link-underline link-underline-opacity-0"
                            href="https://grails.apache.org/docs/"
                            target="_blank">

                            <asset:image
                                src="documentation.svg"
                                alt="Grails Documentation"
                                class="me-2"
                                width="34"/>

                            Documentation

                        </a>

                    </h6>

                    <p class="card-text">

                        Ready to dig in?

                        You can find in-depth documentation for all the features
                        of Grails in the

                        <a
                            href="https://grails.apache.org/docs/"
                            target="_blank">

                            User Guide

                        </a>.

                    </p>

                </div>

            </div>


            <!-- Community -->
            <div class="card border-0 col-12 col-md">

                <div class="card-body">

                    <h6 class="card-title">

                        <a
                            class="link-underline link-underline-opacity-0"
                            href="https://slack.grails.org"
                            target="_blank">

                            <asset:image
                                src="slack.svg"
                                alt="Grails Slack"
                                class="me-2"
                                width="34"/>

                            Join the Community

                        </a>

                    </h6>

                    <p class="card-text">

                        Get feedback and share your experience with other
                        Grails developers in the community

                        <a
                            href="https://slack.grails.org"
                            target="_blank">

                            Slack channel

                        </a>.

                    </p>

                </div>

            </div>

        </div>

    </div>

</div>


<!-- Loading Spinner -->
<div
    id="spinner"
    class="position-absolute top-0 end-0 p-1"
    style="display:none;">

    <div
        class="spinner-border spinner-border-sm"
        role="status">

        <span class="visually-hidden">
            Loading...
        </span>

    </div>

</div>


<asset:javascript src="application.js"/>

</body>
</html>