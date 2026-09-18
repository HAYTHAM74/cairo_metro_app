class FareCalcService
{
  FareCalcService();
  
  int _normalTicketCalc(int numOfStations)
  {
    if(numOfStations >= 24)
    {
      return 20;
    }
    else if(numOfStations >= 17)
    {
      return 15;
    }
    else if(numOfStations >= 10)
    {
      return 12;
    }
    else
    {
      return 10;
    }
  }
  int _seniorsTicketCalc(int numOfStations)
  {
    if(numOfStations >= 24)
    {
      return 10;
    }
    else if(numOfStations >= 17)
    {
      return 8;
    }
    else if(numOfStations >= 10)
    {
      return 6;
    }
    else
    {
      return 5;
    }
  }
  int _specialNeedsTicketCalc(int numOfStations)
  {
    return 5;
  }
  (int, int) ticketCalc(int numOfStations, bool isSenior, bool isSpecialNeeds)
  {
    if(isSenior)
    {
      return (_normalTicketCalc(numOfStations), _seniorsTicketCalc(numOfStations));
    }
    else if(isSpecialNeeds)
    {
      return (_normalTicketCalc(numOfStations), _specialNeedsTicketCalc(numOfStations));
    }
    else
    {
      return (_normalTicketCalc(numOfStations), 0);
    }
  }
}