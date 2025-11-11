Return-Path: <dmaengine+bounces-7132-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC437C4BFDE
	for <lists+dmaengine@lfdr.de>; Tue, 11 Nov 2025 08:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15C9D34F2EB
	for <lists+dmaengine@lfdr.de>; Tue, 11 Nov 2025 07:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913BD346FD0;
	Tue, 11 Nov 2025 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tAXH4i8e"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773A355049;
	Tue, 11 Nov 2025 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844744; cv=fail; b=eeVgn9M1jKZK66pdiwBk+KF30wAo5iIXOO8y3ioBv4LP+MwsBIJ52etO/kUlCTrJweI57iXKUvZXYs17nOh0wFRJREUm+csO/AK8zWEF8uDpmPs5/SynV12f+skU2DolK6IJNpzk8z8yAs05aXyeCS82nLB86rFSdrm/M2aQi5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844744; c=relaxed/simple;
	bh=R6BJVuyHpgoouVK3pXMp/EJMBW7SYfRMN8iVzuvkRTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLON4itNdStxpSyyITPSyXwwjpyTpi38YIRc+xleUgb+UQsQReJTEjuo0bm1w/k4o9h0yMwVXMHUGCkmmR+4cEa4j67kk9vovd3DzZV5LsfotSuJ62wyZ8jT6pljYmQFazT7dspOIdFofIENyxWNUJI2qO8C7wIXDgYhXBPIwmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tAXH4i8e; arc=fail smtp.client-ip=40.107.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTkNXOvtLr5ULxqeAohp5UqMaq2G3e7U/kDxjWhVevefr22JUJeyIl1cNDV7Hva0s5pdtCA9YvX3q6cNbyZCMR2ylaYnJqH1Tn2jPjXZddvGa2jleSATwUJfIMZyiPuognHBoPWqL3Y8TuOJ5IlcQOplb7wKrxjmjyQEeWrWxFfwuES/ZzcVFXz/vqNRIK+CykZFcFgIU6iyCWhi2oQFDAyFPY5aLGjB8oYKUtUrV+U8CioM6QEXtmR6okxj2ZBita5LUolVfqd+JWwmzqZaHHo5g7lCnIk+igj+kC+YThh45C6oJo3ymgwfGftxM7rpDQ/SA5DTZ8l4wmKNsSZ/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WeqNIMuEs/hDIwLznHphFUBkfZX3rHv/Thn+DzGFXo=;
 b=paPwnmMnHIxjGFyZ5JRtg2IsiLrPrLGGX7YjfN24oQytBu8oBsNTTcPuN5wMGn149nKz5B1s/5eF/dbt895t1BoDGEx6ruTG1/jlq9WBMku8Hv8er0ByyNSxBivtduriUmGmWi1GjBTQ+jMTFr+J9vMxeICR8Bdg39KPobGuJRA7lha1avhZ4QsUQgT5vcmXO1i5KwFEDuWO5bKweiWKPwqlCxOVZjkNq3gA3ww0RC0VKer+rRW04rrZH4J5WhJYrH5jBzZ7VXsdu3n6WDBFXf3lz7CfXsupHNi+OMIl3uwmrGzUc4DBxiDBrDogt2EoLEEQg3lQzP9BlDjSVVrh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WeqNIMuEs/hDIwLznHphFUBkfZX3rHv/Thn+DzGFXo=;
 b=tAXH4i8eRpuVpuPoa3h8A9Z9y2onVFMLY0mw2340QQ3yzSwHQyWOvOtKbGEdKG3KR8h2dubb07yvZzrWIIaud5SW95OwnLqtfZGsQEr6QoqePWKdo+IQrB1cWFrfbMzXPcSuFoL/88DUwaMrE1Eo262TXYMNhkBiF1nsIbYyFWo=
