Return-Path: <dmaengine+bounces-9504-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEywM9JXumnFUgIAu9opvQ
	(envelope-from <dmaengine+bounces-9504-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 08:44:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B222B7220
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 08:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4AA3059FF2
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 07:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F39736AB54;
	Wed, 18 Mar 2026 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uamGfnOM"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21B36BCC9;
	Wed, 18 Mar 2026 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819603; cv=fail; b=jdwM2GbGZNwPua1FH/6YWl9oiWE9zvY1vpelJdmaF+3KXb4qVAAcQkFzYzGfOxnfXRTWD8tQjAvxCKjrSmsMhX2ZN/lTwsmAWSj2QZhdhw7fq8sEl38xmJOIZJQZqgrXpoRUzwP18mjepqo5674G6x2veqHt7Ig0LscHiGRCc7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819603; c=relaxed/simple;
	bh=SanAqAW1pZUMoeWKDJxdb0vZGdnzNzuSVA9HqdAIqHs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dtpz5VW9Ox7DquSIwRl0yeTuKyMxCs8GFdNPi7zBFCwSfAHDwvS++02e0P0MWGMMJITPYlxILmvsBw6s+8solaQYk2XWFCLzvb2wUx1r+yn2f8+Z0vkA3hkunmy/daQf29OslvwAm+CrsCSxraPNi/jDg9UrcPYTs4KfGboxOLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uamGfnOM; arc=fail smtp.client-ip=40.93.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tan6C7vMbiMwiUb2vgirGex03Awcp3q5egtZp02UdFIO3PLu2LelvwnqjSHAlyB8vP0xNpiimqSTG7FhKe4gHW3UcXD1ugcEdZSgjOhkKUbyvRry66kShjePm37fA7xnu7Yk6cJeeJ/1QrR6HJ1fJxmSPoVbw3eX2hyOkSrvPe24X2mM4OXo2d99iCmhkmrNVZjAIXEoqMqsV8JD/mqSAw1RUIyI1zFgmMMRrPksQGVPAeSj8pZ3/kyY6kNchGd8GqywSpM9rvw/gNLMG1aS4aE6AOtyH/ZMPx979VrHP14Muo12gWfERO8biTrp0IEJia8aPNO75G4asBmuFRGpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VluZvYQcFEOhVpqe0sEvybhjPEoQ9vQbxv0i9FvjVCo=;
 b=uq6GsJO/cnIE3rOkbvui1YxnyyoY0LVGAMSVE4QC2yEWlXMs8fQMmqQUwmwQkDLxYAxxDTZ0bv3l1rqbbz7989Ec5lySikyMrGyq7w4WphGqozZN92qIVfbhoyyvnlvVtr5oWXy3qJANN/THyOEHZU5fO9FqN2btM1uzma0epCi1BjkHLtJ4dgSWYb5KxlQbBB/Jl5al1R5pxXq4Kyog1eWA/MO+jCvabpAOAX2S9QFGDSjZ7gJQnyR7PbwQEPpeuHyr2shQqkv4Mxw6eB2YNnOgePGRY8rC1oX6TtN35mBRCR6k4+tKRG/VWlzoUGWn11Zzg206ILr6fokFjeZ+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VluZvYQcFEOhVpqe0sEvybhjPEoQ9vQbxv0i9FvjVCo=;
 b=uamGfnOMaAyYpp47guRTHvv5uQMIJ48y808XbQZToj/mxQ97ek7Fuy8tGL7NdOb323CTl2FGm5fe3zNdsEyuvW4FjOvtsVw5H62xmL3oCbfm4rxhla/geQU7QhIdQqq+MEIxz52vBiFT2/q6XpAYLYBHIQdAfiG/QsodvsCKCc9CW3d8rIOeswu5REW2VR4WqB6djvRnd7jX6LKgc1w2DIQ/lHM/f5nBHHIunIfnr+YsVkNAWtDKA4KYa/fUG/d2leJ3dlejiIXad3CcebGEjPwKAjZhepWzR6h/Mw2z/HPAkPUKeOpub/qpl8ZNuf91/7KiU/JEUKqQehnt/VSDJw==
Received: from BY3PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:39a::9)
 by DS3PR12MB999218.namprd12.prod.outlook.com (2603:10b6:8:38e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 07:39:56 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::c1) by BY3PR03CA0004.outlook.office365.com
 (2603:10b6:a03:39a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 07:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 07:39:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 00:39:41 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 00:39:40 -0700
Received: from build-sheetal-bionic-20251202.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 18 Mar 2026 00:39:40 -0700
From: Sheetal <sheetal@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, "Thierry
 Reding" <thierry.reding@kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>, Frank Li <Frank.Li@kernel.org>,
	Mohan Kumar <mkumard@nvidia.com>, <dmaengine@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sheetal
	<sheetal@nvidia.com>
Subject: [PATCH] dmaengine: tegra210-adma: Add error logging on failure paths
Date: Wed, 18 Mar 2026 07:39:22 +0000
Message-ID: <20260318073922.1760132-1-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DS3PR12MB999218:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3501d6-9166-46da-6141-08de84c18d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TbXa1dB2CcOezSIDiRlltTC9/nEEO0N79JnLiRJmUEC/+nd208GdxTZKHeRlNORr1NYHHoXlfAONf3Jc4IwRAANs3Ty5Z6xSKIhuM8c5UShvgXYok9q4i6kmMxIAGx+DgaySqSEFQ9Fsa3z+9uGZb+fpohdDaZTE4WmaprROKAUAf9O6W/+RIczFOxvHG+5aH8HmDjhsMhQSyh8VjvFtP45giz7EHnPMKxRdGFrT03U3Sc7JCQYsq+GkevYl/uglGEP2pVOPgdu99TRyE5Fq6CTCGaVJWpIEEmzFVQ+Y3HMTPWZxzNXvw1Weog+kdFEQpkfDj3/CQg4BlujmCfW3fZFmU4zQL7NM7zDuOQ2JexbnU9vNVNrryA0rVX2ZyohfnlHR0H3IHZDw/s4WlQvrBrvo5MXNZmux6eGAJT4/5JneMIRZUL25aM9x2XX07ygJSblMzd+Y9Uu4mkKQ3epWAbBAVvo+n6jV1qlVaoGfKek0kUXkl7XlzJqvRYUTiMOd4/GpCfVLLpEu1EoyCUBwcMxQMW33/noXJQjrnmLCuocVMdAhdC4MoudXPWoClYUTY6pCAc58pdybnd+Su1ouFTcKodHFvvBoItblaA6D4ehnEgFjdlGUQX+UfCqu4QYJTLpeMb2uM/qZ6gNymUQC5Sfkq3BhaT5Jb8/23Yl6Y/OTZxE19el1IaC7HYP1inQJ/PPa1vAq5rBg8k0qiUM+7ozHdvQsFkVZHayz4EaYK6ALpFBVg9Am5hap2Jb8fKlf8cMt3LOProyx7ojU2lCY9g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	27eK5JKrl8PzGiz2iVlytaxy24MjD9hHxQeUfEQtjZJQln7u8VcIBx2oVRvNh4Cdut4S6HGTXN7FKZqsVMLh+jINsbY2KvTzVpUyIUondVJZTQ5xuDNDZ/ZTBnthtVdH+jBQOKVyRUVy1EFWg0UsgmfvBuceq6ukXidJvNg7Njr7bG7b7gAqS6c4KCtA9GNIIUtGN5FjcUI3P6Xyc2cNcXedXVEFsfhbcRTZIDSITpu4oa863sg/4cZafY93k50JcIMl+vf2YY82tw+OwnbqRFkFETOqYxYa3KrF/62XYD2EviXb/buG+StHQvDvkbo0YeQEa70K48sRSO/nTHvYLrrigpgJZUQ7dsR3ttSkIwnkOWTPtOO+fBhx/akSN2w0FOd1SbGnHTw3/c1+hp09Ll1MT+Zzr4XmQcZSK0s5EP6/yNjMX0u6oDUi+nKYtnss
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:39:56.2344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3501d6-9166-46da-6141-08de84c18d15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999218
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9504-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sheetal@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 71B222B7220
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add dev_err/dev_err_probe logging across failure paths to improve
debuggability of DMA errors during runtime and probe.

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
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
+		dev_err(tdc2dev(tdc), "invalid DMA periods %u (max %u)\n",
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


