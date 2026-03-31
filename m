Return-Path: <dmaengine+bounces-9767-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C0mBO+jy2mTJwYAu9opvQ
	(envelope-from <dmaengine+bounces-9767-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:37:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0673681AA
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2AEB30845D5
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867023EF0B5;
	Tue, 31 Mar 2026 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZEygUXLV"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E673EDAAF;
	Tue, 31 Mar 2026 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952709; cv=fail; b=cRlSyTzxobK69NC/ojRtAe9sbPXhQwymDB/kQTkez5N811zwMRgyF0h3mFs3ny75ZQYJRTf6pmskckSx8tFK+SsUNWgvPmeu/h1vPsg2rMnZabOKTMG3y/hbbbrX4tpGY/7SlKGdOux0Kda4r5qLRwRvExsTAmuZ7Vgs+s66IPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952709; c=relaxed/simple;
	bh=OM5BEsJMn9MdTnYaXLqqGwpVfkzAWgapdjHwKGili9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYFxEITBSz6yyBh1KbGTFshn3ZhI8lOFuaoohUuhkVB1yDrylOJWJgU1v2p5pf132nP9HmvxE4ZzNejAnpXl9Gia+fLOyXeR9Ai7lNh2mgdFBbWrCPRtTAGCUbcH7LpzuEojqeQ6I72bXmazVLuREf277YSTjhTI7AM3HpA6b1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZEygUXLV; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hErH4fXQwE/OENb9D0KCiz/8Fg827pHf63e7hNDNEffrCf8aMiV0IulhjnOvSQUu7YBK62qNYiPagjBoMj1MSFoVlEVB+uQtwvk0CBww29aJfn7903ItfebaiYFvBAyMchpSWOswF34VYgq9BFKFBBdQVA7UJMCle/blea00MWZhL+KrcMraSW7w1//paACZArIz5wJasnPLWIiM5NXqiStIyYtbZWF4Geov5P7vESWO5eWaq6f4sW3R6+4rFQXJvOFueH6DcxmkRM3+LUSClWK7FMx0njYTbvHnvhs/+fIMBPYw1kiudLCJxs3MMaBGvWpgZPOZo2PZ5V1j1lZJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Nca36bDpJgZPPkBqyrYycJ5tYt0634axG2dvgcFpGw=;
 b=RR3nS6T8sG2S2IShoooEGv33il66TF3KFGuD4E/3CYtyvWWLYkctBRrJeFxiDTMwOYx5YZNx3Uc7IDi/Ebn1jegbqj+7rh2lQ3pDjKePv4m4lVCmYcJyUPVkcWvSRIJRv0/Z8CO2TpUEIeQvW4onPelnFU8u2tumTzWNIYB1JqwwA6VhMy1Y2VDHnjH7Pn5chxD9eVltdzwsmsCW0gzU8ZrkxxJscwUQbQsqfnZeBLMYEqcX1ruz2+0t6hy1etPu90PR+lqlcbbBqIq19MgjkdN19dkIdzA5HSP1HvTBMrtB24H2MMfMEjUA4Q2yGuNcS7L7FM+ukN7azM/uC96fLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Nca36bDpJgZPPkBqyrYycJ5tYt0634axG2dvgcFpGw=;
 b=ZEygUXLVX+OOvgpjOCq4Gj8aKMODyUhFSCAk5korwh4NlFqROfdoYQJPjnjkeun9Fw224cdboSihNK5TImZMgg6J1hyIl25wBo0R9yNNWvMWQeNsdkXHzjR2Jo2iql680CWthwzOC0sOMBF0IoQfqib0f0pjJdN+i6oO4woc3aAH4HpFx390aALNhOmM9OFjKYD+emysDukvg50MELZi06Q9PI92i1ksEUW6TvoEkZJjj+MY+YvAJTcu6QAKuiwOvvUTX84vREMQduh91QUqKmrLTP3Iwf5xgBegSqZvAzrG91fC/TcsNHYRHQq+D6jPWT0uiDxUIwV/1lIg17bVeQ==
Received: from CH0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:610:e4::6)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:24:56 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::f7) by CH0PR03CA0181.outlook.office365.com
 (2603:10b6:610:e4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 10:24:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 03:24:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 31 Mar 2026 03:24:46 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 03:24:42 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v6 08/10] dmaengine: tegra: Use iommu-map for stream ID