Received: from CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::9)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:05:38 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::c9) by CH0P221CA0025.outlook.office365.com
 (2603:10b6:610:11d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 07:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 07:05:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 23:05:37 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 23:05:37 -0800
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 10 Nov 2025 23:05:35 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Tue, 11 Nov 2025 12:35:30 +0530
Message-ID: <20251111070531.6808-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111070531.6808-1-devendra.verma@amd.com>
References: <20251111070531.6808-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 1734e857-4d01-45dc-1653-08de20f0b80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q3JNHHubEkMILcsTX0VsXyK+FrBhk+Hx0j6XFkQe5DhGwIVWMGL4Z8s/sCza?=
 =?us-ascii?Q?R1eCTWgZzTCZx74vztsr2VrA6N+8OIjy6bjJ6c6lPKwx41qF4D+tFf7me2h+?=
 =?us-ascii?Q?TqSpIMDb76r5D63RLD8LllIM3TNjz6P7rRAtw0kQXgSIR6k15m5nmdMqvxfN?=
 =?us-ascii?Q?IErHtJDDRzotEIARujO5eO151e8daCBMN5oLtZJV/pypE8Gfm2txTywXtqCp?=
 =?us-ascii?Q?gXmKPMHoJ9arzcQhHGm5brGtBuo0xhrY3GGq57/Hio5StcgsNm8hF/RH9JVP?=
 =?us-ascii?Q?0vAKlkzaIBbv3w9vJV/gDaBVCl8rSL6QX6/Uj21LxCkPJNaeLaqGqvVNEkiF?=
 =?us-ascii?Q?lQ/KnpOLWgSDuD1lszjdOuQ2AQ8XB4BeULHmyosWwxZvRi/+YpFouDflelwD?=
 =?us-ascii?Q?vAo+zhw2FPEyRevD+7/yvw9GlROe/8Uvd8OwNTnoEgiq0mv8aSi7duJWzXR8?=
 =?us-ascii?Q?IjKsyIWTa70rL7r738C/l56Z3V1B3gFD3rEv4aLeeZtkmS3f3Xey99cy+6nb?=
 =?us-ascii?Q?kHlLZu4AQ2Xaa/dQ+JPPGGAoAcyFLqqwSenPzvAI24oouxv5bwQR8Dbk48mk?=
 =?us-ascii?Q?FxUzOUnlFLLm8trcELYzsRIW5x54EV987TCJjiCMTsn93rLcK0/v682ClhPR?=
 =?us-ascii?Q?FFm9juS8GRJN6by25JvS2aUp3R1tnxyHFl8+p/ayYY+8tczpyK7Ju4/Ty2kV?=
 =?us-ascii?Q?mZpqpJb8unYcDebdqRrjznMWANsc9BO8YfLHUbeaZxR13phCK4LUpsDSkhFt?=
 =?us-ascii?Q?/ZqX8NgWKbH+AV13Ju8SJUDKVWucBQkVdJh6bD1HDpt26Jp1zlW0a9kkD6dJ?=
 =?us-ascii?Q?9WihoL/ipfjRaumlBiNBTXaEt07H04Ywkqf0cgUqKTmyLJ5qwGG6N0TtNCKN?=
 =?us-ascii?Q?17VS/kG06q0mAXhTpwgUPb5NI4KQ4y40x/LU8qnWa9K9uc1i+4j71b5sHDpw?=
 =?us-ascii?Q?z6cMkZ9DK2Cfv46JSy0GyrjPYQW8J3PsEH1KmBSgIyO+Jn3FH9oUCh3DllFf?=
 =?us-ascii?Q?XRTDfyTO9g/wTG95QnZGNOH97FUn3ckN3LABekYDzAGIzgM7RxxWD55l7uXy?=
 =?us-ascii?Q?8lOwpXFZnkpDS7cOCrE3W84fVytQpohvIrXbyIwHa8J9a2y8VPMnyaENXnSp?=
 =?us-ascii?Q?uVJlhF/P7BbUIG5AWFhj9uumkV/KhbEV5Q2CQO3njZYdtnMIvcpDsPmDbUnM?=
 =?us-ascii?Q?xgjcBVk2DsZ6HGJ4rdQGiG5zmNjZcs+zD1shpMTizZOi+lEa2M3bVeZxlIeE?=
 =?us-ascii?Q?jjprmm1aNM74QTk2w1YPmcjHKth+29dVsNaOtsimqCZeMylC8PTz9WqYXUDJ?=
 =?us-ascii?Q?vGU0dkRDpOibM1B21gSQFxxhX+K27IeLy1fIWFbwUWT1tapHLQiXqtfaKlDa?=
 =?us-ascii?Q?4qiVc/P4z9fqI5Gl/PWNHQuLA3s7y7cF0F2Nb11HVXESomeVDpa1BbAwfhtt?=
 =?us-ascii?Q?nbsm3WR7SA6Nzr0ua7olMQqoXMTFM+Qu1iyl6qzXaQmi4I43VrQkkmbNnxJ4?=
 =?us-ascii?Q?TydLDP+aERDXWRs+f4Mqp6T2ovQlhC6wlHIKNZtE0dnXs2G1+QfWMNW0GavN?=
 =?us-ascii?Q?LyevgPMG98+pfybiAL8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:05:38.4815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1734e857-4d01-45dc-1653-08de20f0b80e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037

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


