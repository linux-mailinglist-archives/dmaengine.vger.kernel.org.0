Return-Path: <dmaengine+bounces-5132-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFDFAB2E9F
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 07:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C743A954B
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 05:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478172550AA;
	Mon, 12 May 2025 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rqTkR9E0"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F55254B18;
	Mon, 12 May 2025 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747026067; cv=fail; b=rwEpKUKBxGk2f6L7GojI4J6nVfzrjs9v7+q1O9mGbY46QJ7A4KqebXLEb/7p9N+xgQb2MJONaE7wh2B7p63IIszKlaaRKqorQIiVmJVO0tpuYRD23Wwfb6b883afO+qPDvscKcwv/kyq9i1hS9J07gXArS+2DcZzU9efXyRgESI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747026067; c=relaxed/simple;
	bh=6Btlv8FGQqu4NBynYodLQungZsFvr1FWRYbjMGiRNmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeYxQH26l0Sck2C4msY7D7rS9JsYzTzc7rFwftoGaZ4f58JOzvscVus/pKedan67BQ6dzs0Q9QsjT8kEzpDgkBUbyS3usCd9OHcZL7ymR3g0BDd2HGUSwuXINAefmzCC+HUFN14pqC0DU+pomPMU5fQEiskOOKvRtLTh1HOkH6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rqTkR9E0; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXPr/jYhJ4QjtmRML7Ehz0y4Hhr4rw3eU0gxch5Bl65r8JWZmwJXCWJtNlWZhIzUC2PqqTOodrrktKcLtLa5FDD9Nv3X7ASoxUILaHNjKRCzZ8otwi5nL3MtUNazmpb+EUtBc3fAXDPHIjSaROJ/tRBTdJMh8A4r0tZyIEUskG90ZxRzo0nI9cahJHFO0slNWgc5sHpzmKrl1gLV18b6yIxqD11Yh7zjLe5iZA7eBJdJ5LdJv1em/EypMKmv8Cf8qP07T0itM7hQGlV3S8bs3oY6lfU8/8ONwvx+D+TKRwwgpZdrOTbOVx/wuGTikINXW4TdwIUlZouK5hoB4NuLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGQxd169s6Yr3sScRLWvMVPXwUvEAJFsMQi0ZlhmcsQ=;
 b=cOqJUcBhitf3ImrrocLRPPzUyPHA9d6AS3zFHHTnf4apmYXnWMGVENpUNdeYsVOSO9qy+JmVyZ8ZwYNPh5caur/k71dRVjw2EEsHB5SdgQ/gOCfiujTiJTUHPFscZ+4bRnsCaUV7Svge2wWSz6R1xJxOH4RYo11i4jsnqrf+O0qw/CCA8s3imfLuf+/qskx1RAnvkS5T4JsXMFfXvNx6fSdKGecJRkZVAQSUtKZRD11VgAJFj/JqR7Tr+xvWir8iLBJw77Piw6JvMWyPjhMiuJEaJnlJBLk/JHmreQD3+oRe5shglmS+eQ75DpR/Y9ffLH/6EiU/ZMjv77yI5GcDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGQxd169s6Yr3sScRLWvMVPXwUvEAJFsMQi0ZlhmcsQ=;
 b=rqTkR9E0hYzRW/j1g5kn3yNNQXZuaIGefTFKcv8If/c9yxkZ9upw2et5HEtMGpx93mF8kYE/7EQlv/w+XiFkhwt1D9H2LRxhav689bfBPFpWJ1K1txG9gV2G4tW6pUtM1nTjnj3QzCALfk3RH7lmrgM6QJJbl8COTd0949o4velbdNplNK/C6tmF764HCzL0fWzSt24EXhQ1LGzqnUO9KVQWRgrgJaUYDIzZLqgGtBbcLjtjMXe9uPR/APZXOkwGvgC4i2Bu3yqsS3kR3basR0zlssmnV00Znu//2kPWzwwsOpAG/eMiq48jgkPR51XwTLxkptAdFJHxNKP80kegHw==
