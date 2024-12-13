Return-Path: <dmaengine+bounces-3967-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB89F09CD
	for <lists+dmaengine@lfdr.de>; Fri, 13 Dec 2024 11:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF0D284509
	for <lists+dmaengine@lfdr.de>; Fri, 13 Dec 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CBE1C3BF3;
	Fri, 13 Dec 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mFNvNkpP"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D761C3BE7;
	Fri, 13 Dec 2024 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086419; cv=fail; b=nI9sjbsqVwLZ4oG2gDTsxNToBeBFxX4pNTjltQohCRSJBEV6O2jW/APST0qprTNA7xDhTk/liCQn9p55sODnivMlls+DsaYoWMaFadvdPd4ZJHljPzoLiV10EI/JpjtwDp7MWNjvOh6yxpwxSPWvPolLP8Hd2kdH2a3aOFBi1NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086419; c=relaxed/simple;
	bh=t2O0J+ehR56uejV8Dv1PgD98ZExfvTkfzfaRBJIICbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5xA2dA3q8wRfHXLdf4CWQqSMVmeQMnCDUjW1sLU7a8WiMSvKXFcEgk+E0yyxS6Dpf4hXW09dpHP2l+5EQBlgHYJm3KSpGlX6g1MIm5D2SSKN+bYZP62KCvIviIHeFpMv4ZTm4RdH/1F6t6NpuYISrSU381tG5yh4vcARcLDxfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mFNvNkpP; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w68licwPk8ZoHEUwnOI0vXA5jScHQswb0i2Ii7CohP8H/1mcAecelpQ8f0I3SfsPJ98zOPlrmRUFcCpw50XHns0iJm0B/U/fTsr8cfoAqea7W7Ysb51vkFY9rfParvfwTX00jiF3Gp+jhUqrH1kwzOth60r+fkw5EtRq3276YwFs5EQjHXqXMlOcRIJ4j3UYkW4Qz3yx53ckm0TZhoebkDwx5XC0He+hJinGBdU8Xy8xthzRPzpky3K+VrOrXE2OApY5luWT4oAEm5h+8vo+Y5xVHuNiQboinZcneZrsqnOsI5ThLoNCb3NQowX/FrhJsZtCmsAFVSjvscNVXG+CHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIIu534TX3lhOryF2fscbWwyfydqGSYwW+sCHVbJG8M=;
 b=apsDCdF0eTebdhxM8pDJ9bOcvie4Nk8zl7YaKSw8z3uFXeRqi5/wMPH0Cf07FumJa9Ct7KA3FaQl/lbnXCs5ry9gBR1XMyFJePyCVImKcsS2VC87xjcLwW0cKVy2Kt/rOc0g7DlbVm9lL8wHnX45jGNTy84FZXNzbyi7f33a7YOinm1uxe+kKvfIdkdWhpunepFkohiBMXqARPLoYAhwWEMeh0aYCEhhWVjYxeBIOzZaI2B3HKa2KwC3gIdjeInmkAW4N4uZYeM4bQOYoeLMSsX77+WOy0jGlyNrr3iPTrRAq3z7NoScOeQpgVDvfgtwq31mzq8LtxL8dZH9UX88AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIIu534TX3lhOryF2fscbWwyfydqGSYwW+sCHVbJG8M=;
 b=mFNvNkpPSD8bXAfA2bXgHUkmvmgCHIbjWSroqa5QWf8HGEAf6VTZpoZcRn8j9781hLy9efioXFcVlZjvWZSgUO3xw6DnSBz5JgLnYI0MLTHfpvuFhYnb3d3B2tHau0eVYh+0wgiwlVVBZKYv7eLOwovmAyQ4G3OAC6Sq3o/indn1SIdGbo5L0HSutY9FplSAt54zfqLEXO8BvXFFVmN31BSCeu4xCDK5HG3/y5oeQubzuJ8bhPDdDX0QpY22NAyq6a/IfeH9xitTeXB1bVL4uPK0KyWPgKxNXH+XzGb8bGnmddXhqdWRryoZ8OwOEclJ4bnFSKHP5FKyfUQffjO0tA==
