Return-Path: <dmaengine+bounces-7280-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D77C78D3E
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 12:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EFB03629DA
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA534BA42;
	Fri, 21 Nov 2025 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dSwwSi2D"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED834B682;
	Fri, 21 Nov 2025 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724911; cv=fail; b=Gw7tfMXFpI8lTUNnt64olEWowhqWG77Cqn1iQmY6EnLbb2RAjNsSDkrFN+HCNU0LYI5DghEUHEMKSXXkkBHpuX7EkjEOjlfvnE/1xuwHTMahsYaOiz6Kgdlu0d/m0LiFY2GXxPsUmjOV9pwyZWngeuDi0cNefXlkd4Vxzmm7kKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724911; c=relaxed/simple;
	bh=R6BJVuyHpgoouVK3pXMp/EJMBW7SYfRMN8iVzuvkRTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VW+3zwdjR6xsq9+Ri0yqcGodn+kUeY/sG2E8kcoxFombYOUWKZlsMCEF/VZJszUYl0HCmxdz83Rt761PLHbfI04xKr+cHHB0cQI6gblEgreuZ9OP+1TqfnInu06NPRIThOD82ZlFUw2C6BouHsaYraUPOTCm8kmxOfyrBTwiMYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dSwwSi2D; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yyzq4fiqfyHJnaI6iMJFc1bZR2wZU528zYhK6bq+HB/ctA84kqoQPDuBw9kZAdWlXr5xfdIEsQpU9sp4MGV1oN4olezOxwo4v2X7cFuwsAnniSQpdII+saHWVLXmQUkqVZlJabZY17cqZLBioxYLFHPdQhdGVuqA4TYGMnRLS5tKNCHdHIVazY3oELREHLrj+mHn+vbYcSVhAYI0LlqZqFGP6wVTu2fuIn8BQOn/KEP666ek84haZCKYMA3jpj3qgBc8q8ydf5bAq98A55ySWNW206EDwq9xOak0rIrxJDp6rN4BK2n++7tcdG4xD1qfN8f9XtCQbc4k63p5Pmsd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WeqNIMuEs/hDIwLznHphFUBkfZX3rHv/Thn+DzGFXo=;
 b=dQPXEasHzIkOqA5CQNZpGn2vdNGL5s0ROn9SMA6FZ7QAPls0SIzdxe5BYBm7va9n1jxDhW08xzYmjU42h/BXHtj3jTVEDuKR27o37YmX6z94SGZ6JE8ReKKLOfhc4VuhPreG6lPClcOu7UFIqVxPXss1VjqNKMKfDGcaJAF1a/HGMTPVyFJNhJhOCzgfJf+s+B5t6Tckf3ZANfGMivL6DTYpztGlxJkjeKnJdxULP/hHYLmAr1OijroRC2jjVPc4UZXAIx+1HVG+VZWM7ugo91YbS7Mqxc6CIzGQpHXpmJl4y3ABtxOUYVAA7Zd6MaGZ7MFjNgCif47Jzd7V5O2bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WeqNIMuEs/hDIwLznHphFUBkfZX3rHv/Thn+DzGFXo=;
 b=dSwwSi2DswoRJniRIszMuB0UhnilbQ/G2zIAui0LALeE2iozlHNiIuYGnrIu9TdQ4Wi+y0t1b3lsvgiMHdOv3ci1x36zmsgwXzVVPfmJmxWnzP2GGUfVWOd7vqOpQI8oZerCaAlgqbVMgREvauxB43i7hjYViQLVtoOic5aNdcY=
