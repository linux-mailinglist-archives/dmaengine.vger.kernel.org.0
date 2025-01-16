Return-Path: <dmaengine+bounces-4135-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDB6A13E3D
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 16:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD116C362
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AFE22CBC1;
	Thu, 16 Jan 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nFnyi6aU"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43D22CA19;
	Thu, 16 Jan 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042802; cv=fail; b=VVOWIEUWOh9SJHphMkoQxdnxHwuFWhPh+uN0TZn8Ku/rPKG1bfrZ/Y/+zeta/EznUKL02YoD+AoLRlZQp9hGlDi5ij3ylfw89x5T/KXkOWzgrqTSdDD51m+nUcN1wP7hNUdsmk6VwaShsXDXl41vePIBhcUa3plDPCl9mljuEBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042802; c=relaxed/simple;
	bh=7QyTJ7y8T1jyAfpVk0Ud0K2zPZq+LAtJ3IdzDboqyBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBNU8MQ6+SyVRJVYmMySZoANHzWUy+p49L77i1RXovCXFactDdRXzwCB400lIZG+g39mcY5+cx6DDnx8i0nxOQtzrl8VwGqQJDQ5xJk0789/m3Sd054VocOsRjaSarO92GeXM6zpEvgPMYcQvpge7aWW06yhWiOKEOnNpJQVUxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nFnyi6aU; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjxJGPLplx5Q5KBmdgQZGArwyjqYgNbSUXWLKQDLfWEp1jzaxfDokH6FKf8TQ2im7kXcPIzCZJy7N7nALGDTGO3OIOOAn8jriDk9eumu+GacD6XRsBFwDbdFdfghxg3IEnvL8YrTAeZlPZyo+4J1ZUsJbCxWEmmq+cSKY3J7HnPEM0TNQAl6hnbF5nFbpblvt8UBDaT7IIjx+3GlP/EbMI1gQvTuRoNM7nkMxcPh/K2xfTc+fPhwHXA7iVjLoR8uU83Cn7Onm/HCdbh4TwUxTGF2dlzssy/lbOKJXBPJQMSHfvP0briAgdQENpcErBnq3Cg7KD2YbdpccDP4eSwhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4WczvLfzRBfFY2JJ7fpEpdmW48zpdWuGwNm8EJBdpg=;
 b=fUAGUaoXvWwvBA/nvgMZgvnzdcdc8GNuhsYhEEHFU+Qcw5ZSaR2VHZKkgY3S/XfEPrFT8yKzDET7bTkPyrvH4UETO4dr9VcvNq1r2osFIjxg2705H5CKZ+Rjb4WtU3oAYnwwCV/jqCF6NUCAU+BuC7srPo5IlTATjL/s1EB/kqxLmTCI8zmZRHAD25zy6DPMM+89jp7/pNfFRLfOS/+CRkLxp/SpHnePZcWRBgrfxbkHgLox5khv/JDrPIyXpjF/vFi8gctQDymUA7QF0D3It5Q4D+D3pi0h5Ti2WFA+twiC4QpUkpl9nVR6BzE9SYnhsrnlJ6KPPbWH71iaJ4JzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4WczvLfzRBfFY2JJ7fpEpdmW48zpdWuGwNm8EJBdpg=;
 b=nFnyi6aU1iqvCyJPILdsQUhbusT9shenI9tMr4ZzgTWuW+qOm+ykU4zwoD5nJ7hHuXcIuu8DD9BSYdYXRa1bR2FLIbCDLHsYkIZhWyuNAhLeSYdksb5hiWnToxzFWmxhowaRuvJgMNm4RD8pNjC+GVjoqraJ/uYAac8pWuGFmAYHohiSEUlPKOIPiBCNWQennnYp5jllmRqwOQhXzI336CqhR3E0ZrJ6jD97fi0fXbKwzwQGbIcq1RBTJFFecJffpvFzeJy421PwC+1PLtLV3LWOHV1vexBIQ4huLrjoLLwBRFoKk/7IeLb/PunhK4dDzpWXyhvSoUtcbi+bBH7gNw==
