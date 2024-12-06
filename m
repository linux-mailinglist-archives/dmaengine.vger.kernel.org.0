Return-Path: <dmaengine+bounces-3917-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2499E6941
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2024 09:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEE31648CC
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2024 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17741DF978;
	Fri,  6 Dec 2024 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S2TPzT0S"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810519ABC6;
	Fri,  6 Dec 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474939; cv=fail; b=N7I9xEzGGJhKOVj45RBX5ApOJjyEA5Nrw1lYC9YPzkLqXVWPrSA+TelqWO2kTw5OZNq+jTxVE4bHDxrzCK90wvUg1B+A30nMe2ff8yMBaY5mlTfT2TYffv7f1rQUxIPX8i0hLNNlTLuy8tFlbLDGjZiG1LBdbVWhU8xZAMd0iaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474939; c=relaxed/simple;
	bh=Tr7B9ERWtXV9fytB1VL8OYTOWorWfCTX1R74Hcyr0iI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+EcUY5njLKvNewpnxc+Or3wZduPU2Af5mmy3FlBDsXA0SzgWo0R+40n/8jOb3xcM9qAtQ6VOPCHMqDOmwxjWO7Q1M1C5snSg66mvI/8VRabbXGsfXOgGN+nmhUgHSO7zOpjq59OliYgv7rXQTeqIFnCK8CXcPFOkFiOVc7Bav4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S2TPzT0S; arc=fail smtp.client-ip=40.107.247.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBSHmWqfyLhuz0DPI0ITg97Hprq0bF+YC0S0hze9p6t+ZxcgJlcao5wz8HMnykMaNG0cP7pu371KOzg8ts3JSy/RQWtn/dyNQ/BCXeqj/j4a5fswyJqHloYKavqhudFU8sHesS+/q36zR8YejcmktG7x5knkGZV7kHmS9e6658xI0uPTSOP5Bj+9OK6kShYb3yAmuoBtaJm8kne4uw2mQ8A463+Cx6fs9IBKOnpg97b9f/VUtebGPTwzcANDeEtPopeQMQGNneyGFwtMOasXIDrvU7SkoWxSofbSS2wYv7tUrtGEy7R55uZVw5JlswdPV9mpRu/COdiasIk/1fPB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqCGfV4CoGa26D5xYRB642zCvwy3oUGLjXqpd2WvmL8=;
 b=ESW3ffsVT1QJEMtTyQD+Lct+VkD2BxX4MS7LjHbAyKB5ycwKoEizv9TPmVk8LdVu+apq4XgQNgSnvKKe4LyYasRhxhS88keO0aSGhLRIaHGt9HYLHSFqxCZtnltsJhrJhHKDXWWv8Bao4UBmkqGnef42gWrTVPfFpvFPIzjAcxIfTb1GvN1pHW/+4a5g8GWbsHa6DxXKckpPe280uap74oaSVFhEvWpGie40Z8tkgfta/YDDj5P7sFenK/hZWp4J/Unmmr83NH+ndTyjagQognWFTorwBa8oLlfQ+qRdISR7ouZx6gQJAB1D75BFXq9qMzdBO2eChs5VVh168kvVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqCGfV4CoGa26D5xYRB642zCvwy3oUGLjXqpd2WvmL8=;
 b=S2TPzT0SvNoNoG4AAB8JZ6BoJBEKjlz+eFxCP1th3yNVbymp0FVe9dZH4kbsExd6TKe9GveJuUHzOVbf5FODMfRfYMwyZfQdn39s4d64aOyOKbbcdtuU6an1eUlYzkS0srs8Flc9Jm1mZIX/gUc8aBcezZMDl5VgHyfH9s9VPAWaT0T0T1eYTyw5+dJPmmpseRZ1EqZnZyaH/sT1bxcZrfERslPFQ2jdoYcnaM0s3QAAbgmfNNqhKL4NIDWxx71E2jyH8DyTSBsWpcP05ZQ3qftpIPR8KvsNEW8YanB3EVFZWzeC1SSleKMNwRBYclinVN2Zq6vgBZROSMK8q7n5DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10301.eurprd04.prod.outlook.com (2603:10a6:150:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 08:48:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 08:48:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 2/2] dmaengine: fsl-edma: free irq correctly in remove path
