Return-Path: <dmaengine+bounces-6449-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2439EB53156
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 13:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B6F3B3946
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152D631B117;
	Thu, 11 Sep 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0wACJLiS"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948631CA78;
	Thu, 11 Sep 2025 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591107; cv=fail; b=jxstvnPVPA/lN1okD4/6NIA+ZnCRrzdyaesndFLSpT3VuGhBBfPfekA7imTCi+De6Q1UO9b6BZZ4cC3JqRjKm2ALBDtHBIsJyAizLysYc8TYH3wH/qivheSOFW7sWk2m5j62APh2VdIDxbFostngQ6GBnCbQJZC96XjLzkUaxb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591107; c=relaxed/simple;
	bh=3A97s343CLVj4MVYG7ZDA8vi86J7B7KOe++KXId/PMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmf96IxikYZmVSBrI2L24xnGmXivIPlc3zo6vTtL41l2vUwTkglbXJHGTjPE2Np2wIlMNnP4GPQBOjgCBb01emw9BOMTRORYE+G+X5bo2n1leIikRNlz4AWQS1MyIEMMevcke/avka/Ux00KZTSHWosc5/rZsRy+pTyT3ZVZLxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0wACJLiS; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wpe9feFlIJhhcgA25Krr7rqQ6P5pqu1adKSW5/El7vdR1C9iLJbGhvkR6LEh044VH/9nFthhb4NuZoGGfNQKK/pRaQYmn9V6rr4Ly6wVOuvCq3cPE982aZXQaReCNztrxMZOaBBUniRbyzb0picJ/CAyn9lKsH8QN+oao1NBET+8plJa4G+ze1BF6ERTbJsY2/FE3zbX5OS+tS4PH9GDMXB4x9/ujG8UzICaA9+JuuerUntqb1aS2Cs2ChsYn85pYgsg4t8a+tylMbDuZ6TlVLnimoPygjXiWgowm59UDjF29IShm2ZqbcgijAJaC4lJc+97qhOFnZMJ4ZHBHJzvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXkbqzDt4GzHikMkWUrmhwUwuFYqWTHv1D0nVDyIkDc=;
 b=qpWJGYziM+jB25OTBENu3AD87rdSSJ63AQMkrDULcTlVv4BY/qED1n8LPa/Qj5zhGcH4PsjeF/WX584FzdxfRT5DjSdvSQlSqunO7AUanVfr7z4CIbeT9zcLk1I5DgFteFDe5GouPU1YQiTt4xRKjlwgmKExT7FVxPoxOITZo89rn9NZpImdlYzP8l8VkrZ8Z69ytmnd7bNJuIkl5Cu0WiV/m3WUflePj4eNZBjz1GNN+b/HOlzcZvs4oNSkpAJYbpjcKf171xeaKs4p8LHz3zomf35zgiytwoED0SSASZivPUowX0n13X+JAm21WaE+aCdWVeDHuLJlo3OtOKDJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXkbqzDt4GzHikMkWUrmhwUwuFYqWTHv1D0nVDyIkDc=;
 b=0wACJLiSeUgJLhfNZuvVeSsd70lwVPcb/adAfedy26+p7goYyw+06WFEaYjy58oWuTQoZAPj99T51Kf2NCU4h8OntaJnvcsJ8225tjySRD888b1fpG+VYDyKJG+eUFTGIW+7/blRbvi3ElFSspR8gnhyZV3JNA2pb1BkvYDm4nU=
