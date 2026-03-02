Return-Path: <dmaengine+bounces-9169-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMqgAvSFpWkeDAYAu9opvQ
	(envelope-from <dmaengine+bounces-9169-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:43:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B38A1D8E54
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA11B302DF42
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9E36E483;
	Mon,  2 Mar 2026 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D0KuexOX"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56D361660;
	Mon,  2 Mar 2026 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454988; cv=fail; b=EunM0yKk9koaBQ3zv+zXQ/7FqebR5D1F7S+Vxt2DOPFK+ddoQb6oAX8I6AT9Ch/3nFFlFMlJnxRmZ9gnhQ4LKzfz542qn2ohfXVWw2PW5YaGy5/IZYM61fWLdTANZ+CjQnfB5UKRvc+UZXZG16nLVNReueUxU37AudO98D9QsaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454988; c=relaxed/simple;
	bh=D8CQRcpDHP6mcyD7f+r+90vTp6VrX4puBnj3dSMXqCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHTSBRUtVAyw4+RyIua/mNIaqnA1Z24BDSKNdJ5N6wMsuABpVy1wnMj2Rxqr+nBf9wIKpxfw3d9nac7MYczQvSmVYXoKQWW3Aq0J9JyNB1hK8CFpek0V1fagWVubGes7Sp7epgg2q6ckLpacA5Po+Dbqv22qH1UqCUaBucID2g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D0KuexOX; arc=fail smtp.client-ip=52.101.43.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9s1R0VNwnjg+w7fjV5C9Tec+3tM1y42UOECScSdbPebeWqngr48uEP6Etoe2mLH60a4gPQIS9LquL+UnzUmtyX+inWlDH5SDoBw/n1xKGQVHKyELwD8quv+J3kO/VbMbvgAdfaVgRAa9PY4opZ3BczDo2OKgO7MicxKSgslzGpiJaCI8DOhe4wj6wM2SUeuY9HqPXFvVcypxjWpFS1h12tpWHq3vWc8h/EdkmdbRXOsDZ2XPSHAUQUeixn0e1PGL1XJDkyoV+onwFqAdDfz3MihyMFreOAy5JzF4NWVjDqnyBJgtHuk51J4k7L2PwuqMut/oWWklFwJ4ZnCZXz7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIt94m3KU59y5MR+T9JvrP9DHYgDQLNXCijccuLwjw4=;
 b=AQD28lSkO8GpVgRV86yKFgHn6MmBEmlp4QWZJBSaizNDzTh2Xy6bCihI0OuUVDk58J0LZ2fbxPxNkFEMCrdszbx0ilwRsX7QrsikwWjfYlIJnHVfmArvZhhQA9zASEbd1j4R9loQrIPuow1aU+CEapNgXdy/WEyeaci7e1d5lc9H1037DiAqKDJV/04fMDHxn3n0wDkSGPxvV6yrpXXp72ejljU4ChWcoPymEQkyxHZEIwYcRh7gEAfyGds8w1O2EECJ77N2QxiVwWXm3OdwpWmie/cWMVomg57NqgmCHyjfB2pMkE3ePtbrfF5/9J7cgD1wIfQFptKlHFhOLK5Jgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIt94m3KU59y5MR+T9JvrP9DHYgDQLNXCijccuLwjw4=;
 b=D0KuexOXHTA8J4GfTbCnkaa0hFrhVzRy17uvZOlg5E3BElT0oFWBBcx26OUEbjrkEO7m78pEmDXETMHkg/83zoCLssgKMSx37VpzKqpjvDgpx412FUpjONneVh3NJsKs8cvXQ+ropK5kL86mqasnQJq024Y8xi95p0GB4fMc0H4BwQoaRRwWCpxx1y+H70p9Ulc4ecfoDM/NZuOG5KShiklpSelLOpz6/3PfrtLsw/PQPHjXVKIBSdtKI35ZGElOcBrEkZ+s2vcrh8/3oLge7SKr2DyXm1snwF6eraJrk9HqEUSOyZfpMgbQO8uJ5MERCGMOsp14ChXy8oLSfU/Lcw==
Received: from CH2PR18CA0015.namprd18.prod.outlook.com (2603:10b6:610:4f::25)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 12:36:18 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::37) by CH2PR18CA0015.outlook.office365.com
 (2603:10b6:610:4f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 12:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 12:36:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:36:00 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:35:59 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 04:35:55 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 7/9] dmaengine: tegra: Use iommu-map for stream ID
