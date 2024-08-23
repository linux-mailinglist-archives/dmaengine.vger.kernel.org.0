Return-Path: <dmaengine+bounces-2943-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3A595CA5A
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5226C1C21054
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7073187866;
	Fri, 23 Aug 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Tp3uEHIh"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA33187568;
	Fri, 23 Aug 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408407; cv=fail; b=XBnfJ/524nyoIbQfwc3IUmUiNIHBL1wS4afZxt9b9woW8Q04tXFlxHTuQCZIUrfrNcLqzY6CMPqN+76cFAZw8EuZTZNGdE1dQMQRD+em4uD/NKEgBnlDKUfCLhXp7h/aXrQNN3Kj7E6uWvpRI/sU2FGoM1m3JJ725VV7jMtLYfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408407; c=relaxed/simple;
	bh=JSrVpMV6/L51y8i+ffpQkeXXiw1cXLe3yCiR4GsZXOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ua1LtM+1Br8yig7ek5+YugXLGSvFL+gU5J9Cet2PItcZ5otuqeWuS/jQURSMfTUswZz4TiqWk+KqYxDsJUMBfiMNBosHRytPD1WMbGCy/ULM/Z4HLldAWYZeDJzS8p5g6hZ9gwKkh3Q9gFgzBOB4vvwiFro3DTuJOodf/MFHAks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Tp3uEHIh; arc=fail smtp.client-ip=40.107.215.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nw5MigdeKtc5GOT7pmXtUsPq73KCowNQj1O/yOMK5I5e0aTLeMvujEiZTKyEANf1YMq1xcocQur24VfClYCVgK5lDM2D5DNBgYDuu97JrkdEE3a75sZJ6YFVKxhbBa0a4OW/eb/tzEyC0XA6wSWqU2ITvbgmkDw/oOppmqXFgcTe0ImxbWziGgaBaq+2vxYp+GNeid+k/UeRjMVP6IqiSJxDIjU8Fh8lsennLayGqzTQXbi9CtMXfQGI6X8gODOt9ZneIO1eAVC8AW+3AGWQHuVcUWEFKXIl/W0CVdUZdQgaN5FQzw/zNCrrGHgO4uPDXLkBpVPPlqU1tnMBaBKJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t//JNj3zH8IwaNVFP+SWjbF0AZkMptOSwtNFs21wFN8=;
 b=ZFg8W0YzatdjYguO2aLbrFC6evH1R9NBW0MKxfw/x3DFlQCBulHYn3xKF3tiCoyE8LcYbaPFmABRyb8srtVUQ8xQXHNIVxHUsg+f/YRpS+L6IkGedp5AehV+ItE/+Lj1xrKNek3AHX8IlMnb9x70oQcZ8ZoHBqvewwEaehS3j/1tLi59PdaQzeWxDB1jlkvhRAreaZXSuPuOQWANDr8QrwJHFCWINWUX0ryCx4hNIL2IfI3GtX+XtsxycCkQWlOqo3ecyVJBG1ppcViyvsuOaqCH/HOjF5uvz4fYbfYplXd9hvleLIzsSpKSqCO9QswAv0GJnsFh77OFsNVWzeyYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t//JNj3zH8IwaNVFP+SWjbF0AZkMptOSwtNFs21wFN8=;
 b=Tp3uEHIhP2wmBetx4bdRCJLS7l1lvqcqLe+1n5vX2d2SG0fLVm3o6jPOUBl59G2ewcocGfZ0zAAP1Jsnibt2bU/A4b+1knVHw56644wkYQjiaHO6hUPi6zmraq/PwZ3sSkYj2BXw3z0MQ8qcMpIfmWLixV/T9iIst1sbnOPE0FnGxqXEMjDYLHTcwoKqxiktx8uoMooGnPFEEHAOS07JN+roKgytzNXhzgCoZnw74kVyGmFg/Y5O/XOWmcdAqZCJxl4kATNCHqeuT8K+uITzB5TnX8gtgCGYTIJc0zaq8pViacQQeypF9nMJIfsKoiPz5T45vzM3S2WK4FlUpas5HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYUPR06MB5873.apcprd06.prod.outlook.com (2603:1096:400:345::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 10:20:02 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 10:20:02 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 5/6] dma:milbeaut-hdmac:Use devm_clk_get_enabled() helpers
