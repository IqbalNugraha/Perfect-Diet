class ApiService {
  //spoonacular
  String apiKey2 = '265143fd096244b392beb5cb2fed8463';
  String apiKey3 = '0d55b02897734243874aeee6fe64b258';
  String apiKey1 = 'b6f3d21bf42b49d3ac420803ce05f4f0';
  String apiKey = 'fc55c1b755cf4071b5cee44a833aa8ff';
  String baseUrlSpoonacular = 'https://api.spoonacular.com';
  String recipe = '/recipes';
  String findByNutrient = '/findByNutrients?';
  String getFindByNutrient =
      'https://api.spoonacular.com/recipes/findByNutrients';
  String getListFood = "/recipes/complexSearch";
  String cameraRecommendation = "/food/images/analyze";

  //clarifai
  String urlGenderClarifai =
      "https://api.clarifai.com/v2/users/clarifai/apps/main/models/gender-demographics-recognition/versions/ff83d5baac004aafbe6b372ffa6f8227/outputs";
  String urlFoodClarifai =
      "https://api.clarifai.com/v2/users/clarifai/apps/main/models/food-item-recognition/versions/1d5fd481e0cf4826aa72ec3ff049e044/outputs";
  String personalKey = "d482cdd410414af2b70cc767e2f72c2d";

  //Firebase Authentication

  String keyFirebase = "AIzaSyD2Zn_zkSSPJ6ZLsuGhjZWN0nXs3zdQXIE";
  String signUpUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=";
  String signInUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";
  String profileUrl =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/profile/";
  String targetProfileUrl =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/target_profile/";
  String imtProfileUrl =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/imt_profile/";
  String polaMakanUrl =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/pola_makan/";
  String batasKandunganUrl =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/batas_kandungan/";
  String listSarapan =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/list_sarapan/";
  String listMakanSiang =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/list_makan_siang/";
  String listMakanMalam =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/list_makan_malam/";
  String listCamilan =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/list_camilan/";
  String listHistory =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/history/";
  String tablePolaMakan =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/table_pola_makan/";
  String listTablePola =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/list_table_pola_makan/";
  String nutrisiPolaMakan =
      "https://perfectdiet-8631f-default-rtdb.asia-southeast1.firebasedatabase.app/nutrisi_pola_makan/";
}
