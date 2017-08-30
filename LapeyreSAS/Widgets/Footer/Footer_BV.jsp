<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ page trimDirectiveWhitespaces="true" %>

<script type="text/javascript" 
	src="//display.ugc.bazaarvoice.com/static/lapeyre/fr_FR/bvapi.js">
</script>

<script type="text/javascript"> 
//    var Id = '${partNumber}'.replace(/[^0-9.]/g, "");
//    $BV.configure('global', { productId : Id });
   
   setTimeout(function(){
       list = [];  
       $( ".product_info .productRating" ).each(function( index ) {
          if ($( this ).attr('id').replace('BVRRInlineRating-','').length>0) list.push($( this ).attr('id').replace('BVRRInlineRating-',''));
       });  
       if (list.length>0) {
        $BV.ui( 'rr', 'inline_ratings', {
          productIds : list,
          containerPrefix : 'BVRRInlineRating'
        });
        setTimeout(function(){
         $( ".productRating:contains('(0)')" ).each(function() {
          $( this ).css('visibility','hidden');
         });
        }, 3000);
       }
   }, 3000);
</script>