Date: Fri, 23 Aug 2024 18:19:32 +0800
Message-Id: <20240823101933.9517-6-liaoyuanhong@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c080b9c2-5def-4573-a580-08dcc35d2662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2XuxfTK5RZBYyjQ/zWewnwgRzkspuyFotiGaLq6j2dJrjQHVP3FScD+hjSh5?=
 =?us-ascii?Q?1OnJiQoZj9zRa8+COEtrRcUBmdqHfyRvGIYNsmx0eTimDame6v1KdaO0kRl8?=
 =?us-ascii?Q?cZXZSI+YB9lomyIW0irusydka3ctK/neO55TKIf6xZGKShvsB5RLcCaDhZgX?=
 =?us-ascii?Q?1Z9A9Lq0LUTA8JwKmy1S7rzv3/Tbw23lrLo3d0hGhTRjL9RWtGa8N2ewu9Ji?=
 =?us-ascii?Q?HgRwnvlq/c8U8RkXgHyfCRJ35oKPrslAMnJNTkd4Kf4rR1i6H/h6/V08mYSJ?=
 =?us-ascii?Q?lF7dUkJSzqc2rtXtdxMm75m6WSSie7BBgaCCily71krFeSsivHKPPj8ZAocB?=
 =?us-ascii?Q?OHfCfJJSU44+erb5NDSJSZIlrk7ddOQEhOjAuoM2Gg/RFvR0jLIwtEmLZkY1?=
 =?us-ascii?Q?VpW6vDeK10Pio+iXI7yMmKS7e6dbepv6SbigCzyiXcFDRk4zHUcNyzSv4oTQ?=
 =?us-ascii?Q?rGO/R4om/xtxTMDj/9QvyySKXvl1mpjfJYnccffvcvEjbKfi5uWM2PirWCj7?=
 =?us-ascii?Q?CsG5Gk7iGNXFrORmQX87hB1PYX9hFKDWurUeEXTdD2KaYdI9ToOuZQIG0TPC?=
 =?us-ascii?Q?GQc0OuHfzS5mdG3ZGyPyK9aEaKts+bde7FmlDuNtf7Xu59UixkwM337FQ3ry?=
 =?us-ascii?Q?Rlgc7q+wRoHlR844OP39NxhaRVolIkybgNgl+bn7vT2AYtqfC1Ftv6cZwB95?=
 =?us-ascii?Q?c5RZMDtf84myRdDnaS3Rotqx5pZ6KCx1MZPahuUDlvCq37MXGVeqfCtvraWQ?=
 =?us-ascii?Q?iXT/SuN1APrEClIDPl5bGDJkYPNQd2md/elTLsLUn8/Z9WpJur/Xv0zS6w7w?=
 =?us-ascii?Q?b2xtf9lOCrsPOItlXh1roIu5uHCJ/B+/rAKktcw8v+NmzhYMcFshNuWA/p+5?=
 =?us-ascii?Q?lYaZ6TkMM6JCzxF6oXS4tZHpd183n3IWQ/g5I0RKBcpPl5d0fghG23tEY8b/?=
 =?us-ascii?Q?TBnf5m8I7VATmXXvqWxPlaRzwGm3dBCcl34mu/e6VpqfJdEyScfXCr8l1I83?=
 =?us-ascii?Q?y5ze7t1CPL+KaFbRjgyptFVw0RVMeoupb0G00Q2FaZm89+Yap6JPJue7IPcu?=
 =?us-ascii?Q?YDeYk2GKrPsjjriW1PvJVoYC7o+9jkeD8jtqwF6YpzQEaBRQ28+pnTAo3c+W?=
 =?us-ascii?Q?Oe6LzBtXVw0jtywkhST5NCfPuiLdG3rHSwRJ9DMVpzuCcByzptUeFzXU7tV1?=
 =?us-ascii?Q?+tBIEEE8nugx1tBZBT97udchiP9lcaOJI5TAefN7O/d8zcd+WN+rvsLaI+zy?=
 =?us-ascii?Q?LJOSGcc9ozheaArALuRz2GFRST1K5E94Bt/Zrrx6Llg4hijIfNlTzoR5d13l?=
 =?us-ascii?Q?yStl0uvPFPfLpr1D8CvwhyMk2llmME3N/frHTlaa541Wg5iVUQzgXLGHDwHS?=
 =?us-ascii?Q?D4Kj5q1lVqW5eIsB2wmfTi+Tg4DepG5J9C2aciNePfSC4LsX1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MU6Q5TGJmDAC/Aui4r+dxrwtNX7u2S47vSTQoU6nr5ZUKQUHEzcehsItP7Qb?=
 =?us-ascii?Q?ZhmNrx9xpv491tiTpkGjP1bA14BgOwuE2nGL9uJQ/jcaq2wBjzx5N4APX6zF?=
 =?us-ascii?Q?ONNFjkLzoHoLm8mah+840ZGUil96w5Q//aBulY93MD/nWpU+mw4Fwq9cz6/G?=
 =?us-ascii?Q?GdtdS3sJMwoj0HqGvFIoSAGBnH0ME/3SKggNgDQU6lvu2jj9FbOiuJ5Hf2Ec?=
 =?us-ascii?Q?YMz+1TL/A4v038+x4uxUpgeq/jf8OZA3Mw4+qpiCdH2s8LfM3ixhSM/fwoJW?=
 =?us-ascii?Q?sps8pSz2NrSXBtQG0wI2Bk5IZB6J+aadbXfj03OGcH0w0zmnCswnQCrV75gD?=
 =?us-ascii?Q?tYBPOlxiJ/m4l36gEVK00nuyhhCMgzErGj0yKN557Xs7CBGDIRGHdnMF2deC?=
 =?us-ascii?Q?o9UYj4q4g/mLA9fZVWorHCXp+3No7Q9exxYywCgInmrzvGIr7Pe+yuMNyRJp?=
 =?us-ascii?Q?IfPspOY69NWDf8vDypiDpTB8r8kFKO6EB3Tr23ws+P04+Pa3aHYy5brdt0Vn?=
 =?us-ascii?Q?I58Bk57sBt1X3Ml2y8sQCUbhcwg0K27SqcUTbAdKhWjuPJXhWE+r9JH3Hh3g?=
 =?us-ascii?Q?TgTWm1Aq3vuBMB1dPd76ofueJaQ3JHww8lAgzrq4jLM1Ckbv8L6kNZSc9Mws?=
 =?us-ascii?Q?KsAxYfA5BATS4juyTs4+ipRfmNPlwt4Qn+BMRHIdB7zg02PPLsFv8t+4WGLS?=
 =?us-ascii?Q?2lpT6Qv/Au3tVhpSveu4CdkWyfqfAPL191DshvHpbcKfAXB/vejgH0GYqNiK?=
 =?us-ascii?Q?72IfrcHQQw4ZT9Or7t8iOStwllkvkUJNAnSWEniDRr0sAzunyd8VHgrVs+Br?=
 =?us-ascii?Q?j90rMxuA9slYfnLG1qOvfgmLjY2mbp32cyTWZazGLkgbyqBTL9lWZU/iLdms?=
 =?us-ascii?Q?ZsdaQ3KNFwROZkXhAXZxcfzktak1OgNdA/DvGL/ZJg341nj8gSg31HESZll7?=
 =?us-ascii?Q?6BaW49YE0HOom/auQXIb0tlSowrJH3dy/bSgcd2cT5Fog90y0jEpYgx/KAoM?=
 =?us-ascii?Q?8dF4GP6FI0wCdG37EhTsqoy1oyRLb5Onvu45s/3DMFLyhQOKmtB/af/MprCn?=
 =?us-ascii?Q?6a14fBPiFYJwHWNibeFWtAoGzO5jnRo+cwBhWlUztVWb60eugmFMSQ+AsmPH?=
 =?us-ascii?Q?Ue8HHoiP8PzSd9P8ZNmyq1vFSjOahcBN8k5xuTqnqj+JB/KscLuoDIyy1AcP?=
 =?us-ascii?Q?n26lXCwWETwVk7rV/Y9W9OKfT3CK2r/ovm07xMf8+2F+QR+RZ9r0qrKKGWKY?=
 =?us-ascii?Q?XzSgJ3cw4lO5LV09m9vNEk5bo9n9mujOgaw1Xcvf6FrfoLxyxTwFYl13V+eF?=
 =?us-ascii?Q?M+CbrumTJQQP3wGsLuKBQF4MjOb3Mcoon5Qvk4zCqEqnaZ5hPWzDDs+nj12k?=
 =?us-ascii?Q?H2fQ17YxLTMG11H94qQJzr5p9oyUX6gdSIkZuJrDMRYyUuuZ26YyYPrmnE68?=
 =?us-ascii?Q?TIlLDmke+CTks0eTn+NxiHl5JTM0oSw6Zrb5iSLhzLXxs69z4ZH6HP5CWeWy?=
 =?us-ascii?Q?/WogwTXp0+SsGhk/JeRSLJJnEtKxwva5wr80TO7+dXHql1Ozjyixdbg6Xefr?=
 =?us-ascii?Q?VGCWZMKM4rNijka94kOBKemIl9NdAItqnyU/+V52?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c080b9c2-5def-4573-a580-08dcc35d2662
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:20:02.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yltom0lIg4s/6ShKbal8+dbjvGIU3ZPaozcTnpN7g81CmyuWLfEE5zokKQFlQYFFgAz9OpkKamEbec7qndvnfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5873