Received: from SJ0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:a03:2c2::28)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Fri, 13 Dec
 2024 10:40:11 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::20) by SJ0PR13CA0053.outlook.office365.com
 (2603:10b6:a03:2c2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.5 via Frontend Transport; Fri,
 13 Dec 2024 10:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 10:40:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Dec
 2024 02:39:59 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Dec
 2024 02:39:58 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 13 Dec 2024 02:39:55 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <spujar@nvidia.com>,
	Mohan Kumar D <mkumard@nvidia.com>
Subject: [PATCH v2 2/2] dmaengine: tegra210-adma: Support channel page
Date: Fri, 13 Dec 2024 16:09:39 +0530
Message-ID: <20241213103939.3851827-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213103939.3851827-1-mkumard@nvidia.com>
References: <20241213103939.3851827-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: e89c7fe4-3932-49ce-5e4a-08dd1b628588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gaMn3aOgLsW+8LaK/3CO3WiNxrjNmQx3zGBisHWOPtyWKzJHRbFkgJ0/XzPK?=
 =?us-ascii?Q?v3GekCwyv35xLudr3z+EALOkhGGFfGtw4Agc2PvVCq0hSUqm+k+oRznHScSR?=
 =?us-ascii?Q?qyH2beLCJ1b+NWtOFiG2vZ8JD4nIoz1iHGHM8LVgXj/Hhf4af2E4wvyD9EiE?=
 =?us-ascii?Q?gMDDgQhNotxfcRnPuEFmtdJcMJYbkGej3Qq91P8I9DsvKU21eAkid5Jo+/HY?=
 =?us-ascii?Q?Gj+ygceNNiViWpsoD+0kbq1PCIBQp8kuRJU3HRgVg+BSF2HPWurb6m7O6uOu?=
 =?us-ascii?Q?Wc5M3OfFMpHpGIpHSSJPlOmvWwnDrSu4aR7dukfVQlU3qeJh+C32isHs6Db3?=
 =?us-ascii?Q?Dmfa8c+XnN79ZVAnGSJv/Zs6HRmViGGcW4E7LByjRV1sTjjA4QvXpLpb7Eu8?=
 =?us-ascii?Q?CeyESlUDN1mf0r9rIVLYdsNdGZrgVe6ly2FOj2z6iMU8vStgNl2CusmZmju6?=
 =?us-ascii?Q?YXYcUeb6kaf/zSjoyTNv3K0LZBwtAHN1/ipKTIuCkjTCEO4N0igcCFGxaeC7?=
 =?us-ascii?Q?tHfhLvghR2MpYYNZjLiMqZm8VDhKbqbfTd48yxHk4ZhYgnZ9GTJjVH3SyKOO?=
 =?us-ascii?Q?aSsmJ1Z2llKuFe25A3GfMid77p+1cu+uAM46LvqlautkEh6zjh5umQ0utD3I?=
 =?us-ascii?Q?1O2PRFJwYBcvXUP8GCUkVpNj0JljMSKyAEhIZIYKANnizCc0qm7h3IK2RwkM?=
 =?us-ascii?Q?j82SQlVvUwCATa3B2QlIOOLKguVH48wOqpRuR9Rd7ZLWQq37WdcZVBHLluM9?=
 =?us-ascii?Q?9O/tj5ls6uxtDCDBghOWloC572mCGM5qcnQwiLhkpbxm2/xdtCKdYp/BgIu4?=
 =?us-ascii?Q?H1TFouhVt8cYZwnuun867fydq6n20m1cEsu8l4eLjAMm1MyaXh5XWcCFOYn6?=
 =?us-ascii?Q?ho3ABuctRocEsSmD02IqGvp6O0cqrN5feVMupO0czUE4X9DElJGO6X/L4DEe?=
 =?us-ascii?Q?oQNjcJC4TIvcRCAIatXrCt8X341TuApTTr7/FN8eVluTxZ/nN7r+giP59/q6?=
 =?us-ascii?Q?viAj5oI26NCE1yR2YsFIJMLs9EPCgt8c3BCDTL8eDa4DmAjXuS26x9cHKtFa?=
 =?us-ascii?Q?49LZSX888jcoJgfw3PG+ewVp0pkCqLR/i9aGu8rNZM7BR8GG9xwmatwwD5vN?=
 =?us-ascii?Q?YN3wDaB7UPGFgQFfCsnqxTdj10ixynRBZ1ueBd6yr4rVaJQdmnuTK/3HjzFX?=
 =?us-ascii?Q?N152X/nPTt80oJl9oJGPL1N3sgsyNEZh0TEF4b/p9TTbJMKfWOjnG84urFOJ?=
 =?us-ascii?Q?MLj/KhMGvbYl9VeFGGP2btjAt/raE5eSgg+pecKoodGuBF5ddjvLBi3kCTjd?=
 =?us-ascii?Q?WwRQe3nGvEMhmj8hGbSx758j2ZsQEYsQbdTyalTPpZoewTygtFVp3XnIxnPP?=
 =?us-ascii?Q?GlWEbiUbN3imqaAVrsY8cj1FRX/lAGOcPyQAFO0Ut4oLC6wKIokhv4AdI1v9?=
 =?us-ascii?Q?w0dqi9uY+EveqkwN3LPExPzxpcoVcz5F?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:40:11.6123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e89c7fe4-3932-49ce-5e4a-08dd1b628588
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783

Multiple ADMA Channel page hardware support has been
added from TEGRA186 and onwards.

- Add support in the tegra adma driver to handle selective
  channel page usage
- Make global register programming optional

Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 86 ++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 2953008d42ef..6896da8ac7ef 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -43,6 +43,10 @@
 #define ADMA_CH_CONFIG_MAX_BUFS				8
 #define TEGRA186_ADMA_CH_CONFIG_OUTSTANDING_REQS(reqs)	(reqs << 4)
 
+#define TEGRA186_ADMA_GLOBAL_PAGE_CHGRP			0x30
+#define TEGRA186_ADMA_GLOBAL_PAGE_RX_REQ		0x70
+#define TEGRA186_ADMA_GLOBAL_PAGE_TX_REQ		0x84
+
 #define ADMA_CH_FIFO_CTRL				0x2c
 #define ADMA_CH_TX_FIFO_SIZE_SHIFT			8
 #define ADMA_CH_RX_FIFO_SIZE_SHIFT			0
@@ -96,6 +100,7 @@ struct tegra_adma_chip_data {
 	unsigned int ch_fifo_size_mask;
 	unsigned int sreq_index_offset;
 	bool has_outstanding_reqs;
+	void (*set_global_pg_config)(struct tegra_adma *tdma);
 };
 
 /*
@@ -151,6 +156,7 @@ struct tegra_adma {
 	struct dma_device		dma_dev;
 	struct device			*dev;
 	void __iomem			*base_addr;
+	void __iomem			*ch_base_addr;
 	struct clk			*ahub_clk;
 	unsigned int			nr_channels;
 	unsigned long			*dma_chan_mask;
@@ -159,6 +165,7 @@ struct tegra_adma {
 
 	/* Used to store global command register state when suspending */
 	unsigned int			global_cmd;
+	unsigned int			ch_page_no;
 
 	const struct tegra_adma_chip_data *cdata;
 
@@ -176,6 +183,11 @@ static inline u32 tdma_read(struct tegra_adma *tdma, u32 reg)
 	return readl(tdma->base_addr + tdma->cdata->global_reg_offset + reg);
 }
 
