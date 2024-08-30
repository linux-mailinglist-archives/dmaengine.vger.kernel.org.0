Return-Path: <dmaengine+bounces-3043-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C01965D3A
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 11:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D261C22FE1
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95F917DE36;
	Fri, 30 Aug 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eJW42M7K"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9F17994F;
	Fri, 30 Aug 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010913; cv=fail; b=Dfi5Vx+fPdljnC2jddqNCmmJQzl3aUinYgADuX3k89FPmp4JvlzhFWvntQ4rGOZRmjYvn10gezqD1IBBMT1n3GslwcTnHd+rrn659FJNBnHjY/m4K9KyMcrflyfP7dpQ+9FKZC7QWJHWNhx88VLVriCyYYoQiXRa+1/FGlGFBjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010913; c=relaxed/simple;
	bh=vcilT1fgufl/wmnpBoZD1a8ZfdOgQgFNPE/9IcSNOus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fOekc3RDnGJt1YbsqtRtYyemWH+crXkW2VQCJm9HTXLrRdPlmtrhLzWK3JPbzLZ5193ozIdN6ZYrfOaFBIE2KsIKLI3YGA76RfHSfHwfbhl8KkwmJrnch0bdtJT8PF4TPwrpTdaa7eOcPA4XOIzropBEoVHnVWzl0ZyOFHERWK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eJW42M7K; arc=fail smtp.client-ip=40.107.255.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxDV0CrdUpe6HbBa+bLNQS3Q2ftYL9isi0jG3SkBt4PuP+U1HHVH2WX24PXIdoAP77KDkZWb7nT7s65hlO4z092AGC/0oScau5+i18T/HhWevHT0B2vVF1XotQRGpJW8QrSNK7+t8tBr295mUhzGN0oFbuhOlDsBjuOe2MzkU9WvF5YdbmMs19TzQc8NEhi8a4GzKZzqVry2KBXiyd1FSOljtJaxCbD/6ptwhuPPnW6mC2pg6vE4PG+5gZxrRs4YXnxUxd8GN7JwJbs8O7JJm7G/LTMpm821zK0+L9QEDhUpvkOhCMcigcqiJRufXXh9h+wkA38RjoXi53mbUTeJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAIiRvIi1lOxnG91KjnyRmAZG4cwJZ1EK/A8vbDAN40=;
 b=xB7EF2s5ciu5b1RUTqJrZv1kh7b1CLDwtBAoCu3or7hlxPSMgay5NP6L7nTiKqyRrYUtdFuffQS97vvpN0/K9W8senL2hJrpfrsaUMdh+lwhJWiN6kw/ouClqOWUwCt30pqJe9iMlYp5xyt3WI/jczo9UfHv/8a2W6Wk6TaDzN12PzkbhwHZc3AehahPeqMwQ2aAz6R4DF1yJl4+kBg7W/C74DjKMb08wvoq1Nxzifb+Jxuu+2htwMSQ7xcpgrghfOaOiVolr5apZ6xCXG5LnmF02Osl/pmUQwmix8Gj9/JaXPFE6fcaoDBNl3T+L9fek71etxGxr+E/pcMKJ7VupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAIiRvIi1lOxnG91KjnyRmAZG4cwJZ1EK/A8vbDAN40=;
 b=eJW42M7KrKnTfbB7nsaAyCazF5ixOJmCTF8kTVD2yKRQrcPJBCmCWNk8owB/YczPmzkW9IvziCNfHYH3SMftBZFjM2v9BCDgAIf2FHg8DkiJItNZcjMAqEf9xpDCONIl6NWtx4p+5DNraPJLa9mUyHTqmt3zh5GCducfl5qxf8QDWf/kgTppYDpVfjL2X9J1EXhwHK8tZdCcR/KI/afaiW7M/gUI6DyS174SS0Jm4C9kZGHOnrsBCARziEBnxz0SoHo812UMfhO0d1eeu/9l5uaGr3EiwZmrCGwDUu3s+r0eWuSN+ub/tT2uCJHha4JRkNv3iPbUQsVMAO78lSb/ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by PUZPR06MB5619.apcprd06.prod.outlook.com (2603:1096:301:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 09:41:48 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:41:48 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2 7/7] dmaengine:uniphier-mdmac:Use devm_clk_get_enabled() helpers
