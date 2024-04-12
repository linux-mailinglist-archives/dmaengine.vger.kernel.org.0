Return-Path: <dmaengine+bounces-1826-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5498A2407
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 04:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE6F1F22C2D
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 02:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F018F125BA;
	Fri, 12 Apr 2024 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TNW0dxET"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925814AB2;
	Fri, 12 Apr 2024 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890658; cv=fail; b=OvEBsOXg/s2J7hZjVfv5uxxKueuZEleidbv6dxmMGjx3QtH+5Kh+3eUIEpSjW8MijY5vpCsJ0KzZBDnxpZJbafWE+pQQcN/xRcBz7J8ULIuX00ljB/ab561XKMBuj19sVz6K0Cx/PmhVvFlXL8CSGI9z3FPa2Us7nx541rV1fRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890658; c=relaxed/simple;
	bh=zzMQGCJ0MHOMyk8nv1e0t+sdNkndRRi2xX/KdfMdkJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ANqsRvKNsjEKHnHGmw6tu3USmnTHeUeSkZ423qVpZaGi+hsIZoYw2/zdOhe2N8E7WK/kPqL5WdpqDQ1hU9q9r9UltN8a3J6tTh84+/y/ZyO89D4O68g7PNYm2DXyFuApBEIMtggc3cNHyGNRpekYGk6QxhtJKSQV6TcLhV2RGqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TNW0dxET; arc=fail smtp.client-ip=40.107.6.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI5o5irfvvl0s5AuS+6fh8F/VIlj01/5LDzmQTAhoFWEjBTPHVLCNob78nS6l+wDklRJVtg2iYvRHFVq5c23FAPwp2LIwnpLpU12cdusnJq6d6i+7i0qL2uEUakMFxPTmUL4qyUKboQEC/YwR0xH2xFXsL8/EndPNKNvzaStIxkJLPsKCyKtw7+ry85jF+kDCoHlF3PjB5w7/Ha2ltO9Qi0blBrBPiPC+s8CZs6vKWOIsUyj+w6kGS6LddyfDs7fU5cniqZNmNo4a0B4HUCGlS2+63rhL5/82ZG8jRnoVv2C/lxvxh/0MkzRnq19+fvXAwRxRrFNVRnCSZdOCaPB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABIq4t9w5QvkrNcsbI9RxEkButaCcxUnZwGMIqSTnUY=;
 b=ZqxW/1EgysGUwXceUQDArYolK3PaSQJKlzaQJNWuisLqRqMEgoXgpno6jo4rOSO8Kh737Y+qvfqwdd2ZirG+ZS4DAugePGi+yDyOOPVIww5V22mfN5jSvZJI8nUP95GbZyD2l5CGQVo5UO9OVxIRGWE1vz89mAnW4ZUGNvm302FC5+hxnQCD/VfEkwkzf/Cy79UzzxxmFMin3HrGKPA4CEWqYJH4mjR+IrO+uxw//ELSiDV0+YRTbiLWU3X12XPjGwl2gYLMkgMABlizpcs/Q0YsMGeN/rfqSAahOAlKXa0siRmI3LS+Fkl3oPJYYshPiJ0gOirPPiv6KTmvhoqA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABIq4t9w5QvkrNcsbI9RxEkButaCcxUnZwGMIqSTnUY=;
 b=TNW0dxETPMkUtZTyC5POcCzYuAPmoIJhJxmzEJ3zn0lRhEQU3wJg6gIsRUF/mnpaNoR780BoYB5PMX/yvyShFDopuyIBc0i4t5TILxYiDQWFgo15irWA9kGhiuPjtQ0/f4IfqgvKllpEGkWqzq5YuWqIV22JwWCDe0/l7RlpFes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Fri, 12 Apr
 2024 02:57:34 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 02:57:34 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	peng.fan@nxp.com,
	vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dmaengine: fsl-edma: Remove unused "fsl,imx8qm-adma" compatible string
