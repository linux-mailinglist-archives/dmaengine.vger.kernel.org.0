Return-Path: <dmaengine+bounces-6844-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E53BD94B8
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 14:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 738324E2B5F
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040D431353C;
	Tue, 14 Oct 2025 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s1S8138u"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6E29DB88;
	Tue, 14 Oct 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444213; cv=fail; b=oog5v1PBK7ZGRm0iRCdbvcwoxPc+1kJYLePUSIcswQKDz/t4ECT1oPiLeFA7EJ9+azqa2q/d7ZrmzmLGk0RQz67+rJte3v6h49O9pkh4dlu5ZLzG2eWq+3NG7PtaE3APwvIImlwLE/eD8Tssi75qe9wYn6v5paC77L2e8dzP/Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444213; c=relaxed/simple;
	bh=SnGSC9XjhCZa10u0y8QI3FqlmwHD91ay2MFdTOBvGog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djhtfImlzT6X7U7NiMmHN4/OzhjrUHlHwRvSdkDd++bgiZiBcBxBUDuTvaacKkjc5ikg/9PxAjSkx5hf7yAY80DAwHimcnfftaIoRitJqJOfhTh/TlDJ8NsOM3aZD22qDZfqicAV1dr824TwyZRxfNYt5K++49pTQREfw3XN20A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s1S8138u; arc=fail smtp.client-ip=52.101.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kfk2bve5aabN6JNSCKkkYPszj0N3bkR8xZEz23sTBRRr+sVC+y3vcGFmhgJ+buF3FwynAZ2Xy/WksF/QXEejzZLiJTiZ1gJmCRgFC211CouK6yk+MyAgJyTN20w9Cf1IUxPkKlutnTBBxd2l9NGXb0ziKjCv9fntwIzgaSJX01vL2VOatHdWFerilgFWONMF/wQxSceeLOE1/uZWDHWlwXg2LhBlSP4mdmN0DTYIBQsxz0Z8yxYxMtth4gA4av+peczVMT3IuPYVJz04/KBlukYQr/STaeFU9aWguFfCrppB8uhxo4TAZ5lz480Hw49zsxPGK7aUHJQugMM9qhpvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heOMS7i/3gG4OkfAk5w1VnR3C4+ygFcKi+UVjbxsF2M=;
 b=LLoWlpZyQZ5UOD39wfyAuChHwBrsfYmK7jcMvLPwlNI62KG4tIc64/z//NV62jPhZ8ZGuSxFftOP9BvE9d8oPi/G2iOLgxv4CeDOHSA2f4N1IYngTUemEodZhrAGop7vaNQi1rYgVI+vWUDgVXwmU/qOA591X1tIvfVuweGNvO8sciUGcaV+Sm6aTiZoiAfcIc4rfWpjhInHocWsHpLEkgUsijrxVWomGnCA73UeIR4TqhDfywGXbbOBpbc2XvTxGou1Mp3+7697gXeYaeCxinnB3UR+EaOKayfJW8Ln/AtMkbFnv+pp1BK0Hqld1GcDsVsxVJS0f3md1NRlxGyigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heOMS7i/3gG4OkfAk5w1VnR3C4+ygFcKi+UVjbxsF2M=;
 b=s1S8138u9c9mnS2DpA02k7fD1P4rf4P3S+SesJ5PTnsDe2fSo1+toqGS5CxvAWvamVZP6OgVC/R8lOZIeeWaRMtoVNOZNw2dzprzPHgMJ8GVPOLrdXXrkts4V+EKI2luay1Q/eZlVzuZ9aDwOhFmzRJLBj5HRPeRLbVl7nJHJ6A=
