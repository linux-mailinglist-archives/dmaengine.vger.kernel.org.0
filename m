Return-Path: <dmaengine+bounces-2944-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA7495CA5C
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468B528201E
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E00187FF3;
	Fri, 23 Aug 2024 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BgW7C4+F"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFDE18786C;
	Fri, 23 Aug 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408409; cv=fail; b=rH4iwCUdvIOip09XZKyLqxgYbOMHuLfbUq8DrFpOPPFrDX7YPVTFNkPvZ1A27LGfJmmsohq1267AVmblWLiwicGYCvo7e/9VDi57c3vBFvtUWJct3m2IvWWeLwfzpMNyY8vNFh/5XtA1liMQyekF2nF7rK44FIhpimubBElcTkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408409; c=relaxed/simple;
	bh=vcilT1fgufl/wmnpBoZD1a8ZfdOgQgFNPE/9IcSNOus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WjELSPYDiSPLs8Pacj78CezeGtfiMtCZLbcG62NVBnFzTdvw2BDHR0PEitiqz8j1PUxfo0XxUlnnnPKlGvIw92XJOvPOLwMmTjacaBzr3FY0qoTHD33MdvVQ08dlSn6wQUJCVeLVK+dnsDX8V2assnx1sYYAvY6i1CsV33x0+ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BgW7C4+F; arc=fail smtp.client-ip=40.107.215.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbDmUH8HZ5pOEEYK2Wgttrrv73d83TjAKacwe8n6AgsVkebqPrjzvwYfE7LMoiIpFebJrOEISVHnr2oV4UsxINd0xG29o/L2o6Uo/uvUQ+FJWBgtdCgecCb2CB5Pob4qymS4d2CtU8PIvgDav0+UYwwDdHZVDjboc7DSmvbmjrKyDa4I2B21WXW3f+uSAZFVY6KNOmnXjqvEsHT4EpBE4dHECcS6Ka/0aEWBYkZB5uWsTknFOr1VURYzAvZVKOQ6kD5hby2OFS+QBTPFQa3WfbiR0W+92/Vw162TLypofX7vGWU6tF1L2PYgIMH+j9c7/Xdg+UxhyFa+S2iypuy7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAIiRvIi1lOxnG91KjnyRmAZG4cwJZ1EK/A8vbDAN40=;
 b=c2xlQTsAtg7i9e29TODRuQYoprLR3Ru4bW0+xspl0nkzaYNFSWT3iaGfn8cyUydQLLGE0BCY7DLHX8rgGECCghf8DuVXJhA4CfAUWoaQJ2ZynUKwIshEeW/Xvt6ngFXS9q11tuW7wImr/zVgrRO+3D+smBBcpPnlVbFNMIHq/4OL3IuG34VchL27JTWTv6nKstgiGBUWq1uSAJrUMeldAu+KqgakH1FhCK9W6pMCOPMZthXkWwlnAd4MFf4/Hl+pd9hKqW5PESK5hZks2t5t24hXRiblA7D0uz6ZL3V7u0Jj5Fk/jvImhMh8RmEYU+J3/ilZ6KPWjbGhyh6FzkNr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAIiRvIi1lOxnG91KjnyRmAZG4cwJZ1EK/A8vbDAN40=;
 b=BgW7C4+FphXMINOIfGOLRvBt4uHROHZb0nUPzbKg+Tf9rX1F/SHbsxEw0roscECLXhIHf6cLz1mIsNABNdvAki8RdVJE6vClLI7hKjoZ7roTr/OCUriOrZI4oEZu0eV7U2rd7AycmTy+W/Pg2Imq0H3wVBAtTxCuXhRdDSY8eCC+uyxT57D0QtVrWFORDFcuOW0zyqyNcg3zGMYbPTySDU0pA0N3+/FTtrBJUpQZKVGJ5ftu5sMnZQf7FRP9W/3hTu5IsHCsKX4tlWSWw1b+AHFIRywf+v182wA3GDaF+xK/h6qGESxizQgxUbGSd8FucQp5TdIX0nuKXDyLBHGaTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYUPR06MB5873.apcprd06.prod.outlook.com (2603:1096:400:345::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 10:20:04 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 10:20:04 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 6/6] dma:uniphier-mdmac:Use devm_clk_get_enabled() helpers
