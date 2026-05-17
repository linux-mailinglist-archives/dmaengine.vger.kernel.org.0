Return-Path: <dmaengine+bounces-10488-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO7gLljtCWp6vQQAu9opvQ
	(envelope-from <dmaengine+bounces-10488-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 18:31:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E82A562443
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 18:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64F3630099B5
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A03264D8;
	Sun, 17 May 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dJhRIVko"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1F2E175F;
	Sun, 17 May 2026 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779035477; cv=fail; b=jpeyTk0YoSrqkIxzGA0Hs0aB+UXlyxpYtbVWtB1M6KSCl39Zlp6O8dy4Ak2oyzhXSVPnA02QXWcyKMSzm/1C/5jwKHPccjrBCn73gILUFMSimKswN+yzyNw7ZydT9s6Ra2Z4Lyc2V9DK8NwOA0Ag3O6UrTQK5AcihEIYJPls1oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779035477; c=relaxed/simple;
	bh=9zik3uUK0I6P7LkWofwWl921j31cswiUxPsKpa2noEY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWbxmBIb7STUUsH6LC6bxtEw6DO3BcIS7yEmj4FH0z+RSIXkwDLodDfQGgoYCl1puXBNuhxn/wZGev1ru1xUb1uUDY5xJk0ZwN6MG+CxtkkayF1EsOCTKmRsYQmL1oXPZWCr3vpD5j44UjMTXZNBGKCxKajsYdNy2PJZvlgTUNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dJhRIVko; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXA8VTXIELx14gPaDoQ1F2GRU8H+8fo6vGcKbQZqNDsX1ChxaXdZdwHO4r4JU+ainAoH9aTctr3Ukw7GXvSZD5MpS9C7B2B6mdM7WB2ME4KSUHc02eIVG4W6CpPLWTBaU8jvzgzGWeLrGU4gnX9oTEVFvqtPjiCm8zFhQSYHYTwoLgs4L7212bbqT1oRtc6wMX9wefbc4je5r+oO2JKdoJsfD4z3vwpneu42Ook3GbKzHqYhfBdYCd31Fvn65ImvDDji6aMRUEMy2FeS1T6o0veWxQcFvXAwsRQw2rtNxczDQxbdap79/ecyDJBAPvZ1zwy+gB3jRYs1LXMDVMpxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR4InExSttsgzuhSWH4gFbAhbqBU8TwyRKOfqTurJ9w=;
 b=hGsshtBIV0yRGG5U5Ucf64AdFppFCT2K5u5+HpAK9YVO1r4xK2aksBbekVcyR0Ocw3A1YEjmAEhL+ZEZXhXHjsNwvppvio/yqurEGo+s4F2/gRJPxHf53UARtLDl5p5Rs7hf0cnZ3LF9fbRMsHMrA3w04LFeFCeE7FWeix9ftNVCh6+VWBaqo6qGHqbEagIFjTOzli8vQl9m1Tay0kvVSCviddRdQp80aqr23K1o2Bga+NX0WC+144FHo6ZhGsiOrteWSk9LLXn8y+3nC2WjMLqfoXmERVsc/5SuV5b7rpu8FgaQwPxkjiiuQ3k+smbJYh8J3Pwb+J6/7AIxC9qUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR4InExSttsgzuhSWH4gFbAhbqBU8TwyRKOfqTurJ9w=;
 b=dJhRIVkozt4+dGvsPb7usjfNwOTC9TnJIpOAPWw6HqBNFmxLCDuwfkbjPXfK1uKaiTK0dFYQ6qrwgpJv0+gEC0d+qgKwM6SOXcqX7XaFPRTki865FIdylguzGVZaxd9+K2iQbpdOA4AeBrcJggsHJw9pnXhWBJevF1enYEUpERQ54Hh0CGQ/rzeWpbwIonO3lGG+npd8kbR3oIzQup7qmkDvfhj9pbiKYh+giY0LJJ32tmNWxWcAQvxw3WQojroi2G8tazPlNsRDubP7F4qNrLtJ6p8Iow/jvwCSyUyfgjKGk+XHK9XF9fZq9SLUnYvwu4ivROr9+RwlSziRRZuFIw==
Received: from PH7PR17CA0065.namprd17.prod.outlook.com (2603:10b6:510:325::9)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Sun, 17 May
 2026 16:31:10 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:325:cafe::62) by PH7PR17CA0065.outlook.office365.com
 (2603:10b6:510:325::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.22 via Frontend Transport; Sun, 17
 May 2026 16:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Sun, 17 May 2026 16:31:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 09:30:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 09:30:46 -0700
Received: from build-sheetal-bionic-20251202.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Sun, 17 May 2026 09:30:45 -0700
From: Sheetal <sheetal@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
	Frank Li <Frank.Li@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Mohan Kumar <mkumard@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sheetal
	<sheetal@nvidia.com>
Subject: [PATCH v7] dmaengine: tegra210-adma: Add error logging on failure paths
Date: Sun, 17 May 2026 16:30:45 +0000
Message-ID: <20260517163045.363444-1-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a74ec2-bf58-4430-4fb2-08deb431b3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	7UkW3xtS0IIcBCz7Y93un3HrTFdjOuhtL7gcNe0aRgnHM6RYbn9ueqIQ7YPOzYs8H5qu/HE7OZmgQpqpob9B9yopDn7SBuMr2F7ZlZmX931jDXf7eIE6pkQBcyF6gzNTbAhMJw6CPv9BYmQ9GjDTFkkTS1/PB235+jOgYHDWIWsfXZZuEmFJdSUTZQkl9BM2ZBg2xCKrH0Xtm0XJjbf6MZA4EC6BBhawOffUSarpb2PytbyJ8zajP0MNvBK4tJxSjJoM0e0E4OGN97yHlRyNELWVFEOG8VbSwCdR6MqbUNIooCimYbC4nxNXci8LuR/9Afs2SFLMTJfKI0WDNoPoVhXMHHLHuOhfIoVXFkBY5cN+mPca4JgVLyGpufSZPCbq0gID3yJY1Y6Hd2OZIkrPzV+OvMjIcFW1bhYL+6FU59qeuB5n7IYdvtuLena63eMTf29bOf2i6uJUGIhD96E9YuFHgFKyiMqcpd96MEkOw+CK/WKtPaP7p6EIzwloxcgNm5tbtX0ynDxL0QGUWu7JseSQ7b2Wv9ekaDXt3hqjgivT4oMw48HalqbOCPdW1MzTMkmO24jj7+e4WB3XurlKTCoxKkJ9Ipxaq8Rkin2IjWcmJuu0x0HylJfDjAEUu/X/eanuUS5rzkPHrFwa0A0ab9M9idiJOjJOCOaYNJNZLYI+1bcWFFNl3lmq1N6APrQnnokHg/eCm1+MBq99tsveUTGUJQKJlbw0yraiOmthbFE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/QbA7Et5bKrkykBcS6SOIqlajMC+j2leCyyra8Wf0wQYyXcpJGutKfukCTrSfudx7HbdgwZrJ5kBTFEkpSPBtJ735MAr4APPwB3G3uRjyuP1stLwJdUyVwplfrDRzWQSebyoa2TUUqAttb9ExMWT8W42bEtE3Fi67RG/XEt3ssg1RzJnJGjP3xMhbypUT7gFsm0LyCqTlFw7APOr4yW8hAkapGIUfZ/6o48LCrGLvwuqxw2BBxMmMmr7yvG7eHeZ2rIVU6DNGXBlOK19A/O9n0oyNTpIOsnmnZ6GjyB7YTQ5rx36YaTttcpCxQgnnSq22i9eoZEEsUTCVj80t4XoNhZHJoN02gcSRtdHrscwx1tOHJ+L4meWJV7UxPG8GIO7Ds2tYfX1Cn/TooF2xhpZI7yC5PTiOyZRANTTh9x5I5avimtMDPiCOS74ZhqiSHPr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 16:31:09.4452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a74ec2-bf58-4430-4fb2-08deb431b3c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
X-Rspamd-Queue-Id: 2E82A562443
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
	TAGGED_FROM(0.00)[bounces-10488-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Add dev_err/dev_err_probe logging across failure paths to improve
debuggability of DMA errors during runtime and probe.

Use return dev_err_probe() pattern where no cleanup is required in the
probe function. On error paths that need explicit unwind, store the
dev_err_probe() return value in ret before jumping to the cleanup label.
Also convert existing dev_err calls in probe to dev_err_probe for
consistency, and use dev_err in non-probe functions.

Keep explicit runtime PM and DMA registration unwind instead of managed or
scoped cleanup. The scoped runtime PM guard releases the usage count with
pm_runtime_put(), while this probe error path needs pm_runtime_put_sync()
before pm_runtime_disable(). The OF DMA registration failure path also
needs to unregister the DMA engine before dropping the runtime PM reference.

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
Changes in v7:
- Keep explicit runtime PM unwind instead of using a scoped runtime PM guard
  and devm_pm_runtime_enable(), because the guard releases with
  pm_runtime_put() while this path needs pm_runtime_put_sync() before
  pm_runtime_disable().
- Keep manual DMA registration unwind instead of using
  dmaenginem_async_device_register() so DMA unregister happens before the
  runtime PM reference is dropped on OF DMA registration failure.
- Restore the explicit IRQ cleanup path instead of using managed IRQ disposal.

---
 drivers/dma/tegra210-adma.c | 63 ++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 14e0c408ed1e..ceaee1e33e68 100644
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
@@ -1029,8 +1040,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 	cdata = of_device_get_match_data(&pdev->dev);
 	if (!cdata) {
-		dev_err(&pdev->dev, "device match data not found\n");
-		return -ENODEV;
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "device match data not found\n");
 	}
 
 	tdma = devm_kzalloc(&pdev->dev,
@@ -1056,7 +1067,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 			unsigned int ch_base_offset;
 
 			if (res_page->start < res_base->start)
-				return -EINVAL;
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "invalid page/global resource order\n");
 			page_offset = res_page->start - res_base->start;
 			ch_base_offset = cdata->ch_base_offset;
 			if (!ch_base_offset)
@@ -1064,7 +1076,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 			page_no = div_u64(page_offset, ch_base_offset);
 			if (!page_no || page_no > INT_MAX)
-				return -EINVAL;
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "invalid page number %llu\n",
+						     (unsigned long long)page_no);
 
 			tdma->ch_page_no = page_no - 1;
 			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