Date: Fri,  6 Dec 2024 16:48:16 +0800
Message-Id: <20241206084817.3799312-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241206084817.3799312-1-peng.fan@oss.nxp.com>
References: <20241206084817.3799312-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10301:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a729444-85d7-4cfe-a587-08dd15d2ccb8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?phGPYVUhEWhuu98bwPCi9LXEloLPHhEhV4/BaDvgIS2ZSuQEgrK6/wHTUSJn?=
 =?us-ascii?Q?BhdqS5pYGJZd8fkNFKQ5tDC6T2bkFjgoqDJ9c8XD0g7J2UB9Fhzd5sbNQ2BH?=
 =?us-ascii?Q?OBsgfG2J674pIcTj6pJmxb7LpQMz67eRx5xly+IghrAtZSVgmhM7bZets4gj?=
 =?us-ascii?Q?gfySFsAVhwcOrVSW3ASb/Y8FhXtXLiCMy36Mjn0U1BdSEojyYThpXdCwicVT?=
 =?us-ascii?Q?psu5SxP0SA7ttjG9JwFbpzUZZv1czeCXWXlzTxk9LfqhyRiNRw7Zb+2peT4h?=
 =?us-ascii?Q?8IqMQGZKMjxOHu1s7eZxKL+P9dMJN8EbMU8dmvxm4og7nIXKl67d3WkNkAB9?=
 =?us-ascii?Q?rtO5YCGpt2px8WVxbBjcGPx8lGQS+eu8/ZPbwUkPXCgzRnF5G3ptGpJ/Zycd?=
 =?us-ascii?Q?rI/Aw13PBHSHbijYSGGU0mxK1H7v4yS2UmpZMd9RWentEVUUcPAkmzBXZiwg?=
 =?us-ascii?Q?/eBmuAuq5ZCfGVXiYBfJUI/PkE25WJP7TY3T6Za2U+TaYl2ytFISz+2tZRQp?=
 =?us-ascii?Q?ks9uxZK6jaNzRYds8vgdr4KQkv28YMqP3dymap0wrXiiWZh37z6bphf+8AgY?=
 =?us-ascii?Q?aQ9KPm0c/R/3MGJJ8ZCBDJWhFmslZu8CSofvLO8eJirNSiRyvQRMHPhUApqb?=
 =?us-ascii?Q?FMvsMPfRJKqKTap1WWhL5DvJh0rBX7S+p50qEeCBIB14jAaCABOaAIfrcaJI?=
 =?us-ascii?Q?ZgoGCDUsXIv7q1/knW/WamQ6V2Dnk9w+iyMjLl+N68rC7xI67z1hDZ16SNAD?=
 =?us-ascii?Q?lPQY5kilTOfl+5flWl5Z3lOEDYvnPpO3WVqHrxRhWgnt5Dts4ue28XSPYKcf?=
 =?us-ascii?Q?5IKr+g7B1+NK5weJMvNjZ0LGr6kyCr2y/yNzGO85bQ9FhJu1SxLW2X2352V+?=
 =?us-ascii?Q?afIfDCcl1YjImDuPrFnbRw8MQi8RsUc1LFIh/6s5Ibwk4hpc03qnraDBvIfx?=
 =?us-ascii?Q?516YxbN7q/x/WEps81futhzuA3inM0kUc1vYrphM41b5JbJLtLQf9GpN6jR9?=
 =?us-ascii?Q?5ZKmzFkGZXajEs+AaCse9FGFzvbQmgpbxDsoDgNs5L90xJ2D3HQR21Zxrd+n?=
 =?us-ascii?Q?May+wprKLEKYKQyO8iJdVvAaG/jBWUTadIRSz82dPMaHTDJx9j923uBrUwQh?=
 =?us-ascii?Q?HZM83H9nDt5U/mNWmCOx6YcHf26a/XaqXSLT6jeNlroDooADE9oUNJkr5W1E?=
 =?us-ascii?Q?IWQbVLvIP/93cvv7lrYrxrKXxXos+znFAsg+y8u92qvjNwpGXGDNLvjMe739?=
 =?us-ascii?Q?4WMnUDqIL5K0Btr61XFkC2JNm31qwwydmyR8l7e4XjaOJbjcJFt7446bE5Hh?=
 =?us-ascii?Q?xjDCjBHNuA1xaSVwNjtM1Qa2y2yrq2xcYMzXuSwi/e086fn4qAfMkxXhjGGM?=
 =?us-ascii?Q?PJD80QUJnTPVXQc6L2DocF9qvL59Z7pG87F6ots1XLrwakT+Vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1pmmAexjACUnKK9WxUWrz5/nKc8fodyBR/sc1CPcXsNbTOdKdhnNrwoBuf+p?=
 =?us-ascii?Q?Y1WNi31RnByuf+Z/EIiFfEa+jpfSg5xZsAHQMM0hcfxNYN7+nVWBFIAwhixf?=
 =?us-ascii?Q?Wa2hvSErW3MnQtjnXJmnufifSj8YciuVqP6nQoDtR9n4d/ZabtHnr4L+Sqij?=
 =?us-ascii?Q?EvwmETpXF9i75+90oPMq47UU3pVKrkWOu6cewwggFT0B35eMXdsf9uphDRu9?=
 =?us-ascii?Q?3M+dWeIVx/in3sdHNGrxFIlnVspZs9wuaz7vPdYBCbc5AWTMpbw5NSCAVSJp?=
 =?us-ascii?Q?XrVq2Ykx/m98ao8UWdFp0PNfpPbQH+JKvl393w4E/1XlGY75Q38IvEwtzIlU?=
 =?us-ascii?Q?F1wwZqvSnfXcXVUYUAUF2L9ty7C1Z2df0D1tyJCKSZUZQ2A6MkoSDJnVyZ96?=
 =?us-ascii?Q?hp5jt8wc9/je9g2xns/DCxRKZROJqOrTo4NVZLv5R60W39s6orev0rKmuOOH?=
 =?us-ascii?Q?oIQRTcp9FuW+Pipuqevvs2aPAy9kkeWm6eUTo5U/cBggyWkZBYKF9SnKZO06?=
 =?us-ascii?Q?8Xs82XvLUEAwn7x2HukhJ7MbEqZhFPDl6gxR4Y9vFmufJSoAwzPcHS6qdes3?=
 =?us-ascii?Q?cN9Pyq7sGg/eqGv2JBlKcUfaQSa1/dm+X1+lOFDn+D/pE9Ayp11rM57ZSsiR?=
 =?us-ascii?Q?gFdJADSMPxSqkT0pvNzVuyusaFduG9CH8E+wI7U/sv9gsuoANFOTT1LPWujd?=
 =?us-ascii?Q?LhTNn/Seb5o58k3trnmf/w1EX9QFR61ZCalo/Wqb6AAkzl2dqf3z6og9dYJ1?=
 =?us-ascii?Q?qjCLqdRFdq528Ca23aeDoipuDpbUiyaMgPEFockM98ndq2VJTq7DGrdWdCpo?=
 =?us-ascii?Q?VC7Xsc0FmpwhSnTIR+UuUOUbzS6TCD1VQ+Gw68V9wjZCVWcld+ytTtA2Snhc?=
 =?us-ascii?Q?QgXUsna+pGDY4CwnRF/Yl6cpRXPDfm/jLBtRVrLVdi5VnbVeBrJdX2PvQAtV?=
 =?us-ascii?Q?Zzgxgt7X6W9Mq0heCXPZ50iEnAp6m+rY/4DPaeX7n5DF1Lze2KJYPBqmknkR?=
 =?us-ascii?Q?iSvL+RtYJt45aRLa33wFQWLPwiXc6UfgwqwDFoOYNtALR9FgFl6AoyamC365?=
 =?us-ascii?Q?P3WHj/ixwXbRdl6vRP0YaUDT1arTeE1bGGeQ2fX0XwD16mRnMuUBAstydH7Y?=
 =?us-ascii?Q?CBgoWxLdE1v1/Ojfhps5m/QhmwuuzahDPRbW+mtg3ULTdxzqmYKaxJDFuctg?=
 =?us-ascii?Q?qZWFPzju+9Oc7qpt5t3qyGE2+HhZW2bNguIBhplwnrhgY2bRFxLtopjRXRJK?=
 =?us-ascii?Q?qgX/92OkIU4vpuQetGnAdkWCUn4LRhOgFbvWP/IHAa8GUqAaG4lUjVNNzelY?=
 =?us-ascii?Q?mY1zr1OUtFS/+lWTM5NxDGmk65L0CNNGs/m7h0SMSJSuz3Ko59mrh9i3SkDr?=
 =?us-ascii?Q?H5SoTlwN4SZVImODU95Rui2BtK9GZXUHNDUYCp8FJl5RxAn48uGDF1LwABUb?=
 =?us-ascii?Q?pwwWJZ5aHv90f2+GQgfTE+btFoxAvNNTF25K3UAzrBk1zQyzDoteeL1OCcGm?=
 =?us-ascii?Q?19YBlELg+eJogkyCjsLrpvvOAi0/1n41iKvKhmfc+3daXq2fC7Q16adQjl/l?=
 =?us-ascii?Q?iJkUI3GuKX0vrtjodfCC/wYAskXsxzRicg5bf4oA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a729444-85d7-4cfe-a587-08dd15d2ccb8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 08:48:48.0609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9mNDUuZDNEJW4UngdyPDMQaMKFr2QrhjVlUm1xGh+jxy9Dz6/EMA8hl9NO7bvrFStbcsZKg/HsckCNx9xrVLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

