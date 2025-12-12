Return-Path: <dmaengine+bounces-7585-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E95CB8C8F
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 13:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 717783091634
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B73191D3;
	Fri, 12 Dec 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qAtybOgt"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851731B118;
	Fri, 12 Dec 2025 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542072; cv=fail; b=EIEwIW5/6gf2ajPsB7zNobxwAX/SGYPGciBFN+xAasHPNZTyJhMQR++Nf140JgO/D0znH8bTHtB81ca6I8rZbUx8QSWOVVvpFx7OsOfis8kI/oDQxJFh+UuznZ3dCxvbPCkPH5Jk/X4lUbjKaEHoDCaUWHWgBBmRlRXOADu++10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542072; c=relaxed/simple;
	bh=jEE3ACWNeWibdjggl0RBwgs1beOf+Q8fkg036t4LfLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUFnp5dw+M/eBTW5MPhO6MnT9R992UE14N2r8tWOrwRsxC4kCwfeQAld0vq2KKitlzxKXmt5OzchKLOTkff7TK3tr3wJQKfqKkcYkWCrfkYlVG0NZKAfggkiEpO4OVZcqFwzqYS4lEJHUPoxv71glKYfd2MgUiRcJQYYGZ5N4Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qAtybOgt; arc=fail smtp.client-ip=52.101.61.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivZLx0mhKrd1SeoUrTlxZtU30OHvBxJq0zMUv2JCfX5xGtYjCryvOraYqHn66QcjHfBnUhniouaFNtYxFlMn9Qnq3puqdlxZlzwxBbPw0AfCjVuzHN/IQtl04BQaOQOyAsLzZcK9RD9+PrqdbWa/IrVK3mq+UHMQOBMuReG+RvXrsG95Bp4JuifU4MhM8PUagZBINlWOZSgH2IpeJNg4pL/PUmKhbQshCnOxCb3jy/V+qUNZy8CV2xs5WBGkZOh/zRIYQtJIHz5bJvhiWExl+3LkCqFuFdND85Lq80IZHHsOPR8vOp+Krg2N6RNu7SLIrU4Boh/hUAZhCZo7jgvqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVu6zMAwUt6eEOG7wHqV70mtD1Ymq2cQ6VGEZK8IUq8=;
 b=ls27U8Wqmt3oynkXaYNK6m9BRwg/A5Dhk7E22Soaa/lGfp+jQwFC7tB5aS4cLDLnZ4YHgTmwZ3+7d6tpDLMuT8NCq0iRkIX+APLXt3MmdSgoSrxvul5oAF/Ge6oNKGKcXxxOT+rlGMw5tY1R8m+bqfiQvxow92XjJWLbaLSY4Z1IHaDo3Rcsx9lllcUotYKzU0l5gDjdmy6OgTa2HvzBO1AaL7h4/hEIUbsoejbnU3ON0dR8moBPXCbFMr7gkbhgxK9HTjT8hZK/yLLxTwCv3VoiMRljOO+tMSE5YHyC+gHwyY9z0rwvVdX81M6ZFrVnljUAvat5Fe7Qlr410pgeyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVu6zMAwUt6eEOG7wHqV70mtD1Ymq2cQ6VGEZK8IUq8=;
 b=qAtybOgtvrSB+BH1p6SJb48WurFMC94//Qzzqkdp1fKkTq0osXOgY1ZX6dXciKigNBoemDM38J9XNM5JwTVx/JV9HHuykaLEh9w2nlx/D3hMzchhd5z5PG8ogNGL8aNYsI0iGCYOgFVLpdTQznN2Tn6EU1GgWYsyACPWUjCvssQ=