Use devm_clk_get_enabled() instead of clk functions in milbeaut-hdmac.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/dma/milbeaut-hdmac.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
index 7b41c670970a..b188bfa9613a 100644
--- a/drivers/dma/milbeaut-hdmac.c
+++ b/drivers/dma/milbeaut-hdmac.c
@@ -75,7 +75,6 @@ struct milbeaut_hdmac_chan {
 
 struct milbeaut_hdmac_device {
 	struct dma_device ddev;
-	struct clk *clk;
 	void __iomem *reg_base;
 	struct milbeaut_hdmac_chan channels[];
 };
@@ -458,6 +457,7 @@ static int milbeaut_hdmac_probe(struct platform_device *pdev)
 	struct milbeaut_hdmac_device *mdev;
 	struct dma_device *ddev;
 	int nr_chans, ret, i;
+	struct clk *clk;
 
 	nr_chans = platform_irq_count(pdev);
 	if (nr_chans < 0)
@@ -476,16 +476,12 @@ static int milbeaut_hdmac_probe(struct platform_device *pdev)
 	if (IS_ERR(mdev->reg_base))
 		return PTR_ERR(mdev->reg_base);
 
-	mdev->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(mdev->clk)) {
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk)) {
 		dev_err(dev, "failed to get clock\n");
-		return PTR_ERR(mdev->clk);
+		return PTR_ERR(clk);
 	}
 
