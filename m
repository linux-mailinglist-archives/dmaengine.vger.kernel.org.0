Return-Path: <dmaengine+bounces-7028-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9ACC18B8F
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 08:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A08C3B9765
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC83101C4;
	Wed, 29 Oct 2025 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qjTxJ01s"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA330FC2C;
	Wed, 29 Oct 2025 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723557; cv=fail; b=l0EEyAW1hFxydB2WW1Bd2EOGSGepZEbYnAlxon7nb2IwM7dqtkTQzO70VYgWRmTQ2fSodMzNhq5MenJB73hYvjDj2n4exrwhzHgVN0XiUcljzej0qDQbNuBd5CsE1vby2ljj/30QH6Ki22XqeeWqFiglW6NedjehdN8yyFqie5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723557; c=relaxed/simple;
	bh=R6BJVuyHpgoouVK3pXMp/EJMBW7SYfRMN8iVzuvkRTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfyznmmkPBL5d+8pae3n7g/T9S9VK0MirotDkLZSotdfM/grCvTNFGKWhlp6vYGX9si+rmgW05jCLgpLG5cbUMnzrFG0MSmb/LOXE9IwexTH0LTsd/gkuROmPgJAC+0QMIgZVgQd5v8Xa2Kjr6tlU2ohBoZDTsW0SarPa3MicUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qjTxJ01s; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7S5oep/e65ipsoIg7MrUdzejtJ3N9kdx/dAcd4WjcLymLFwCRRIK/aMygeCxrQtDFaPUfgQYzkobAi3dvCan3nn2qER/ap+cmdV2xOBxdttqZPvsWzSXhGwuCup7iLqI96ILdLrw/LE65UMChnT2tkBbUMWY/7xAmHYSUtmREwBg+tC8KbeSgYBF3JSToYtugT9AjDqtgNhmp9An7RX6+vZ34P3aFMLFPcU8oAVQTWKU2WCSSfJdcdUSELKXO6oIOVDHbuNryzlaLJZJJMtqJ1vwWBgFWA6pxhP+CbQUptaHeiZxnArSE204BQhHHpxFR4y7fYhuc5/VqdXfhd3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WeqNIMuEs/hDIwLznHphFUBkfZX3rHv/Thn+DzGFXo=;
 b=OxjFq+pM/y0HaBMw1MOWA/XcNQmg7f/oWRLJiBXmYm+xDcfqXtWGzhbX0YdjD2l7ha12vLzRAXqv6JCMbS5pywXtPyNregieo1PHP4igOCLXq+/rtZColW8Ga/hwuhvetftItI2MVbA0dQbD4Ids3j0NsT1t2epPg7qKKvg22ZZDX0j03Est+CpxeiGiS1+yT2gZhI6jJ4MN71HBiA6YWHO5hjpvvbeWnmLIt2x0VFd4e4WZft4e3JPB2HO0+54K6n6DpIoQJek8qOfFzcdxopv2bvcxhVGHP8YS2yDbspWbBlSW8xbnilhzvfztV0z+84jsUUJn2cvjuIdNxiA/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WeqNIMuEs/hDIwLznHphFUBkfZX3rHv/Thn+DzGFXo=;
 b=qjTxJ01syfQ/SaYvfYGdFo/qvuA5Fi0VOURFPwvQ1Fb6oYPieqX3DFZ+tggQZlqepRLgWjQ93CHCtqdeAguwFaFMyjZDEXnB0mJW+8SbyIBMVbOxmQRelkuJqVUeuJ1UvHjxmsdyGWrovreSCzp8K+BPOepSxIxiL3DX8KgZUbY=
