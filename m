Return-Path: <dmaengine+bounces-5113-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6A3AAFA25
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 14:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874BB3B8BAD
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CDB22687A;
	Thu,  8 May 2025 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kqavyIWJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677D226170;
	Thu,  8 May 2025 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707778; cv=fail; b=bsPovp15snofAYbabS06tG1Fp0Z8B/QDt/Fo0ZAf0aeC3MvjJgSelTxlGgRLyGtN1+dIXlI7oGhFQssEz6SSsfX0z1qvnKbbXDOKxm74Cx67fULTPN3DTr/nnffYJqfqZRBHg3TG4Ro4qosDJssDcO4q24QtcylBn/9IKRcy7tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707778; c=relaxed/simple;
	bh=U/xxQJXhDAe4WEl9g4SQklZbj4XDmY6i4JAcN7+UT2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfqG7W/PYcyICB9JcSG2txiD1Jktte7bZyJQEeWs/8xQOdFfoLLPLc/NT+AfQ3XPJPpeCApuw61JSgsGxiJlXFMPgWsn6RMGPLQjfdSow5fYIfBPUdjYlnIN0T8rgiAeLFHHnjLDce1VeAbDtmbTiK1hq4s4zLI+qZBXUIWlNIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kqavyIWJ; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbViS7BJqy36UpL/jQJ7oiH9xlvSoIxdKjceNpBujXKgdmM+t6EkIqRPW6Bh4wMU1hq8JR+tN6+YyqYeQDiqg9+F1cC9cnpx3YkiDkuUcWkYbhQzdPMu9SH+CuaDtA8ThOLaxBBetkzsvNfc+DQC5mCoLd/casxXxp9EfnxZ4a9kDamBT+YBMxhD45bkOsfIoq37hwbD5v9AXMKJcxbV6OZQ4se79XGqtgZn7OXE5qriHXqlr5xk3dadR2TUW/DKfGiQ4rnOC46LOzZsrb/atgFIuhVabDO8qGse7fZveSiqGf8ESOKL08K2I9r6Mzuoykp3H6iynB5atwwRAQVb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWK4DmCjigkGCiV0f8TvjgvmtMzWNE6dU7ZLbay8IdQ=;
 b=AXmhgkI7vChHmkSHHy/CoZjAqAqZFUR+k6vMoHBKvjapQVTrp/fSjjCEoPqnB61D4y56TfCcWa7mg7DpP1x1SYcguQK9Yqzn/iRChmYG9D79YP5GYALqycVzS/G02RvS7R7yx0ibTD5RV1tI48cZUFNfIVJR5iw13oZMKylVqvDAKvbb1QTeymLUOa4FLwQgzqG2jzbVQOnZPlwd7rF5xqYRmbDHcjtOXFShfmG0kowhpZoALOx2J3uqhagqBO8RnK6w/lYE/PnlNvQbaJnX0L1BA5t2G30u44YWRTqnFjOghgm3Suk0BeM5M4g2wIHud6uSmmUO9AF7pdYQHmyQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWK4DmCjigkGCiV0f8TvjgvmtMzWNE6dU7ZLbay8IdQ=;
 b=kqavyIWJVBiQ3pLue1WL3MnXgoOUUzgyrQiEdEIhPsQ59B+GdC6aDJVXaY/6za7EInqDaAkR4n2YUs7U6BIfPN7vOoORpIEUOrSg1v/BMq7HqlP5eU6M69nO69DZRdpmZvMk2KNdl3Ut7B4Pl1YFktxWA95/ncTt13QMpUAZj0vyUqv7dQx6EDyeZdsVAIB3bVg6ROv6QAEku4mia2CZj8ajE7qAL8WrOJXljLmMcZf0fOMvv8kHwErTxKutcUQz3zK2U3P6dlmGUYUPKrbFLyYMh9SkrqVzd/dRz2Amc6+aTiR+hPl45jzr2uQ4ztS/+UHrVRaiUFWsTX/mm4jj6g==
