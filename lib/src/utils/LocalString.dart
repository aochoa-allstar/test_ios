import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // comments refers to dart file where the string was added
        'en_US': {
          // --utils--
          'utils_save': 'Save',
          'utils_name': 'Name',
          'utils_warning': 'Warning',
          'utils_completed_at': 'Completed at ',
          'utils_upload_photo': 'upload photo',
          'utils_photo_from': 'Photo source',
          'utils_take_photo': 'Take a photo',
          'utils_gallery': 'From gallery',
          'utils_cancel': 'Cancel',
          'utils_language': 'Language',
          'utils_next': 'Next',
          'utils_other': 'Other',
          'utils_signature': 'Signature',
          'utils_clear': 'Clear',
          // home_screen
          'home_old_tickets': 'Old ticket',
          'home_new_ticket': 'New ticket',
          // oldTicketsList
          'home_prevtickets_notickets': 'Not yet preview tickets',
          'home_prevtickets_date': 'Start date',
          // cardInfoShift
          'home_shift_active': 'Active',
          'home_shift_start_shift': 'Start Shift',
          'home_shift_warning': 'You have a shift but not an active ticket,\nplease create new ticket to continue.',
          // newTicketBtn
          'home_new_ticket_btn': 'New Ticket',
          // createTicket - addProjectScreen
          'new_ticket_trucks_hint': 'Select a Truck',
          'new_ticket_trucks_validator': 'Please select a Truck',
          'new_ticket_customer_hint': 'Select a Customer',
          'new_ticket_customer_validator': 'Please select a Customer',
          'new_ticket_project_hint': 'Select a Project',
          'new_ticket_project_validator': 'Please select a Project',
          'new_ticket_companyman_hint': 'Select a Company Man',
          'new_ticket_companyman_validator': 'Please select a Company Man',
          'new_ticket_origin_hint': 'Select the Origin',
          'new_ticket_origin_validator': 'Please select the Origin',
          'new_ticket_destiny_hint': 'Select the Destination',
          'new_ticket_destiny_validator': 'Please select the Destination',
          'new_ticket_start_ticket': 'Start Ticket',
          // dropDownTruck
          'new_ticket_trucks_label': 'Truck',
          // dropDownCustomer - addProjectScreen
          'new_ticket_customer_label': 'Customer',
          // dropDownProject
          'new_ticket_project_label': 'Project',
          // dropDownCompanyMan
          'new_ticket_companyman_label': 'Company Man',
          // dropDownOrigin
          'new_ticket_origin_label': 'Origin',
          // dropDownDesitny
          'new_ticket_destiny_label': 'Destination',
          // pages_screen - addDestinationScreen
          'menu_add_destination': 'Add Destination',
          'menu_add_project': 'Add Project',
          // ticketsToSignature
          'menu_tickets_screen': 'Tickets to sign',
          'menu_tickets_screen_noprevious': 'Not Previous ticket.',
          // pfd_ticketSignature
          'tickets_signature_clean': 'Clean Pad',
          // create_new_shift
          'start_shift_helper_hint': 'Select a Helper',
          'start_shift_helper_validator': 'Please select a Helper',
          'start_shift_equipment_hint': 'Select an Equiment',
          'start_shift_equipment_validator':
              'Por favor, Select an equiment / vehicle',
          'start_shift_role_hint': 'Select a role',
          'start_shift_role_validator': 'Por favor, select a role',
          // createShiftController
          'start_shift_helper_warning_message':
              'Please select different helpers in each field to continue',
          // headerTicketSteper
          'ticket_date': 'Ticket date',
          'ticket_current_ticket': 'Current Ticket',
          // steperTicketHome - ticketSteper_depart
          'ticket_steps_depart': 'Depart',
          'ticket_steps_complete_jsa': 'Fill out JSA',
          'ticket_steps_jsa_status': 'Finished JSA',
          // steperTicketHome- ticketSteper_arrived
          'ticket_steps_arrive': 'Arrive',
          // steperTicketHome- ticketSteper_finish
          'ticket_steps_finished': 'Finished',
          // ticketSteper_finish
          'ticket_finish_supervisor_hint': 'Select a Supervisor',
          'ticket_finish_supervisor_validator': 'Please select a Supervisor',
          'ticket_finish_supervisor_workhours': 'Supervisor work hours',
          'ticket_finish_description_hint': 'Select a description',
          'ticket_finish_description_validator': 'Please select a Description',
          'ticket_finish_description': 'Description',
          'ticket_finish_workhours': 'Work hours',
          'ticket_finish_additionalequip': 'Additional equipment (opt.)',
          'ticket_finish_finished':
              'Ticket finished.\nWhat would you like to do?',
          'ticket_finish_endshift': 'End shift',
          // JsasFormScreen
          'new_jsas': 'New JSAs',
          'new_jsas_generalinfo': 'General Information',
          'new_jsas_safetyequip': 'Required Safety Equipment',
          'new_jsas_hazards': 'Hazards',
          'new_jsas_permits': 'Permits Required',
          'new_jsas_check': 'Check and Review',
          'new_jsas_environment': 'Environmental Concerns',
          'new_jsas_task': 'Task',
          'new_jsas_controls': 'Controls',
          'new_jsas_recomended': 'Recomended Actions and Procedures',
          'new_jsas_muster': 'Muster Points',
          'new_jsas_signatures': 'Signatures',
          // steperGenerlinfo
          'new_jsas_generalinfo_location_hint': 'Select a Location',
          'new_jsas_generalinfo_location_validator': 'Please select a Location',
          'new_jsas_generalinfo_job': 'Job Description',
          // steperRequiredEquipment
          'new_jsas_safetyequip_steel': 'Steel Toed Shoes',
          'new_jsas_safetyequip_hard': 'Hard Hat',
          'new_jsas_safetyequip_glasses': 'Safety Glasses',
          'new_jsas_safetyequip_monitor': 'H2S Monitor',
          'new_jsas_safetyequip_fr': 'FR Clothing',
          'new_jsas_safetyequip_fall': 'Fall\nProtection',
          'new_jsas_safetyequip_hearing': 'Hearing Protection',
          'new_jsas_safetyequip_respirator': 'Respirator',
          // steperHazards
          'new_jsas_hazards_fall': 'Fall Potencial',
          'new_jsas_hazards_overhead': 'Overhead Lift',
          'new_jsas_hazards_pinch': 'Pinch Points',
          'new_jsas_hazards_split': 'Splip/Trip',
          'new_jsas_hazards_sharp': 'Sharp Objects',
          'new_jsas_hazards_power': 'Power Tools',
          'new_jsas_hazards_surface': 'Hot/Cold Surface',
          'new_jsas_hazards_preassure': 'Pressure',
          'new_jsas_hazards_dropped': 'Dropped Objects',
          'new_jsas_hazards_heavy': 'Heavy Lifting',
          'new_jsas_hazards_weather': 'Weather',
          'new_jsas_hazards_flammables': 'Flammables',
          'new_jsas_hazards_chemicals': 'Chemicals',
          // steperPermits
          'new_jsas_permits_onecall': 'One Call #',
          'new_jsas_permits_confined': 'Confined Space Permits',
          'new_jsas_permits_hot': 'Hot Work Permit',
          'new_jsas_permits_excavation': 'Excavation / Trenching',
          // steperCheckReview
          'new_jsas_check_lockout': 'Lock Out/Tag Out',
          'new_jsas_check_ladder': 'Ladder',
          'new_jsas_check_fire': 'Fire Exitinguisher',
          'new_jsas_check_permits': 'Permits',
          'new_jsas_check_inspection': 'Inspection of Equipment',
          'new_jsas_check_msds': 'MSDS Review',
          // steperEnviroment
          'new_jsas_environment_weather': 'Weather Condition',
          'new_jsas_environment_wind': 'Wind Direction',
          // steperTask
          'new_jsas_task_tasks': 'Tasks',
          // steperMusterPoints
          'new_jsas_muster_draw': 'Please, draw in the pad',
          // steperSinganures
          'new_jsas_signatures_msg': 'Please, sign on the pads',
          // fourth_screen
          'new_inspection_msg': 'Create a vehicle inspection',
          'new_inspection_pretrip': 'Pre Trip',
          'new_inspection_posttrip': 'Post Trip',
          // inspectionScreen
          'new_inspection_pretrip_title': 'Drivers Vehicle Inspection Report',
          'new_inspection_pretrip_check': 'Check any Defective Items',
          'new_inspection_pretrip_trailers': 'Trailer(s) No.(s)',
          'new_inspection_pretrip_remarks': 'Remarks',
          'new_inspection_pretrip_signature': 'Signature Driver',
          // steperGeneralInfo
          'new_inspection_pretrip_odometer_label': 'Odometer reading',
          'new_inspection_pretrip_odometer_hint': 'Begin',
          'new_inspection_pretrip_odometer_hint2': 'End',
          'new_inspection_pretrip_odometer_hint3': 'Select a Tractor/Truck',
          'new_inspection_pretrip_odometer_validator':
              'Please select a Tractor/Truck',
          // steperPosPrTrip
          'new_inspection_pretrip_check_aircompressor': 'Air Compressor',
          'new_inspection_pretrip_check_airlines': 'Air Lines',
          'new_inspection_pretrip_check_battery': 'Battery',
          'new_inspection_pretrip_check_belts': 'Belts and Hoses',
          'new_inspection_pretrip_check_body': 'Body',
          'new_inspection_pretrip_check_brake_accesories': 'Brake Accesories',
          'new_inspection_pretrip_check_brakes_parking': 'Brakes, Parking',
          'new_inspection_pretrip_check_brakes_service': 'Brakes, Service',
          'new_inspection_pretrip_check_clutch': 'Clutch',
          'new_inspection_pretrip_check_coupling': 'Coupling Devices',
          'new_inspection_pretrip_check_defroster': 'Defroster/Heater',
          'new_inspection_pretrip_check_drive': 'Drive Line',
          'new_inspection_pretrip_check_engine': 'Engine',
          'new_inspection_pretrip_check_fifth': 'Fifth Wheel',
          'new_inspection_pretrip_check_exhaust': 'Exhaust',
          'new_inspection_pretrip_check_fluid': 'Fluid Levels',
          'new_inspection_pretrip_check_frame': 'Frame and Assembly',
          'new_inspection_pretrip_check_front': 'Front Axle',
          'new_inspection_pretrip_check_fuel': 'Fuel Tanks',
          'new_inspection_pretrip_check_generator': 'Generator',
          'new_inspection_pretrip_check_horn': 'Horn',
          'new_inspection_pretrip_check_lights':
              'Lights\nHead-Stop\nTail-Dash\nTurn Indicators',
          'new_inspection_pretrip_check_mirrors': 'Mirrors',
          'new_inspection_pretrip_check_muffler': 'Muffler',
          'new_inspection_pretrip_check_oil': 'Oil Level',
          'new_inspection_pretrip_check_radiator': 'Radiator Level',
          'new_inspection_pretrip_check_rear': 'Rear End',
          'new_inspection_pretrip_check_reflectors': 'Reflectors',
          'new_inspection_pretrip_check_safety':
              'Safety Equipment\nFire Extinguisher\nFlags-Flares-Fusees\nReflective Triangles\nSpare Bulbs and Fuses\nSpare Seal Beam',
          'new_inspection_pretrip_check_starter': 'Starter',
          'new_inspection_pretrip_check_steering': 'Steering',
          'new_inspection_pretrip_check_suspension': 'Suspension System',
          'new_inspection_pretrip_check_tirechains': 'Tire Chains',
          'new_inspection_pretrip_check_tires': 'Tires',
          'new_inspection_pretrip_check_transmission': 'Transmission',
          'new_inspection_pretrip_check_trip': 'Trip Recorder',
          'new_inspection_pretrip_check_wheels': 'Wheels and Rims',
          'new_inspection_pretrip_check_windows': 'Windows',
          'new_inspection_pretrip_check_windshield': 'Windshield Wipers',
          // steperTrailers
          'new_inspection_pretrip_trailers_hint1': 'Select a Trailer No.1',
          'new_inspection_pretrip_trailers_validator1':
              'Please select a Trailer No.1',
          'new_inspection_pretrip_trailers_hint2': 'Select a Trailer No.2',
          'new_inspection_pretrip_trailers_validator2':
              'Please select a Trailer No.2',
          'new_inspection_pretrip_trailers_brake': 'Brake Connections',
          'new_inspection_pretrip_trailers_brakes': 'Brakes',
          'new_inspection_pretrip_trailers_coupling': 'Coupling Devices',
          'new_inspection_pretrip_trailers_coupling_king':
              'Coupling (King) Pin',
          'new_inspection_pretrip_trailers_doors': 'Doors',
          'new_inspection_pretrip_trailers_hitch': 'Hitch',
          'new_inspection_pretrip_trailers_landing': 'Landing Gear',
          'new_inspection_pretrip_trailers_lights': 'Lights - All',
          'new_inspection_pretrip_trailers_reflectors':
              'Reflectors/Reflective Tape',
          'new_inspection_pretrip_trailers_roof': 'Roof',
          'new_inspection_pretrip_trailers_suspension': 'Suspension System',
          'new_inspection_pretrip_trailers_straps': 'Straps',
          'new_inspection_pretrip_trailers_tarpaulin': 'Tarpaulin',
          'new_inspection_pretrip_trailers_tires': 'Tires',
          'new_inspection_pretrip_trailers_wheels': 'Wheels and Rims',
          // steperRemarks
          'new_inspection_pretrip_remarks_msg':
              'CONDITION OF THE ABOVE VEHICLE IS SATISFACOTRY',
          'new_inspection_pretrip_remarks_sign': 'Please, sign on the pad',
          'new_inspection_pretrip_remarks_sign_conditions':
              'Signature Conditions',
          // steperSignature
          'new_inspection_pretrip_signature_above1': 'ABOVE DEFECTS CORRECTED',
          'new_inspection_pretrip_signature_above2':
              'THE ABOVE DEFECTS DO NOT NEED TO BE CORRECTED FOR THE SAFE OPERATION OF THE VEHICLE',
          // manage_options_screen
          'options_logout': 'Log Out',
          'options_changepsw': 'Change password',
          'list_pdf_jsas_prev':
              'You must connect to the internet to view the pdf list',
        },
        'es_MX': {
          // --utils--
          'utils_save': 'Guardar',
          'utils_name': 'Nombre',
          'utils_warning': 'Advertencia',
          'utils_completed_at': 'Completado el ',
          'utils_upload_photo': 'cargar foto',
          'utils_photo_from': 'Fuente de la foto',
          'utils_take_photo': 'Abrir cámara',
          'utils_gallery': 'Abrir galería',
          'utils_cancel': 'Cancelar',
          'utils_language': 'Idioma',
          'utils_next': 'Siguiente',
          'utils_other': 'Otro',
          'utils_signature': 'Firma',
          'utils_clear': 'Limpiar',
          // home_screen
          'home_old_tickets': 'Tickets anteriores',
          'home_new_ticket': 'Nuevo ticket',
          // oldTicketsList
          'home_prevtickets_notickets': 'Sin tickets anteriores',
          'home_prevtickets_date': 'Fecha de inicio',
          // cardInfoShift
          'home_shift_active': 'Activo',
          'home_shift_start_shift': 'Comenzar turno',
          'home_shift_warning': 'Has iniciado turno, pero no tienes un ticket activo,\npor favor, crea un ticket para continuar.',
          // newTicketBtn
          'home_new_ticket_btn': 'Nuevo Ticket',
          // createTicket
          'new_ticket_trucks_hint': 'Selecciona una camioneta',
          'new_ticket_trucks_validator': 'Por favor, selecciona una camioneta',
          'new_ticket_customer_hint': 'Selecciona un cliente',
          'new_ticket_customer_validator': 'Por favor, selecciona un cliente',
          'new_ticket_project_hint': 'Selecciona un projecto',
          'new_ticket_project_validator': 'Por favor, selecciona un projecto',
          'new_ticket_companyman_hint': 'Selecciona un agente',
          'new_ticket_companyman_validator': 'Por favor, selecciona un agente',
          'new_ticket_origin_hint': 'Selecciona el origen',
          'new_ticket_origin_validator': 'Por favor, selecciona el origen',
          'new_ticket_destiny_hint': 'Selecciona el destino',
          'new_ticket_destiny_validator': 'Por favor, selecciona el destino',
          'new_ticket_start_ticket': 'Comenzar Ticket',
          // dropDownTruck
          'new_ticket_trucks_label': 'Camioneta',
          // dropDownCustomer
          'new_ticket_customer_label': 'Cliente',
          // dropDownProject
          'new_ticket_project_label': 'Projecto',
          // dropDownCompanyMan
          'new_ticket_companyman_label': 'Agente',
          // dropDownOrigin
          'new_ticket_origin_label': 'Origen',
          // dropDownDesitny
          'new_ticket_destiny_label': 'Destino',
          // pages_screen - addDestinationScreen
          'menu_add_destination': 'Agregar Destino',
          'menu_add_project': 'Agregar Projecto',
          // ticketsToSignature
          'menu_tickets_screen': 'Tickets para firmar',
          'menu_tickets_screen_noprevious': 'Sin tickets pendientes.',
          // pfd_ticketSignature
          'tickets_signature_clean': 'Limpiar área',
          // create_new_shift
          'start_shift_helper_hint': 'Selecciona un ayudante',
          'start_shift_helper_validator': 'Por favor, selecciona un ayudante',
          'start_shift_equipment_hint': 'Selecciona un equipo',
          'start_shift_equipment_validator': 'Por favor, selecciona un equipo',
          'start_shift_role_hint': 'Selecciona un rol',
          'start_shift_role_validator': 'Por favor, selecciona un rol',
          // createShiftController
          'start_shift_helper_warning_message':
              'Por favor, selecciona ayudantes diferentes para continuar',
          // headerTicketSteper
          'ticket_date': 'Fecha del ticket',
          'ticket_current_ticket': 'Ticket actual',
          // steperTicketHome - ticketSteper_depart
          'ticket_steps_depart': 'Salida',
          'ticket_steps_complete_jsa': 'Llenar JSA',
          'ticket_steps_jsa_status': 'JSA completo',
          // steperTicketHome- ticketSteper_arrived
          'ticket_steps_arrive': 'Llegada',
          // steperTicketHome- ticketSteper_finish
          'ticket_steps_finished': 'Finalizar',
          // ticketSteper_finish
          'ticket_finish_supervisor_hint': 'Selecciona un supervisor',
          'ticket_finish_supervisor_validator':
              'Por favor, selecciona un supervisor',
          'ticket_finish_supervisor_workhours':
              'Horas de trabajo del supervisor',
          'ticket_finish_description_hint': 'Selecciona una descripción',
          'ticket_finish_description_validator':
              'Por favor, selecciona una descripción',
          'ticket_finish_description': 'Descripción',
          'ticket_finish_workhours': 'Horas trabajadas',
          'ticket_finish_additionalequip': 'Equipo adicional (op.)',
          'ticket_finish_finished': 'Ticket terminado.\n¿Qué deseas hacer?',
          'ticket_finish_endshift': 'Terminar turno',
          // JsasFormScreen
          'new_jsas': 'Nuevo JSAs',
          'new_jsas_generalinfo': 'Información general',
          'new_jsas_safetyequip': 'Equipo de seguridad requerido',
          'new_jsas_hazards': 'Peligros',
          'new_jsas_permits': 'Permisos requeridos',
          'new_jsas_check': 'Comprobar y revisar',
          'new_jsas_environment': 'Preocupaciones ambientales',
          'new_jsas_task': 'Tarea',
          'new_jsas_controls': 'Controles',
          'new_jsas_recomended': 'Acciones y procedimientos recomendados',
          'new_jsas_muster': 'Puntos de reunión',
          'new_jsas_signatures': 'Signatures',
          // steperGenerlinfo
          'new_jsas_generalinfo_location_hint': 'Selecciona una ubicación',
          'new_jsas_generalinfo_location_validator':
              'Por favor, selecciona una ubicación',
          'new_jsas_generalinfo_job': 'Descripción del trabajo',
          // steperRequiredEquipment
          'new_jsas_safetyequip_steel': 'Zapatos con punta de acero',
          'new_jsas_safetyequip_hard': 'Casco de seguridad',
          'new_jsas_safetyequip_glasses': 'Lentes de seguridad',
          'new_jsas_safetyequip_monitor': 'Monitor H2S',
          'new_jsas_safetyequip_fr': 'Ropa FR',
          'new_jsas_safetyequip_fall': 'Protección\ncontra caídas',
          'new_jsas_safetyequip_hearing': 'Protección para oídos',
          'new_jsas_safetyequip_respirator': 'Respirador',
          // steperHazards
          'new_jsas_hazards_fall': 'Potencial de caída',
          'new_jsas_hazards_overhead': 'Levatamiento por sobre la cabeza',
          'new_jsas_hazards_pinch': 'Puntos de agarre',
          'new_jsas_hazards_split': 'Resbalón/Tropiezo',
          'new_jsas_hazards_sharp': 'Objetos afilados',
          'new_jsas_hazards_power': 'Herrammientas eléctricas',
          'new_jsas_hazards_surface': 'Superficie caliente/fría',
          'new_jsas_hazards_preassure': 'Presión',
          'new_jsas_hazards_dropped': 'Objetos tirados',
          'new_jsas_hazards_heavy': 'Levantamiento pesado',
          'new_jsas_hazards_weather': 'Clima',
          'new_jsas_hazards_flammables': 'Inflamables',
          'new_jsas_hazards_chemicals': 'Químicos',
          // steperPermits
          'new_jsas_permits_onecall': 'Una llamada #',
          'new_jsas_permits_confined': 'Permisos para espacios confinados',
          'new_jsas_permits_hot': 'Hot Work Permit',
          'new_jsas_permits_excavation': 'Excavación / Zanja',
          // steperCheckReview
          'new_jsas_check_lockout': 'Bloqueo y etiquetado',
          'new_jsas_check_ladder': 'Escalera',
          'new_jsas_check_fire': 'Extintor',
          'new_jsas_check_permits': 'Permisos',
          'new_jsas_check_inspection': 'Inspección de equipo',
          'new_jsas_check_msds': 'Revisión de MSDS',
          // steperEnviroment
          'new_jsas_environment_weather': 'Condición climática',
          'new_jsas_environment_wind': 'Dirección del viento',
          // steperTask
          'new_jsas_task_tasks': 'Tareas',
          // steperMusterPoints
          'new_jsas_muster_draw': 'Por favor, dibuja en el área',
          // steperSinganures
          'new_jsas_signatures_msg': 'Por favor, firma en las áreas',
          // fourth_screen
          'new_inspection_msg': 'Crear una inspección vehicular',
          'new_inspection_pretrip': 'Pre-viaje',
          'new_inspection_posttrip': 'Post-viaje',
          // inspectionScreen
          'new_inspection_pretrip_title':
              'Reporte de inspección vehicular de conductores',
          'new_inspection_pretrip_check': 'Verificar artículos defectuosos',
          'new_inspection_pretrip_trailers': 'Número(s) de trailer(s)',
          'new_inspection_pretrip_remarks': 'Comentarios',
          'new_inspection_pretrip_signature': 'Firma del conductor',
          // steperGeneralInfo
          'new_inspection_pretrip_odometer_label': 'Lectura de odómetro',
          'new_inspection_pretrip_odometer_hint': 'Inicio',
          'new_inspection_pretrip_odometer_hint2': 'Fin',
          'new_inspection_pretrip_odometer_hint3':
              'Selecciona un tractor/camioneta',
          'new_inspection_pretrip_odometer_validator':
              'Por favor, selecciona un tractor/camioneta',
          // steperPosPrTrip
          'new_inspection_pretrip_check_aircompressor': 'Compresor de aire',
          'new_inspection_pretrip_check_airlines': 'Líneas de aire',
          'new_inspection_pretrip_check_battery': 'Batería',
          'new_inspection_pretrip_check_belts': 'Correas y mangueras',
          'new_inspection_pretrip_check_body': 'Carrocería',
          'new_inspection_pretrip_check_brake_accesories':
              'Accesorios de freno',
          'new_inspection_pretrip_check_brakes_parking':
              'Frenos de estacionamiento',
          'new_inspection_pretrip_check_brakes_service': 'Frenos de servicio',
          'new_inspection_pretrip_check_clutch': 'Embrague',
          'new_inspection_pretrip_check_coupling':
              'Dispositivos de acoplamiento',
          'new_inspection_pretrip_check_defroster': 'Descongelador/Calentador',
          'new_inspection_pretrip_check_drive': 'Línea de transmisión',
          'new_inspection_pretrip_check_engine': 'Motor',
          'new_inspection_pretrip_check_fifth': 'Quinta rueda',
          'new_inspection_pretrip_check_exhaust': 'Escape',
          'new_inspection_pretrip_check_fluid': 'Niveles de líquido',
          'new_inspection_pretrip_check_frame': 'Estructura y ensamblaje',
          'new_inspection_pretrip_check_front': 'Eje delantero',
          'new_inspection_pretrip_check_fuel': 'Tanques de combustible',
          'new_inspection_pretrip_check_generator': 'Generador',
          'new_inspection_pretrip_check_horn': 'Bocina',
          'new_inspection_pretrip_check_lights':
              'Luces\nTercera luz\nFaros\nIntermitentes',
          'new_inspection_pretrip_check_mirrors': 'Espejos',
          'new_inspection_pretrip_check_muffler': 'Silenciador',
          'new_inspection_pretrip_check_oil': 'Nivel de aceite',
          'new_inspection_pretrip_check_radiator': 'Nivel del radiador',
          'new_inspection_pretrip_check_rear': 'Parte trasera',
          'new_inspection_pretrip_check_reflectors': 'Reflectores',
          'new_inspection_pretrip_check_safety':
              'Equipo de seguridad\nExtintor de incendios\nBanderas-Bengalas-Fusibles\nTriángulos reflectantes\nBombillas y fusibles de repuesto\nFoco de sellado de repuesto',
          'new_inspection_pretrip_check_starter': 'Motor de arranque',
          'new_inspection_pretrip_check_steering': 'Dirección',
          'new_inspection_pretrip_check_suspension': 'Sistema de suspensión',
          'new_inspection_pretrip_check_tirechains': 'Cadenas de neumáticos',
          'new_inspection_pretrip_check_tires': 'Neumáticos',
          'new_inspection_pretrip_check_transmission': 'Transmisión',
          'new_inspection_pretrip_check_trip': 'Registrador de viaje',
          'new_inspection_pretrip_check_wheels': 'Ruedas y aros',
          'new_inspection_pretrip_check_windows': 'Ventanas',
          'new_inspection_pretrip_check_windshield': 'Limpiaparabrisas',
          // steperTrailers
          'new_inspection_pretrip_trailers_hint1': 'Selecciona el trailer no.1',
          'new_inspection_pretrip_trailers_validator1':
              'Por favor, selecciona el trailer no.1',
          'new_inspection_pretrip_trailers_hint2': 'Selecciona el trailer no.2',
          'new_inspection_pretrip_trailers_validator2':
              'Por favor, selecciona el trailer no.2',
          'new_inspection_pretrip_trailers_brake': 'Conexiones de Freno',
          'new_inspection_pretrip_trailers_brakes': 'Frenos',
          'new_inspection_pretrip_trailers_coupling':
              'Dispositivos de Acoplamiento',
          'new_inspection_pretrip_trailers_coupling_king':
              'Pasador de Acoplamiento (King)',
          'new_inspection_pretrip_trailers_doors': 'Puertas',
          'new_inspection_pretrip_trailers_hitch': 'Enganche',
          'new_inspection_pretrip_trailers_landing': 'Patas de Apoyo',
          'new_inspection_pretrip_trailers_lights': 'Luces - Todas',
          'new_inspection_pretrip_trailers_reflectors':
              'Reflectores/Cinta Reflectante',
          'new_inspection_pretrip_trailers_roof': 'Techo',
          'new_inspection_pretrip_trailers_suspension': 'Sistema de Suspensión',
          'new_inspection_pretrip_trailers_straps': 'Correas',
          'new_inspection_pretrip_trailers_tarpaulin': 'Lonas',
          'new_inspection_pretrip_trailers_tires': 'Neumáticos',
          'new_inspection_pretrip_trailers_wheels': 'Ruedas y Llantas',
          // steperRemarks
          'new_inspection_pretrip_remarks_msg':
              'LA CONDICIÓN DEL VEHÍCULO ANTERIOR ES SATISFACTORIA',
          'new_inspection_pretrip_remarks_sign': 'Por favor, firma en el área',
          'new_inspection_pretrip_remarks_sign_conditions':
              'Firma de condiciones',
          // steperSignature
          'new_inspection_pretrip_signature_above1':
              'DEFECTOS ANTERIORES CORREGIDOS',
          'new_inspection_pretrip_signature_above2':
              'LOS DEFECTOS ANTERIORES NO NECESITAN SER CORREGIDOS PARA EL FUNCIONAMIENTO SEGURO DEL VEHÍCULO',
          // manage_options_screen
          'options_logout': 'Cerrar sesión',
          'options_changepsw': 'Cambiar contraseña',
          'list_pdf_jsas_prev':
              'Debes conectarte a internet para poder visualizar a lista de pdf'
        }
      };
}
