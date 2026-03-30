Return-Path: <dmaengine+bounces-9722-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ50OdmSymma+AUAu9opvQ
	(envelope-from <dmaengine+bounces-9722-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:12:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDDF35D8E7
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C359E3146CE2
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C109632C94B;
	Mon, 30 Mar 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bGY69NDB"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675F328616;
	Mon, 30 Mar 2026 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882007; cv=fail; b=Ce/QMRM38BgjDvFWPac4pAHrK4geqmN7MFFFx5dK7G92W8mI9qIlkohzJVqe1RxtZjaMXTl+2OyrzxF7CoukK740JIAsBVWlKgw7Va1uKfFlDe+r1nfJ+CIShqvnEK++wgEVPcmkGPaIG4DJTWvIdhxWthsnSSDqdOMomEcOkbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882007; c=relaxed/simple;
	bh=Er2RRwu1u3oKOS3YC2aaM4wUjBHuUHQTytGBNX25oZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwYKEnvY4fIlVZfq3h9Dj0W/1FSJVhLUwRuL8kh4b87eMJkca4jMsrIcL36VcTtPxQ/REwgiG9ZqIQJ3gpnRswi1sgWc5PdmeShj//g3jW/aHkST/RmzqmXA1GJJifx8/gMWBmgQg+E19kWztvbybA05zGfJ2aWOrQESxw+mq6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bGY69NDB; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPYVLHAHlJ2ivxC/lP2A8NKSz/lGXTgSZRbECYhacxrGPZGgcnU6MhaKCXKB7mq161qcWzPoppj/h/YXaH33stiN9RpQDmcdJJZX0STs2CZ6mo2I4oF/XyU5Gz3hz4Mp4iPCQiqZKTFo6vNaDdnWh6J09EqvuxhCx6MSq/HXxiUQaPcBUebiH0jyNWqUBZ2Zfe5AnwoBhdngzSUF2Ne4Tm6NQNgL68B+BnBghVSs7wSTe+6RKYn7uZoIG4js2c1Q8QH+hTpQU5MLVBaSMFL6Rs6Et8q/QVlCk5z1Ri16nWWytJDR2TMR99m7leiMI4qMA4f+SSSALeJCCSvLn24M0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnQOQpqDrVK75f38aGwZwUolWtEicpOiR9xr7UsTKpI=;
 b=DuLpDPPhRbSc4CVuv0/NfrFVPj498G1/KxxU0cZq0YMSf8fpeCYYTb3Nr566C8sV2GXYe665kamH0qr74+t99a5qYZlVAw9jou1dslPo9gNd2L+CJ8ZPonY4QAkscBJc6tmwUnSJJ5VL1ziy1tagA1eWewc/8fjY922hO9uveHUFl4glzP5BaXNepfACLJ8I7ZV52amMcXm3qRRBXy8PMREUusGrP2UDLmRoEL+npKzt8qtT4mVSHoZKJ8okIjIKfr61204u1f5Ees6RT0tIyoB4mpoJSsahrF3oZva/5yMIret4phcA5CqHfDnemeApILwNI8dd5U+vtnQt5v17Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnQOQpqDrVK75f38aGwZwUolWtEicpOiR9xr7UsTKpI=;
 b=bGY69NDBFJ+lw7EJ2tr6zRMqp7BwlBQJOp5HDjJJNqJFZMsOqegskpf4yCiuD/KRluT5fBmrVgu3NmEAc1XtR46taDCMC28udtv9ql/HKXCUFn9M6fiLMx4DBxQy6fYQ/3CapUcnZk830yuiBOr8DKFw7FUTBFufsfDBViEcVsh5co3eKkGQK8Iet1fpUJBDXKSo2O4h3KYUPpp4RZ7ClKaKJWUEghqcw4X1bl0++wNvzYv4GHT+6CwXPEbJareK619S9jN7/p1Mk6+dJ1UK35/HHcNLtCipJ1J+DZ24s9h7K+XfF0lO5F4CEelNA2JaEBayGw4NT3UI9Fg/FoLwog==
Received: from DS7PR03CA0253.namprd03.prod.outlook.com (2603:10b6:5:3b3::18)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:46:38 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::67) by DS7PR03CA0253.outlook.office365.com
 (2603:10b6:5:3b3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:46:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:46:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:46:19 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:46:15 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <frank.li@nxp.com>
Subject: [PATCH v5 07/10] dmaengine: tegra: Use managed DMA controller registration
Date: Mon, 30 Mar 2026 20:14:53 +0530
Message-ID: <20260330144456.13551-8-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260330144456.13551-1-akhilrajeev@nvidia.com>
References: <20260330144456.13551-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH1PR12MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4f9079-6f0e-4475-8d3e-08de8e6b25fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3H4OItW5uaK7AwNIzHe2XMj2Fe6wyTShyHukwFGhDsDG6f/FwP1k41ZvkktZzGPU4R4urMFH3UUGhRmuIp4K2T+Z1eVOnaeglsChE/4PRd0hlBQs6nOYBwnunJcF1/UZfNTtAbQ0PEGmVBeR0doLHlV+rDy1zzQCepxJMst0b97s82fwdGLF1aJH5/DtLS+uxFMXihpN0W6AXVvXLbWCYGL7737/P4vu/CdevsVVVTWaTWtU3R/BUbTmyMLvtfriw8RBwfRRhf9/wYJyW065D9Mc8uWmdRq5Zkxz7u1ohTBeLS5VFCieehbgTTP97vZoWetiWfsrBwiQpBh8zQuAQuwT7OUXc1eXHWY/A5gegVyqeMC/9qPtnYJ9Ugz1eMfizm1lYaSeJ7xmRQV6hGwmAv1vYgAg5CSvtySGXHPeZpQfy37zPXrs6TJtNGJu5XVLw5DG3OP6OVdH4NO/n6OlH6d4uc0PQBtSUVw1V4quWZhJ90Vav1qBDmUju9Ftc9oW5FnZoTi4hlJI8Mv6yi6tq1Oxxs7i2gUOGUugBkZPyjA/oh5Ow+/peUpQqVVFUC1/GxqFr3xHR9hxDLudGTXT0OjkTPwUo4efFnUDGyqjAXdTPC6LluVVAV2Y65Ql9aa0E1kLYQskQPd1yKnxBP+XXTkYlp76CMeabjV/YOSR/7LnA0cu5FbP2dOgbF+aBDf+uni3z8BESeyTcz5oiKn2RmCxXakTMUD1Z2jh8NaiVzEc6kRzBPOSseAmUYcZvgrHeulkGKC0SQCg6GpaQT8LrBtVyO/YcuWnRfkKHWoJ22R4eJuB4OJ1QZfnsY4nEm5L
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L/mDl5Fv/kRvRDwME1BPWX1bsDMP+fT5SHza2nnW1btlqFQv/zGQTnTcq90fABlAppOhFpXtaJJxLqXCQTOzc8A1eirA2efkQcIRDgm3iBcw2wPjvVvUFGWBDDPjmPS+MtFqR9b0EIjBHod3X+tTQgE2GnGnmnJn2ZeULaYqm6TN6vS2EDpH1gZIN969VH+NrKiwSsQK3QPVcjHAvhhSF7UJUlGJmWpMZ+0wmY3/19fxYZz6DKM8uIMMoocZ+jakskGfERRDcnM+FEISGdxGiRf4++yLcDNaeEhFOrapAzjXtME9u1CWg7CN5DRgN9I86RTKJC8+N+QiepbRFntWlkBF+ANckNPER3Ar62eu4bVnANp6n0bB8PfxanhlXmu9csnh9Mh6WfW0JlRwSkfN88UFaYd8cuX/rtz7AXo/AOPt9bQUGV7l1tfwg+gLxYdW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:46:38.2223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4f9079-6f0e-4475-8d3e-08de8e6b25fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9722-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nxp.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4DDDF35D8E7
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