Date: Fri, 12 Apr 2024 11:04:35 +0800
Message-Id: <20240412030436.2976233-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240412030436.2976233-1-joy.zou@nxp.com>
References: <20240412030436.2976233-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DBBPR04MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: ee918d91-d20c-44d4-b787-08dc5a9c4da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P1a9+WwZuRzLjaK+gzwxTNE1u3WgTdypD7qtcsT1cC4g8aHKqoiJHLb+0Vq6SCPgEOIOcohZDIjA7LQolTlgK6dZK8kOOADI1+S0pU0BRvwdlMG4Hap2pgB2s7EXn3WpeKZIyoOdquwfDaf07RULFff4/1vgnhOSv4AXnaHj492vVcQ3/aObhnJrmosKYibDcNnFFyzSk09pbUXZ3c5WHAzcvvp+1jeoZmK/yWeZqM0ESAQCNq0jRghuoEFuGqce1D6wgqV8/1H0qC65HlOOWNlIr93PxqtW2sq5IP0RgaxhkiZkNsh8zBNRE2TDbEWUyRnh+Ea3TQyXy/TFNeci1ZLdcNG6aXw3hnUX0yZhxGkcRVCXRahKCUbB8DYxOCRHhhtFapBgTyeg6NMYI+qkb6PCMutXFYzpz3POQzsicHukKLF31tVudNP7lWiOFVAn5jhc2XweMJSpcL3Zyxbm+vAt8kUFeqV0PEGcl9MUYmOvrQ71gBICEAl/3JI42QjR8HLPePxScOCW6UOUQqVS7AiQifhQcVkf0jjL8gc7Q8V2aYzOFrOKRjCpPRxXOp5tpTjt+UwjMKIT8tfTj7/brzfTl8/81mexhfqk1FxRxdrDwQHr/sNNW7wz3or4nn6j2Xcda0qKzJ7JW0Aq0WCSlhXVAs7OkIZctW5Vuse6sZ8mivoQkzwmzYFJLuIdwk6bvXBHvFjokb4DJaXaH3Y7gtDo/OWipqufd8t4sLJIRsw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7BkSPfveObTXBO+aFawwhza3d5/BLdlgr+lluTEdAjF3baXPiig5tGsgpi5?=
 =?us-ascii?Q?OldoiVz/p/pieELio0YUS0jrG4pEUBMDPc86oe+bZkf1hj4uPmzbmXWK+b3R?=
 =?us-ascii?Q?P7vtPHTV4uBrS14c/a3F25IOlmbH3lxrZqXDKiQFYnLCsOPMJYJtAP8YrPTW?=
 =?us-ascii?Q?02pHf4ovmgSQjWuyjsSnAtdDwEia77Rbuul82Dg7W0b13ylYHf1qany3HBWn?=
 =?us-ascii?Q?T8egI+5uc1YRjpMcqpgEi73CoyEZS55uJnSvqBYXluFbBzD/e7AvN7ap35B5?=
 =?us-ascii?Q?Ie0cTrPUpGi8wLOoJ+qh/J1mQQYHIZrhSpNukHcCGCu4myjiKFpcUqEsnfCu?=
 =?us-ascii?Q?oPor2/MBpx3l6DksL/1xkaeTijhxOhhIg9GkN9XoL4EtKkMoOk28j+Op3ThC?=
 =?us-ascii?Q?pb8dh8xg+oMz37qf92vXgLd1CjuBEF1hvhjyO3lI8FlweX6cmGlq7DoVEZrI?=
 =?us-ascii?Q?aQAkdfasKrX4E8yH/obyMrGpnkHtXd/fCGOpWDfxjc2K/cvnP95VQrpKTqGU?=
 =?us-ascii?Q?Shbru2dUwlZ56l5vEml8WMA5DPKfAXa3LHFJQOsZmhJSApJN+9h2RuCm7l4D?=
 =?us-ascii?Q?ncpBey4IX6NsmT1Vd8IEKK/unGmF0Lz//MwtR2NPVa0SkNo0BOK3smTVIDpY?=
 =?us-ascii?Q?RtBaIynhQ8Gn9aDzG0Cxrqjjpab+tmg0bb8kDLbLPmM0x/JF2QGTQ5N8mu9P?=
 =?us-ascii?Q?00jfuuDR1nbOfhH7ua+TYdjYR+tUKledAotBkUe8Mrju5bDo+mL7eIG2LKGP?=
 =?us-ascii?Q?SUz72xlPIH3AjyUK9C9ydV7o+KWRW4TmS0VfwfW2SEyFZEJoE8ucUzNWwHEA?=
 =?us-ascii?Q?0qPnP5JXMd7+6tU4rsjETQbR09G5wNsHgT3HrjKRAmYqiyl/LJCF0xjuhmej?=
 =?us-ascii?Q?lZvJrBBT7pYWbeOGEIIFNpm9bU4f9g7qlU42/G080QRmu0jGLNK9OLOQC7x1?=
 =?us-ascii?Q?m4nMccJ6Jba//2NGI/yNkvO1ZVchp9pjbaoENib6uDyiDvug+gAasbEoU8LC?=
 =?us-ascii?Q?8Fd9ExbiRLylj2HfKdfr4OL2e5dNMy2SoTO1q5rwkbkUnSXsta17JqjIEoO6?=
 =?us-ascii?Q?NfNThmjJdelHpVL15rHIIzExtQ1NOUhEYqmH8Rpp6VelTaGQxhyEQdzClAuy?=
 =?us-ascii?Q?w2la/NwF68GJgnReeblZiC8O9EaWi9E0GquWhK3bccAxdhhEjhmqx9oavqd6?=
 =?us-ascii?Q?XnP3Phj0FeYrs3BjJzkm3OehC4bGgnTo506SvZm4bXb162gySO+8Z8XHZMwm?=
 =?us-ascii?Q?HRX2vFQKVkJDnw8j7O3BctAL75pnIkxW7UrFT2aoBNM7kr7WeyCuz2aIi4aC?=
 =?us-ascii?Q?T6L0v5YGH7qBlX2+28+DWKRGs3cZ6XoBlHlPIKEoxUyozgQ7Ra02TH4qBvVc?=
 =?us-ascii?Q?2Lwy2his5cgESLnnTw7RmfREXrk5ZndGdE228pPAupfGe6s8z5TXfTgeIaUb?=
 =?us-ascii?Q?2qMSyiHtS4ACnxO3esMoLoriGpCnrcQx0FY7bG+XG6/CgAXpICuQcxZihyod?=
 =?us-ascii?Q?02MMUOksLDRMuEqBKVzRCOWsac8NQRAYPlFG8Ew5wLyiUl0MshvFRaaRUrrc?=
 =?us-ascii?Q?9viT9RhrbamjrtUHlCvXnNBdZYuvyfpuM8v/97Vo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee918d91-d20c-44d4-b787-08dc5a9c4da1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 02:57:34.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7vPpIx6QkOLbhRDXejYhirN62D4ikRC5k6xWOEr0f9mP9VEqrHDMi4Obf0JmMFU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515

