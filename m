Return-Path: <dmaengine+bounces-1237-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FE386F93F
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 05:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BC91F2176F
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 04:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468D76ABF;
	Mon,  4 Mar 2024 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d00Ohs2Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2062.outbound.protection.outlook.com [40.107.241.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E19CA4A;
	Mon,  4 Mar 2024 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526827; cv=fail; b=M+bs7JgpzJnDbUgJqydGpYKAcA62FgBynG4xHEMX9cJJS90P4NdE9Hn2jykANInSZulGVffG8X+OekKnVqPgvfqPmMmQRYz61jnjr4NAeKbTZ41XNrvQ0eG8/M9W8vzLjgljs+PmU65R4xxiVrPkFiO+XWFWoXVmdt6KhZUht3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526827; c=relaxed/simple;
	bh=QEZqUUXW8Rgc2Oqu2u7FH9lfYbbaApne+Xq+yBJSvGg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ty2F8BDL3gvFKwOAjg3PBT5VWSC74fs64WxmB1KwwVQWSvMy4TpmZYIvL9WxQASJHy6DxF0d1pCb3y/Sr5jxk8oaxfGeNm8/9lUBVIJTopwRCin2GiMGskB2dXqiWDbjHhi6b/+8QVF9ccu051dV+Q/adYSEZr2Dtoufbd1KeP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d00Ohs2Z; arc=fail smtp.client-ip=40.107.241.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2dYbXWHiTLEjcQGN8IoYt6kiacXn3WWz0z9naTSX5PJ5kHFnc9xZgfu63x1PhwneXDXgr2RxkVeQd3Uf9fJG47ArTsjrKH2cv19jiCQEtWbFkVttqQiIHvxKtWsUmYZhvejplBvyQDnwbVy2/de4WWo8Y9wwee//ytrAMiDjY5kJHJypsCSWpeZxCES4RSWjo36QpGoDNr7+hvpK2f8vGBXO1kQM2RenDrNpXJngKgm6mPhjD4HDUg/OTPO/9c+0HGvvIZZL2tkscpkBrz2E6MkJE2ebBlw0XEX+X1qbH5QLyTkxGHtvch8cStVj5dP9dMM1i7yjWWQnI2WUcV17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z64wZYjKKUfm1pxpEOeB7lPcrGc3jLg+jMihqDpSYE=;
 b=HfS/3CWrGMGQWe4XTFnfM1bMMAcOMWzaCYr4wPYo/hcqZlpGdN2NJhiLztGVz32QJqNOE+DybUNM3tqJjAhloKl/ixo9/KlK08t5Ca4RpPVxgu2REOVf4lZ2BhxIxyaSzEcQH71x8SmP2kIh40aDsrdxrRp/HL1zS4uXFLvzVSPNHPhNRVXeu3daSap9D+UYMXaRIpikCm1au7uxrqQ5TCstN7Ljz5lB2VNxbXueYYTxRiZrGPQm5ocfoL5ILOtLVivCNGSVe5vznocV2UKrEE8m+LOHtati1woh8NrYbh06QJDy4PzOO97hZi7ai8YDIAxn16pcLnZZshNA9FHbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z64wZYjKKUfm1pxpEOeB7lPcrGc3jLg+jMihqDpSYE=;
 b=d00Ohs2Zcy4YBSsJqN4Des8TvRV/My9zO03v7NhMWKXTJ8RrnC4Hiq6RkzDNdj3wOdGuxInCQOMPaYIPHaCvEH8uOrWfZftrlkoKWidNLTZBbqBAsY2Ihn2pHf/JTO3O3OGGOtFY7WawEXz7Hk5Ls2adaRPR9KB79NoQ8b8xx6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 04:33:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 04:33:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sun, 03 Mar 2024 23:32:56 -0500
Subject: [PATCH 4/4] dmaengine: imx-sdma: Add i2c dma support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-sdma_upstream-v1-4-869cd0165b09@nxp.com>
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
In-Reply-To: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Robin Gong <yibin.gong@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709526805; l=1643;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jvaJuGAbq/PgTRjNdACNawbK/+uhKFgC31PN65XdWH4=;
 b=3TebILFHjhFYpSl9rErEHst/rEjqdhhvMwWqKFjHRFlvwpD0+ZP3hDh5q5dGYxf1GR7J5m/nl
 eam4Zeguk/qCvacgGwtR5/mn76RVzAC8PNMLGXErLnkJEWY1jXYJlTX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b58476-fb01-430e-670e-08dc3c04458b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6K1A97qgzRWtel6rnPgHS1Hy+XnanCIgP9exLx5fcX8TehTU95oOD6p3B30vaPrL8yPtYG5nPGwf3dqYirSSMhi0RIWQhxBPPzqXc2Qh5R5t5o0/dRfCw6GDK1B2/9RyokCMTLQI/nY9JPd3gKndSOx/n06qlFdK5KtyUz2+9G1ET36nAG+s3qa/8rrreo3h26yIXW4M+0vtnUkRxopm6JiTKt8BS7odGd9kgBfRvBH4/ilFKiK2B1uOiy6kCbhFGB2da0f0Y5kQM6+EIHi8aHZf7t/Efn75cugwWV6r9rEIRqejddGWT4WupSNnCB7zPNs/2ggUsbWpu2m1oHI9hSo6ByLkJQjRrJkRdjrjN2Rl6QPq7tPiIMqlofVLvMIel8bNS1WqgSdcT838iURsDlv89E5pOtDtuIfwI8zH0ycE2G6d7XdsjuzL12fqn5MDJi2LfuQ30y+f3HLroaa9XgXnOn/4TUR0FMUvzsK8a+UdKdZiQ2s5tMiMsireMT3ZKIkVjPJ4CCSbX8TsdBU8LNQovGhZLghOKxz+JtrQWUYxU55yuxgRVkaCyPlESG0RzCqYPJh80bzwnA65/vugeQWWRx1pF4d9E9p9V1PQEDEhXA1QXeldOECzH9ZE2n/1tls8soqILk25QoziCrz2WREF9DYuKeXXBotUxTfDjPUo/O24u6R0c0F7u6DZalBb0/gzEyRM9GxTPCyrriGwLTJ8Bokae0hg+V9Y4K0mbpU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDE3emZxYjhhd1RlRWh5VGpsT0RuNXl6TlRIY1lBaXdVWmIrVUZsU1lUUlhO?=
 =?utf-8?B?Q3paL2g1VjYrQVg1dll0dStKaW1NTEYrUlhkZHBFaHMxNDhJTWJjVkJGVzFi?=
 =?utf-8?B?OTBsT2IxdDY0Qi9mcDZudXdhM3U3NW5QS3dJMmt4VVlDM3VZcDVBRzhJcFd3?=
 =?utf-8?B?cGU5NDBBTDZ1b1NvaXh5UXJyUmZERkdtVnpSL0F4OTVzbTVld0xGNmNjeFdt?=
 =?utf-8?B?VTduRWZZeUJqZDlIZm9vZ1dqYWQyRmZHcE5iOUtvdTJIVFBvajhwYWx4eG5L?=
 =?utf-8?B?SXZwWUdYQlE1UWtoZmVObmZ1ekd2RmlwdWczWlRvTERSbXVMaGtNOUYyOGta?=
 =?utf-8?B?U2NOU1EvWlVrdGl3T0l6SW1lb1FlTHpORElSMS9rS2lDeU0xakFBMU9oQTlO?=
 =?utf-8?B?OE92andOeGU4TS9XWUhlT0hOMDdPSjFRckRaZEdrNUdMYTZqT1RDbHVSMkRm?=
 =?utf-8?B?THVjT0lBYUR0d2ZCckplb3kvKy9SamdZYlRnSXZtZ1pLYi9tQWNGaTVHZjlF?=
 =?utf-8?B?Z1RRVmxnd0xwMWxzN1ltaGNWOExjTkJ1aVYreXVhNlJpVERQaS9aRmowcmh1?=
 =?utf-8?B?c3lLekRwckxCblpFK2sranVTYjhkbDRnTmkrSGhBczQrTGlOUGZ1TUlwakdm?=
 =?utf-8?B?VjJGVUVxRFFna2g1OVJzU3RVVGZGODF0Q2tmL29YaXgyVCs0algvSllGWk8r?=
 =?utf-8?B?QXlqdGUxM0xwZFdYeWJnZUIrMUY1VkxRdGpSd2x6Z1lQNEJhMnVkTmwyWUZS?=
 =?utf-8?B?MUVFZTh2a3hBSVJzL3BwNW1WOGlOZ3pGS0xSVXdoQitFRWRYSTc3UnEweGNU?=
 =?utf-8?B?dE9XUGd4UDZMVE5NbEdZOFc4K2p0VEtJMnRwRVJFRWd6Q2lYcXZ4RDErUGZD?=
 =?utf-8?B?NTVFMEZoSlJUbU9Pank0TEdjK3dub2lySXFMTkF3MkNBWW5nUzR4T2FTMG81?=
 =?utf-8?B?dE5lQ3FLaCtydUc5OUtlWXpEeWVFRHBvYXFZbkJYcU5lakdIL3FmemxzVTUy?=
 =?utf-8?B?N205aWl0cFpEbm1CUTJBNlBxSHdHMHRjbGVtV3NFRFJKS1h6NGJ0ZHAvVVFq?=
 =?utf-8?B?aFdyVGJQSFlLOWQwSk9HV2VhKzc5SDJjRGl2a25KK2RJMGRsUGNvRWpEV2Zv?=
 =?utf-8?B?WS9PWm1PWlU1RGpWdERCamdDMHhtME5GazB6aitSK2RVM1BVa1hnTUQ5REs1?=
 =?utf-8?B?elR1UVlWWjdUZTBqUUpKQWJnM2VjVVZmTjRYSjdlZWNhYWtNNURRQUdBMTJJ?=
 =?utf-8?B?Z1cvU2lxWTVnWWRFSStkSnNkUFZmU0wzWUt4UkxMaXNUNkx1eTRjQUVDSld2?=
 =?utf-8?B?SmFWV2RoLzRVYSt6azNBV0x6Y3Z6QmVmTlhZMmNiTTNyK1dOMTdEWHFCbTFo?=
 =?utf-8?B?UWxQMHprNXptYkRtS2d6dGlGMXBNRE5DUzdTUEduZWNBQUZSYWdGVWhDTU5G?=
 =?utf-8?B?ZVlpYjJhMXRna0FXTHZmaURGanlMbDE0K1h4RlhsYmJMRHRUbGI4bVNjOWQw?=
 =?utf-8?B?cElQL2JIbVZLemxod3I2bk80TDl6bmNuNWZlVmZnSnp6UU4wbzdtMys2aGhs?=
 =?utf-8?B?S3hqaGhPTnRNRmNPRUl6TFpPanpjQ0hrRkRYa1RWdTIwWlJoZzRJTE9SMHZa?=
 =?utf-8?B?US9uMERKTHliSWg1SzV6OW1hN2J4bXhkL1ljTS84RkNyb09tMmgydURZUDhZ?=
 =?utf-8?B?bi9YU2N4U201SUVBSkRBaTVrRFVEQmMzVXdlZ1Q4NEtJN253N1R3citrY21r?=
 =?utf-8?B?eldnNCtRZmtvRjlzeXg3cmVKQlNLL0IvN0I5ZjRzbEtnWW1uL2lRQzIxR0Vq?=
 =?utf-8?B?LzVFOGdEbUs4Q3pNRG5GWTN0QmF0dXRXMzdoalZocm51Ym5Ma2xaeGpTTncw?=
 =?utf-8?B?NndTVVZDS0R3VzRFQ0RGSXUweDQvaVg5U2duT0o2aWVrclhyaDlrOUtRMHl6?=
 =?utf-8?B?bzRacGVtK1RMSHB4d0Q4WGc0bmRXYS9DcnZIbVF5WlU2eW00dTJTUklhay9v?=
 =?utf-8?B?YllLbHBGTnpkd1NzN1lPdklYOStSVnc5VW1TZC9zWnJLVVJSL0lQN0tUaVpT?=
 =?utf-8?B?YU1iOEpyWTA2aXF5K0Y3c1NXTHVGR2NrV0xHa3hTQUNMMS9OL3ZNd3loMjF0?=
 =?utf-8?Q?hXMbmDYAKGRcgifCF2mANIWsp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b58476-fb01-430e-670e-08dc3c04458b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 04:33:42.4954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwTh17tR6Srn/2bzNW2M/Nw/4Lw5gDJkv6ppajy7oOG3CpScysG91amWr45XwL0nyM/ZbbNoN2j3q1jvCv04eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234

From: Robin Gong <yibin.gong@nxp.com>

New sdma script support i2c. So add I2C dma support.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c      | 7 +++++++
 include/linux/dma/imx-dma.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9b133990afa39..832be7eccb335 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -247,6 +247,8 @@ struct sdma_script_start_addrs {
 	s32 sai_2_mcu_addr;
 	s32 uart_2_mcu_rom_addr;
 	s32 uartsh_2_mcu_rom_addr;
+	s32 i2c_2_mcu_addr;
+	s32 mcu_2_i2c_addr;
 	/* End of v3 array */
 	s32 mcu_2_zqspi_addr;
 	/* End of v4 array */
@@ -1078,6 +1080,11 @@ static int sdma_get_pc(struct sdma_channel *sdmac,
 		per_2_emi = sdma->script_addrs->sai_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->mcu_2_sai_addr;
 		break;
+	case IMX_DMATYPE_I2C:
+		per_2_emi = sdma->script_addrs->i2c_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_i2c_addr;
+		sdmac->is_ram_script = true;
+		break;
 	case IMX_DMATYPE_HDMI:
 		emi_2_per = sdma->script_addrs->hdmi_dma_addr;
 		sdmac->is_ram_script = true;
diff --git a/include/linux/dma/imx-dma.h b/include/linux/dma/imx-dma.h
index cfec5f946e237..76a8de9ae1517 100644
--- a/include/linux/dma/imx-dma.h
+++ b/include/linux/dma/imx-dma.h
@@ -41,6 +41,7 @@ enum sdma_peripheral_type {
 	IMX_DMATYPE_SAI,	/* SAI */
 	IMX_DMATYPE_MULTI_SAI,	/* MULTI FIFOs For Audio */
 	IMX_DMATYPE_HDMI,       /* HDMI Audio */
+	IMX_DMATYPE_I2C,	/* I2C */
 };
 
 enum imx_dma_prio {

-- 
2.34.1


