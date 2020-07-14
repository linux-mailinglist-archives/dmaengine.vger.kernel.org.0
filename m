Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5AA21ECD5
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 11:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgGNJ2H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 05:28:07 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:34030
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727104AbgGNJ2E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 05:28:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8fw2rPJ9yD7nbpuXFWGkGWYfGtf70QKNcUFpkvxTYljaDWXSMtqMvr8wojdH2Bm6gwpkZ2Vtl07cwdwUdwP9PHc96Q6LyWPOhyYFa9X/Wi5V8lo02ZjXX3NpLShvo38xlEfZAA8gcZD51wVaoeprpYOPFGuMgf6pzlvnBF6ZnBnP5AR4alZdf62fGvG/GNLVzUeMG8fG/LlO1AqQzJVRpB2+c+lq+HFy0H4jM4Ibk8V0GXRG4j1UrxnrGysROglll4mohA09ZrvJKV1OGGEDY2gKN28j5uBvDj3p38jvD0cCXBfIrPVgpzxuesdTkS2NpT2sW1mQxM3kz7C1cGbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyhlYTu0tRkFp9zbFDzlDAa/ti9lPivQitLRWGWiSXc=;
 b=VEMsyF+UruQnejNvrGiZzSO4puqxTz3tLHdbJXok//cJrQ0ZpAZKA+gitOkK9S4F78lQVyuCM/Z/LiETFYW8Ctc0JHBAN0QzkGcJI0znD6JXjLpYQDmx1e4KlINpNgoYoDB2+2aD2Dzv+tjU88Vbk+8xnPH2rqFuvWXKk/pAzpE5LWk60PLyjdjpUaV4ciYkA28vBtUp2Eh2ee3nl5CSLxv6LiBVbnc7PEXgLHWf88nIkceO6q5kvDu+GQUxwAMCem8/9BtqRBE6/vMH9vVzYekJH20dCxkRI3E7yyFmroWvW86fOFHzahFfGsJBoFg1BtFEZHpZ4KSGATXj9gidCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyhlYTu0tRkFp9zbFDzlDAa/ti9lPivQitLRWGWiSXc=;
 b=AvVcnKkUTGM+DjF7gLhpGC/CdxEbsSJrSA1CR9JD8IpYzOYW/k2xmadNoU74wSyBqXnDJiCWNM2SkWN9ZiWzLNPYK/1glhkoT2B2nBuj7DeWaMx6j/Y+uxKuchzUa2QMbEGlrUmrLhKcwScrSVJi3E6l1MWGf/eXQTKD4fndDmY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6270.eurprd04.prod.outlook.com (2603:10a6:803:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 09:27:54 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 09:27:54 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 8/9] arm64: dts: imx8qxp: add edma2
