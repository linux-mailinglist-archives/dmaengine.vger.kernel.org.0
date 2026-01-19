Return-Path: <dmaengine+bounces-8369-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A2AD3A282
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 10:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64E383057AD9
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 09:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC79433C1BD;
	Mon, 19 Jan 2026 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ERB0lvXB"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F46352F94;
	Mon, 19 Jan 2026 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813824; cv=fail; b=XvA3bpVY9YUGUj8LGS1fz6YL31/XSy7K9onas3K95/ZzPWYhK2l9tSCxOUwrVYvLF8ZZFIVg/wCBexndtJ0P1RKUsZdb0ubR26GViBRy4wbMWOJvH6JjXtxc/peojlAkIQ3WxGMezVTtb1Dmku2D8DE5MqHoWDJZvpoyaldek0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813824; c=relaxed/simple;
	bh=9LBOc+sAOSDRw0SXWcXVbDZDeX+rvXIFuY08k/mTWlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zyl45foAcMh6Q7IfPA6ikEVFaiPc6IoSiYbpUCRyOfwRuu8jhDFeZ5KxrDOilqrV5Limv5mulOgh0Zhv1pFexwrnySEXvEgVzBl63Leud9d7VhAGjDOljX0fiotH6a/RQxudUZlfvSb9jlwkIJXG1Bb+f5a1KEU/KijG81B5Rzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ERB0lvXB; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHPCIXgCmDVww56ZQhOcbKh2RJNItBxsdcDV7aum71yr9WkQP5wWL770FbXKM+uoglM+nd1Z5ve7yBR+UnlRoRCWzp+ZYBSf+Ou5XMjlmeSnJKuUwUlaZGAHYgpmBf+pDE0CR4tkDMt99TtYb68PjF59yzNLj8uef6JuxRz9z9m3jZPUz4+RERLelo6RPYnt+i3ndpvk7eFgUl64t+suoTx+uxEjXNdkzUjIYoweoc/xjgm7u5pM8un+SWWmvQ7OsdErmiFrja0ulN71mo8MM5H622e03y3qQG5sEqmFybmqz06JeamislBc63HY6HPTbUH5YmrwtbPOflKEE6F6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNJTVRBKqOlBNzBEnROYmHphNbPIp2Y4mhPg4DZzo/A=;
 b=D+SUuWUenZAkK+43Ao/NAeWlWZ3Mw8YDVP1aGN+7NaorQfzmRvR3vLO0lHZ+41RoyX1FFzzMFvaQEBiCLbUdlpgBrzHMimzkWOkbYU02IRcAI8e2ctmkRCbTa/m52ISjMyQDgA5AralHnnzDWZvfivRxGY0QNcwrY9+guFUiKAehig7m82BhYIMAHlSWbLESJ7o6v0seXPm8KxLvuA3Npf648XQrPaQOMs/QVZoynzZPFS+9NC/2wfmu/Rd34uDchn5E3bpG4117AOikxiJCVW64TCDhPayYvGq9/PuDF1klAZC0AZbMaDmkWLX+FPbluKB4aVR9u4nN3f6nvhXH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNJTVRBKqOlBNzBEnROYmHphNbPIp2Y4mhPg4DZzo/A=;
 b=ERB0lvXBL8+VgPO0etK8p0caWyzvsxnB9IRfzu7lH7XFVXlC1dpnYsVBLhsFpPsy+YwAQHJViwQLoRwc5FhKYozp+oLZ/HQdSviE/4CWyIXlqWt7au1ftxOwMbcniWF7POR7Nask1J500szn9Y0AUOBIIb30Uh0cBDDtAwtFgWM=
