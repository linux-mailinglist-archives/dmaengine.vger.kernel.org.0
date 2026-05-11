Return-Path: <dmaengine+bounces-10291-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ISVE/2jAWqrhAEAu9opvQ
	(envelope-from <dmaengine+bounces-10291-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 11:40:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E4650B170
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 11:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 082EF306EBCA
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E73BD63D;
	Mon, 11 May 2026 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LQ4yvMYR"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4243BC68D;
	Mon, 11 May 2026 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491551; cv=fail; b=TMP1E/pd5eQymr61UPNbxfyc4dPMDAQ4xyw34dM02rTbvXe3vsGbV0b2tZEaVg8pkv7vkQbA8qzlSaZwKmYf2ZYEXaq7hY0meZZ7AJKBp+waJabJDu5O04diarc6B5y+B05symfo4ov62NjDvljHiRSfgT1itcM2vGRhXH+SIoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491551; c=relaxed/simple;
	bh=sWDTQNCT/JRvubzT6BmfEUqGGn3fRjb1s1I6QOO9wNo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rx3qxNz6ks9Ypt6z8LQHA2eat+M0bDIlz3a9vJ0nqtfgLLAM5PIt4TZJa9qt9LYIryVtqs6e8+tDXRLH6vLoKsxeC0ImgVoBYTzm3g/Dim3RwXCplmKD9yvDDjH++vvhLHW4h4SBavhlvd7kBzCzeNrQ/huZ05q6Sr0j1+jXc00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LQ4yvMYR; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laF6isljG04ak/53Rp7FZ2V+sYw3A1ye+6+q8RtMvgJC+P0tyhrMy//F0vuiLwm0O1tbVeQgNXcCPoaLaA8LttM7zC2Ti9fIo8N+msE6NitePLTR2gajGpbtlTKBAReEoV+IFBhAd7icYb61fGNI0zj6X//taxCry9Y6TlCICsfkKIwYDx+8rBslXStC/6slwl3rqHfi5TtbVTyqyax0vp5VgndahrGpP3Fg6auswYdBnJL8afLIQ38Ff9XzVikmLq+dsn81HzjdmolLlD34lAcVzVaYIDdZGnp1ZdI55pztKs9FwVqGw0Dw2J8cqbm4FYKhgJcGE3Z6tVbVJpyyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOC/Unb5Rcif3lxUlvEYEV9A9eQdFG3W/MViCsn/MOw=;
 b=B9kia05A3AsDEU1MQKhqHP9SDs4PF0xNJJTeHSOcrytjNou5azDRe7WN2X3RTlNUfIcr5Im3U9Ja1xX8dJoaXwtlHVoTTnKD/Ib0Loo6WIZi3WGETfY5jH7Iooj/p1Uy+IXCvrL7pdhVlEwwZi3/K+aurXT4EysRchM05/NNEIMwg1NSMnNDUhROGvAavWpujZBgTP6D/Pbm0fVCX9y/DuV7QvVU6pNoL6sGDrGBsSpJWhDLbP8vBlRSxmrPefjXIJtlm8tYDY9cJapR4nact8Uo/g2uPa2MDdoMIhzcChShH4qzAG51tWK7OfLAhkmwAIqui5K4QiwTbhfpwEE9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOC/Unb5Rcif3lxUlvEYEV9A9eQdFG3W/MViCsn/MOw=;
 b=LQ4yvMYRNDIUQsPdztOTMZsBGeue4UbU6PLXoy9XJLb7XkAXhXFDnHlGe73hcR3cJP1pABosd/mBXbMiGQ4cRclVBvi9QJSgzgm1t5q/Vd6uEVtuUnacXmcK0WKxPfLHCUwLF+3uZwxtwraR2yyGSfA4JucyDQvjjJblv1h8YhbNnHx6B1UdIIeysqi0AksU8HmhyoNdAWYnN07GuFW90nOHmDhpN8AZAJKpJV1wiLfytKz0K0na79LpLcMR9d0igkUpMmlmh7jMOV7kdu6Vkp0NFajzHRTwYDW1PnAsb2vVfDriC2bZ8S0vnKbCUw6OBhxNJfJ65bXXt6Nj2oyRkg==
Received: from PH5P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::13)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 09:25:44 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::91) by PH5P220CA0010.outlook.office365.com
 (2603:10b6:510:34a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 09:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 09:25:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 02:25:27 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 02:25:27 -0700
Received: from build-sheetal-bionic-20251202.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 11 May 2026 02:25:26 -0700
From: Sheetal <sheetal@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
	Frank Li <Frank.Li@kernel.org>
CC: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
	<thierry.reding@kernel.org>, Sameer Pujar <spujar@nvidia.com>,
	<dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sheetal <sheetal@nvidia.com>
Subject: [PATCH v5] dmaengine: tegra210-adma: Add error logging on failure paths
Date: Mon, 11 May 2026 09:24:58 +0000
Message-ID: <20260511092458.1299793-1-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3f77ef-dcd4-4188-6413-08deaf3f46cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ko8Dq0IEri6XrudIhODvskH8AeiRmyHXZpb24cXnERUNV6cL2c04XznUqyVgqNi3U9/nx3z2ikvOmaNSvsAwkp5GDN5RkB7KVQnFi0dkuaRvJtwwVblttFklgXg6nZKNCIt0FB5t++EQlfOaAbfQfFa9TSTB8DgGQLFgr4oxPlGjZ4TorwksVQGTedIxlDqWDAWPPpWaisqCAspmX5ul1LnajYg3u2pRbCqSYXRdzBiy2mchCG9AAjjTW5zgcP/yKX4kVsBoQEgx2pyZtf6QBDc4Fyw8/PNbNsCCC4bXSEPRYjbDKk1lF+XAW9MN/3dWpGZewmgBg0MztcCYQOWeMFjcFsYGVMdBfwLE7LsIp9GmFdlJnjRnGGsYtmwPpEA8A1HDkDy0jb2ZahCvWucBc7m9Xjag1HpBzNqv05MMKtPaU6kV57g5lO1qcHffhb/1VgRVt+P9y4M6o0UIP0DXXvj5vAsIMX5ubXV1gg/0v7MvWxTZ/FyRdBH2w8g+XT/1JeahXReYii+MqpiBH+OSt508ss53+yB6tv6CjKLKk9kjtv+uRbTtWlEEEdi7pddX3mCC68EVEgvwxh+yEuWTrei+JQUGmNprPE9NdFn28i+6dsvqxdPllJCpzl3Q8y5t1NtdFeg62dUdG3TyezU64aVSudBir57T/sO2hPCon2Imq87qVz0WeSuWeQS5x06LbPRKZKl2GXEvOebLWcO6YdSRpuCAIM1Obv4Ru65t3p0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PhjiO/bsN0EqLlckIHf1tHJ7vpH7+tdq8ZaXBdT4EaCw+rmMZnk4Bw27YK7qj0KJCHkexTw+McfXsX/2YcfvRop00FN5jaX1sJQrsIS1/70v21oEqVxdF7RRnVFvzZ+upZngPzVh3JnOOczdZVz6DAGSE0qMKW4aywrZoYAA9kF6K609UwFtNcQJWtYkV5TJ5v2DnrLh+ooJX84ptVX9Im60VTN6ei2k18qBQh3LvjqHq2e8f/NtgoP9omCHW5JgNGv4451D0XDPdHkrOyeafoYCtMn2wcDtQjKR9hGHxTUakp87aHc0fjaty87wRPX1SxyOkVq9+3tO2+ZTFkkKad2lAxFwxRNRd3PjGirdlRzzY8VtMZy8utgJJwA0UHrNCYL8vTXdwk/kOM8sn310pYfATRarsD31tfzQfkb4SPkDmcotJJTt2Ms7EmwRFNIo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 09:25:43.7930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3f77ef-dcd4-4188-6413-08deaf3f46cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
X-Rspamd-Queue-Id: E7E4650B170
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10291-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sheetal@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Add dev_err/dev_err_probe logging across failure paths to improve
debuggability of DMA errors during runtime and probe.

Use return dev_err_probe() pattern consistently in the probe function,
and dev_err in non-probe functions. Also convert existing dev_err calls
in probe to dev_err_probe for consistency.

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
Changes in v5:
- Use ACQUIRE() for runtime PM active handling and devm_pm_runtime_enable()
- Use dmaenginem_async_device_register() and direct dev_err_probe() returns
- Use managed IRQ mapping cleanup to remove probe unwind labels

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

