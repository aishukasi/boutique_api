ProjectName: botique_api

Models Designed:
Category
Inventory
Discount

Route:
http://localhost:3000/api/v1/boutiques/catalog - POST
http://localhost:3000/api/v1/boutiques/order - GET


1. run rails db:migrate
2. run rails db:seed

Category table will be filled by seed process.

Start rails server - rails server

Testing:

Use boutique.postman_collection file to check the api. Import josn in the post using import option in the postman collection.