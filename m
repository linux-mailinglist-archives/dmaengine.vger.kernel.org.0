Return-Path: <dmaengine+bounces-3044-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A935D965D3C
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 11:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341BB1F25D5F
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE2517E002;
	Fri, 30 Aug 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XtxBFWPd"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282217A5AA;
	Fri, 30 Aug 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010915; cv=fail; b=rHWoQ1TSk1wN8z82wNM4jlhrbXmkKG3kf7pvMmt+ZWpSYrn0f4jV/IK1il2hW0rZk2yoA2e0oqLNOkyq5E/S2sAtGcGHmtzxRXwLDdKRoq/PLYRNOlVQJnTkdki2F6dSQORiffv+Rw0Yjbu8fgmK400OxCbDA7dSGGWDMrADcUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010915; c=relaxed/simple;
	bh=JSrVpMV6/L51y8i+ffpQkeXXiw1cXLe3yCiR4GsZXOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nT1cv4z6o5Y0uiGUleIVolsdV69yftZw7+Moy+bHbntj6rLg3mpUTtWcLniK63Uu2SLis2ZV26tpYYRUPTJ9/t/+jIF/v386ZSKwxkmzZ6mJF4/SLtKzaJk4jsz42PwJIf7llqxSa/M8zP73QMdFb5moO/+MO2X8yh8WDJ+hhtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XtxBFWPd; arc=fail smtp.client-ip=40.107.255.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSYmhSsXkwoRlY+9WiDr2sNJFf8Cm2yhTyYnhqGeiYiAPRxcK+YbTTpGB8rSYGXZGyLFPCWY3hGgIfg6/n95erJ8UhgBlAud6jk278usPyItjOF0RPWLp4skXFjbebvjVeE2FtwZ5WGOVaZRXAjGpVRCk6ECM5azaZe/m3KBI3yGfuznhdE7jABBMFA/mJrAqnXEA0PV/DBjm1ZI3q93vIovInSgLiDvvZ4z8hxVq0DwK61cWUYaNszhRfQ8yoJtO7w+pX9bSJQAwkJ2bNF4fbRMSI3AkzSo30BBUqfZ17I+gTUWfPOXprrsoDJ9lLP0ffDfKs1gdcqeuI+81flCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t//JNj3zH8IwaNVFP+SWjbF0AZkMptOSwtNFs21wFN8=;
 b=r0VAMUj/lsVS9qQAXxCn2Y8EJrsDOQurqdBl3T7XtfY5CrnCPq/fTvnFT+K1nOjHuIxWizpt12pmMGtIfwdABZdUM9g3OqHaRCua3hCMnpKHkLweawqKef0LF4dBBj6EsF1aNVrtxYNEb01u+/zXQZb6jHvGbz6a3IlzDTmcXPgSRBdXFxH7+hKg/Y+XixHIXR6r3UYoz8OzWKt6j9ScykCn/ELf6V/VY9GphScN000lbgofRR0LhzzwSOfJty3WCIxxLdBh5VPfxE5DyOMc3qMxN0XIpXMKNaRKBGws5rfH2GvAn0DCiHO61F8/UozCEClQ3bkuyC425icbD2R62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t//JNj3zH8IwaNVFP+SWjbF0AZkMptOSwtNFs21wFN8=;
 b=XtxBFWPdZ3qgbJQokCPN0pBrTEgTifwpkCIBfFr2WkO+doshr2DsBfHka9rlq0Qw607MdEbuwoEqu7F5h9qojSrlOg78pkRJV8twEIQvOay+1nsk9f5L0/aggpavXcQDLeZVzW7ITASQVXMm4/dOQrnAjVLnSLInxhf5UwH05SEvMFLP6lnBOVWthP8xRB9P9C9JK5ywErE9YGTFfQCWqNuH5/RaW2ZSrBjCX8GgUeNIO4I62+cHfC59FEEwRaLjzKd2mNz0hUxIo3sL0b+7JcEnk4jAIz33eKUm475BlPQyE+EpF7TU+hwJJGnsiaOHu9/UqToKh/dbqlvcoGIrtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by PUZPR06MB5619.apcprd06.prod.outlook.com (2603:1096:301:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 09:41:46 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:41:45 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2 6/7] dmaengine:milbeaut-hdmac:Use devm_clk_get_enabled() helpers
