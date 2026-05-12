Return-Path: <dmaengine+bounces-10342-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOY9D6PyAmrpywEAu9opvQ
	(envelope-from <dmaengine+bounces-10342-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 11:28:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A697051DA9B
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 11:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB2CF3012BFB
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 09:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E847A0A7;
	Tue, 12 May 2026 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YFIlfWha"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D735379C52;
	Tue, 12 May 2026 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577947; cv=fail; b=uunyY6r6spKXLDGqQzzzqYIX7PnguEeiijvBr98KBUkhN2E6CeI/Tigm+BSQEUzHogeQ+G1DLcGDxFQQXrBoU6h0b3tkKVWGNGK/U6fsrcol/nRDJ0d4orIpQ/jJhj4GxlXb1rYfwUKG1aHkyLDDzKDuMKzHkelXpGsqzhdhuqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577947; c=relaxed/simple;
	bh=pyhPdfXHMoAHloobXgCUWXY2X6PcLEDdjclofGI2eMo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hG73HXHsYnzdZsOr2WDg1lHxjs7nXR1W3fAsPwJ+HIL2turkrhFWYEL+v8ZVwV0Uky3rt2JkbBvhCREOd/wybH3eipEvpOfW4tX/OEi3K84bPTz0crpCUH8RuRxGEQVJxTDdiKfuzE1DXHdP5nBydOCthPG7kk0/389EavaTtyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YFIlfWha; arc=fail smtp.client-ip=40.107.208.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxXk7fNJk5sm5BcW5tkDYK8KA1shwdjjpCPpHanrQ+mN2Zsi01uOji05SrKBthYdV+YlGbYjTJ2XxNBXc0IBT6f9FAw0l9+2D9WyRf6zlMvTAs9WTRTKPHc7dhCZDj9Nxm43+rNBpE/BYyKeK3tFsghIk/WTbB+PstdFTxPyQxcB2uwnBwT4E9gW08LXweh3F5bQAiTyKtWU1DEhwJpLkMSpovrc1HgwdyqJsS7ZfKCjpirthPmwWnAH4RwzjTXC8Fvg/b6xaj7Xd4mzq9Zn5t0/UW2bze6izsXBmGt9oJ7jeWqBLRjDJemp+RBDYJOwdnFL5PKsx416NSPy5PF/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAa4M0P3rZy16zqV41YD4wQg0gbr8YB148mIEnvPPdo=;
 b=u7xhArqmBmJX3oDpoC0rqDF5x/Kb8kJUJ32id2u26mel8gf/pmIwlRykIN5B5OH63P9CShrl/0qg3OFD5gDpoFvFnRKbMgVyfuJaW6Oqex4k0aaDs5UhUYq4cCm2H552ylfTbren90pMJNxxeNDb+f2cfS842+l5ZJSHN61eGkn+O2shPXsB2G49X5RUN5KNM1aK7vpf1nm0m6isoS203VtmpxB8wDvMhomSe5d16WEYONtoFt9lPo5FJz9M8NIQLjPKu3xviw7qiFolfhRv5rFemjAy7sOOX9fZFLxy2j7bXTtui/5yvmS8GSfAJbueb/tDJTlWFPBct0XfF/mZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAa4M0P3rZy16zqV41YD4wQg0gbr8YB148mIEnvPPdo=;
 b=YFIlfWhaXl4sc8mBKieSeWUVbCxmMTbAeIgufT3PByan3OL0t8BTcyh9xazaVBVFaYSoUn2NSoH+ytaVAVz+UrjdT9BUObcGdjcf5UDMlOPIu6/z1/mEF94/NZg3kGcbv45m1eaRYTDS7ln8SynJ6huk6CE0VrNkL4HUBae2y5PgwNplr35MUbUn6N6hIOwJsDImXBBMRuEIS8LjbaSxuA/MVHakKJhyZrgU5IF0erjJ3Sn8zo/o2WDdNQ4Zgyijcmzr5NqqHMOwJ5X58C749CJZnizxlm0GHlAGaOWO7Up5QGrP5YeV9squWKCfgTmGDtVCfN5BZiqdwGg6WB1QVg==
Received: from SA0PR11CA0145.namprd11.prod.outlook.com (2603:10b6:806:131::30)
 by IA4PR12MB9785.namprd12.prod.outlook.com (2603:10b6:208:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 09:25:41 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::d) by SA0PR11CA0145.outlook.office365.com
 (2603:10b6:806:131::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 09:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 09:25:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 02:25:19 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 02:25:18 -0700
Received: from build-sheetal-bionic-20251202.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 12 May 2026 02:25:17 -0700
From: Sheetal <sheetal@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>
CC: Jon Hunter <jonathanh@nvidia.com>, Frank Li <Frank.Li@kernel.org>,
	"Thierry Reding" <thierry.reding@kernel.org>, Sameer Pujar
	<spujar@nvidia.com>, "Mohan Kumar" <mkumard@nvidia.com>,
	<dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sheetal <sheetal@nvidia.com>
Subject: [PATCH v6] dmaengine: tegra210-adma: Add error logging on failure paths
Date: Tue, 12 May 2026 09:25:08 +0000
Message-ID: <20260512092508.1406119-1-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|IA4PR12MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: cd77913a-d5ea-4b12-b498-08deb0086f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hbvrpHokktofYq4WMi3Br7AhrG66+qQM+vIZd5/DAGm8MW93nVJG3E4dj3PPJF75FdhmZpqiqP0sf+7BOo0xMC/DUE6yDuq74gbMMHmFDvkwh+oxBKyY84eRsD0yFwvt731oJhKvCwkuT3rfZddlmr4KSsR6vCNyaFvj22cZUa9Y+767CiGoV4XYU4jQU46Y7G7KAJEbwXbxWTuc/fMk1A08LzRi2r7BgovFLRexo5h5AGzlPbnH+my2OtyceDBlNArZVoWVueYt6hjaXKX8lpSQmV8dn2R5ijLYc0ecCb/LB6Vw3Hh5G98QzLLVyu+O2aWH0WegtRxdT60dKM5trR5GwNm7nJ545Lb69UhkvDhVUmbmDVAF4Y/pFZneKOnFlLxC5EgZYwAxp9FdEhT7KhirtlTts7RPkis34VHqmLAq8qxUaTEw3y+nLw3C3zCt4gSxJC+0yvUed5S/o4+L6qk2NaTbG5LiXsIDF8nmcFVnS1g/fcLwSEydFWva0JzoreUNjEpgj9/SBJ1cO6LhVZeYae7MwZ3NViK0Wt9PE/DbwKeE1KAIN5L1+ZchRuvro+mDIAqjJoSlW+4sl4UdulopZ+KHK59/mpuIJ+gSHeJVvVfJBXtdDvTdJhjg0Mj/Fn7XZxM6ASysfOp3thhzyDKigt5bPGIdLox+LePgS18m1tsmHri8nLeactku9Phq9G/Iwf4u0tsU6t/zpsaVXHE7ZrL/pFGFDpw1QaT81Ak=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8t9M8C5MP6jvEQwZeqsEOMu+tOLjro81Xdp5XHP81AivjelymV4pd9bCxzAAKtFgpcCRwFMkqDacTpxebfXcK2ZgicV/YMCdFlNpwBJ0IPv4M5ERYfIHV2qnVk2a9XmqSTrodlZW0L0RgvYSCm/05fShtR/kbNz+PS92+eO7FsGDvDZ2KFZw5QELnKqUrmq2ZaguOi9HysbqF1u6/s9hqJ1iOwdscs6Zh67K0aWTbfY9AaCyuohL9RLk2dPAtYZUAZZ4pj5iRYHw4jj5+8pcsLYHjlH/G1oqUIU7ZL8iraYUelyOk8QJ1xVYXMvj/P6Ud505gzujHtt3BHOzO72XrGIf6/DPzHLFba5nWuQevAapNc68fICzKXv/+xRrbOfXUIDdvAtGLfQJmliYdwnXy9AHE9Kh7KxfRsaH7G7GQIZ2PtdSEwv8vCCNFxxeUsK9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:25:40.7411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd77913a-d5ea-4b12-b498-08deb0086f6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9785
X-Rspamd-Queue-Id: A697051DA9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10342-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sheetal@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Add dev_err/dev_err_probe logging across failure paths to improve
debuggability of DMA errors during runtime and probe.

Use return dev_err_probe() pattern consistently in the probe function,
and dev_err in non-probe functions. Also convert existing dev_err calls
in probe to dev_err_probe for consistency.

As part of the probe-path cleanup, use dmaenginem_async_device_register()
and devm_pm_runtime_enable(), and add tegra_adma_irq_dispose() for managed
IRQ mapping cleanup. These managed helpers remove the probe error unwind
labels while keeping the remove path minimal.

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
Changes in v6:
- Document managed DMA registration, runtime PM enablement, and IRQ cleanup
  in the commit message.

 drivers/dma/tegra210-adma.c | 123 ++++++++++++++++++++++++--------------------
 1 file changed, 68 insertions(+), 55 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 14e0c408ed1e..6987bf6ec648 100644
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
@@ -1020,6 +1031,17 @@ static const struct of_device_id tegra_adma_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_adma_of_match);
 
+static void tegra_adma_irq_dispose(void *data)
+{
+	struct tegra_adma *tdma = data;
+	int i;
+
+	for (i = 0; i < tdma->nr_channels; ++i) {
+		if (tdma->channels[i].irq > 0)
+			irq_dispose_mapping(tdma->channels[i].irq);
+	}
+}
+
 static int tegra_adma_probe(struct platform_device *pdev)
 {
 	const struct tegra_adma_chip_data *cdata;
@@ -1029,8 +1051,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 	cdata = of_device_get_match_data(&pdev->dev);
 	if (!cdata) {
-		dev_err(&pdev->dev, "device match data not found\n");
-		return -ENODEV;
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "device match data not found\n");
 	}
 
 	tdma = devm_kzalloc(&pdev->dev,
@@ -1056,7 +1078,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 			unsigned int ch_base_offset;
 
 			if (res_page->start < res_base->start)
-				return -EINVAL;
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "invalid page/global resource order\n");
 			page_offset = res_page->start - res_base->start;
 			ch_base_offset = cdata->ch_base_offset;
 			if (!ch_base_offset)
@@ -1064,7 +1087,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 			page_no = div_u64(page_offset, ch_base_offset);
 			if (!page_no || page_no > INT_MAX)
-				return -EINVAL;
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "invalid page number %llu\n",
+						     (unsigned long long)page_no);
 
 			tdma->ch_page_no = page_no - 1;
 			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