Received: from BYAPR07CA0043.namprd07.prod.outlook.com (2603:10b6:a03:60::20)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 09:10:15 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::b7) by BYAPR07CA0043.outlook.office365.com
 (2603:10b6:a03:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 09:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 09:10:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 03:10:14 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 01:10:12 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v9 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Mon, 19 Jan 2026 14:40:08 +0530
Message-ID: <20260119091009.70288-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119091009.70288-1-devendra.verma@amd.com>
References: <20260119091009.70288-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb6fbe2-01e3-47a5-39a8-08de573a8f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4KS6CuvCwpDpy3W0S9XUniGuHiM6LJo+oeV1LsLb/rBaOUy2rrYOmYZCZo0j?=
 =?us-ascii?Q?T6mJvgquklph7I5oJvDqsmtwbDyOkoLu3t8fnHiitd+TCB1qExR0qf9CeZgf?=
 =?us-ascii?Q?Fidp/ueUn6goXjF58oL/pNFJ/jX+gkHkOGH2QfKwaJiKhxhjw5X4bJp79eRL?=
 =?us-ascii?Q?ApPCvDhk3ADx1yjrRVfmPW2nUpXUeZnmNeuZA5fTSEA24zGLcKP/R/WTqT7x?=
 =?us-ascii?Q?KW9ytXfaOZklSQMU26jItIeE8/VvnRoeg12lA+1kmY7pecRo+Uis7iNthkj2?=
 =?us-ascii?Q?mCLsKwn2jj674ci85sDBiR8CCzrb31d+FYTcqyRRl58DyanHsIGwPPUFtpih?=
 =?us-ascii?Q?Xvnsqfw69QAb5GE8THXyhpRHHfFd8bVNKK7aOqKY4+FkDZhdit0l5X1OFI4P?=
 =?us-ascii?Q?QI7iex+SkoRq98AvkGzbcez49qmd3+sEsj9v7hxUiyuqpZkhech8h51tqOXr?=
 =?us-ascii?Q?wBMmXgRmh5drbAhanuXVzuryBgaHmo52zkNr9IhhWICO37xgl4B4XuIXIl4a?=
 =?us-ascii?Q?1DigcxT1JBzA7kFH3+dZaS0AvCorlvbK6mz+HOOAx6WhPKYGv09i7ftMqnPy?=
 =?us-ascii?Q?WdzaepnsjApM8N36aYjaFi8MJyoyXzSg73LtJ+GvVYOSeYd+AG5TU4Y7SJ41?=
 =?us-ascii?Q?nBvRJFehXipyrGth2Wo6komNtFkCG+WkrJpXgoZGfGiMixJP1OR6YGJZ72tL?=
 =?us-ascii?Q?6x4uFPZC9zbFffGCa3oZLA6HrREci5fQ+A27XYNFN9/e3EERs1aVlSHun/vH?=
 =?us-ascii?Q?ov0f6CvnDPEd+GkJ1imnCawLpNYu1YuRZ6+G+thbsWEAKZ4+RWMDkGFtzq84?=
 =?us-ascii?Q?FPIMQDyASdAwfcyxLDPSAJ7KYcwfLJLbCt36y0rKTlMSs3KhxlAPM7rgS9C6?=
 =?us-ascii?Q?Q/UCCWUGgoYd4qnNSDE0biV2Aug4jSvDnJTIK5GBxxA8MoO96P/AtKeW2XMV?=
 =?us-ascii?Q?emCpib9KfLbYnu2mlfGkTVnFbI2dRHrAZctL+9nQhrKtdfJyAVs5oKOagUWg?=
 =?us-ascii?Q?Dwiko4rrt0Iv/Cfq9fsmB7UKndI3nYhTcnlhcGDtwXnOF9EGZPyg5ZV6YwPm?=
 =?us-ascii?Q?yModeuA6QDjmQJmxoEQFizGwS8l0muiFV8nVpZrpBKCBWBWyOfoVdOkVSpVv?=
 =?us-ascii?Q?WsXmA5JfDpJk2XCBY+c+TPMfGO5llcKnlkTdi2KY6VlHCb/62nSYaoIkNNrI?=
 =?us-ascii?Q?uE0YMhi7ORGqC6Dv4BRyMrPnfzDcyyMUCSlYi32N5qPDl5WThjsmx1M9y8Tr?=
 =?us-ascii?Q?H8gf+COm4bMLPJk6nXUJh/f/ftGUxBLJA0K2gEPw3rzkarWKuhwh5IfTsTgO?=
 =?us-ascii?Q?Q5HDT8UWOt/9BJcp6KTVkJy/rEMTUadSax3VVnnDAOFcK18aE5yCQ1rVdYNT?=
 =?us-ascii?Q?PM5oExHKaJlub6Jop5KnptS06Il5ZLCCPoWMkyp+itn8VaJrqeLltvZgqeJs?=
 =?us-ascii?Q?BQ/aV+uUIHGWhkKvr2J2MP7W3kcvY0qGb0O9ATEpYcntyP1/RLiPaKXKjsdD?=
 =?us-ascii?Q?0uWVgmiQiuISK+lHUJJmlXioItAn7bcBmHBIzOJeHWQ7tBSFd2qkBgaUhN1q?=
 =?us-ascii?Q?TphPvWHbWkkM+ENlnrcGihmeYgKf6OR8WjAhYQr+XRMcPBdBa3LBcdwhN+oa?=
 =?us-ascii?Q?xd/iz270iMKXc8QXm5qEUDJItUP+Gh4iM1RLR7DA43MG/H3wYAp15Q/p9k3G?=
 =?us-ascii?Q?fLXyoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:10:15.4791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb6fbe2-01e3-47a5-39a8-08de573a8f36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v9:
Moved Xilinx specific VSEC capability functions under
the vendor ID condition.

Changes in v8:
Changed the contant names to includer product vendor.
Moved the vendor specific code to vendor specific functions.

Changes in v7:
Introduced vendor specific functions to retrieve the
vsec data.

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
 drivers/dma/dw-edma/dw-edma-pcie.c | 193 ++++++++++++++++++++++++++---
 1 file changed, 179 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a76d3c..76fedeb1ec8d 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -14,14 +14,35 @@
 #include <linux/pci-epf.h>
 #include <linux/msi.h>
 #include <linux/bitfield.h>
+#include <linux/sizes.h>
 
 #include "dw-edma-core.h"
 
-#define DW_PCIE_VSEC_DMA_ID			0x6
-#define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
-#define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
-#define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
-#define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
+/* Synopsys */
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_ID		0x6
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_BAR		GENMASK(10, 8)
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH		GENMASK(9, 0)
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH		GENMASK(25, 16)
+
+/* AMD MDB (Xilinx) specific defines */
+#define PCI_DEVICE_ID_XILINX_B054		0xb054
+
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
+#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
+
+#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
+#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
+#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
+
+#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
+#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
+#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
+#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
 
 #define DW_BLOCK(a, b, c) \
 	{ \
@@ -50,6 +71,7 @@ struct dw_edma_pcie_data {
 	u8				irqs;
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
+	u64				devmem_phys_off;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -90,6 +112,64 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	.rd_ch_cnt			= 2,
 };
 
+static const struct dw_edma_pcie_data xilinx_mdb_data = {
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
@@ -114,15 +194,15 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
 	.pci_address = dw_edma_pcie_address,
 };
 
-static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
-					   struct dw_edma_pcie_data *pdata)
+static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
+					       struct dw_edma_pcie_data *pdata)
 {
 	u32 val, map;
 	u16 vsec;
 	u64 off;
 
 	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
-					DW_PCIE_VSEC_DMA_ID);
+					DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
 	if (!vsec)
 		return;
 
