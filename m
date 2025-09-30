Return-Path: <dmaengine+bounces-6732-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0A3BAD088
	for <lists+dmaengine@lfdr.de>; Tue, 30 Sep 2025 15:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873BA163C98
	for <lists+dmaengine@lfdr.de>; Tue, 30 Sep 2025 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE72309F03;
	Tue, 30 Sep 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zvWz2C7m"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F9309EE6;
	Tue, 30 Sep 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238291; cv=fail; b=gEpGvC3joAIUAEg26uzxRO8oryoZOIJYeNEmWksHhBGkJu9aoJ9jdaD/lRGGWN+ZxxheRaUvTAPmsyyLxNfDMoQ84pCGwJu+74W3Dq6kn3fZpSpE9xxiORDkuXGFF4sttcqJ53zEaY1CrheZiYDA5+/UTmbNtj/KRqrkb+ukuig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238291; c=relaxed/simple;
	bh=kyuQEhPhGIdbOHOap7KrZmjhZrwhuDk+WI3fpWCRC8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRQOnwqRUBF0/Cr51tnKR/A0aMxXtxyO+yOOKSHNiERVzMoxbGX/OHU+ggn2gDZmjc+4fPk8XoCBzUth2wHx5nEvfAeZxg7IASfn77eErz61b0jGoOEjngCAV8MPbjI5uyJHSGZmXoGNOKmChGreZnlUcBzAsPGF6OeUaiauVjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zvWz2C7m; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdXhQ3DaHyaDm5CFlUOEosRPQzJSBe/FvMfxTeRPSur+swunJ9e9g/j1Es4pQw4FnYGghLqojZbBteRycddQ7OSvdT3KH98hQMDgmTp4Jhn6kbzFIJ+3T8I/NvddfIuRjB+IdNLXoQYCkCmIznGP7m8OKD+a3z25iDKq2OXZYnJ9n9RZ7YxOsbaa/EZ408lMosUFlBMqohcyneMCvsAGcuVWFtut44mPUxp0DfguxiHnp/mVozraXNz+YV8apwa6PuuJOBJnpm/jVlh4qTGTD8wrYR+UJMyMZIs37vWrBdYDcCsKxx6rH13ctzy5lDuOwHKGZiQrQFGYqiCSLU65zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUT7JFPcTyjkIJPrmM3HE2CCq7dwbfEuwk5u29zz1Mk=;
 b=yB0yQI+3ynrxwOcDvotwmNmOqc2OaKBQTcUWGvwYG84RCato1jeljOp/vRXlc1CUxF8gz6tJSNCY3Vr2y4BjWqu2FbXDv5lO4OQ8OyKAOKIWNQWd/D7V5Ggj3VkHKzOcBDhL5aDmqRaFXLesVyzlZ/5cH/xKTg+sr5MKR2QFNoHXVarWuYmXhKjvUEKdE4t7k2fG36YwlCspH48tAugB3NcNzj28sLsgkQzZ0X2aZ42QiGY10C3WEUgGIPo+J1/tiiOgHt21qIQ/8A7p9yo5dKQ9KsxUmId/7N49jHbn7a8aVsU5lvkSu63n0ZRLV/FgCnNZnx7wTm2Y/g4m8o8Clw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUT7JFPcTyjkIJPrmM3HE2CCq7dwbfEuwk5u29zz1Mk=;
 b=zvWz2C7mR+NJrO0pqu8Bb3fRfX1HhUFhWLx32dHDYZYeYcsBKj2BkXrpjJbTDynF4334w+kZsZbep6n4dTFj1FNgCUBrbe0VRXI82/S23FQqiAFWGAO013toq2STPoT73x8M4rqmmviaqmgR/9CI96MzhwJZr8fums71pNEW6mQ=