Received: from DM5PR07CA0106.namprd07.prod.outlook.com (2603:10b6:4:ae::35) by
 LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Thu, 8 May
 2025 12:36:04 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::28) by DM5PR07CA0106.outlook.office365.com
 (2603:10b6:4:ae::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 8 May 2025 12:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 12:36:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 05:35:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 8 May
 2025 05:35:46 -0700
Received: from build-sheetal-bionic-20250305.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Thu, 8 May 2025 05:35:46 -0700
From: "Sheetal ." <sheetal@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
	Sheetal <sheetal@nvidia.com>
Subject: [PATCH 2/2] dmaengine: tegra210-adma: Add Tegra264 support
Date: Thu, 8 May 2025 12:35:20 +0000
Message-ID: <20250508123520.973675-3-sheetal@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250508123520.973675-1-sheetal@nvidia.com>
References: <20250508123520.973675-1-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 355b963e-1b02-4e53-d5f8-08dd8e2ce61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQ9WzltjLxiEdq7HRIA/BBE0pHu2xYf080W8/tIvanzrnaLCQ+uPHEgLulVt?=
 =?us-ascii?Q?YD5RHD2VvqBePEhMd7eLIaoQ8t0C/XWn4ey7U4alUFOEGDQXYwzxGp0WQY5S?=
 =?us-ascii?Q?DktpB/6uuc+3HX+OhxWRHaRHsI1A43sYPzQ83whh+f9WUqaNZMnc6Q1GfynZ?=
 =?us-ascii?Q?MQj2XZFQJcCRreCS26nokKjCiyYSC1L65o2TgOZ2KzQeim0U3qYArtwnAV95?=
 =?us-ascii?Q?fiWHninkx6TRdw8zXHGfCRFWiEMzgLEeAnJGhlBs66GeBziTfG4d20JOoBt+?=
 =?us-ascii?Q?UolgWTvAtFmuTSPpyng8BXyHBjPleRRrmku6rDbQQRAhIJ4e48XsQj3pcy3L?=
 =?us-ascii?Q?24H4RiX+5MxYYFWm0iWAy1Q+eyebQa0FHyLpyOWvYtY3Ehj25Xp9hGlHPLgf?=
 =?us-ascii?Q?c8DCd6lejN18uT0ILlSrdsTevn8cAyYpQCN2+EKzfJFG0Hl0y+J/KGRMpM5Z?=
 =?us-ascii?Q?upnKcY3SObRyg8Qd5lAnOX4JNqVTIARO2JtEZpU78F2Hc7M3UdHcsa070snG?=
 =?us-ascii?Q?dFhciqjF9D/mc5K4zuEuQ9SduCIQtGHKkh3K1C+pzDaM2N87qxyoFCAjz+Kj?=
 =?us-ascii?Q?+0k5Czj88kEfRJFmuXWPCoyZlZvMy29Wlu7q46GQTI+yA7f7FRzftbV8RBpd?=
 =?us-ascii?Q?zV8X6gi4fqnm55Tt8DN/nIvPmkk0c8GcBl9nAKD8nE9rjDy5AfWGKRmn3n5Y?=
 =?us-ascii?Q?2J+2pC7n8y/3qrm99H0PZK2BuRDIXEtuaPx0Kq1nUZQleV6Q1EulwCdOodVH?=
 =?us-ascii?Q?WasSd+B14X5iLyqpkIXlip+SSqDaq1TZp7wlmVL8xwo42IX6rDxnOMjFgfZt?=
 =?us-ascii?Q?GnzFPfjJ6Jxyos+K4R8gDp+yuA1+nJYzVR3a9GIZCj3bCEJKs781MOgd8Roz?=
 =?us-ascii?Q?5KYbYNr9612oA9NEhEm8e83XW1F82NQaimEC7L/weP9Wxr5Xx0AIxX9O7IHB?=
 =?us-ascii?Q?LK55EsYZy689gS6XKKMaMQXwHEBqe2dN+FaAJXakCajNxG4e2SuIAB2EU44f?=
 =?us-ascii?Q?09ZbH7aGf6b67oSeEcxq1NK8cEG/LxPBlHHVXjHsEItP8af6Fh2z0tcDsAlA?=
 =?us-ascii?Q?l/pFifI/AFgdDu0E/kANH4pcXIpNoeTMTVE/aKNGN9Tv4g80x0S3nT6WGMs5?=
 =?us-ascii?Q?YryzJcXqe8N3yYf1Yz+nnwCVrttn34RBjZnaSKwX6HShBOe+0LXrJaWBsaTv?=
 =?us-ascii?Q?XTZIIkaTF51NnCtrBfexziH0rEL+fMMBTe3j+AIW9fZ8AW1c56SlQOf96R1H?=
 =?us-ascii?Q?mWAuBkOlAF4JW1m6wSD9ryJDuJNT9qq+ezKjk5kpvB1JASoYmuuOVVOrEnT5?=
 =?us-ascii?Q?cKA4VwA49UFOTawMtfUJiWpOvWxRYBXe6VIU4isPmJiJqmg9H8pqxSNNEyxJ?=
 =?us-ascii?Q?QCo/Fp74L12nkfPjJLl7gCbYLZAOQ24Vfl0kADqo0c+T88J5LqfOkZFrdFWI?=
 =?us-ascii?Q?adPFnHzQqeIurb+Hfc81b2WVWykN9pWI6DSB9ZXHoqdNvlq6Gh78+D8tnJIz?=
 =?us-ascii?Q?ZC0eOuySeQmH+HUCMHlEwWEP0caQFtkoAC9L?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:36:04.5195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355b963e-1b02-4e53-d5f8-08dd8e2ce61a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265

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
 drivers/dma/tegra210-adma.c | 194 ++++++++++++++++++++++++++++++------
 1 file changed, 164 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index ce80ac4b1a1b..1ed3ee590f5c 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*
- * ADMA driver for Nvidia's Tegra210 ADMA controller.
- *
- * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
- */
+// SPDX-FileCopyrightText: Copyright (c) 2016-2025 NVIDIA CORPORATION & AFFILIATES.
+// All rights reserved.
+//
+// tegra210-adma.c - ADMA driver for Nvidia's Tegra210 ADMA controller.
 
 #include <linux/clk.h>
 #include <linux/iopoll.h>
@@ -27,10 +26,10 @@
 
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
 
@@ -41,15 +40,27 @@
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
@@ -73,36 +84,48 @@ struct tegra_adma;
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
 
@@ -112,6 +135,7 @@ struct tegra_adma_chip_data {
 struct tegra_adma_chan_regs {
 	unsigned int ctrl;
 	unsigned int config;
+	unsigned int global_config;
 	unsigned int src_addr;
 	unsigned int trg_addr;
 	unsigned int fifo_ctrl;
@@ -150,6 +174,9 @@ struct tegra_adma_chan {
 	/* Transfer count and position info */
 	unsigned int			tx_buf_count;
 	unsigned int			tx_buf_pos;
+
+	unsigned int			global_ch_fifo_offset;
+	unsigned int			global_ch_config_offset;
 };
 
 /*
@@ -246,6 +273,29 @@ static void tegra186_adma_global_page_config(struct tegra_adma *tdma)
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
@@ -404,11 +454,21 @@ static void tegra_adma_start(struct tegra_adma_chan *tdc)
 
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
@@ -421,7 +481,8 @@ static unsigned int tegra_adma_get_residue(struct tegra_adma_chan *tdc)
 {
 	struct tegra_adma_desc *desc = tdc->desc;
 	unsigned int max = ADMA_CH_XFER_STATUS_COUNT_MASK + 1;
-	unsigned int pos = tdma_ch_read(tdc, ADMA_CH_XFER_STATUS);
+	unsigned int pos = tdma_ch_read(tdc, ADMA_CH_XFER_STATUS -
+			tdc->tdma->cdata->ch_tc_offset_diff);
 	unsigned int periods_remaining;
 
 	/*
@@ -627,13 +688,16 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
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
@@ -788,12 +852,23 @@ static int __maybe_unused tegra_adma_runtime_suspend(struct device *dev)
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
@@ -832,12 +907,23 @@ static int __maybe_unused tegra_adma_runtime_resume(struct device *dev)
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
 
@@ -848,17 +934,23 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
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
 
@@ -866,23 +958,56 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
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
@@ -985,6 +1110,15 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
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