+static inline void tdma_ch_global_write(struct tegra_adma *tdma, u32 reg, u32 val)
+{
+	writel(val, tdma->ch_base_addr + tdma->cdata->global_reg_offset + reg);
+}
+
 static inline void tdma_ch_write(struct tegra_adma_chan *tdc, u32 reg, u32 val)
 {
 	writel(val, tdc->chan_addr + reg);
@@ -217,13 +229,30 @@ static int tegra_adma_slave_config(struct dma_chan *dc,
 	return 0;
 }
 
+static void tegra186_adma_global_page_config(struct tegra_adma *tdma)
+{
+	/*
+	 * Clear the default page1 channel group configs and program
+	 * the global registers based on the actual page usage
+	 */
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_CHGRP, 0);
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_RX_REQ, 0);
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_TX_REQ, 0);
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_CHGRP + (tdma->ch_page_no * 0x4), 0xff);
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_RX_REQ + (tdma->ch_page_no * 0x4), 0x1ffffff);
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_TX_REQ + (tdma->ch_page_no * 0x4), 0xffffff);
+}
+
 static int tegra_adma_init(struct tegra_adma *tdma)
 {
 	u32 status;
 	int ret;
 
-	/* Clear any interrupts */
-	tdma_write(tdma, tdma->cdata->ch_base_offset + tdma->cdata->global_int_clear, 0x1);
+	/* Clear any channels group global interrupts */
+	tdma_ch_global_write(tdma, tdma->cdata->global_int_clear, 0x1);
+
+	if (!tdma->base_addr)
+		return 0;
 
 	/* Assert soft reset */
 	tdma_write(tdma, ADMA_GLOBAL_SOFT_RESET, 0x1);
@@ -237,6 +266,9 @@ static int tegra_adma_init(struct tegra_adma *tdma)
 	if (ret)
 		return ret;
 
+	if (tdma->cdata->set_global_pg_config)
+		tdma->cdata->set_global_pg_config(tdma);
+
 	/* Enable global ADMA registers */
 	tdma_write(tdma, ADMA_GLOBAL_CMD, 1);
 
@@ -736,7 +768,9 @@ static int __maybe_unused tegra_adma_runtime_suspend(struct device *dev)
 	struct tegra_adma_chan *tdc;
 	int i;
 
-	tdma->global_cmd = tdma_read(tdma, ADMA_GLOBAL_CMD);
+	if (tdma->base_addr)
+		tdma->global_cmd = tdma_read(tdma, ADMA_GLOBAL_CMD);
+
 	if (!tdma->global_cmd)
 		goto clk_disable;
 
@@ -777,7 +811,11 @@ static int __maybe_unused tegra_adma_runtime_resume(struct device *dev)
 		dev_err(dev, "ahub clk_enable failed: %d\n", ret);
 		return ret;
 	}
