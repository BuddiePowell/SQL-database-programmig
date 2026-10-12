# Topic 4 Interactive
USE RecipesExample;

# You try!
# Find all recipes that have the same name as an ingredient
Select RecipeTitle, IngredientName
from Recipes
inner join Ingredients
	on (RecipeTitle - IngredientName)
Order By RecipeTitle;





# We saw a query similar to this last week that inner joins tables 
# where all field names are fully qualified with the table name.
#
# Modify this query to use table aliases.
SELECT 
    Ingredients.IngredientName AS Ingredient,
    Recipe_Ingredients.Amount, 
    Measurements.MeasurementDescription AS Unit
FROM
    Recipes as r
        INNER JOIN
    Recipe_Ingredients aS ri ON (Recipes.RecipeID = Recipe_Ingredients.RecipeID)
        INNER JOIN
    Ingredients as i ON (ri.IngredientID = Ingredients.IngredientID)
        INNER JOIN
    Measurements as m ON (ri.MeasureAmountID = m.MeasureAmountID)
WHERE
    r.RecipeTitle = 'Pollo Picoso'
ORDER BY ri.RecipeSeqNo;

#
# Using Joins Flexbily
#

# Some questions can be answered by including a table more than once 
# in a query. When we do this, table aliases are necessary.
# 
# Write a query that shows all the recipes that contain Salt and contain
# either Butter or Vegetable Oil.
select RecipeTitle
from Recipes
inner join Recipe_Ingredients as ri1 USING (RecipeID)
inner join Ingredients as i1
ON(ri1.IngredientID = i1.IngredientID AND (i1.IngredientName = 'Salt' and i1.IngredientName = 'Butter'));
inner join Recipe_Ingredients as ri2 USING (RecipeID)
inner join Ingredients as i2
ON(ri2.IngredientID = i2.IngredientID AND i2.IngredientName IN 'Butter', 'Vegatable Oil'));
# You try! 
# Show all pairs of recipes (two recipes in each row) that include the word "blender" in the preparation notes.


    
#
# Combining inner and outer joins
#

# Let's do: Write a query to show all Ingredients and the title of any recipes
# that they are in. 


# Doing well? Try limiting the query above to only 
# 1. Meat, Vegetable or Grain ingredient categories.
# 2. (And show only the ingredients that are not in a recipe)


# You try! 
# Show all recipes that do not contain Dairy. 
#


# Feeling good? Take it a step further and add the Recipe Class column to the results from the previous query
# and sort the results by recipe class.
