Return-Path: <dmaengine+bounces-6639-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70034B84B07
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 14:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386DE7C1E19
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 12:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377E03054DE;
	Thu, 18 Sep 2025 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h/czOYae"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB430506D;
	Thu, 18 Sep 2025 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200025; cv=fail; b=GnrH2E97UmNTI11XkilwK49DiVe+GTApI2RHGp30wDA67gPbWuHIb6YTXieTt54ngt8vxTe/WY2pTe5YmLKe9wDyKo6IK1iejZb+m+WfJTVDnPUI9M+hsufqQe9qGDbIM9bC1RiYdt4cvqVeoiFkBExZAHwdwDac1HRgHZED4KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200025; c=relaxed/simple;
	bh=SnGSC9XjhCZa10u0y8QI3FqlmwHD91ay2MFdTOBvGog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UesafLdBH3HNVQLUvnM5uq6o19jZLBg9NhY5/QhH0RnPctQmCx90NdzxX32eB2AshBGpkSBtkIUI/vbkFIPcOTZQl69dRjIanNWQ2d/Twl+sfZH/HmxB62f5A07IinwY/HJZAbWfsfP36cZoRUSph4+adpY83ixDy8j0Roo9DtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h/czOYae; arc=fail smtp.client-ip=52.101.193.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnrQ8QTpsoamLBnCXjngiDwjaptlU+Q4yl6b+Y2Dtq8scFFQp7KKk7E0LaM2bcKIMFPEtDDOFBogGNC4rQjOXWRtbl9d+GvOsrUV0RNnvITM29XDY4ibxoIPdqzSJXueN4fwsBfguOciikgxFzxP3BP0yM8LXH51/pZdytHnLcnMHB2T6/5WIdr8GoMmui4xlev/XggxJZr0BqjvzKH2iIlctSgdos8AvynOwN4nSbdpt/g/oE7jiuqmZS6XF6QOO6AKqT5AVvoWxNMb1VYn6W6GoHeAbbnTaubPYkhZyOmbB6qKjudTESgcUAxD6GQU3qJ07H9BJnlqvalzqfyEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heOMS7i/3gG4OkfAk5w1VnR3C4+ygFcKi+UVjbxsF2M=;
 b=uzfGoBv+lV6mIKei0e12pSjlMlcYGeAGbi8xOiQ3++jDeUcYVzCD4qz8uGDSW3xy7yK+b7a10irg2Ozgg5yLqaUmVdG3hkM/9cRXRSpairoiL6Z5lxfAh8mC4H5blGIoF/RWFilVYiHWREQvtSC1hejittRtAoujigtgFhBJnpd/GfH9wsOppGcptUJRnT6pUwPVtjyi7bq5A9vCn6iRPeqTOEk5CAnyrzYdZkHoja2obINO6dL61BThmgORWbLkS9HSVY9NU/+xCO6a3xQ1bJjxwNIrK6t2DTs7YEjYROZ1NO3Q5Q7sEi4G39nPP1SRi9o3t/ZOC1eid2EiluT/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heOMS7i/3gG4OkfAk5w1VnR3C4+ygFcKi+UVjbxsF2M=;
 b=h/czOYaeoKuahfl3BtllHoLA3d8tnLN3FiQWqGg0dyTAq6DALyUckiW2u+x3yv9lnYqNQTtT6kXT4UYygVPlpOAKyHeQre1H2GMQwmwtZqnfvyDr/IQ3+eBUUJSKGc1JxHdnVSuuDv146IU0+KH+IQrSJdRNTrBgPsvengmgK30=