@@ -1079,7 +1093,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 			if (IS_ERR(tdma->base_addr))
 				return PTR_ERR(tdma->base_addr);
 		} else {
-			return -ENODEV;
+			return dev_err_probe(&pdev->dev, -ENODEV,
+					     "failed to get memory resource\n");
 		}
 
 		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
@@ -1087,8 +1102,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 	tdma->ahub_clk = devm_clk_get(&pdev->dev, "d_audio");
 	if (IS_ERR(tdma->ahub_clk)) {
-		dev_err(&pdev->dev, "Error: Missing ahub controller clock\n");
-		return PTR_ERR(tdma->ahub_clk);
+		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->ahub_clk),
+				     "failed to get ahub clock\n");
 	}
 
 	tdma->dma_chan_mask = devm_kzalloc(&pdev->dev,
@@ -1104,8 +1119,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 					 (u32 *)tdma->dma_chan_mask,
 					 BITS_TO_U32(tdma->nr_channels));
 	if (ret < 0 && (ret != -EINVAL)) {
-		dev_err(&pdev->dev, "dma-channel-mask is not complete.\n");
-		return ret;
+		return dev_err_probe(&pdev->dev, ret,
+				     "dma-channel-mask is not complete.\n");
 	}
 
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
@@ -1127,11 +1142,13 @@ static int tegra_adma_probe(struct platform_device *pdev)
 					cdata->global_ch_config_base + (4 * i);
 		}
 