-	ret = clk_prepare_enable(mdev->clk);
-	if (ret)
-		return ret;
-
 	ddev = &mdev->ddev;
 	ddev->dev = dev;
 	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
@@ -507,12 +503,12 @@ static int milbeaut_hdmac_probe(struct platform_device *pdev)
 	for (i = 0; i < nr_chans; i++) {
 		ret = milbeaut_hdmac_chan_init(pdev, mdev, i);
 		if (ret)
-			goto disable_clk;
+			return ret;
 	}
 
 	ret = dma_async_device_register(ddev);
 	if (ret)
-		goto disable_clk;
+		return ret;
 
 	ret = of_dma_controller_register(dev->of_node,
 					 milbeaut_hdmac_xlate, mdev);
@@ -525,9 +521,6 @@ static int milbeaut_hdmac_probe(struct platform_device *pdev)
 
 unregister_dmac:
 	dma_async_device_unregister(ddev);
-disable_clk:
-	clk_disable_unprepare(mdev->clk);
-
 	return ret;
 }
 
@@ -560,7 +553,6 @@ static void milbeaut_hdmac_remove(struct platform_device *pdev)
 
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&mdev->ddev);
-	clk_disable_unprepare(mdev->clk);
 }
 
 static const struct of_device_id milbeaut_hdmac_match[] = {
-- 
2.25.1