Received: from CH0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:610:77::35)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 12:53:39 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::77) by CH0PR04CA0060.outlook.office365.com
 (2603:10b6:610:77::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 12:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 12:53:38 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 05:53:36 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 18 Sep 2025 05:53:33 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v4 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Thu, 18 Sep 2025 18:23:23 +0530
Message-ID: <20250918125324.26033-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918125324.26033-1-devendra.verma@amd.com>
References: <20250918125324.26033-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2f54ee-caa5-4131-f4fa-08ddf6b2637d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ec395btHV/amWMiopOrpLIqnVlUwwg3jXuXdRGGAZ3c22VXs2o2XHlE+FDBy?=
 =?us-ascii?Q?SSnZ8EcV64WAcwg1Vw+wq1anDaPzj0Czx40AQ0Q10vjIhpRIjcPTv9kkpS1I?=
 =?us-ascii?Q?VI7Ch+tMVNchEXrOylp9fb42iH2OLt4Jdn2g/19Iec93sLcvLKPGeWE4Cts9?=
 =?us-ascii?Q?/4E97qH55CIoOtJ9psxPy27Y/ZsfR5TlWFcv81Ot/M3XAZnRdR6wzycTFbE3?=
 =?us-ascii?Q?+FuphUbNAkl3p4j5gazZKz+CO6rw2MrDdNttx85GGb2UoualEkfJenlA8For?=
 =?us-ascii?Q?xble3f7ObxLgTs9rFK+ahGpP76mSrCtMTGkMuPfdxiitnA3zRQHQrDVjMYit?=
 =?us-ascii?Q?pBAJ1S8fZt/LJ1o43/74DgeYdk7a+gstfd9uVdHxDW1+kaRm+DNY5Vl5YVe/?=
 =?us-ascii?Q?ulo7wE1pNSRgClqbdxcsa1eUsMaLZUhPSSbAk7Frqo/N6nM5lEV3V+HVbc7E?=
 =?us-ascii?Q?TzWIkwpLESIquq9HsNfuk2Sw7kbxFRwQ6YvcBlYl2Mv8MZWKYv0rj4pS14VM?=
 =?us-ascii?Q?DueGrNuy5DUz67uMPdoW0MmX3ynRwQ6e6TcbVj/nPYp/eIDa7wS+2F6DwuZN?=
 =?us-ascii?Q?OSgmOQXPyPNLiwyjxxwW0Uf1tbsFR1Z6iki4DkvwJtaPWyn1xJwAfpSeP/lc?=
 =?us-ascii?Q?CADWq+RcoQRLkSMk6Sxng5YJ/bL+Gk9zIF+ZMxDpiF5Kc1O7LN/jNKcP00cr?=
 =?us-ascii?Q?rVSO00hKbXb2WAqHfxIFe1UXM+RGe5th12gxH1wG9X48qbUisVPvhvpijlnP?=
 =?us-ascii?Q?D3dFZhImsycli6rCCxh3YC3vEXmmIzoK1bAipjTCCQmFWDr2t5kZtKsM4l6W?=
 =?us-ascii?Q?ehoaGcq5zmiBM7AqSLKD6bpGj8dm5Ue0h+w8ccEShUhG36CbNJwo/9kogyyZ?=
 =?us-ascii?Q?miTX4qx25xhyEnhyZKpKFaDqINem3nnUNEPLjF2YimklJJq3QRCX5fWx7LCg?=
 =?us-ascii?Q?AOhpPasThQgIsqHXCzoPZZUJVyo/VCUw/90YMANeX6g5tJNyf2Aa+tqvjIlo?=
 =?us-ascii?Q?xvEyklAqH94CX/7xXMEJ6eO+cDTGWmoVWbLDSUFK7ruDR87ld0TXgI/YLXQs?=
 =?us-ascii?Q?RkxV4BKdbFN6GdyuQLZ83qO/fQkYSewiEd6fyCS+Ia3Jof09X7LCpkv/rxLR?=
 =?us-ascii?Q?RTy9IIeX12Srv+myVDXNOH63ePqbcCQsMx7ZxZvAjhVOq5xykdYSaWExrWGT?=
 =?us-ascii?Q?6tzyUHUdtFxM2BcIQXk2DMN7J02JAlnI4rQKsazzjEAu5Axxx5mAtwsWyMwa?=
 =?us-ascii?Q?BWDtHIFjyXQd/Vd4rw/oc898X0bBOxWGKiTqCnOHm3H6iniPkbPT4sEy+/ev?=
 =?us-ascii?Q?pIt3sam1977QPLkb7Rr7azJRRFC0OltKzCrethA+kH3K+xaZ5Ts91+SI3OLf?=
 =?us-ascii?Q?PZOdamCb+lyiVwUQJFFf2YpUskePeZUFw2m/VlQ+vKJEFrWZ7CPPbwDpDIMJ?=
 =?us-ascii?Q?BzOAqpmOnN/O6ar8QaDVLucY8t6bGNurETJILpzxrTE1S3h4brQECMQ3xLJP?=
 =?us-ascii?Q?TdXmEfytQkfXWceC2eGP0dzqs5pgd45q+UOf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:53:38.9491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2f54ee-caa5-4131-f4fa-08ddf6b2637d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
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
 drivers/dma/dw-edma/dw-edma-pcie.c | 130 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a7..b26a55e 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -17,12 +17,23 @@
 
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
+
 #define DW_BLOCK(a, b, c) \
 	{ \
 		.bar = a, \
@@ -50,6 +61,7 @@ struct dw_edma_pcie_data {
 	u8				irqs;
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
+	u64				devmem_phys_off;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -90,6 +102,64 @@ struct dw_edma_pcie_data {
 	.rd_ch_cnt			= 2,
 };
 
+static const struct dw_edma_pcie_data amd_mdb_data = {
+	/* MDB registers location */
+	.rg.bar				= BAR_0,
+	.rg.off				= 0x00001000,	/*  4 Kbytes */
+	.rg.sz				= 0x00002000,	/*  8 Kbytes */
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
+	u16 i;
+	off_t off;
+	u16 wr_ch = pdata->wr_ch_cnt;
+	u16 rd_ch = pdata->rd_ch_cnt;
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
@@ -120,9 +190,24 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	u32 val, map;
 	u16 vsec;
 	u64 off;
+	int cap;
 
-	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
-					DW_PCIE_VSEC_DMA_ID);
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
+
+	vsec = pci_find_vsec_capability(pdev, pdev->vendor, cap);
 	if (!vsec)
 		return;
 
@@ -155,6 +240,24 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
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
@@ -179,6 +282,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
+	vsec_data->devmem_phys_off = DW_PCIE_AMD_MDB_INVALID_ADDR;
 
 	/*
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
@@ -186,6 +290,26 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
@@ -367,6 +491,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
+	  (kernel_ulong_t)&amd_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
1.8.3.1