Received: from BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36)
 by CH2PR12MB9496.namprd12.prod.outlook.com (2603:10b6:610:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 12:21:07 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::8a) by BL0PR02CA0023.outlook.office365.com
 (2603:10b6:207:3c::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.10 via Frontend Transport; Fri,
 12 Dec 2025 12:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 12:21:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Dec
 2025 06:21:02 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 12 Dec 2025 04:21:00 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v7 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Fri, 12 Dec 2025 17:50:55 +0530
Message-ID: <20251212122056.8153-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212122056.8153-1-devendra.verma@amd.com>
References: <20251212122056.8153-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CH2PR12MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e35b4f3-3d9b-4697-efa2-08de3978ed07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H/XQTOEj7ubBGWefZBBR2eUvot6TyOc+KFsleiaawzkGJ/B027VMJeVsMU7X?=
 =?us-ascii?Q?Ts4wbqZF4+pZkqgrOhRLKd5FXbfmCe3Sc0GSaLo/oQSe2+AeuBcCVNULinqI?=
 =?us-ascii?Q?DeojCAuhw66Ntm51g6zIeGIizhCdVFhw+MgFvX4b5bc9Zs3pIRuMDnHf2+qS?=
 =?us-ascii?Q?fohauQmZ0xdFO76WKKB/T54F0Rre9azmbQDO3vfvzxb/5YXGB2dJjVWb2Zzu?=
 =?us-ascii?Q?79vnWx573pxEOe0QT4c6/PC/AJTDlL3lZnKQ8YYLDJFePz90a2/ILXHA7SHL?=
 =?us-ascii?Q?PaUjby8xJjO0oIo9w0VC3RZI7MIQ2p2DzQb6oizd1zkTr1Z2IdvSuLUBdiCg?=
 =?us-ascii?Q?5OsU2rqh9OdOmBtDLqH7LDQ1KHfN9PqbmdsX1uvyPTeDzsBytFI4Ad85EyDi?=
 =?us-ascii?Q?7ZNJqXgXzth24GAwjsZAViPj4+5aqROrEMJuOXgTkFiX+8wPI9G0JQ/glNDk?=
 =?us-ascii?Q?Gi29Wv2c3j3OPoZH3LZCT1OPDf3YcBfRl3tGozswYKveK2WEqBec7Tb1Ja0a?=
 =?us-ascii?Q?14djBMh3KGGVvUtWD1fnbhffLXuSoHDF/h1p+tkA9F98m95UmpDtr7lNQEtp?=
 =?us-ascii?Q?ltnvNyUKh2VRIdBmA6Zm1Di7fcrK4cmYHzVFLN05m+PwqPyiFcksFIYaZqIx?=
 =?us-ascii?Q?lH8oCZbo6eabTXzGUjSejTDE4SscO8vTxVjLubTprza4OoqByt99ij4rUmw9?=
 =?us-ascii?Q?hJHsVjdbg0CMHctIDp4HZWYvvbCqSVSgDHEILEDqGXx4HQm1bViFSJtLkylO?=
 =?us-ascii?Q?ISM4H7F1PeYv7TdCVnkub0s4bvIRf1jN01UgriYD19jSsqeiAa5AhmSJxn5p?=
 =?us-ascii?Q?9/Tnz1F3wUG4XywLv/MPejUPpJuch1c+QlL2yLFSWdxACHjvcYI/oraeIkZq?=
 =?us-ascii?Q?24m4ell80SwgVhWvENneBe6KwTcCU12VU5z0qWgW95YxId3O2WPLo/JlU8pv?=
 =?us-ascii?Q?8hVo4hgWjVc0HGOaEta+oVUSyxxG8Vl82kn37LevpEGzV7mDvfvHLLSkq72a?=
 =?us-ascii?Q?Rp9CXwgj1FDk6cHi8oSJmAROiwKuygxVseKg1IV8/nbJTOVliobjaFTp6kRh?=
 =?us-ascii?Q?mAMN7sGIXpj47we8c950gF2SNA1Ngywp4sTSTavyqm+DpbRvJROOosWS2ZG9?=
 =?us-ascii?Q?RSjHd4qB8/Z8hqehz+jaBvYmYliPqY7lh7Ogf48rF4W5+/444VzIIih7ZMpW?=
 =?us-ascii?Q?5wJVL6wY7wwD/kSbliudazZYfz+U2GwzRAyZ2l3UNXbDpaWS/vuYT8KWfBHT?=
 =?us-ascii?Q?wTLjJXwty3WvY103RbRJWVOu047X89+Kdu2M9pCVfy+O5Our9uAjKw+1OnAI?=
 =?us-ascii?Q?lOHMHJBhn4JZ8+219hAA0A12H8Ch3tZMgETI6slBd+ulEVJ9vCs7+rPAiTqP?=
 =?us-ascii?Q?Uzqr3mhQRaRYjQshsRm7CiGnTGhpOuWedP/Ueq+m6YfmfuQN22SrTyXDYWxe?=
 =?us-ascii?Q?EqZzsFJJcu8WfHcHSGZcs3JCVkZXv9phLJX0faAz6mJaG3orBylAJhKoJ5+T?=
 =?us-ascii?Q?/2tIN8vckJ4LtiaDmy874Al0Cy4sVRnleL6dZLWSIK0kWYKzjlSSGel7XnEM?=
 =?us-ascii?Q?MgXH7hbGYHdj9A2jhug=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 12:21:06.8397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e35b4f3-3d9b-4697-efa2-08de3978ed07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9496

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
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
 drivers/dma/dw-edma/dw-edma-pcie.c | 169 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a7..9c1314b 100644
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
@@ -114,8 +189,8 @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
 	.pci_address = dw_edma_pcie_address,
 };
 
-static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
-					   struct dw_edma_pcie_data *pdata)
+static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
+					       struct dw_edma_pcie_data *pdata)
 {
 	u32 val, map;
 	u16 vsec;
@@ -157,6 +232,70 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	pdata->rg.off = off;
 }
 
+static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
+					     struct dw_edma_pcie_data *pdata)
+{
+	u32 val, map;
+	u16 vsec;
+	u64 off;
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
+	pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability DMA\n");
+	pci_read_config_dword(pdev, vsec + 0x8, &val);
+	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
+	if (map != EDMA_MF_EDMA_LEGACY &&
+	    map != EDMA_MF_EDMA_UNROLL &&
+	    map != EDMA_MF_HDMA_COMPAT &&
+	    map != EDMA_MF_HDMA_NATIVE)
+		return;
+
+	pdata->mf = map;
+	pdata->rg.bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
+
+	pci_read_config_dword(pdev, vsec + 0xc, &val);
+	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
+				 FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
+	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
+				 FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
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
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -179,12 +318,34 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
+	vsec_data->devmem_phys_off = DW_PCIE_AMD_MDB_INVALID_ADDR;
 
 	/*
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
 	 * for the DMA, if one exists, then reconfigures it.
 	 */
-	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
+	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
+	dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
+
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
 
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
@@ -367,6 +528,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
+	  (kernel_ulong_t)&amd_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
1.8.3.1