Date:   Wed, 15 Jul 2020 01:41:47 +0800
Message-Id: <1594748508-22179-9-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
References: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0092.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::18) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0092.apcprd01.prod.exchangelabs.com (2603:1096:3:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 09:27:50 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 109dc475-301d-4f2d-937e-08d827d83001
X-MS-TrafficTypeDiagnostic: VI1PR04MB6270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB62709CD632DBC8DD35EB856389610@VI1PR04MB6270.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:267;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TIsMcHhjbhBkvTO8j3TCWDCKAJgvhSiwz5wl2fVHLCEhM2NuBbKSUHcv1+Tp2hrW69KI5jehLwBKkmOa22byDy7D2sSWtiOBdMzBcgLi02J4+V5WVqHixVAx1G6McNLf4bGL8cW0j0mIyyrmzlpfBZFUXdo0C4WKyEA8m3DVk5yC1oGlIM4bJ1asYV8mkDJucJu838MnW+Q9bMoPpdMECLn7lOrANx+1iG5oLe1atObXNuDLgNrWeFxtM+Qp5Y4iW/+KDLNuxHphKLIrJdAgCqcWh6w8fHaMXXhmg2scZ7GddmN+KIhU3Mma+myIDO5qvBJ9Nq0N1AkWpyPqcMiiL0kAw72IlfTdyeRCohvrWJkMak9kcwu8DmJQnZTeSxF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66946007)(6486002)(6512007)(66476007)(66556008)(8936002)(4326008)(86362001)(2906002)(6506007)(83380400001)(478600001)(36756003)(16526019)(956004)(2616005)(186003)(6666004)(26005)(5660300002)(8676002)(52116002)(7416002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3DEcN+UJ2xnsgdgxIN6dkx3UBPsjSRgON9TsWBEj2/V6K00WCy8SQ2poHJb+qMmANPpXMk4Gw0tLUIccEBxizQr1cX6baV7Wr2KHC8jnepfawPMbR01GD0UsfNqoIxpw+x7EfL9+9ERxSS4Q3X7OPQvZ91sZynRqb2blFDlezOEIOE9lH3IgAvKUvGkIuXcAST9SehDLjqEAWOU0NpiRmNK1o9PU2JYOVPYxLkfVKqHpFA6fgRSjIAcZIpWql7+mvaq+U36eqtpFgqG7VLl5huidPsRkmAw52KEZpRi8SyJWpK4Ecd8z8ugot+753RFa4aT2jSDtdNUaulZyhdcuReC18OQMeicuE3+mC8hINOKFvon1rPO215v4QN+Gmy7+S/MqD8M5YJ7euBiOOk/QW4epvX3H3vmnEb3mKGzWVn8zI+052cOdOoK5I4KZfnxISvJxeKBBum2Kx1HsKw/DJt06yyKOmVYeit1W9UanDeg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109dc475-301d-4f2d-937e-08d827d83001
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 09:27:54.7102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuVyysExswLTOp2XxeHgYonEsFvXo1LkVRyx3o8Ejm7G617XP7RK61lv2x8ArZEpaCXn2WEb5JjbZ1qx7SsmEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

add edma2 on i.mx8qxp.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index e46faac..3f4fa59d 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -300,6 +300,44 @@
 			status = "disabled";
 		};
 
+	edma2: dma-controller@5a1f0000 {
+		compatible = "fsl,imx8qm-edma";
+		reg = <0x5a280000 0x10000>, /* channel8 UART0 rx */
+		      <0x5a290000 0x10000>, /* channel9 UART0 tx */
+		      <0x5a2a0000 0x10000>, /* channel10 UART1 rx */
+		      <0x5a2b0000 0x10000>, /* channel11 UART1 tx */
+		      <0x5a2c0000 0x10000>, /* channel12 UART2 rx */
+		      <0x5a2d0000 0x10000>, /* channel13 UART2 tx */
+		      <0x5a2e0000 0x10000>, /* channel14 UART3 rx */
+		      <0x5a2f0000 0x10000>; /* channel15 UART3 tx */
+		#dma-cells = <3>;
+		dma-channels = <8>;
+		interrupts = <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "edma2-chan8-rx", "edma2-chan9-tx",
+				  "edma2-chan10-rx", "edma2-chan11-tx",
+				  "edma2-chan12-rx", "edma2-chan13-tx",
+				  "edma2-chan14-rx", "edma2-chan15-tx";
+		power-domains = <&pd IMX_SC_R_DMA_2_CH8>,
+				<&pd IMX_SC_R_DMA_2_CH9>,
+				<&pd IMX_SC_R_DMA_2_CH10>,
+				<&pd IMX_SC_R_DMA_2_CH11>,
+				<&pd IMX_SC_R_DMA_2_CH12>,
+				<&pd IMX_SC_R_DMA_2_CH13>,
+				<&pd IMX_SC_R_DMA_2_CH14>,
+				<&pd IMX_SC_R_DMA_2_CH15>;
+		power-domain-names = "edma2-chan8", "edma2-chan9",
+				     "edma2-chan10", "edma2-chan11",
+				     "edma2-chan12", "edma2-chan13",
+				     "edma2-chan14", "edma2-chan15";
+	};
+
 		adma_i2c0: i2c@5a800000 {
 			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 			reg = <0x5a800000 0x4000>;
-- 
2.7.4