Date: Fri, 23 Aug 2024 18:19:33 +0800
Message-Id: <20240823101933.9517-7-liaoyuanhong@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 07dd6941-805c-4a5d-ba8d-08dcc35d2796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uF6iNjdvX3qkVom5zpfZoQdPPjaAWCdQlusT7UNquvme0b/AiYaMfq1TIlDB?=
 =?us-ascii?Q?jgZkEVwDQsP7OwYKJuaAUo38VH2vsfKh8bH11B2tlEp8h5BEilD5zvSQNJQd?=
 =?us-ascii?Q?KA4SSvYISH0K8Z/3xkZLyVx8/EsDnsc8w/9bZBePwXVeaSd9TFSWYjdAOp6T?=
 =?us-ascii?Q?wOAltTLFPC+dIPdxlP/XVh2g7bGRABojaRgGR20yI951pfbGxdJNby6eiAJn?=
 =?us-ascii?Q?Yrb9FN0hKFVroCRJzlU7tPcUQACk00yWW7patQ3V8gdG6iiHKXJJpsEEUwbP?=
 =?us-ascii?Q?R9echqlHRW03dEDukE1XXt7JS0UQWSkBnk01+DN0kK6/5CIyHfHXl6YqlVVu?=
 =?us-ascii?Q?ZcNUnbOql6HAuZMkgmyqlNhj5QT9uHme3HR9S7dqdcwlJMRn41JrQgKBMGBS?=
 =?us-ascii?Q?2Be0+wicRtZikoj04nMp8e+ub91xKJexNqypnEtChby/QeIGCJhdlSCHyQLU?=
 =?us-ascii?Q?9f8oRSvl18mGpjKms3H+yrT05G5rfu578Rzr2KlMiHz0ypOU511YYDQhPE8u?=
 =?us-ascii?Q?4WmTLZvGUX0NTJJ1hWxM//zmXxfSUH1FBS1UZh2meJbO38a6IKmX6smLbpja?=
 =?us-ascii?Q?J06KMqnTJ29YXU0B1UiCAqLZq0YGnLl+Xbe7QD7BJ8g98RictrjpPWsUvshe?=
 =?us-ascii?Q?PfVCMn9HCzewIZvvflNcd4rnH3oPyureU4COv3QEbvZAo4dfk/sxmIkVob23?=
 =?us-ascii?Q?rkhfRW8m2S13MNDevGprY2CLv55lES3z49rSwxRPmYbndpLtzGcUMZ2tvzBc?=
 =?us-ascii?Q?U5Iw6uCQ3QZ5SbnSuUnH9koqGZIEtm/LBJziagR5uFx12MSgRyquPD/Q041D?=
 =?us-ascii?Q?TseAq1rOgcHy9KNeWRD50MsmVug1wg1Y8Y32eSttVt+nqPLkVH1ckV6b/6wk?=
 =?us-ascii?Q?HE8prWdkJzn6MpXwY7VH27r40VL73HeMxlsOHo0VFySm74ZkeidYMPyEG7KB?=
 =?us-ascii?Q?X2OOGG5al7Ni7LYjuN3rFnEtTZnPYon/SCVkCrkVeN5a0b9ET4o1rWj4QXel?=
 =?us-ascii?Q?iLXfjYfADgVEYvmCi4Vx6JeoM2SGmu+eoO5KMYfPZ9CV5xvYOclCnEZxVsfO?=
 =?us-ascii?Q?2XQdPly28rO1uYAT+iNaE81lFI1q8ZoruOV1Lfs1oXkpDpQ36X5Xb+Ob2rfM?=
 =?us-ascii?Q?MTEp+Yj+tROA/7XhF+oC898urh1JioAO4MLSrirkqPLqlahndJdHXb/wNy/2?=
 =?us-ascii?Q?mO2VQAsZUTI/c25XXEz0AggsBC/61tcI58CzDCTimUtZZyBCfoeN+RSd0JTu?=
 =?us-ascii?Q?aOwyWe48/+XFJ3t8NJpxKwhnyBBlPt13TASlZSkhp/vOVafonW9cShOP758B?=
 =?us-ascii?Q?4S9519iNe+EEK2OHFqaMTwejawi8+Jr037bxwOxOIJwnvHKQRjeYanFUmEgn?=
 =?us-ascii?Q?KA5TnWu3H3bqeMc906mSGSsfb47o7vSckcgwlKRmOjZJseB/Rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QSXd/SvfOAZc527PlfUYXrHxBNO2M6Fw50DL6ANKjK9hJqpcwAMWSTN4d6QW?=
 =?us-ascii?Q?1RtXOtVsZgYtDoi9zuiiR0qaI62flrMnuZmnPgVttCApUsslwAcNN0RyCAhr?=
 =?us-ascii?Q?uvG0C32zMum/plUqX3BrYsxB6Ifw74OYdItz/tJO/QixqlhaLYroqfIU++Vq?=
 =?us-ascii?Q?S0uZ9PX9BYoMzdMH25saoNMxpmskJs8Z5RERWRxi5bxstNJKWXcekrDwjWic?=
 =?us-ascii?Q?AyR5vs4gRAI1+rfBhMYKcIFp15u0Ntx4uY1kYo45WHRJXNSM1AEertq6QgAX?=
 =?us-ascii?Q?z5s5DwB0nCJ8PlMj1bptm7KK3QGqevjmuFVIarxt9J9gevN3D23hwoUkImmQ?=
 =?us-ascii?Q?kTkIiwgmOzrkWD/vKJIw3WbZCSfXQmvZIuBnrRye36yOb15ife44nexiWkSQ?=
 =?us-ascii?Q?1uVhYmksJi/G/yJ79kQ7w5VdY+n57J3P26X3rjFMl0SM/Jw3P6WtfEAlnZ9l?=
 =?us-ascii?Q?NMVZPUXD4NR+N9Hc9WfFM/VGAvOD5RFJoT/JWe2LsHFHZKQ2DPISNZbi8m88?=
 =?us-ascii?Q?T4e5xmaJSWfLFfpX+hAbMiiHXB12j2bRtD6LG57k5bK+wRv4Iy0Bex41+VLt?=
 =?us-ascii?Q?E/Syqyoc2m3ztsQwtCRTwxriU1PXIXS7ks/yui8V7J7PL1eBiW/Vqm0s7Fp8?=
 =?us-ascii?Q?E+sbhVhfEmhEUdHO3DSSYNq1Bmn6ZACXfY/zOaLW4WDRcUH7VhV19/fFMWom?=
 =?us-ascii?Q?3ibiiVsq/4b6D6aoON/4BUUjhuR5iHJYl0ZkwpgSjANQjtg6ihf6AhiOSXqN?=
 =?us-ascii?Q?8TOJeyj1nq1U6TSyicm3G9atD9EAE6dHxWpC/AVLoiBgIRireCTfV3wROs+y?=
 =?us-ascii?Q?ZDO1NlK94I9udDtOz0L8BefV0udL5vPo4mK43/CMOpTifyHmdODtNRWjSIh2?=
 =?us-ascii?Q?uofyjYQUvlXGVWNp/zyDkaJZJSuCg1v9sI1B4lY4o2GqlNXtfA/n7XIU4EM6?=
 =?us-ascii?Q?HJQGu9z4lAJTIwS+wXhehjeoz4eCC1Ptg6DhHxStpDEW+U6GPJlLWut1TgAp?=
 =?us-ascii?Q?7GDlrhO+wOzUwhYuvYNHoXIIrWf+sn18UL/TDq62pnDOfiQJfASzRmBrl3Ox?=
 =?us-ascii?Q?PoYzbfDuQynA2ZWbr7QeLWsrglTHL3d7+oqlaex5BRp1zH1e1aNtuzCNtF1H?=
 =?us-ascii?Q?sIZi2DjfMLeUTSaMZ19TXm8V1YwyhJPheb15/yaUVwaof/3Q/Cfs7nlhBavA?=
 =?us-ascii?Q?IkWEomiTRB8M/3Nqxac55knF4fjyJ2mxmTW0kUn7NiOATz5nNuYFwpdCp1CL?=
 =?us-ascii?Q?0pN9n91Ws04zhInlLfVvF2asxj8l3/f8cu4zS2o5poh0/OxYqNZ4AjAz/TAh?=
 =?us-ascii?Q?+uzbYWPrP+eJwZXvELqeu77NNRcl+o5owhY8BSHgi4t1k+eZ4bmCRU2w2X08?=
 =?us-ascii?Q?i0XYwVTaVuLENTuveVjXR5dZSZQMO7rdeno3rCawEz2Oq4FaWmmKoYFjMSSq?=
 =?us-ascii?Q?soEZn5t6qxJDxv5t96l1RsRrPlACJmpMeowLpPn+SSpiRLpZxvhyiuyR6dYC?=
 =?us-ascii?Q?BqLpLUxpkhfJrE7WJiLadQBODEsZOpjwmB2YUK/+4TMTGeVo/xPoFFLkZExo?=
 =?us-ascii?Q?rrS5OmogAlk6MOZ3gp8riX1TA66dWgiXxkXe/g7K?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dd6941-805c-4a5d-ba8d-08dcc35d2796
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:20:04.5187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ezNzFy/r+Mb7tnI2iGa/wNVECQY45slT6XNImwYsxCbi+rtSgQI8Je9xjgZa+8rd5SA6DfHdvgUodYUAKzLyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5873