-	tdma_write(tdma, ADMA_GLOBAL_CMD, tdma->global_cmd);
+	if (tdma->base_addr) {
+		tdma_write(tdma, ADMA_GLOBAL_CMD, tdma->global_cmd);
+		if (tdma->cdata->set_global_pg_config)
+			tdma->cdata->set_global_pg_config(tdma);
+	}
 
 	if (!tdma->global_cmd)
 		return 0;
@@ -817,6 +855,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.ch_fifo_size_mask	= 0xf,
 	.sreq_index_offset	= 2,
 	.has_outstanding_reqs	= false,
+	.set_global_pg_config	= NULL,
 };
 
 static const struct tegra_adma_chip_data tegra186_chip_data = {
@@ -833,6 +872,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
 	.ch_fifo_size_mask	= 0x1f,
 	.sreq_index_offset	= 4,
 	.has_outstanding_reqs	= true,
+	.set_global_pg_config	= tegra186_adma_global_page_config,
 };
 
 static const struct of_device_id tegra_adma_of_match[] = {
@@ -846,7 +886,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 {
 	const struct tegra_adma_chip_data *cdata;
 	struct tegra_adma *tdma;
-	int ret, i;
+	struct resource *res_page, *res_base;
+	int ret, i, page_no;
 
 	cdata = of_device_get_match_data(&pdev->dev);
 	if (!cdata) {
@@ -865,9 +906,35 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	tdma->nr_channels = cdata->nr_channels;
 	platform_set_drvdata(pdev, tdma);
 
-	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(tdma->base_addr))
-		return PTR_ERR(tdma->base_addr);
+	res_page = platform_get_resource_byname(pdev, IORESOURCE_MEM, "page");
+	if (res_page) {
+		tdma->ch_base_addr = devm_ioremap_resource(&pdev->dev, res_page);
+		if (IS_ERR(tdma->ch_base_addr))
+			return PTR_ERR(tdma->ch_base_addr);
+
+		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
+		if (res_base) {
+			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
+			if (page_no <= 0)
+				return -EINVAL;
+			tdma->ch_page_no = page_no - 1;
+			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
+			if (IS_ERR(tdma->base_addr))
+				return PTR_ERR(tdma->base_addr);
+		}
+	} else {
+		/* If no 'page' property found, then reg DT binding would be legacy */
+		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (res_base) {
+			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
+			if (IS_ERR(tdma->base_addr))
+				return PTR_ERR(tdma->base_addr);
+		} else {
+			return -ENODEV;
+		}
+
+		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
+	}
 
 	tdma->ahub_clk = devm_clk_get(&pdev->dev, "d_audio");
 	if (IS_ERR(tdma->ahub_clk)) {
@@ -900,8 +967,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		if (!test_bit(i, tdma->dma_chan_mask))
 			continue;
 
-		tdc->chan_addr = tdma->base_addr + cdata->ch_base_offset
-				 + (cdata->ch_reg_size * i);
+		tdc->chan_addr = tdma->ch_base_addr + (cdata->ch_reg_size * i);
 
 		tdc->irq = of_irq_get(pdev->dev.of_node, i);
 		if (tdc->irq <= 0) {
-- 
2.25.1


