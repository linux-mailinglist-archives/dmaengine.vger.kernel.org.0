Return-Path: <dmaengine+bounces-7017-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E890BC145D8
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 12:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3EE5E78E9
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4513D30ACFD;
	Tue, 28 Oct 2025 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h/f9Ss/C"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397B3093D8;
	Tue, 28 Oct 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650952; cv=fail; b=Ck0yC/4IZElAyK/nUc3qqW1wexZJX9DlLgyHMCmXTxytgSTt+6NNyDXvYU97NwQ1eyNPcrjqsStABtE54pyFyaHyJx5UTgoOupslAYRvuAWRellp0ZYMo82GcOaNBuytuZSd1UWOqZcK2go/vpDlMBH/jzC3N/5HJV7mHholkDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650952; c=relaxed/simple;
	bh=OYjmsxGjVGpRpTGbZ0wrFfci6lHlVN900LiflHjOvKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYFfX6UAw8TrZFlp+8YH+zc8SppKPPAcYXsZSoxs39TCF1kpmx99g1k9ZoXB4WHW24C+QmOVEFneQsE6e6UdDVwpE/K6beeLyUtwsdhK/30QgZixAmLLbF0gvARbk84AZPfXkAbGQeAufX7pWZOYpsm8KMVLNIhzGbGgLCYtMaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h/f9Ss/C; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4/wKOSZ3m09viozVTNI4IlJ6EmcJPfRS6WMtXBrh14ao27jtJC0PWKkdR9tSlLM/XJL/P5IQDie4yMKk2E39JCG7Bo8BpZwA29rVrjbr2C8CGxizwXuERFahaQLbvZgPcqk7QTyMJ+z7ncjsy+OF507AEccMvXt+PMCqhRQpJel8+6vj6f57rRKPdLlZemP8eRyRW6XmoX5jBIpS1hfG0z/c61MUT9oMQTYDgaCHCumcDMPK7yfQps6c/Fsa9puQjfAgyvmLHFlUpH0OgQGK/X73QxgusuuLg5E/XcEFToW3KvsIhWtPhGWVv1IYJt1K3eURlkO9+lbjo69K8ZFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a91RVGT0jc3ot3uSqX7fXt7IjHdYm0fCwrMufVroS+8=;
 b=WyGvRYSuxNfbGcmWLlbfV0/2VXTxOxxlkutk07OKtYGK+2Kd0LwbMIPtZGh0Rz//MbRLMhgRO4zAjUlAw05O+8844z6IAdw4prl+I6Yct2wD+1XvJeHzDn3OJRr2JbsfuLe4eHjqfHJDCfCQyL7+0O4dCvnioZwWF3g//ROI2ryDwgdR9sS/0EerdhnNCCfbJfLQSRxydExK+osQmKbMGbLGG6vRlR1T0Gj+vquGG5uLwoW++o66liwnPauk0RiJP+bdNGx61tlrAH0fWsNlghIlVzRx/NdQ48QasbzN0Bl/Iouzhsxl8Kn3dmSOMe0mFbQbsk9+Iqsh+hDqJmdn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a91RVGT0jc3ot3uSqX7fXt7IjHdYm0fCwrMufVroS+8=;
 b=h/f9Ss/CeLy32WOsMmK71YG4xJzluSw6mWdFUSBwCfFC2PW0Z0a0SL3JjYIyIwiMpZ24uReF/Kjh9Dpd2+gqyqoU0v7BALfTdKOyZo8wr0YPy3bP17zAJ+UAJpz6rO39GoTHmVC1cmgHJxZg8tUYINhKjOUzxiGAt6qQU5a//Pc=
