Return-Path: <dmaengine+bounces-9447-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ3EEak9uGmpagEAu9opvQ
	(envelope-from <dmaengine+bounces-9447-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:28:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D28B29E32E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1238731B5B94
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A593D0931;
	Mon, 16 Mar 2026 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oka6xusE"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1883CF69D;
	Mon, 16 Mar 2026 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681640; cv=fail; b=NyJUE+J90f4K70WV9tCH+vRMoylDXckvJEk4me5wO/Y8rXln52Xb8GM7t66gz8ocCzxBYcnX25Kr+evZIeX7BSDoBJ15Le5vlQxWWzje1/jHGBLuTsXpLmGlaGrmi1HiJgkhbQRBrBoBv2rJYFvJZscHZ96WZ6mUK8QuGRYX8Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681640; c=relaxed/simple;
	bh=vQ8fmdF+LQAb0ZkSX398EMOuNWVIB2XMaC+13DCk9Zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Teum93newLfbZpyYV/nmjh6Dkm0+74x+cD/FcYzUPa8tTu4vX+FCt7skFVJc8o+FmwkQZXrDxjmB3Wyg8myJAcO36rbT+yjD//9Rn+gnCIPnPcRF9NqeaF64+D09pVLu6CCILSm7aWyVqBA/0qawhAfbR0ROHKf29KR37dokWjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oka6xusE; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOCHmXHyZ7vLuLOmsRoxIvZ/GOfHAB91aoTxz4TfiotErCebCpcP8UFh+aEwb3t1hasKH7W86/HAZ+OecEP/ZWM68QpI9MfASmNQxRvWuKgHN3vJ1i6wtr//KSOKHl40PpGVBhhGdytYkmBy9KqL89ZKU3dqXeu5zfz+tMBuMyYeqCmnHNn2iWI7m/Bh2F0rNVO0MWPukj6iLXsC0XZLEFdiWTlnoDwgl+Uw/lmEsaJPFLjKj2InAeY/wmeKCbzzKHtKBPlZ5xj03fy6ZRNeuKiGpFXX7o1gfRlYl4y6JINC/nyhskmRNIw8dCoBYXH1KehbB34r6FAXI80k5a0bgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H20ofsnPIZ6iNA0giexV/N0n8vYo2NlpEAxXyhH9dc=;
 b=siKsWEdNFAbXJctJNtIwl7Wg+FqOM4yVccg7pqUS8Q6N4wq5cRpb68DXXty0qYoly2nUsKzC3zdZYc+hgpkF522cWDZJ2I2phwmIOhU3y0FNKKQWvvYH7UyaLIxRbdQfJxYS8W89JpCDi3N56XBly+lLkydNWnzUulyR5t7SCv46S03Jz1pG/Ym23t3HrwuRR/aj5yJ587LDaaVoCB/EE/aRNx0lS3OVAFcn/uQRacAo2RKgsr7zJv9Wdpb1fl/Te4tQhs22sUbSGtBFIpArPg+ffvQMpHSeZdFhra+cSH9R6dZLjUg1ph7OOmT47sjvaezHYqkpdDbj/zdyrFWOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H20ofsnPIZ6iNA0giexV/N0n8vYo2NlpEAxXyhH9dc=;
 b=Oka6xusE5iwvI9SqS+w2d0BYzU374+jQ/cDEmDzh1mDmznpAFRkwwjdGr3KHzf5BrIO3B3o92kGylsv6vKWDj3+Ac7ydzEYZzU+9QejVTXRNO1aNmDkVVADsrceS5sPXMfdjBaB4/Iv7HQv5wSwqNX5RgibYxQYIHCuTJb3ohhYrqJAOsT9h+BDLOpndAa4hWYbbcDU1bQ98YxDBxW7JFoi57d1VIQPSFT4KaAQyF8b99Z+GFf5SRcGG7V0xK/u7fbYELT8AGFxBc+bIKf4sOSWexh2HSzuaG2x1ZIsTIP/uyu6GZn+2XYFAVCV15jNMIc66pX4uMAM+q0mJKJuFCw==
Received: from CH0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:610:b3::30)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 17:20:24 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::f5) by CH0PR03CA0055.outlook.office365.com
 (2603:10b6:610:b3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 17:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:20:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 10:20:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 10:20:05 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 10:20:01 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <frank.li@nxp.com>
Subject: [PATCH v3 6/9] dmaengine: tegra: Use managed DMA controller registration
Date: Mon, 16 Mar 2026 22:48:20 +0530
Message-ID: <20260316171823.61800-7-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316171823.61800-1-akhilrajeev@nvidia.com>
References: <20260316171823.61800-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce44f02-249f-4ab3-5a13-08de83804f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YUhWNmIiRsD3+2IN95VDBGXecX7jpLrYNcLLHNOll11FF2ZwA9i8Tl9sVdAfurbuitPjvbh60jVI7jVEhQBfnrH6YDXGRiAXQXpvsLLhXAoxvZVeXvYxrtKDYx+QIVMVS5xvXwDNAFHyEtKTQfIWz3XXCTnv/PCJ3W2x1+3yrtcqOq0eFw3FjlW7I3ke+7tGuUdV5sKpJpTZRJknbDmYpyqaErcv2DJE7FHhuMYVVctW9fJ4tKm2s790GqpPnUgdyIF9O4SWo7H5mYan/EqCZOU5f7EvR8r5gIlINnimlC59D7A/tmLLe/qYxTJOL8/ZGTgXVejEWd5Tq7QXEAgeuYLXXxXaU9yKM86TTbhDk+mGDJhKPpwfIuLQBl2JIEzf4Jx0X9ExrHgrwCJ57Wd0NJUl90b02jZmu1Z0qa5Jr1uaVzi8obx6HZmQmdZdmSFhWQk6gTXF7duo7VtulbZB7I0uoy2/6lKa5l3DAI/MTTval3c5NCAYR9qDgka8dJJg0NF+VlPaIeqM/kCRaAF9H6ZFkZdp9rB5xt490c4Ed87Cl6zpKb8bihutzVKGaaUm7u+LoZElGycB2kaOkXXjJHW9/sjU/pXsW1iec/85iOi3MdPKH4sSbw0xUXMDt9QvSeqrLeolpGp8Xdn9cKpElxJRf8XsERPjM5iL8uhQD/VunsuiuWlqoB3zK3OZ+cRA4Ep9Dw3SRSIwOy/c75UqCuKc9hPZmb449+168ZhFdgSyZb3hbGvnw3Wh4ZuZhtFa2SNyf3zQGtbZ3zM8BHBfGa7CuH6Fo6TbCWpHgtU1lTkGcat5gva5+bm1dl487giM
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iLDtHqj3glrzSn2EjF8boHW9bTHBXn/nGKL00H8rogDuJheXE3ecydY9EOQA6iH+sVtozQhl43uTbg5QF5oCFrJV+fpBS219mc4hgJJDgGtqn1H40FV8rXdGiDKV4wRDzeIOeF9IflqqS5nAhOKsTIwXu1u+cC88nBeIm2JrIcq1Vea8DbuIEBXZvTYhhpGyQvc/cq6dCOthKn++37XVDOa6YKf5jwwU6ciUoMtAL8rwgrOHGiDfSUKGp2oE1YTrkTxor9x2tgm9Rhq2chKEWmw86dE+x7F1dNEk6CbOWqsmeV10njpGLzE8WnhyqOn3ykr0ZErO/g8jCxAFQwlE1QJ4d0aJpE89K4wdOHXcmdu/sAd7AX35qF0hBOB9OPYrzyE6bhzReIyvfUrw2ljVDcz9I5lK/X2oIMFiaWDmmTfC/BgLFSB1LqSYb9cMCDq1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:20:24.3863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce44f02-249f-4ab3-5a13-08de83804f77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9447-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9D28B29E32E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch to managed registration in probe. This simplifies the error
paths in the probe and also removes the need for a driver remove
function.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Suggested-by: Frank Li <frank.li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 3ac43ad19ed6..9bea2ffb3b9e 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1483,37 +1483,27 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
 	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
-	ret = dma_async_device_register(&tdma->dma_dev);
+	ret = dmaenginem_async_device_register(&tdma->dma_dev);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret,
 			      "GPC DMA driver registration failed\n");
 		return ret;
 	}
 