Received: from MW3PR06CA0008.namprd06.prod.outlook.com (2603:10b6:303:2a::13)
 by IA0PPF002462CFE.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Tue, 14 Oct
 2025 12:16:47 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::97) by MW3PR06CA0008.outlook.office365.com
 (2603:10b6:303:2a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 12:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 12:16:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Oct
 2025 05:16:46 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Oct
 2025 07:16:45 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 05:16:43 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<devendra.verma@amd.com>
Subject: [PATCH RESEND v4 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Tue, 14 Oct 2025 17:46:33 +0530
Message-ID: <20251014121635.47914-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014121635.47914-1-devendra.verma@amd.com>
References: <20251014121635.47914-1-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: devendra.verma@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 15714c38-52e8-426e-bf2d-08de0b1b8bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dpsBpIomeuHZfBnuiOeyCZ5ifI1P0BYnOQLZ/hquxbZ4WwXxjET1fsMB1cQ2?=
 =?us-ascii?Q?Mxsx4Brf4ZpKSqbdjlKHwt5wssITwpb7UrMkglFmYt7MRfCf9FRmMYh3rIL6?=
 =?us-ascii?Q?1iny5sP253pOQ2htOL89YUs1jq0Tkfv37wW2pyRti7PmZhSuoIJSu3kqEaSM?=
 =?us-ascii?Q?yfoIWLsdQz7ZPeW0idtLbRXnhDcOR0hp93Pe3B5zKkfpbPsrPsS3CCHhkGDU?=
 =?us-ascii?Q?PfM8Tr619C2T9P43G6Jvt1KR90VcuhvqkSAwKw6kjrZUNTbsz3ZGcXCmkzbf?=
 =?us-ascii?Q?mhagMsJl3+9QO+YJHry3UQQoikV6Ff4UeZjuBjl+BjSHw6nrGWOSZL3Qmqcj?=
 =?us-ascii?Q?IEs70WLkZmvYzUQWhNIpwJQ75OrtpzxkfwTvHbO2gNtymxTuYKTEW3zkz6UR?=
 =?us-ascii?Q?08iSqf2Aft2u7BfgqftElduoUdU7qCXAdwn3xm/ATL3jZy1KLDabGfiv/wY3?=
 =?us-ascii?Q?tJIl6jau5kk1o9yf6K3DaeaoxCtUI4+55z0T48Oa0SrgPrM5H6YstjoMZahp?=
 =?us-ascii?Q?667G0gPVNDyvFE+q39UuyokTzje/QPc90coPLVUHn96AV52wygLFcxapMD4i?=
 =?us-ascii?Q?VYrffeJDiWSmKB8+TZYbIB72qmkMRY0ZdCivC6WdNqt3rFdfmo6CrQtXsDwd?=
 =?us-ascii?Q?i6P0Cv5Ytc9Cp8v4A7WhyUFNzNdwyq71Ys8idrxVSbpsHNgkEJ3kXwGQQSl0?=
 =?us-ascii?Q?T51BDcmYRHP+9Oblox0ImUbGEwT9vF2HaPCa3vxw3lc6cm0dj/eMukahqOX6?=
 =?us-ascii?Q?cbLQLR/RCAsVyimLgtLAAaRi0SzbLS9fUKlgMEU8SnOF147tViKMkgEf5Spx?=
 =?us-ascii?Q?UsAgOCuGIS9+liw6aU4vwQjK/FWD8j5CzcnAw/uW6JB2x2iCkuO/UPo0M2aU?=
 =?us-ascii?Q?9EHridYxAtswLmGUJ1fR/9Pb9YMNUfO4rGXyeuW/OpFffrKsY5ZxFyov6O68?=
 =?us-ascii?Q?GoCu7Kdr+U7LB/V3Dr/1XYhCXHYhEEHk/3rjIPUIwdWirUQkUTqppynOSmIn?=
 =?us-ascii?Q?RaSgSTlzKcz8kCk3x3/M0wFSAFE1YlkQ1ncn5gJ910EZsFUm6nxtvMJrLNnn?=
 =?us-ascii?Q?drQCdIuzLLhuFOevt8vZciupsSQNA06GfJjHpw/j+oDTFCzMt/QG39dYcuFp?=
 =?us-ascii?Q?UxTERPUIG+xhZJJbTCmq0v4s+T4ePXuy50DTP5cTOy0CVEivrSyHxEYo2lSB?=
 =?us-ascii?Q?ZGKwvMhdaYkbdXbeyqfCijLqXf1eZQeJhrtGJFynOyA+dKRlvlKL1TMwhpzl?=
 =?us-ascii?Q?J91npdrsuiqEjPJJRUeR7vPJScX3F8cjauKUdKKegsu4r/dgdbnjdXkh3yy8?=
 =?us-ascii?Q?loa8EHJaUJq51rjTevvWB6KJFwV02j/7F1LOt50L55jNtVCS+/hPcDEARp/c?=
 =?us-ascii?Q?tGKBT3CZUVFqRbBxcHsAodO1DdtE86OXZAeJJ3fZSylV9ZEWLZ/FelKc7KjP?=
 =?us-ascii?Q?s2BgShsZnm8lJBO8st1ZYJkxmT3OH9bvuHPE81hZ0mI+Aj1+0rIwE9KvOrUh?=
 =?us-ascii?Q?5FNw/3yk6W23DvzSG2gBzANnxW7UyskeMOclv7Tg2havhkAjl3x+uc8bB6T4?=
 =?us-ascii?Q?b6i4IXj/Z7t87QUqeHA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 12:16:46.7822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15714c38-52e8-426e-bf2d-08de0b1b8bb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE

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


