Return-Path: <dmaengine+bounces-9506-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNCIFtx9ummTWwIAu9opvQ
	(envelope-from <dmaengine+bounces-9506-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 11:26:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 066972B9DA6
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 11:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0C6B3028831
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EBB394490;
	Wed, 18 Mar 2026 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mLM1VxS+"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CC34EEFD;
	Wed, 18 Mar 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773829479; cv=fail; b=Bknxi8W1s5jUjQv2iJ/iP1Ke0PycxpVJdAbB053kvdPzyYjOs9PeQkj3tKRCRCAL2DSXMDrBNSi7ZZitFGQKHJSIlXmxOKOevDCAGWyx0BtHPOltFXVeqTyYtLZtmo8KyEcfq/zrd0r3tWxfZvo99kbtQoF1wS1O1Oa4eRnN5d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773829479; c=relaxed/simple;
	bh=cbDH5GTKju3ZZ6Dr2gi/g7SM8jVjVIc4m9xzSNfl3dI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FbPM5/NArn2rR1gPcbwf7AQiw6hSZKhcjkzri4gnyKZ7OIwaJWxVlEQ+RpdLiOEgkFI17OE8xnRJX6j6iIh1rgNiHZSa/jXbA2LTh3VbeZaD7ouZRraEzSuW+XcSqNP5HaleKP1c5wU7It5MJta/URHt3RscunTzJH/8GRPimlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mLM1VxS+; arc=fail smtp.client-ip=52.101.57.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxwHp1HnG5A48PCnsNqGn9K9cP3Gm4/EcTpnUdKrpzvwMZPcqpkFSWBKeEkod9Xhgp+ir2ncVe4XfHSXOTbFVGEEOWDpw+YwumACptqpuXjoQwcfTSjt5A21Uvb51c442LY/3GjyGo7u/GPuHpyctwujc4gIedWyPt87dsxkKslBkv/RNhXm6XYzKRhh1IVnRtR9QFQgetfD5vUVe+cexst/Lu8EEQP0a/mGqc5k3FLAx+0cr7dEVleTakP2BObi3Ns/6eK2dEqcYiDRoaj1w9aK2yKf9LGwZxT3t5M/w/MeT2Nva4KKCLeS8xYNxrd0nDqM5LLeJH163LxdPyCvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hv5b7P6cSQOtHEldfn/C0hKjHlEtY+6lecfjv9mi4kE=;
 b=ow8sAAfbhZj39E97rdvLwcEFJ4EcL2cgEa7jr4DGMPs+7hvmmubMwv0n+PB3FXFaoP32JKno173uGnXE9Li5B+qX90Py/KkPffEWORc4dwksY0BVRFRFBZgICiYm/dLpfyFjHJmgH3fLe/xVLk2w/rJiTaBG3HDKP/+bNurivb6tQnmiScET5cLUgBtGZur2Kkzs6k9VuJAWvA21EP/3rbUrDhvASh8pEvmCcf/bJMO11rke5BvTfG77GsKa5xxuit8UXzfAqqcaCXZfW7Ub9w3OLOw8E3FmXFHr03XEHuehf0/wiR2MuFORyF4nz16bhMHHgmOzZp2AU0I5olyozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv5b7P6cSQOtHEldfn/C0hKjHlEtY+6lecfjv9mi4kE=;
 b=mLM1VxS+U+xf+x33JkzesG5sJRS66BnJ1XdJ3cezs+s8Z5csxQAT07HAukM4eVUSHt/lnhBfJx2xzY/m2KKg3O/c+r1GatHD4uYl2gDg491Eu04batLMDB1Vqfy+eXecwOIYm7CJ3fKyDGwsv5Njbi7aIG6wVVlk8e3W0rnSPtP6H43r5KfESHvbagiLfTc08ijnj16MFHWToCuaLZ4iw0yhvhdtAQdfNB4LCvJ3UQZwaDAIA+T6WKHFH+r7oVZrSAuUlgCAoMevB+NGBUwVHT1R/JTcTEMRZPxMiaBOVcQqJrMntC1f6LpHDcf9nxc/PyO/ZntWmox3AX4oeYSQYQ==
Received: from SJ0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:a03:2c0::16)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 10:24:30 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::6d) by SJ0PR13CA0011.outlook.office365.com
 (2603:10b6:a03:2c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Wed,
 18 Mar 2026 10:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 10:24:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 03:24:16 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 03:24:16 -0700
Received: from build-sheetal-bionic-20251202.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 18 Mar 2026 03:24:15 -0700
From: Sheetal <sheetal@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, "Thierry
 Reding" <thierry.reding@kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>, Frank Li <Frank.Li@kernel.org>,
	Mohan Kumar <mkumard@nvidia.com>, <dmaengine@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sheetal
	<sheetal@nvidia.com>
Subject: [PATCH v2] dmaengine: tegra210-adma: Add error logging on failure paths
Date: Wed, 18 Mar 2026 10:24:10 +0000
Message-ID: <20260318102410.1800162-1-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 121a2784-41ff-464a-fee3-08de84d88a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ivXenEL1QsIXNo1R4Y+YPwOSWLcokNqtWId2GAXx0u18nj5SgVNy0dqYqaxlPJ9EMyvHHQKalAkQWIUmudrzT7QQLXAALuN+Xwr9l5Z0NCvVsY+Z16Vg+ElwKH83eNc+QHli+UkaM2wAAArvgbR4Joawcd91m/0RRoR1tvTpdxpf/f/JoTEkuGxG71kX7stWVobytiI3nO5iW3BEnpU5epa9GduKfpSDhHujojDu0CIvxaJTBjSDjIe27qc8SzAozVRbuWTZri28Omzd1j37ZV0beDPUy5wUdvYzzvpoG2cq1yOJP8zAND9BKsMOAf0jySeT5xqi+7hlARxK5mlFjUH7yD0rkbZDLnXZxvoAjCH8or/z4MnXFaWlqR+cI6YXG7Mf6NbrQFJ+rS+67x55bW8M0UfOavyTNAHpW+AIupfqHbJ7FopTD820bMhdOcs5m8XE3ASn8jS9NLmuwDYLp6S5ybE/jmmgzv+a8NFvhQJdR0Hn9d23lSYaNND1VYbzvYYxVqh3I1G5cDuNQfBjSoGC2U6tc8jFGkOdt77qLp6T7yJB1NUVjypa8YRjgSLhG+rSoUopINiPlZ1xHHDcIcskpwKY9k/kNn73LYPObimex9Dq0NC81pQWs0xE+tfXtsygLgEuTOaYI8mZF0UL5ajSukxfFqyXZkTpavB6IDGC9cSAzUf4pKbyjAfNOVxa7ujYD3LLr/xsUVTGPQsonBcoeRv+11kTSlf1I8PpObXjZUq5H3qugbGhJU6KWtCmipU721zW2uoLg4JfzAATbQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H+aNmqDZ2gnFXkKayNEPGgRfEqNLfdEewU701Jnlvu7HsgQvVIeGzeRumUHjRPBOZ8hH3QwpNxnpV4cgRJu2sCDHLvv12AzptKLaPmzIBgvzf8177UCZd89Zk6CU4JBABza8VbH4e/xMXvaa0CBC15LCEjwegSyN3QkspoH+2edm2qlQ77kQmD3ZbLcSEWxLWiuFfc4wWadeDIuM2MD4tBqdzzIK+jRoR4gTWz4BuX2qhEUY0mgB+4lLgvlfj7Siw4zuJYff9e4efhGsXlQ2DkwM7OY/vQiw7/Vto+YESVor68Be9QXqtsKe39H1O2bR+d6jMQ7/EgiPkWWnVcU7j9wy/vfEadFHHVNKUL2xNZw2lz7p5/xKL6Ua+XpY8CllPYAd15oRSF45R8XW8X681PndkcEAdJBrjOxi9QwS1yI/3uM7b36dKg12y43/sNxh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:24:30.2576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121a2784-41ff-464a-fee3-08de84d88a64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9506-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sheetal@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 066972B9DA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add dev_err/dev_err_probe logging across failure paths to improve
debuggability of DMA errors during runtime and probe.

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
Changes in v2:
- Fix format specifier for size_t: use %zu instead of %u for
  desc->num_periods to resolve -Wformat warning with W=1

 drivers/dma/tegra210-adma.c | 48 +++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 10 deletions(-)

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
@@ -1047,38 +1058,50 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	res_page = platform_get_resource_byname(pdev, IORESOURCE_MEM, "page");
 	if (res_page) {
 		tdma->ch_base_addr = devm_ioremap_resource(&pdev->dev, res_page);
-		if (IS_ERR(tdma->ch_base_addr))
+		if (IS_ERR(tdma->ch_base_addr)) {
+			dev_err(&pdev->dev, "failed to map page resource\n");
 			return PTR_ERR(tdma->ch_base_addr);
+		}
 
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
+				dev_err(&pdev->dev, "invalid page number %llu\n", page_no);
 				return -EINVAL;
+			}
 
 			tdma->ch_page_no = page_no - 1;
 			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
-			if (IS_ERR(tdma->base_addr))
+			if (IS_ERR(tdma->base_addr)) {
+				dev_err(&pdev->dev, "failed to map global resource\n");
 				return PTR_ERR(tdma->base_addr);
+			}
 		}
 	} else {
 		/* If no 'page' property found, then reg DT binding would be legacy */
 		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (res_base) {
 			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
-			if (IS_ERR(tdma->base_addr))
+			if (IS_ERR(tdma->base_addr)) {
+				dev_err(&pdev->dev, "failed to map base resource\n");
 				return PTR_ERR(tdma->base_addr);
+			}
 		} else {
+			dev_err(&pdev->dev, "failed to map mem resource\n");
 			return -ENODEV;
 		}
 
@@ -1130,6 +1153,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		tdc->irq = of_irq_get(pdev->dev.of_node, i);
 		if (tdc->irq <= 0) {
 			ret = tdc->irq ?: -ENXIO;
+			dev_err_probe(&pdev->dev, ret, "failed to get IRQ for channel %d\n", i);
 			goto irq_dispose;
 		}
 
@@ -1141,12 +1165,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(&pdev->dev, "runtime PM resume failed: %d\n", ret);
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


