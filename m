Return-Path: <dmaengine+bounces-3907-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EBD9E5911
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 16:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C2516AD14
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E84021C9E8;
	Thu,  5 Dec 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EZASi6Po"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795821D594;
	Thu,  5 Dec 2024 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410781; cv=fail; b=vELaFSmbQTCkqROSP0CPZC977wWXol1z+LjLQCSImejhxOcZDPKh6xqTqc4EEFUJs3IlEYjGrYyyR6MWffAd3OL+ne8u8fjL0uj0/WEABjnY50Gpg2AV4JaxxqD1XyLcNGtj+qjXOAK27VJX5fZBdqQ5CT+9uyhvnoWNxm2XKWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410781; c=relaxed/simple;
	bh=t2O0J+ehR56uejV8Dv1PgD98ZExfvTkfzfaRBJIICbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcLVzP12ZwtwAF7TD/6MViXm48GUM9Fbli1LPMHwpg3oWpCeV64cbV+LU7oGYohg/1VK5xF0PipUKXKsnsaEFPrCAQkXeWa6p3sUOBESXgZ0VxnlrnOCt0IAXwCjPsx9EzhLJRIRd1lKOWpDU0Za0TzxV1tcIVfYo9L98WcU180=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EZASi6Po; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3bYUdB/Uv8IX10++Zr6CdADsMfeQWXfXXXie5bH/u3axw7vRrMwNz5eL14Jtv+c62o7H2iIW1t9Zq+dkb+nTCSuGFJfAfmCSXsm4OuLqijuJBD5VYRs22h8lZVBiyIbx01F8wpuFx0DrPTA2fjxfWyrZnsxq1Jo7PVIQ/A0lM7Pge42dj0U0G2/ZbMjnQtBw/x3X/QVVILVtSleLGDiClHAEesgghDiGSJMWbsrzQkgKPUZxVs2q44A4WH12HgZweolRL8h5AVct7wS/H8xKJ4I/lEijfS3oQwGXCbCcrgikOSW4E2zI16aToHXH3j5iA9BkDmEWZX5TK5uU+93dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIIu534TX3lhOryF2fscbWwyfydqGSYwW+sCHVbJG8M=;
 b=HPrTm2OEMYGC2c7PyIYpnnbB7UbV01aWl5BVFcMZUYZn+oPGk15YS/QiIsCNy8g9H8XlTM3PXKUqZ+9Ck1NLGUFhAdX9AuUt4qpMaLceZVr6WKbsSCvZTHKXvKXXqYhPkza/jI1ZHypBiJDUt1Ht7cDxX6dQg1SFMKhqfXRVYs2zqnBu/4OSQ8Nj/L08i5Cx3zgQjNg6nTHFO1wZ5cDi13SIcgIjpE4RN6wxiMhgJYf4Rkckyl4JxGIxw9gsqf742YyefZpahhHVnVWAgq1f7YcFLKJRh0mSLhlIasly5CLSlq07Li9XefrrDeUuok+2r6wuMnGO14xQgziZJU4Omw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIIu534TX3lhOryF2fscbWwyfydqGSYwW+sCHVbJG8M=;
 b=EZASi6PoQd9k+vJrNehffslbwpaAgCVbmA2rMsUQkWYX4ZrBSFX4o0VN0n/KmHc4if8XmgQCTfWXPLd5Ce3V4uGlyMu4HeruZqF6lfhY/GXEbFckGoyVLxGetZ6KSVnV/cvn7/ZN3csfYduagM5R896MMDLsRT8y03Qhnr8RIZsZV8a3eI8x75uHMT/MNYuvXBby1KcGYoFVKUbmbFyx7bA1O6cc93LeWlyJXGXhRgKXU8Jvna3nNYp3s9+w7nxTj+t58oQ/FpiuCMl2ItGf4+HAGbzU6CQQp1PJg4ORtzqR8LNLPKNQmd4hBY5FXD6HEO7ntaNAcynPRdkhnhJRAw==
Received: from MW4PR02CA0020.namprd02.prod.outlook.com (2603:10b6:303:16d::26)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 14:59:30 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::58) by MW4PR02CA0020.outlook.office365.com
 (2603:10b6:303:16d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Thu,
 5 Dec 2024 14:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.1 via Frontend Transport; Thu, 5 Dec 2024 14:59:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 06:59:16 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Dec 2024 06:59:16 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Dec 2024 06:59:12 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <spujar@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH 2/2] dmaengine: tegra210-adma: Support channel page
