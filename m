Return-Path: <dmaengine+bounces-6533-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F22F9B59593
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 13:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DA21B276DE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E3F30BF71;
	Tue, 16 Sep 2025 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ztljIobU"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66342D661D;
	Tue, 16 Sep 2025 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023666; cv=fail; b=dQdbyFrx/A4PY9EZSwtlrOjQ/kUNR7VeAuXNUhATjeYTtsgtqLwORLLsA8JOn+Mo+0LW8KISvfFWkUgRKqo+zzK5c51wKh027ux96rLYZnMmRLqRghA35QdbcR0+QuP2bDf9zh7iFpX3ouG1J6+Ff9AVGckj9evJ3bQKBz2xYSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023666; c=relaxed/simple;
	bh=+BQQPsrDx97q8RH8G8lmbWy9rQzr64Y9CJ+s/jCWq+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZqNns+wMaMHkLZvkD32+MzemOEJ7SHDILZ2YntwMDZx+Dwr3iDWWne0tqPVAtfrcIcJu264ii0+aYIUkJt5OpUzFUnYg7j+y6M+7X3PU6yeidWjB7qJKvTlpKKDvTfPxw+0sAgCDd+dYWvPAESho5pmdNT24ZPvbdF+dIqW+qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ztljIobU; arc=fail smtp.client-ip=52.101.57.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfjyVWIq9nK/wGXjFNMlXbUETVLwIZ81WoTmkIwzG/zU0NPPUcCIdPOzxWe9N/PSJ6KlphNLWQ4cA27Dx6NubOmFFOwsqH/+D5vU2TIrD3UNvihXTZfzHKW3zK0UIJwGajHdjgNYvehSCtJaj95weNavgv8m6/KvxpNk+/sxsRtWxfyFbk6nRvNM4RQ1AqYqgfILxjpOU1ou/3L1GR+HVSv7Zaa3ON0+q2aZuNLFiLtBnl3d2YUbN7GElXbBM5AFoHjXNRjbSljEwM/1gDebrblDXMm6rCF/7FshWAj1omEjdtT26+YbeYj1GbWQpS5pvPbiH7yRrm7qCxWp+k4ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9uNgDnHk9zQWccNcUAEXF1h7XHiyej0bc38H/Nzhfc=;
 b=jTGFyN6VSIEqsaq6Js66aFSFg5vrO7ylD0nCOaFra87WMc5QuD/WrN1oAlidP38zwbboLc8VE38khtLvzAchTIoJc9xVz9AZ/55AE79PMHMnouwFyHLR94MiX5VX6r+MPk3hF0WaSouqX9YV9VfPoL6U/A1DUaHTFOOAhpCDyczlSrW4nJMI2yqoMEgkTW8oyopHftgzPnTgouPOIShl9EjRrAIk4tMrO86IEScUu4T2VNEfBptJmA2PZ0g42lNSvP9mv7GY6Gi6VgykMDzeIaAFhbGSvJ+E3Lky5ewYq81iVgeQ0yuF288B4TsXfKkbnWEP0zUdCpcZFngNa21Alw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9uNgDnHk9zQWccNcUAEXF1h7XHiyej0bc38H/Nzhfc=;
 b=ztljIobUqVFfeDQNDESevoEwoXCIbxcdSfrZHTgz46wQ00S0T9xxgNIDQxWYxtpPq3AbS5pw4w6sRibByjpxZ46jO8wJA4Yhpy5fXBlzNuryQsleEc0cn7hObYVPiMLL9i/nuIyWfGSMudYkkfwzA8LgwnlMaDgMaWn6QD6jgxU=