Received: from CH0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:610:b1::21)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:44:59 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::8b) by CH0PR13CA0016.outlook.office365.com
 (2603:10b6:610:b1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Thu,
 11 Sep 2025 11:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 11:44:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 11 Sep
 2025 04:44:58 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Sep
 2025 06:44:58 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 04:44:55 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v1 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Thu, 11 Sep 2025 17:14:50 +0530
Message-ID: <20250911114451.15947-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911114451.15947-1-devendra.verma@amd.com>
References: <20250911114451.15947-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b17741-3fe7-43e3-a198-08ddf128a30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pEM0wymv8QgGJYH9gbrhpyLSV4wfPs7BT6Ai2SU+iD47xSfa1RUq8/VOJYAg?=
 =?us-ascii?Q?2YHI6OgP0+XR+GZ6BezXGFwZOOy+AeYuHAI+PlMhT+N6IKzeNVk0sJIZpTmN?=
 =?us-ascii?Q?ybhLz3rwFIYl5MqgGt9f2e5BzmiCu8zCJf1DdTcNDfAFXArFpdRKa1ybsxXx?=
 =?us-ascii?Q?MxMi3OScJcZ/CYj/n8XJIro9urzkJyqnTT68Rwt0jCObWZ7k8kXYEjrpQ3XU?=
 =?us-ascii?Q?VD+Vpj8gvFHVZhB0+K+zUoIhudpc30yOs7YQb3nJOuKE1OFzZ95BMewubtlF?=
 =?us-ascii?Q?+0NMvEbznTTtPP4HoWqxmqDp8Le1m61ZenQt8gtL1naNKemO89HJq2dAS5JU?=
 =?us-ascii?Q?RdejBV7nrZxEDuNX/1iNSkeN9BN4Si+1dOUP3riLnOQhWWusvMx4NILiiRyp?=
 =?us-ascii?Q?OFUHh87G57HzeTHVIKhHaE5XF3+Qwk+5Yu0/Lmtg14k8acSreWFAA1frlXqL?=
 =?us-ascii?Q?ZmodsBEsYz8Ri6d2z4e2yYAp8rjDJmhIqbw0nFGiaJahnX57044JUR2BRKvG?=
 =?us-ascii?Q?f4+9S7otijNbK1ZbFyzpe2lC+PyTYYdHqwzApf7x++Qg8rpY9wAbIrLlswzh?=
 =?us-ascii?Q?bIR9yDwcM17d5q+ztxT/YQFYjg3Mb6X8cQMqWgWmHmxdaRatPwPJIoxd1w7G?=
 =?us-ascii?Q?UX6bXAjvrDC9fWz0+S5c7c3O2CTLp6Pzs7iYuXoxRnqKLZMGgo7/RzndfdhJ?=
 =?us-ascii?Q?/e0+QAxzg1GxmxjsSFFrYJcCH8maLpXz21TpPZqX3SO9Fq1uidI921A/zV4Q?=
 =?us-ascii?Q?LfErWdvFR8f0uTGbERIkL+rwPlF1dzsjlHNWyFmzh5XXA5jbVQgfXW+w5tNw?=
 =?us-ascii?Q?xgk5UcbVOrIYuMjofBIBrBhScxo33Oy6aaG3AJzfmWwO340+Qf+H9zbdwEPr?=
 =?us-ascii?Q?J4S4sYY7ootvGT1vlgcmy2X7tcmlao6LvBDND2Ua3NNclDqk23xPwrk2jGlb?=
 =?us-ascii?Q?N7oW3XQW0GVYwrD1TP0JESz/99Ipd2/eFi/qlunS/bZDSSvnqwYcek0P7IJD?=
 =?us-ascii?Q?DQ6y08gHWtPeIDD31nTrsIbDI3vK9tguMGLRzZtijIXoaW0wwxFitKiQhKw9?=
 =?us-ascii?Q?UVvJXk38S3o6mpZciIW9lx5Eq8eFNzWh0P3gNT+URd5DWVVwxbqo2cUz7fVQ?=
 =?us-ascii?Q?2EwKvY1bajBrCCa12Ih4GkXRLdzDn5iDX0XmcFYXI4yOZdAHyWnCXbiRrDvz?=
 =?us-ascii?Q?eiKURRFZemLH+3ZgQlcDrhqGiErrfmihwXU3I7caaF1wUla8BmWALjBIpt+b?=
 =?us-ascii?Q?bP3tVbkq2YziZi3qKmMXx7AV6B9xoBcH/rd8WJx2QNbKtWZc2EtdnXfyRVxr?=
 =?us-ascii?Q?eIDttGW4a3J4hq/Gn0EykOFuEc8i3osMC7woAnG6DFLbpX/o18WAb+BF5gC9?=
 =?us-ascii?Q?jyoOM1OlT00UY9CySQ/gRffQJ4SviXCLt5xabuXTfdDCjPDq3DIcBwzaGXZb?=
 =?us-ascii?Q?VtcZI4BmpKd78U/HWoGUwEiJ+ehYjNjAGHpidpyGXUat+4HKXmZlRB00V0yD?=
 =?us-ascii?Q?cPQ7qZip00XXRScxAk1nI3k2EvJV+RZwBYBQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:44:59.2552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b17741-3fe7-43e3-a198-08ddf128a30e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v1:
Removed the pci device id from pci_ids.h file.
Added the vendor id macro as per the suggested method.
Changed the type of the newly added devmem_phys_off variable.
Added to logic to assign offsets for LL and data region blocks
in case more number of channels are enabled than given in
amd_mdb_data struct.
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 132 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a7..48ecfce 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -23,6 +23,11 @@
 #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
 #define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
 
+/* AMD MDB specific defines */
+#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
+#define PCI_DEVICE_ID_AMD_MDB_B054		0xb054
+#define DW_PCIE_AMD_MDB_INVALID_ADDR		(~0ULL)
+
 #define DW_BLOCK(a, b, c) \
 	{ \
 		.bar = a, \
@@ -50,6 +55,7 @@ struct dw_edma_pcie_data {
 	u8				irqs;
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
+	pci_bus_addr_t			devmem_phys_off;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -90,6 +96,89 @@ struct dw_edma_pcie_data {
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
+static void dw_edma_assign_chan_data(struct dw_edma_pcie_data *pdata,
+				     enum pci_barno bar)
+{
+	u16 i;
+	off_t off = 0, offsz = 0x200000;
+	size_t size = 0x800;
+	u16 wr_ch = pdata->wr_ch_cnt;
+	u16 rd_ch = pdata->rd_ch_cnt;
+
+	if (wr_ch <= 2 || rd_ch <= 2)
+		return;
+
+	/* Write channel LL region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->ll_wr[i].bar = bar;
+		pdata->ll_wr[i].off = off;
+		pdata->ll_wr[i].sz = size;
+		off += offsz + size;
+	}
+
+	/* Read channel LL region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->ll_rd[i].bar = bar;
+		pdata->ll_rd[i].off = off;
+		pdata->ll_rd[i].sz = size;
+		off += offsz + size;
+	}
+
+	/* Write channel data region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->dt_wr[i].bar = bar;
+		pdata->dt_wr[i].off = off;
+		pdata->dt_wr[i].sz = size;
+		off += offsz + size;
+	}
+
+	/* Read channel data region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->dt_rd[i].bar = bar;
+		pdata->dt_rd[i].off = off;
+		pdata->dt_rd[i].sz = size;
+		off += offsz + size;
+	}
+}
+
 static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
 {
 	return pci_irq_vector(to_pci_dev(dev), nr);
@@ -121,7 +210,11 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	u16 vsec;
 	u64 off;
 
-	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
+	/*
+	 * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
+	 * of map, channel counts, etc.
+	 */
+	vsec = pci_find_vsec_capability(pdev, pdev->vendor,
 					DW_PCIE_VSEC_DMA_ID);
 	if (!vsec)
 		return;
@@ -155,6 +248,24 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	off <<= 32;
 	off |= val;
 	pdata->rg.off = off;
+
+	/* AMD specific VSEC capability */
+	vsec = pci_find_vsec_capability(pdev, pdev->vendor,
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
@@ -179,6 +290,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
+	vsec_data->devmem_phys_off = DW_PCIE_AMD_MDB_INVALID_ADDR;
 
 	/*
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
@@ -186,6 +298,22 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
+		dw_edma_assign_chan_data(vsec_data, BAR_2);
+	}
+
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
 	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
@@ -367,6 +495,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
+	  (kernel_ulong_t)&amd_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
1.8.3.1