Date: Mon, 2 Mar 2026 18:02:37 +0530
Message-ID: <20260302123239.68441-8-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302123239.68441-1-akhilrajeev@nvidia.com>
References: <20260302123239.68441-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: d24b6b32-d520-48c9-107e-08de78584d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	2/tuaVZz1DwqSfI2fik2qx+SxeCu82uwwFBJJ3YlVk5OrwOW5bDH2KHxsA115aVzcBHPF5KtXZ8eMiFPu0d6HuLuxelUN006cfbhOeP28aYY6w8phXIOU7YHRZv3esKcppoToRD5wEUKwtFAQBarB2PrzY1+zw++ZKMFqt8Uk0aW4vlPwc0L5PbRGvhCevxjp4DdWK4X9AEUzDKsjAgiMpH9dpj7H5fjfutGUt1f9oXi9hGJUS6WfMJx3OZ36NBNcB+2qW7E9SyCA/dgNU/c4DhGdPmXF55efLzMt2iQlDjhR4I30UNA38nKlULqm3zbFxLuXg4mZxYG0cV8moRUJ1mfgx2OAcBdyUJetFye+Xo9i2EqB8ZF9I1UZS8BU9EGsdz7CLNzyW68+su+fv+aQCsnZ7o2vsaTm7bv0jvIEbvzH17qiN18Rs3OAuZZrDxyiPIYu1Ms40914Y0/WuknvFInCrZuLyVGxg1YTHZ8N6pL0k+hOO1pNxTcq01Y5IozlqCCuQ1fX3GhJP5dqhBGm+UCPrSmPuq9tZnxfrMhIDwjMoThF5UvdJcPj1utJU5sal783GTm4EhIi8KcVx0O26KEmQG1xEmfrYge2kVLhOHcUvrVL78dFygQegEcK6W+wu/cy6iazkbiqu64/T8H2OFyppvwY7uPEQA/BBfKWYoc85t36pLewZmNu6+0ymkKSAFVqA3gRFepqXY7bZvBMfQoOzAQ3F2IdQ2zbKO+prqRaHHdnfiuPL6n/D2vVzcsjaURAEucUSpFis7CkbAeAWIOZVhvOgyUh0KxQNu3Qli2SR1aqbQfJ8yhaRz8HED+uJzaWGay7yOVYvx08DCsPUV0l8vEhi/9DrVP+guszXs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CgTboK4y+Xp3vrtn+N3JuVxaov2T5XsfY8yk1LJzQW5aaZH4P+UovSNhgVEDKRgwp24cTGh92o1fE8sx0HYVzUYMiV8mv0u1soiZ+P/Ss1CoWJW5m9sal5LH/INVlEuAC2oytLgOUfCpPGJLHuSVqJ6M2NcGmyW5+Xjw6yEf9FTZ0mdgTtdN0e8jhA5k9OBE1HR+u1DAxKR+b17ibKoRNR6Te/EusBfrCCRf3/m4RbV93gDKSaPnx5ltfvBbCY/wZnzDSjAVRT+uJOX/crMqtKwnGHHiWxWxFy2TIRYRuIOi/UYMabznRyA019TyfXzYBpS76afy0YLNQZBWb6Ci0G+jcvrfcrTIrz2RKwaiPEziCff/EC6NKVQBsKcFNvPZOIj+Jw2v8L8X6npdfR3XlIsiMzwRrlMxApN29oKZrbXtraCdozU17qgNKhkF4fsq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:36:17.9733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d24b6b32-d520-48c9-107e-08de78584d39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9169-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7B38A1D8E54
X-Rspamd-Action: no action

Use 'iommu-map', when provided, to get the stream ID to be programmed
for each channel. Iterate over the channels registered and configure
each channel device separately using of_dma_configure_id() to allow
it to use a separate IOMMU domain for the transfer. But do this
in a second loop since the first loop populates the dma device channels
list and async_device_register() registers the channels. Both are
prerequisite for using the channel device in the next loop.

Channels will continue to use the same global stream ID if the
'iommu-map' property is not present in the device tree.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 64 +++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 5997edaba28e..9af509ecf495 100644
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
@@ -1390,9 +1391,13 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
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
@@ -1420,9 +1425,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 	tdma->dma_dev.dev = &pdev->dev;
 
-	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
-		dev_err(&pdev->dev, "Missing iommu stream-id\n");
-		return -EINVAL;
+	use_iommu_map = of_property_present(pdev->dev.of_node, "iommu-map");
+	if (!use_iommu_map) {
+		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
+			dev_err(&pdev->dev, "Missing iommu stream-id\n");
+			return -EINVAL;
+		}
 	}
 
 	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
@@ -1434,9 +1442,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdma->chan_mask = TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK;
 	}
 
+	/* Initialize vchan for each channel and populate the channels list */
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < cdata->nr_channels; i++) {
-		struct tegra_dma_channel *tdc = &tdma->channels[i];
+		tdc = &tdma->channels[i];
 
 		/* Check for channel mask */
 		if (!(tdma->chan_mask & BIT(i)))
@@ -1456,10 +1465,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 		vchan_init(&tdc->vc, &tdma->dma_dev);
 		tdc->vc.desc_free = tegra_dma_desc_free;
-
-		/* program stream-id for this channel */
-		tegra_dma_program_sid(tdc, stream_id);
-		tdc->stream_id = stream_id;
 	}
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
@@ -1497,6 +1502,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
 	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
+	/* Register the DMA device and the channels */
 	ret = dmaenginem_async_device_register(&tdma->dma_dev);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret,
@@ -1504,6 +1510,46 @@ static int tegra_dma_probe(struct platform_device *pdev)
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
+			ret = dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
+			if (ret) {
+				dev_err(chdev, "Failed to set DMA mask for channel %d: %d\n",
+					tdc->id, ret);
+				return ret;
+			}
+
+			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
+						  true, &tdc->id);
+			if (ret) {
+				dev_err(chdev, "Failed to configure IOMMU for channel %d: %d\n",
+					tdc->id, ret);
+				return ret;
+			}
+
+			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id)) {
+				dev_err(chdev, "Failed to get stream ID for channel %d\n",
+					tdc->id);
+				return -EINVAL;
+			}
+
+			chan->dev->chan_dma_dev = true;
+		}
+
+		/* program stream-id for this channel */
+		tegra_dma_program_sid(tdc, stream_id);
+		tdc->stream_id = stream_id;
+	}
+
 	ret = of_dma_controller_register(pdev->dev.of_node,
 					 tegra_dma_of_xlate, tdma);
 	if (ret < 0) {
-- 
2.50.1


