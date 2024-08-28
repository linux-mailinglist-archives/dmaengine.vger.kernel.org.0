Return-Path: <dmaengine+bounces-2979-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69029622D2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 10:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5671F26C30
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D1A15D5B8;
	Wed, 28 Aug 2024 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UoYBTdNe"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2076.outbound.protection.outlook.com [40.107.117.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348C915B55D;
	Wed, 28 Aug 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835148; cv=fail; b=SP5XfWsDwZVsvkxvQ/c2amcSzeNpZqiSLetXEmXNypdQYLKNEabfprPrU3n6w3D/rCVF9d/uZOEKWhLQmaOX4dfBmOOlHLhViL1pUtwN86BvIjhsNo/lps6J11LfT6qCsYVvCbX2bePjZwWE4dp265XZ6+PToElijQGb3QaGWvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835148; c=relaxed/simple;
	bh=kJhijTa36u4nwIz7gIfQuRYca3uZetdknBg1SbcF2Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tLbLOZjkFvKYPHw4MtbZEInOrVPbrdatjrx46jvZ2YbkLOkahHx5UXKPqoCOoMuLwVkrbe0jTq0+DL40mFZpwj5RjMppKut84eDlRw70eyYseVHjJNeB+RiXHzfBqLzTiwxP5n4hVHqi0kafylXRn9aoOoQQwul9I2YTYpqHPN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UoYBTdNe; arc=fail smtp.client-ip=40.107.117.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wo0O6x1U2skA+WDnhCW5Ix7pe+2B271bSKBSRHS3gqLrYw7jLZ8VfGbO0hVSFdy/CuYypB6Q/DEAtO/6Dxk6S4WweZkKBsbftn9GwvsDoqM5nlEhtLN0+lsnicQMXvWfuVY2pdohNwPy/s8BIqzT9ScO/9mOyBNbmkRBIg+ZjNuENSIuEuM9SgQw+K+93yO9S1HNq+Wo0d6I/s6MySrBCM32kwMEMBggCf53WvxRSCFNDmvn9bbStobO7E74eSh8bsilSqtMeDoscVQ1aNtkmBdVwo7qeZlo7l+urb0ue4Iskz/C0O1T92GN4lRUM7cSHagkUK2R6HEnP7GvIPsgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUPbvKAvk29hTfUC3ZC9LXRK8LifK4Gu3GMob5TERlw=;
 b=v+YwJ7iU/JrgrxXXRgoq1RLIjadyWhiWwldrrHcHdwmk2Ctq4HqxmLTPe3zV4ThutALQbscPQKr1xWA5cpB9sKAcpnSqLPdpo0PI+Z2osUGHh4zGy76tLTtBysCpJ/kvgvHtL6KHUou9HcMVXXDMb8zVKwvEe94Ep7rg7kjSuaG5wY2gzT17DW/tbweISYDp8+fSUdmyaVeAFHa/zQDyvhHctBra5PHnZ+ApX+mSHph2bYiHB52YHFB8WAoXIduUo5/HVU6JWOI0xQw3C9Gkwx/GQ6t37NfE+wKo4GmPZKRRAQ5VP3FKvwOjHX/edh4lbXIwzLEcoYVIrraErItU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUPbvKAvk29hTfUC3ZC9LXRK8LifK4Gu3GMob5TERlw=;
 b=UoYBTdNeKFU6UhNmhkjCxm73YXj6pzUdqmsURKmEu0/p0C2RzjmLdv91FrIiBYg7M1Id0SnE7w6jMAyarajWdjLb0j5uk1i0MusM3nnFyG//gL2r4+f4cO9QedepiD2DoHebxKJV+tGlHNXVsiTh4O+/hlaIoDnQ3uBXg2Qm8sx79DU1ev1JwCQuV2x1ehx+Vfk28DGNnn2WI+NAEUuhtv8m7rqKF5GRXko8nOiaRlZZLzTx6r13y5Wa3uixVVPFMsGrVF2orcIMhdpuGtkfOZNuwG0iKBUeLyuHBoqc3pYbrLxny5AttGPZYQ0oPJdbpjheaiVFucOnb3yyT43zDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEZPR06MB6013.apcprd06.prod.outlook.com (2603:1096:101:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 08:52:20 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 08:52:20 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2 4/6] dma:imx-sdma:Use devm_clk_get_enabled() helpers