Received: from BY3PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:217::14)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Mon, 12 May
 2025 05:00:53 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::5d) by BY3PR04CA0009.outlook.office365.com
 (2603:10b6:a03:217::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Mon,
 12 May 2025 05:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 05:00:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 22:00:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 11 May 2025 22:00:38 -0700
Received: from build-sheetal-bionic-20250305.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Sun, 11 May 2025 22:00:38 -0700
From: "Sheetal ." <sheetal@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<ldewangan@nvidia.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sheetal <sheetal@nvidia.com>
Subject: [PATCH v2 2/2] dmaengine: tegra210-adma: Add Tegra264 support
Date: Mon, 12 May 2025 05:00:10 +0000
Message-ID: <20250512050010.1025259-3-sheetal@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250512050010.1025259-1-sheetal@nvidia.com>
References: <20250512050010.1025259-1-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd583de-e598-4ccd-d3b9-08dd9111f8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EuoyoEpIryL8J405D404vimxgHMOC8+3ohkf4y09DMP5709y9PM8IWWNde8v?=
 =?us-ascii?Q?3N0IUjrhajNrvYIXgsNNKDkDRmYvXuTkm015K8DHc/78XadDAzV2SguV41pN?=
 =?us-ascii?Q?MF4XtNfUE3KQcR+sPrJlKFBuSFL7qQ1xDHgPVwqEwfSNGVqQKjs8e419WfcB?=
 =?us-ascii?Q?ACAzHeADH0geXVB+/HU9bu4Vq0tm7MRqBKPWfrY2ekuSuN5No9QN6p4B1uif?=
 =?us-ascii?Q?ZlY05H/kjIgqoeXdERm94kFINfZmu7JzZbin1S4d6dYMnTiV6KNuXtlMfXFd?=
 =?us-ascii?Q?lpuTXjljRgcO1Io1Bsbcy6XJ0/5nhGqMu7Mc/26U/nSPHkbB8IFpN9BCWUXe?=
 =?us-ascii?Q?wwI2Ngtvhns1M9eFfBroFXw61QGfiXS48dcafC7lC9t/41gWGVtDT43P+jHN?=
 =?us-ascii?Q?DEYItLzs5WFWSr3+b8QQxPP5MLn0ofViPtAnJE9y6TmUzXohSJYpButeib88?=
 =?us-ascii?Q?hPlNV+k5OReYkGiKjDraTeS//4NxqiW/7GQW0I0w4Y7J6yBi1ZFpFdq9XPIr?=
 =?us-ascii?Q?6Z98rs++CbpvrAjFGAKXLoHkPZqGiGLQ2buSXyFfzgS2q8H6YuYAOfKzaLk6?=
 =?us-ascii?Q?ebAV+DsCYw18Teary583A7YHVtJSmEbHPzc9kOHhaGRWoRNzT+YVN2R3bUZz?=
 =?us-ascii?Q?floBfsHK8VOFbTeaypv5bbwklCdTQ5oRjujgHlX8bCT+BfusJ5kFuE0McVww?=
 =?us-ascii?Q?GCFJ9ZcBtiY/ZhsX+dBSYEa693qUDzfZdoOdK+WFg0Y0Sv8d4Lqlj8hPLvtT?=
 =?us-ascii?Q?LtIMfvQ/plKDFx6mQlWTdeQOIitCRAiWWn7VQ/OP1kOzKMIOi2pX5SmLaEZv?=
 =?us-ascii?Q?2mnZEXTD2B4QAWHx10ll1HH2ATG8m5sVY+4tN0093DOAUmj7QY0AKcd1BSdz?=
 =?us-ascii?Q?Wr6U3SANnxlyGr6iRq3i65sPP0+xTDca7eOsdsInCeQviPNQWG8rYLnHbTqB?=
 =?us-ascii?Q?PccsRl2C39NyiqP566HDOV/IugZrQbF9lWJ4QSAfBBhLAbdsXhC3Uv13C+Fh?=
 =?us-ascii?Q?u7g6ndukW6x6czbl/HlhJMMpYrBJidj/pDeH2xObATxqecs847a/lnQjpGhD?=
 =?us-ascii?Q?MigR76MDTla/awfrdDhaGUvgVUusQwsw6AvUHWp1h1dAxN5AstdKx4dHdIHX?=
 =?us-ascii?Q?nIIHwakWYgGv3i6I0b2YXDQA1466e0Nk23YXkN6rkUKmrcfeq18wuxEV4oQI?=
 =?us-ascii?Q?H+OnABMPqaWt1uxgRtQqW5jvS90lRIhixAidKYoRJuGZVkIS0Ttwl2TJWt6u?=
 =?us-ascii?Q?B3aDWpN6Y1HlqL1fzB6+7IhmsBjvwIePt3WIuyF4SyEmA8Stqfo19CsD++K3?=
 =?us-ascii?Q?AKH3OT0ll7R4YLGjKXRK/+xf3M/vVcfUJRO3Bda1SWA/Aff3ZVHAFAxjKCpE?=
 =?us-ascii?Q?jgJjFVgWudP2ZjbcLggAHkfcGnKyDt21vmlTHPkZ1eS4M20TCrqshtdoRA6Q?=
 =?us-ascii?Q?O3D68n8m06eeQnPZvbD3EmizyWo49mRmmdjsk6nNGSjBWlHtYmLSfSJoPas2?=
 =?us-ascii?Q?5PXspXFyGft6nW7IPK8C1wKKZFMSc4jh4JkN?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 05:00:53.0496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd583de-e598-4ccd-d3b9-08dd9111f8c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

From: Sheetal <sheetal@nvidia.com>

Add Tegra264 ADMA support with following changes:
- Add soc_data for Tegra264-specific variations.
- Tegra264 supports 64 channels and 10 pages, hence update the global
  page configuration.
- In Tegra264 FIFO and outstanding request configs are moved to global
  registers, hence add those registers offset in adma channel struct.
  Also, 'has_outstanding_reqs' is removed and configuration moved to the
  SoC data.
- Update channel direction and mode bit positions as per Tegra264.
- Register offsets are updated to align with Tegra264.

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 185 +++++++++++++++++++++++++++++++-----
 1 file changed, 160 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index ce80ac4b1a1b..fad896ff29a2 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -27,10 +27,10 @@
 
 #define ADMA_CH_INT_CLEAR				0x1c
 #define ADMA_CH_CTRL					0x24
-#define ADMA_CH_CTRL_DIR(val)				(((val) & 0xf) << 12)
+#define ADMA_CH_CTRL_DIR(val, mask, shift)		(((val) & (mask)) << (shift))
 #define ADMA_CH_CTRL_DIR_AHUB2MEM			2
 #define ADMA_CH_CTRL_DIR_MEM2AHUB			4
-#define ADMA_CH_CTRL_MODE_CONTINUOUS			(2 << 8)
+#define ADMA_CH_CTRL_MODE_CONTINUOUS(shift)		(2 << (shift))
 #define ADMA_CH_CTRL_FLOWCTRL_EN			BIT(1)
 #define ADMA_CH_CTRL_XFER_PAUSE_SHIFT			0
 
@@ -41,15 +41,27 @@
 #define ADMA_CH_CONFIG_MAX_BURST_SIZE                   16
 #define ADMA_CH_CONFIG_WEIGHT_FOR_WRR(val)		((val) & 0xf)
 #define ADMA_CH_CONFIG_MAX_BUFS				8
-#define TEGRA186_ADMA_CH_CONFIG_OUTSTANDING_REQS(reqs)	(reqs << 4)
+#define TEGRA186_ADMA_CH_CONFIG_OUTSTANDING_REQS(reqs)	((reqs) << 4)
+
+#define ADMA_GLOBAL_CH_CONFIG				0x400
+#define ADMA_GLOBAL_CH_CONFIG_WEIGHT_FOR_WRR(val)	((val) & 0x7)
+#define ADMA_GLOBAL_CH_CONFIG_OUTSTANDING_REQS(reqs)	((reqs) << 8)
 
 #define TEGRA186_ADMA_GLOBAL_PAGE_CHGRP			0x30
 #define TEGRA186_ADMA_GLOBAL_PAGE_RX_REQ		0x70
 #define TEGRA186_ADMA_GLOBAL_PAGE_TX_REQ		0x84
+#define TEGRA264_ADMA_GLOBAL_PAGE_CHGRP_0		0x44
+#define TEGRA264_ADMA_GLOBAL_PAGE_CHGRP_1		0x48
+#define TEGRA264_ADMA_GLOBAL_PAGE_RX_REQ_0		0x100
+#define TEGRA264_ADMA_GLOBAL_PAGE_RX_REQ_1		0x104
+#define TEGRA264_ADMA_GLOBAL_PAGE_TX_REQ_0		0x180
+#define TEGRA264_ADMA_GLOBAL_PAGE_TX_REQ_1		0x184
+#define TEGRA264_ADMA_GLOBAL_PAGE_OFFSET		0x8
 
 #define ADMA_CH_FIFO_CTRL				0x2c
 #define ADMA_CH_TX_FIFO_SIZE_SHIFT			8
 #define ADMA_CH_RX_FIFO_SIZE_SHIFT			0
+#define ADMA_GLOBAL_CH_FIFO_CTRL			0x300
 
 #define ADMA_CH_LOWER_SRC_ADDR				0x34
 #define ADMA_CH_LOWER_TRG_ADDR				0x3c
@@ -73,36 +85,48 @@ struct tegra_adma;
  * @adma_get_burst_config: Function callback used to set DMA burst size.
  * @global_reg_offset: Register offset of DMA global register.
  * @global_int_clear: Register offset of DMA global interrupt clear.
+ * @global_ch_fifo_base: Global channel fifo ctrl base offset
+ * @global_ch_config_base: Global channel config base offset
  * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
  * @ch_req_rx_shift: Register offset for AHUB receive channel select.
+ * @ch_dir_shift: Channel direction bit position.
+ * @ch_mode_shift: Channel mode bit position.
  * @ch_base_offset: Register offset of DMA channel registers.
+ * @ch_tc_offset_diff: From TC register onwards offset differs for Tegra264
  * @ch_fifo_ctrl: Default value for channel FIFO CTRL register.
+ * @ch_config: Outstanding and WRR config values
  * @ch_req_mask: Mask for Tx or Rx channel select.
+ * @ch_dir_mask: Mask for channel direction.
  * @ch_req_max: Maximum number of Tx or Rx channels available.
  * @ch_reg_size: Size of DMA channel register space.
  * @nr_channels: Number of DMA channels available.
  * @ch_fifo_size_mask: Mask for FIFO size field.
  * @sreq_index_offset: Slave channel index offset.
  * @max_page: Maximum ADMA Channel Page.
- * @has_outstanding_reqs: If DMA channel can have outstanding requests.
  * @set_global_pg_config: Global page programming.
  */
 struct tegra_adma_chip_data {
 	unsigned int (*adma_get_burst_config)(unsigned int burst_size);
 	unsigned int global_reg_offset;
 	unsigned int global_int_clear;
+	unsigned int global_ch_fifo_base;
+	unsigned int global_ch_config_base;
 	unsigned int ch_req_tx_shift;
 	unsigned int ch_req_rx_shift;
+	unsigned int ch_dir_shift;
+	unsigned int ch_mode_shift;
 	unsigned int ch_base_offset;
+	unsigned int ch_tc_offset_diff;
 	unsigned int ch_fifo_ctrl;
+	unsigned int ch_config;
 	unsigned int ch_req_mask;
+	unsigned int ch_dir_mask;
 	unsigned int ch_req_max;
 	unsigned int ch_reg_size;
 	unsigned int nr_channels;
 	unsigned int ch_fifo_size_mask;
 	unsigned int sreq_index_offset;
 	unsigned int max_page;
-	bool has_outstanding_reqs;
 	void (*set_global_pg_config)(struct tegra_adma *tdma);
 };
 
@@ -112,6 +136,7 @@ struct tegra_adma_chip_data {
 struct tegra_adma_chan_regs {
 	unsigned int ctrl;
 	unsigned int config;
+	unsigned int global_config;
 	unsigned int src_addr;
 	unsigned int trg_addr;
 	unsigned int fifo_ctrl;
@@ -150,6 +175,9 @@ struct tegra_adma_chan {
 	/* Transfer count and position info */
 	unsigned int			tx_buf_count;
 	unsigned int			tx_buf_pos;
+
+	unsigned int			global_ch_fifo_offset;
+	unsigned int			global_ch_config_offset;
 };
 
 /*
@@ -246,6 +274,29 @@ static void tegra186_adma_global_page_config(struct tegra_adma *tdma)
 	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_TX_REQ + (tdma->ch_page_no * 0x4), 0xffffff);
 }
 
+static void tegra264_adma_global_page_config(struct tegra_adma *tdma)
+{
+	u32 global_page_offset = tdma->ch_page_no * TEGRA264_ADMA_GLOBAL_PAGE_OFFSET;
+
+	/* If the default page (page1) is not used, then clear page1 registers */
+	if (tdma->ch_page_no) {
+		tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_CHGRP_0, 0);
+		tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_CHGRP_1, 0);
+		tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_RX_REQ_0, 0);
+		tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_RX_REQ_1, 0);
+		tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_TX_REQ_0, 0);
+		tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_TX_REQ_1, 0);
+	}
+
+	/* Program global registers for selected page */
+	tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_CHGRP_0 + global_page_offset, 0xffffffff);
+	tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_CHGRP_1 + global_page_offset, 0xffffffff);
+	tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_RX_REQ_0 + global_page_offset, 0xffffffff);
+	tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_RX_REQ_1 + global_page_offset, 0x1);
+	tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_TX_REQ_0 + global_page_offset, 0xffffffff);
+	tdma_write(tdma, TEGRA264_ADMA_GLOBAL_PAGE_TX_REQ_1 + global_page_offset, 0x1);
+}
+
 static int tegra_adma_init(struct tegra_adma *tdma)
 {
 	u32 status;
@@ -404,11 +455,21 @@ static void tegra_adma_start(struct tegra_adma_chan *tdc)
 
 	tdc->tx_buf_pos = 0;
 	tdc->tx_buf_count = 0;
-	tdma_ch_write(tdc, ADMA_CH_TC, ch_regs->tc);
+	tdma_ch_write(tdc, ADMA_CH_TC - tdc->tdma->cdata->ch_tc_offset_diff, ch_regs->tc);
 	tdma_ch_write(tdc, ADMA_CH_CTRL, ch_regs->ctrl);
-	tdma_ch_write(tdc, ADMA_CH_LOWER_SRC_ADDR, ch_regs->src_addr);
-	tdma_ch_write(tdc, ADMA_CH_LOWER_TRG_ADDR, ch_regs->trg_addr);
-	tdma_ch_write(tdc, ADMA_CH_FIFO_CTRL, ch_regs->fifo_ctrl);
+	tdma_ch_write(tdc, ADMA_CH_LOWER_SRC_ADDR - tdc->tdma->cdata->ch_tc_offset_diff,
+		      ch_regs->src_addr);
+	tdma_ch_write(tdc, ADMA_CH_LOWER_TRG_ADDR - tdc->tdma->cdata->ch_tc_offset_diff,
+		      ch_regs->trg_addr);
+
+	if (!tdc->tdma->cdata->global_ch_fifo_base)
+		tdma_ch_write(tdc, ADMA_CH_FIFO_CTRL, ch_regs->fifo_ctrl);
+	else if (tdc->global_ch_fifo_offset)
+		tdma_write(tdc->tdma, tdc->global_ch_fifo_offset, ch_regs->fifo_ctrl);
+
+	if (tdc->global_ch_config_offset)
+		tdma_write(tdc->tdma, tdc->global_ch_config_offset, ch_regs->global_config);
+
 	tdma_ch_write(tdc, ADMA_CH_CONFIG, ch_regs->config);
 
 	/* Start ADMA */
@@ -421,7 +482,8 @@ static unsigned int tegra_adma_get_residue(struct tegra_adma_chan *tdc)
 {
 	struct tegra_adma_desc *desc = tdc->desc;
 	unsigned int max = ADMA_CH_XFER_STATUS_COUNT_MASK + 1;
-	unsigned int pos = tdma_ch_read(tdc, ADMA_CH_XFER_STATUS);
+	unsigned int pos = tdma_ch_read(tdc, ADMA_CH_XFER_STATUS -
+			tdc->tdma->cdata->ch_tc_offset_diff);
 	unsigned int periods_remaining;
 
 	/*
@@ -627,13 +689,16 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 		return -EINVAL;
 	}
 
-	ch_regs->ctrl |= ADMA_CH_CTRL_DIR(adma_dir) |
-			 ADMA_CH_CTRL_MODE_CONTINUOUS |
+	ch_regs->ctrl |= ADMA_CH_CTRL_DIR(adma_dir, cdata->ch_dir_mask,
+			cdata->ch_dir_shift) |
+			 ADMA_CH_CTRL_MODE_CONTINUOUS(cdata->ch_mode_shift) |
 			 ADMA_CH_CTRL_FLOWCTRL_EN;
 	ch_regs->config |= cdata->adma_get_burst_config(burst_size);
-	ch_regs->config |= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1);
-	if (cdata->has_outstanding_reqs)
-		ch_regs->config |= TEGRA186_ADMA_CH_CONFIG_OUTSTANDING_REQS(8);
+
+	if (cdata->global_ch_config_base)
+		ch_regs->global_config |= cdata->ch_config;
+	else
+		ch_regs->config |= cdata->ch_config;
 
 	/*
 	 * 'sreq_index' represents the current ADMAIF channel number and as per
@@ -788,12 +853,23 @@ static int __maybe_unused tegra_adma_runtime_suspend(struct device *dev)
 		/* skip if channel is not active */
 		if (!ch_reg->cmd)
 			continue;
-		ch_reg->tc = tdma_ch_read(tdc, ADMA_CH_TC);
-		ch_reg->src_addr = tdma_ch_read(tdc, ADMA_CH_LOWER_SRC_ADDR);
-		ch_reg->trg_addr = tdma_ch_read(tdc, ADMA_CH_LOWER_TRG_ADDR);
+		ch_reg->tc = tdma_ch_read(tdc, ADMA_CH_TC - tdma->cdata->ch_tc_offset_diff);
+		ch_reg->src_addr = tdma_ch_read(tdc, ADMA_CH_LOWER_SRC_ADDR -
+						tdma->cdata->ch_tc_offset_diff);
+		ch_reg->trg_addr = tdma_ch_read(tdc, ADMA_CH_LOWER_TRG_ADDR -
+						tdma->cdata->ch_tc_offset_diff);
 		ch_reg->ctrl = tdma_ch_read(tdc, ADMA_CH_CTRL);
-		ch_reg->fifo_ctrl = tdma_ch_read(tdc, ADMA_CH_FIFO_CTRL);
+
+		if (tdc->global_ch_config_offset)
+			ch_reg->global_config = tdma_read(tdc->tdma, tdc->global_ch_config_offset);
+
+		if (!tdc->tdma->cdata->global_ch_fifo_base)
+			ch_reg->fifo_ctrl = tdma_ch_read(tdc, ADMA_CH_FIFO_CTRL);
+		else if (tdc->global_ch_fifo_offset)
+			ch_reg->fifo_ctrl = tdma_read(tdc->tdma, tdc->global_ch_fifo_offset);
+
 		ch_reg->config = tdma_ch_read(tdc, ADMA_CH_CONFIG);
+
 	}
 
 clk_disable:
@@ -832,12 +908,23 @@ static int __maybe_unused tegra_adma_runtime_resume(struct device *dev)
 		/* skip if channel was not active earlier */
 		if (!ch_reg->cmd)
 			continue;
-		tdma_ch_write(tdc, ADMA_CH_TC, ch_reg->tc);
-		tdma_ch_write(tdc, ADMA_CH_LOWER_SRC_ADDR, ch_reg->src_addr);
-		tdma_ch_write(tdc, ADMA_CH_LOWER_TRG_ADDR, ch_reg->trg_addr);
+		tdma_ch_write(tdc, ADMA_CH_TC - tdma->cdata->ch_tc_offset_diff, ch_reg->tc);
+		tdma_ch_write(tdc, ADMA_CH_LOWER_SRC_ADDR - tdma->cdata->ch_tc_offset_diff,
+			      ch_reg->src_addr);
+		tdma_ch_write(tdc, ADMA_CH_LOWER_TRG_ADDR - tdma->cdata->ch_tc_offset_diff,
+			      ch_reg->trg_addr);
 		tdma_ch_write(tdc, ADMA_CH_CTRL, ch_reg->ctrl);
-		tdma_ch_write(tdc, ADMA_CH_FIFO_CTRL, ch_reg->fifo_ctrl);
+
+		if (!tdc->tdma->cdata->global_ch_fifo_base)
+			tdma_ch_write(tdc, ADMA_CH_FIFO_CTRL, ch_reg->fifo_ctrl);
+		else if (tdc->global_ch_fifo_offset)
+			tdma_write(tdc->tdma, tdc->global_ch_fifo_offset, ch_reg->fifo_ctrl);
+
+		if (tdc->global_ch_config_offset)
+			tdma_write(tdc->tdma, tdc->global_ch_config_offset, ch_reg->global_config);
+
 		tdma_ch_write(tdc, ADMA_CH_CONFIG, ch_reg->config);
+
 		tdma_ch_write(tdc, ADMA_CH_CMD, ch_reg->cmd);
 	}
 
