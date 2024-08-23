Return-Path: <dmaengine+bounces-2941-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5753395CA56
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB4C1C2459B
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C6187334;
	Fri, 23 Aug 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LHHc0G5f"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE8183061;
	Fri, 23 Aug 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408403; cv=fail; b=QuwszkQMyrFKwPoscx2yWHjw7ZunVWVvx5silAKbSEIYLHvpXhWF9MpeveQWD2Be2ZYIaFP2lb4duxd06TSpjaeBi/a4VY524XJmUQ56wHw6PA/gDr0tsVmqqjetMcYESBJ5NUeXN4lfXortE5H8WuJWGbHWaAj8lhoHpsDfoyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408403; c=relaxed/simple;
	bh=U0+aJnyMNlaQ0ryEudVqINsv0ZOA77eKMJq4/8+2bQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VF2ZROj5mqb9GpF5OF6IENqKF7yfU1AeLS+kMYmNY4Khp1zhfkhl2+iAQLX8BlqQih9ZYsQZA67phY9QDhtnMoBWjC2dmbEIV/yVN3Scq/DSXVkRenY6UMnuvhwdXMfSEeDa4pPPMxXO1hop7Myq3Z/8OccdAeFvwmrW7kUnDus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LHHc0G5f; arc=fail smtp.client-ip=40.107.215.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTy1U8PceOd6Is6gVcJ/pVpwS6G2RyFRDlwsxZSvSCemNJgqAfItU7l7bfVKnvzKScLNgRseX5zDaqmydOZ1Qta9LgbAqQkFg3zwz1ii2n/mr62pi9afQqih4fQ/edf+XdBJCLJdmL3C3y8LHIQWNk+07wJzlX+iP3cy1RNrf3+VvXXk2+uvxYSYLbGd6YCAKqM6zh6U7qin7mVCNm53s4Kgqal1yJ72tnF1Crh8gOlCaWwb7gEj5YVwSQ0yfvUInb1GlebgMDPZ3+Fwxwgz6EQuXeWhmW7bAProvhfki+gLZ8AGw30XTv9voZYwnwLvogyTm7twrfZv0fpkMsvDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD0/H4MaXwi5m6Lep224sF/IcLmCoO8d9kwLMxcXtPg=;
 b=QJkG6nOLyfXCr4Nkox0wdYntLIPAzg/4Rvntto6H3AYSfO3JwMwWwwhwWNKPbyVYjeM1z/cj+jNL8H0M8hxKkdGT9jdChxO9HsCvEPeeH+j8L+UMPLGPAxzvmOpcjpP+0Lc7zmCizhZ5nY2r+XtshjUS4vn/ZgGksYjzjln156cg9qN4+w5dqqZPXG4KnPbV2HpsV+yqJV5rVoxnhnaMnPmvyiwyNIENeMERsfV3QR2ZvM8EQBdV+1nL2BC6VP01Q03YtisDpuaBi1oR/F+Y3KsYJnyUJK9ceuH5XuFkvYm+Ebyl9uxZC/DOR8aw6O8otnAcTJVjWdDQe8K7J0wOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD0/H4MaXwi5m6Lep224sF/IcLmCoO8d9kwLMxcXtPg=;
 b=LHHc0G5f5kgn0hDrqrgQfx6vTGfytvAA5RaB2Q2xlRwimj6dVcWrccSnuIY7lGBqtPDXrKQFFdXHV6SD332qZRo4UjPygA08mi3IMFs7GHJ0Ie8XrGtEvRt/gIK4iW0PvqMCDE0NXrKW4HNbtB8f01ySioakuboaJ6SL9daS0ufsNqwNfrySIGVL04GtN2N9NclzyayjL7Z5f6Y6Ve//EQ8dUPxHzIKtZww3hlasoWXlWCteFjBWFHJj4yNywXMDnntSrQ8U7kczEzYKyNZDfrvxnMKCURJo7Z+U9ZTqH9c97PPLO98P1E9zyBIp3eMr7Hfogt6mX2ykr3ACGKz0SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYUPR06MB5873.apcprd06.prod.outlook.com (2603:1096:400:345::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 10:19:58 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 10:19:58 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 3/6] dma:imx-dma:Use devm_clk_get_enabled() helpers