Date: Wed, 28 Aug 2024 16:52:10 +0800
Message-Id: <20240828085210.7159-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823101933.9517-5-liaoyuanhong@vivo.com>
References: <20240823101933.9517-5-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEZPR06MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f857ba3-dd0e-4481-3ca3-08dcc73eb9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xvZUAYfqKwk93ysN0JJUX0xNPaxFDJOxnrKzkwVb03P6BCfMfZjcrEs6TmfM?=
 =?us-ascii?Q?aHVcd9gnxGD0PDFq6VzvJxIHcTUS5tQtnaI/tToI7a3K6ibHu+buJZ1H0WRe?=
 =?us-ascii?Q?pekIug6tgRrHCPMc+ezBOHnCKOOfv9mmkBRvEt8MDdn8lgL6U7CzNWOJvMzP?=
 =?us-ascii?Q?miirygxfd7QUli0VyMjcc6TQL9nzVLUHv6udXPQkbu5tFItcwuIU6ZJlFvxC?=
 =?us-ascii?Q?KovZKfBzNfbKeNv9DrEDnOYc7kgquM5esMIXzdNt1yCVapi1lLcWO4Rrsd07?=
 =?us-ascii?Q?44yT1yNaKW3TVbuHFDN7PFShHPi6h+TZKn9UHcdV7QbcA3k/ESTQ+tAOn+s5?=
 =?us-ascii?Q?F2nqU4jzcgX992SSUhhEsW6TsqQ6QQCtiideJ5Fc1nLBrAmnCMd8ijIoltfb?=
 =?us-ascii?Q?CFsTRkhPNcBSvDZ8bRO/HqvlIiy8ZwLMsBzZycYy2WXpp7R5ODNjInbUDCjb?=
 =?us-ascii?Q?rXH0j9dcNYdhBTpGGLR7on3Xh3iUZ0trbqT2v2/9KFZVHBBxon23uJG9G3nj?=
 =?us-ascii?Q?R5FXqsg8W3BVThPXFPD9T7MCzQTQIlbtIF8wzSQr1GCBY9Dc+aAdfPbDYofs?=
 =?us-ascii?Q?oeekghc8Z+rcSGS/Fz79LX6FxvWOE97johcbBZCEcYEGN5DjUf0Mdb9jH1O7?=
 =?us-ascii?Q?8Hsfgd0uFwU7DsPH7CNN094jdWQKl2ETKR1ZwutfA5oD+ZXvSQKV6F/dp/Ze?=
 =?us-ascii?Q?V3M0ADYB3/tPs9DlHXB56nBXT/lSafCj6mczvFFK4UzcqxXca2vGdsEy0qN2?=
 =?us-ascii?Q?WJr3jsAmN6miNAnQoavdIoVa/87VPCXSBcCDtYPNxCdocgtQ/s7yfy37Ctm4?=
 =?us-ascii?Q?KuRPAaqZ+xcEmOkOPVNOen+BkFk8HgzKhUbQseRQuZLIGldPRnGh7koKQhB8?=
 =?us-ascii?Q?DtmGhk7ZR2k9thIHf0/y3b85tYD+E4o88f5D7sfbd96HUssaBpjAlapiSWxN?=
 =?us-ascii?Q?VIWVR5OZ9VeqDOoX/AG0tPa+S5vqO6FviLvtVII/YOOpzxPlJnLodJcrR82S?=
 =?us-ascii?Q?Ip3QqXWb9I4nACnT819VPwp7sdaNdbK22nek3oRQqbFLSY1ssCH1vPbG9ltW?=
 =?us-ascii?Q?5AcB+oj37TZKQCUvDdOv8ZgldpGMwtDFf7db/Ad+v2ueuGGZxt+Mhyezrp/K?=
 =?us-ascii?Q?nmSFsR+SP7FmwlpDVOeKJ+kCeXMyDFd9pG5tDnrmMDDVdjKXlo0qGxht78kc?=
 =?us-ascii?Q?l/qchLCTXKbHRtmrykXGkvwIoMvnm5hNSuJfcSZqp+OFViRHY9Xx72sRekWc?=
 =?us-ascii?Q?S9cYWTgdP7N6iIAzeqAcaMaZC4L4Sgx4Z3r/lbGrtdU5PGy9bRpscO1Idj7B?=
 =?us-ascii?Q?hqy8URXkkxo7nz1VJAwGwbQOSN0q9viiwrYbzqSi0huA48VDDCgNLOb/is4w?=
 =?us-ascii?Q?itOiEsNywomDakWtsEa36WiZvsgMr0tOaS8ND+Jk3WeNxH1XBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k399aAAzLJiQTlJOxWuxYeujOH1iUv0HHXmwaHka0SEGpH0a/en3Rb9eEq0H?=
 =?us-ascii?Q?OR+60ndVhzAO8gtGkXFKEXjty8Q/V6hBtqzFv+s//2Bt9kPauqiqoh5FU81M?=
 =?us-ascii?Q?8LDrURSCjKx+JzwaxthQ+XuEhLn2bQj2S3uNHcLOCjctn2e9ikEJztcpkQQA?=
 =?us-ascii?Q?R7hZ63T1x+N1rAs6Da9t5sNzyTV691juM3m/AuJilqyysSj4lp62OmyHvpo7?=
 =?us-ascii?Q?adwL4F1gTIrLLuPt9BQiLY0IzQplBEylIQWUFX8UJfbFtbC8yDu9UgZklmkV?=
 =?us-ascii?Q?xVNc244t5cq0eqo0lz5pcSwlHHy1b40goO6fAmi70ZlPJ9fHrlI79hTcSXzf?=
 =?us-ascii?Q?1eK8a2TwmsRv+duHNQ0sgvKOTtlCqo471Mo8IxZrfh6s8/CtzCCrt20eOV/t?=
 =?us-ascii?Q?J6YbKEgop5LgicCN4bk9leW2AtNjw2A8OKv2rF3CU5NwqfwMWwJA64ukW4aM?=
 =?us-ascii?Q?gXK/WNqjlk4DGjy0eLzEdtO2j9Skt6kl27+H2SohFrwwhjI6NRN61s5BDDg8?=
 =?us-ascii?Q?kLQDKUfpfzll+c94NlQ2hrF0AdiMxXf4W4x+muR5ijlG1Pc9HCwEEtaiAN98?=
 =?us-ascii?Q?UheqFcrECR8C5iFmpU8u6LkRvlFObkGZxY+ZblTGrocie+Zw3w1PQJNGf4k7?=
 =?us-ascii?Q?+7EtyoPxvgzrZZiz1G/XCnbD1zSv/FaQPZ/7j4qx3nuqiXCgK1VVqdq/hf17?=
 =?us-ascii?Q?YZut7mHs1CIH0xyWiaZE2LvGxCsrRk8Cw9kFtrSezsT8zvryVyFoXndW5+QZ?=
 =?us-ascii?Q?d9fbeRhcCNLKgO6RkESXGb1g6QVis5qcs4zqex56IF64Bld6wQOz1RmCbYcs?=
 =?us-ascii?Q?m1Hle9lSjpJoHnIO7f3/2RKaCsZusLTcd1QMQm+WupkEetfcLvGg/tkWiO9g?=
 =?us-ascii?Q?/pSuTEvphkaT6ra97489Q/iJgd3Aqa+5aQJxefgIycyzaK2RHkQWXORFFplO?=
 =?us-ascii?Q?NTjry6QAnzdesDBm1vD41x2QkFCaxRKhnPGVvS3mkeoYEF62mMMJoAiXTypX?=
 =?us-ascii?Q?xKAtsWmQK13/a6/3f/XZh1TSqjx0VoE1J+qGtuLroAETc0d9u2giJf0ar4SK?=
 =?us-ascii?Q?rcbqKkd3Nc64tw0il2pMamfuMj1Ec3xpsKMVSVNO3B0uXdICxDAdAhQSri33?=
 =?us-ascii?Q?DKwy5wxKlXtBAP9gbycMcVzHje+yhMASXLZp7Ht+wSn16XzwTrF3UI1HucJ5?=
 =?us-ascii?Q?8XhPKpuo0ipPGUQc5+tuAi3aOjFtCJHRLAKprL2L4Owj19zbOG79mGa4jd5f?=
 =?us-ascii?Q?zZDhk1EXp/IcxtfuvCDN98w9JmECqOPLGiGLa+xIz5+sS8CFnh8YoxwoQL6w?=
 =?us-ascii?Q?wRLnf66C9h+CT4akLVpnhGcoL5Tqdfb2RIX5VrkZnEKTf6SBHwtAOof2kGeg?=
 =?us-ascii?Q?UBB0QbVPFt6uVCF9yeEnAigmUIxc3JFnHdCLexey7iR8jsDZhPXI+SnDt5JY?=
 =?us-ascii?Q?LTUdaaLWsTcK8tX31rvzPbVaMxyYUHAk+3YpIkBdY+Lu6cRUD5eXK4ocKR5L?=
 =?us-ascii?Q?1IG7h80gq+5g538/6P1cqtpC7dGY/c4NMVkcpGCMkHPSF/mgFCyh63IAspGt?=
 =?us-ascii?Q?1A9xj3lUiJELGkJfp+Di7bvCwGrYw9vbGXb2yjQ7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f857ba3-dd0e-4481-3ca3-08dcc73eb9f9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:52:20.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+EWlXlPQ05lE6avzjSpKHFVxQChtQ1p4w3ruONRqMTbNbu8IEdktzF/lS8asCntfuLIk+7EhH3vHlFLClgSfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6013