@@ -131,9 +211,9 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	    PCI_VNDR_HEADER_LEN(val) != 0x18)
 		return;
 
-	pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability DMA\n");
+	pci_dbg(pdev, "Detected Synopsys PCIe Vendor-Specific Extended Capability DMA\n");
 	pci_read_config_dword(pdev, vsec + 0x8, &val);
-	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
+	map = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_MAP, val);
 	if (map != EDMA_MF_EDMA_LEGACY &&
 	    map != EDMA_MF_EDMA_UNROLL &&
 	    map != EDMA_MF_HDMA_COMPAT &&
@@ -141,13 +221,13 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 		return;
 
 	pdata->mf = map;
-	pdata->rg.bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
+	pdata->rg.bar = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_BAR, val);
 
 	pci_read_config_dword(pdev, vsec + 0xc, &val);
 	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
-				 FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
+				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH, val));
 	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
-				 FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
+				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH, val));
 
 	pci_read_config_dword(pdev, vsec + 0x14, &val);
 	off = val;
@@ -157,6 +237,67 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	pdata->rg.off = off;
 }
 
+static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
+					     struct dw_edma_pcie_data *pdata)
+{
+	u32 val, map;
+	u16 vsec;
+	u64 off;
+
+	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
+
+	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
+					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
+	if (!vsec)
+		return;
+
+	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
+	if (PCI_VNDR_HEADER_REV(val) != 0x00 ||
+	    PCI_VNDR_HEADER_LEN(val) != 0x18)
+		return;
+
+	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
+	pci_read_config_dword(pdev, vsec + 0x8, &val);
+	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
+	if (map != EDMA_MF_EDMA_LEGACY &&
+	    map != EDMA_MF_EDMA_UNROLL &&
+	    map != EDMA_MF_HDMA_COMPAT &&
+	    map != EDMA_MF_HDMA_NATIVE)
+		return;
+
+	pdata->mf = map;
+	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
+
+	pci_read_config_dword(pdev, vsec + 0xc, &val);
+	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
+				 FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
+	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
+				 FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
+
+	pci_read_config_dword(pdev, vsec + 0x14, &val);
+	off = val;
+	pci_read_config_dword(pdev, vsec + 0x10, &val);
+	off <<= 32;
+	off |= val;
+	pdata->rg.off = off;
+
+	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
+					DW_PCIE_XILINX_MDB_VSEC_ID);
+	if (!vsec)
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
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -184,7 +325,29 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
 	 * for the DMA, if one exists, then reconfigures it.
 	 */
-	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
+	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
+
+	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
+		dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
+
+		/*
+		 * There is no valid address found for the LL memory
+		 * space on the device side.
+		 */
+		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
+			return -ENOMEM;
+
+		/*
+		 * Configure the channel LL and data blocks if number of
+		 * channels enabled in VSEC capability are more than the
+		 * channels configured in xilinx_mdb_data.
+		 */
+		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
+					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
+					       DW_PCIE_XILINX_MDB_LL_SIZE,
+					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
+					       DW_PCIE_XILINX_MDB_DT_SIZE);
+	}
 
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
@@ -367,6 +530,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
+	  (kernel_ulong_t)&xilinx_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
2.43.0