Date: Tue, 31 Mar 2026 15:53:01 +0530
Message-ID: <20260331102303.33181-9-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260331102303.33181-1-akhilrajeev@nvidia.com>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: c2317ab6-f6f5-41b9-5109-08de8f0fc149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	d85k5mWC5R/DYkz6M+sgSbwXScYWDKL5lcop5LgEi/YP0MAoggaWquCo3SuTmZULoEUjyk0H4tmz+3rn9qAMudIKVyHcotOig8zEThRwq+8GIXbOVvKKDryL8vne2WzCzrKPqx6Akk383SUMvj80ri63jmRQDdk1sKzT/nn1BcOFgMRQCoaSMjhdnV+Yitx+ed9lJbNMkAkYvQbhQgNmMoNmTmpf91wvYKsymkkdP0qGjOTFErkWYT49p2Bh+otPOQPuZ8VtXvWtH2VviJfe9Bx1HoPNdKkXU2jHkuYMA/yFCLVk7RXyyL1Q8aEyURv1/L+nEVwiem+u1y5n4akzY6NFMmLslvZ/WypG+07+kVAQ7sblAuiD/Zc85UfLPxTBJkKQnBa0EPo8qc383w63G1t/SsUEAIbtb+Mu256Y4pUOxLGK8QVyaM35j8mu2rJ5qiLSTBC8huWNOpjgNOzWKft/nTEnw2nNbSj0J8LYVy/o8Y2Pd+8u1xSvbdECdjwdJlDbemIev0eF5Pm0XjGOTYB5dngAEotowQXpgUIKBSZxoJ5k84MAtqPCgZXftxgGSS/3Pio0Lmd1QXIupa3dh6H9rVxAiTc8NMahnlS7Yh4wtk9Ncs5vSbtxdowjKIEcgbmRsIM6wNX/zfiktBU8VK6tE/nQk2lWEDHk0dJfUIPeXQIO7x91jeaigiYbVG4MEaa1r3QvS6FuP8hhgHhOh8r4f53UCHQMsVrxJ3dMi9B3r3JCUfX0kETzDteJE20Kcz9ve34zr1vkvvCYoa5Yo/YnZMai6xKtxpP8QZmG0/wPg02WTSNTEjhAkO4ZG230
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EAdmcBxV43ZybosSxjytJ+GjWHEGNMeua/82fh3H6VE56IulTD3mnz6+HGEPo9vjBCCyhrV4UWRRPYcTnyhXUqNIx7NRhsNJfWKUf+CX905tBgsd5BPs5i5eE+0y3gzoPEYzYDFQyaQIRM6BETvDmQN9n8tcHQkIAtEmdqkFvkCFB/f+hT1+++Lo0S4zusONL/LPzk1ZjlTFc51jKuS1PJk1scUOddzzfJ1ii6bRxoL/WUXcR2ncDjCKmlPBa0SVdn5b2P4qN3RDlCS1zW+e9uWyCbZVqGruIadIe3CnqVxyDvcWwWqSE4D672KbaEtXjw12ubyssnxiZHM2SywpBpsIyf5fXR5+NUi9VGScG87FoSmgRnCGtxJzwxp9dLxyULYx/1lAlDH+8KPSW16I1tAcrlRrqEGknlEKNTD+GRGKOKYdnq+8BZxGqv2oMln3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:24:56.1781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2317ab6-f6f5-41b9-5109-08de8f0fc149
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9767-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0E0673681AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use 'iommu-map', when provided, to get the stream ID to be programmed
for each channel. Iterate over the channels registered and configure
each channel device separately using of_dma_configure_id() to allow
it to use a separate IOMMU domain for the transfer. However, do this
in a second loop since the first loop populates the DMA device channels
list and async_device_register() registers the channels. Both are
prerequisites for using the channel device in the next loop.

Channels will continue to use the same global stream ID if the
'iommu-map' property is not present in the device tree.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 53 ++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 9bea2ffb3b9e..cd480d047204 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -1380,9 +1381,13 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
 static int tegra_dma_probe(struct platform_device *pdev)
 {
 	const struct tegra_dma_chip_data *cdata = NULL;
+	struct tegra_dma_channel *tdc;
+	struct tegra_dma *tdma;
+	struct dma_chan *chan;
+	struct device *chdev;
+	bool use_iommu_map = false;
 	unsigned int i;
 	u32 stream_id;
-	struct tegra_dma *tdma;
 	int ret;
 
 	cdata = of_device_get_match_data(&pdev->dev);
@@ -1410,9 +1415,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 	tdma->dma_dev.dev = &pdev->dev;
 
-	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
-		dev_err(&pdev->dev, "Missing iommu stream-id\n");
-		return -EINVAL;
+	use_iommu_map = of_property_present(pdev->dev.of_node, "iommu-map");
+	if (!use_iommu_map) {
+		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id))
+			return dev_err_probe(&pdev->dev, -EINVAL, "Missing iommu stream-id\n");
 	}
 
 	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
@@ -1424,9 +1430,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdma->chan_mask = TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK;
 	}
 
+	/* Initialize vchan for each channel and populate the channels list */
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < cdata->nr_channels; i++) {
-		struct tegra_dma_channel *tdc = &tdma->channels[i];
+		tdc = &tdma->channels[i];
 
 		/* Check for channel mask */
 		if (!(tdma->chan_mask & BIT(i)))
@@ -1446,10 +1453,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 		vchan_init(&tdc->vc, &tdma->dma_dev);
 		tdc->vc.desc_free = tegra_dma_desc_free;
-
-		/* program stream-id for this channel */
-		tegra_dma_program_sid(tdc, stream_id);
-		tdc->stream_id = stream_id;
 	}
 
 	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
@@ -1483,6 +1486,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
 	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
+	/* Register the DMA device and the channels */
 	ret = dmaenginem_async_device_register(&tdma->dma_dev);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret,
@@ -1490,6 +1494,37 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * Configure stream ID for each channel from the channels registered
+	 * above. This is done in a separate iteration to ensure that only
+	 * the channels available and registered for the DMA device are used.
+	 */
+	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
+		chdev = &chan->dev->device;
+		tdc = to_tegra_dma_chan(chan);
+
+		if (use_iommu_map) {
+			chdev->bus = pdev->dev.bus;
+			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
+
+			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
+						  true, &tdc->id);
+			if (ret)
+				return dev_err_probe(chdev, ret,
+					   "Failed to configure IOMMU for channel %d\n", tdc->id);
+
+			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id))
+				return dev_err_probe(chdev, -EINVAL,
+					   "Failed to get stream ID for channel %d\n", tdc->id);
+
+			chan->dev->chan_dma_dev = true;
+		}
+
+		/* program stream-id for this channel */
+		tegra_dma_program_sid(tdc, stream_id);
+		tdc->stream_id = stream_id;
+	}
+
 	ret = devm_of_dma_controller_register(&pdev->dev, pdev->dev.of_node,
 					      tegra_dma_of_xlate, tdma);
 	if (ret < 0) {
-- 
2.50.1