@@ -1079,7 +1104,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 			if (IS_ERR(tdma->base_addr))
 				return PTR_ERR(tdma->base_addr);
 		} else {
-			return -ENODEV;
+			return dev_err_probe(&pdev->dev, -ENODEV,
+					     "failed to get memory resource\n");
 		}
 
 		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
@@ -1087,8 +1113,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 	tdma->ahub_clk = devm_clk_get(&pdev->dev, "d_audio");
 	if (IS_ERR(tdma->ahub_clk)) {
-		dev_err(&pdev->dev, "Error: Missing ahub controller clock\n");
-		return PTR_ERR(tdma->ahub_clk);
+		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->ahub_clk),
+				     "failed to get ahub clock\n");
 	}
 
 	tdma->dma_chan_mask = devm_kzalloc(&pdev->dev,
@@ -1104,11 +1130,18 @@ static int tegra_adma_probe(struct platform_device *pdev)
 					 (u32 *)tdma->dma_chan_mask,
 					 BITS_TO_U32(tdma->nr_channels));
 	if (ret < 0 && (ret != -EINVAL)) {
-		dev_err(&pdev->dev, "dma-channel-mask is not complete.\n");
-		return ret;
+		return dev_err_probe(&pdev->dev, ret,
+				     "dma-channel-mask is not complete.\n");
 	}
 
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
+
+	ret = devm_add_action_or_reset(&pdev->dev, tegra_adma_irq_dispose,
+				       tdma);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to add IRQ cleanup action\n");
+
 	for (i = 0; i < tdma->nr_channels; i++) {
 		struct tegra_adma_chan *tdc = &tdma->channels[i];
 
@@ -1127,26 +1160,33 @@ static int tegra_adma_probe(struct platform_device *pdev)
 					cdata->global_ch_config_base + (4 * i);
 		}
 
