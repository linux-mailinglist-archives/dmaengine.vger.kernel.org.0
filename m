Return-Path: <dmaengine+bounces-115-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F40E7EB417
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 16:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613B21C20A02
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 15:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D664176E;
	Tue, 14 Nov 2023 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QMrzt4x3"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5941771;
	Tue, 14 Nov 2023 15:49:02 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434B2D43;
	Tue, 14 Nov 2023 07:49:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWIuZmiaAL1N5DnRpL/9TWobJ31NdFlq/CnOEcxyrIrdJAeZcrLvh/hTGXOOzsHeUzwDnEoRByNVagmbIDE86HYKOzK0IDuauLhFjY9n2+/z6gyaQJLaS4GtVxMtF5Npe7oKz9v8S8nVdGn6Y9w442hR4rUTlDn7yW7garPb1ZK5+26Je9J7271il2Hjyr0Zyj/W3heMnZP2Jc0nVUONb+VhuzUdDPOodKek7ADPLvmL4Vp4SzL24t+zVXQKJwrX7QCFiBDaMqnv+By8qWfpUdtlRdrKTZlqXEmB2yJrSOzKOkKZ1WJltO+Sx7UJllDxLFAQopKUzulf4HyJ+VE6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxdH3nsXBgcDAIR9AkVzdF+sl+BFzEQbk+JwUbgHX+4=;
 b=dbZk37galVTwckuhrCqTJ9PGri7Wo6RKp8u1Khk/2xXMSMYagVp0HVm07p639OfDG3IDXC0aNnIpEqxKg3swxFNo3hGHzElXFNPcaUfjT6vazH8MRJvjmFB7M7CZe5w5RntxZlR6tTjpIApSwD3j1StzTnDfrP03DOerPuYsbd4txG5yptGB2/rvk9eiKqV8Ag2s/InKmftHOURIbwHspPXmFWBuQimmqd0TPC4/nV3AOH0v2BiM6NTEWqCOfSO+qKRrgssVbx3RnmwdHvN5AQ6Qekx6GQXbsRPObdOEjblrR2J+1GsfN9Lj+w1ouxB82HUC/YNeK51XF63Petb4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxdH3nsXBgcDAIR9AkVzdF+sl+BFzEQbk+JwUbgHX+4=;
 b=QMrzt4x3BgoUBl4i0VMOjBqUwBGgU81rLBah87rn/YoJbcg3Cg0z1GxNCcBO7xG6xDhAspGY0r6prerOfQLNCIKKw90l+c0QWMpqaPjMEuwsZWHW4anDV55aK/w6HwnvA/vesybs5Cz0fM9RPU1mM48OxdjV+B94cK2+C/AXirs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 15:48:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 15:48:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org,
	shawnguo@kernel.org,
	festevam@denx.de