@@ -848,17 +935,23 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.adma_get_burst_config  = tegra210_adma_get_burst_config,
 	.global_reg_offset	= 0xc00,
 	.global_int_clear	= 0x20,
+	.global_ch_fifo_base	= 0,
+	.global_ch_config_base	= 0,
 	.ch_req_tx_shift	= 28,
 	.ch_req_rx_shift	= 24,
+	.ch_dir_shift		= 12,
+	.ch_mode_shift		= 8,
 	.ch_base_offset		= 0,
+	.ch_tc_offset_diff	= 0,
+	.ch_config		= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1),
 	.ch_req_mask		= 0xf,
+	.ch_dir_mask		= 0xf,
 	.ch_req_max		= 10,
 	.ch_reg_size		= 0x80,
 	.nr_channels		= 22,
 	.ch_fifo_size_mask	= 0xf,
 	.sreq_index_offset	= 2,
 	.max_page		= 0,
-	.has_outstanding_reqs	= false,
 	.set_global_pg_config	= NULL,
 };
 
@@ -866,23 +959,56 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
 	.adma_get_burst_config  = tegra186_adma_get_burst_config,
 	.global_reg_offset	= 0,
 	.global_int_clear	= 0x402c,
+	.global_ch_fifo_base	= 0,
+	.global_ch_config_base	= 0,
 	.ch_req_tx_shift	= 27,
 	.ch_req_rx_shift	= 22,
