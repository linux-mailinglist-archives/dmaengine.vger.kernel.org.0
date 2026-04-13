Return-Path: <dmaengine+bounces-10005-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ1cME+R3Gl9TAkAu9opvQ
	(envelope-from <dmaengine+bounces-10005-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Apr 2026 08:46:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D303E7E39
	for <lists+dmaengine@lfdr.de>; Mon, 13 Apr 2026 08:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0730300F9D8
	for <lists+dmaengine@lfdr.de>; Mon, 13 Apr 2026 06:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E7D35DA49;
	Mon, 13 Apr 2026 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mulYGMF7"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D521E7660;
	Mon, 13 Apr 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062794; cv=fail; b=pk5QDVWR2ZsVdcRtM7NhERahMcSXg7iLLyHnu2BfJT7mBP+s/lwZNuKkzin22JGDhOqFi0+2EN/bgE2b3hsvGetR3RCaOJyqgi5ZdoK8WtzrbgG6V5jJhfvl2DwaKMcQNmi+66rUEhz/Hdmt5ymam6ZfldxOWkNNGsY0BTeutVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062794; c=relaxed/simple;
	bh=aafc4wOQWcrHRi6wGFx4R7NkB7J3PKtbJAEB66bGp/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M021JzrqAXWmiZW9VkynAEmdGBoapvrqIjDpfaDcC0rajz6900U++fsuuFqQcjcAyoz/X2g7pIY5CdEC38GlYJ2YD2ZPsP+OrLfTIhzmmloyuuKE+DXCDaEE0WEiIgUyjbFwS2OcfqejjjNZsIFA+l1Ug0+PvpRhler0Yny9uEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mulYGMF7; arc=fail smtp.client-ip=40.93.196.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN0VfubiETQCwDjr9z32+zFP0edoA/c/c3omlifUYI0HIBKzMH+v15aMWCWPdthanPRz6YxbuOePw3Jc0DieAbEqA391i4qcqynf66+jSEKf3fu+cPddnxnADippMkN6Ab47GZvctWiIBc1E/gnH6jCS0hj/6uzICVgw+crlYTYwufRykf+TE4bPFP41W32gGDxgUQQXFDX7FxwnW49TBTnH1qnEwnstrgT071CZAqYft63teRGWzhxkbANegND+hTOWXNOIVMSJbfukT+cySmHMtwlc2gggrUBAyitKR4sKv7kMLyhIIldEY8aaGGK9820lS31XPcI63S0jsXs5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKH7cF7w4y5hQkLl0VKEgtyEYK2tS64iVlRM/1dDFZY=;
 b=u/JSUl1Q4AioLI7nLyG8IBH4A/n/8+KWbrlRASfcXFyF1Rq5EAnPogrW3OKMJ/Qu/71+U21rS6WROhdV6svx7YtP4A+UAQD8uGGe/8CAl7raGxstZLTAG2ljm+Og4/u+ykpl0g4y7r4q+ecqYUvDpTUEN72p+kSyvTRkXhtSM17pKrixLpduzrzeCCxmnsjkBBNvfv4HJyF1aAANz2ds2vrD8OWHfACu3K/45pIky/84gkMaKT2L0H5H41/u3nIs7pP2gAxDfWVwbzJOt9fRhAWVyi0myjiwZWXraUsAdwnslT7+dlpKjD819/wGY6E4IygyHrgOpYs/QY6oHIWkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKH7cF7w4y5hQkLl0VKEgtyEYK2tS64iVlRM/1dDFZY=;
 b=mulYGMF7ZsO3LRB51s4olubFwdfZH+5oXeEpgErOAXdkyBpOiWPoJ/6PYl5/D3UiThhFQbMg8DIsFSNfcOM15nx5xp2tb2ufC0jX4cJP/qiGSbodb+jKv2HNrHGh2E9b3+Fs2gbWHoVV6Mg+Kid5Gx5X+o1SRqxg6TG1OzkmgrQOcytRGhr6a/RS5ePHC7M0MT7FZvcT3vB4y0o7EwSb2l1VYeVNyuAzYTTubMax7g9+fR0Ivq6I7SuhyLa4YcTkvHHwuHza0EKrY96rUrY7xohPAV0GT8FdHf9Kl88WOFNh5Ni16Tt+7MGU0GCoF1Zzp1/dUnM4UoKr+qdBAk65Mg==
Received: from BL1P223CA0041.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::12)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.15; Mon, 13 Apr
 2026 06:46:26 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::76) by BL1P223CA0041.outlook.office365.com
 (2603:10b6:208:5b6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 06:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 06:46:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 12 Apr
 2026 23:46:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 12 Apr 2026 23:46:11 -0700
Received: from build-sheetal-bionic-20251202.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 12 Apr 2026 23:46:11 -0700
From: Sheetal <sheetal@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, "Thierry
 Reding" <thierry.reding@kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>, Frank Li <Frank.Li@kernel.org>,
	Mohan Kumar <mkumard@nvidia.com>, <dmaengine@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sheetal
	<sheetal@nvidia.com>
Subject: [PATCH v4] dmaengine: tegra210-adma: Add error logging on failure paths
Date: Mon, 13 Apr 2026 06:45:45 +0000
Message-ID: <20260413064545.2157410-1-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: e44487db-cad5-4f02-7b77-08de99286299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mwJDXzV1lbxadpVSMRfv+3WBLVB3uS9ZZfF66lBwK9hpmHiDOHZhg7kJ0+5MbPl33yLzvirC9CNSrLWLCp2Q0KjLC6hS4mk2/LTVxPufOR/Lg37q2bo4OjG5rjdtzQU30BsIvXT+nr8FKz2zbnfeVhEwkDDLA2pdKPJ+viiwsNeuollUWlcreR7K4sTHzq4lHtd2cdRe47OQlOJx+Hm3wJnByapPM/6JCGYM9cmaLBHcm+zlIFIFOC5h59cC6E5ZDSPswGWgRplyJkZu/Q8OYd/vDylv4YdOuYtHUaDKo3OXhDwirINZH9fbLPaqdfKRApZf1UDt0mn5aJVvdxxlkAYuJK17n0y+5MyQM0JSUPBYcUBIdw+K/RsKCrJXQ0RtgLxuGe9B1GPZ+2yW7jf6rY65g+77UW4xhi2AxWUkQ+ZsumR+wP3UGYGLblQrgIQcrCGaSnfHqys64RAY2nIo/0sV/E6Rr6lkUNOLBzteeBLjmhX53qSwulyNOEHTpEwc0d0kJNHBT1aCBNOSMvYaniPPMH2d41P59/5QSEFjhbFZdKB/ugM9MpDKtsU8v5bRC9aXNkxrPP9ByfW79f6bxPBnex6kXJPfOiFeJPwhyLxIdR0WPMgSVRXPI4NDoz4bYk4YR1d2/MGJwZbN3EzC7AoIfu1VkNBNbKHjtIcvQc3o4KQcWcwwFxwpkzQsRTOLblXKCg3/v2cVpqBSQnk2JiWxa/JHr7B3xA47IFx5WRv3kNc4BWJ0HAKCdmFj+O4tMCbkn3BorQ/bjLmlkdQX5Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	skStYV5yl7Q7sBME3L8Ao5x8tmfEIS18CAlXdDE+VhYjhP8HpYYBdtl+yCWB8VSL+2GYmOZo9Y5HF/ZlCItagFCH55QxJfSOeUbB9/29fqlyIJfvHfumoP8LpPk0SXF8vtTxXfPVgqPPGQwe1Yb7Wu3JA35sS4Sge6CATJG1jdgA0+EfXfqrbYEVF3TGnb/rQ/K20OxI4oLOOORwcNkeuTbf7Yiix2fgX9rKmB8yK62AjtlCm9azbzda9xylbxZp5EXp5Zn6FVelPNxTyXQ7mTL5WTPHKV/WdYrlGqDrXHKJzU22jsuP1e3K5K7qHGa6iztnJaPXUtshs0yut6qwYa+4lO+2xVQCXByPzRUZfsuSVuhoLUMvMZayS60LMnqTiUwgxGGq96GDeH8xi090imz/uHAijZxAoBIu4fjh4Yk3g0hVmTFvg3Fb8cXvbvui
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 06:46:26.3435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44487db-cad5-4f02-7b77-08de99286299
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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
	TAGGED_FROM(0.00)[bounces-10005-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
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
X-Rspamd-Queue-Id: 67D303E7E39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add dev_err/dev_err_probe logging across failure paths to improve
debuggability of DMA errors during runtime and probe.

Use return dev_err_probe() pattern consistently in the probe function,
and dev_err in non-probe functions. Also convert existing dev_err calls
in probe to dev_err_probe for consistency.

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
Changes in v4:
- Use return dev_err_probe() pattern in probe function instead of
  dev_err() + return
- Use dev_err_probe consistently for all error paths in probe
- Convert existing dev_err in probe to dev_err_probe

Changes in v3:
- Cast page_no to (unsigned long long) for %llu to fix -Wformat
  warning on 32-bit builds where resource_size_t is unsigned int
- Remove redundant dev_err for devm_ioremap_resource failures since
  the API already logs errors internally.

Changes in v2:
- Fix format specifier for size_t: use %zu instead of %u for
  desc->num_periods to resolve -Wformat warning with W=1

 drivers/dma/tegra210-adma.c | 52 +++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 14e0c408ed1e..1ced5b37d0d8 100644
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
@@ -1130,6 +1145,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		tdc->irq = of_irq_get(pdev->dev.of_node, i);
 		if (tdc->irq <= 0) {
 			ret = tdc->irq ?: -ENXIO;
+			dev_err_probe(&pdev->dev, ret, "failed to get IRQ for channel %d\n", i);
 			goto irq_dispose;
 		}
 
@@ -1141,12 +1157,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
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
+		dev_err_probe(&pdev->dev, ret, "failed to initialize ADMA\n");
 		goto rpm_put;
+	}
 
 	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
@@ -1172,14 +1192,14 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 	ret = dma_async_device_register(&tdma->dma_dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "ADMA registration failed: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "ADMA registration failed\n");
 		goto rpm_put;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
 					 tegra_dma_of_xlate, tdma);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "ADMA OF registration failed %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "ADMA OF registration failed\n");
 		goto dma_remove;
 	}
 
-- 
2.17.1


