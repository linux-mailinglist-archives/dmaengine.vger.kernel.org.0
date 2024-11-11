Return-Path: <dmaengine+bounces-3700-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B247A9C3900
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 08:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3CB1C2164E
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 07:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FEF15B119;
	Mon, 11 Nov 2024 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XtimhoX3"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211B9159565;
	Mon, 11 Nov 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309990; cv=fail; b=bIiueweOwQwEwwoccBgSxG/gqKhCmEgpX2zwjrDDwRj4t0pl/S092stxQG8vKToanatBWeO/EQKr6Jk7tDAc/9wvtXQWafBddRjAFAZoNT9lj3TXyqb8xc6peJIbnqh+PyhR33HMkBvpAHpNFQp7qrECsD98j39qCfvvLAiOBmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309990; c=relaxed/simple;
	bh=FOyOG3TgFJuJKd/0OUNogp+OkjAaVab6ZqYcwd43b+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fZQGvjsjpCF3/uNBcL4f2wSedzEDlBnH0JNioCe3LITwliNr38rMhr78ZU+8BaXcHfdjcliSsToCdOpPAMZbsXV9xaTvHdkMOSismvC+67qdyOU2MpPmh+z4ik/tdV0l1oGj1EyWvZBkOBM5SQfimMHTRgYJhH+cM/gkrIJYOMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XtimhoX3; arc=fail smtp.client-ip=40.107.22.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=borsMF135Y/3Eah++yzle81vdWffu9Yn23sEvmW1gnfMe0kmPsZNJMttyh9tIEi3iUnX19a1lsJZX7NL78kGGPWEfVbmvZnR909CO9YJsbNY9CEdQ1hZgRzu8Z2IZooQMMbRgKIQf/Q5Z+pmEPSn4i69643f8Uvco7dnbuSJgmfHySPQMDms2cUMjP1GBBPadaC6LGKYUTZ7sxUk3OpsYWCCMPtEvXUWCRF42e0P+DhoLk6p1m+OoHjWnDJiuTLCPWahV/7lgec5EwL+4DHgj7fxDWOOar+9fwssSs34ehUhmTW/ntlYmdZDvRpb28lZ+/Khp9NigE7yAUrOGLK6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BsncxoQ5RypthZkFgD6XkknO2HJScoLYoedKX2oyGk=;
 b=psRc6/nniT6Rn8vQK0cTlE0jwbFGDtEzFo8XsUJktAjkIEJ4A6C4sd5UdCyeeNvKOphkRJ7QoIr7ivE2n0r5Nn+KYD5apzoBrYII7tJr5fLgtAh4yIg8dzTtP86hE9dE7SrGGF1qv9TUEs2w6nmU2HGMw0AfjFZB4gUNKGPmAV8NG0SGpLBcPm5srMpYJd7i8DO93XTGeyZKtRyiVUwl+qtzQ1cJ5/0zg+NqESyrEpXPN2anu43wdbmeMfeYeUFLsfYgrPqVNjBMW1rBXXR5r0CtJHmPsOFvR4ymnM90hPF+K4TPzvnWeBR6rDeVCtKvQ9yS+1Z/TZ9LMCeVxlT1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BsncxoQ5RypthZkFgD6XkknO2HJScoLYoedKX2oyGk=;
 b=XtimhoX3VxQLOTct5KVqLDy52f+ZfNKocwF8xh4b9Chacp+ymxSOepWdvaOqAn4/r4shQMH82H0xphSIvw1uhT5vML9HTFEnOCHCvkbts7ryf+azLbAtlTRe9RN6OD1LUYAlwN0VyWR89xAoXBP4EwhYdpRVi4bOykLUblEiFTtPx3v/Jrp7p2wvZ8qsQ15ruLQU0z42HREflUC3l0Ay6NuX0hoq8YF1wLW15O3hxg2WvIMDlYKbB4Zq/xbqLbtNZrXumPEgQ5LV7tpqH/ILx2hcvYBEDTniBqrY49sTZtxIBjHj8iyF3pvZyv69LhJ/u/TEfVXH4PzsUfswkXCwHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7920.eurprd04.prod.outlook.com (2603:10a6:102:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 07:26:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 07:26:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] dmaengine: fsl-edma: free irq correctly in remove path
