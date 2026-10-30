/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : W-2024.09-SP5-3
// Date      : Fri Sep 25 21:08:48 2026
/////////////////////////////////////////////////////////////


module tool_life_monitor_top ( clk, rst_n, cycle_event, system_sel, 
        threshold_data, threshold_we, replace_ack, warning, replacement_req, 
        invalid_threshold, counter_max, selected_count, selected_threshold, 
        selected_status );
  input [3:0] cycle_event;
  input [1:0] system_sel;
  input [15:0] threshold_data;
  input [3:0] replace_ack;
  output [3:0] warning;
  output [3:0] replacement_req;
  output [3:0] invalid_threshold;
  output [3:0] counter_max;
  output [15:0] selected_count;
  output [15:0] selected_threshold;
  output [1:0] selected_status;
  input clk, rst_n, threshold_we;
  wire   n364, n365, n366, n367, n368, n369, n370, n371, n372, n373, n374,
         n375, n376, n377, n378, n379, n380, n381, n382, n383, n384, n385,
         n386, n387, n388, n389, n390, n391, n392, n393, n394, n395, n396,
         n397, n398, n399, n400, n401, n402, n403, n404, n405, n406, n407,
         n408, n409, n410, n411, n412, n413, n414, n415, n416, n417, n418,
         n419, n420, n421, n422, n423, n424, n425, n426, n427, n428, n429,
         n430, n431, n432, n433, n434, n435, n436, n437, n438, n439, n440,
         n441, n442, n443, n444, n445, n446, n447, n448, n449, n450, n451,
         n452, n453, n454, n455, n456, n457, n458, n459, n460, n461, n462,
         n463, n464, n465, n466, n467, n468, n469, n470, n471, n472, n473,
         n474, n475, n476, n477, n478, n479, n480, n481, n482, n483, n484,
         n485, n486, n487, n488, n489, n490, n491, intadd_0_CI,
         intadd_0_SUM_12_, intadd_0_SUM_11_, intadd_0_SUM_10_, intadd_0_SUM_9_,
         intadd_0_SUM_8_, intadd_0_SUM_7_, intadd_0_SUM_6_, intadd_0_SUM_5_,
         intadd_0_SUM_4_, intadd_0_SUM_3_, intadd_0_SUM_2_, intadd_0_SUM_1_,
         intadd_0_SUM_0_, intadd_0_n13, intadd_0_n12, intadd_0_n11,
         intadd_0_n10, intadd_0_n9, intadd_0_n8, intadd_0_n7, intadd_0_n6,
         intadd_0_n5, intadd_0_n4, intadd_0_n3, intadd_0_n2, intadd_0_n1,
         intadd_1_CI, intadd_1_SUM_12_, intadd_1_SUM_11_, intadd_1_SUM_10_,
         intadd_1_SUM_9_, intadd_1_SUM_8_, intadd_1_SUM_7_, intadd_1_SUM_6_,
         intadd_1_SUM_5_, intadd_1_SUM_4_, intadd_1_SUM_3_, intadd_1_SUM_2_,
         intadd_1_SUM_1_, intadd_1_SUM_0_, intadd_1_n13, intadd_1_n12,
         intadd_1_n11, intadd_1_n10, intadd_1_n9, intadd_1_n8, intadd_1_n7,
         intadd_1_n6, intadd_1_n5, intadd_1_n4, intadd_1_n3, intadd_1_n2,
         intadd_1_n1, intadd_2_CI, intadd_2_SUM_12_, intadd_2_SUM_11_,
         intadd_2_SUM_10_, intadd_2_SUM_9_, intadd_2_SUM_8_, intadd_2_SUM_7_,
         intadd_2_SUM_6_, intadd_2_SUM_5_, intadd_2_SUM_4_, intadd_2_SUM_3_,
         intadd_2_SUM_2_, intadd_2_SUM_1_, intadd_2_SUM_0_, intadd_2_n13,
         intadd_2_n12, intadd_2_n11, intadd_2_n10, intadd_2_n9, intadd_2_n8,
         intadd_2_n7, intadd_2_n6, intadd_2_n5, intadd_2_n4, intadd_2_n3,
         intadd_2_n2, intadd_2_n1, intadd_3_CI, intadd_3_SUM_12_,
         intadd_3_SUM_11_, intadd_3_SUM_10_, intadd_3_SUM_9_, intadd_3_SUM_8_,
         intadd_3_SUM_7_, intadd_3_SUM_6_, intadd_3_SUM_5_, intadd_3_SUM_4_,
         intadd_3_SUM_3_, intadd_3_SUM_2_, intadd_3_SUM_1_, intadd_3_SUM_0_,
         intadd_3_n13, intadd_3_n12, intadd_3_n11, intadd_3_n10, intadd_3_n9,
         intadd_3_n8, intadd_3_n7, intadd_3_n6, intadd_3_n5, intadd_3_n4,
         intadd_3_n3, intadd_3_n2, intadd_3_n1, n530, n531, n532, n533, n534,
         n535, n536, n537, n538, n539, n540, n541, n542, n543, n544, n545,
         n546, n547, n548, n549, n550, n551, n552, n553, n554, n555, n556,
         n557, n558, n559, n560, n561, n562, n563, n564, n565, n566, n567,
         n568, n569, n570, n571, n572, n573, n574, n575, n576, n577, n578,
         n579, n580, n581, n582, n583, n584, n585, n586, n587, n588, n589,
         n590, n591, n592, n593, n594, n595, n596, n597, n598, n599, n600,
         n601, n602, n603, n604, n605, n606, n607, n608, n609, n610, n611,
         n612, n613, n614, n615, n616, n617, n618, n619, n620, n621, n622,
         n623, n624, n625, n626, n627, n628, n629, n630, n631, n632, n633,
         n634, n635, n636, n637, n638, n639, n640, n641, n642, n643, n644,
         n645, n646, n647, n648, n649, n650, n651, n652, n653, n654, n655,
         n656, n657, n658, n659, n660, n661, n662, n663, n664, n665, n666,
         n667, n668, n669, n670, n671, n672, n673, n674, n675, n676, n677,
         n678, n679, n680, n681, n682, n683, n684, n685, n686, n687, n688,
         n689, n690, n691, n692, n693, n694, n695, n696, n697, n698, n699,
         n700, n701, n702, n703, n704, n705, n706, n707, n708, n709, n710,
         n711, n712, n713, n714, n715, n716, n717, n718, n719, n720, n721,
         n722, n723, n724, n725, n726, n727, n728, n729, n730, n731, n732,
         n733, n734, n735, n736, n737, n738, n739, n740, n741, n742, n743,
         n744, n745, n746, n747, n748, n749, n750, n751, n752, n753, n754,
         n755, n756, n757, n758, n759, n760, n761, n762, n763, n764, n765,
         n766, n767, n768, n769, n770, n771, n772, n773, n774, n775, n776,
         n777, n778, n779, n780, n781, n782, n783, n784, n785, n786, n787,
         n788, n789, n790, n791, n792, n793, n794, n795, n796, n797, n798,
         n799, n800, n801, n802, n803, n804, n805, n806, n807, n808, n809,
         n810, n811, n812, n813, n814, n815, n816, n817, n818, n819, n820,
         n821, n822, n823, n824, n825, n826, n827, n828, n829, n830, n831,
         n832, n833, n834, n835, n836, n837, n838, n839, n840, n841, n842,
         n843, n844, n845, n846, n847, n848, n849, n850, n851, n852, n853,
         n854, n855, n856, n857, n858, n859, n860, n861, n862, n863, n864,
         n865, n866, n867, n868, n869, n870, n871, n872, n873, n874, n875,
         n876, n877, n878, n879, n880, n881, n882, n883, n884, n885, n886,
         n887, n888, n889, n890, n891, n892, n893, n894, n895, n896, n897,
         n898, n899, n900, n901, n902, n903, n904, n905, n906, n907, n908,
         n909, n910, n911, n912, n913, n914, n915, n916, n917, n918, n919,
         n920, n921, n922, n923, n924, n925, n926, n927, n928, n929, n930,
         n931, n932, n933, n934, n935, n936, n937, n938, n939, n940, n941,
         n942, n943, n944, n945, n946, n947, n948, n949, n950, n951, n952,
         n953, n954, n955, n956, n957, n958, n959, n960, n961, n962, n963,
         n964, n965, n966, n967, n968, n969, n970, n971, n972, n973, n974,
         n975, n976, n977, n978, n979, n980, n981, n982, n983, n984, n985,
         n986, n987, n988, n989, n990, n991, n992, n993, n994, n995, n996,
         n997, n998, n999, n1000, n1001, n1002, n1003, n1004, n1005, n1006,
         n1007, n1008, n1009, n1010, n1011, n1012, n1013, n1014, n1015, n1016,
         n1017, n1018, n1019, n1020, n1021, n1022, n1023, n1024, n1025, n1026,
         n1027, n1028, n1029, n1030, n1031;
  wire   [63:0] count;
  wire   [63:0] threshold;

  DFFARX1_RVT u_threshold_bank_threshold_reg_3__0_ ( .D(n491), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[0]), .QN(n911) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__1_ ( .D(n490), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[1]), .QN(n927) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__2_ ( .D(n489), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[2]), .QN(n947) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__3_ ( .D(n488), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[3]), .QN(n967) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__4_ ( .D(n487), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[4]), .QN(n915) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__5_ ( .D(n486), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[5]), .QN(n931) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__6_ ( .D(n485), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[6]), .QN(n951) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__7_ ( .D(n484), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[7]), .QN(n971) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__8_ ( .D(n483), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[8]), .QN(n919) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__9_ ( .D(n482), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[9]), .QN(n935) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__10_ ( .D(n481), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[10]), .QN(n955) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__11_ ( .D(n480), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[11]), .QN(n975) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__12_ ( .D(n479), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[12]), .QN(n923) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__13_ ( .D(n478), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[13]), .QN(n939) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__14_ ( .D(n477), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[14]), .QN(n959) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_3__15_ ( .D(n476), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[15]), .QN(n979) );
  DFFARX1_RVT u_system_counter_count_reg_3__0_ ( .D(n475), .CLK(clk), .RSTB(
        rst_n), .Q(count[0]), .QN(n963) );
  DFFARX1_RVT u_system_counter_count_reg_3__15_ ( .D(n474), .CLK(clk), .RSTB(
        rst_n), .Q(count[15]), .QN(n983) );
  DFFARX1_RVT u_system_counter_count_reg_3__14_ ( .D(n473), .CLK(clk), .RSTB(
        rst_n), .Q(count[14]), .QN(n987) );
  DFFARX1_RVT u_system_counter_count_reg_3__12_ ( .D(n471), .CLK(clk), .RSTB(
        rst_n), .Q(count[12]), .QN(n993) );
  DFFARX1_RVT u_system_counter_count_reg_3__10_ ( .D(n469), .CLK(clk), .RSTB(
        rst_n), .Q(count[10]), .QN(n1005) );
  DFFARX1_RVT u_system_counter_count_reg_3__8_ ( .D(n467), .CLK(clk), .RSTB(
        rst_n), .Q(count[8]), .QN(n997) );
  DFFARX1_RVT u_system_counter_count_reg_3__6_ ( .D(n465), .CLK(clk), .RSTB(
        rst_n), .Q(count[6]), .QN(n1001) );
  DFFARX1_RVT u_system_counter_count_reg_3__2_ ( .D(n461), .CLK(clk), .RSTB(
        rst_n), .Q(count[2]), .QN(n943) );
  DFFARX1_RVT u_system_counter_count_reg_3__1_ ( .D(n460), .CLK(clk), .RSTB(
        rst_n), .Q(count[1]) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__0_ ( .D(n459), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[16]), .QN(n912) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__1_ ( .D(n458), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[17]), .QN(n928) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__2_ ( .D(n457), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[18]), .QN(n948) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__3_ ( .D(n456), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[19]), .QN(n968) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__4_ ( .D(n455), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[20]), .QN(n916) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__5_ ( .D(n454), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[21]), .QN(n932) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__6_ ( .D(n453), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[22]), .QN(n952) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__7_ ( .D(n452), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[23]), .QN(n972) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__8_ ( .D(n451), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[24]), .QN(n920) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__9_ ( .D(n450), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[25]), .QN(n936) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__10_ ( .D(n449), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[26]), .QN(n956) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__11_ ( .D(n448), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[27]), .QN(n976) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__12_ ( .D(n447), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[28]), .QN(n924) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__13_ ( .D(n446), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[29]), .QN(n940) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__14_ ( .D(n445), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[30]), .QN(n960) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_2__15_ ( .D(n444), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[31]), .QN(n980) );
  DFFARX1_RVT u_system_counter_count_reg_2__0_ ( .D(n443), .CLK(clk), .RSTB(
        rst_n), .Q(count[16]), .QN(n964) );
  DFFARX1_RVT u_system_counter_count_reg_2__15_ ( .D(n442), .CLK(clk), .RSTB(
        rst_n), .Q(count[31]), .QN(n984) );
  DFFARX1_RVT u_system_counter_count_reg_2__14_ ( .D(n441), .CLK(clk), .RSTB(
        rst_n), .Q(count[30]), .QN(n988) );
  DFFARX1_RVT u_system_counter_count_reg_2__12_ ( .D(n439), .CLK(clk), .RSTB(
        rst_n), .Q(count[28]), .QN(n995) );
  DFFARX1_RVT u_system_counter_count_reg_2__10_ ( .D(n437), .CLK(clk), .RSTB(
        rst_n), .Q(count[26]), .QN(n1007) );
  DFFARX1_RVT u_system_counter_count_reg_2__8_ ( .D(n435), .CLK(clk), .RSTB(
        rst_n), .Q(count[24]), .QN(n999) );
  DFFARX1_RVT u_system_counter_count_reg_2__6_ ( .D(n433), .CLK(clk), .RSTB(
        rst_n), .Q(count[22]), .QN(n1003) );
  DFFARX1_RVT u_system_counter_count_reg_2__2_ ( .D(n429), .CLK(clk), .RSTB(
        rst_n), .Q(count[18]), .QN(n944) );
  DFFARX1_RVT u_system_counter_count_reg_2__1_ ( .D(n428), .CLK(clk), .RSTB(
        rst_n), .Q(count[17]) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__0_ ( .D(n427), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[32]), .QN(n910) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__1_ ( .D(n426), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[33]), .QN(n926) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__2_ ( .D(n425), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[34]), .QN(n946) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__3_ ( .D(n424), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[35]), .QN(n966) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__4_ ( .D(n423), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[36]), .QN(n914) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__5_ ( .D(n422), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[37]), .QN(n930) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__6_ ( .D(n421), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[38]), .QN(n950) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__7_ ( .D(n420), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[39]), .QN(n970) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__8_ ( .D(n419), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[40]), .QN(n918) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__9_ ( .D(n418), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[41]), .QN(n934) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__10_ ( .D(n417), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[42]), .QN(n954) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__11_ ( .D(n416), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[43]), .QN(n974) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__12_ ( .D(n415), .CLK(clk), 
        .RSTB(n1030), .Q(threshold[44]), .QN(n922) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__13_ ( .D(n414), .CLK(clk), 
        .RSTB(n1029), .Q(threshold[45]), .QN(n938) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__14_ ( .D(n413), .CLK(clk), 
        .RSTB(n1029), .Q(threshold[46]), .QN(n958) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_1__15_ ( .D(n412), .CLK(clk), 
        .RSTB(n1029), .Q(threshold[47]), .QN(n977) );
  DFFARX1_RVT u_system_counter_count_reg_1__0_ ( .D(n411), .CLK(clk), .RSTB(
        n1029), .Q(count[32]), .QN(n962) );
  DFFARX1_RVT u_system_counter_count_reg_1__15_ ( .D(n410), .CLK(clk), .RSTB(
        n1029), .Q(count[47]), .QN(n982) );
  DFFARX1_RVT u_system_counter_count_reg_1__14_ ( .D(n409), .CLK(clk), .RSTB(
        n1029), .Q(count[46]), .QN(n985) );
  DFFARX1_RVT u_system_counter_count_reg_1__12_ ( .D(n407), .CLK(clk), .RSTB(
        n1029), .Q(count[44]), .QN(n996) );
  DFFARX1_RVT u_system_counter_count_reg_1__10_ ( .D(n405), .CLK(clk), .RSTB(
        n1029), .Q(count[42]), .QN(n1008) );
  DFFARX1_RVT u_system_counter_count_reg_1__8_ ( .D(n403), .CLK(clk), .RSTB(
        n1029), .Q(count[40]), .QN(n1000) );
  DFFARX1_RVT u_system_counter_count_reg_1__6_ ( .D(n401), .CLK(clk), .RSTB(
        n1029), .Q(count[38]), .QN(n1004) );
  DFFARX1_RVT u_system_counter_count_reg_1__2_ ( .D(n397), .CLK(clk), .RSTB(
        n1029), .Q(count[34]), .QN(n942) );
  DFFARX1_RVT u_system_counter_count_reg_1__1_ ( .D(n396), .CLK(clk), .RSTB(
        n1029), .Q(count[33]) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__0_ ( .D(n395), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[48]), .QN(n909) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__1_ ( .D(n394), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[49]), .QN(n925) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__2_ ( .D(n393), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[50]), .QN(n945) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__3_ ( .D(n392), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[51]), .QN(n965) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__4_ ( .D(n391), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[52]), .QN(n913) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__5_ ( .D(n390), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[53]), .QN(n929) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__6_ ( .D(n389), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[54]), .QN(n949) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__7_ ( .D(n388), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[55]), .QN(n969) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__8_ ( .D(n387), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[56]), .QN(n917) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__9_ ( .D(n386), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[57]), .QN(n933) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__10_ ( .D(n385), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[58]), .QN(n953) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__11_ ( .D(n384), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[59]), .QN(n973) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__12_ ( .D(n383), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[60]), .QN(n921) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__13_ ( .D(n382), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[61]), .QN(n937) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__14_ ( .D(n381), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[62]), .QN(n957) );
  DFFARX1_RVT u_threshold_bank_threshold_reg_0__15_ ( .D(n380), .CLK(clk), 
        .RSTB(rst_n), .Q(threshold[63]), .QN(n978) );
  DFFARX1_RVT u_system_counter_count_reg_0__0_ ( .D(n379), .CLK(clk), .RSTB(
        rst_n), .Q(count[48]), .QN(n961) );
  DFFARX1_RVT u_system_counter_count_reg_0__15_ ( .D(n378), .CLK(clk), .RSTB(
        rst_n), .Q(count[63]), .QN(n981) );
  DFFARX1_RVT u_system_counter_count_reg_0__14_ ( .D(n377), .CLK(clk), .RSTB(
        rst_n), .Q(count[62]), .QN(n986) );
  DFFARX1_RVT u_system_counter_count_reg_0__12_ ( .D(n375), .CLK(clk), .RSTB(
        rst_n), .Q(count[60]), .QN(n994) );
  DFFARX1_RVT u_system_counter_count_reg_0__10_ ( .D(n373), .CLK(clk), .RSTB(
        rst_n), .Q(count[58]), .QN(n1006) );
  DFFARX1_RVT u_system_counter_count_reg_0__8_ ( .D(n371), .CLK(clk), .RSTB(
        rst_n), .Q(count[56]), .QN(n998) );
  DFFARX1_RVT u_system_counter_count_reg_0__6_ ( .D(n369), .CLK(clk), .RSTB(
        rst_n), .Q(count[54]), .QN(n1002) );
  DFFARX1_RVT u_system_counter_count_reg_0__2_ ( .D(n365), .CLK(clk), .RSTB(
        rst_n), .Q(count[50]), .QN(n941) );
  DFFARX1_RVT u_system_counter_count_reg_0__1_ ( .D(n364), .CLK(clk), .RSTB(
        rst_n), .Q(count[49]) );
  FADDX1_RVT intadd_0_U14 ( .A(count[35]), .B(count[33]), .CI(intadd_0_CI), 
        .CO(intadd_0_n13), .S(intadd_0_SUM_0_) );
  FADDX1_RVT intadd_0_U13 ( .A(count[36]), .B(count[34]), .CI(intadd_0_n13), 
        .CO(intadd_0_n12), .S(intadd_0_SUM_1_) );
  FADDX1_RVT intadd_0_U12 ( .A(count[37]), .B(count[35]), .CI(intadd_0_n12), 
        .CO(intadd_0_n11), .S(intadd_0_SUM_2_) );
  FADDX1_RVT intadd_0_U11 ( .A(count[38]), .B(count[36]), .CI(intadd_0_n11), 
        .CO(intadd_0_n10), .S(intadd_0_SUM_3_) );
  FADDX1_RVT intadd_0_U10 ( .A(count[39]), .B(count[37]), .CI(intadd_0_n10), 
        .CO(intadd_0_n9), .S(intadd_0_SUM_4_) );
  FADDX1_RVT intadd_0_U9 ( .A(count[40]), .B(count[38]), .CI(intadd_0_n9), 
        .CO(intadd_0_n8), .S(intadd_0_SUM_5_) );
  FADDX1_RVT intadd_0_U8 ( .A(count[41]), .B(count[39]), .CI(intadd_0_n8), 
        .CO(intadd_0_n7), .S(intadd_0_SUM_6_) );
  FADDX1_RVT intadd_0_U7 ( .A(count[42]), .B(count[40]), .CI(intadd_0_n7), 
        .CO(intadd_0_n6), .S(intadd_0_SUM_7_) );
  FADDX1_RVT intadd_0_U6 ( .A(count[43]), .B(count[41]), .CI(intadd_0_n6), 
        .CO(intadd_0_n5), .S(intadd_0_SUM_8_) );
  FADDX1_RVT intadd_0_U5 ( .A(count[44]), .B(count[42]), .CI(intadd_0_n5), 
        .CO(intadd_0_n4), .S(intadd_0_SUM_9_) );
  FADDX1_RVT intadd_0_U4 ( .A(count[45]), .B(count[43]), .CI(intadd_0_n4), 
        .CO(intadd_0_n3), .S(intadd_0_SUM_10_) );
  FADDX1_RVT intadd_0_U3 ( .A(count[46]), .B(count[44]), .CI(intadd_0_n3), 
        .CO(intadd_0_n2), .S(intadd_0_SUM_11_) );
  FADDX1_RVT intadd_0_U2 ( .A(count[45]), .B(count[47]), .CI(intadd_0_n2), 
        .CO(intadd_0_n1), .S(intadd_0_SUM_12_) );
  FADDX1_RVT intadd_1_U14 ( .A(count[3]), .B(count[1]), .CI(intadd_1_CI), .CO(
        intadd_1_n13), .S(intadd_1_SUM_0_) );
  FADDX1_RVT intadd_1_U13 ( .A(count[4]), .B(count[2]), .CI(intadd_1_n13), 
        .CO(intadd_1_n12), .S(intadd_1_SUM_1_) );
  FADDX1_RVT intadd_1_U12 ( .A(count[5]), .B(count[3]), .CI(intadd_1_n12), 
        .CO(intadd_1_n11), .S(intadd_1_SUM_2_) );
  FADDX1_RVT intadd_1_U11 ( .A(count[6]), .B(count[4]), .CI(intadd_1_n11), 
        .CO(intadd_1_n10), .S(intadd_1_SUM_3_) );
  FADDX1_RVT intadd_1_U10 ( .A(count[7]), .B(count[5]), .CI(intadd_1_n10), 
        .CO(intadd_1_n9), .S(intadd_1_SUM_4_) );
  FADDX1_RVT intadd_1_U9 ( .A(count[8]), .B(count[6]), .CI(intadd_1_n9), .CO(
        intadd_1_n8), .S(intadd_1_SUM_5_) );
  FADDX1_RVT intadd_1_U8 ( .A(count[9]), .B(count[7]), .CI(intadd_1_n8), .CO(
        intadd_1_n7), .S(intadd_1_SUM_6_) );
  FADDX1_RVT intadd_1_U7 ( .A(count[10]), .B(count[8]), .CI(intadd_1_n7), .CO(
        intadd_1_n6), .S(intadd_1_SUM_7_) );
  FADDX1_RVT intadd_1_U6 ( .A(count[11]), .B(count[9]), .CI(intadd_1_n6), .CO(
        intadd_1_n5), .S(intadd_1_SUM_8_) );
  FADDX1_RVT intadd_1_U5 ( .A(count[12]), .B(count[10]), .CI(intadd_1_n5), 
        .CO(intadd_1_n4), .S(intadd_1_SUM_9_) );
  FADDX1_RVT intadd_1_U4 ( .A(count[13]), .B(count[11]), .CI(intadd_1_n4), 
        .CO(intadd_1_n3), .S(intadd_1_SUM_10_) );
  FADDX1_RVT intadd_1_U3 ( .A(count[14]), .B(count[12]), .CI(intadd_1_n3), 
        .CO(intadd_1_n2), .S(intadd_1_SUM_11_) );
  FADDX1_RVT intadd_1_U2 ( .A(count[13]), .B(count[15]), .CI(intadd_1_n2), 
        .CO(intadd_1_n1), .S(intadd_1_SUM_12_) );
  FADDX1_RVT intadd_2_U14 ( .A(count[51]), .B(count[49]), .CI(intadd_2_CI), 
        .CO(intadd_2_n13), .S(intadd_2_SUM_0_) );
  FADDX1_RVT intadd_2_U13 ( .A(count[52]), .B(count[50]), .CI(intadd_2_n13), 
        .CO(intadd_2_n12), .S(intadd_2_SUM_1_) );
  FADDX1_RVT intadd_2_U12 ( .A(count[53]), .B(count[51]), .CI(intadd_2_n12), 
        .CO(intadd_2_n11), .S(intadd_2_SUM_2_) );
  FADDX1_RVT intadd_2_U11 ( .A(count[54]), .B(count[52]), .CI(intadd_2_n11), 
        .CO(intadd_2_n10), .S(intadd_2_SUM_3_) );
  FADDX1_RVT intadd_2_U10 ( .A(count[55]), .B(count[53]), .CI(intadd_2_n10), 
        .CO(intadd_2_n9), .S(intadd_2_SUM_4_) );
  FADDX1_RVT intadd_2_U9 ( .A(count[56]), .B(count[54]), .CI(intadd_2_n9), 
        .CO(intadd_2_n8), .S(intadd_2_SUM_5_) );
  FADDX1_RVT intadd_2_U8 ( .A(count[57]), .B(count[55]), .CI(intadd_2_n8), 
        .CO(intadd_2_n7), .S(intadd_2_SUM_6_) );
  FADDX1_RVT intadd_2_U7 ( .A(count[58]), .B(count[56]), .CI(intadd_2_n7), 
        .CO(intadd_2_n6), .S(intadd_2_SUM_7_) );
  FADDX1_RVT intadd_2_U6 ( .A(count[59]), .B(count[57]), .CI(intadd_2_n6), 
        .CO(intadd_2_n5), .S(intadd_2_SUM_8_) );
  FADDX1_RVT intadd_2_U5 ( .A(count[60]), .B(count[58]), .CI(intadd_2_n5), 
        .CO(intadd_2_n4), .S(intadd_2_SUM_9_) );
  FADDX1_RVT intadd_2_U4 ( .A(count[61]), .B(count[59]), .CI(intadd_2_n4), 
        .CO(intadd_2_n3), .S(intadd_2_SUM_10_) );
  FADDX1_RVT intadd_2_U3 ( .A(count[62]), .B(count[60]), .CI(intadd_2_n3), 
        .CO(intadd_2_n2), .S(intadd_2_SUM_11_) );
  FADDX1_RVT intadd_2_U2 ( .A(count[61]), .B(count[63]), .CI(intadd_2_n2), 
        .CO(intadd_2_n1), .S(intadd_2_SUM_12_) );
  FADDX1_RVT intadd_3_U14 ( .A(count[19]), .B(count[17]), .CI(intadd_3_CI), 
        .CO(intadd_3_n13), .S(intadd_3_SUM_0_) );
  FADDX1_RVT intadd_3_U13 ( .A(count[20]), .B(count[18]), .CI(intadd_3_n13), 
        .CO(intadd_3_n12), .S(intadd_3_SUM_1_) );
  FADDX1_RVT intadd_3_U12 ( .A(count[21]), .B(count[19]), .CI(intadd_3_n12), 
        .CO(intadd_3_n11), .S(intadd_3_SUM_2_) );
  FADDX1_RVT intadd_3_U11 ( .A(count[22]), .B(count[20]), .CI(intadd_3_n11), 
        .CO(intadd_3_n10), .S(intadd_3_SUM_3_) );
  FADDX1_RVT intadd_3_U10 ( .A(count[23]), .B(count[21]), .CI(intadd_3_n10), 
        .CO(intadd_3_n9), .S(intadd_3_SUM_4_) );
  FADDX1_RVT intadd_3_U9 ( .A(count[24]), .B(count[22]), .CI(intadd_3_n9), 
        .CO(intadd_3_n8), .S(intadd_3_SUM_5_) );
  FADDX1_RVT intadd_3_U8 ( .A(count[25]), .B(count[23]), .CI(intadd_3_n8), 
        .CO(intadd_3_n7), .S(intadd_3_SUM_6_) );
  FADDX1_RVT intadd_3_U7 ( .A(count[26]), .B(count[24]), .CI(intadd_3_n7), 
        .CO(intadd_3_n6), .S(intadd_3_SUM_7_) );
  FADDX1_RVT intadd_3_U6 ( .A(count[27]), .B(count[25]), .CI(intadd_3_n6), 
        .CO(intadd_3_n5), .S(intadd_3_SUM_8_) );
  FADDX1_RVT intadd_3_U5 ( .A(count[28]), .B(count[26]), .CI(intadd_3_n5), 
        .CO(intadd_3_n4), .S(intadd_3_SUM_9_) );
  FADDX1_RVT intadd_3_U4 ( .A(count[29]), .B(count[27]), .CI(intadd_3_n4), 
        .CO(intadd_3_n3), .S(intadd_3_SUM_10_) );
  FADDX1_RVT intadd_3_U3 ( .A(count[30]), .B(count[28]), .CI(intadd_3_n3), 
        .CO(intadd_3_n2), .S(intadd_3_SUM_11_) );
  FADDX1_RVT intadd_3_U2 ( .A(count[29]), .B(count[31]), .CI(intadd_3_n2), 
        .CO(intadd_3_n1), .S(intadd_3_SUM_12_) );
  DFFARX1_RVT u_system_counter_count_reg_3__13_ ( .D(n472), .CLK(clk), .RSTB(
        rst_n), .Q(count[13]) );
  DFFARX1_RVT u_system_counter_count_reg_3__11_ ( .D(n470), .CLK(clk), .RSTB(
        rst_n), .Q(count[11]), .QN(n1009) );
  DFFARX1_RVT u_system_counter_count_reg_3__9_ ( .D(n468), .CLK(clk), .RSTB(
        rst_n), .Q(count[9]), .QN(n1013) );
  DFFARX1_RVT u_system_counter_count_reg_3__7_ ( .D(n466), .CLK(clk), .RSTB(
        rst_n), .Q(count[7]), .QN(n1021) );
  DFFARX1_RVT u_system_counter_count_reg_3__5_ ( .D(n464), .CLK(clk), .RSTB(
        rst_n), .Q(count[5]), .QN(n1017) );
  DFFARX1_RVT u_system_counter_count_reg_3__4_ ( .D(n463), .CLK(clk), .RSTB(
        rst_n), .Q(count[4]), .QN(n1025) );
  DFFARX1_RVT u_system_counter_count_reg_3__3_ ( .D(n462), .CLK(clk), .RSTB(
        rst_n), .Q(count[3]), .QN(n989) );
  DFFARX1_RVT u_system_counter_count_reg_2__13_ ( .D(n440), .CLK(clk), .RSTB(
        rst_n), .Q(count[29]) );
  DFFARX1_RVT u_system_counter_count_reg_2__11_ ( .D(n438), .CLK(clk), .RSTB(
        n1031), .Q(count[27]), .QN(n1011) );
  DFFARX1_RVT u_system_counter_count_reg_2__9_ ( .D(n436), .CLK(clk), .RSTB(
        n1031), .Q(count[25]), .QN(n1015) );
  DFFARX1_RVT u_system_counter_count_reg_2__7_ ( .D(n434), .CLK(clk), .RSTB(
        n1031), .Q(count[23]), .QN(n1023) );
  DFFARX1_RVT u_system_counter_count_reg_2__5_ ( .D(n432), .CLK(clk), .RSTB(
        n1031), .Q(count[21]), .QN(n1019) );
  DFFARX1_RVT u_system_counter_count_reg_2__4_ ( .D(n431), .CLK(clk), .RSTB(
        n1031), .Q(count[20]), .QN(n1027) );
  DFFARX1_RVT u_system_counter_count_reg_2__3_ ( .D(n430), .CLK(clk), .RSTB(
        n1031), .Q(count[19]), .QN(n991) );
  DFFARX1_RVT u_system_counter_count_reg_1__13_ ( .D(n408), .CLK(clk), .RSTB(
        n1031), .Q(count[45]) );
  DFFARX1_RVT u_system_counter_count_reg_1__11_ ( .D(n406), .CLK(clk), .RSTB(
        n1031), .Q(count[43]), .QN(n1012) );
  DFFARX1_RVT u_system_counter_count_reg_1__9_ ( .D(n404), .CLK(clk), .RSTB(
        n1031), .Q(count[41]), .QN(n1016) );
  DFFARX1_RVT u_system_counter_count_reg_1__7_ ( .D(n402), .CLK(clk), .RSTB(
        n1031), .Q(count[39]), .QN(n1024) );
  DFFARX1_RVT u_system_counter_count_reg_1__5_ ( .D(n400), .CLK(clk), .RSTB(
        n1031), .Q(count[37]), .QN(n1020) );
  DFFARX1_RVT u_system_counter_count_reg_1__4_ ( .D(n399), .CLK(clk), .RSTB(
        n1031), .Q(count[36]), .QN(n1028) );
  DFFARX1_RVT u_system_counter_count_reg_1__3_ ( .D(n398), .CLK(clk), .RSTB(
        rst_n), .Q(count[35]), .QN(n992) );
  DFFARX1_RVT u_system_counter_count_reg_0__13_ ( .D(n376), .CLK(clk), .RSTB(
        rst_n), .Q(count[61]) );
  DFFARX1_RVT u_system_counter_count_reg_0__11_ ( .D(n374), .CLK(clk), .RSTB(
        rst_n), .Q(count[59]), .QN(n1010) );
  DFFARX1_RVT u_system_counter_count_reg_0__9_ ( .D(n372), .CLK(clk), .RSTB(
        rst_n), .Q(count[57]), .QN(n1014) );
  DFFARX1_RVT u_system_counter_count_reg_0__7_ ( .D(n370), .CLK(clk), .RSTB(
        rst_n), .Q(count[55]), .QN(n1022) );
  DFFARX1_RVT u_system_counter_count_reg_0__5_ ( .D(n368), .CLK(clk), .RSTB(
        rst_n), .Q(count[53]), .QN(n1018) );
  DFFARX1_RVT u_system_counter_count_reg_0__4_ ( .D(n367), .CLK(clk), .RSTB(
        rst_n), .Q(count[52]), .QN(n1026) );
  DFFARX1_RVT u_system_counter_count_reg_0__3_ ( .D(n366), .CLK(clk), .RSTB(
        rst_n), .Q(count[51]), .QN(n990) );
  INVX0_RVT U543 ( .A(n668), .Y(n670) );
  INVX0_RVT U544 ( .A(n710), .Y(n712) );
  INVX0_RVT U545 ( .A(n731), .Y(n733) );
  INVX0_RVT U546 ( .A(n689), .Y(n691) );
  NAND2X0_RVT U547 ( .A1(n736), .A2(threshold_we), .Y(n737) );
  INVX4_RVT U548 ( .A(system_sel[1]), .Y(n735) );
  AOI22X1_RVT U549 ( .A1(count[63]), .A2(n978), .A3(count[62]), .A4(n957), .Y(
        n530) );
  AOI22X1_RVT U550 ( .A1(count[47]), .A2(n977), .A3(count[46]), .A4(n958), .Y(
        n531) );
  AOI22X1_RVT U551 ( .A1(count[15]), .A2(n979), .A3(count[14]), .A4(n959), .Y(
        n532) );
  AOI22X1_RVT U552 ( .A1(count[31]), .A2(n980), .A3(count[30]), .A4(n960), .Y(
        n533) );
  INVX0_RVT U553 ( .A(n898), .Y(n901) );
  INVX0_RVT U554 ( .A(n854), .Y(n857) );
  INVX0_RVT U555 ( .A(n805), .Y(n807) );
  INVX0_RVT U556 ( .A(n762), .Y(n764) );
  INVX0_RVT U557 ( .A(n902), .Y(n905) );
  INVX0_RVT U558 ( .A(n858), .Y(n861) );
  INVX0_RVT U559 ( .A(n815), .Y(n818) );
  INVX0_RVT U560 ( .A(n772), .Y(n775) );
  INVX0_RVT U561 ( .A(n737), .Y(n738) );
  INVX0_RVT U562 ( .A(n869), .Y(counter_max[0]) );
  NAND3X0_RVT U563 ( .A1(n531), .A2(n627), .A3(n534), .Y(n650) );
  NAND2X0_RVT U564 ( .A1(n646), .A2(n645), .Y(n534) );
  NAND3X0_RVT U565 ( .A1(n532), .A2(n599), .A3(n535), .Y(n622) );
  NAND2X0_RVT U566 ( .A1(n618), .A2(n617), .Y(n535) );
  NAND3X0_RVT U567 ( .A1(n530), .A2(n571), .A3(n536), .Y(n594) );
  NAND2X0_RVT U568 ( .A1(n590), .A2(n589), .Y(n536) );
  NAND3X0_RVT U569 ( .A1(n533), .A2(n543), .A3(n537), .Y(n566) );
  NAND2X0_RVT U570 ( .A1(n562), .A2(n561), .Y(n537) );
  AND2X1_RVT U571 ( .A1(count[50]), .A2(count[48]), .Y(intadd_2_CI) );
  NAND4X0_RVT U572 ( .A1(count[49]), .A2(count[51]), .A3(count[52]), .A4(
        intadd_2_CI), .Y(n892) );
  INVX0_RVT U573 ( .A(n892), .Y(n894) );
  NAND3X0_RVT U574 ( .A1(count[53]), .A2(count[54]), .A3(n894), .Y(n887) );
  INVX0_RVT U575 ( .A(n887), .Y(n889) );
  NAND3X0_RVT U576 ( .A1(count[56]), .A2(count[55]), .A3(n889), .Y(n882) );
  INVX0_RVT U577 ( .A(n882), .Y(n884) );
  AND3X1_RVT U578 ( .A1(count[58]), .A2(count[57]), .A3(n884), .Y(n879) );
  NAND3X0_RVT U579 ( .A1(count[60]), .A2(count[59]), .A3(n879), .Y(n870) );
  INVX0_RVT U580 ( .A(n870), .Y(n873) );
  NAND4X0_RVT U581 ( .A1(count[63]), .A2(count[62]), .A3(count[61]), .A4(n873), 
        .Y(n869) );
  AND2X1_RVT U582 ( .A1(count[34]), .A2(count[32]), .Y(intadd_0_CI) );
  NAND4X0_RVT U583 ( .A1(count[33]), .A2(count[35]), .A3(count[36]), .A4(
        intadd_0_CI), .Y(n848) );
  INVX0_RVT U584 ( .A(n848), .Y(n850) );
  NAND3X0_RVT U585 ( .A1(count[37]), .A2(count[38]), .A3(n850), .Y(n843) );
  INVX0_RVT U586 ( .A(n843), .Y(n845) );
  NAND3X0_RVT U587 ( .A1(count[40]), .A2(count[39]), .A3(n845), .Y(n838) );
  INVX0_RVT U588 ( .A(n838), .Y(n840) );
  AND3X1_RVT U589 ( .A1(count[42]), .A2(count[41]), .A3(n840), .Y(n835) );
  NAND3X0_RVT U590 ( .A1(count[44]), .A2(count[43]), .A3(n835), .Y(n826) );
  INVX0_RVT U591 ( .A(n826), .Y(n829) );
  NAND4X0_RVT U592 ( .A1(count[47]), .A2(count[46]), .A3(count[45]), .A4(n829), 
        .Y(n825) );
  INVX0_RVT U593 ( .A(n825), .Y(counter_max[1]) );
  AND2X1_RVT U594 ( .A1(count[18]), .A2(count[16]), .Y(intadd_3_CI) );
  NAND4X0_RVT U595 ( .A1(count[17]), .A2(count[19]), .A3(count[20]), .A4(
        intadd_3_CI), .Y(n805) );
  NAND3X0_RVT U596 ( .A1(count[21]), .A2(count[22]), .A3(n807), .Y(n800) );
  INVX0_RVT U597 ( .A(n800), .Y(n802) );
  NAND3X0_RVT U598 ( .A1(count[24]), .A2(count[23]), .A3(n802), .Y(n795) );
  INVX0_RVT U599 ( .A(n795), .Y(n797) );
  AND3X1_RVT U600 ( .A1(count[26]), .A2(count[25]), .A3(n797), .Y(n792) );
  NAND3X0_RVT U601 ( .A1(count[28]), .A2(count[27]), .A3(n792), .Y(n783) );
  INVX0_RVT U602 ( .A(n783), .Y(n786) );
  NAND4X0_RVT U603 ( .A1(count[31]), .A2(count[30]), .A3(count[29]), .A4(n786), 
        .Y(n782) );
  INVX0_RVT U604 ( .A(n782), .Y(counter_max[2]) );
  AND2X1_RVT U605 ( .A1(count[2]), .A2(count[0]), .Y(intadd_1_CI) );
  NAND4X0_RVT U606 ( .A1(count[1]), .A2(count[3]), .A3(count[4]), .A4(
        intadd_1_CI), .Y(n762) );
  NAND3X0_RVT U607 ( .A1(count[5]), .A2(count[6]), .A3(n764), .Y(n757) );
  INVX0_RVT U608 ( .A(n757), .Y(n759) );
  NAND3X0_RVT U609 ( .A1(count[8]), .A2(count[7]), .A3(n759), .Y(n752) );
  INVX0_RVT U610 ( .A(n752), .Y(n754) );
  AND3X1_RVT U611 ( .A1(count[10]), .A2(count[9]), .A3(n754), .Y(n749) );
  NAND3X0_RVT U612 ( .A1(count[12]), .A2(count[11]), .A3(n749), .Y(n740) );
  INVX0_RVT U613 ( .A(n740), .Y(n743) );
  NAND4X0_RVT U614 ( .A1(count[15]), .A2(count[14]), .A3(count[13]), .A4(n743), 
        .Y(n739) );
  INVX0_RVT U615 ( .A(n739), .Y(counter_max[3]) );
  NBUFFX2_RVT U616 ( .A(rst_n), .Y(n1029) );
  NBUFFX2_RVT U617 ( .A(rst_n), .Y(n1030) );
  NBUFFX2_RVT U618 ( .A(rst_n), .Y(n1031) );
  MUX41X1_RVT U619 ( .A1(count[31]), .A3(count[63]), .A2(count[15]), .A4(
        count[47]), .S0(n735), .S1(system_sel[0]), .Y(selected_count[15]) );
  MUX41X1_RVT U620 ( .A1(count[30]), .A3(count[62]), .A2(count[14]), .A4(
        count[46]), .S0(n735), .S1(system_sel[0]), .Y(selected_count[14]) );
  MUX41X1_RVT U621 ( .A1(count[29]), .A3(count[61]), .A2(count[13]), .A4(
        count[45]), .S0(n735), .S1(system_sel[0]), .Y(selected_count[13]) );
  MUX41X1_RVT U622 ( .A1(count[28]), .A3(count[60]), .A2(count[12]), .A4(
        count[44]), .S0(n735), .S1(system_sel[0]), .Y(selected_count[12]) );
  MUX41X1_RVT U623 ( .A1(count[27]), .A3(count[59]), .A2(count[11]), .A4(
        count[43]), .S0(n735), .S1(system_sel[0]), .Y(selected_count[11]) );
  MUX41X1_RVT U624 ( .A1(count[26]), .A3(count[58]), .A2(count[10]), .A4(
        count[42]), .S0(n735), .S1(system_sel[0]), .Y(selected_count[10]) );
  MUX41X1_RVT U625 ( .A1(count[25]), .A3(count[57]), .A2(count[9]), .A4(
        count[41]), .S0(n735), .S1(system_sel[0]), .Y(selected_count[9]) );
  MUX41X1_RVT U626 ( .A1(count[24]), .A3(count[56]), .A2(count[8]), .A4(
        count[40]), .S0(n735), .S1(system_sel[0]), .Y(selected_count[8]) );
  MUX41X1_RVT U627 ( .A1(count[23]), .A3(count[55]), .A2(count[7]), .A4(
        count[39]), .S0(n735), .S1(system_sel[0]), .Y(selected_count[7]) );
  MUX41X1_RVT U628 ( .A1(count[22]), .A3(count[54]), .A2(count[6]), .A4(
        count[38]), .S0(n735), .S1(system_sel[0]), .Y(selected_count[6]) );
  MUX41X1_RVT U629 ( .A1(count[21]), .A3(count[53]), .A2(count[5]), .A4(
        count[37]), .S0(n735), .S1(system_sel[0]), .Y(selected_count[5]) );
  NBUFFX2_RVT U630 ( .A(n735), .Y(n538) );
  MUX41X1_RVT U631 ( .A1(count[20]), .A3(count[52]), .A2(count[4]), .A4(
        count[36]), .S0(n538), .S1(system_sel[0]), .Y(selected_count[4]) );
  MUX41X1_RVT U632 ( .A1(count[19]), .A3(count[51]), .A2(count[3]), .A4(
        count[35]), .S0(n538), .S1(system_sel[0]), .Y(selected_count[3]) );
  MUX41X1_RVT U633 ( .A1(count[18]), .A3(count[50]), .A2(count[2]), .A4(
        count[34]), .S0(n538), .S1(system_sel[0]), .Y(selected_count[2]) );
  MUX41X1_RVT U634 ( .A1(count[17]), .A3(count[49]), .A2(count[1]), .A4(
        count[33]), .S0(n538), .S1(system_sel[0]), .Y(selected_count[1]) );
  MUX41X1_RVT U635 ( .A1(count[16]), .A3(count[48]), .A2(count[0]), .A4(
        count[32]), .S0(n538), .S1(system_sel[0]), .Y(selected_count[0]) );
  MUX41X1_RVT U636 ( .A1(threshold[31]), .A3(threshold[63]), .A2(threshold[15]), .A4(threshold[47]), .S0(n538), .S1(system_sel[0]), .Y(selected_threshold[15]) );
  MUX41X1_RVT U637 ( .A1(threshold[30]), .A3(threshold[62]), .A2(threshold[14]), .A4(threshold[46]), .S0(n538), .S1(system_sel[0]), .Y(selected_threshold[14]) );
  MUX41X1_RVT U638 ( .A1(threshold[29]), .A3(threshold[61]), .A2(threshold[13]), .A4(threshold[45]), .S0(n538), .S1(system_sel[0]), .Y(selected_threshold[13]) );
  MUX41X1_RVT U639 ( .A1(threshold[28]), .A3(threshold[60]), .A2(threshold[12]), .A4(threshold[44]), .S0(n538), .S1(system_sel[0]), .Y(selected_threshold[12]) );
  MUX41X1_RVT U640 ( .A1(threshold[27]), .A3(threshold[59]), .A2(threshold[11]), .A4(threshold[43]), .S0(n538), .S1(system_sel[0]), .Y(selected_threshold[11]) );
  MUX41X1_RVT U641 ( .A1(threshold[26]), .A3(threshold[58]), .A2(threshold[10]), .A4(threshold[42]), .S0(n538), .S1(system_sel[0]), .Y(selected_threshold[10]) );
  MUX41X1_RVT U642 ( .A1(threshold[25]), .A3(threshold[57]), .A2(threshold[9]), 
        .A4(threshold[41]), .S0(n735), .S1(system_sel[0]), .Y(
        selected_threshold[9]) );
  MUX41X1_RVT U643 ( .A1(threshold[24]), .A3(threshold[56]), .A2(threshold[8]), 
        .A4(threshold[40]), .S0(n735), .S1(system_sel[0]), .Y(
        selected_threshold[8]) );
  MUX41X1_RVT U644 ( .A1(threshold[23]), .A3(threshold[55]), .A2(threshold[7]), 
        .A4(threshold[39]), .S0(n735), .S1(system_sel[0]), .Y(
        selected_threshold[7]) );
  MUX41X1_RVT U645 ( .A1(threshold[22]), .A3(threshold[54]), .A2(threshold[6]), 
        .A4(threshold[38]), .S0(n735), .S1(system_sel[0]), .Y(
        selected_threshold[6]) );
  MUX41X1_RVT U646 ( .A1(threshold[21]), .A3(threshold[53]), .A2(threshold[5]), 
        .A4(threshold[37]), .S0(n735), .S1(system_sel[0]), .Y(
        selected_threshold[5]) );
  MUX41X1_RVT U647 ( .A1(threshold[20]), .A3(threshold[52]), .A2(threshold[4]), 
        .A4(threshold[36]), .S0(n538), .S1(system_sel[0]), .Y(
        selected_threshold[4]) );
  MUX41X1_RVT U648 ( .A1(threshold[19]), .A3(threshold[51]), .A2(threshold[3]), 
        .A4(threshold[35]), .S0(n735), .S1(system_sel[0]), .Y(
        selected_threshold[3]) );
  MUX41X1_RVT U649 ( .A1(threshold[18]), .A3(threshold[50]), .A2(threshold[2]), 
        .A4(threshold[34]), .S0(n735), .S1(system_sel[0]), .Y(
        selected_threshold[2]) );
  MUX41X1_RVT U650 ( .A1(threshold[17]), .A3(threshold[49]), .A2(threshold[1]), 
        .A4(threshold[33]), .S0(n735), .S1(system_sel[0]), .Y(
        selected_threshold[1]) );
  MUX41X1_RVT U651 ( .A1(threshold[16]), .A3(threshold[48]), .A2(threshold[0]), 
        .A4(threshold[32]), .S0(n735), .S1(system_sel[0]), .Y(
        selected_threshold[0]) );
  NAND4X0_RVT U652 ( .A1(n980), .A2(n960), .A3(n924), .A4(n940), .Y(n542) );
  NAND4X0_RVT U653 ( .A1(n976), .A2(n956), .A3(n920), .A4(n936), .Y(n541) );
  NAND4X0_RVT U654 ( .A1(n932), .A2(n916), .A3(n952), .A4(n972), .Y(n540) );
  NAND4X0_RVT U655 ( .A1(n948), .A2(n928), .A3(n912), .A4(n968), .Y(n539) );
  NOR4X1_RVT U656 ( .A1(n542), .A2(n541), .A3(n540), .A4(n539), .Y(
        invalid_threshold[2]) );
  NAND2X0_RVT U657 ( .A1(count[29]), .A2(n940), .Y(n543) );
  OA22X1_RVT U658 ( .A1(count[29]), .A2(n940), .A3(count[28]), .A4(n924), .Y(
        n562) );
  NAND2X0_RVT U659 ( .A1(count[27]), .A2(n976), .Y(n544) );
  NAND2X0_RVT U660 ( .A1(threshold[26]), .A2(n544), .Y(n545) );
  OA22X1_RVT U661 ( .A1(count[26]), .A2(n545), .A3(count[27]), .A4(n976), .Y(
        n560) );
  NAND2X0_RVT U662 ( .A1(count[25]), .A2(n936), .Y(n546) );
  NAND2X0_RVT U663 ( .A1(threshold[24]), .A2(n546), .Y(n547) );
  OA22X1_RVT U664 ( .A1(count[25]), .A2(n936), .A3(count[24]), .A4(n547), .Y(
        n558) );
  NAND2X0_RVT U665 ( .A1(threshold[16]), .A2(n964), .Y(n548) );
  AO222X1_RVT U666 ( .A1(count[17]), .A2(n928), .A3(count[17]), .A4(n548), 
        .A5(n928), .A6(n548), .Y(n549) );
  AO222X1_RVT U667 ( .A1(count[18]), .A2(n948), .A3(count[18]), .A4(n549), 
        .A5(n948), .A6(n549), .Y(n550) );
  AO222X1_RVT U668 ( .A1(count[19]), .A2(n968), .A3(count[19]), .A4(n550), 
        .A5(n968), .A6(n550), .Y(n551) );
  AO222X1_RVT U669 ( .A1(count[20]), .A2(n551), .A3(count[20]), .A4(n916), 
        .A5(n551), .A6(n916), .Y(n552) );
  AO222X1_RVT U670 ( .A1(count[21]), .A2(n552), .A3(count[21]), .A4(n932), 
        .A5(n552), .A6(n932), .Y(n553) );
  AO222X1_RVT U671 ( .A1(count[22]), .A2(n553), .A3(count[22]), .A4(n952), 
        .A5(n553), .A6(n952), .Y(n554) );
  AO222X1_RVT U672 ( .A1(count[23]), .A2(n554), .A3(count[23]), .A4(n972), 
        .A5(n554), .A6(n972), .Y(n557) );
  AO22X1_RVT U673 ( .A1(count[24]), .A2(n920), .A3(count[25]), .A4(n936), .Y(
        n556) );
  AO22X1_RVT U674 ( .A1(count[27]), .A2(n976), .A3(count[26]), .A4(n956), .Y(
        n555) );
  AO221X1_RVT U675 ( .A1(n558), .A2(n557), .A3(n558), .A4(n556), .A5(n555), 
        .Y(n559) );
  AO22X1_RVT U676 ( .A1(count[28]), .A2(n924), .A3(n560), .A4(n559), .Y(n561)
         );
  NAND2X0_RVT U677 ( .A1(threshold[31]), .A2(n984), .Y(n565) );
  NAND2X0_RVT U678 ( .A1(count[31]), .A2(n980), .Y(n563) );
  NAND3X0_RVT U679 ( .A1(threshold[30]), .A2(n563), .A3(n988), .Y(n564) );
  NAND3X0_RVT U680 ( .A1(n566), .A2(n565), .A3(n564), .Y(n669) );
  NOR2X0_RVT U681 ( .A1(invalid_threshold[2]), .A2(n669), .Y(
        replacement_req[2]) );
  NAND4X0_RVT U682 ( .A1(n978), .A2(n957), .A3(n921), .A4(n937), .Y(n570) );
  NAND4X0_RVT U683 ( .A1(n973), .A2(n953), .A3(n917), .A4(n933), .Y(n569) );
  NAND4X0_RVT U684 ( .A1(n929), .A2(n913), .A3(n949), .A4(n969), .Y(n568) );
  NAND4X0_RVT U685 ( .A1(n945), .A2(n925), .A3(n909), .A4(n965), .Y(n567) );
  NOR4X1_RVT U686 ( .A1(n570), .A2(n569), .A3(n568), .A4(n567), .Y(
        invalid_threshold[0]) );
  NAND2X0_RVT U687 ( .A1(count[61]), .A2(n937), .Y(n571) );
  OA22X1_RVT U688 ( .A1(count[61]), .A2(n937), .A3(count[60]), .A4(n921), .Y(
        n590) );
  NAND2X0_RVT U689 ( .A1(count[59]), .A2(n973), .Y(n572) );
  NAND2X0_RVT U690 ( .A1(threshold[58]), .A2(n572), .Y(n573) );
  OA22X1_RVT U691 ( .A1(count[58]), .A2(n573), .A3(count[59]), .A4(n973), .Y(
        n588) );
  NAND2X0_RVT U692 ( .A1(count[57]), .A2(n933), .Y(n574) );
  NAND2X0_RVT U693 ( .A1(threshold[56]), .A2(n574), .Y(n575) );
  OA22X1_RVT U694 ( .A1(count[57]), .A2(n933), .A3(count[56]), .A4(n575), .Y(
        n586) );
  NAND2X0_RVT U695 ( .A1(threshold[48]), .A2(n961), .Y(n576) );
  AO222X1_RVT U696 ( .A1(count[49]), .A2(n925), .A3(count[49]), .A4(n576), 
        .A5(n925), .A6(n576), .Y(n577) );
  AO222X1_RVT U697 ( .A1(count[50]), .A2(n945), .A3(count[50]), .A4(n577), 
        .A5(n945), .A6(n577), .Y(n578) );
  AO222X1_RVT U698 ( .A1(count[51]), .A2(n965), .A3(count[51]), .A4(n578), 
        .A5(n965), .A6(n578), .Y(n579) );
  AO222X1_RVT U699 ( .A1(count[52]), .A2(n579), .A3(count[52]), .A4(n913), 
        .A5(n579), .A6(n913), .Y(n580) );
  AO222X1_RVT U700 ( .A1(count[53]), .A2(n580), .A3(count[53]), .A4(n929), 
        .A5(n580), .A6(n929), .Y(n581) );
  AO222X1_RVT U701 ( .A1(count[54]), .A2(n581), .A3(count[54]), .A4(n949), 
        .A5(n581), .A6(n949), .Y(n582) );
  AO222X1_RVT U702 ( .A1(count[55]), .A2(n582), .A3(count[55]), .A4(n969), 
        .A5(n582), .A6(n969), .Y(n585) );
  AO22X1_RVT U703 ( .A1(count[56]), .A2(n917), .A3(count[57]), .A4(n933), .Y(
        n584) );
  AO22X1_RVT U704 ( .A1(count[59]), .A2(n973), .A3(count[58]), .A4(n953), .Y(
        n583) );
  AO221X1_RVT U705 ( .A1(n586), .A2(n585), .A3(n586), .A4(n584), .A5(n583), 
        .Y(n587) );
  AO22X1_RVT U706 ( .A1(count[60]), .A2(n921), .A3(n588), .A4(n587), .Y(n589)
         );
  NAND2X0_RVT U707 ( .A1(threshold[63]), .A2(n981), .Y(n593) );
  NAND2X0_RVT U708 ( .A1(count[63]), .A2(n978), .Y(n591) );
  NAND3X0_RVT U709 ( .A1(threshold[62]), .A2(n591), .A3(n986), .Y(n592) );
  NAND3X0_RVT U710 ( .A1(n594), .A2(n593), .A3(n592), .Y(n690) );
  NOR2X0_RVT U711 ( .A1(invalid_threshold[0]), .A2(n690), .Y(
        replacement_req[0]) );
  NAND4X0_RVT U712 ( .A1(n979), .A2(n959), .A3(n923), .A4(n939), .Y(n598) );
  NAND4X0_RVT U713 ( .A1(n975), .A2(n955), .A3(n919), .A4(n935), .Y(n597) );
  NAND4X0_RVT U714 ( .A1(n931), .A2(n915), .A3(n951), .A4(n971), .Y(n596) );
  NAND4X0_RVT U715 ( .A1(n947), .A2(n927), .A3(n911), .A4(n967), .Y(n595) );
  NOR4X1_RVT U716 ( .A1(n598), .A2(n597), .A3(n596), .A4(n595), .Y(
        invalid_threshold[3]) );
  NAND2X0_RVT U717 ( .A1(count[13]), .A2(n939), .Y(n599) );
  OA22X1_RVT U718 ( .A1(count[13]), .A2(n939), .A3(count[12]), .A4(n923), .Y(
        n618) );
  NAND2X0_RVT U719 ( .A1(count[11]), .A2(n975), .Y(n600) );
  NAND2X0_RVT U720 ( .A1(threshold[10]), .A2(n600), .Y(n601) );
  OA22X1_RVT U721 ( .A1(count[10]), .A2(n601), .A3(count[11]), .A4(n975), .Y(
        n616) );
  NAND2X0_RVT U722 ( .A1(count[9]), .A2(n935), .Y(n602) );
  NAND2X0_RVT U723 ( .A1(threshold[8]), .A2(n602), .Y(n603) );
  OA22X1_RVT U724 ( .A1(count[9]), .A2(n935), .A3(count[8]), .A4(n603), .Y(
        n614) );
  NAND2X0_RVT U725 ( .A1(threshold[0]), .A2(n963), .Y(n604) );
  AO222X1_RVT U726 ( .A1(count[1]), .A2(n927), .A3(count[1]), .A4(n604), .A5(
        n927), .A6(n604), .Y(n605) );
  AO222X1_RVT U727 ( .A1(count[2]), .A2(n947), .A3(count[2]), .A4(n605), .A5(
        n947), .A6(n605), .Y(n606) );
  AO222X1_RVT U728 ( .A1(count[3]), .A2(n967), .A3(count[3]), .A4(n606), .A5(
        n967), .A6(n606), .Y(n607) );
  AO222X1_RVT U729 ( .A1(count[4]), .A2(n607), .A3(count[4]), .A4(n915), .A5(
        n607), .A6(n915), .Y(n608) );
  AO222X1_RVT U730 ( .A1(count[5]), .A2(n608), .A3(count[5]), .A4(n931), .A5(
        n608), .A6(n931), .Y(n609) );
  AO222X1_RVT U731 ( .A1(count[6]), .A2(n609), .A3(count[6]), .A4(n951), .A5(
        n609), .A6(n951), .Y(n610) );
  AO222X1_RVT U732 ( .A1(count[7]), .A2(n610), .A3(count[7]), .A4(n971), .A5(
        n610), .A6(n971), .Y(n613) );
  AO22X1_RVT U733 ( .A1(count[8]), .A2(n919), .A3(count[9]), .A4(n935), .Y(
        n612) );
  AO22X1_RVT U734 ( .A1(count[11]), .A2(n975), .A3(count[10]), .A4(n955), .Y(
        n611) );
  AO221X1_RVT U735 ( .A1(n614), .A2(n613), .A3(n614), .A4(n612), .A5(n611), 
        .Y(n615) );
  AO22X1_RVT U736 ( .A1(count[12]), .A2(n923), .A3(n616), .A4(n615), .Y(n617)
         );
  NAND2X0_RVT U737 ( .A1(threshold[15]), .A2(n983), .Y(n621) );
  NAND2X0_RVT U738 ( .A1(count[15]), .A2(n979), .Y(n619) );
  NAND3X0_RVT U739 ( .A1(threshold[14]), .A2(n619), .A3(n987), .Y(n620) );
  NAND3X0_RVT U740 ( .A1(n622), .A2(n621), .A3(n620), .Y(n711) );
  NOR2X0_RVT U741 ( .A1(invalid_threshold[3]), .A2(n711), .Y(
        replacement_req[3]) );
  NAND4X0_RVT U742 ( .A1(n977), .A2(n958), .A3(n922), .A4(n938), .Y(n626) );
  NAND4X0_RVT U743 ( .A1(n974), .A2(n954), .A3(n918), .A4(n934), .Y(n625) );
  NAND4X0_RVT U744 ( .A1(n930), .A2(n914), .A3(n950), .A4(n970), .Y(n624) );
  NAND4X0_RVT U745 ( .A1(n946), .A2(n926), .A3(n910), .A4(n966), .Y(n623) );
  NOR4X1_RVT U746 ( .A1(n626), .A2(n625), .A3(n624), .A4(n623), .Y(
        invalid_threshold[1]) );
  NAND2X0_RVT U747 ( .A1(count[45]), .A2(n938), .Y(n627) );
  OA22X1_RVT U748 ( .A1(count[45]), .A2(n938), .A3(count[44]), .A4(n922), .Y(
        n646) );
  NAND2X0_RVT U749 ( .A1(count[43]), .A2(n974), .Y(n628) );
  NAND2X0_RVT U750 ( .A1(threshold[42]), .A2(n628), .Y(n629) );
  OA22X1_RVT U751 ( .A1(count[42]), .A2(n629), .A3(count[43]), .A4(n974), .Y(
        n644) );
  NAND2X0_RVT U752 ( .A1(count[41]), .A2(n934), .Y(n630) );
  NAND2X0_RVT U753 ( .A1(threshold[40]), .A2(n630), .Y(n631) );
  OA22X1_RVT U754 ( .A1(count[41]), .A2(n934), .A3(count[40]), .A4(n631), .Y(
        n642) );
  NAND2X0_RVT U755 ( .A1(threshold[32]), .A2(n962), .Y(n632) );
  AO222X1_RVT U756 ( .A1(count[33]), .A2(n926), .A3(count[33]), .A4(n632), 
        .A5(n926), .A6(n632), .Y(n633) );
  AO222X1_RVT U757 ( .A1(count[34]), .A2(n946), .A3(count[34]), .A4(n633), 
        .A5(n946), .A6(n633), .Y(n634) );
  AO222X1_RVT U758 ( .A1(count[35]), .A2(n966), .A3(count[35]), .A4(n634), 
        .A5(n966), .A6(n634), .Y(n635) );
  AO222X1_RVT U759 ( .A1(count[36]), .A2(n635), .A3(count[36]), .A4(n914), 
        .A5(n635), .A6(n914), .Y(n636) );
  AO222X1_RVT U760 ( .A1(count[37]), .A2(n636), .A3(count[37]), .A4(n930), 
        .A5(n636), .A6(n930), .Y(n637) );
  AO222X1_RVT U761 ( .A1(count[38]), .A2(n637), .A3(count[38]), .A4(n950), 
        .A5(n637), .A6(n950), .Y(n638) );
  AO222X1_RVT U762 ( .A1(count[39]), .A2(n638), .A3(count[39]), .A4(n970), 
        .A5(n638), .A6(n970), .Y(n641) );
  AO22X1_RVT U763 ( .A1(count[40]), .A2(n918), .A3(count[41]), .A4(n934), .Y(
        n640) );
  AO22X1_RVT U764 ( .A1(count[43]), .A2(n974), .A3(count[42]), .A4(n954), .Y(
        n639) );
  AO221X1_RVT U765 ( .A1(n642), .A2(n641), .A3(n642), .A4(n640), .A5(n639), 
        .Y(n643) );
  AO22X1_RVT U766 ( .A1(count[44]), .A2(n922), .A3(n644), .A4(n643), .Y(n645)
         );
  NAND2X0_RVT U767 ( .A1(threshold[47]), .A2(n982), .Y(n649) );
  NAND2X0_RVT U768 ( .A1(count[47]), .A2(n977), .Y(n647) );
  NAND3X0_RVT U769 ( .A1(threshold[46]), .A2(n647), .A3(n985), .Y(n648) );
  NAND3X0_RVT U770 ( .A1(n650), .A2(n649), .A3(n648), .Y(n732) );
  NOR2X0_RVT U771 ( .A1(invalid_threshold[1]), .A2(n732), .Y(
        replacement_req[1]) );
  MUX41X1_RVT U772 ( .A1(replacement_req[2]), .A3(replacement_req[0]), .A2(
        replacement_req[3]), .A4(replacement_req[1]), .S0(n735), .S1(
        system_sel[0]), .Y(selected_status[1]) );
  AO221X1_RVT U773 ( .A1(count[16]), .A2(n944), .A3(n964), .A4(count[18]), 
        .A5(n912), .Y(n651) );
  AO222X1_RVT U774 ( .A1(intadd_3_SUM_0_), .A2(n651), .A3(intadd_3_SUM_0_), 
        .A4(n928), .A5(n651), .A6(n928), .Y(n652) );
  AO222X1_RVT U775 ( .A1(intadd_3_SUM_1_), .A2(n652), .A3(intadd_3_SUM_1_), 
        .A4(n948), .A5(n652), .A6(n948), .Y(n653) );
  AO222X1_RVT U776 ( .A1(intadd_3_SUM_2_), .A2(n653), .A3(intadd_3_SUM_2_), 
        .A4(n968), .A5(n653), .A6(n968), .Y(n654) );
  AO222X1_RVT U777 ( .A1(intadd_3_SUM_3_), .A2(n654), .A3(intadd_3_SUM_3_), 
        .A4(n916), .A5(n654), .A6(n916), .Y(n655) );
  AO222X1_RVT U778 ( .A1(intadd_3_SUM_4_), .A2(n655), .A3(intadd_3_SUM_4_), 
        .A4(n932), .A5(n655), .A6(n932), .Y(n656) );
  AO222X1_RVT U779 ( .A1(intadd_3_SUM_5_), .A2(n656), .A3(intadd_3_SUM_5_), 
        .A4(n952), .A5(n656), .A6(n952), .Y(n657) );
  AO222X1_RVT U780 ( .A1(intadd_3_SUM_6_), .A2(n657), .A3(intadd_3_SUM_6_), 
        .A4(n972), .A5(n657), .A6(n972), .Y(n658) );
  AO222X1_RVT U781 ( .A1(intadd_3_SUM_7_), .A2(n658), .A3(intadd_3_SUM_7_), 
        .A4(n920), .A5(n658), .A6(n920), .Y(n659) );
  AO222X1_RVT U782 ( .A1(intadd_3_SUM_8_), .A2(n659), .A3(intadd_3_SUM_8_), 
        .A4(n936), .A5(n659), .A6(n936), .Y(n660) );
  AO222X1_RVT U783 ( .A1(intadd_3_SUM_9_), .A2(n660), .A3(intadd_3_SUM_9_), 
        .A4(n956), .A5(n660), .A6(n956), .Y(n661) );
  AO222X1_RVT U784 ( .A1(intadd_3_SUM_10_), .A2(n661), .A3(intadd_3_SUM_10_), 
        .A4(n976), .A5(n661), .A6(n976), .Y(n662) );
  AO222X1_RVT U785 ( .A1(intadd_3_SUM_11_), .A2(n662), .A3(intadd_3_SUM_11_), 
        .A4(n924), .A5(n662), .A6(n924), .Y(n663) );
  AO222X1_RVT U786 ( .A1(intadd_3_SUM_12_), .A2(n663), .A3(intadd_3_SUM_12_), 
        .A4(n940), .A5(n663), .A6(n940), .Y(n665) );
  NAND2X0_RVT U787 ( .A1(count[30]), .A2(intadd_3_n1), .Y(n668) );
  OA21X1_RVT U788 ( .A1(count[30]), .A2(intadd_3_n1), .A3(n668), .Y(n664) );
  AO222X1_RVT U789 ( .A1(n665), .A2(n664), .A3(n665), .A4(n960), .A5(n664), 
        .A6(n960), .Y(n667) );
  NAND2X0_RVT U790 ( .A1(n984), .A2(n668), .Y(n666) );
  AO222X1_RVT U791 ( .A1(n667), .A2(n980), .A3(n667), .A4(n666), .A5(n980), 
        .A6(n666), .Y(n671) );
  OA221X1_RVT U792 ( .A1(n671), .A2(count[31]), .A3(n671), .A4(n670), .A5(n669), .Y(warning[2]) );
  AO221X1_RVT U793 ( .A1(count[48]), .A2(n941), .A3(n961), .A4(count[50]), 
        .A5(n909), .Y(n672) );
  AO222X1_RVT U794 ( .A1(intadd_2_SUM_0_), .A2(n672), .A3(intadd_2_SUM_0_), 
        .A4(n925), .A5(n672), .A6(n925), .Y(n673) );
  AO222X1_RVT U795 ( .A1(intadd_2_SUM_1_), .A2(n673), .A3(intadd_2_SUM_1_), 
        .A4(n945), .A5(n673), .A6(n945), .Y(n674) );
  AO222X1_RVT U796 ( .A1(intadd_2_SUM_2_), .A2(n674), .A3(intadd_2_SUM_2_), 
        .A4(n965), .A5(n674), .A6(n965), .Y(n675) );
  AO222X1_RVT U797 ( .A1(intadd_2_SUM_3_), .A2(n675), .A3(intadd_2_SUM_3_), 
        .A4(n913), .A5(n675), .A6(n913), .Y(n676) );
  AO222X1_RVT U798 ( .A1(intadd_2_SUM_4_), .A2(n676), .A3(intadd_2_SUM_4_), 
        .A4(n929), .A5(n676), .A6(n929), .Y(n677) );
  AO222X1_RVT U799 ( .A1(intadd_2_SUM_5_), .A2(n677), .A3(intadd_2_SUM_5_), 
        .A4(n949), .A5(n677), .A6(n949), .Y(n678) );
  AO222X1_RVT U800 ( .A1(intadd_2_SUM_6_), .A2(n678), .A3(intadd_2_SUM_6_), 
        .A4(n969), .A5(n678), .A6(n969), .Y(n679) );
  AO222X1_RVT U801 ( .A1(intadd_2_SUM_7_), .A2(n679), .A3(intadd_2_SUM_7_), 
        .A4(n917), .A5(n679), .A6(n917), .Y(n680) );
  AO222X1_RVT U802 ( .A1(intadd_2_SUM_8_), .A2(n680), .A3(intadd_2_SUM_8_), 
        .A4(n933), .A5(n680), .A6(n933), .Y(n681) );
  AO222X1_RVT U803 ( .A1(intadd_2_SUM_9_), .A2(n681), .A3(intadd_2_SUM_9_), 
        .A4(n953), .A5(n681), .A6(n953), .Y(n682) );
  AO222X1_RVT U804 ( .A1(intadd_2_SUM_10_), .A2(n682), .A3(intadd_2_SUM_10_), 
        .A4(n973), .A5(n682), .A6(n973), .Y(n683) );
  AO222X1_RVT U805 ( .A1(intadd_2_SUM_11_), .A2(n683), .A3(intadd_2_SUM_11_), 
        .A4(n921), .A5(n683), .A6(n921), .Y(n684) );
  AO222X1_RVT U806 ( .A1(intadd_2_SUM_12_), .A2(n684), .A3(intadd_2_SUM_12_), 
        .A4(n937), .A5(n684), .A6(n937), .Y(n686) );
  NAND2X0_RVT U807 ( .A1(count[62]), .A2(intadd_2_n1), .Y(n689) );
  OA21X1_RVT U808 ( .A1(count[62]), .A2(intadd_2_n1), .A3(n689), .Y(n685) );
  AO222X1_RVT U809 ( .A1(n686), .A2(n685), .A3(n686), .A4(n957), .A5(n685), 
        .A6(n957), .Y(n688) );
  NAND2X0_RVT U810 ( .A1(n981), .A2(n689), .Y(n687) );
  AO222X1_RVT U811 ( .A1(n688), .A2(n978), .A3(n688), .A4(n687), .A5(n978), 
        .A6(n687), .Y(n692) );
  OA221X1_RVT U812 ( .A1(n692), .A2(count[63]), .A3(n692), .A4(n691), .A5(n690), .Y(warning[0]) );
  AO221X1_RVT U813 ( .A1(count[0]), .A2(n943), .A3(n963), .A4(count[2]), .A5(
        n911), .Y(n693) );
  AO222X1_RVT U814 ( .A1(intadd_1_SUM_0_), .A2(n693), .A3(intadd_1_SUM_0_), 
        .A4(n927), .A5(n693), .A6(n927), .Y(n694) );
  AO222X1_RVT U815 ( .A1(intadd_1_SUM_1_), .A2(n694), .A3(intadd_1_SUM_1_), 
        .A4(n947), .A5(n694), .A6(n947), .Y(n695) );
  AO222X1_RVT U816 ( .A1(intadd_1_SUM_2_), .A2(n695), .A3(intadd_1_SUM_2_), 
        .A4(n967), .A5(n695), .A6(n967), .Y(n696) );
  AO222X1_RVT U817 ( .A1(intadd_1_SUM_3_), .A2(n696), .A3(intadd_1_SUM_3_), 
        .A4(n915), .A5(n696), .A6(n915), .Y(n697) );
  AO222X1_RVT U818 ( .A1(intadd_1_SUM_4_), .A2(n697), .A3(intadd_1_SUM_4_), 
        .A4(n931), .A5(n697), .A6(n931), .Y(n698) );
  AO222X1_RVT U819 ( .A1(intadd_1_SUM_5_), .A2(n698), .A3(intadd_1_SUM_5_), 
        .A4(n951), .A5(n698), .A6(n951), .Y(n699) );
  AO222X1_RVT U820 ( .A1(intadd_1_SUM_6_), .A2(n699), .A3(intadd_1_SUM_6_), 
        .A4(n971), .A5(n699), .A6(n971), .Y(n700) );
  AO222X1_RVT U821 ( .A1(intadd_1_SUM_7_), .A2(n700), .A3(intadd_1_SUM_7_), 
        .A4(n919), .A5(n700), .A6(n919), .Y(n701) );
  AO222X1_RVT U822 ( .A1(intadd_1_SUM_8_), .A2(n701), .A3(intadd_1_SUM_8_), 
        .A4(n935), .A5(n701), .A6(n935), .Y(n702) );
  AO222X1_RVT U823 ( .A1(intadd_1_SUM_9_), .A2(n702), .A3(intadd_1_SUM_9_), 
        .A4(n955), .A5(n702), .A6(n955), .Y(n703) );
  AO222X1_RVT U824 ( .A1(intadd_1_SUM_10_), .A2(n703), .A3(intadd_1_SUM_10_), 
        .A4(n975), .A5(n703), .A6(n975), .Y(n704) );
  AO222X1_RVT U825 ( .A1(intadd_1_SUM_11_), .A2(n704), .A3(intadd_1_SUM_11_), 
        .A4(n923), .A5(n704), .A6(n923), .Y(n705) );
  AO222X1_RVT U826 ( .A1(intadd_1_SUM_12_), .A2(n705), .A3(intadd_1_SUM_12_), 
        .A4(n939), .A5(n705), .A6(n939), .Y(n707) );
  NAND2X0_RVT U827 ( .A1(count[14]), .A2(intadd_1_n1), .Y(n710) );
  OA21X1_RVT U828 ( .A1(count[14]), .A2(intadd_1_n1), .A3(n710), .Y(n706) );
  AO222X1_RVT U829 ( .A1(n707), .A2(n706), .A3(n707), .A4(n959), .A5(n706), 
        .A6(n959), .Y(n709) );
  NAND2X0_RVT U830 ( .A1(n983), .A2(n710), .Y(n708) );
  AO222X1_RVT U831 ( .A1(n709), .A2(n979), .A3(n709), .A4(n708), .A5(n979), 
        .A6(n708), .Y(n713) );
  OA221X1_RVT U832 ( .A1(n713), .A2(count[15]), .A3(n713), .A4(n712), .A5(n711), .Y(warning[3]) );
  AO221X1_RVT U833 ( .A1(count[32]), .A2(n942), .A3(n962), .A4(count[34]), 
        .A5(n910), .Y(n714) );
  AO222X1_RVT U834 ( .A1(intadd_0_SUM_0_), .A2(n714), .A3(intadd_0_SUM_0_), 
        .A4(n926), .A5(n714), .A6(n926), .Y(n715) );
  AO222X1_RVT U835 ( .A1(intadd_0_SUM_1_), .A2(n715), .A3(intadd_0_SUM_1_), 
        .A4(n946), .A5(n715), .A6(n946), .Y(n716) );
  AO222X1_RVT U836 ( .A1(intadd_0_SUM_2_), .A2(n716), .A3(intadd_0_SUM_2_), 
        .A4(n966), .A5(n716), .A6(n966), .Y(n717) );
  AO222X1_RVT U837 ( .A1(intadd_0_SUM_3_), .A2(n717), .A3(intadd_0_SUM_3_), 
        .A4(n914), .A5(n717), .A6(n914), .Y(n718) );
  AO222X1_RVT U838 ( .A1(intadd_0_SUM_4_), .A2(n718), .A3(intadd_0_SUM_4_), 
        .A4(n930), .A5(n718), .A6(n930), .Y(n719) );
  AO222X1_RVT U839 ( .A1(intadd_0_SUM_5_), .A2(n719), .A3(intadd_0_SUM_5_), 
        .A4(n950), .A5(n719), .A6(n950), .Y(n720) );
  AO222X1_RVT U840 ( .A1(intadd_0_SUM_6_), .A2(n720), .A3(intadd_0_SUM_6_), 
        .A4(n970), .A5(n720), .A6(n970), .Y(n721) );
  AO222X1_RVT U841 ( .A1(intadd_0_SUM_7_), .A2(n721), .A3(intadd_0_SUM_7_), 
        .A4(n918), .A5(n721), .A6(n918), .Y(n722) );
  AO222X1_RVT U842 ( .A1(intadd_0_SUM_8_), .A2(n722), .A3(intadd_0_SUM_8_), 
        .A4(n934), .A5(n722), .A6(n934), .Y(n723) );
  AO222X1_RVT U843 ( .A1(intadd_0_SUM_9_), .A2(n723), .A3(intadd_0_SUM_9_), 
        .A4(n954), .A5(n723), .A6(n954), .Y(n724) );
  AO222X1_RVT U844 ( .A1(intadd_0_SUM_10_), .A2(n724), .A3(intadd_0_SUM_10_), 
        .A4(n974), .A5(n724), .A6(n974), .Y(n725) );
  AO222X1_RVT U845 ( .A1(intadd_0_SUM_11_), .A2(n725), .A3(intadd_0_SUM_11_), 
        .A4(n922), .A5(n725), .A6(n922), .Y(n726) );
  AO222X1_RVT U846 ( .A1(intadd_0_SUM_12_), .A2(n726), .A3(intadd_0_SUM_12_), 
        .A4(n938), .A5(n726), .A6(n938), .Y(n728) );
  NAND2X0_RVT U847 ( .A1(count[46]), .A2(intadd_0_n1), .Y(n731) );
  OA21X1_RVT U848 ( .A1(count[46]), .A2(intadd_0_n1), .A3(n731), .Y(n727) );
  AO222X1_RVT U849 ( .A1(n728), .A2(n727), .A3(n728), .A4(n958), .A5(n727), 
        .A6(n958), .Y(n730) );
  NAND2X0_RVT U850 ( .A1(n982), .A2(n731), .Y(n729) );
  AO222X1_RVT U851 ( .A1(n730), .A2(n977), .A3(n730), .A4(n729), .A5(n977), 
        .A6(n729), .Y(n734) );
  OA221X1_RVT U852 ( .A1(n734), .A2(count[47]), .A3(n734), .A4(n733), .A5(n732), .Y(warning[1]) );
  MUX41X1_RVT U853 ( .A1(warning[2]), .A3(warning[0]), .A2(warning[3]), .A4(
        warning[1]), .S0(n735), .S1(system_sel[0]), .Y(selected_status[0]) );
  AND2X1_RVT U854 ( .A1(system_sel[1]), .A2(system_sel[0]), .Y(n736) );
  AO22X1_RVT U855 ( .A1(n738), .A2(threshold_data[0]), .A3(n737), .A4(
        threshold[0]), .Y(n491) );
  AO22X1_RVT U856 ( .A1(n738), .A2(threshold_data[1]), .A3(n737), .A4(
        threshold[1]), .Y(n490) );
  AO22X1_RVT U857 ( .A1(n738), .A2(threshold_data[2]), .A3(n737), .A4(
        threshold[2]), .Y(n489) );
  AO22X1_RVT U858 ( .A1(n738), .A2(threshold_data[3]), .A3(n737), .A4(
        threshold[3]), .Y(n488) );
  AO22X1_RVT U859 ( .A1(n738), .A2(threshold_data[4]), .A3(n737), .A4(
        threshold[4]), .Y(n487) );
  AO22X1_RVT U860 ( .A1(n738), .A2(threshold_data[5]), .A3(n737), .A4(
        threshold[5]), .Y(n486) );
  AO22X1_RVT U861 ( .A1(n738), .A2(threshold_data[6]), .A3(n737), .A4(
        threshold[6]), .Y(n485) );
  AO22X1_RVT U862 ( .A1(n738), .A2(threshold_data[7]), .A3(n737), .A4(
        threshold[7]), .Y(n484) );
  AO22X1_RVT U863 ( .A1(n738), .A2(threshold_data[8]), .A3(n737), .A4(
        threshold[8]), .Y(n483) );
  AO22X1_RVT U864 ( .A1(n738), .A2(threshold_data[9]), .A3(n737), .A4(
        threshold[9]), .Y(n482) );
  AO22X1_RVT U865 ( .A1(n738), .A2(threshold_data[10]), .A3(n737), .A4(
        threshold[10]), .Y(n481) );
  AO22X1_RVT U866 ( .A1(n738), .A2(threshold_data[11]), .A3(n737), .A4(
        threshold[11]), .Y(n480) );
  AO22X1_RVT U867 ( .A1(n738), .A2(threshold_data[12]), .A3(n737), .A4(
        threshold[12]), .Y(n479) );
  AO22X1_RVT U868 ( .A1(n738), .A2(threshold_data[13]), .A3(n737), .A4(
        threshold[13]), .Y(n478) );
  AO22X1_RVT U869 ( .A1(n738), .A2(threshold_data[14]), .A3(n737), .A4(
        threshold[14]), .Y(n477) );
  AO22X1_RVT U870 ( .A1(n738), .A2(threshold_data[15]), .A3(n737), .A4(
        threshold[15]), .Y(n476) );
  AO22X1_RVT U871 ( .A1(replacement_req[3]), .A2(replace_ack[3]), .A3(
        cycle_event[3]), .A4(n739), .Y(n774) );
  INVX0_RVT U872 ( .A(n774), .Y(n767) );
  NAND2X0_RVT U873 ( .A1(replacement_req[3]), .A2(replace_ack[3]), .Y(n769) );
  NAND2X0_RVT U874 ( .A1(n769), .A2(n774), .Y(n772) );
  AO22X1_RVT U875 ( .A1(count[0]), .A2(n767), .A3(n963), .A4(n775), .Y(n475)
         );
  AND3X1_RVT U876 ( .A1(count[13]), .A2(n743), .A3(n775), .Y(n741) );
  AO22X1_RVT U877 ( .A1(count[15]), .A2(n769), .A3(count[14]), .A4(n741), .Y(
        n474) );
  NOR2X0_RVT U878 ( .A1(n772), .A2(count[13]), .Y(n742) );
  AO21X1_RVT U879 ( .A1(n775), .A2(n740), .A3(n767), .Y(n744) );
  AO222X1_RVT U880 ( .A1(count[14]), .A2(n742), .A3(count[14]), .A4(n744), 
        .A5(n741), .A6(n987), .Y(n473) );
  AO22X1_RVT U881 ( .A1(count[13]), .A2(n744), .A3(n743), .A4(n742), .Y(n472)
         );
  OA21X1_RVT U882 ( .A1(n749), .A2(n772), .A3(n774), .Y(n747) );
  AO221X1_RVT U883 ( .A1(n747), .A2(count[11]), .A3(n747), .A4(n772), .A5(n993), .Y(n746) );
  NAND4X0_RVT U884 ( .A1(count[11]), .A2(n749), .A3(n775), .A4(n993), .Y(n745)
         );
  NAND2X0_RVT U885 ( .A1(n746), .A2(n745), .Y(n471) );
  INVX0_RVT U886 ( .A(n747), .Y(n748) );
  OA222X1_RVT U887 ( .A1(count[11]), .A2(n749), .A3(count[11]), .A4(n775), 
        .A5(n1009), .A6(n748), .Y(n470) );
  OA221X1_RVT U888 ( .A1(n772), .A2(n754), .A3(n772), .A4(count[9]), .A5(n774), 
        .Y(n751) );
  NAND3X0_RVT U889 ( .A1(count[9]), .A2(n754), .A3(n1005), .Y(n750) );
  OAI22X1_RVT U890 ( .A1(n751), .A2(n1005), .A3(n772), .A4(n750), .Y(n469) );
  AO21X1_RVT U891 ( .A1(n769), .A2(n752), .A3(n767), .Y(n753) );
  OA222X1_RVT U892 ( .A1(count[9]), .A2(n754), .A3(count[9]), .A4(n775), .A5(
        n1013), .A6(n753), .Y(n468) );
  OA221X1_RVT U893 ( .A1(n772), .A2(n759), .A3(n772), .A4(count[7]), .A5(n774), 
        .Y(n756) );
  NAND3X0_RVT U894 ( .A1(count[7]), .A2(n759), .A3(n997), .Y(n755) );
  OAI22X1_RVT U895 ( .A1(n756), .A2(n997), .A3(n772), .A4(n755), .Y(n467) );
  AO21X1_RVT U896 ( .A1(n769), .A2(n757), .A3(n767), .Y(n758) );
  OA222X1_RVT U897 ( .A1(count[7]), .A2(n759), .A3(count[7]), .A4(n775), .A5(
        n1021), .A6(n758), .Y(n466) );
  OA221X1_RVT U898 ( .A1(n772), .A2(n764), .A3(n772), .A4(count[5]), .A5(n774), 
        .Y(n761) );
  NAND3X0_RVT U899 ( .A1(count[5]), .A2(n764), .A3(n1001), .Y(n760) );
  OAI22X1_RVT U900 ( .A1(n761), .A2(n1001), .A3(n772), .A4(n760), .Y(n465) );
  AO21X1_RVT U901 ( .A1(n769), .A2(n762), .A3(n767), .Y(n763) );
  OA222X1_RVT U902 ( .A1(count[5]), .A2(n764), .A3(count[5]), .A4(n775), .A5(
        n1017), .A6(n763), .Y(n464) );
  AND3X1_RVT U903 ( .A1(count[1]), .A2(count[3]), .A3(intadd_1_CI), .Y(n766)
         );
  NAND2X0_RVT U904 ( .A1(count[1]), .A2(intadd_1_CI), .Y(n768) );
  AO221X1_RVT U905 ( .A1(n769), .A2(n989), .A3(n769), .A4(n768), .A5(n767), 
        .Y(n765) );
  OA222X1_RVT U906 ( .A1(count[4]), .A2(n766), .A3(count[4]), .A4(n775), .A5(
        n1025), .A6(n765), .Y(n463) );
  INVX0_RVT U907 ( .A(n768), .Y(n771) );
  AO21X1_RVT U908 ( .A1(n769), .A2(n768), .A3(n767), .Y(n770) );
  OA222X1_RVT U909 ( .A1(count[3]), .A2(n771), .A3(count[3]), .A4(n775), .A5(
        n989), .A6(n770), .Y(n462) );
  NOR2X0_RVT U910 ( .A1(n772), .A2(count[1]), .Y(n777) );
  NAND2X0_RVT U911 ( .A1(n775), .A2(n963), .Y(n773) );
  NAND2X0_RVT U912 ( .A1(n774), .A2(n773), .Y(n778) );
  AND3X1_RVT U913 ( .A1(count[1]), .A2(count[0]), .A3(n775), .Y(n776) );
  AO222X1_RVT U914 ( .A1(count[2]), .A2(n777), .A3(count[2]), .A4(n778), .A5(
        n776), .A6(n943), .Y(n461) );
  AO22X1_RVT U915 ( .A1(count[1]), .A2(n778), .A3(count[0]), .A4(n777), .Y(
        n460) );
  INVX0_RVT U916 ( .A(system_sel[0]), .Y(n865) );
  AND2X1_RVT U917 ( .A1(system_sel[1]), .A2(n865), .Y(n779) );
  NAND2X0_RVT U918 ( .A1(n779), .A2(threshold_we), .Y(n780) );
  INVX0_RVT U919 ( .A(n780), .Y(n781) );
  AO22X1_RVT U920 ( .A1(n781), .A2(threshold_data[0]), .A3(n780), .A4(
        threshold[16]), .Y(n459) );
  AO22X1_RVT U921 ( .A1(n781), .A2(threshold_data[1]), .A3(n780), .A4(
        threshold[17]), .Y(n458) );
  AO22X1_RVT U922 ( .A1(n781), .A2(threshold_data[2]), .A3(n780), .A4(
        threshold[18]), .Y(n457) );
  AO22X1_RVT U923 ( .A1(n781), .A2(threshold_data[3]), .A3(n780), .A4(
        threshold[19]), .Y(n456) );
  AO22X1_RVT U924 ( .A1(n781), .A2(threshold_data[4]), .A3(n780), .A4(
        threshold[20]), .Y(n455) );
  AO22X1_RVT U925 ( .A1(n781), .A2(threshold_data[5]), .A3(n780), .A4(
        threshold[21]), .Y(n454) );
  AO22X1_RVT U926 ( .A1(n781), .A2(threshold_data[6]), .A3(n780), .A4(
        threshold[22]), .Y(n453) );
  AO22X1_RVT U927 ( .A1(n781), .A2(threshold_data[7]), .A3(n780), .A4(
        threshold[23]), .Y(n452) );
  AO22X1_RVT U928 ( .A1(n781), .A2(threshold_data[8]), .A3(n780), .A4(
        threshold[24]), .Y(n451) );
  AO22X1_RVT U929 ( .A1(n781), .A2(threshold_data[9]), .A3(n780), .A4(
        threshold[25]), .Y(n450) );
  AO22X1_RVT U930 ( .A1(n781), .A2(threshold_data[10]), .A3(n780), .A4(
        threshold[26]), .Y(n449) );
  AO22X1_RVT U931 ( .A1(n781), .A2(threshold_data[11]), .A3(n780), .A4(
        threshold[27]), .Y(n448) );
  AO22X1_RVT U932 ( .A1(n781), .A2(threshold_data[12]), .A3(n780), .A4(
        threshold[28]), .Y(n447) );
  AO22X1_RVT U933 ( .A1(n781), .A2(threshold_data[13]), .A3(n780), .A4(
        threshold[29]), .Y(n446) );
  AO22X1_RVT U934 ( .A1(n781), .A2(threshold_data[14]), .A3(n780), .A4(
        threshold[30]), .Y(n445) );
  AO22X1_RVT U935 ( .A1(n781), .A2(threshold_data[15]), .A3(n780), .A4(
        threshold[31]), .Y(n444) );
  AO22X1_RVT U936 ( .A1(replacement_req[2]), .A2(replace_ack[2]), .A3(
        cycle_event[2]), .A4(n782), .Y(n817) );
  INVX0_RVT U937 ( .A(n817), .Y(n810) );
  NAND2X0_RVT U938 ( .A1(replacement_req[2]), .A2(replace_ack[2]), .Y(n812) );
  NAND2X0_RVT U939 ( .A1(n812), .A2(n817), .Y(n815) );
  AO22X1_RVT U940 ( .A1(count[16]), .A2(n810), .A3(n964), .A4(n818), .Y(n443)
         );
  AND3X1_RVT U941 ( .A1(count[29]), .A2(n786), .A3(n818), .Y(n784) );
  AO22X1_RVT U942 ( .A1(count[31]), .A2(n812), .A3(count[30]), .A4(n784), .Y(
        n442) );
  NOR2X0_RVT U943 ( .A1(n815), .A2(count[29]), .Y(n785) );
  AO21X1_RVT U944 ( .A1(n818), .A2(n783), .A3(n810), .Y(n787) );
  AO222X1_RVT U945 ( .A1(count[30]), .A2(n785), .A3(count[30]), .A4(n787), 
        .A5(n784), .A6(n988), .Y(n441) );
  AO22X1_RVT U946 ( .A1(count[29]), .A2(n787), .A3(n786), .A4(n785), .Y(n440)
         );
  OA21X1_RVT U947 ( .A1(n792), .A2(n815), .A3(n817), .Y(n790) );
  AO221X1_RVT U948 ( .A1(n790), .A2(count[27]), .A3(n790), .A4(n815), .A5(n995), .Y(n789) );
  NAND4X0_RVT U949 ( .A1(count[27]), .A2(n792), .A3(n818), .A4(n995), .Y(n788)
         );
  NAND2X0_RVT U950 ( .A1(n789), .A2(n788), .Y(n439) );
  INVX0_RVT U951 ( .A(n790), .Y(n791) );
  OA222X1_RVT U952 ( .A1(count[27]), .A2(n792), .A3(count[27]), .A4(n818), 
        .A5(n1011), .A6(n791), .Y(n438) );
  OA221X1_RVT U953 ( .A1(n815), .A2(n797), .A3(n815), .A4(count[25]), .A5(n817), .Y(n794) );
  NAND3X0_RVT U954 ( .A1(count[25]), .A2(n797), .A3(n1007), .Y(n793) );
  OAI22X1_RVT U955 ( .A1(n794), .A2(n1007), .A3(n815), .A4(n793), .Y(n437) );
  AO21X1_RVT U956 ( .A1(n812), .A2(n795), .A3(n810), .Y(n796) );
  OA222X1_RVT U957 ( .A1(count[25]), .A2(n797), .A3(count[25]), .A4(n818), 
        .A5(n1015), .A6(n796), .Y(n436) );
  OA221X1_RVT U958 ( .A1(n815), .A2(n802), .A3(n815), .A4(count[23]), .A5(n817), .Y(n799) );
  NAND3X0_RVT U959 ( .A1(count[23]), .A2(n802), .A3(n999), .Y(n798) );
  OAI22X1_RVT U960 ( .A1(n799), .A2(n999), .A3(n815), .A4(n798), .Y(n435) );
  AO21X1_RVT U961 ( .A1(n812), .A2(n800), .A3(n810), .Y(n801) );
  OA222X1_RVT U962 ( .A1(count[23]), .A2(n802), .A3(count[23]), .A4(n818), 
        .A5(n1023), .A6(n801), .Y(n434) );
  OA221X1_RVT U963 ( .A1(n815), .A2(n807), .A3(n815), .A4(count[21]), .A5(n817), .Y(n804) );
  NAND3X0_RVT U964 ( .A1(count[21]), .A2(n807), .A3(n1003), .Y(n803) );
  OAI22X1_RVT U965 ( .A1(n804), .A2(n1003), .A3(n815), .A4(n803), .Y(n433) );
  AO21X1_RVT U966 ( .A1(n812), .A2(n805), .A3(n810), .Y(n806) );
  OA222X1_RVT U967 ( .A1(count[21]), .A2(n807), .A3(count[21]), .A4(n818), 
        .A5(n1019), .A6(n806), .Y(n432) );
  AND3X1_RVT U968 ( .A1(count[17]), .A2(count[19]), .A3(intadd_3_CI), .Y(n809)
         );
  NAND2X0_RVT U969 ( .A1(count[17]), .A2(intadd_3_CI), .Y(n811) );
  AO221X1_RVT U970 ( .A1(n812), .A2(n991), .A3(n812), .A4(n811), .A5(n810), 
        .Y(n808) );
  OA222X1_RVT U971 ( .A1(count[20]), .A2(n809), .A3(count[20]), .A4(n818), 
        .A5(n1027), .A6(n808), .Y(n431) );
  INVX0_RVT U972 ( .A(n811), .Y(n814) );
  AO21X1_RVT U973 ( .A1(n812), .A2(n811), .A3(n810), .Y(n813) );
  OA222X1_RVT U974 ( .A1(count[19]), .A2(n814), .A3(count[19]), .A4(n818), 
        .A5(n991), .A6(n813), .Y(n430) );
  NOR2X0_RVT U975 ( .A1(n815), .A2(count[17]), .Y(n820) );
  NAND2X0_RVT U976 ( .A1(n818), .A2(n964), .Y(n816) );
  NAND2X0_RVT U977 ( .A1(n817), .A2(n816), .Y(n821) );
  AND3X1_RVT U978 ( .A1(count[17]), .A2(count[16]), .A3(n818), .Y(n819) );
  AO222X1_RVT U979 ( .A1(count[18]), .A2(n820), .A3(count[18]), .A4(n821), 
        .A5(n819), .A6(n944), .Y(n429) );
  AO22X1_RVT U980 ( .A1(count[17]), .A2(n821), .A3(count[16]), .A4(n820), .Y(
        n428) );
  AND2X1_RVT U981 ( .A1(system_sel[0]), .A2(n735), .Y(n822) );
  NAND2X0_RVT U982 ( .A1(n822), .A2(threshold_we), .Y(n823) );
  INVX0_RVT U983 ( .A(n823), .Y(n824) );
  AO22X1_RVT U984 ( .A1(n824), .A2(threshold_data[0]), .A3(n823), .A4(
        threshold[32]), .Y(n427) );
  AO22X1_RVT U985 ( .A1(n824), .A2(threshold_data[1]), .A3(n823), .A4(
        threshold[33]), .Y(n426) );
  AO22X1_RVT U986 ( .A1(n824), .A2(threshold_data[2]), .A3(n823), .A4(
        threshold[34]), .Y(n425) );
  AO22X1_RVT U987 ( .A1(n824), .A2(threshold_data[3]), .A3(n823), .A4(
        threshold[35]), .Y(n424) );
  AO22X1_RVT U988 ( .A1(n824), .A2(threshold_data[4]), .A3(n823), .A4(
        threshold[36]), .Y(n423) );
  AO22X1_RVT U989 ( .A1(n824), .A2(threshold_data[5]), .A3(n823), .A4(
        threshold[37]), .Y(n422) );
  AO22X1_RVT U990 ( .A1(n824), .A2(threshold_data[6]), .A3(n823), .A4(
        threshold[38]), .Y(n421) );
  AO22X1_RVT U991 ( .A1(n824), .A2(threshold_data[7]), .A3(n823), .A4(
        threshold[39]), .Y(n420) );
  AO22X1_RVT U992 ( .A1(n824), .A2(threshold_data[8]), .A3(n823), .A4(
        threshold[40]), .Y(n419) );
  AO22X1_RVT U993 ( .A1(n824), .A2(threshold_data[9]), .A3(n823), .A4(
        threshold[41]), .Y(n418) );
  AO22X1_RVT U994 ( .A1(n824), .A2(threshold_data[10]), .A3(n823), .A4(
        threshold[42]), .Y(n417) );
  AO22X1_RVT U995 ( .A1(n824), .A2(threshold_data[11]), .A3(n823), .A4(
        threshold[43]), .Y(n416) );
  AO22X1_RVT U996 ( .A1(n824), .A2(threshold_data[12]), .A3(n823), .A4(
        threshold[44]), .Y(n415) );
  AO22X1_RVT U997 ( .A1(n824), .A2(threshold_data[13]), .A3(n823), .A4(
        threshold[45]), .Y(n414) );
  AO22X1_RVT U998 ( .A1(n824), .A2(threshold_data[14]), .A3(n823), .A4(
        threshold[46]), .Y(n413) );
  AO22X1_RVT U999 ( .A1(n824), .A2(threshold_data[15]), .A3(n823), .A4(
        threshold[47]), .Y(n412) );
  AO22X1_RVT U1000 ( .A1(replacement_req[1]), .A2(replace_ack[1]), .A3(
        cycle_event[1]), .A4(n825), .Y(n860) );
  INVX0_RVT U1001 ( .A(n860), .Y(n853) );
  NAND2X0_RVT U1002 ( .A1(replacement_req[1]), .A2(replace_ack[1]), .Y(n855)
         );
  NAND2X0_RVT U1003 ( .A1(n855), .A2(n860), .Y(n858) );
  AO22X1_RVT U1004 ( .A1(count[32]), .A2(n853), .A3(n962), .A4(n861), .Y(n411)
         );
  AND3X1_RVT U1005 ( .A1(count[45]), .A2(n829), .A3(n861), .Y(n827) );
  AO22X1_RVT U1006 ( .A1(count[47]), .A2(n855), .A3(count[46]), .A4(n827), .Y(
        n410) );
  NOR2X0_RVT U1007 ( .A1(n858), .A2(count[45]), .Y(n828) );
  AO21X1_RVT U1008 ( .A1(n861), .A2(n826), .A3(n853), .Y(n830) );
  AO222X1_RVT U1009 ( .A1(count[46]), .A2(n828), .A3(count[46]), .A4(n830), 
        .A5(n827), .A6(n985), .Y(n409) );
  AO22X1_RVT U1010 ( .A1(count[45]), .A2(n830), .A3(n829), .A4(n828), .Y(n408)
         );
  OA21X1_RVT U1011 ( .A1(n835), .A2(n858), .A3(n860), .Y(n833) );
  AO221X1_RVT U1012 ( .A1(n833), .A2(count[43]), .A3(n833), .A4(n858), .A5(
        n996), .Y(n832) );
  NAND4X0_RVT U1013 ( .A1(count[43]), .A2(n835), .A3(n861), .A4(n996), .Y(n831) );
  NAND2X0_RVT U1014 ( .A1(n832), .A2(n831), .Y(n407) );
  INVX0_RVT U1015 ( .A(n833), .Y(n834) );
  OA222X1_RVT U1016 ( .A1(count[43]), .A2(n835), .A3(count[43]), .A4(n861), 
        .A5(n1012), .A6(n834), .Y(n406) );
  OA221X1_RVT U1017 ( .A1(n858), .A2(n840), .A3(n858), .A4(count[41]), .A5(
        n860), .Y(n837) );
  NAND3X0_RVT U1018 ( .A1(count[41]), .A2(n840), .A3(n1008), .Y(n836) );
  OAI22X1_RVT U1019 ( .A1(n837), .A2(n1008), .A3(n858), .A4(n836), .Y(n405) );
  AO21X1_RVT U1020 ( .A1(n855), .A2(n838), .A3(n853), .Y(n839) );
  OA222X1_RVT U1021 ( .A1(count[41]), .A2(n840), .A3(count[41]), .A4(n861), 
        .A5(n1016), .A6(n839), .Y(n404) );
  OA221X1_RVT U1022 ( .A1(n858), .A2(n845), .A3(n858), .A4(count[39]), .A5(
        n860), .Y(n842) );
  NAND3X0_RVT U1023 ( .A1(count[39]), .A2(n845), .A3(n1000), .Y(n841) );
  OAI22X1_RVT U1024 ( .A1(n842), .A2(n1000), .A3(n858), .A4(n841), .Y(n403) );
  AO21X1_RVT U1025 ( .A1(n855), .A2(n843), .A3(n853), .Y(n844) );
  OA222X1_RVT U1026 ( .A1(count[39]), .A2(n845), .A3(count[39]), .A4(n861), 
        .A5(n1024), .A6(n844), .Y(n402) );
  OA221X1_RVT U1027 ( .A1(n858), .A2(n850), .A3(n858), .A4(count[37]), .A5(
        n860), .Y(n847) );
  NAND3X0_RVT U1028 ( .A1(count[37]), .A2(n850), .A3(n1004), .Y(n846) );
  OAI22X1_RVT U1029 ( .A1(n847), .A2(n1004), .A3(n858), .A4(n846), .Y(n401) );
  AO21X1_RVT U1030 ( .A1(n855), .A2(n848), .A3(n853), .Y(n849) );
  OA222X1_RVT U1031 ( .A1(count[37]), .A2(n850), .A3(count[37]), .A4(n861), 
        .A5(n1020), .A6(n849), .Y(n400) );
  AND3X1_RVT U1032 ( .A1(count[33]), .A2(count[35]), .A3(intadd_0_CI), .Y(n852) );
  NAND2X0_RVT U1033 ( .A1(count[33]), .A2(intadd_0_CI), .Y(n854) );
  AO221X1_RVT U1034 ( .A1(n855), .A2(n992), .A3(n855), .A4(n854), .A5(n853), 
        .Y(n851) );
  OA222X1_RVT U1035 ( .A1(count[36]), .A2(n852), .A3(count[36]), .A4(n861), 
        .A5(n1028), .A6(n851), .Y(n399) );
  AO21X1_RVT U1036 ( .A1(n855), .A2(n854), .A3(n853), .Y(n856) );
  OA222X1_RVT U1037 ( .A1(count[35]), .A2(n857), .A3(count[35]), .A4(n861), 
        .A5(n992), .A6(n856), .Y(n398) );
  NOR2X0_RVT U1038 ( .A1(n858), .A2(count[33]), .Y(n863) );
  NAND2X0_RVT U1039 ( .A1(n861), .A2(n962), .Y(n859) );
  NAND2X0_RVT U1040 ( .A1(n860), .A2(n859), .Y(n864) );
  AND3X1_RVT U1041 ( .A1(count[33]), .A2(count[32]), .A3(n861), .Y(n862) );
  AO222X1_RVT U1042 ( .A1(count[34]), .A2(n863), .A3(count[34]), .A4(n864), 
        .A5(n862), .A6(n942), .Y(n397) );
  AO22X1_RVT U1043 ( .A1(count[33]), .A2(n864), .A3(count[32]), .A4(n863), .Y(
        n396) );
  AND2X1_RVT U1044 ( .A1(n735), .A2(n865), .Y(n866) );
  NAND2X0_RVT U1045 ( .A1(n866), .A2(threshold_we), .Y(n867) );
  INVX0_RVT U1046 ( .A(n867), .Y(n868) );
  AO22X1_RVT U1047 ( .A1(n868), .A2(threshold_data[0]), .A3(n867), .A4(
        threshold[48]), .Y(n395) );
  AO22X1_RVT U1048 ( .A1(n868), .A2(threshold_data[1]), .A3(n867), .A4(
        threshold[49]), .Y(n394) );
  AO22X1_RVT U1049 ( .A1(n868), .A2(threshold_data[2]), .A3(n867), .A4(
        threshold[50]), .Y(n393) );
  AO22X1_RVT U1050 ( .A1(n868), .A2(threshold_data[3]), .A3(n867), .A4(
        threshold[51]), .Y(n392) );
  AO22X1_RVT U1051 ( .A1(n868), .A2(threshold_data[4]), .A3(n867), .A4(
        threshold[52]), .Y(n391) );
  AO22X1_RVT U1052 ( .A1(n868), .A2(threshold_data[5]), .A3(n867), .A4(
        threshold[53]), .Y(n390) );
  AO22X1_RVT U1053 ( .A1(n868), .A2(threshold_data[6]), .A3(n867), .A4(
        threshold[54]), .Y(n389) );
  AO22X1_RVT U1054 ( .A1(n868), .A2(threshold_data[7]), .A3(n867), .A4(
        threshold[55]), .Y(n388) );
  AO22X1_RVT U1055 ( .A1(n868), .A2(threshold_data[8]), .A3(n867), .A4(
        threshold[56]), .Y(n387) );
  AO22X1_RVT U1056 ( .A1(n868), .A2(threshold_data[9]), .A3(n867), .A4(
        threshold[57]), .Y(n386) );
  AO22X1_RVT U1057 ( .A1(n868), .A2(threshold_data[10]), .A3(n867), .A4(
        threshold[58]), .Y(n385) );
  AO22X1_RVT U1058 ( .A1(n868), .A2(threshold_data[11]), .A3(n867), .A4(
        threshold[59]), .Y(n384) );
  AO22X1_RVT U1059 ( .A1(n868), .A2(threshold_data[12]), .A3(n867), .A4(
        threshold[60]), .Y(n383) );
  AO22X1_RVT U1060 ( .A1(n868), .A2(threshold_data[13]), .A3(n867), .A4(
        threshold[61]), .Y(n382) );
  AO22X1_RVT U1061 ( .A1(n868), .A2(threshold_data[14]), .A3(n867), .A4(
        threshold[62]), .Y(n381) );
  AO22X1_RVT U1062 ( .A1(n868), .A2(threshold_data[15]), .A3(n867), .A4(
        threshold[63]), .Y(n380) );
  AO22X1_RVT U1063 ( .A1(replacement_req[0]), .A2(replace_ack[0]), .A3(
        cycle_event[0]), .A4(n869), .Y(n904) );
  INVX0_RVT U1064 ( .A(n904), .Y(n897) );
  NAND2X0_RVT U1065 ( .A1(replacement_req[0]), .A2(replace_ack[0]), .Y(n899)
         );
  NAND2X0_RVT U1066 ( .A1(n899), .A2(n904), .Y(n902) );
  AO22X1_RVT U1067 ( .A1(count[48]), .A2(n897), .A3(n961), .A4(n905), .Y(n379)
         );
  AND3X1_RVT U1068 ( .A1(count[61]), .A2(n873), .A3(n905), .Y(n871) );
  AO22X1_RVT U1069 ( .A1(count[63]), .A2(n899), .A3(count[62]), .A4(n871), .Y(
        n378) );
  NOR2X0_RVT U1070 ( .A1(n902), .A2(count[61]), .Y(n872) );
  AO21X1_RVT U1071 ( .A1(n905), .A2(n870), .A3(n897), .Y(n874) );
  AO222X1_RVT U1072 ( .A1(count[62]), .A2(n872), .A3(count[62]), .A4(n874), 
        .A5(n871), .A6(n986), .Y(n377) );
  AO22X1_RVT U1073 ( .A1(count[61]), .A2(n874), .A3(n873), .A4(n872), .Y(n376)
         );
  OA21X1_RVT U1074 ( .A1(n879), .A2(n902), .A3(n904), .Y(n877) );
  AO221X1_RVT U1075 ( .A1(n877), .A2(count[59]), .A3(n877), .A4(n902), .A5(
        n994), .Y(n876) );
  NAND4X0_RVT U1076 ( .A1(count[59]), .A2(n879), .A3(n905), .A4(n994), .Y(n875) );
  NAND2X0_RVT U1077 ( .A1(n876), .A2(n875), .Y(n375) );
  INVX0_RVT U1078 ( .A(n877), .Y(n878) );
  OA222X1_RVT U1079 ( .A1(count[59]), .A2(n879), .A3(count[59]), .A4(n905), 
        .A5(n1010), .A6(n878), .Y(n374) );
  OA221X1_RVT U1080 ( .A1(n902), .A2(n884), .A3(n902), .A4(count[57]), .A5(
        n904), .Y(n881) );
  NAND3X0_RVT U1081 ( .A1(count[57]), .A2(n884), .A3(n1006), .Y(n880) );
  OAI22X1_RVT U1082 ( .A1(n881), .A2(n1006), .A3(n902), .A4(n880), .Y(n373) );
  AO21X1_RVT U1083 ( .A1(n899), .A2(n882), .A3(n897), .Y(n883) );
  OA222X1_RVT U1084 ( .A1(count[57]), .A2(n884), .A3(count[57]), .A4(n905), 
        .A5(n1014), .A6(n883), .Y(n372) );
  OA221X1_RVT U1085 ( .A1(n902), .A2(n889), .A3(n902), .A4(count[55]), .A5(
        n904), .Y(n886) );
  NAND3X0_RVT U1086 ( .A1(count[55]), .A2(n889), .A3(n998), .Y(n885) );
  OAI22X1_RVT U1087 ( .A1(n886), .A2(n998), .A3(n902), .A4(n885), .Y(n371) );
  AO21X1_RVT U1088 ( .A1(n899), .A2(n887), .A3(n897), .Y(n888) );
  OA222X1_RVT U1089 ( .A1(count[55]), .A2(n889), .A3(count[55]), .A4(n905), 
        .A5(n1022), .A6(n888), .Y(n370) );
  OA221X1_RVT U1090 ( .A1(n902), .A2(n894), .A3(n902), .A4(count[53]), .A5(
        n904), .Y(n891) );
  NAND3X0_RVT U1091 ( .A1(count[53]), .A2(n894), .A3(n1002), .Y(n890) );
  OAI22X1_RVT U1092 ( .A1(n891), .A2(n1002), .A3(n902), .A4(n890), .Y(n369) );
  AO21X1_RVT U1093 ( .A1(n899), .A2(n892), .A3(n897), .Y(n893) );
  OA222X1_RVT U1094 ( .A1(count[53]), .A2(n894), .A3(count[53]), .A4(n905), 
        .A5(n1018), .A6(n893), .Y(n368) );
  AND3X1_RVT U1095 ( .A1(count[49]), .A2(count[51]), .A3(intadd_2_CI), .Y(n896) );
  NAND2X0_RVT U1096 ( .A1(count[49]), .A2(intadd_2_CI), .Y(n898) );
  AO221X1_RVT U1097 ( .A1(n899), .A2(n990), .A3(n899), .A4(n898), .A5(n897), 
        .Y(n895) );
  OA222X1_RVT U1098 ( .A1(count[52]), .A2(n896), .A3(count[52]), .A4(n905), 
        .A5(n1026), .A6(n895), .Y(n367) );
  AO21X1_RVT U1099 ( .A1(n899), .A2(n898), .A3(n897), .Y(n900) );
  OA222X1_RVT U1100 ( .A1(count[51]), .A2(n901), .A3(count[51]), .A4(n905), 
        .A5(n990), .A6(n900), .Y(n366) );
  NOR2X0_RVT U1101 ( .A1(n902), .A2(count[49]), .Y(n907) );
  NAND2X0_RVT U1102 ( .A1(n905), .A2(n961), .Y(n903) );
  NAND2X0_RVT U1103 ( .A1(n904), .A2(n903), .Y(n908) );
  AND3X1_RVT U1104 ( .A1(count[49]), .A2(count[48]), .A3(n905), .Y(n906) );
  AO222X1_RVT U1105 ( .A1(count[50]), .A2(n907), .A3(count[50]), .A4(n908), 
        .A5(n906), .A6(n941), .Y(n365) );
  AO22X1_RVT U1106 ( .A1(count[49]), .A2(n908), .A3(count[48]), .A4(n907), .Y(
        n364) );
endmodule