The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
So remove the workaround safely.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v2:
1. Change the subject.
---
 drivers/dma/fsl-edma-common.c | 16 ++++------------
 drivers/dma/fsl-edma-main.c   |  8 --------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index f9144b015439..ed93e01282d5 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -75,18 +75,10 @@ static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
 
 	flags = fsl_edma_drvflags(fsl_chan);
 	val = edma_readl_chreg(fsl_chan, ch_sbr);
-	/* Remote/local swapped wrongly on iMX8 QM Audio edma */
-	if (flags & FSL_EDMA_DRV_QUIRK_SWAPPED) {
-		if (!fsl_chan->is_rxchan)
-			val |= EDMA_V3_CH_SBR_RD;
-		else
-			val |= EDMA_V3_CH_SBR_WR;
-	} else {
-		if (fsl_chan->is_rxchan)
-			val |= EDMA_V3_CH_SBR_RD;
-		else
-			val |= EDMA_V3_CH_SBR_WR;
-	}
+	if (fsl_chan->is_rxchan)
+		val |= EDMA_V3_CH_SBR_RD;
+	else
+		val |= EDMA_V3_CH_SBR_WR;
 
 	if (fsl_chan->is_remote)
 		val &= ~(EDMA_V3_CH_SBR_RD | EDMA_V3_CH_SBR_WR);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 755a3dc3b0a7..b06fa147d6ba 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -349,13 +349,6 @@ static struct fsl_edma_drvdata imx8qm_data = {
 	.setup_irq = fsl_edma3_irq_init,
 };
 
-static struct fsl_edma_drvdata imx8qm_audio_data = {
-	.flags = FSL_EDMA_DRV_QUIRK_SWAPPED | FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3,
-	.chreg_space_sz = 0x10000,
-	.chreg_off = 0x10000,
-	.setup_irq = fsl_edma3_irq_init,
-};
-
 static struct fsl_edma_drvdata imx8ulp_data = {
 	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_CHCLK | FSL_EDMA_DRV_HAS_DMACLK |
 		 FSL_EDMA_DRV_EDMA3,
@@ -397,7 +390,6 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
 	{ .compatible = "fsl,imx7ulp-edma", .data = &imx7ulp_data},
 	{ .compatible = "fsl,imx8qm-edma", .data = &imx8qm_data},
-	{ .compatible = "fsl,imx8qm-adma", .data = &imx8qm_audio_data},
 	{ .compatible = "fsl,imx8ulp-edma", .data = &imx8ulp_data},
 	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
 	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
-- 
2.37.1