Date: Fri, 23 Aug 2024 18:19:30 +0800
Message-Id: <20240823101933.9517-4-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823101933.9517-1-liaoyuanhong@vivo.com>
References: <20240823101933.9517-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0024.jpnprd01.prod.outlook.com (2603:1096:404::36)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYUPR06MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 515ebd5c-3e2e-4a03-2d06-08dcc35d2436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AfOI8C+y9itBALuJNZnai2Rtu7bUvRcMmVq4tbqEBTO5Pxcp3B/0wxYcYpu?=
 =?us-ascii?Q?UF3Pcmwxj8out6r7Z6sw+kHdVjf0j/iei5oyBQ+V/Y77mglGOaFi8Tf2a/sg?=
 =?us-ascii?Q?KGNp88MIoAFizaVa/BWDMwPZjnEyHXb01lDmb8VgWb08eefMjYhn+uBX7tym?=
 =?us-ascii?Q?5eZAlOJEu2gzk4scsuluEle7i+DNccMBCVbcbUAr8XgkU/Zs4WuCRPPptv/i?=
 =?us-ascii?Q?D4gvgk/596B9+cOoEUFzlsa+vJgRZpZNTL5EIOO/ZfSHEpL7EZ+nG2cgV2zx?=
 =?us-ascii?Q?dMFy1ftIMszGFFCEmfIuoGmmYQIWrcw2jW1GGeg3bs5ljG3RfReJIb1YZRf5?=
 =?us-ascii?Q?8r4rj2/jwSKqN0uXlbuu2zCrZFRX8NsuYReByHdbRWkZXTB9IokhDYnjHKka?=
 =?us-ascii?Q?WVEDFHzx681apM4e8OsLA/ZICimSVaEXtP1H2BErxXfhz1y+S3Vx0FNgiQ00?=
 =?us-ascii?Q?Bt6rNyjPaUTOGnQOOy2MadGn4VYUP600oOWrgDBlfNDoJpICf8FyytB0pBzw?=
 =?us-ascii?Q?rM9UYp8DQZ0xauL5o/MIKmJczw78Bqpq7QKSt/sG2datPOD50KPhsBfl6U37?=
 =?us-ascii?Q?h6KNJUAuwdUfL3PRzbNUZ+BdRUJ8I5aNeijjTsk2MocO843yRLUixz+P11Uf?=
 =?us-ascii?Q?doEI9C2oIV4j9psWVufF6i/RwC0OkxlrZfoCzgYvk8AlHGSZ8mAlN1022aF8?=
 =?us-ascii?Q?8w6NY3gFbIaXzVloNZlpBVQCGPDZs4PhjXPF/cV0bV4LSlYzocxqPclCBrYg?=
 =?us-ascii?Q?Kh2blivh7PqgOmPBMQV+qZJAoo4QUzhQnXPr10URStnF6VABy4VoKpVwy4tV?=
 =?us-ascii?Q?hn5QUAshleQegpSkcVx1JofLaHWObGrSy16eln28S7Yt1digENYrBfhqP878?=
 =?us-ascii?Q?sqBRwYdyScrPa+keyqypVub9R+2GKtTs2HQi1AAfEWFr3jck2W0hiiHldXOP?=
 =?us-ascii?Q?2f8itlLyQSFv+VnB79/6wlLPM+G+gkTzLi66WPF/6V7sCPk8/6M2DuAeWULP?=
 =?us-ascii?Q?3gUKv2eg8wvVvvIY4BYj5dCO4Spl+gfalAGtByFSZWc9/5VD43dL6B6w90GK?=
 =?us-ascii?Q?OQ1g9M4GqgKTpGau6O29rsULLKUkyNKoMrUeIk5aPVgq1z6167+NGcEsaTPA?=
 =?us-ascii?Q?cEsL4widQS732+tM0Gup2kV5ocw1NxOGBI/Cz2ErkOakolAyalIeZkO0f4um?=
 =?us-ascii?Q?P/8MCnmLQC687+lp/0DXnySr5gWzxHave8Lg73lC5cfj5l6msjX8MwPESHPF?=
 =?us-ascii?Q?gj6/Gz3wfFlwTVlDhw4M/9DnOheskIy8lK0NLgFJhliUWvZnhO9esD0GF94J?=
 =?us-ascii?Q?Kg2kvhsocl0Q6knZWKz6+TELZNuHRIDmqkrzHT3UXoeIn3AZKLVuORP3G2UT?=
 =?us-ascii?Q?UinaDxRi7o0Y6ZKj2ncKKJHqs12gGeNrT2XIL6SKmnk8jWnyyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2+phClZ43eQFr80FC3AcqTIe853fp5zHdZuB1Xb/HneNyBxtHBdVkPynKV/r?=
 =?us-ascii?Q?5Qyn8yXQB9ydXVjK+H8kt2GKHyqJ0ROmxkvMv0rmx3vWHfJZR9fKQiIHYnKX?=
 =?us-ascii?Q?rfWvJGKXjicjqmVX0q7JoDaYqLCY5UsOEL4FxzQS9sIffkc0kYZLBZsM6Ss/?=
 =?us-ascii?Q?TIzgDBFmr2c6BzW0F7kvhWO8ryRWQYyWfmZQr0jOi+wYoHA55m/J2lKcgei5?=
 =?us-ascii?Q?AZXrLrvePcwLacvuyqk09nQXaKP9b5gJuv9MNrNgSPLyNmeTc+0tjUZgjd1R?=
 =?us-ascii?Q?r2TozUQGQ4/OYRwxyUFSpkfVFU5Q6S/oVU4TUvlhhk71JQoMlIEKqQ2hdahb?=
 =?us-ascii?Q?nKA/273fRjD5utgnBf1hdcUVJOm5gv3g7fpNdeQj8n8SPSmyIfw7GcV1wBlo?=
 =?us-ascii?Q?8DMGeGWaJqreMsl+3+tl6F2F+RInAZ+MWdP7kZ+cdjUZYxZcQpQD/E1knHrq?=
 =?us-ascii?Q?TGbnyJHD4BXGk5dqzFBFMk0us96/V+2YOB3x9iYHmRnA2U8u0JjluBsNfpr9?=
 =?us-ascii?Q?iVrxpXxjsSEpmOdWBW2hGGhyzJqftVkUKLtc5jFZoK7gYcFbNjxaqaddpT4k?=
 =?us-ascii?Q?ZrGBNkhO5lephvvJoWT3jmWI0wDBR2voMX4v1V3I7YdmuugjaKGXAPpQJLpa?=
 =?us-ascii?Q?9PIkORF7vRvPt3zmpo1PIbgmDlqnhxPmxDlZXnbYqNRHRirPDZ98Sd8Zx/aT?=
 =?us-ascii?Q?JaOptNIU7xwHaaOt64Lpeu/dah+SjH3zzCZUHnU7dcdcYF4sVWb11T+XsFmV?=
 =?us-ascii?Q?v8424odIyd0jbHyBmvyxDpV0xjJMxMPy0AsoOH+fte3bQFVWAJjgLMygc6lR?=
 =?us-ascii?Q?y7+uN6wCHwsqOI5TM22AzvUexAnYT+wgTxv0tHnUSGoLoeIe5RbVDoXi+/QM?=
 =?us-ascii?Q?Aar9GlPXBxYeiS/5qRuX+auwfXu8WNCbWTxOOWDpVJNbtPnXozDNnI/l0+h8?=
 =?us-ascii?Q?mGHbc5EHbo1TOdetKptc2QpafXjP/FOcgyjuogQNLt0uXR6/7lc4J8zFysHf?=
 =?us-ascii?Q?6bVNOhlekFz4Oq+R3U0Usum3KxykcmiWccT7YTUj03k4Ip2wcRP5Um9PVCal?=
 =?us-ascii?Q?fE0yCAF4vW/QDuKdx/zA/nSE58Myots8TmKYVgazjuOSDlDbAvDhn3Yncrpa?=
 =?us-ascii?Q?7WKBatj6R2UofSOfFtlPJYJyCzLyRBTCeRWRGMDisaxv+FY+ookMetQdIpyu?=
 =?us-ascii?Q?1eB53Qmo1zr0I4Er139VMaUmUoDRNPxBJyMNIROjMqb2ZyJhKZlRwgWYl02V?=
 =?us-ascii?Q?11zJjk391w99jvYpLGbYumEUdiSOp2fcpfuO55CvuYMN+WgPfhUOWbw2zSDf?=
 =?us-ascii?Q?xZQkTvhi6bOjDTxFI4mU6e12dTwFbxbKeG2SyrUKz7cxbVgP6490E8VVzzHJ?=
 =?us-ascii?Q?2szBqMR+SFv4DAFqQDhDLYCA7nW5NqtA1/2mto/HfezBDCnNXAxJiGKfdbc4?=
 =?us-ascii?Q?H5sPiWaaFVf93LNJ7IbhnUvmK03voNnu4fOUMudRbdjn+Ki0YkWXyB5QaZVG?=
 =?us-ascii?Q?7rrhHUgkdYpgtPAjvr9B2HyYnYUtkeQIgcgSOlSDVsu0LaYbCaY9Bu9l64j5?=
 =?us-ascii?Q?/PwtE2obQhdAFhTSU8v3QH4yOyTIPSbmpICcywOU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515ebd5c-3e2e-4a03-2d06-08dcc35d2436
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:19:58.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mnFax6UgzTXQotG6eIVwO3urDE2lp5U5zkBE7I9d7sNgfbT+ykKfJESyw1Xuz9NB2TU0mPcRUU0eX+Bor237Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5873