Received: from BN0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:408:e6::7)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 15:53:16 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::f8) by BN0PR03CA0002.outlook.office365.com
 (2603:10b6:408:e6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 16 Jan 2025 15:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 15:53:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 07:53:01 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 07:53:00 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 07:52:58 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH v2 2/2] dmaengine: tegra210-adma: check for adma max page
Date: Thu, 16 Jan 2025 21:22:20 +0530
Message-ID: <20250116155220.3896947-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116155220.3896947-1-mkumard@nvidia.com>
References: <20250116155220.3896947-1-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c9aace-a1ae-45ab-a11b-08dd3645e433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K2a13Uk5zZHbBXRvklmNpQCs7NEL6C1pBeppszcuujiTevtc/Lj+Iabyc7/w?=
 =?us-ascii?Q?mOJSiJ/qiHYqgm49Pqphpamry5qeCEm4j35GrERGWhDe2MgVnP1UyLkY36WE?=
 =?us-ascii?Q?ybAgVdl3X/AwQlMKo/bNMxEu/d38er2Q4LGX6ONDjCZekiiu+R0Ujz+ypItD?=
 =?us-ascii?Q?Jp4KqBJRI38F6v2rQlNyWl0NrboF17vLFhehHqIucsvYjFkYzzGoiXeGku4A?=
 =?us-ascii?Q?v7mjNVrnQ7fFzdNMYbSx0pXVpH99n0mruUlKGPYGdpM9jzsTTK4lYoEENKOG?=
 =?us-ascii?Q?I4zhjTGTD9A3tMEmhkoxQQh7LnQhaRhOobqLFSNO/AU7VTAsBtaj/0EyU9Ac?=
 =?us-ascii?Q?+3P5Lb88We+f8GbZb3Q/UgWjXUiZMZfH0h0oAD7QIxWZRa5ZosjqwM0j0Zvh?=
 =?us-ascii?Q?qdzzky9vNCG3T3EzxzjMBn9T7jrGXuW62tY6y5CoaGY4tvyzE6z21Tly0k8v?=
 =?us-ascii?Q?uGoVq+Yy69J5zTbUiVrfhMZm8Bm3R8cfgk2uWVUoEZfMLql7FC971bJ2++ux?=
 =?us-ascii?Q?ibll6MZlf6fyQBac/wElAHMIFLRA8NUT/7Rz8H0TXLcV+TE8lTQ9a4IwSJl/?=
 =?us-ascii?Q?KdxW1dB/rKXBcpYjV3l8+g7L7C5N3clhqMAjoT+zoQOs/Z16p5voK0ZZ2Vtj?=
 =?us-ascii?Q?oaDPvie5+j0kDd2alm8Bjd4hRkv6GqYZn/bOL38AABDXfWB48Pr+5LoXaz80?=
 =?us-ascii?Q?ZN6ovPP0yHO7OPTkxvPIXV78SoUjIb6FWKSMMoABacj3P4Ers8jLXZsb/r+R?=
 =?us-ascii?Q?aAYvmJ0fMPrJiGGu2xVLarx8sLL6Y3mHSH1y9KPU/hnNSHSDPDtSLHU6em5K?=
 =?us-ascii?Q?CvCqWDh6VDY2PE+/uTWzixCoYOcI8WOTSzN+9ZLQ6ScmceY3i6n/MDqVwMuA?=
 =?us-ascii?Q?ms+FpBsLNsmLkHk5hgsZB5xHtLTqnz0DbE0iAyNT9CR3nA5SYgjpkAhFedeT?=
 =?us-ascii?Q?xXLBptoI9dRTN+GeV8Pz+WxTGd6V4YA0wXHaj4yTIwk3/atWkAgIMoaoryCZ?=
 =?us-ascii?Q?StQwszwt1lzeN6vq7hbe6DMJWAReHdil5lAwPMUOidFHaSDHjUVEkH1twg8+?=
 =?us-ascii?Q?1d/5Nc26lcJiWCUmhh28OAcj0C3KPzcS3EhWBwL38a70rVgKOjAY95wedzke?=
 =?us-ascii?Q?DiTc5OOqNQceuChFSFKebbeqQ2wAW+1qflwLPYb3ws73rzGa0iDUeP39lFOE?=
 =?us-ascii?Q?ssWTijk99ydT45NpjhANrb8z6mCakc1oDOYcWvlbPzEY+M7+F93ZExFoYEc5?=
 =?us-ascii?Q?bkUZ/MRvddLz8dQ0Z5GNcYtFj3jANuWmTbOp9GxvW6/Gjz35cyrpLxChFibC?=
 =?us-ascii?Q?rf2aC4PXCOnm2jzkx8G185/fB15O/LbLPI7QgFZm0qrl7Yg1b+MmtBGbFNUN?=
 =?us-ascii?Q?+HlsIUwUw8vyInfPA78mjeIolKL8f8v0JfGSTXXmeT3TKBa4NkOKzd4KI4+m?=
 =?us-ascii?Q?qdF5bw7oqXjlcKVwTX7YmX0MVzJXdxI4sgBNhDMXbnIOt12wFNrt4MjZPuKX?=
 =?us-ascii?Q?Muw3sd6qjTkoAXM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:53:16.3835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c9aace-a1ae-45ab-a11b-08dd3645e433
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472