Date: Thu, 5 Dec 2024 20:28:59 +0530
Message-ID: <20241205145859.2331691-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205145859.2331691-1-mkumard@nvidia.com>
References: <20241205145859.2331691-1-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c1d034-2b61-42c0-a315-08dd153d6bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l9SsjxSl8XnU1VGNIERURWd5ZBCzq7cjmffrTqgfwVt0Xpalf3rfvwtlfcyg?=
 =?us-ascii?Q?uFpXpAjYAZzf28wE/ymLBXBnU/qsV9h/e0j6LGT6l+KyRUut3Bw5dKfDgA9j?=
 =?us-ascii?Q?hT97ZxW9MAbgIsQot2L06iz43LIfEv2vK87onMLh6k7amEZTX+sO2fNCrBsY?=
 =?us-ascii?Q?dQbad9MQO09+WnJmFvA1wZj5fPl7o+/HY7BfGJWFahG4kHxQI5nQO3JCENAl?=
 =?us-ascii?Q?x+35Tvn0TPtjqDJFY0FVwINq1nWvCg9IAJ9FK6SWxL7vQCePcoBZmnX8Y0tB?=
 =?us-ascii?Q?w3e9n+JrTecjz9g2D3Nj9pNk3UQtYtUpsdeCcrU98l5fbMwqzBQ56ne8jmSM?=
 =?us-ascii?Q?dJIu+Ritvoan3NCMUJLMYtRvsiDyCG4F8kOJfQ+mDkoZXa1KeD/Kq0k9S0VR?=
 =?us-ascii?Q?VPjncfd/7Vic2THOfNs4mN2SoThTUcX84Jb8YcCutR/ufWouCJaKFNYTkyo4?=
 =?us-ascii?Q?Dt6QgRR21Y+d2KGywd/X1a9uZQQ0MOC6ZO/jawu7lDg0sAVcorNUtFzBv1x3?=
 =?us-ascii?Q?BDTPgRupLOCkxWwzd6gcTOVkKlJHuwXcdzPE0WK1oeFNsGnF0bX24vRLBiUO?=
 =?us-ascii?Q?CzGpZO6m1VnUIRJxtq0nm6h3ElPrAcxS6w9kkC6U04LrbprqI8gKijyrybxN?=
 =?us-ascii?Q?73EnCgsX7OMOgUOfMHLd7NZxrc4SpA56Z2PDK2KO8WZDUMOQiYFs8qzYsgSy?=
 =?us-ascii?Q?1ND+Y0VYZUm5TpdS+EPepFiuWQ4uf5O2FyVw0unnqMyiei9C7bNGse4QzDQm?=
 =?us-ascii?Q?yRRQyhBUrIlzLMx87Z0OncGGnXYdP/ujin8sJR2nISCEjT/o895XlB3F9z6N?=
 =?us-ascii?Q?jVkr/3sFv4DxxVyVf9/vuAaTnpQq4HEe2OZaYhAeDrkRO7NDjeuY5yXXPThX?=
 =?us-ascii?Q?qE0B5yEWm4Cwxs9pGHaCznfJnztfSFo55ODkgIMuo2e4bTlVUozbpK69nHe+?=
 =?us-ascii?Q?kUFkQGR/QrL1GXzR6CfD8xCEMr1pRWR0Ozb+a0lfAZ5sHcHRDJnhiIQng5US?=
 =?us-ascii?Q?mjyOaa1SpuXluB0E4+vgZJXILxJyKPfJ07VZdrg3bWZ/5mdbtyQRUX0Wxib4?=
 =?us-ascii?Q?ZMevJPePWzHATR7bb38yCV7NnELOoNtXT0eo2j1e9hx731/y/kI+lOMvH2LP?=
 =?us-ascii?Q?JkDoDHijzV/h145nHJay6BapR/udNrvm9XAQJnj4t99/0DIH0Gx0CWkiXESs?=
 =?us-ascii?Q?RtaRiybRIsYYK794YMIqfa2z8HeXgm3Ann3bkvMilUWMcUEY+cooqBnZTZxg?=
 =?us-ascii?Q?vBDmCpIOHf+8+GVHZFitwNYi2YpzlPHBuNBtfmmIi9cXeXuQP6gBmU/Fp/iA?=
 =?us-ascii?Q?RRC+QRtwK7WmZPuX08E767Wlvk7AOhwL4fB4dksCSZUBfH0WibbTX+k48Mhi?=
 =?us-ascii?Q?mJdT2RLd+ARKQEJSnXfxBex4NRBbXzFwFwsMA65IDi/Zp3Cvaspw03R3rMj+?=
 =?us-ascii?Q?MMO3DTBynqURsp/WA8Hd19xNTpo7TxpB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:59:30.1826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c1d034-2b61-42c0-a315-08dd153d6bd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339

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


