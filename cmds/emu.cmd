require dataacquisition, 1.1.2
require mrfioc2, 2.2.0-rc5
require std        
require scanning, 2.0.8
require sscan, 1339922
require emu, develop 
require calc        
require busy
require stream,2.7.14p
require ecmc,

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES" "8000000")
epicsEnvSet("EMU_TOP", $(E3_CMD_TOP))


######### Motion  ##############
epicsEnvSet("MOT_TOP", /home/iocuser/ecmctraining/startup/ecmcProject_LEBT_EMU/)

cd $(MOT_TOP)

< start.cmd

# Brake Readback
dbLoadRecords(/epics/iocs/emu/db/brakeRB.db)


########## EVR #################
epicsEnvSet("SYS", "FEB-030Row:PBI")
epicsEnvSet("DEV", "EVR-070") 
epicsEnvSet("ESSEvtClockRate", "88.0525")

#PCIe endpoint of Timing Receiver
mrmEvrSetupPCI($(DEV), "0b:00.0")
# Enable daisy chaining the optics cable between multiple EVRs
#mrmEvrLoopback($(EVR), 1, 0)

dbLoadRecords("evr-pcie-300dc-ess.db", "EVR=$(DEV), SYS=$(SYS), D=$(DEV), FEVT=$(ESSEvtClockRate)")
var evrMrmTimeNSOverflowThreshold 100000


afterInit("dbpf $(SYS)-$(DEV):Time-I.EVNT 14")
afterInit("dbpf $(SYS)-$(DEV):Time-I.INP '@OBJ=$(DEV), Code=14'")
afterInit("dbpf $(SYS)-$(DEV):DC-Tgt-SP 70")


########## DataAcquisition ###########

var ifcdaqdrvDebug 5
epicsEnvSet("SRPV","LNS-ISRC-010:PBI-EM:CARD0:SAMPLINGRATE-RB")
epicsEnvSet(NELM, 1024)

######### Local Protection  ##############

iocshLoad("/epics/iocs/emu/plc-only.cmd")


######### Scanning #############

#Scanning macros
epicsEnvSet("SCANPREFIX_EMU_V", "LNS-ISRC-010:PBI-EMV")
epicsEnvSet("SCANPREFIX_EMU_H", "LNS-ISRC-010:PBI-EMH")
epicsEnvSet("SCAN_SLIT",        "MTR")
epicsEnvSet("SCAN_EF",          "PS")
epicsEnvSet("SCAN_POINTS_EF",   "400")
epicsEnvSet("SCAN_POINTS_SLIT", "100")

epicsEnvSet("BUFFERSIZE",     "40000")
epicsEnvSet("DAQPREFIX",      "LNS-ISRC-010")
epicsEnvSet("DAQBUFSIZE",     "1024")
epicsEnvSet("EVR_PUL0_EVENT", "14")
epicsEnvSet("MTRREC",         "LEBT-010:PBI-EMU-001:Mtr")
epicsEnvSet("TR_TL",          "SYS0-EVR0:Pul0-Ena-Sel")     # Control of daq trigger line (Enable/Disable)
epicsEnvSet("TR_TLTSEL",      "$(SYS)-$(DEV):Time-I.TIME")  

#epicsEnvSet("PSU1_SP",         "LNS-ISRC-010:PBI-EM:HVhor-SP")
epicsEnvSet("PSU1_SP",         "HV1:S")

#epicsEnvSet("PSU1_RBV",         "LNS-ISRC-010:PBI-EM:HVhor-SP")
epicsEnvSet("PSU1_RBV",         "HV1:RB")

#epicsEnvSet("PSU2_SP",         "LNS-ISRC-010:PBI-EM:HVver-SP")
epicsEnvSet("PSU2_SP",         "HV2:S")

#epicsEnvSet("PSU2_RBV",         "LNS-ISRC-010:PBI-EM:HVver-SP")
epicsEnvSet("PSU2_RBV",         "HV2:RB")



dbLoadRecords("EMU_VME.db", "DEVICE=$(SCANPREFIX_EMU_V), SCAN_SLIT=$(SCAN_SLIT), SCAN_EF=$(SCAN_EF),MTRREC=$(MTRREC), MAX_POINTS_EF=$(SCAN_POINTS_EF), MAX_POINTS_SLIT=$(SCAN_POINTS_SLIT), DAQNDSPREFIX=$(DAQPREFIX), DAQBUFSIZE=$(DAQBUFSIZE), DET1WF=PBI-EMV-FC:CurrR_Y, DET2WF=PBI-EM-HV1:VoltR_Y, DET3WF=PBI-EM-HV2:VoltR_Y, TR_TL=$(TR_TL), TR_TLTSEL=$(TR_TLTSEL), PSU_SP=$(PSU1_SP), PSU_RBV=$(PSU1_RBV), PSU2_SP=$(PSU2_SP), PSU2_RBV=$(PSU2_RBV),BUFFERSIZE=$(BUFFERSIZE)")

dbLoadRecords("EMU_VME_common.db", "DEVICE=LNS-ISRC-010:PBI-EM")

dbLoadRecords("/epics/iocs/emu/db/Sim.db", R="HV1")
dbLoadRecords("/epics/iocs/emu/db/Sim.db", R="HV2")
dbLoadRecords("/epics/iocs/emu/db/Sim.db", R="Mtr")


afterInit("dbpf $(SCANPREFIX_EMU_V):BUFF-DET1.FLNK $(SCANPREFIX_EMU_V):DET1-GUARD")
afterInit("dbpf $(SCANPREFIX_EMU_V):BUFF-DET2.FLNK $(SCANPREFIX_EMU_V):DET2-GUARD")
afterInit("dbpf $(SCANPREFIX_EMU_V):BUFF-DET3.FLNK $(SCANPREFIX_EMU_V):DET3-GUARD")
afterInit("dbpf $(DAQPREFIX):PBI-EM:CARD0-STAT-RB-V.FLNK $(SCANPREFIX_EMU_V):DAQTRG-DAQSTGUARD")

iocInit
dbpf LNS-ISRC-010:PBI-EMV:MTR.TPRO 1
< /epics/iocs/emu/init.cmd