Date: Fri, 30 Aug 2024 17:41:17 +0800
Message-Id: <20240830094118.15458-7-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830094118.15458-1-liaoyuanhong@vivo.com>
References: <20240830094118.15458-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|PUZPR06MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e644a8-0bf8-48f6-4d72-08dcc8d7f65c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DCi8l45U9S1sGJyWBTGuZAfwxqdWaS/5HeHcBJVYh8tLyg2h4NRLYRxYi37+?=
 =?us-ascii?Q?yqvTWn+R1t1yavvwyWFkemtXk7+pasmy5bxa+ARNiz1gi1yKRQy23Y0LZyla?=
 =?us-ascii?Q?eDwusafRLh/nSu06hkAz1jBQRI+LfYCK0qpnBbAJooEPktA91JCxoLDo9sXm?=
 =?us-ascii?Q?6zRM/SgwxBZ4P8g27dviSvBKjVz9/i5JIT3Vd6YP5LC/H0KOxmAYUVQ7xUuo?=
 =?us-ascii?Q?RSHVtMzLSAwcnKdaxiJ9cfYjjFu+Dyn8F4t5oELp1Zfc3OTP3kC2eWAYE0BQ?=
 =?us-ascii?Q?Yx0jv+F5OF/WtaaoFPM+hRgAuGdO1nnhcy5BevTrOWmusjv6puTYfTttxntJ?=
 =?us-ascii?Q?QSIbK0PjWCnLE6gfxJkzO1Egc18K6olrCUJVeFE7dsmXDwNU4MZgFG2iwXmU?=
 =?us-ascii?Q?gNZOy9Dgc233VnI4dTIwRfH4M2+YSRiYUoIzAwEEKd4hONTZjb4TAFOtylVU?=
 =?us-ascii?Q?2B5dxs0vV7cZfiqJAIkd3MLwcuFW6ko3s1V1pXcBXSPuzQbsXm70XfQtHt11?=
 =?us-ascii?Q?1EacjbvJ1bv21tyKr52S/fM0Q8Qp8d2j2S/zm9vbv7HLeYICseVJUUoTxEbT?=
 =?us-ascii?Q?1twx9Q2WWxrcPp05wYTzJe978sBXkJDiTSkz1HoGJPheHtMmGeuQZL1rY4Mw?=
 =?us-ascii?Q?DvCknMpnQuXlPTB57gp6jeGCDhFxDQNQcyljqunCCrSVD+f9+VYyicHwaWbB?=
 =?us-ascii?Q?9XEEVTEH4B2yREmZ+esylwsj/4bIOTwmBimXkjUOW7LOzG+Uer+/0GQkAegs?=
 =?us-ascii?Q?PtZlOCwdSSugyfC//IQM10oM/VfZ+LTC806pjv8vrLyNn4cCw3znFNDhzcNJ?=
 =?us-ascii?Q?I02ppcJutn0wbwJG0+nmb6wE6+hgMOKO9FHTNgZmJOgH2egP6irfHvutbGaA?=
 =?us-ascii?Q?nsTbb1Dkf8DBpJJZJFEtJb7Sc6L1E5amQ/xtKgKoijha3Quu/GE2lnZVMFN3?=
 =?us-ascii?Q?V97KxSjIKqARkqgglp5VmqBW8ASIpTZEj1nZ0eZDqfDBTdhMAceE7Russosy?=
 =?us-ascii?Q?mmFqJqOI8x3SS5k7GWF2GUwRLnFDvzt9RM2ujFxbA6emlm1TRgl0S3plR3fs?=
 =?us-ascii?Q?wEy2jiAl0mXJnNZfHoz7IVmAxOwMgcTO2MPedODSCyIW/z223I8nAHbINAuM?=
 =?us-ascii?Q?rjvUopQt4bEJ26Ha7NXsmwReye3j33Xq/OMekvH88jA8FP+TWfLLfGOHJDxR?=
 =?us-ascii?Q?R2wN/kBaMTZMcc2eVZDU2AEEd9AhpdAPiX26/8MkNYYo/Fdozr2GIeNWoLE9?=
 =?us-ascii?Q?lKoLom+uYRyAYNrwFM05zsdL8jKxA1qmx1ai8AlzLaVMt4GNiKHWPNG9NhtK?=
 =?us-ascii?Q?6TMDu0vlakBdbLSExetvE2oc4N333funW1K6Kc1oOZvlhabAWFptaIoWqRSF?=
 =?us-ascii?Q?ZoXloYjVURI9uL092aPWCse1nYNpK5BQZaonX/IGDV5HBeq8SQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N8urTLkx6frbiFvLyis1bbJwXFC0UuOblQGH38DqJKLm68tLWjgcEtYJYaUa?=
 =?us-ascii?Q?71GhnA72uOmoeiMFvTy/pA7YI+4XBVZJsZR215Rhtq75y+Pnxb5F5mqgKCiR?=
 =?us-ascii?Q?D6479/edV2G/MEC0b63kMPfN8jvfAaOSAhjha+vKDweHtlRIEwwU8BUiIj3S?=
 =?us-ascii?Q?ohojHcMk2AezDCw6Tq8aaPaSZVbvw6p3pauZjb4YGGWaMTyfbzwHcR3VkaEk?=
 =?us-ascii?Q?qX8Z3u8IUjkEWGLuW4pbB8DLxuk8ohLRB8tKX8HrywynJoyM7LWgBSkwzHCj?=
 =?us-ascii?Q?lVpBsSc2LrwKCf1ESwkrGqPrYrs8OsTObueh1/B9TeZqkXPF2iyNGSSJqDBc?=
 =?us-ascii?Q?YcJQQyBD/Lo0JH0Dr/Ba4N0SZWrj6kZONbkdibsq3WD2Z8Dh+wkHP2/RiTPF?=
 =?us-ascii?Q?IDhptBz8UJv77A73F2xFcTlvNpXlBPjzqXm9NUKnG4jpTZXV8UdEKzM1RFqH?=
 =?us-ascii?Q?TjUqj0p1suS3BBKYbhVqI4+Hkw7assd8kc/yUSTi/WwvKYhwTeOugQmVNFZ3?=
 =?us-ascii?Q?vJlHyYeQsC8JCGVLUbxIo0BSyb2x3hGxTuwqVkRGQzel50qvVLzztItibRMJ?=
 =?us-ascii?Q?QFmuwUKNWViZtgq9pCVQo1oh4NBDpmhEbAJoCD5iXbxHaUJFcXFVtCHZMFwI?=
 =?us-ascii?Q?oZXSdatALt3gSL2xTKGcPdXdH37/mmFHiUXrHEjjcVapj3zRS+InBjNJBoF+?=
 =?us-ascii?Q?gnbXscESrgQ0maV6mRnTnMaXPtg8xzTfG5sJiP/CZEyO6yfAMWr685GgNc5b?=
 =?us-ascii?Q?Pu0cD60ie+rnWWLb47jRjJEHCUpI6mGBphK/Dxs4GgMrlhp1hRTvokZoWX7m?=
 =?us-ascii?Q?x1JTHy1SsbEPfpPgl3sOZrcwUGQ87xCqrfMvKZg8/f+PatSJm0OD4AYsZzHC?=
 =?us-ascii?Q?+vjReDia4TSSKtYjLF5Az8U08vUSRFawo97aU8EMyuk3sWGQ+/+bm0lJbWyC?=
 =?us-ascii?Q?cdE6MNYd/R7vE9TxOk6qb5EFaaTrHFn+dhyt742lgSRRO4bXx5VRBp85RN9L?=
 =?us-ascii?Q?TUxE1wpTCaGW6IOUqE2+F86oWjnj7unZKqaQOK5dJ7qorOr8itNE0OfTk/Bf?=
 =?us-ascii?Q?/Jw9u53Kyb0+U0BErIe6BcPi1maUQr0XzkiX9v3AVOKE/Tovw7O6iMe7i9W9?=
 =?us-ascii?Q?z+mqY2M8m7FcSFZ7qYdgCapbJtEn6vGxABxNDSWxh7LDcUbP7nzpVOxVbIbN?=
 =?us-ascii?Q?bcLxWRvNNzid9t83k+FGoTNoztxKITYF9abhtMoD0E/31O56KHq7CMf437hN?=
 =?us-ascii?Q?QaCNY4CJ3rnR22zcFDELX4VnTl09Z8ZHW4xCuBoNV3YJsPQamGKac/NNt1hF?=
 =?us-ascii?Q?cwwYUSulSibwAnLSp1bQXc88wYEOolVDrihNurgk89kIlcKEMqvRAKQeB7BU?=
 =?us-ascii?Q?3MI+Im3Dg952NA4C4vT0bGs83jfzrVBv/zl/MLMy1+lvGwRiTUhlLdntk+1r?=
 =?us-ascii?Q?p/iP0eNwVgHVTi6SEM+NiaR1lpLoTl1CK9jz7ucNW0luSV9tIZQnJYDO+7HP?=
 =?us-ascii?Q?2EX6/PyDEUr1wVt2oJgD+nAm/cHzfhKSK0PN0+qmAfljH5U72rQrSHIbBtyj?=
 =?us-ascii?Q?nerlq0SwK76VX/+kqkyXuEl1u31itwDyW1Q1kuJl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e644a8-0bf8-48f6-4d72-08dcc8d7f65c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:41:45.8065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoSUqAawA/NeAgmxffmoublkhVGF7qAqiYGlIoI5+8BEoafiyMVYzKZTsl5UglJnFpz/WR1CsO/4mFhvxC6M4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5619

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


