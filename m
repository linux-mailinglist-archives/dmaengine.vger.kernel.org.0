Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075D7211C42
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 08:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGBGy3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 02:54:29 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:12347
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbgGBGyY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 02:54:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEuXRCCB8RWSRNn0kW9ZIkw8eUW+bmxXEbSNjwouIc6As/QtWQCw/NzaAZDGY3D3qZwMcSNQFGrwz+f8aO8YgZdamg2A49vMSVG6L1q2hRx5lDXEjM8VFkftrqcJIWrtgHoMHBnAsoya+CblkM53O3GX4NI4+CNyjWuJDjGJGAw9ypP7J1HhwtxMDDLCeRkmZDigsjh/Q/TxSyA7pIYUKLQxSsyG5YV31BfXo/X9uW9LSzP0BYeFZISAhd8bCN5bge+CGakMtwNpDf9OoIRhOu9suQ6opA39k8NniPAqN1NHyv9iXe6qKdL9uCLscWeTSYiM2aIfYst678VODeymQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyhlYTu0tRkFp9zbFDzlDAa/ti9lPivQitLRWGWiSXc=;
 b=SaGmiv9jV/1eNQWU2I/1riBrA2vJXNONtCF3k8AwSBgZwCYOhd2WfowpBosNZZcsiFaBerBVkWr77XSuG+CKymEYwnko89dNwN/QfgPwvPkNdo92fVZZmpqjd7fS0hlunLh6aZ6+2Gg5s2joccCScoQZ7yupOWYMSUCAmm07JeNhP1nmDqG4EY5aGibvUdD9SjIOMa6uaZAsB3Xt5IaSS7JJs/v7JwCE3QmVaxhWFBS4cSXLBVdc6mASFfK3UEmyfRF2vWZp4y6y38Uzh/TOAZ3VKcj0x3Dt/dOUZoxEauqXzBjP3QGGcrTZl5QCGNIaECkYb8tknBfIMVbxJPBCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyhlYTu0tRkFp9zbFDzlDAa/ti9lPivQitLRWGWiSXc=;
 b=c2RO14Eqjk9mJyhYg+SjStE38da4Ysrh9hzP65Jx/P2Y/RKDvs1dTj2Zw3tF9e55WysqfCQ2cM9I7/yXbV+SaP1qNjM779N3h3jAO13WeU/ZxdPWUo1GVlhYLgDr61nLGAc0vDNzME6Xydls5y64GERoYcpMew9TrISSH1CDPEE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 06:54:16 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.024; Thu, 2 Jul 2020
 06:54:16 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 8/9] arm64: dts: imx8qxp: add edma2
Date:   Thu,  2 Jul 2020 23:08:08 +0800
Message-Id: <1593702489-21648-9-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
References: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0172.apcprd01.prod.exchangelabs.com (2603:1096:4:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 06:54:11 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a2f73a6-895a-42b6-60e3-08d81e54bc3f
X-MS-TrafficTypeDiagnostic: VI1PR04MB6943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB694322A54EB67FE0E0F835E6896D0@VI1PR04MB6943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:267;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+juFg+izG+CX7ilyzkPt8gVpGSu7TENJEd8Bd1IQNUViFc0GNEkTKpUezjdmJiPb7L/BBUhf6azt65NK3Df0f7+wv+QYzmMokkHY+QY7dHhnyui0i2+K8vBMFu95LqJ/M8YSIKppkFz+/n7xScAHPe2DgEiMzt0scfZiH52z1fzcIpM0cqRTnlh7M9FsMJlOnWphF+oAI8WUGuQpzG/QUgPt41N2ExKwAt8I73khYK2iw6QjrX+NYeJNyoJW4e7Jc6RCPzrSxxJ9ogwqX07hss3vhx3Xxo42D/EYuTJByCXtfWGf04Nib2XO+EtE8NKhjRYZf7Xkv5atBO2m2C8tPexOnDeVoaDAsA+BFmOPOn8xKMBXnKq3ohSKMYqeo7O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(83380400001)(66476007)(6666004)(66946007)(66556008)(52116002)(36756003)(8936002)(2616005)(6486002)(956004)(6512007)(186003)(7416002)(4326008)(26005)(2906002)(8676002)(86362001)(16526019)(478600001)(6506007)(5660300002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: G7GYLlKgQcy3Z7MDWvnZRXSfbhL9yvpIXc6zkoLGZJQyZ2CS33bL5Tg6iF75kZedpqa7VWaT54DDh5Sz6Flw3fTLLFPL+fMME8mogweC7MZj/QHYGeigQ2I20RhsGzvpljkfjILB+SnFDNdL6lMWIJ3fvUasrmcn5WkpuDpkZJT/A00S3uLKJP7i7lmn2Sr7VTgOoqDI/ja8wCiyS3RdqAXbmC05GwIF6/OXN6XK+vGCZBhF+SL+W3pnbu+wK+MXIbloC1VK1CsHHQBOqX8QorbRJDV8rbiaUU1DIdlhWwG4lnrjgKz2zZoLDmY9/sHgo+wJfhz+b+WMWraXmf/ebyrXWGMBSDB7QLdSanoG8TY1cxXjkkhWY2DesBBzZQOzXjDzcRxQ3QVlMUKUZBasJR6SybAew4GDq0teVxxcWX1BGc/ReBLi3twE50GFu7+bTAtyhx6TNqg6gmpkdd4cNJbYCnjbdKvOib8G8S4R6eg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2f73a6-895a-42b6-60e3-08d81e54bc3f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 06:54:15.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmfEPpIsEx1wFV04Rs6K8qhiWYT+NZjayF8+TrcD+O4xImACX70kY6bbKrplBoTU6/kmbRwst+UqiXxapWgFuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
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