Use devm_clk_get_enabled() instead of clk functions in uniphier-mdmac.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/dma/uniphier-mdmac.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/uniphier-mdmac.c b/drivers/dma/uniphier-mdmac.c
index ad7125f6e2ca..6b3570440b70 100644
--- a/drivers/dma/uniphier-mdmac.c
+++ b/drivers/dma/uniphier-mdmac.c
@@ -66,7 +66,6 @@ struct uniphier_mdmac_chan {
 
 struct uniphier_mdmac_device {
 	struct dma_device ddev;
-	struct clk *clk;
 	void __iomem *reg_base;
 	struct uniphier_mdmac_chan channels[];
 };
@@ -383,6 +382,7 @@ static int uniphier_mdmac_probe(struct platform_device *pdev)
 	struct uniphier_mdmac_device *mdev;
 	struct dma_device *ddev;
 	int nr_chans, ret, i;
+	struct clk *clk;
 
 	nr_chans = platform_irq_count(pdev);
 	if (nr_chans < 0)
@@ -401,16 +401,12 @@ static int uniphier_mdmac_probe(struct platform_device *pdev)
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
 	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
@@ -429,12 +425,12 @@ static int uniphier_mdmac_probe(struct platform_device *pdev)
 	for (i = 0; i < nr_chans; i++) {
 		ret = uniphier_mdmac_chan_init(pdev, mdev, i);
 		if (ret)
-			goto disable_clk;
+			return ret;
 	}
 
 	ret = dma_async_device_register(ddev);
 	if (ret)
-		goto disable_clk;
+		return ret;
 
 	ret = of_dma_controller_register(dev->of_node, of_dma_xlate_by_chan_id,
 					 ddev);
@@ -447,9 +443,6 @@ static int uniphier_mdmac_probe(struct platform_device *pdev)
 
 unregister_dmac:
 	dma_async_device_unregister(ddev);
-disable_clk:
-	clk_disable_unprepare(mdev->clk);
-
 	return ret;
 }
 
@@ -482,7 +475,6 @@ static void uniphier_mdmac_remove(struct platform_device *pdev)
 
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&mdev->ddev);
-	clk_disable_unprepare(mdev->clk);
 }
 
 static const struct of_device_id uniphier_mdmac_match[] = {
-- 
2.25.1


