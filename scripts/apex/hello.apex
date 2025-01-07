// // // Use .apex files to store anonymous Apex.
// // // You can execute anonymous Apex in VS Code by selecting the
// // //     apex text and running the command:
// // //     SFDX: Execute Anonymous Apex with Currently Selected Text
// // // You can also execute the entire file by running the command:
// // //     SFDX: Execute Anonymous Apex with Editor Contents

// // // string tempvar = 'Enter_your_name_here';
// // // System.debug('Hello World!');
// // // System.debug('My name is ' + tempvar);

// // // ApexTutorial.nullCheckAndNullCoallesing();
// // // Account test = new Account(name = 'test');
// // // String s = [select name from account where id = '001000000012345']?.Name;

// // // System.debug(s??test.Name);

// // // BatchTest b = new BatchTest();
// // // Database.executeBatch(b, 1);

// // Schema.SObjectDescribeResult accountTokenBasedDescribe = 

// // --------------------------------------------
// // 1. Define Parking_Lot__c Object
// // 2. Define Level__c object Object
// // 3. create master-detail between Parking_Lot__c and Level__c
// // 4. Define Slot__c Object
// // 5. Create M-D between Parking_Lot__c and Slot__c
// // 6. Define lookup from Slot__c to Level__c
// // 7. Define Vehicle__c Object
// // 8. Define reservation__c Object
// // 9. Define lookup from Reservation to Vehicle
// // 10. Define lookup from Reservation to Slot__c
// // 11. One cannot have a vehicle without reservation;
// //     therefore, define a VR to ensure this

// // ---------------------------------------------
// // Movie theater has:
// // - Multiple theater locations
// // - Multiple Ticketing interfaces
// // - Multiple showings per movie per location
// // - Multiple movies
// // - Multiple theathers within a Location
// // - One movie ticket per seat per showing

// // Set up data model:

// // Theater_Location__c Object__c
// //   . Name: Company name
// //   . Address: Physical Location address of the theater

// // Show_Room__c
// //   . Number: the Id number of the show room in a particular Location
// //   . Theater_Location__c: lookup to location. consideration: either theater record cannot be deleted if they have
// //   at least one show room, or all show room records are deleted when theater record gets deleted
// //   . Capacity: Total number of available seats

// // Seat__c
// //   . Show_Room__c: Look up to a show room.
// //   Consideration, seat cannot exist without show room.
// //   . Number: seat number

// // Movie__c
// //    . Title
// //    . Description/Details:

// // Showing management Data model:

// // Showing__c
// //   . Movie__c: lookup to movie being shown
// //   . Theater_Location__c: look up to the location movie is being shown at
// //   . Type (picklist): regular, 3D...

// // Show_Time__c:
// //   . Showing__c: lookup to movie being shown
// //   . When__c: The date and time of the showing
// //   . Show_room__c: lookup to the actual show room in a specified location the movie is being shown at


// // Seat_Management__c:
// //   . Show_Time__c: lookup to a showtime
// //   . Seat__c: lookup to actual seat
// //   . Availability__c (picklist): Available (Default), Unavailable, Uneligible

// // Ticket__c:
// //   . Seat_Management__c: M-D to Available_Seat__c. Filter for only available seats.
// //   . Multiple Cross-object formula fields: movie title, showing room, seat number, theater location name

// //   consideration: Once a ticket is successfully issued, a seat management record should be mark as unavailable

// // Open questions: holding a seat for a few minutes to ensure a transaction goes through successfully
// // Payment aspect of the booking is omitted

// List<SelectOption> options = new List<SelectOption>{
//     new SelectOption('A', 'US', true),
//     new SelectOption('CANADA', 'Canada', true),
//     new SelectOption('M', 'Mexico', false),
//     new SelectOption('B', 'Brazil')
// };
// DisabledSelectOptionComparator comp = new DisabledSelectOptionComparator();
// System.debug(options);
// options.sort(comp);
// system.debug(options);
Database.QueryLocator locator = Database.getQueryLocator(
                    'SELECT Id, Name FROM Account ORDER BY CreatedDate ASC'
                );
                Database.QueryLocatorIterator iterator = locator.iterator();
                system.debug(iterator);
                system.debug(system.JSON.serialize(iterator));
                // system.debug(locator.getRecords());
                // system.debug(locator.getRecords(0, 1));  
                // return locator.getRecords(0, limit);