Cc: Frank.li@nxp.com,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: [PATCH 4/4] arm64: dts: imx93: Fix EDMA transfer failure
Date: Tue, 14 Nov 2023 10:48:24 -0500
Message-Id: <20231114154824.3617255-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114154824.3617255-1-Frank.Li@nxp.com>
References: <20231114154824.3617255-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:180::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: f261359b-e079-4001-9f4e-08dbe5293755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VbfDgHyMAXvvgC53mpAb+qdgAxRhRUeRrR2tf9LoywGhJM7YKNhd0+jpmaSdbvW6SeBLMD0/7Zk+QOw3yCJ9p8LgzkIFIvzHv+0lH3S+0Cxw1KBbY4dZe2pyHj/54pn+9T/5BN7Wh/h2P5ctQSD5bUeReFoLJYHJKKnSd/ewSC7sNcLIUdDWdNt7TnDRTv7TceWpy6h9JMZKKfWDyyGI8sDT+iOcmph/7wGTsNrtWMvBEykFSPmtWohGOE4l5nvgeQf3dFpI2KaKYfsI81ImE0AHLyKkCi2dkCau4bpg6NAVcmcq/w+k1KI+j++nxCDnHjLeH1zNjsR8b8I0vb1FN1ywGqLKkIJ2E8WQTGMIife5AkSJlM0GGeRBbuZQmRECsM8gtpchWFLCG/rik7h1ddloG2WKii+CBWut7IIzFnYiwvwOuO/spQKQVW5xRE5Z32rs5WYNYQvERV6KfgzD1CvkcEQKPI9hAXNyQ7ZVX7Er/8PsLb1oaAVmxXHt9dL9bNW4Pdrr6j6ZDw603TAhpksbwgRlRTizqd4b3Pv2mHze84ltj2xgOSEGwFpHirgNzroxRZ4GLGSonfpyWwnlbxWDdOLtFoBYAGa0mKyTKFsLAvXf90TNBVBz4CmSoNV0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(1076003)(2616005)(83380400001)(38350700005)(26005)(478600001)(52116002)(6666004)(6506007)(6512007)(6486002)(2906002)(38100700002)(8676002)(8936002)(4326008)(36756003)(41300700001)(5660300002)(86362001)(7416002)(316002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yXWRvgi3wvdL7jS7j2VDdZocD62j+PnooVIGT0pzrjb8p6t3Z27eZmlKf4Eu?=
 =?us-ascii?Q?C/jfBR1Th4gUuVshXnudGGdhgYti2VsJIbMVGDAQJWHGG1hwr67F3ivSWSp8?=
 =?us-ascii?Q?oRqRORuW11l98Zv4fNelV21ySmtwKojM4MW6zd5PULFjKQYGf6v9uS1Kbc4v?=
 =?us-ascii?Q?w9r7x1VG0+BeBoh4w83bGFssBNQrBEiU/Dv2rCtBqs7wvLgQJba/gmBaeJbC?=
 =?us-ascii?Q?YIVylqfIsp5V7J34pZUTGz4BAfPT2K0A/co/OCXvr9Nok2djSyesNyBL3Ms5?=
 =?us-ascii?Q?xjY7l0iktP+w9Dsnzfkri29VsLV8bDaXNdM91D5hRP7bFgak47p4F1wpZMPf?=
 =?us-ascii?Q?CoPDmY2WyTu+UofQzEGiyvAtUYv0wi90VkOt1pCfBWpm6FDqFN7TlDMDsr4S?=
 =?us-ascii?Q?1uB84Ebn67M2ElxfwaM3k1bCvr2hPS6iTa8Q4R0UNRW+C3JlzsoaTiXPTZyy?=
 =?us-ascii?Q?m8nhswmOM0Uq1+AwLioS09MpcqorVVONNY0Oi9pwqwrbtPuMAnx4FP5aqj+D?=
 =?us-ascii?Q?e4ZKj8zS6U6+TL+eqnmZpxmpPCkCRG61NXZqXvw9DwDLYmHCTrQQCAhox1sc?=
 =?us-ascii?Q?nN4gGlQ/7dwIUsudpXGDxKRBT/OwJS18sF++gVQAa+EfMkWRY00xjxZsJZW/?=
 =?us-ascii?Q?EK+9UlasoxOV6veZEvNU000+CGmR6lWDrQndwpbgC54rRz6SXYA96AZx8qGD?=
 =?us-ascii?Q?ystkvx+6/RXoSS8n9AwHgQR7H5XSQO8DIURLgiUe2LjiKRIgjB93wI+NLDV2?=
 =?us-ascii?Q?GBoWTlyAfkZ8vrIe128gW/lRQCT+S0aIWUEDxWei3NLR34/7k4mmAr1r1aSo?=
 =?us-ascii?Q?f4SFvW3CC4q/6vceBrPQkjMbKs/JC5sIobCtiQNxgfOXvg2ln36PuRwz6xYt?=
 =?us-ascii?Q?fEZvCk56APNYGXoM4suxMmTzPXygFHQFdH/Mn0gQ1LA/XbAyyUNf3T5Wf7vf?=
 =?us-ascii?Q?mPyVMrVShYaZRFhcwSshMGuXiJGGX8FvdJLdM+6Ks6HqOAu1czVpwxT4jonY?=
 =?us-ascii?Q?BO9sjXX4uMov7mGTnwcwJVbIRZnIsta9/VoUA0lqUYJ8ozL/g+J04RhfbQu8?=
 =?us-ascii?Q?lqaJd8ERjDLB0FQBdovXBO7SljtWsFWyksPlkYRAmPmDADQOID8eX5qkrNZE?=
 =?us-ascii?Q?9kdf8u1l5NeRscCHOrD8HoNqSKb40yt2g/mAH+ODCyirHyhmgeK4Yte9n2iH?=
 =?us-ascii?Q?/VT1pzoHLJMle9acLCJ4bTMDnuWVJOeEH+8PkgnQtaIQYntBMgLRsciDbegT?=
 =?us-ascii?Q?phsUXF7mxj0eqs0YHhVNTPPK26CkS1TiikG0cHY+dfg63VXL8d8QP/39Dw1/?=
 =?us-ascii?Q?Y5FXQW8j/j6uGVgEUs4sATBmtGDPRvCMlh6BT/5dHU2jcUETIfolGTiCyNeb?=
 =?us-ascii?Q?M2v8GdjZv6KyyDp+0UTstT8Wd1Bju9We12DILfV4okIc9iT3LRmL18qIzlcW?=
 =?us-ascii?Q?40iFOioiI8TGKs66EC5SYd/pXftWX4ypF03sLSzCEkwQzMCPFd4KegkFFima?=
 =?us-ascii?Q?H5FcP66KJJ6m+lLz3pLIr2X7xIbO+Mz2jEtVJA8RQTXI4d4HBy9ATbAteK3k?=
 =?us-ascii?Q?N+HdLfgP0t1qbY0ZtZ8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f261359b-e079-4001-9f4e-08dbe5293755
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 15:48:58.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsGD1iqtLjK5nUMDOcWdSTCjqDhbhmcOFNwCUv0uaJgPm4t+WM5q/3fxwvQW+WbI76fFAtavBC+VY1KLoid/Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113

The EDMAv4 has hardware restrictions, requiring some channels to be
allocated to ODD and others to EVEN. The previous eDMA driver did not
account for these restrictions, and it worked due to the order in dts
matching the requirements. The commit below reverts the rx/tx channel,
triggering this issue.

Adds channel requirements to the dts to instruct the driver to allocate
odd or even channels, ensuring it is not dependent on the order of rx/tx in
dts.

Fixes: a725990557e7 ("arm64: dts: imx93: Fix the dmas entries order")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index ceccf47664407..6f06ebdcb2513 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx93-clock.h>
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -670,7 +671,8 @@ lpuart3: serial@42570000 {
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma2 18 0 1>, <&edma2 17 0 0>;
+				dmas = <&edma2 18 0 (FSL_EDMA_RX | FSL_EDMA_ODD_CH)>,
+				       <&edma2 17 0 FSL_EDMA_EVEN_CH>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -681,7 +683,8 @@ lpuart4: serial@42580000 {
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma2 20 0 1>, <&edma2 19 0 0>;
+				dmas = <&edma2 20 0 (FSL_EDMA_RX | FSL_EDMA_ODD_CH)>,
+				       <&edma2 19 0 FSL_EDMA_EVEN_CH>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -692,7 +695,8 @@ lpuart5: serial@42590000 {
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma2 22 0 1>, <&edma2 21 0 0>;
+				dmas = <&edma2 22 0 (FSL_EDMA_RX | FSL_EDMA_ODD_CH)>,
+				       <&edma2 21 0 FSL_EDMA_EVEN_CH>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -703,7 +707,8 @@ lpuart6: serial@425a0000 {
 				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma2 24 0 1>, <&edma2 23 0 0>;
+				dmas = <&edma2 24 0 (FSL_EDMA_RX | FSL_EDMA_ODD_CH)>,
+				       <&edma2 23 0 FSL_EDMA_EVEN_CH>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
-- 
2.34.1


