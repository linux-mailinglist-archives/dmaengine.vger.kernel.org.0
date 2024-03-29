Return-Path: <dmaengine+bounces-1659-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4ED891FE9
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2711F314E9
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB3713B79B;
	Fri, 29 Mar 2024 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TtkPcUQL"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2110.outbound.protection.outlook.com [40.107.15.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361313B5A0;
	Fri, 29 Mar 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722923; cv=fail; b=JxTX/0ZGIMMeccD5B15nFWg7TSKF9lHqlnLKw7+A+oEhgzDu8duBWPHJ5h2Ku4StfiSOw6GzFuNJFre1GZX49L9ZApkC6eWLleSaNNl8il+yUG0EcAm8VG6/E7/XkMlGhH/UKACVGzIoB9+ufcuxruWZfJhhhdO0iD0Sgzu8rt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722923; c=relaxed/simple;
	bh=aq2/ULP0Acqkl5nMyq60djlyfH/8ofMH5hwkVDWJ9JM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=N3ZUl5PevSj1QW9EfEuqijQKnX3JhPcga/REzmC1zqmnRLn4VwD0ZTZqrm4gl1bsBwFc4+nng0VpcEx3bMNAiZeqyDBq6ouxCHdfule4zQpHwNFp5vRvQvUSZH9KZVbGHOLO3qehUoS00ziYtw0gDkYebP7dSb+jus9fiFxNQag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TtkPcUQL; arc=fail smtp.client-ip=40.107.15.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6zRcafX6rrPiht7K1OkBpgt/w+sodXPsTkNckLHfw7DsGy1FHJ9JrIuRGhdX5rrfsYcMEWRfOXOLYRApmKyebEL4hRVSSK92N2/Keeu3XLyi2RCgN9HhmTCBfFxoBULKO0BZfR0hWK1v6uGPRKF4A/i1x+/JTSXLdFeD1/TIITUDu8k23chVaWtn4ECHHRaw0OSm8MKdkkRkQV1dQR4IAOeQpdnqRU95zvk1eKrDv3ecFZUheWviRfpCs0y9XFRRe2lCvMM/Ryipv+VLgnjQhh/Hqp7Rxz7QbZNnfsFqjayBqfLKkU0zCziTUvrI2DUNozBffPmmIuhxWJmj1VwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GroNJye/Yehgv2tou8mx9qaw1VtXSIYv09vStwtBzqQ=;
 b=IDES9FX1R20mVytGvnWbdbgGnzBmLVYHcGMcGdaWmsrXUbTUSAAXrVFeJBj5SqsxF1fejP9/zfNOHGjZhEMlHmGynVTOnudTyLRrHn8TabPXctiZdJRlh6qkK4MOEDK3JBvEdMCEDJYnV4G77iHhgXMmUBNUnTsEBpTl2MLBTln4hJ/Al2x49z404hZZmVt8lidGmEnaYPGiQxgpxFi2D82d173JAzZvdB4uCbZE/t/AguVOpnnDWP4Asfp9TSzMbzGWs6LBk4MRd96iJAg1EXJqyROPBjjzv0AUYYg0JC4tbZb8j7P9fGEsxcKEbJru+Z+RrmqOHaPD/Ia6kkQe4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GroNJye/Yehgv2tou8mx9qaw1VtXSIYv09vStwtBzqQ=;
 b=TtkPcUQL1veWKuxdniYAguVRtTpAKyma7R76k48vkLG3G8UB5txbrUciWUS5dj/CBGlGFZjaCcw2ZrIQDsfZhP3Sr1uAl4lcMZDXVAYR86EC4VaWgZT/WJHs3zqYumzVu5xyGU7z23E16L2C+/IZchoPEjs++GVsrtTOSWkcy1E=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 14:35:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 14:35:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 29 Mar 2024 10:34:42 -0400
Subject: [PATCH v4 2/5] dmaengine: imx-sdma: Support 24bit/3bytes for sg
 mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-sdma_upstream-v4-2-daeb3067dea7@nxp.com>