Have additional check for max channel page during the probe
to cover if any offset overshoot happens due to wrong DT
configuration.

Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
Cc: stable@vger.kernel.org
Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
---
 drivers/dma/tegra210-adma.c                  | 7 ++++++-
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 258220c9cb50..393e8a8a5bc1 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -83,7 +83,9 @@ struct tegra_adma;
  * @nr_channels: Number of DMA channels available.
  * @ch_fifo_size_mask: Mask for FIFO size field.
  * @sreq_index_offset: Slave channel index offset.
+ * @max_page: Maximum ADMA Channel Page.
  * @has_outstanding_reqs: If DMA channel can have outstanding requests.
+ * @set_global_pg_config: Global page programming.
  */
 struct tegra_adma_chip_data {
 	unsigned int (*adma_get_burst_config)(unsigned int burst_size);
@@ -99,6 +101,7 @@ struct tegra_adma_chip_data {
 	unsigned int nr_channels;
 	unsigned int ch_fifo_size_mask;
 	unsigned int sreq_index_offset;
+	unsigned int max_page;
 	bool has_outstanding_reqs;
 	void (*set_global_pg_config)(struct tegra_adma *tdma);
 };
@@ -854,6 +857,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.nr_channels		= 22,
 	.ch_fifo_size_mask	= 0xf,
 	.sreq_index_offset	= 2,
+	.max_page		= 0,
 	.has_outstanding_reqs	= false,
 	.set_global_pg_config	= NULL,
 };
@@ -871,6 +875,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
 	.nr_channels		= 32,
 	.ch_fifo_size_mask	= 0x1f,
 	.sreq_index_offset	= 4,
+	.max_page		= 4,
 	.has_outstanding_reqs	= true,
 	.set_global_pg_config	= tegra186_adma_global_page_config,
 };
@@ -922,7 +927,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 			page_offset = lower_32_bits(res_page->start) -
 						lower_32_bits(res_base->start);
 			page_no = page_offset / cdata->ch_base_offset;
-			if (page_no == 0)
+			if (page_no == 0 || page_no > cdata->max_page)
 				return -EINVAL;
 
 			tdma->ch_page_no = page_no - 1;
diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 45004f598e4d..2af939bab62b 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -466,7 +466,7 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
 	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
 	       cfg->pll_div_regs[2] >> 4), phy->regs + PHY_REG(21));
 
-	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
+	//fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
 
 	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(33));
 
-- 
2.25.1


