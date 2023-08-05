const espress = require('express');
const productRoute=espress.Router();
const auth=require('../midddlewares/auth');
const { findById } = require('../models/product');
const {Product}=require('../models/product');



productRoute.get('/api/product',auth,async(req,res)=>{
 
    try{
   product=await Product.find({category:req.query.category});
   res.json(product);
  
    } catch (e){
        res.status(500).json({error: e.message});
       
    }
  });

  productRoute.get('/api/products/search/:searchQurey',auth,async(req,res)=>{

try{
const product=await Product.find({name: {$regex:req.params.searchQurey, $options:"i" },
});
res.json(product);
}catch (e){
    res.status(500).json({error: e.message});
}
  });

  productRoute.post('/api/rate-product',auth,async (req,res)=>{
    const {id,rating}=req.body;

    let product=await Product.findById(id);

    for(let i=0;i<product.ratings.length;i++){
      if(product.ratings[i].userId==req.user){
        product.ratings.splice(i,1);
        break;
      }
    }
    const ratingShema={
      userId:req.user,
      rating,
    };
    product.ratings.push(ratingShema);
    product = await product.save();
    res.json(product);

  });

  productRoute.get("/api/deal-of-day",auth, async(req,res)=>{
   
    try{
      let product = await Product.find({});
      product = product.sort((a,b)=>{

        let aSum=0;
        let bSum=0;

        for(let i=0;i<a.ratings.length;i++){
          aSum+=a.ratings[i].rating;
        }
        for(let i=0;i<b.ratings.length;i++){
          bSum+=b.ratings[i].rating;
        }
        return aSum < bSum ? 1 : -1;

      });

      res.json(product[0]);

    } catch(e){
     res.status(500).json({error:e.message});
   
    }

  });
  module.exports=productRoute;