+	.ch_dir_shift		= 12,
+	.ch_mode_shift		= 8,
 	.ch_base_offset		= 0x10000,
+	.ch_tc_offset_diff	= 0,
+	.ch_config		= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1) |
+				  TEGRA186_ADMA_CH_CONFIG_OUTSTANDING_REQS(8),
 	.ch_req_mask		= 0x1f,
+	.ch_dir_mask		= 0xf,
 	.ch_req_max		= 20,
 	.ch_reg_size		= 0x100,
 	.nr_channels		= 32,
 	.ch_fifo_size_mask	= 0x1f,
 	.sreq_index_offset	= 4,
 	.max_page		= 4,
-	.has_outstanding_reqs	= true,
 	.set_global_pg_config	= tegra186_adma_global_page_config,
 };
 
+static const struct tegra_adma_chip_data tegra264_chip_data = {
+	.adma_get_burst_config  = tegra186_adma_get_burst_config,
+	.global_reg_offset	= 0,
+	.global_int_clear	= 0x800c,
+	.global_ch_fifo_base	= ADMA_GLOBAL_CH_FIFO_CTRL,
+	.global_ch_config_base	= ADMA_GLOBAL_CH_CONFIG,
+	.ch_req_tx_shift	= 26,
+	.ch_req_rx_shift	= 20,
+	.ch_dir_shift		= 10,
+	.ch_mode_shift		= 7,
+	.ch_base_offset		= 0x10000,
+	.ch_tc_offset_diff	= 4,
+	.ch_config		= ADMA_GLOBAL_CH_CONFIG_WEIGHT_FOR_WRR(1) |
+				  ADMA_GLOBAL_CH_CONFIG_OUTSTANDING_REQS(8),
+	.ch_req_mask		= 0x3f,
+	.ch_dir_mask		= 7,
+	.ch_req_max		= 32,
+	.ch_reg_size		= 0x100,
+	.nr_channels		= 64,
+	.ch_fifo_size_mask	= 0x7f,
+	.sreq_index_offset	= 0,
+	.max_page		= 10,
+	.set_global_pg_config	= tegra264_adma_global_page_config,
+};
+
 static const struct of_device_id tegra_adma_of_match[] = {
 	{ .compatible = "nvidia,tegra210-adma", .data = &tegra210_chip_data },
 	{ .compatible = "nvidia,tegra186-adma", .data = &tegra186_chip_data },
+	{ .compatible = "nvidia,tegra264-adma", .data = &tegra264_chip_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra_adma_of_match);
@@ -985,6 +1111,15 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 		tdc->chan_addr = tdma->ch_base_addr + (cdata->ch_reg_size * i);
 
+		if (tdma->base_addr) {
+			if (cdata->global_ch_fifo_base)
+				tdc->global_ch_fifo_offset = cdata->global_ch_fifo_base + (4 * i);
+
+			if (cdata->global_ch_config_base)
+				tdc->global_ch_config_offset =
+					cdata->global_ch_config_base + (4 * i);
+		}
+
 		tdc->irq = of_irq_get(pdev->dev.of_node, i);
 		if (tdc->irq <= 0) {
 			ret = tdc->irq ?: -ENXIO;
-- 
2.17.1