From: Peng Fan <peng.fan@nxp.com>

Add fsl_edma->txirq/errirq check to avoid below warning because no
errirq at i.MX9 platform. Otherwise there will be kernel dump:
WARNING: CPU: 0 PID: 11 at kernel/irq/devres.c:144 devm_free_irq+0x74/0x80
Modules linked in:
CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.12.0-rc7#18
Hardware name: NXP i.MX93 11X11 EVK board (DT)
Workqueue: events_unbound deferred_probe_work_func
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : devm_free_irq+0x74/0x80
lr : devm_free_irq+0x48/0x80
Call trace:
 devm_free_irq+0x74/0x80 (P)
 devm_free_irq+0x48/0x80 (L)
 fsl_edma_remove+0xc4/0xc8
 platform_remove+0x28/0x44
 device_remove+0x4c/0x80

Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel IRQ only when channel is allocated")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
V4:
 Update commit log per Frank
 Add R-b
V3:
 Update commit log
V2:
 None

 drivers/dma/fsl-edma-main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 3966320c3d73..03b684d7358c 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -303,6 +303,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 
 		/* The last IRQ is for eDMA err */
 		if (i == count - 1) {
+			fsl_edma->errirq = irq;
 			ret = devm_request_irq(&pdev->dev, irq,
 						fsl_edma_err_handler,
 						0, "eDMA2-ERR", fsl_edma);
@@ -322,10 +323,13 @@ static void fsl_edma_irq_exit(
 		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
 	if (fsl_edma->txirq == fsl_edma->errirq) {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
+		if (fsl_edma->txirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
 	} else {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
+		if (fsl_edma->txirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
+		if (fsl_edma->errirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
 	}
 }
 
@@ -485,6 +489,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (!fsl_edma)
 		return -ENOMEM;
 
+	fsl_edma->errirq = -EINVAL;
+	fsl_edma->txirq = -EINVAL;
 	fsl_edma->drvdata = drvdata;
 	fsl_edma->n_chans = chans;
 	mutex_init(&fsl_edma->fsl_edma_mutex);
-- 
2.37.1