Use devm_clk_get_enabled() instead of clk functions in imx-dma.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/dma/imx-dma.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index ebf7c115d553..1ef926304d0e 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1039,6 +1039,8 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	struct imxdma_engine *imxdma;
 	int ret, i;
 	int irq, irq_err;
+	struct clk *dma_ahb;
+	struct clk *dma_ipg;
 
 	imxdma = devm_kzalloc(&pdev->dev, sizeof(*imxdma), GFP_KERNEL);
 	if (!imxdma)
@@ -1055,20 +1057,13 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	imxdma->dma_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(imxdma->dma_ipg))
-		return PTR_ERR(imxdma->dma_ipg);
+	dma_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
+	if (IS_ERR(dma_ipg))
+		return PTR_ERR(dma_ipg);
 
-	imxdma->dma_ahb = devm_clk_get(&pdev->dev, "ahb");
-	if (IS_ERR(imxdma->dma_ahb))
-		return PTR_ERR(imxdma->dma_ahb);
-
-	ret = clk_prepare_enable(imxdma->dma_ipg);
-	if (ret)
-		return ret;
-	ret = clk_prepare_enable(imxdma->dma_ahb);
-	if (ret)
-		goto disable_dma_ipg_clk;
+	dma_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");
+	if (IS_ERR(dma_ahb))
+		return PTR_ERR(dma_ahb);
 
 	/* reset DMA module */
 	imx_dmav1_writel(imxdma, DCR_DRST, DMA_DCR);