Received: from MN2PR17CA0036.namprd17.prod.outlook.com (2603:10b6:208:15e::49)
 by BN7PPF28614436A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 11:35:01 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::41) by MN2PR17CA0036.outlook.office365.com
 (2603:10b6:208:15e::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 21 Nov 2025 11:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 11:35:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 21 Nov
 2025 03:35:01 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Nov
 2025 05:35:00 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 21 Nov 2025 03:34:58 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Fri, 21 Nov 2025 17:04:54 +0530
Message-ID: <20251121113455.4029-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121113455.4029-1-devendra.verma@amd.com>
References: <20251121113455.4029-1-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: devendra.verma@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d94c021-bb80-41e9-7a39-08de28f2022a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8XH2DfD+lWvA8YppKnOwLBf1XylUkX2HRUYenU3bOHiigqNYKgj+oQh3h5Hf?=
 =?us-ascii?Q?z2Upt1lRyAq/GpMUdvVx1Bq84E+aDZy0iUW2O7f9SVcQA88z8yErvci1nSSA?=
 =?us-ascii?Q?cu6wmCO9QkmqBTBkjksow/C3eBgLepXjnW8nkZe1ff6fc2CGIxJfM0Z3rHXi?=
 =?us-ascii?Q?WAktKUAdbIi8XJuqyhXVFLRY7hs1BsshS8vCIyBgN1CBx6nNx6i6mWlrur+t?=
 =?us-ascii?Q?0r0jrX5bUocn1riplNoaVPgeWzA6a4aWyonkL7GOCfHuO60EnXLqrCFS8VKU?=
 =?us-ascii?Q?gp/CAJidrkQ5HX5SYu+r5xAdrwdrVDi43G6EAJxJg4U7sFx5JOStqd6iSVre?=
 =?us-ascii?Q?a8OPBWiPN7IMsxIaJcy6so791pNPh3JnDYOZbIa5VIJabtvBGpI4eAYJz5u8?=
 =?us-ascii?Q?wDNY3t7GrQbtLSufLDCNoRcdCZ22CDOJzt+8K/YJ5hZx6jp0fQ/VYC4G7KcD?=
 =?us-ascii?Q?INf++HA2BmxDn/aFhDFvCNKM3Pl3CtYmfuywj2fJ5kmCrgKQEvWufXOHaV7K?=
 =?us-ascii?Q?azA6Hqg1AFT2ma7SJ7Ps+m4zyIZdkpxzyBO/qKkwKfImmevx6SRb85Afw24N?=
 =?us-ascii?Q?6FHfQuuSXu5MQWiEJZRmjZpgPpj7U1ONYg0NDy0n6PILZFEZphyKHmgq4PHP?=
 =?us-ascii?Q?F7c4JJ3Va5E2TMBpEamc4rnG5bFT+zzXAVAOA+TF8QcK8EpiNjRneAWRX+xa?=
 =?us-ascii?Q?QzaxAUnVjl7WTO7XsGPnJUITS5JPkcVCD7pshjf+lZJFDVHg5JaySM5pZcxp?=
 =?us-ascii?Q?RzwrqTIZhOF/cBdrNHsN0k+17xE64KM+2ZcUHe78QepvjphtP8AhVAyvMs4l?=
 =?us-ascii?Q?dUhykv4lLY526ge4XHzztBui2SuOTlxTCbxsIMPMqKj/53EBfg0By1r0+hIb?=
 =?us-ascii?Q?c8+okIxXdPI9ifTBHQzACyL+RKPV2D25yG1Y2BYhh0O+sO0j2eQJ74nqziZA?=
 =?us-ascii?Q?2Qo4nNADVztOp9Q+IpDk6HEB3VNfKJKyUISmh/a7a21F7PVY0dYQXomp/a33?=
 =?us-ascii?Q?sq+sYylckXvzs9XqqgEacwpw3yR4xz4SzzFVFh5+LRQQ9lau6zEYpz/C04wP?=
 =?us-ascii?Q?JRaF4x5RwtzbB7eV5PCL/tiMZ6V0njt4pKznmGrcAdY4ivk7spQJDqcjap76?=
 =?us-ascii?Q?UJnaWMHViiA9QFJvgAKXksgkbDaB6LCKTraMP66LDwwymKI57UZp48+jrY/g?=
 =?us-ascii?Q?DW0toskXpw4TYIW5AayTPzw9n+aFWjoYlOiSqlAR8OUbP4279hnlADIa5Wuy?=
 =?us-ascii?Q?EwnS7gEDQhRBFALHVXjAz9ESXaEiiGEr3EsrGoEeoyTRXyEqUnPFxDYeklAD?=
 =?us-ascii?Q?kNE5pcedFqvPf6YNqlFXNqAkIPWvX9mm3VqPjRnrmCIhPVYcdAypjJ8LrACh?=
 =?us-ascii?Q?58KK7UZRVKoWKSo+SdFMhUB+lg1HzvDfmYfXU8ggcOet7j0QkWBXUoUv0/Qs?=
 =?us-ascii?Q?3wlz7O5NpJAfq/ueEd6cinOpScjHugnH9yztXokCgfwUJNPpmJQcYsLUZnET?=
 =?us-ascii?Q?UDDkM7sZzwQg7QJZES9kILTCJst6W0QQP5Uv5zyI0/SxcpBDJ7SqcIMD6eBN?=
 =?us-ascii?Q?C9wAX826k2a751qg+oQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 11:35:01.6264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d94c021-bb80-41e9-7a39-08de28f2022a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v6:
Included "sizes.h" header and used the appropriate
definitions instead of constants.

Changes in v5:
Added the definitions for Xilinx specific VSEC header id,
revision, and register offsets.
Corrected the error type when no physical offset found for
device side memory.
Corrected the order of variables.

Changes in v4:
Configured 8 read and 8 write channels for Xilinx vendor
Added checks to validate vendor ID for vendor
specific vsec id.
Added Xilinx specific vendor id for vsec specific to Xilinx
Added the LL and data region offsets, size as input params to
function dw_edma_set_chan_region_offset().
Moved the LL and data region offsets assignment to function
for Xilinx specific case.
Corrected comments.

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
 drivers/dma/dw-edma/dw-edma-pcie.c | 139 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a7..3d7247c 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -14,15 +14,31 @@
 #include <linux/pci-epf.h>
 #include <linux/msi.h>
 #include <linux/bitfield.h>
+#include <linux/sizes.h>
 
 #include "dw-edma-core.h"
 
+/* Synopsys */
 #define DW_PCIE_VSEC_DMA_ID			0x6
 #define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
 #define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
 #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
 #define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
 
+/* AMD MDB (Xilinx) specific defines */
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
+#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
+#define PCI_DEVICE_ID_AMD_MDB_B054		0xb054
+#define DW_PCIE_AMD_MDB_INVALID_ADDR		(~0ULL)
+#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
+#define DW_PCIE_XILINX_LL_SIZE			0x800
+#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
+#define DW_PCIE_XILINX_DT_SIZE			0x800
+#define DW_PCIE_XILINX_MDB_VSEC_HDR_ID		0x20
+#define DW_PCIE_XILINX_MDB_VSEC_REV		0x1
+#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
+#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
+
 #define DW_BLOCK(a, b, c) \
 	{ \
 		.bar = a, \
@@ -50,6 +66,7 @@ struct dw_edma_pcie_data {
 	u8				irqs;
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
+	u64				devmem_phys_off;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -90,6 +107,64 @@ struct dw_edma_pcie_data {
 	.rd_ch_cnt			= 2,
 };
 
+static const struct dw_edma_pcie_data amd_mdb_data = {
+	/* MDB registers location */
+	.rg.bar				= BAR_0,
+	.rg.off				= SZ_4K,	/*  4 Kbytes */
+	.rg.sz				= SZ_8K,	/*  8 Kbytes */
+
+	/* Other */
+	.mf				= EDMA_MF_HDMA_NATIVE,
+	.irqs				= 1,
+	.wr_ch_cnt			= 8,
+	.rd_ch_cnt			= 8,
+};
+
+static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
+					   enum pci_barno bar, off_t start_off,
+					   off_t ll_off_gap, size_t ll_size,
+					   off_t dt_off_gap, size_t dt_size)
+{
+	u16 wr_ch = pdata->wr_ch_cnt;
+	u16 rd_ch = pdata->rd_ch_cnt;
+	off_t off;
+	u16 i;
+
+	off = start_off;
+
+	/* Write channel LL region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->ll_wr[i].bar = bar;
+		pdata->ll_wr[i].off = off;
+		pdata->ll_wr[i].sz = ll_size;
+		off += ll_off_gap;
+	}
+
+	/* Read channel LL region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->ll_rd[i].bar = bar;
+		pdata->ll_rd[i].off = off;
+		pdata->ll_rd[i].sz = ll_size;
+		off += ll_off_gap;
+	}
+
+	/* Write channel data region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->dt_wr[i].bar = bar;
+		pdata->dt_wr[i].off = off;
+		pdata->dt_wr[i].sz = dt_size;
+		off += dt_off_gap;
+	}
+
+	/* Read channel data region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->dt_rd[i].bar = bar;
+		pdata->dt_rd[i].off = off;
+		pdata->dt_rd[i].sz = dt_size;
+		off += dt_off_gap;
+	}
+}
+
 static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
 {
 	return pci_irq_vector(to_pci_dev(dev), nr);
@@ -120,9 +195,24 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	u32 val, map;
 	u16 vsec;
 	u64 off;
+	int cap;
+
+	/*
+	 * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
+	 * of map, channel counts, etc.
+	 */
+	switch (pdev->vendor) {
+	case PCI_VENDOR_ID_SYNOPSYS:
+		cap = DW_PCIE_VSEC_DMA_ID;
+		break;
+	case PCI_VENDOR_ID_XILINX:
+		cap = DW_PCIE_XILINX_MDB_VSEC_DMA_ID;
+		break;
+	default:
+		return;
+	}
 
-	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
-					DW_PCIE_VSEC_DMA_ID);
+	vsec = pci_find_vsec_capability(pdev, pdev->vendor, cap);
 	if (!vsec)
 		return;
 
@@ -155,6 +245,28 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	off <<= 32;
 	off |= val;
 	pdata->rg.off = off;
+
+	/* Xilinx specific VSEC capability */
+	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
+					DW_PCIE_XILINX_MDB_VSEC_ID);
+	if (!vsec)
+		return;
+
+	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
+	if (PCI_VNDR_HEADER_ID(val) != DW_PCIE_XILINX_MDB_VSEC_HDR_ID ||
+	    PCI_VNDR_HEADER_REV(val) != DW_PCIE_XILINX_MDB_VSEC_REV)
+		return;
+
+	pci_read_config_dword(pdev,
+			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
+			      &val);
+	off = val;
+	pci_read_config_dword(pdev,
+			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
+			      &val);
+	off <<= 32;
+	off |= val;
+	pdata->devmem_phys_off = off;
 }
 
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
@@ -179,6 +291,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
+	vsec_data->devmem_phys_off = DW_PCIE_AMD_MDB_INVALID_ADDR;
 
 	/*
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
@@ -186,6 +299,26 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	 */
 	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
 
+	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
+		/*
+		 * There is no valid address found for the LL memory
+		 * space on the device side.
+		 */
+		if (vsec_data->devmem_phys_off == DW_PCIE_AMD_MDB_INVALID_ADDR)
+			return -ENOMEM;
+
+		/*
+		 * Configure the channel LL and data blocks if number of
+		 * channels enabled in VSEC capability are more than the
+		 * channels configured in amd_mdb_data.
+		 */
+		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
+					       DW_PCIE_XILINX_LL_OFF_GAP,
+					       DW_PCIE_XILINX_LL_SIZE,
+					       DW_PCIE_XILINX_DT_OFF_GAP,
+					       DW_PCIE_XILINX_DT_SIZE);
+	}
+
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
 	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
@@ -367,6 +500,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
+	  (kernel_ulong_t)&amd_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
1.8.3.1