-		tdc->irq = of_irq_get(pdev->dev.of_node, i);
-		if (tdc->irq <= 0) {
-			ret = tdc->irq ?: -ENXIO;
+		ret = of_irq_get(pdev->dev.of_node, i);
+		if (ret <= 0) {
+			ret = dev_err_probe(&pdev->dev, ret ?: -ENXIO,
+					    "failed to get IRQ for channel %d\n", i);
 			goto irq_dispose;
 		}
+		tdc->irq = ret;
 
 		vchan_init(&tdc->vc, &tdma->dma_dev);
 		tdc->vc.desc_free = tegra_adma_desc_free;
@@ -1141,12 +1158,18 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		ret = dev_err_probe(&pdev->dev, ret,
+				    "runtime PM resume failed\n");
 		goto rpm_disable;
+	}
 
 	ret = tegra_adma_init(tdma);
-	if (ret)
+	if (ret) {
+		ret = dev_err_probe(&pdev->dev, ret,
+				    "failed to initialize ADMA\n");
 		goto rpm_put;
+	}
 
 	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
@@ -1172,14 +1195,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 	ret = dma_async_device_register(&tdma->dma_dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "ADMA registration failed: %d\n", ret);
+		ret = dev_err_probe(&pdev->dev, ret,
+				    "ADMA registration failed\n");
 		goto rpm_put;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
 					 tegra_dma_of_xlate, tdma);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "ADMA OF registration failed %d\n", ret);
+		ret = dev_err_probe(&pdev->dev, ret,
+				    "ADMA OF registration failed\n");
 		goto dma_remove;
 	}
 
-- 
2.17.1

