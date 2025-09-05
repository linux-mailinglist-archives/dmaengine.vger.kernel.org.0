Return-Path: <dmaengine+bounces-6395-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA9DB45454
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 12:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7715639FC
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952E2D5C9E;
	Fri,  5 Sep 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FiF5fDgg"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8A72D63F6;
	Fri,  5 Sep 2025 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067438; cv=fail; b=NKnSOjOPbmypnjuzVoV3loR4w63/5W0czps2TRAoujXkdUoqJb1SwHIMDOG0KQiTo1fE5m+k4ynN5Dw4w2Y6tBGkgcMyBC8sqkYkmU4+EpQCYLtu9mEUSfhznJVMmcnBzzemuqmSpO6gaS2bv/nkPg9eyQYZ+t8eRpD1xu3gNUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067438; c=relaxed/simple;
	bh=jguEZrlkhkRTGYDjyQCC5WnBbSUCyod24CJP24hn1PU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2S4fGJa+MVmT2SobSGHWY23JEM1Hc9jKFhVleI2qD49CT6P2L32fDk1keNBWTrr+JUWW6hhC693xOPQtk7DdHSaTVIRkKolMTdc8fApxN1+llZHSp0VBcVBbnJrb9M/5npSeH8EJ5DdvvdvfILstiZNjmZQJThhEnuEqGWtO7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FiF5fDgg; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzZWlS2MqPgI7cLBG+bmsOILqYw4mMWr0indra19wy44ZwQuOh7MIk8kXx5YvN9DQ4/03HOx1GbrAKO7zmCYAgONExwdvZGOTNn5CHU/Nngph4IaM07zlmSe24zh0CmZR6lzrIlN9yW6BFTJpRgbP2V0wp8pWIQ9IFxP89/VTwWIn8IOw1YNiazZ7tWHfC8zmKoGTZY0UAlWYdZ7OBDivY4YNLEC61u82M6XWnaxWpfvzHr5S8d/8pEsWTCkc48kzB5IAw6eaU8bp0otkOnYmTkVzbtvHMwwv+A7UcEy+rR1O97v8F65PnLm+8EcoK29k4Deu7t9oCWsl32pDogz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHdW5QQ3ZXgcjct3hiD4G7FhkX1gxvGMKABb0eL3Jfo=;
 b=jtjql7EYmLerLXulR5cU3GtKRlo6FhL0ssC3IxWGF37IOIogl6c7EmJdeUR9WUba50zqWYC7dRi/+ohNdQHOxzFG1s4PSKDMFXMkIgQ7VhOKg5ssyK/rAF+je4FozkNC5okCnNyee/gQEuFzhieTIKEzgdOiFUCFah2qBs4APD0RdBmw8fs7eCb/ajtzkJ5tE1TOngpyL0wblai1Dmedk42b9bSD3zFXythsjlGQXLMNnFWp0sJWca15i19Vr2v1UF2WJB1Ym0KEN0yGnfkZhaThdIESBFvrFv18F3Gcs4D6LNJqBXU+MRPQy59GLpxn4E2YRXroi98Vw/2cXroyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHdW5QQ3ZXgcjct3hiD4G7FhkX1gxvGMKABb0eL3Jfo=;
 b=FiF5fDgg+Y68MhEkC0ScgJj13vUXOfdZ5GCY+7RfkUXWQOvfpgT1/2Qt0yZlQrp8L6hldlAE0DfUb2zdaOV4bGCdNaH5H8UqC2eBlf7DiiJBzBPRPD/dGlaV4EOVRhuPQk9kilO0brzjfiAKSzNue/VujUXo8zHD1bbR6TDDq3M=
