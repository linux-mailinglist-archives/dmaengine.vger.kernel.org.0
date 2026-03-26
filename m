Return-Path: <dmaengine+bounces-9668-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAoWDHgWxWnr6QQAu9opvQ
	(envelope-from <dmaengine+bounces-9668-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:20:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E8533458E
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E1F30969B4
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 11:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDB839527D;
	Thu, 26 Mar 2026 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ar3IRF7P"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C638F22B;
	Thu, 26 Mar 2026 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523492; cv=fail; b=kNHkko4f7oJ3FTZUNde4hjC++35UK9vI1ajDz9P1fmH7Vi0brDzsYMaWYTs9B7IOeGoO6eEGfjtswpS3i/SSwsKY2BPjot3EEwb3AgmEUNokhP2wPdfy411xm+E/HVvqCwTVTi+tU2BL/7z5/kkM83LBUcIuW300zuqf0M93+Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523492; c=relaxed/simple;
	bh=Er2RRwu1u3oKOS3YC2aaM4wUjBHuUHQTytGBNX25oZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYcSuSSAgwAc/tN52tQdp87VLYV8XBNUlcons3qAFh0m0dU51WJMAyozpY7oznUW0hVm9i/puam+AJfqI1jvXXIdGoQ/omCXS0m5E7CoU8mMyvmcT+R0M7ddYijsm/tuUnK1IOzdDFSEjuugU0KUmZAgJsGeWSkkBlTh8jWKLm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ar3IRF7P; arc=fail smtp.client-ip=40.93.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLtlJHaNmqGqxXTyvLSuKoNGQ8BuyATkow4p8m5YoL8swynxyAuIF129UTsrSYNTqko14IIkariZms8X1GKgvbI/v82mcKW5Dx3ytwczUls335yp7SJC6LKEoaMpo2bVtCV/47ReeH7J0O7OC+9Wy2a6o/vCHxisbTtfFfUCsKMjg1aKnwp+Di/LdTTQMEItULpMfIrhDe6zU/N7ESpORkEnRJqlqMC0/YHryv2te+jUxUUoqvCiZnXWDnic2SUQAAWIav51FlMagxp6xxw4NwXVq3e46EQ3RbNnaUIhXkAiZJUxUvtoF+HsGDcmgoEwj8ebStrilzFaNTijDY3fSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnQOQpqDrVK75f38aGwZwUolWtEicpOiR9xr7UsTKpI=;
 b=dGgvs1/k/Kra7UleZJ/nN+ioHZgc5LCcVyPhQhXp9f/jVRpNP/KK4Q6mapbwEBWWfEkkYha2KgIrk8mQ8uRdPVHkap0qotmcHgZZzqN4sh6Kex+Be4amL6BLuktkrKbm7dnWNdzDIRSd3IIN4+DRebmiHlXAv/uKHg1wDYKfrPZE0vRqftRF6NUEkWWoWwvUAOObGzN9Iv0/jwIXLQKb6ZaVlOPy9ziZ7JhiadtF0cevFYeMUylsoDDyhWqkIgnO1Dq+KCsXTGc2Z6hpMYVlQrEOaYrPaXCnSEiSnaQP++tvqx5BlyOCCKMIShRqhfUIpmVxrWF/6NibO5h+T/EukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnQOQpqDrVK75f38aGwZwUolWtEicpOiR9xr7UsTKpI=;
 b=Ar3IRF7PKF3hhZH9KMCV550QqZC6LXT3xLITyWcQEgtD7JJA73FtcCHFEG0boj9XBGzx/B40m0WWf6NmuHYWG5KeqMU6hdIMqijT1DdhXXtPxUovXbGmxaEkoUCcci8Fk/hTc1JxTKvyqyr1CPkE7lePMHoX3ZXFLVrowwJieGH9y2yqr719GokSsQbdE3M+05cvBN0A9G8gkouRP3VgxExsgNP2vRVN+rWgyefat6+fsW7YsxZ5UGbbsEW4/8vkn4deC1I7ER5DuxaQseCvWSKkD6yvLJzQnEOul2Il2sgF+YCNKlTDPECu/VGUbis58/l3L/xLEx7bS1eL0Nba5Q==
Received: from PH7P221CA0090.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::25)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 11:11:23 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::7e) by PH7P221CA0090.outlook.office365.com
 (2603:10b6:510:328::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 11:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:11:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 04:11:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 04:11:13 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 04:11:09 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <frank.li@nxp.com>
Subject: [PATCH v4 07/10] dmaengine: tegra: Use managed DMA controller registration
Date: Thu, 26 Mar 2026 16:39:44 +0530
Message-ID: <20260326110948.68908-8-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326110948.68908-1-akhilrajeev@nvidia.com>
References: <20260326110948.68908-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c53367-e078-4cec-5497-08de8b2869dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|1800799024|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NmH76rrgIlMkvbBPVykln1tbTST2rX+zsfdSpXt0jPKi3Z+zFvg6NnZixyqGqSdlhQrJTEUPXvsk8KkfRq+a8FMsz1hWpcjYckaZoV88uDe7T7VIcCY126Jjvj1v3sCk/ws8xLwRhPMYapHIROMhc80uzngdiRdso5hS6SvXdqmzc5JASLcQNlT8e4geLdOVutaPJL+U1VkcaRxkojcYaBy7NEg5Fmz/TE/OQ168lx0YqactQ2iiNGicoAma5HC2AF3nNwGmMIqBUJwLeLCO9ktfd9zz0ih94IScxBWg0fCmO/KeKsasNNl54cR8JxDOpvpySFZ2BAAxoNnyzYakgdJO0JuZZg1Jhwec4FSu4J6CtYwbSs1mXdl2LpljCmVdp9QwNH1q0kEMqZNch5IfNuUnmtIVFDdEOQuxMnj718Sd3yI9rTcMq59faTwGXfQFY6vKbi6HozZSJIleT5ME8mmnje8OsQkzgnFik73kuzsMpwlvJP6ZEIwxT3Q5XL8c3gS0yIFbsOBP9c7cb8CLFaCfAx632QmNUzMvv5YK+4JDynAorXp4F6hnUTspLXyrPTaOfoYn/LRaWG8CIlL0ZgAuiJbzv11Y1Eq6iwGnyTutoi6EfWSdGoFX7EFWofS/YbLFQtNzCE22woqWqlHsOgE9/c6IE7Q6qa3GVTdHKPBve+4LERWPfIjdFiTIbG6aDZHQK5YbruBiumGaHbjq2guc6RhVJr3ub9lMZCyGcI0lK/2ILZY4ytyXucXrMoCDHuRRks5MMAZxygTzfsSyMGdTbblKL8X4Z3AJe7O9Y68oU+LOcqqYm1/YFpI7EfaM
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(1800799024)(376014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aZy6P5z2zu7+sDDqSiKgERbtWc7aKHGcazcluHDTtZG1iSvEddszyRKwgIY55r45i4O3cFUU64iuprHcoYhW8uxwL8ULnDNl034fyfu9pnuH7FAO+TjnM7tWqsmVG0SyNeITmF5MZpKYwqF+PDLX8ocDnYixNxlH9BciJTrshn5/fKLiw8o5BMBdQo0kuYVRxzIyNjKfyH956FTFeQX/wgPWVUGjgd8VKVPM0UnSdA2DHMBuk9+1mKS4A/waJ9DXMBKh1D1ysrnNdXwAXKi61HVte1r0WORvJMMheqiJNitD+0QFRiKf32XvnFA3UvHLW6G0uFrZOHl8Z+aBy0t1Q/c3W/z3GANnh+R7LkQDjjN0YHAvlcwS2YSYffBRjGSGzHcFx8isEThHiL8rHhIlawgu3HHUZHQEv/vwLkaheevlCwvnIBzespBmYebiMpAM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:11:22.3053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c53367-e078-4cec-5497-08de8b2869dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9668-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,nxp.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C3E8533458E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch to managed registration in probe. This simplifies the error
paths in the probe and also removes the requirement of the driver
remove function.

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