Received: from BN0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:e7::34)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 13:18:02 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::1a) by BN0PR03CA0059.outlook.office365.com
 (2603:10b6:408:e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 13:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 13:18:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 30 Sep
 2025 06:18:00 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Sep
 2025 08:18:00 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 30 Sep 2025 06:17:58 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [RESEND PATCH v4 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Tue, 30 Sep 2025 18:47:54 +0530
Message-ID: <20250930131755.3844-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930131755.3844-1-devendra.verma@amd.com>
References: <20250930131755.3844-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 055e468b-ee33-4e98-023a-08de0023c880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VI5I5YFXdS/DncLRkwhnlSvGbu7y2TG34lf8r8RD2ulzr5L3zjTJW17jXHj/?=
 =?us-ascii?Q?Cco3nF6lhdBvpvIKC8tXfQicGsF3fNiNuOYbfNL1dq7Ge+HEHmH5Qg2uReri?=
 =?us-ascii?Q?50nIZhsjjGhZF3HkJRWTyeWBT+I9GuJUVWsYcsbp9c0xMJjwHiI4uxjbwEgR?=
 =?us-ascii?Q?Vr6pHQgxyR3GYmiCLNm6rRmOPTd4dKKV5F5/N4k2H2yPnts4yZpGeoqrOBPV?=
 =?us-ascii?Q?PG974kAFqjoUzDOgjdTD0lrdVyItryVIEOarlQ2nuiIgqi2ncPJMdWa7Drj+?=
 =?us-ascii?Q?5tjNHccy6dQA8ZpqoE2bYa7nmV7M76C6b3RAqOovQbNPKKGDVoA0EY/8h0Na?=
 =?us-ascii?Q?cuK6oSGOsLGQTFgiYjFabSyB9ttwNhErJjiWdW3n8ZQycNmUZc7QLjdLzs5v?=
 =?us-ascii?Q?1B4e8zTYw559Dt+TnhRcuJLWIQmuaHF1E7BFjlu6gvC4hfy0TsWtcLSRoGeE?=
 =?us-ascii?Q?hE6YGuCkxLXwPMzg59qN91ODYUqqYfWVLyiP37jVBRRPdwVX3VPOBg6FnJkp?=
 =?us-ascii?Q?WdH7zlk8KiOJmMgNlch1OA8wp6fd0c3B7CyyDxbuJG/0S0U6pkiiyv7zghsh?=
 =?us-ascii?Q?vIwJfC+hgFqMKd5+Qo99Ue2Qb/hQn9mlbYGskYCt2OX6tadPKwr22cfm8eLV?=
 =?us-ascii?Q?e2qb1whayZ7J+oPrYJIMyNODdZn/g0STSq8SC7MMeFWAYTubjeP50nOwZJPq?=
 =?us-ascii?Q?2gQmpec9eBf0jxA3z7dpQht8HFI2TOeK8lDya4XzSBxcG4VQwcwuoJQOSsGf?=
 =?us-ascii?Q?li7YDUSA+veO0r0QhgR/Dmfrei+/vGkLFb1Tjd6lAdPAoOedSTupsIFXrJSZ?=
 =?us-ascii?Q?Xec1hQR964HZQLA40BJtcS2wJLZ13SX5JNolZjkhylpU109LellDnzpfdm+J?=
 =?us-ascii?Q?BWzVT/ET++fUXnOH3pvpXenfy9SdD1ytNj5UMCFfTHyfMDDAEN5OOklE+jA3?=
 =?us-ascii?Q?DcHKtwThPv+xsQMJBW3906BIUPlwbmlmsoeZc7BBy4BVmZT3c3j88U70O84P?=
 =?us-ascii?Q?5qClxLOFyG+K856lpAPBJiQIMyjwxKGMvknkNAxLN7eebHsXzH8gzo8OOKoe?=
 =?us-ascii?Q?kR0n/BrlHjETM+LEP9HK6YOnwqlAFIQX7mXHJ0x+huF6Lf/eALj1aWeUoCXY?=
 =?us-ascii?Q?3sxnhRZQGh7bn2XLLZ4UylpdoI46FUJIN9/X6ARSYFN2LiD7+TsV248uv+mL?=
 =?us-ascii?Q?8+5wvfW+5a3VUQWA5TD9rlzl7b0Ba3Np8AfMgjkavoWyQ4fNm+3DBLlhuyKT?=
 =?us-ascii?Q?L7zbSy24+b1W+vDurqMLH0zlyI8+F5qoDTSkadCLOJb6IQ4fSDSLhn5ea8Yo?=
 =?us-ascii?Q?IbgIfFDMhhBhLqsxxnHXvcvsOTk16JrCes9Q73WPrJ3hkzWPOxZOM1jSv85O?=
 =?us-ascii?Q?amIS1SsXKZGgMB6wzOz+fTRTQEjBULY5CkmHIQ1eNpefPF6SUsrzOCoYM3aE?=
 =?us-ascii?Q?qxa9Bf5raOn1rjsuYWJu9wh6+HKGbbpcAsOBdmLDz0XG6+SYtGTfkuNNAO2H?=
 =?us-ascii?Q?PLDbQ+M81cjMky8Gf2ayyV/hlQxiKLO0q8aAq0lmA4jsbWwK0cgjcLkJnSK1?=
 =?us-ascii?Q?cuVs+A8sKwrCCmYN5Kk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 13:18:02.0456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055e468b-ee33-4e98-023a-08de0023c880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191

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
 drivers/dma/dw-edma/dw-edma-pcie.c | 130 ++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a76d3c..b26a55eec5e4 100644
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
@@ -90,6 +102,64 @@ static const struct dw_edma_pcie_data snps_edda_data = {
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
2.43.0