Received: from BY3PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:217::16)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 07:39:12 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::77) by BY3PR04CA0011.outlook.office365.com
 (2603:10b6:a03:217::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 07:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 07:39:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 00:39:10 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Oct 2025 00:39:08 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v6 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Wed, 29 Oct 2025 13:09:04 +0530
Message-ID: <20251029073905.40409-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029073905.40409-1-devendra.verma@amd.com>
References: <20251029073905.40409-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1ed937-6c94-4fa2-b06c-08de16be40a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I5wZZNAO7CxpD61r3mlBGJWq0NTKJ4k6hx+NueUG6l0ruGg0P20ZN1a+cJxB?=
 =?us-ascii?Q?X6xGhFvNGmivD/UqczSXBvpGkpjb0HHCWNbAZ9EPDZviiTR4F7gH3YLXBHET?=
 =?us-ascii?Q?JcwFdGv0zEPTNnB0nQa/B2VkCzR2owwzTda8rCly1ofOyssAQvRLdNeCy9ky?=
 =?us-ascii?Q?YZcrG0525ti8NhK/6VdgJUcIczAE9xKHFARou9bRz+wqybyMNgL0xoGhyafy?=
 =?us-ascii?Q?052gJ9pADXJj2ataaQ3VBxKxGL+DAukcrZPfpeb3Z0ckKmmAyzOBBY6CMEsW?=
 =?us-ascii?Q?JY7nAEd2aYwDcVE9XC6vAd2bCLYGn206kAHzGQ+c41PczwzxdbBZsNxTD3vf?=
 =?us-ascii?Q?y9jVdaRwUlsjMFIcKwM1IzlJZuz0/OIHU6UkdbaZsFr5i5Wmf9PhXvRwQxW4?=
 =?us-ascii?Q?YGt2xIPEh0v7DyfeJClhMTfLO1ny4WdomsB6Oip8Gt81mCHRWWA9f0fkT/8/?=
 =?us-ascii?Q?D97WJuznXzAodDzqBVdgDM9fHBjeDF9JGG/8AkOp/3nLOGI0pc/DeTrqE/sc?=
 =?us-ascii?Q?zRViRN/l9DyKyyviGFKYd6FeMVjnKW0Ioqb3U+2JKGJDPld3vsuj1ivxSNC8?=
 =?us-ascii?Q?L1S1LCe7qKDMSzxAp+VlFNVOKLfYhNLrf7UmNYzs1/ekC1hUO2LpuUZhMQUn?=
 =?us-ascii?Q?jKkC57ZjVvlR4UAisQaC2a6F/KtfWYaUNeWHUGhLBXBVrHVabpTnPaGxVA3H?=
 =?us-ascii?Q?SL4eD5SrmoY4KUH4Uh/6nd+XJMeL7chJiTF5ShgSeWBOxAb4PrvzeIArqw+l?=
 =?us-ascii?Q?IGch3lWemb5nweqWgj6SxfamBeN6WxQ32DvtQxxNa9X0aJs3LPuDxgLv3joK?=
 =?us-ascii?Q?kAUjxJdJQqeR/b/+Hw42kCunYJE7PYEfTTzvZZCaK4kUlVMrasnKkD2o1bds?=
 =?us-ascii?Q?oCPgebRt5E+hBf+cT6jNf0z7cWjwOIY8ZiByGBhXnb4wepKdbVY7YfZJcqCY?=
 =?us-ascii?Q?Ym/z1Uv7yfincGBUHL4y9FGeyyvsm+L3KGypEXagjxCDNPVH19VeMZU6QD4G?=
 =?us-ascii?Q?v1d5kLnXG409cpfTs3IBGVQxFYc71xWPCHwxXnOuNZHlKbIkuNO5EOq9ycKl?=
 =?us-ascii?Q?2zQ3WvIZ4E3CplBMJx4AlVQ9ndcTgdxs/9CTzamFd4ebLVlcfsLg/ke5n9Yp?=
 =?us-ascii?Q?wWPTcPAaDHrW6cm9mw+FNFJG12Qpe2AZZvnNgGT+JXPK2qV7o7FZxhEorr5/?=
 =?us-ascii?Q?7qDL1Fj/f/uthnqiecjo+UE4QiyjJCcIx9x2uN1ifBH//acM4W5VlOuxYm51?=
 =?us-ascii?Q?kaSyDogpXsSOKf6RIlEXvmiX8gcSTAfgt/i9quO2kVfy5itWD7fzkdyK09yO?=
 =?us-ascii?Q?MCWkYUfvvD69wmd6055ah1Aa3xsAvlCCD+cpoK7wIRYfFPU+diejJf14XzXW?=
 =?us-ascii?Q?FF+g9Vl9fPp3IYf0d131SC4pU0If5nV45lslxWNLX1MAhLkY87AnK3sa+UiV?=
 =?us-ascii?Q?2ZIkZkdIlIN7+oy1d9yXSfZI02z25iFF0xkP+pJFtSH0SPL1LVaDxLhXoVcZ?=
 =?us-ascii?Q?78qNxVU9uURXOiQ98Dv7CY9WDpWvKjXFLKYZpUmIIxpimCPY4aFXk+ImBy0Y?=
 =?us-ascii?Q?MqRHbX2yVyEN3lrEPW4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:39:11.6313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1ed937-6c94-4fa2-b06c-08de16be40a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357

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