Received: from BYAPR03CA0030.namprd03.prod.outlook.com (2603:10b6:a02:a8::43)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 11:29:05 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::3d) by BYAPR03CA0030.outlook.office365.com
 (2603:10b6:a02:a8::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 11:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 11:29:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 04:29:04 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 04:29:04 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 04:29:01 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v5 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Tue, 28 Oct 2025 16:58:57 +0530
Message-ID: <20251028112858.9930-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028112858.9930-1-devendra.verma@amd.com>
References: <20251028112858.9930-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0fad5a-f736-44c5-c57a-08de161533c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P5ZXHBfUiaejjIMJK52gZf2+DY/bnC0pQ7RKaxicWOEg5u4OaFT+C955ha6F?=
 =?us-ascii?Q?GLq+pIXtfrtCEuBaw8N9H9+naFDrvjDDMiLXcrBwD7kFNSzkB08nhi5yfdU/?=
 =?us-ascii?Q?ePS0qqmna1zBIwheEafb8taIfrBQ2IL10LlTbei3k1SYa/1WVML8418P/5qR?=
 =?us-ascii?Q?cAPhqMRDO3mAEZqkWcG6C78g8ovtbjRuTaGAZYdkVmRJl8HTNrJE6gGApP2m?=
 =?us-ascii?Q?f7rNQ+FvmQCmrDTNcPY3LGzdUdmsRE7r5Mwa2M30/dmd5cpYYne2uQyZ/4rY?=
 =?us-ascii?Q?BfG29tRvvscQsaw40X77HXriYScCONTRGeyTiFDfz398nm994hKJuGA5vpbf?=
 =?us-ascii?Q?iA4SiB7QTcjwacEnxT33av0tyJ0+QOX+ZnG4u86OawPVQ8pZWpfI+D5w73iT?=
 =?us-ascii?Q?FlzsfEVu5/NS3t/S7i8UbFINcRJu4prKt0aySGc/OL9QTvi+zbA3JVTX7iMe?=
 =?us-ascii?Q?+a4791/X6Y+fJL7OAZoujKoW9Bm7JJgGTl8q9tz0zSPi+S1wA8JGWB3yximF?=
 =?us-ascii?Q?57uJZcYZyWu4emUWfDONMQBKlW7RKyXXn+I/pj9dhcnZ6m6uB3FNmZoO7ao6?=
 =?us-ascii?Q?AEfHSgYldv99n8bTpjCodXpixMNlbj1ipOWA3DLBwO8kL8rXQLxlquRpZFmz?=
 =?us-ascii?Q?jMx+RBs8CTBp+/Q0uXdIKQdLeSkhzJeYPSPLhOs+Th2TMVVRv6Qq7UDqpMAJ?=
 =?us-ascii?Q?4rRIgwB0AHxgczG/Mndj4jZeygkTMCcisDGtIow6uzsG6MKW6tIC71Y7+uco?=
 =?us-ascii?Q?QhpAES5zwpmQu7h1/JXC5sOaRrVPuCC009X27WU7I72MCeYm2jzppDRhFGoP?=
 =?us-ascii?Q?5PFAKQsQe4X1xnbcgtX2xVRFizseJuTaYdnY8VjeaNYfjE5DGaRPh5nsWQsO?=
 =?us-ascii?Q?PHir7B672h362Ccl2oSyW5eMSLXX3fDam7ktVQweTZ4LY44ElyoaJssCZKTD?=
 =?us-ascii?Q?6AaiciuWa4XN18yBlddHF34aqxmAz8bG9w5n9WY5+4zVUCtgSDr4wAq6iHi/?=
 =?us-ascii?Q?Z1TpwH8yqv4ovIwJmq7ci0X6VSqEE50q9hOubvyUJmcN9jx2cye1nsN/soMm?=
 =?us-ascii?Q?hTgxx8UGtzhcoFWfOXmQo4Xq+oeqxJbi1cmY0+MikMgf/OO+nIrO4UUPs5qV?=
 =?us-ascii?Q?5K7Vn59XqyUJmu58GrjSSIoZBbZ0KpPOcCeW4ES+eM11UUWx11dhx091KSqR?=
 =?us-ascii?Q?bPzMa/fWcSG8C9iXSXk1IU8N08PW+RsqzHEEAkWr5Izr4oKwQCJ2JEJLGdKR?=
 =?us-ascii?Q?Rwq2Z1y0Ybe4KkdfvlRpl+lPMUlm4xsiLFk7fj9yOFv/M1LmSUqPZV8yray0?=
 =?us-ascii?Q?7Ju2YyMxx8icLymKoaAZEzl+6b7nIYSYJ0JtbCx7xps7Vhj/38IYXoyCGbi3?=
 =?us-ascii?Q?I2Sil2sujU9SPeuFaIFuQi6ytzahtYT1dQHN14+B21et7hi3SY7aW9yXSNB7?=
 =?us-ascii?Q?8tet0bG9nf2zGlQNZTtUfaKPejjg9V+inIUaYD89jJtnVVs9cPoVM9p2bMTw?=
 =?us-ascii?Q?NukBe/rzy++fdFeWou9TO5JEHLOnfwGaxav/1EnEtL2w4hfoPejdgDf+AneR?=
 =?us-ascii?Q?406RQK79oELWswTiRmA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 11:29:05.0707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0fad5a-f736-44c5-c57a-08de161533c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
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
 drivers/dma/dw-edma/dw-edma-pcie.c | 138 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a7..7b991a0 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -17,12 +17,27 @@
 
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
@@ -50,6 +65,7 @@ struct dw_edma_pcie_data {
 	u8				irqs;
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
+	u64				devmem_phys_off;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -90,6 +106,64 @@ struct dw_edma_pcie_data {
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
@@ -120,9 +194,24 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
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
 
@@ -155,6 +244,28 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
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
@@ -179,6 +290,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
+	vsec_data->devmem_phys_off = DW_PCIE_AMD_MDB_INVALID_ADDR;
 
 	/*
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
@@ -186,6 +298,26 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
@@ -367,6 +499,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
+	  (kernel_ulong_t)&amd_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
1.8.3.1