Date: Fri, 30 Aug 2024 17:41:18 +0800
Message-Id: <20240830094118.15458-8-liaoyuanhong@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ae24e0c-82ed-48f9-0b94-08dcc8d7f7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hKfLvSUnScZzn5KH5HVcDPV6mZX/cCaGSsLN5N5QtPdO4vMk7GmGlcKKAAh/?=
 =?us-ascii?Q?JT7YYQLWU1nebfVpAmQS/orl7AMRAC+sm7ujTr6iyQtaNF1qyNUgPbAvzxNo?=
 =?us-ascii?Q?gQa/c5McJGCbDlwhDptWmXEn0I1ubU22QUiAs/gYN0Cw3Ig+dmIcNGxRM2+l?=
 =?us-ascii?Q?Fn4aFfq84he2gg9ep+yg6j9yz155XrXWt6FstlJYEER5petmr+oKJdnwKT2G?=
 =?us-ascii?Q?6ymCp6MSgiUo1gYS8mO1AY8SiSGEY6F8NDMZc6PuGK36VOSRgrEAt9c/hgEC?=
 =?us-ascii?Q?mkF4RSLZBc84Zu5zvml2KLMGxMLqlTgY7d8vzL19Mf9OQxP17a8B/IYfDmqF?=
 =?us-ascii?Q?n06g9kKG8iJrEBPefUKUOvZLvhkAWcplUIkQ4wk0fAuD/tqVDQS/JuEwCJhu?=
 =?us-ascii?Q?xoklaU0lb7ym29UQLHKnzhidmWfqvjLLs9GnL2VFBnMQGOD30ogxLjYYi4uO?=
 =?us-ascii?Q?h1g6B8plp0dzPXEFthjiwwVLdzgevLzaz6K3+Hj/F9Qau/GqeGShP62UaJcy?=
 =?us-ascii?Q?2Y+WQdfnB3+Ds2LGYpvqz4OuVkAixRabESVcds9YLvxomr6n6X6TRW6+OheF?=
 =?us-ascii?Q?rHSQJowify3lrQ3vsLWiLwcZN/ZCDil/6wIPye1BwmndConTfJAxyrDVZriv?=
 =?us-ascii?Q?Vr88xoiTjowSY9ge220LL8OqjLBTEYW1kyIYHPOskQ5jdu+zfpMk18owutcP?=
 =?us-ascii?Q?zDZ1yspKF1WGLvzWarXzsS/qc38xyaqIsf2zvwBSz4aMDCgU9ieURa1D8OKM?=
 =?us-ascii?Q?zkBdXYAKtgqWoK7wc/BGQIuZg+gVi+Yp/+dxjV1nb/KDE0//dJah9E6oHSAv?=
 =?us-ascii?Q?EzyFZSrVzCrPy76d1D9zDYj5+n2wwKjGH3WMWP0+/BWlLEz+UIDX8bFRdIrO?=
 =?us-ascii?Q?yvCc9jDQSPrY3N5SdFhD2X2ULVnQFdycl5mAEE0YcD7bfVABx/RDJv3lkxUy?=
 =?us-ascii?Q?QGSNm95iNjxC/MQUTTFA3gMSEcLRIi0OMEAGHWUtTEWxxg8aMWJYqqAapHZ8?=
 =?us-ascii?Q?d1nWFjE/wu32cgIOViBVLBZfBu/Pjc3XHHVHbP+X3jyGcmy6Pmgru6lrX9eQ?=
 =?us-ascii?Q?SeU24qDG4kCPi2n39GTjtPjWskcz5RVi8LyJW/ifVjQMQlEMv9vARQCJdi4Q?=
 =?us-ascii?Q?DlchKFXET50NyWsfeTlaXgJ70qFys9pMykwe8HMAzcuRk9e+nxjLmiPBxGhD?=
 =?us-ascii?Q?rw2pRM/rmM9nP+4yHLxJ51qiJoz0S16ri8qnku4BqBnv+SbWu4J2UYHg5vou?=
 =?us-ascii?Q?Uz6bEc1OpZKgtZmD/u+KtfRthv1SWj7TQfdKYieuHkTRu00vgAVkJ7j26u1G?=
 =?us-ascii?Q?MW13O/RpxoeJNvXnItiooU5+QTxqYgJUwlRePkTO69vs0AkU3rr1/0oEZ6J9?=
 =?us-ascii?Q?lOhC6dQ+hdIOv6HpzrS/VpHko92XlEF4XG1A2/+g+knWPAaBqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3mDpbiX1Q0IJ7RR1Val43ypetMS7hW/j7ajnXyrKQLqqm6QYZA7WqRIkfHtZ?=
 =?us-ascii?Q?t5yPelTDA53fXlVznLLiyHpQrBbhJjAHRFFQxBAdFf6M08cqcuBXztjs182H?=
 =?us-ascii?Q?k08CFuOyYFEAmqhXMNNmI5ekw5Ciu1JD9MJddnIZUFOg50KQpDw6XmQiqeUd?=
 =?us-ascii?Q?l75pRhgz94GitrcrIOrVq9dRcH/ZMxFytSAP+6OONiIiXxpXPxQBWrx1fyTe?=
 =?us-ascii?Q?sLArHytzApJV0B7AMJvVdsFfcbLQOA0kPWIRr44A8HVMpcHa5LuEhohjOUV5?=
 =?us-ascii?Q?ZyAaLKlZFG7RVKRLJg70uCCAq6gqNeVNM6BYVFcMjsFI2rSnpYcNSd6K450x?=
 =?us-ascii?Q?lYeDJAvaMNy5Be7YEX8Skx+ZDEFkT/ui0/N7h5z+uaM9cGNZymBEJtk3Fysa?=
 =?us-ascii?Q?zTtWS9mY/gI6OAkyXNsTLuDOLY5J+mpHOHT215wzSNDrW6upSwMe9c6WxMag?=
 =?us-ascii?Q?rqmANlx/tjPe7Bbu1ouK0UQVqK2kvfwjMK05ffykwi1jV+DKvzihNq4cte75?=
 =?us-ascii?Q?/cYLf8ms39teEfU6QPhtlVhVi9ioB/kocE4KjMxDDzjZz891KadZRdMVn+e5?=
 =?us-ascii?Q?H4lDddaRD/isoZkDYiLCMwcupc/NhzHbjhKLpMNzTVuANevPuO4AoVK1A/t7?=
 =?us-ascii?Q?lvhm7UWECuMQ1irioNrDPTLVoNra/Ze8ROoFUS7QG5tL1cJX1GLOQHomsJem?=
 =?us-ascii?Q?CIw8TT/6e172JL7lmvYsMtoCfYgHNGoiQeiSOdTfWwhWk12JIUPxIWSTwFDr?=
 =?us-ascii?Q?pD8UCPNqhwo0jwHsM2RhBXfDPtSrvnOlkBRylgkcXE+6FIsmOfOXrM2udSjI?=
 =?us-ascii?Q?X/SfzzBHWxoMMaa/jlLIq5VZnsQy+dn7a2bP5CP5Y+jXZGSAWbS3q3bx8iy5?=
 =?us-ascii?Q?UGHBq21vFFx69BguBauN6EtQ+W/Tcaaa+vlNZiZJ/gjVdA9AfqdPpK4ncsxX?=
 =?us-ascii?Q?2XJ+XGhU720zYmbmgDXuqCR5okKA8MizOCWX1/vATtgQUGleL9OPtFFS+D+e?=
 =?us-ascii?Q?bKQmxwGZgYVljJGDHpCaSOkg1+25LM9I79B26ZI9BuqxBjWTLzBjJPclfEyV?=
 =?us-ascii?Q?NI9qIFdvgVSRcK9QkLZzV4ZG8IrxJ3yQTn18VzHGbwKTllJ9AIvKWYHJoSFr?=
 =?us-ascii?Q?P1ILK+PWkO8I4Akp4Fqi/hKSCIQ3ZLaI2h2g9rYr3hb9UpVGrlL/xt791D8Y?=
 =?us-ascii?Q?PbPno9tUgRXw55ao+0sFv2uWgDBBRKfLo7b15y6TWKk4/2WaIIQz6jf8WmB3?=
 =?us-ascii?Q?R2q4XKgMocWlj2T24+toPSVb5go480UPrffQvINecJQEJUfje6M+1eIUUvHy?=
 =?us-ascii?Q?xEHq0+JXV1jOaNxtKJEMo+mOuWy3JfUyuAbX1gFk1Is+6jS7MS7b6ABzPKMl?=
 =?us-ascii?Q?Ln7rNUZLACOpNL4tlSul9Iv8pkx5sEdjutKHnwWAHlR5JTi2GwiqAI5u0qmE?=
 =?us-ascii?Q?Pi+pp/XsequZ7h8Djse9/7UdU94gwzc3tqB9wrxhpHLx20uP2iWFh6dRAGhd?=
 =?us-ascii?Q?6uHwzTOM3wH710YqZCu8nfOd+W70Z6jgCQG42WOFQlTtTfSU1miewytmXw6D?=
 =?us-ascii?Q?BpVADqTdg+dPTizvTg9Fl2+EgJhMDdeeg599+NC/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae24e0c-82ed-48f9-0b94-08dcc8d7f7b3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:41:48.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yabPy2iy2rKJT6RqFvs1PV0T2tDDLVn1m5j4Tyk/6sMw9jrRJeY8MlOt7xjj4YuvuKtE5E6qxNHDQLozn4SBPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5619

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