-		tdc->irq = of_irq_get(pdev->dev.of_node, i);
-		if (tdc->irq <= 0) {
-			ret = tdc->irq ?: -ENXIO;
-			goto irq_dispose;
-		}
+		ret = of_irq_get(pdev->dev.of_node, i);
+		if (ret <= 0)
+			return dev_err_probe(&pdev->dev, ret ?: -ENXIO,
+					     "failed to get IRQ for channel %d\n", i);
+		tdc->irq = ret;
 
 		vchan_init(&tdc->vc, &tdma->dma_dev);
 		tdc->vc.desc_free = tegra_adma_desc_free;
 		tdc->tdma = tdma;
 	}
 
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to enable runtime PM\n");
+
+	ACQUIRE(pm_runtime_active_try_enabled, pm)(&pdev->dev);
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
 	if (ret < 0)
-		goto rpm_disable;
+		return dev_err_probe(&pdev->dev, ret,
+				     "runtime PM resume failed\n");
 
 	ret = tegra_adma_init(tdma);
 	if (ret)
-		goto rpm_put;
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to initialize ADMA\n");
 
 	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
@@ -1170,53 +1210,26 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_pause = tegra_adma_pause;
 	tdma->dma_dev.device_resume = tegra_adma_resume;
 
-	ret = dma_async_device_register(&tdma->dma_dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "ADMA registration failed: %d\n", ret);
-		goto rpm_put;
-	}
+	ret = dmaenginem_async_device_register(&tdma->dma_dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "ADMA registration failed\n");
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
 					 tegra_dma_of_xlate, tdma);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "ADMA OF registration failed %d\n", ret);
-		goto dma_remove;
-	}
-
-	pm_runtime_put(&pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "ADMA OF registration failed\n");
 
 	dev_info(&pdev->dev, "Tegra210 ADMA driver registered %d channels\n",
 		 tdma->nr_channels);
 
 	return 0;
-
-dma_remove:
-	dma_async_device_unregister(&tdma->dma_dev);
-rpm_put:
-	pm_runtime_put_sync(&pdev->dev);
-rpm_disable:
-	pm_runtime_disable(&pdev->dev);
-irq_dispose:
-	while (--i >= 0)
-		irq_dispose_mapping(tdma->channels[i].irq);
-
-	return ret;
 }
 
 static void tegra_adma_remove(struct platform_device *pdev)
 {
-	struct tegra_adma *tdma = platform_get_drvdata(pdev);
-	int i;
-
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&tdma->dma_dev);
-
-	for (i = 0; i < tdma->nr_channels; ++i) {
-		if (tdma->channels[i].irq)
-			irq_dispose_mapping(tdma->channels[i].irq);
-	}
-
-	pm_runtime_disable(&pdev->dev);
 }
 
 static const struct dev_pm_ops tegra_adma_dev_pm_ops = {
-- 
2.17.1