-	ret = of_dma_controller_register(pdev->dev.of_node,
-					 tegra_dma_of_xlate, tdma);
+	ret = devm_of_dma_controller_register(&pdev->dev, pdev->dev.of_node,
+					      tegra_dma_of_xlate, tdma);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret,
 			      "GPC DMA OF registration failed\n");
-
-		dma_async_device_unregister(&tdma->dma_dev);
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "GPC DMA driver register %lu channels\n",
+	dev_info(&pdev->dev, "GPC DMA driver registered %lu channels\n",
 		 hweight_long(tdma->chan_mask));
 
 	return 0;
 }
 
-static void tegra_dma_remove(struct platform_device *pdev)
-{
-	struct tegra_dma *tdma = platform_get_drvdata(pdev);
-
-	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&tdma->dma_dev);
-}
-
 static int __maybe_unused tegra_dma_pm_suspend(struct device *dev)
 {
 	struct tegra_dma *tdma = dev_get_drvdata(dev);
@@ -1564,7 +1554,6 @@ static struct platform_driver tegra_dma_driver = {
 		.of_match_table = tegra_dma_of_match,
 	},
 	.probe		= tegra_dma_probe,
-	.remove		= tegra_dma_remove,
 };
 
 module_platform_driver(tegra_dma_driver);
-- 
2.50.1