Use devm_clk_get_enabled() instead of clk functions in imx-sdma.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
v2:Remove all enable related modifications, replace clk_prepare() with
devm_clk_get_prepared(), and configure COMPILE_TEST on the corresponding
node in Kconfig for easy compilation and debugging.
---
 drivers/dma/Kconfig    |  4 ++--
 drivers/dma/imx-sdma.c | 22 ++++------------------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index cc0a62c34861..c4ffb5d3e321 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -264,7 +264,7 @@ config IMG_MDC_DMA
 
 config IMX_DMA
 	tristate "i.MX DMA support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support the i.MX DMA engine. This engine is integrated into
@@ -272,7 +272,7 @@ config IMX_DMA
 
 config IMX_SDMA
 	tristate "i.MX SDMA support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 72299a08af44..07a017c40a82 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2266,33 +2266,25 @@ static int sdma_probe(struct platform_device *pdev)
 	if (IS_ERR(sdma->regs))
 		return PTR_ERR(sdma->regs);
 
-	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	sdma->clk_ipg = devm_clk_get_prepared(&pdev->dev, "ipg");
 	if (IS_ERR(sdma->clk_ipg))
 		return PTR_ERR(sdma->clk_ipg);
 
-	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	sdma->clk_ahb = devm_clk_get_prepared(&pdev->dev, "ahb");
 	if (IS_ERR(sdma->clk_ahb))
 		return PTR_ERR(sdma->clk_ahb);
 
-	ret = clk_prepare(sdma->clk_ipg);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare(sdma->clk_ahb);
-	if (ret)
-		goto err_clk;
-
 	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
 				dev_name(&pdev->dev), sdma);
 	if (ret)
-		goto err_irq;
+		return ret;
 
 	sdma->irq = irq;
 
 	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
 	if (!sdma->script_addrs) {
 		ret = -ENOMEM;
-		goto err_irq;
+		return ret;
 	}
 
 	/* initially no scripts available */
@@ -2407,10 +2399,6 @@ static int sdma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&sdma->dma_device);
 err_init:
 	kfree(sdma->script_addrs);
-err_irq:
-	clk_unprepare(sdma->clk_ahb);
-err_clk:
-	clk_unprepare(sdma->clk_ipg);
 	return ret;
 }
 
@@ -2422,8 +2410,6 @@ static void sdma_remove(struct platform_device *pdev)
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
 	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);
-	clk_unprepare(sdma->clk_ahb);
-	clk_unprepare(sdma->clk_ipg);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
-- 
2.25.1