Received: from CH0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::18)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 10:17:09 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::34) by CH0P221CA0016.outlook.office365.com
 (2603:10b6:610:11c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 10:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 10:17:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 05:17:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 5 Sep
 2025 03:17:04 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 05:17:03 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Fri, 5 Sep 2025 15:46:58 +0530
Message-ID: <20250905101659.95700-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905101659.95700-1-devendra.verma@amd.com>
References: <20250905101659.95700-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0a7b10-61e9-40e9-ce84-08ddec655f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CtIZigHSP+ExWK9/pEJ2qOFuF0l3t2aw4KNM6aKT/YKwW4JrqstVqVKSzDQ4?=
 =?us-ascii?Q?wU5mapG4Lx/E1njnm5NOYKBENNFT6rM8UpDde2MvghZU10VvOHwmfprR+j03?=
 =?us-ascii?Q?cs14nJGM600liFaAVssrqT5ZCluidmbHgXk2UXXBzajy4beePULab9DYUEdU?=
 =?us-ascii?Q?kDyUWRuQ5D17W7RFxFO0jTZy4V/jIPnlTupgT1w+sP/SWpuJC0nSfMEN7p0A?=
 =?us-ascii?Q?eLB8KybSztBS9Pvb3heHyGHIKdo4RFaffLc5S8gD8e7mYd7OsUrLQeu4bmoJ?=
 =?us-ascii?Q?zTWlJfpitJdzijCW0yG8tb0APuzIi9FcjZvMmJcVDS/0xq8fDlNjfeCwwUIN?=
 =?us-ascii?Q?yjRKAedidfkXwvRZrgyHURYQKaHNlaGz5iQBftKP21iCVTgvuL8kCHSCOspj?=
 =?us-ascii?Q?X/j4JnZFwl0A3jndxGViwUIy9PIdahAysSRGHGXFKDILscN8Sv65R1KN3rRx?=
 =?us-ascii?Q?p/u/0ANz1e5a+ZQxzJNVG36oKQ8ovimuoykO/EMCKqHYXjdE9zZilKHUkspl?=
 =?us-ascii?Q?2x8ANz9RURtXQMjBE3E+wRFgIuaGfCCECxCf7CYZGCCNyr+pn7Vfa1MCscHN?=
 =?us-ascii?Q?Ir9ffTfJ9155gCUhPe6ZM7ySYHN/nY0VePeBDSzsGcmECUIKJS2W2/pk7VxY?=
 =?us-ascii?Q?5o/hzg8cwxyRpMaclWiLDXr1JEKD23oon3SdyOSBFv1Nqtqf4WB+dMpusSLD?=
 =?us-ascii?Q?JFIDBH7XCJj6rz1zomC6eEA78Wp7vQtI64K57GsrWDgXH4v8UWqr1cuwh4Be?=
 =?us-ascii?Q?D0+fCO/NQP65AgOXZNTDFslkRATy1To/PU8vk0g+OL0+ZooUUWkgReou3zvR?=
 =?us-ascii?Q?3Ncota8bKwA7//TKfeVYMbq/6NqoaOFKqw6ICVnnxqcQdw2OhDQPjnksbTFA?=
 =?us-ascii?Q?8hMfxp8l3O11qGdSbB40q7KOCNMxFOTcCk/yEohAQo0fHrSJi/+0OO6kYTz4?=
 =?us-ascii?Q?u+WLjVshCyZkGbKdLpaYE2E02dxqDfHpCTtqtxxReI3iKxA0ZtDtl0czPajs?=
 =?us-ascii?Q?TKuRgUjPob9pXjLcy2nc/4WfL0ki1ogHGvNXw0Y6znYmWXqyKF9RPrgNW5Ia?=
 =?us-ascii?Q?VFXh9YpoQxTAq1WbkBvYeNZze9HeOK6Effhlclu6m5iQJqZakjkyddpYtM5+?=
 =?us-ascii?Q?vM30zPtO4uxTzHuYWIvmAmtjAGCwqJwK0AwH++b3IRhNalM+MbwRP43zJBHv?=
 =?us-ascii?Q?lZGoSvrDMM9qqMIYUDCVQVCatGoDCDJHgS+nVWzxzy/f2gqKyWDy4JnZi2cm?=
 =?us-ascii?Q?V2VU7yS/szjy5qmSc6k8zhFp3ermX+C78qn/0PkYSj1rgZo5batj9xBSTh8S?=
 =?us-ascii?Q?bn8I3V46l8htAulwGTXV7L7U4qwgJfMHC2PVrwQ2nl6qd6AgF780GUubniyV?=
 =?us-ascii?Q?GWctBSsApbOkFwnk8uFOGimZVwGsJ7WhpDEBgTrFn+FbdFnGjCe3oM4RHWOA?=
 =?us-ascii?Q?Nv2SCUmoAjJev9wWJE5whv2JHg7NYJ6zy+ROrt8sAbDzFwhqYCx+En+cB0TB?=
 =?us-ascii?Q?gyZ3Dxmy20UstENIkYDPgO9FuC2HpheXiErK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 10:17:09.1625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0a7b10-61e9-40e9-ce84-08ddec655f5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 83 +++++++++++++++++++++++++++++++++++++-
 include/linux/pci_ids.h            |  1 +
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a7..749067b 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -18,10 +18,12 @@
 #include "dw-edma-core.h"
 
 #define DW_PCIE_VSEC_DMA_ID			0x6
+#define DW_PCIE_AMD_MDB_VSEC_ID			0x20
 #define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
 #define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
 #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
 #define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
+#define DW_PCIE_AMD_MDB_INVALID_ADDR		(~0ULL)
 
 #define DW_BLOCK(a, b, c) \
 	{ \
@@ -50,6 +52,7 @@ struct dw_edma_pcie_data {
 	u8				irqs;
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
+	u64				phys_addr;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -90,6 +93,44 @@ struct dw_edma_pcie_data {
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
 static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
 {
 	return pci_irq_vector(to_pci_dev(dev), nr);
@@ -120,9 +161,14 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	u32 val, map;
 	u16 vsec;
 	u64 off;
+	u16 vendor;
 
-	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
-					DW_PCIE_VSEC_DMA_ID);
+	vendor = pdev->vendor;
+	if (vendor != PCI_VENDOR_ID_SYNOPSYS &&
+	    vendor != PCI_VENDOR_ID_XILINX)
+		return;
+
+	vsec = pci_find_vsec_capability(pdev, vendor, DW_PCIE_VSEC_DMA_ID);
 	if (!vsec)
 		return;
 
@@ -155,6 +201,27 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	off <<= 32;
 	off |= val;
 	pdata->rg.off = off;
+
+	/* AMD specific VSEC capability */
+	if (vendor != PCI_VENDOR_ID_XILINX)
+		return;
+
+	vsec = pci_find_vsec_capability(pdev, vendor,
+					DW_PCIE_AMD_MDB_VSEC_ID);
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
+	pdata->phys_addr = off;
 }
 
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
@@ -179,6 +246,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
+	vsec_data->phys_addr = DW_PCIE_AMD_MDB_INVALID_ADDR;
 
 	/*
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
@@ -186,6 +254,15 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	 */
 	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
 
+	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
+		/*
+		 * There is no valid address found for the LL memory
+		 * space on the device side.
+		 */
+		if (vsec_data->phys_addr == DW_PCIE_AMD_MDB_INVALID_ADDR)
+			return -EINVAL;
+	}
+
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
 	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
@@ -367,6 +444,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
+	  (kernel_ulong_t)&amd_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc43..c15607d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -636,6 +636,7 @@
 #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
 #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
 #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
+#define PCI_DEVICE_ID_AMD_MDB_B054	0xb054
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
-- 
1.8.3.1