Date: Mon, 11 Nov 2024 15:26:01 +0800
Message-Id: <20241111072602.1179457-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241111072602.1179457-1-peng.fan@oss.nxp.com>
References: <20241111072602.1179457-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dda946f-d1fb-4127-24b3-08dd022225cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cOw+bCz8UfqJnVjLu1xM0PssJPTOHvCMCa8tto7prHPnmwbA7deoG2Lyt92c?=
 =?us-ascii?Q?B3+CD/QqpBfoe6I4dZyfv9TkP1WnoeiD7sRmxDolWW/qYGg2avAYChzXyYAi?=
 =?us-ascii?Q?+9jtjyvhryc08tT7Q+Q6Xpg73saa8eOySMKRKscL0xnht/sFXnIXEdSi/98f?=
 =?us-ascii?Q?gHXhQ3X12tTfTVaf9tEDmgpO2j97KB7L3U27DM9TWruk3bRqMqW+LxUQKXVs?=
 =?us-ascii?Q?VsdLI3HQParoXNMPV59EOEynQ+TuVqCgPpMCb0LZHFnJ/QhlulktdVjhuBy5?=
 =?us-ascii?Q?gosdUuYgtL0g8gDFkspMIpV4J0eACJUV7+MRq5SbtslIvDhLMbgeqS55BFMs?=
 =?us-ascii?Q?+ekuCt5mpj1jc+G0UGr+uCfsWAW2VPY1q5RnLFIt0T05DP5AOFQdkNTpUDoA?=
 =?us-ascii?Q?OMCICLvuDUe3QCRZ2FkLL7wI/TVzsqCac58nNsg8G5f0ynLAuUSWb7wz+pyv?=
 =?us-ascii?Q?ogFSG40wkp2QlT1DkbEz53nAXfHGDuGVRLHe+1rQMsGM8l+UsgHE1yYd3CPd?=
 =?us-ascii?Q?fHRha/2m8h1v/LNUHRyLNUyigsiFW6G7J5sBBO2w1N44t4z6i0ECz6qaM48y?=
 =?us-ascii?Q?nPhDPgLBmCd8GMPz/Lm5M6aectdJelhATmVe/PunudgvEUgDb1PPI+0bz9iG?=
 =?us-ascii?Q?lbzqhki3sG7hUvxzHDQ/wwx/SLuGdbzINfSq85G99y2A9nAg+7ybAT0I/xJa?=
 =?us-ascii?Q?fUtoAayZhbVMgdlTQehEHA59zunGdeY4B88nCeWIAyYosYhQaCPrDGz9ac1Y?=
 =?us-ascii?Q?sT9g22Py8rqBAFn8TD/TQqTjN+6y/6GklpPoqah1LMPXGX25Myw8StNilqlv?=
 =?us-ascii?Q?56wJEbBJa9QU4BAuDHQkOCdlUa38eNStBKqQf5wvt14Z/CHzttde/v4yiyFT?=
 =?us-ascii?Q?JmcZLQFFwVj3MyLQQO+ssFfzCDj/G1ajDzebxuj8WZDf84rl04iNHCqir44r?=
 =?us-ascii?Q?Tyg+gMRL4m5wMxTP3SofGUK6SRdynzyzuxGkSlsXN4ajK75d+qDPK7GC0kfK?=
 =?us-ascii?Q?nAeBXdf74kYJJzDklkz5zTkOLhxKvlJwIMTMst6PUN0u5NF9FcU36i53DZBV?=
 =?us-ascii?Q?x7pJdjCLFV8TcrpONdQPGAnxwLyL77kqVsy9gI0wt7n7E3TjZiUenelkg6Kp?=
 =?us-ascii?Q?qxajLHK60AEi2heNzpu9Fl4d+99nddM6cDXDG6Z7eJPfNU4q+jlX/p7KmurP?=
 =?us-ascii?Q?sVEbViEUxOu84vqPGcYjzlNYj3bIEbab2rmgqB3tRhYEJVKOnwXH2gtpD72W?=
 =?us-ascii?Q?x277Ge0fD9HYyjOy+1kL+YZIHEmpyndlz1hVWnAKIpxg4dDY6sLb68DpKk0Z?=
 =?us-ascii?Q?A3nH+Vn/fRI3SEg9h9Y10LrYsN85AeTjIADu5SOd458bu8bW0YyOGZrpW0WE?=
 =?us-ascii?Q?a0Gcg8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KduvDRinHCTiBdSNLhc8dnSYrO0NcMTr1iJBCW3tqNrvly83kMnoGl/kAsnl?=
 =?us-ascii?Q?Ms8CIHPPZ9aL36Z85F5cXh35XDPExTqAw8MuxBqaTrR7VN1P5IwwyLgtHstk?=
 =?us-ascii?Q?ewfXbygI/dSoDF0zQkZxGo1/h1knidgAPL0WgyQOzxzZSf8xbpZnLY9DA1FV?=
 =?us-ascii?Q?0cyU+hxtMxCzt8tfm0LHAf7nZ5t5yycvdiELtj+a/R5n/pyGnvLU6s+W/KqI?=
 =?us-ascii?Q?iQIvTq+KzXo9EQll2ZoOhdRNI1B1PJyPoVlYu3X54MN/1N5Y+T8X2rU7cGea?=
 =?us-ascii?Q?1IW8muPnrJIYaj5Em5O9tWEtZm5R3zytUiS/LSb0ZK3R5j+q9EqNU+sHrHXY?=
 =?us-ascii?Q?/au68GRAWYuoxNA6VjIbdwu8/5G59FHqvMFew7g9l3A6d7Hzbi/3MNLDZTSD?=
 =?us-ascii?Q?S0Gfvnzztko9IgI6LeXIi+fLmqSjahAUzF4QfFbe5jiFIosZ5+m/6RsodMHz?=
 =?us-ascii?Q?4u22jRlWwa2h9NTGtgULVhfujD5FQBmWL2O0oUTJrkqEbEs9zObsgUuwWgMb?=
 =?us-ascii?Q?7SmY5IdwKqaKA6NVsotda7g4lV7FKqJSXndPLPz8La0D3SMBUIfgvy61tFBH?=
 =?us-ascii?Q?n8y4yG0rs36Nx8ifhnwC//daa8O8OcY4/K+YjaweLz3+6d21Jt4L9f1G2Wn3?=
 =?us-ascii?Q?6TfYQDP/D4zPRSi1vYeUSLGx9P8lqkEFb78hNapv+ADeLekpRad1XtY0+vr3?=
 =?us-ascii?Q?8JKfRLUpEfR6mLGNDPJYZwkpJ8nmUPEZTSAF8r/AGBxq2ji9ewYtXWgKdd2i?=
 =?us-ascii?Q?x3Z1iG8FdiQzQWHn52V5lL1SuTJf98KXPmvzysWjg5srIuuvWMTUXb3uY50e?=
 =?us-ascii?Q?1gg6Y15rvtBA47s4h7ApVK8MTHCE07PGPurvXJT1fLkgC1v/k1LNW7bU9I1Q?=
 =?us-ascii?Q?Dt8tD4nvMnGnhoIYpEGwk4AwaddchYxO8FkGrzHEL5GmrQZoTzSnrqDJTNbZ?=
 =?us-ascii?Q?F6FORkXd9XI1lyS3ZL46hLZMTuS1FwsOeHgZIkt6r9R3YjNCBjJmHdWpH/zl?=
 =?us-ascii?Q?a2qGS7wVdjQZmtmK4zE534sx0fgF6qWxiqJ8iFFhSPmzhn8oT+2dfipzeFyt?=
 =?us-ascii?Q?45lQraUGPjraExTmDeC3jLKSpxM47CYsmeMdqrh8QArYjaKi084O4AKZSX96?=
 =?us-ascii?Q?2p9txoRzy9VOtwuVMrpFgzcKHvopuX6lgHJ48roJ6ZXyNGoPaUUuCY41tzgL?=
 =?us-ascii?Q?/m2xHoIxY0PbPSwBwEChJET+DQHO0F8ejivRPlekVBzUXzE+/OwXSgfv70ro?=
 =?us-ascii?Q?WkL+HtwAdRX12CZgEH911rRY2f3XpT3hxI2Knie/m7OZ2unIUQTAabgPms9K?=
 =?us-ascii?Q?2G5IE0UxJCmYn2rWP4xV8e72uz7ZVY31uNlrZiJ3EmaroSCmcrB+wTninstW?=
 =?us-ascii?Q?5OXpvnXO2v+fDFMfVMvNZX/NMOEVszIEwzYNlG5F023UL5loMRvhuPJI6lUg?=
 =?us-ascii?Q?GlrGqEbjcYih342jG6B9NYCP8JqC6WrbvXA6rVJI9Cy4p0ymhJUvvRfb57Km?=
 =?us-ascii?Q?VAeg6hCCZNSzJX+25FFW77DvmPQuwTV9EcHUJ8dlSc1bmQAzD6bTa4nyBgdO?=
 =?us-ascii?Q?Q3RHjBbrqpVOJ9HOW0d3MNhot8ImgXQrcK1N+UFY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dda946f-d1fb-4127-24b3-08dd022225cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 07:26:24.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl6LhtYXn5fuJHmLKKrHpjLcdtKW6R30BazFCR9W5e58xBoSg42zBdwJSaTJVpuInmYPjKctgjwqykscjKjPUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7920

From: Peng Fan <peng.fan@nxp.com>

To i.MX9, there is no valid fsl_edma->txirq/errirq, so add a check in
fsl_edma_irq_exit to avoid issues.

Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel IRQ only when channel is allocated")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

 drivers/dma/fsl-edma-main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 01bd5cb24a49..89c54eeb4925 100644
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


