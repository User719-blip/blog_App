# BLOG APP

  - this app is build on feature 1st approch ie 
    every feature in this app has diffrent folder
    and can be added or removed with relative eas

  - Now we make a folder name feature which will 
    store all the features of the app

  - Also then of app has to be predefined in 
    main function

  - Create a core folder which has all the 
    resource shared across the app like theme

  - theme folder under lib/core houses theme 
    data app_pallet has colors and theme has 
    theme data like input feild theme etc

# Core
  - Houses  logic such as theme fonts and designs that are to be shared across the app

  ## Core Theme
   
  - theme.dart file contains all the theme data
    like colors and theme data like input feild theme etc

  - app_pallet has diffremt color pallates of all ui design

  ## Core Error
  
  - error.dart file contains all the error data
    like error messages and error codes

  ## Core Secret
   
  - secret.dart file contains all the secret data
    like api keys and other sensitive data

  ## Core  Usecase

  - file has class which can be implemented by use case

# Authentication

  - 1st we design the login pages to do that we 
    made the folder auth and divide it in data , 
    domain and presentation part

  ## Auth Presenataion

    - presenataion divided into pages , widgets 
      and bloc

    - pages has signup_page file handeling signups ui 

    - So the feilds name email password look 
      similar so they can be combined into a 
      widget under lib/feature/presentation/widget
            
    - So we will add signup(gradient) button by creating a
      file under widget folder named auth_gradient_button

    - now we have to create a form to validate data form name email and 
      password feilds using a validator 

    - also use the contollers to get data from the feilds

    - auth_bloc takes a UserSignUp usecase as depedency
      injection via construtor

    - It listens for the AuthSignUp event. When this event is added for example, when a user submits a  
      form Calls the UserSignUp use case with the provided name, email, and password.
      Waits for the result (res), which is an Either'<Failure, String>'.


  ## Auth Domain 

    - this layer sits between the presentation and data layer
      this is most stable layer and defines the core logic

    - this layer does not depend on presenatation layer or data layer
      ie agnostic of presentation and data layer and chnages made in 
      presenataion and data layer should not effect the auth domain

    - it consists of use case(interactors) , entity and repository layers
      Defines what authentication actions are possible (sign up, login).
      Does not know or care how these actions are performed.

    - here the repository layer acts as an interface to the repository layer 
      of data layer ie "hey  data layer log this user in i dont care how"
      so the data layer provides actual implementation 
    
    - This class encapsulates the business logic for signing up a user.
      When called, it delegates the actual sign-up process to the AuthRepo (repository), passing along the user’s credentials.
 
  ## Auth Data

    - retrives and manages data from various sources like data bases or apis
      and makes it available to the domain layer or other layers
      here it Handles the actual communication with the remote server (Supabase).
    
    - it works as traslater for the raw data into the domain layer
      and vice versa 

    - it also provides concrete implementation for the reposetory interfaces 
      defined in the domain layer

    - it converts the errors form apis and databases into domain frendly failure 
      eg like falure objects in lib/core/error  




