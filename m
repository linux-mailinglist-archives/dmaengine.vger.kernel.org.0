Return-Path: <dmaengine+bounces-9584-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLvjNQX9wGmiPQQAu9opvQ
	(envelope-from <dmaengine+bounces-9584-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 09:42:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CCB2EE66B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 09:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 108243013846
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 08:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C3A382299;
	Mon, 23 Mar 2026 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MChI83xG"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D920459A;
	Mon, 23 Mar 2026 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255284; cv=fail; b=tyP+/tYHnT67m0NwYRW/BuI8cW+DsvWtfwo4sA1fMbL7Iv3aJq7/MXEsZER+i4whgLU9y6yq4Y1Ff5c7mBsmkRLXYjaJcr+4f89AsL51SwWiM0W37Zqv51oKdIFUcUSpe+UeQIVh6zmb8x14gdos8eIPJCEuU9UHRyfpUi7a52k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255284; c=relaxed/simple;
	bh=pUsuzbY5Bq+BAY1vtihjuSa2vl+RO1wyD8rxm8QcHXI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LN37O79z70GLjjNBByAFbb4QZelWgqFAbn94DnbVTRex6ef+1RAh0NuS6sN3OMlyFlCO6gdsfVs4BOYlKXOdzqoOXS34Jh2v7uE++O29VOZ67SQdDxjWeKGRUm+e07ORaHs8kMrlT6yqfh0IPqaIBW2PQbSiV0a5uB/YWOMnFbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MChI83xG; arc=fail smtp.client-ip=52.101.57.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP7eRuSd+e0HGMwORw84He6eI4+FrMa0sA5DLEYUPWdXfDyH9CUUIjaZ869IhA58/hgwIRP0b0EiBG5LlH9eliNgICUgrApBfjBGxQ5eZDxy+k3rO0sigXATV+6pfj+LDXZOh9wXt3SiIyBiRguSp42GrCmHjIybQGRiLcJmE/iNeCbPgU4OuXMoL7gFzxzuVNMTAO1Hf85BGPe1F+ThSD67w8ToFg7AucDR5GBOgO84P/WJ2+7gr9EUQVKZIGO7xkLm5G2twLs60xXxutCWn+7AWTcsCXR6l5WcsrgHtsmynn5dtH/9TkFttMDAUac0nnoNX3+DArCDBWgnsdlNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeGiyDOwlv0wSE67e7Jgmeilui7pBbQWyY3mqRGaKh0=;
 b=hdOcMPPl8VVZZ/p0H/ykUpxZTyB9AWzvpICfq2/NnTucdfG2TT4eY3tYnAI7f9ThxtJGRoRRNZLYawYRPFOO8qfP5ctYqexB8O3p5mcD9OWrPvPojKB/MLjpuE5NQN180IbMP//jRH2AHy1yuypXJHrWatfQSay31LY/Wf7/1k0vkgEDnP2AXaoxGEiAyAdDPr64P7xMbgk8GB68LSf4/d+m+IqHvzoZH2pq+38js2E95HD1Q7jFGaymyc3fjpqAiap/rA3jxxeBlDn/ahBrnXfTiCYcpYuGFv6v/1vTgOfdHQmRgYDS3OHFnvqa6VV4AMImVwSAM5gDeo/1e84taw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeGiyDOwlv0wSE67e7Jgmeilui7pBbQWyY3mqRGaKh0=;
 b=MChI83xGkwcnbjIXNd045XRAJD2LhJpu4E4IE/Q163AnWJ8K3EQ7zmWScTSvHhLHPbnUugsNEhvp06I1bVY4B8/3V4U+qtt0zhKZbAWr5OxQfJJxEjyY6o9+mKA7eMM9HO4ryse5DyJZUtoi+QhzQDj40UOPBfWlzmzGysolBnG0YOmNVUSktkxkEOxRCq4BHgiPyNUdsibGw/vxkJdgf0QSglih4196kLEsOW7UQussP0upLTIp5rZVcoWZXKs3K18x9mWRz0iB6YSEtFScsuOTm9JUoj/RCDglgiVHvB2ksgMJsm74VU4nxyTK2XXHI/VJfnmO9NcL8SeaJZdgaA==
Received: from BLAPR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:36e::7)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 08:41:16 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::c4) by BLAPR05CA0007.outlook.office365.com
 (2603:10b6:208:36e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 08:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 08:41:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 01:40:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 01:40:57 -0700
Received: from build-sheetal-bionic-20251202.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 23 Mar 2026 01:40:57 -0700
From: Sheetal <sheetal@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, "Thierry
 Reding" <thierry.reding@kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>, Frank Li <Frank.Li@kernel.org>,
	Mohan Kumar <mkumard@nvidia.com>, <dmaengine@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sheetal
	<sheetal@nvidia.com>
Subject: [PATCH v3] dmaengine: tegra210-adma: Add error logging on failure paths
Date: Mon, 23 Mar 2026 08:38:58 +0000
Message-ID: <20260323083858.2777285-1-sheetal@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4e9793-4e15-41c3-0bc4-08de88b7f1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W/EW8oS06sm7tKXY2MWLgC5MHh29VPCfrS3AunhwBQxcA6VSroW25lVD9m3NdJv/Sjp7u9TF9WrXlIj/4hNNXLd7JgeoPG+3N+sSLRCeXAtqHTCYb5msQuPqetJTEvG3jGdwH+wgBD7tPq04PBw8tX1bIBjoRP1NdfmgowCTOPFBev2w5hNhqUfj0KZRhINDJyeOZ9JDaB+N5NfloX1W8aRmqXkRvnPXmOEW612uWlxEZTBjr474wsSVoeOGMXgMFXE+JuR2XZEnl/0cgTOWmsTjKyr3VvBvtNJY+EVFyXd7aMuHonAMYnKD9FzXHWq/gkOba04k517MqfpxFOdGSvSvwXdq/cou+9Jyw069vVVAqsMGqXjNIyZsBzXpXiAEDCBjjUYNAv+t7ROEYkTH/a4bP0+QXOpBMdrE1OLIHJZAIzxAH+fEp/a7v+HQ/Jhrl6VWGfMs3mfcIN+UBYD5gR8j9+R1TMhCFurCmE4QMe2KSp0nMpFfqNW8w0clYjQvo85l7ko/DSde3IjCFzUPaCx728ZLviXUi/anCCTb4HXhwDzjDU8k3Oa2yIHuaf/KZxOIeHraYa4weHCfJIea7BOdyiysHxpBGGB45+vw8Gg0JIVysz7XKA8lg/2my0rygYJRnQEEie5eXCFoz8cNozbmg2fvdtxwz4fuLGaoSUzs1GDve5LKPjtA+FbiH/nXwuvd92rWMDeDQYokKxRZCc1RxuRt8Rnc+JHmxOl/g6YiXXrZHVPK4Fl3cDMgwO0j72u6l2jaFv0j+qwHEBC9HA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eX2XpUKX5fBljKF54lOOONkHW0LaUp3DxczthIzxOMmhf1SCMLaHsqn93JSKPNSH0bp+vJYuvJCWN1dlgkYf+JzdX6qWVfOcsI60VqQVUfGoSAKQmPmy8un9lPW4EQ/Mwf878t0Tpf3tvmcmPR7rwF7jOr09suAE+LbQ6czwWE+Axw1Axg0CqFFr5fpfhz35MNFrzGHL1074GzUqh+wB1x+X7Kl9FM43ANffG++IcanrgQh8OSdzKiJzXg+UKhehSjLS0wT7OeHjR3b5YBEHAnkht2TE9Z2QGpOZHEP3m9/1Fmnn9qupF8S9HMpDyrFXpN/lFNQuU06v/acoiCwMwhLoVRUIiRKFL9mkKLZurYXmUk2/9/y0r7DXDwDioUlB1zBN6tNe44bwiHaibk4EVBpkGweTv9fLgOtrkstG/oMPYWqpGiyQwKgafT6ANfCS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:41:15.0695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4e9793-4e15-41c3-0bc4-08de88b7f1ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9584-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sheetal@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 60CCB2EE66B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add dev_err/dev_err_probe logging across failure paths to improve
debuggability of DMA errors during runtime and probe.

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
Changes in v3:
- Cast page_no to (unsigned long long) for %llu to fix -Wformat
  warning on 32-bit builds where resource_size_t is unsigned int
- Remove redundant dev_err for devm_ioremap_resource failures since
  the API already logs errors internally.

Changes in v2:
- Fix format specifier for size_t: use %zu instead of %u for
  desc->num_periods to resolve -Wformat warning with W=1

 drivers/dma/tegra210-adma.c | 37 +++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 14e0c408ed1e..a50cd52fec18 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -335,8 +335,16 @@ static int tegra_adma_request_alloc(struct tegra_adma_chan *tdc,
 	struct tegra_adma *tdma = tdc->tdma;
 	unsigned int sreq_index = tdc->sreq_index;
 
-	if (tdc->sreq_reserved)
-		return tdc->sreq_dir == direction ? 0 : -EINVAL;
+	if (tdc->sreq_reserved) {
+		if (tdc->sreq_dir != direction) {
+			dev_err(tdma->dev,
+				"DMA request direction mismatch: reserved=%s, requested=%s\n",
+				dmaengine_get_direction_text(tdc->sreq_dir),
+				dmaengine_get_direction_text(direction));
+			return -EINVAL;
+		}
+		return 0;
+	}
 
 	if (sreq_index > tdma->cdata->ch_req_max) {
 		dev_err(tdma->dev, "invalid DMA request\n");
@@ -665,8 +673,11 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 	const struct tegra_adma_chip_data *cdata = tdc->tdma->cdata;
 	unsigned int burst_size, adma_dir, fifo_size_shift;
 
-	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS)
+	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS) {
+		dev_err(tdc2dev(tdc), "invalid DMA periods %zu (max %u)\n",
+			desc->num_periods, ADMA_CH_CONFIG_MAX_BUFS);
 		return -EINVAL;
+	}
 
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
@@ -1047,38 +1058,45 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	res_page = platform_get_resource_byname(pdev, IORESOURCE_MEM, "page");
 	if (res_page) {
 		tdma->ch_base_addr = devm_ioremap_resource(&pdev->dev, res_page);
 		if (IS_ERR(tdma->ch_base_addr))
 			return PTR_ERR(tdma->ch_base_addr);
 
 		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
 		if (res_base) {
 			resource_size_t page_offset, page_no;
 			unsigned int ch_base_offset;
 
-			if (res_page->start < res_base->start)
+			if (res_page->start < res_base->start) {
+				dev_err(&pdev->dev, "invalid page/global resource order\n");
 				return -EINVAL;
+			}
+
 			page_offset = res_page->start - res_base->start;
 			ch_base_offset = cdata->ch_base_offset;
 			if (!ch_base_offset)
 				return -EINVAL;
 
 			page_no = div_u64(page_offset, ch_base_offset);
-			if (!page_no || page_no > INT_MAX)
+			if (!page_no || page_no > INT_MAX) {
+				dev_err(&pdev->dev, "invalid page number %llu\n",
+					(unsigned long long)page_no);
 				return -EINVAL;
+			}
 
 			tdma->ch_page_no = page_no - 1;
 			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
 			if (IS_ERR(tdma->base_addr))
 				return PTR_ERR(tdma->base_addr);
 		}
 	} else {
 		/* If no 'page' property found, then reg DT binding would be legacy */
 		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (res_base) {
 			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
 			if (IS_ERR(tdma->base_addr))
 				return PTR_ERR(tdma->base_addr);
 		} else {
+			dev_err(&pdev->dev, "failed to get memory resource\n");
 			return -ENODEV;
 		}
 
@@ -1130,6 +1147,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		tdc->irq = of_irq_get(pdev->dev.of_node, i);
 		if (tdc->irq <= 0) {
 			ret = tdc->irq ?: -ENXIO;
+			dev_err_probe(&pdev->dev, ret, "failed to get IRQ for channel %d\n", i);
 			goto irq_dispose;
 		}
 
@@ -1141,12 +1159,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err_probe(&pdev->dev, ret, "runtime PM resume failed\n");
 		goto rpm_disable;
+	}
 
 	ret = tegra_adma_init(tdma);
-	if (ret)
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize ADMA: %d\n", ret);
 		goto rpm_put;
+	}
 
 	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
-- 
2.17.1