References: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
In-Reply-To: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Vipul Kumar <vipul_kumar@mentor.com>, 
 Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>, 
 Robin Gong <yibin.gong@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711722904; l=1279;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/ve4814/ESKVFolOyuQukJbgmItKlbc7RUUIpEOw+Jo=;
 b=HEzkP7vjvFd5k47Tb+Q/FAf71G5RoPOUA8UVQTzqIh3pZaGL1Ttn/VayrpQalPCwYr2bT7rX3
 YGswr1AvKJlBqJ8Tljq90Z1g/bi1auQwyvzdK7AJkmzFRUv4bLiIL7G
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6897:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5JvrSbEpcqmPVeb6W3k2Fqh/0yl2N5KvY5HvgZUUSvckYWgUkQT8RjTvNEXqkXrvG47KdVokPPDKRGbcwDbirp2oEhUBhTg5Cn0cBesCUFGnGH7PdBnsvp2UnP/v7btPar9wzda/rUUEerwBUX7lj222oeTe4e19DxOnzLq/DHB5LUWSbLwswU4A/X7f2y63BLwUNNa84QctvksiBRuwNGq91yI7ENOIylCejf7xGFV2O+TrcJ6cIQ1ppUMQfyuH6Ork/K5F+EkvP8hqyEEd7TIY2WAQJKyjPgfWBUq4uKE4uz7goF0Mzqz5d+KvQjD1wiPvRdbG3Thyno6zRXwkCeigfLAXlxQO/c22wAWiBGH+hi+yhBoqAqEylHMOq4yEy540GVRGqtNEuZvJbMNWLt+kcg88lWyHgZ7qZ7qg+h+DgKUwRPujfTPGzSJkhu4MG5piT2QFBX3InuIGMFHYmFYhvllibijuzaTjQ7GoU8CKzrIHOtAyvngRs2vO0gR/WWqsnxqDGWPbCw4Qs3zrnwbAZ16lf4EtmtLyTf14OtsN1lVJFik57Vg4uqhNVrNGzmw6d25daLdQwknUNPecJzXXD/ghI2lF+Cf6M0Lua5fDMIVsiQjWJfGRxJYK2Y6Pkdnjh2s150tqDenxBe/i+OwLN7+R7V4/KEFtIuKEWT9Kw2sbsQfBkUIw3RWUZopOwEyXXcUzT189GcGi4I/jVH5Fy1tj3n573OSDkOo8RY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2VDeDJjMTlpMnZ4ajlFbzlaTGNUVTlhQWwrdWhwR2ZNdkJCK0tuS0J6Q3JH?=
 =?utf-8?B?SFA5aWN4N3M2d09YRkdKNGJ5NEVqQXMvaEZlZ3dOcUFkUDVvV1d3WHhhOGtI?=
 =?utf-8?B?QTUxQ21GVEk1OUhlcFlRSjJHOERMaWZnSm5MNWVzUERmbVRQcVA5QTl5ZE5J?=
 =?utf-8?B?WjlvemtacnhCZUVNSkRIMGFOWWpQellaZ1VNRFVYMXZla0NONGJlaDRmRWxJ?=
 =?utf-8?B?ZTA0NHJ1bllEa1U4VS9QMllVcndmMEVZd20wQ1dEV2hWWnJrd1c3Umd5NnRz?=
 =?utf-8?B?UDhEWmNyK2hkZW9QeGVBNnNWSFRnR1VuR1gvL1BueHlrOVRUcXF3a1E1djBi?=
 =?utf-8?B?WFhTKy8yT2VCVTIwVGs0cDZlVmtWblJrcHFZYmpERlhHSkxBeTdNQzlJT2xl?=
 =?utf-8?B?Zm1HS1FZS0JPd0NqYUxJWGJVLzBRVnZVSEVnMnRYSU9uSHN4a1Roczl6UndD?=
 =?utf-8?B?S0hLMEhlTFQ2cHMxeDdxVUs2YTJTV1FpOE5jVlhkV21EM2tmTG5yNVRja0pT?=
 =?utf-8?B?Tmd4MnF1bEFxS1d6WXZVcVBSandScHZpMENLSVhPQm96c2JYOXVTdTdCUlRi?=
 =?utf-8?B?YnI2ZnRoaFZOTVRkSk9uRDZ3NVlRN2tFYzNuTm41K0Q0QTgrY1ZwdmxmdklW?=
 =?utf-8?B?cCtaeDVvSnpPWmFnK1Fsb1l3TTZtaURYalU0UHdDUWdFOVZ2R05mTE5oMmVi?=
 =?utf-8?B?N3ZEQWFEK2ovc25sa1VZUVZ5VXp2c0FqQVlLMTNuNFNyOGNXRE5INmNKODc5?=
 =?utf-8?B?RVlpcHorNUkycFVDcU1lU0ZqdG1hVEdLV0tsM29DbitjMWUwQjdWc2dsdjdv?=
 =?utf-8?B?Zy9wNU05V2hDZGNXVXo5QlI4RVMvekVacm4rbU5Ta1BzdVpqRkYvaExRZFhi?=
 =?utf-8?B?b3d1Nkk2SHg1bHZKZ1N6Z3MxUjZ2by9NbWVneWttLy9PZmNPQ0VpNWo4Znla?=
 =?utf-8?B?RlBMdTUwSkVLMmUwSm5RMTJ3eDB3L0RFSGhyaWtzM3RwOUFTVTRXUFA4UlN3?=
 =?utf-8?B?c2dqSGlRZzdyUjVKZ0tLUStSWjMrYTFxVHdZZVhqTlEyZWkyVDFIL3lmbnJP?=
 =?utf-8?B?YjFDREVJdVVkUVhIL1dlL2NRU3hkTVozTGhYQzBQSGNrbTVFSGgvMVdtZUtW?=
 =?utf-8?B?SFEwck5BR0hkVkdSTkdzaGQrV0NpTmRkbFcreDUyNUUwcHBZV0UyVW1aL2c1?=
 =?utf-8?B?WFRvUFp1OE9nQ0t3NGMwbmVkR2M1Mk4vSzVNVmprT05DZndCOGM4aUtmWEdL?=
 =?utf-8?B?VVg3NEphbDVCUkRpRnRkNkgzeVd0TWJEMlVwRzkveXd0U2JXd0xwL2c3NUlN?=
 =?utf-8?B?U2QxMlpEQk1wM0NDZDNJT3ZEa3RUNUhXVEpvb2FNTTJTcEpzVlZmL1hZeVpz?=
 =?utf-8?B?UWhpQ3V3cGFvdmQvZVl1U2pTY2tpMGpQYXA2NGV0aWVSaC96QWRyaDgvV21Z?=
 =?utf-8?B?Ry9mSldORE5nNVBKTXYyYktvMC9BVW44bU95ODBONURVN1lDVzBrUDZ6elM2?=
 =?utf-8?B?aGY0cVhIQUtjZnZXM2ZORW81UVlrR1pmclRlRHo1WWNSdmRndHphdk1aSkky?=
 =?utf-8?B?MUsrMTBuMEkrWVBvNzVERWtGN3VJbUZ2M09sVktiUWJ2bzhMekhDMEY1MXNx?=
 =?utf-8?B?a2xUSWErUHkwcnFVdnAveEdaa1doK0JGc25iaC9PV0pZNVNVQ1JQbUdZelEv?=
 =?utf-8?B?M2hqU0s0MnRuTVpTOHdYSndoNXducXhKMFhlNWs2ZkNxZUkrOVJQWm12UnVp?=
 =?utf-8?B?NXFaY3lmd3I4S0E3c0U2Q0xLdHpOblhGMDhPbWpqYjV1bU93QXZZb2E3SHYr?=
 =?utf-8?B?eG1oa3Y0NlBmOW9RYkpXb29zd0oyd1VXQksvZ3U0OUVJUWVHV0t0OVVVMldz?=
 =?utf-8?B?ZFdtVHRUNjNnZktGbnRqVzZ5UDFTT2xXdDNGa3lIZjlxS1IxQjFXbDREZXYr?=
 =?utf-8?B?RFRxeXZtUFo3ak05Zk1XcUtFS0VEYnYwdlFmcmZOejNCaTBzekRxQTZwNHJQ?=
 =?utf-8?B?RXpFajl1VzNDK0hBM3JmTkVpdmxCVlU2b2V1VUVKdmZmaHIyenZPN2g4SmFR?=
 =?utf-8?B?OU5SNmc1ZEs2YkJXMmZJWEttQjF1QTMwRkkwOVNzSDRWZjhNT2JBdmRrRGRn?=
 =?utf-8?Q?Vkvnh+FkpKdr3VegXT8DTQn2Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b831f83-d668-4a06-c29c-08dc4ffd74ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 14:35:18.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Srn4DMht1ATElsRjX0wNl3Khdu1c/ED9Ma8Vcmx1YvuUEoJVgSAN23DV6tJabFW6rPBFJfYlUZlWo6pfo43CrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Update 3bytes buswidth that is supported by sdma.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
Signed-off-by: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
Acked-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4f1a9d1b152d6..6be4c1e441266 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -176,6 +176,7 @@
 
 #define SDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
 
 #define SDMA_DMA_DIRECTIONS	(BIT(DMA_DEV_TO_MEM) | \
@@ -1658,6 +1659,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 			if (count & 3 || sg->dma_address & 3)
 				goto err_bd_out;
 			break;
+		case DMA_SLAVE_BUSWIDTH_3_BYTES:
+			bd->mode.command = 3;
+			break;
 		case DMA_SLAVE_BUSWIDTH_2_BYTES:
 			bd->mode.command = 2;
 			if (count & 1 || sg->dma_address & 1)

-- 
2.34.1