@@ -1078,21 +1073,21 @@ static int __init imxdma_probe(struct platform_device *pdev)
 				       dma_irq_handler, 0, "DMA", imxdma);
 		if (ret) {
 			dev_warn(imxdma->dev, "Can't register IRQ for DMA\n");
-			goto disable_dma_ahb_clk;
+			return ret;
 		}
 		imxdma->irq = irq;
 
 		irq_err = platform_get_irq(pdev, 1);
 		if (irq_err < 0) {
 			ret = irq_err;
-			goto disable_dma_ahb_clk;
+			return ret;
 		}
 
 		ret = devm_request_irq(&pdev->dev, irq_err,
 				       imxdma_err_handler, 0, "DMA", imxdma);
 		if (ret) {
 			dev_warn(imxdma->dev, "Can't register ERRIRQ for DMA\n");
-			goto disable_dma_ahb_clk;
+			return ret;
 		}
 		imxdma->irq_err = irq_err;
 	}
@@ -1130,7 +1125,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 				dev_warn(imxdma->dev, "Can't register IRQ %d "
 					 "for DMA channel %d\n",
 					 irq + i, i);
-				goto disable_dma_ahb_clk;
+				return ret;
 			}
 
 			imxdmac->irq = irq + i;
@@ -1174,7 +1169,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&imxdma->dma_device);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register\n");
-		goto disable_dma_ahb_clk;
+		return ret;
 	}
 
 	if (pdev->dev.of_node) {
@@ -1190,10 +1185,6 @@ static int __init imxdma_probe(struct platform_device *pdev)
 
 err_of_dma_controller:
 	dma_async_device_unregister(&imxdma->dma_device);
-disable_dma_ahb_clk:
-	clk_disable_unprepare(imxdma->dma_ahb);
-disable_dma_ipg_clk:
-	clk_disable_unprepare(imxdma->dma_ipg);
 	return ret;
 }
 
@@ -1226,9 +1217,6 @@ static void imxdma_remove(struct platform_device *pdev)
 
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
-
-	clk_disable_unprepare(imxdma->dma_ipg);
-	clk_disable_unprepare(imxdma->dma_ahb);
 }
 
 static struct platform_driver imxdma_driver = {
-- 
2.25.1