Received: from CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::19)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 11:54:19 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::a3) by CH5P220CA0021.outlook.office365.com
 (2603:10b6:610:1ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 11:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 11:54:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 04:54:18 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 04:54:18 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 04:54:15 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v3 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Tue, 16 Sep 2025 17:24:10 +0530
Message-ID: <20250916115411.23655-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916115411.23655-1-devendra.verma@amd.com>
References: <20250916115411.23655-1-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b0c597-fe38-42fa-b826-08ddf517c501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LOTwupXNgZ9EpGK5ZdJeptv8xiCYM+d1FXtnA/jZVS0+8J+chKhDAv10yr8/?=
 =?us-ascii?Q?DEVJrkp6lCGUXy7BoGZtA0AZQeBkb1zURCQX1q8C8VM9VSnUhRpQFlDpj/st?=
 =?us-ascii?Q?dBWSaDfwfTV4UIr9la9AGxG6XhFtXKiDawT1+Q5vFrohf2k/O1APh9eh5Qdk?=
 =?us-ascii?Q?1LGGqhdRXW0zeagELol1lefot1/LSukKIJbiLYUNAve2tlD4hceW4T5/lMm/?=
 =?us-ascii?Q?We/CCbzUWEGypviKokpa4OhWdv2hITzMCWkHUNp9YPt6F+eNmVYUVnvYUZd8?=
 =?us-ascii?Q?05vZeTQs6uE+3FPzVI50W6riWjBAn+uewrA9jBcSoEvT3YqJ4tD4e2HK1QAM?=
 =?us-ascii?Q?F2iypLqh2BasABrIKYOkWWgpQWUyMXuL7V5baeRNVLXp2i1vypOQti2GiRqu?=
 =?us-ascii?Q?VaQw/VWgcPogIIvPACFltd5O/DX8V8PE9pAVFgpItgF/mi7HpVLCu4KXJkuL?=
 =?us-ascii?Q?rdR9FRna3wSrus75IqYbSBRZ/SIFHvKYgYxR+O/KATVdBoBCdFXz/H/tK8FP?=
 =?us-ascii?Q?Q5th8/WuXZ/P32iRHu6Bm+8A1qvQDcNn6mygv7zNKAg4Z3LcNXR6BuOVWnXf?=
 =?us-ascii?Q?y6GAdv9wpSPi6kw+Dj1/E9R8x8lSGQqwR6vn36JwJN4W2viGCo3wqu+UwkNS?=
 =?us-ascii?Q?xhYSCLc2/VKcwqsP2xX1JKzT29Imouw1Z0EZu6v4dfgyF/G+irPD0Te/Y3gF?=
 =?us-ascii?Q?+MrlUScORFNHPLAwIwj9TauIvkpc0R6FFSEDmiI4SLTY30R/AfXYSpLAxJEn?=
 =?us-ascii?Q?fILa1kRK/96/h60tKXoP3JSRy/YeE3F26W0tXBbRqu5b4rKXfmp4vOG3mPYx?=
 =?us-ascii?Q?fYg0pX5bqNfyoBR07H+gJIhuJb8/idpRlvvNIYuW1eqzY4yTDvj8D/2bHcSQ?=
 =?us-ascii?Q?GDdwBsbHx3HECSV4SJTGrGZoSiD+GfDhChd7YGUPO5O5c5hKaFihKWgilBUY?=
 =?us-ascii?Q?YVuUlOSwSr8cn0Ph1gyWSvDAdQuW4uH90kFNHRBYWNy7BYi5K3c6r8dOiCzT?=
 =?us-ascii?Q?UipSCtkL0UMyVtbZYuAmV9pnBnkmpaGm0LRaifJ1GHBlLVHKSgjtFnBUTOQj?=
 =?us-ascii?Q?R6YQHx5qcq8IbZ+Fo4vZ09E+sKlQtayFC6lmq0UZ/KLshYzGvvTPKW0ggU/S?=
 =?us-ascii?Q?5EOjoVBNhakn4S430J7Cjc14y9ta3lOOH/ZjIjOWC2oWObJ9FIWXg5XQ1Pz7?=
 =?us-ascii?Q?poBbnfaZga+W6UilW57mVCZTQMFpGCnW1ndcWuLY/8Cx4i/GvCDxGF7B9ktk?=
 =?us-ascii?Q?R9t2a9ZUQr7fR8qvYk+Zy4sBwuHUQUSD40F9B8xYSh5lxIOX7t1sVsK4O+Xp?=
 =?us-ascii?Q?QfFEuSfkaTn4jVQqmbJc4a4i7SbvxYyd4J2HOVgKAfhRUw39I1J+EZI6pojS?=
 =?us-ascii?Q?/zSn5s4vPU8ugJNq/djGslO0aqym2HAPFWq6BpIKopOVYDpGhufvawJWTQqg?=
 =?us-ascii?Q?HS9fXb4lolK5UFfWN9qUqYGCfxsu3UK6b0uJkXs2O75E8XyQoEeQCw+72t1F?=
 =?us-ascii?Q?ngDBcyNMILk/m/qhS1SjgGyA5SgXOdCq0Au4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:54:19.4198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b0c597-fe38-42fa-b826-08ddf517c501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v3:
Corrected a typo when assigning AMD (Xilinx) vsec id macro
and condition check.

Changes in v2:
Reverted the devmem_phys_off type to u64.
Renamed the function appropriately to suit the
functionality for setting the LL & data region offsets.

Changes in v1:
Removed the pci device id from pci_ids.h file.
Added the vendor id macro as per the suggested method.
Changed the type of the newly added devmem_phys_off variable.
Added to logic to assign offsets for LL and data region blocks
in case more number of channels are enabled than given in
amd_mdb_data struct.
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 147 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a7..7549125 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -17,12 +17,19 @@
 
 #include "dw-edma-core.h"
 
+/* Synopsys */
 #define DW_PCIE_VSEC_DMA_ID			0x6
 #define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
 #define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
 #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
 #define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
 
+/* AMD MDB specific defines */
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
+#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
+#define PCI_DEVICE_ID_AMD_MDB_B054		0xb054
+#define DW_PCIE_AMD_MDB_INVALID_ADDR		(~0ULL)
+
 #define DW_BLOCK(a, b, c) \
 	{ \
 		.bar = a, \
@@ -50,6 +57,7 @@ struct dw_edma_pcie_data {
 	u8				irqs;
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
+	u64				devmem_phys_off;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -90,6 +98,91 @@ struct dw_edma_pcie_data {
 	.rd_ch_cnt			= 2,
 };
 
+static const struct dw_edma_pcie_data amd_mdb_data = {
+	/* MDB registers location */
+	.rg.bar				= BAR_0,
+	.rg.off				= 0x00001000,	/*  4 Kbytes */
+	.rg.sz				= 0x00002000,	/*  8 Kbytes */
+	/* MDB memory linked list location */
+	.ll_wr = {
+		/* Channel 0 - BAR 2, offset 0 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00000000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 2 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00200000, 0x00000800)
+	},
+	.ll_rd = {
+		/* Channel 0 - BAR 2, offset 4 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00400000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 6 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00600000, 0x00000800)
+	},
+	/* MDB memory data location */
+	.dt_wr = {
+		/* Channel 0 - BAR 2, offset 8 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00800000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 9 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00900000, 0x00000800)
+	},
+	.dt_rd = {
+		/* Channel 0 - BAR 2, offset 10 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00a00000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 11 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00b00000, 0x00000800)
+	},
+	/* Other */
+	.mf				= EDMA_MF_HDMA_NATIVE,
+	.irqs				= 1,
+	.wr_ch_cnt			= 2,
+	.rd_ch_cnt			= 2,
+};
+
+static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
+					   enum pci_barno bar, off_t start_off,
+					   off_t off_gap, size_t size)
+{
+	u16 i;
+	off_t off;
+	u16 wr_ch = pdata->wr_ch_cnt;
+	u16 rd_ch = pdata->rd_ch_cnt;
+
+	if (wr_ch <= 2 || rd_ch <= 2)
+		return;
+
+	off = start_off;
+
+	/* Write channel LL region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->ll_wr[i].bar = bar;
+		pdata->ll_wr[i].off = off;
+		pdata->ll_wr[i].sz = size;
+		off += off_gap + size;
+	}
+
+	/* Read channel LL region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->ll_rd[i].bar = bar;
+		pdata->ll_rd[i].off = off;
+		pdata->ll_rd[i].sz = size;
+		off += off_gap + size;
+	}
+
+	/* Write channel data region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->dt_wr[i].bar = bar;
+		pdata->dt_wr[i].off = off;
+		pdata->dt_wr[i].sz = size;
+		off += off_gap + size;
+	}
+
+	/* Read channel data region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->dt_rd[i].bar = bar;
+		pdata->dt_rd[i].off = off;
+		pdata->dt_rd[i].sz = size;
+		off += off_gap + size;
+	}
+}
+
 static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
 {
 	return pci_irq_vector(to_pci_dev(dev), nr);
@@ -120,9 +213,22 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	u32 val, map;
 	u16 vsec;
 	u64 off;
+	u16 vendor = pdev->vendor;
+	int cap;
 
-	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
-					DW_PCIE_VSEC_DMA_ID);
+	/*
+	 * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
+	 * of map, channel counts, etc.
+	 */
+	if (vendor != PCI_VENDOR_ID_SYNOPSYS &&
+	    vendor != PCI_VENDOR_ID_XILINX)
+		return;
+
+	cap = DW_PCIE_VSEC_DMA_ID;
+	if (vendor == PCI_VENDOR_ID_XILINX)
+		cap = DW_PCIE_XILINX_MDB_VSEC_DMA_ID;
+
+	vsec = pci_find_vsec_capability(pdev, vendor, cap);
 	if (!vsec)
 		return;
 
@@ -155,6 +261,24 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	off <<= 32;
 	off |= val;
 	pdata->rg.off = off;
+
+	/* AMD specific VSEC capability */
+	vsec = pci_find_vsec_capability(pdev, vendor,
+					DW_PCIE_XILINX_MDB_VSEC_ID);
+	if (!vsec)
+		return;
+
+	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
+	if (PCI_VNDR_HEADER_ID(val) != 0x20 ||
+	    PCI_VNDR_HEADER_REV(val) != 0x1)
+		return;
+
+	pci_read_config_dword(pdev, vsec + 0xc, &val);
+	off = val;
+	pci_read_config_dword(pdev, vsec + 0x8, &val);
+	off <<= 32;
+	off |= val;
+	pdata->devmem_phys_off = off;
 }
 
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
@@ -179,6 +303,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
+	vsec_data->devmem_phys_off = DW_PCIE_AMD_MDB_INVALID_ADDR;
 
 	/*
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
@@ -186,6 +311,22 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	 */
 	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
 
+	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
+		/*
+		 * There is no valid address found for the LL memory
+		 * space on the device side.
+		 */
+		if (vsec_data->devmem_phys_off == DW_PCIE_AMD_MDB_INVALID_ADDR)
+			return -EINVAL;
+
+		/*
+		 * Configure the channel LL and data blocks if number of
+		 * channels enabled in VSEC capability are more than the
+		 * channels configured in amd_mdb_data.
+		 */
+		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0, 0x200000, 0x800);
+	}
+
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
 	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
@@ -367,6 +508,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
+	  (kernel_ulong_t)&amd_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
1.8.3.1


