Return-Path: <dmaengine+bounces-9360-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP5XNP8YsGlAfwIAu9opvQ
	(envelope-from <dmaengine+bounces-9360-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 14:13:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9168C24FC4F
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 14:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB1C531BB160
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0423CFF6C;
	Tue, 10 Mar 2026 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dehqH8wc"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44323CFF52;
	Tue, 10 Mar 2026 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145867; cv=fail; b=CDOdaNI2hsTWvirRLpxOHY+kQ+PLmHYT5aYbMQidmZ8vhjwEbccj9YeiX0sAa9nTNAYyu9c+0EEMqFwRit4hjon/ntL1rLN+pu+BFUY9Sm7SQ4S6Ocx9vN6Qx4px+89gVQqMIIbnuRCTyfr0EUnISuV2URl1Gf6+GvScDk0WX5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145867; c=relaxed/simple;
	bh=aHr5EorojUlEzRxWHImzOAR6F0nAxRmEzCfevsP7/9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X546Zw5kqRrb8j/6uBfkNeCKFThV/R3dTu5awrtLdGL7FCU1WWDCC/1cLDWM/U0/rC8MgJNC0DeZmgJM45At0AOQchKn1y4M3LbagethW4muLji4i+dc/nTnNma/56rTPE0qN+HqwW3DVnCt040L4+uB2uWdM7jDbRDL4/43a4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dehqH8wc; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdydUPUgHZH+8qBZ9HO+syEOURkO0ml++f1aPClm4oiz7ePJtP3952slJFpsYp2uIKOC9WMZRGBgHDw3fXrKnUvs59HR37qanBq9qu5bC88lAfOAH4geBmAJGrFKvLwoJwHq87gW/pKepmzcPno6pOODW+V6I9MifiJr6EWdOyQA5R/fmqf9PFrd2M2obLQ0tFdNO9PnMRMw/C9lTVapE9EGmt3vfI53Z//AZKZ9q+3QWS2P378azqjPzt8u9volPXtZ3eN9HxI6PqBC2fjlmY/4/ZpUDdAPHTgVWW7Wgo0+KsQ1gzynWgyUcah8p2oWGlpMijRdcFUjGV7bBJbqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MqZdqmQyXBkdhZD9icAlzgtv59QcHzEQr02NTJ5HTw=;
 b=Qc+SV0yPQ+7qF3tRVM+QsoLM915VB4hFd8nm1Hwi3fbTRHcUpDmezeQXzwsaALAEabEI6t1Go+sKJvFsVlsAQHdXqIaJiB8vu0yUqQLsPmLLvl/2RLUvIgYuJfKZAUwsqqXdZNJc8AyyjkcqziMuuUhXmNdnZ/GX61MwUcJhXMd6fDOlMXI8fJL89XCwGmQuwzOOVBG4H4WzADHX6gGPnhsFEY9KgdV4q8YMYpqn2iU2bCReJ5Cz5O7iEPTWC8WhMGluJQgY9lw1/MWjQyh9zFOuyU2HBefd3e/g5/wBEBlH94QfGhdLk3m4QGGyQOflqPWLJWpPpB3A9Da1mDjZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MqZdqmQyXBkdhZD9icAlzgtv59QcHzEQr02NTJ5HTw=;
 b=dehqH8wccXVPlMfQ9FZ0RJZngB3DFCV7PMMgxrY06wwjoxLrCy28NZ65VcR5yx7wBRR23L+GoJRmzhMyC+I5vbW3U5IZ1TDCabNgH2+/KmTpm8NZEJxzn3/jzIRSALl5hvnRDqPnXib0S/c5Jb5dbA2qaji7tNNNILS/nH66+uk=
Received: from BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 12:31:02 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::6d) by BY3PR03CA0016.outlook.office365.com
 (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 12:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 12:31:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 07:31:01 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 10 Mar 2026 07:30:59 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v12 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Tue, 10 Mar 2026 18:00:54 +0530
Message-ID: <20260310123055.2863727-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310123055.2863727-1-devendra.verma@amd.com>
References: <20260310123055.2863727-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 677c279d-c856-4b37-9294-08de7ea0e403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|22082099002;
X-Microsoft-Antispam-Message-Info:
	Gik7eOaGnEzJdQ284S4WjfI5K5nppz0jRAyNIkU4ZuDWgaNcCrW8HdT1+XZH+tYOZZT0zK1kMI0FWQ1MwQA/O5IC5+ykXRNKytzOiC7YsQO38akuDRX/gaf1PFS/hVqspLAmaGWXlb9kdxUv0xMzrW1jUF3n/DoVXj2VGnpUOEKOXsTGxOk3QCJtJWJOH1QA09JEtcJBk8IwC64YCHnvdenmvyBI6da5GQLAWVeFH56uGY88ccsvvTMEVUk/LaHBUthzVcdbuIsGU4kgz05dpLZpHC+K7+SiCX3aTUO2vNbzPaAmRlwY8jpyWpEfkJsL4dVrcWcnKqwDJvwyIs7Kox32K38DKrzz7JKVQPS1uLubwlyuxVZDFKZspDVgaWOtn0IdWGARym5cBeIq7RD0hRs7UO4m9AowfQOwsZqSLEYqAuBrCbI5w5E9AIhhU+SplIJMNlVbAXFgXIdynSYEkfEjYYbzsrG+ztXknM1bbGyqFrv7RVO7rqqWQmcM2utj0okVK8beVACH+idCD46nwDnklMYIXieiT5BXoJqTNYpaZSqWnthb80Mo1gkYL8KT4+ybSjk1WYFBx6o6ZJN9N9X5gYVx7shuaHgVa9+eMVR26rKRLnkEuJ/fxIezhnNpGfIf+pY+LXnfLef8eRhhwjtajQumNjmav2kb15sqemxq1Wrr0lBt/EqtndrCVdtY5txXu/iR8upwsTXPsuHTaXnmqzl+VjT3oCOt417PprMUwbSqVJSf18OihnnxYkG0HAfZ/CrowSc/17gbkheC6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MjrkCFMuYkE2sFF4cFKrROsKSu3HL5t5jHqQUBcg2XhVtSYJLSyTNTrEdI94D5ywgmwYTE1rpx1t0vbBPYn9cBWu1y/7Q79sJxGw8MWGJ8EfBiCPJzQTaK/aScqE+uIzkp70rvu4m0v/js/XQ55Gkswv1bzxJuxONQHrgGzULM+JsucFdNFSB01+PuqESxBgagUqDxeN3hEkPv8+E+Fwcclp7JIG1PgdKedzew7dWlElP1dI3rqWbpg6wo1fjSm/t58Wk3o4Dak0Rat04SV2NDtx3CdUBhPIRLK0yamu0KqPtR+Dirt2soFW0+SyqGpSeRo+2a60NXiQSprVUG6Pe6/NiNRJiWbX67XQJOHNwVC0fy5uqY+EfgJZOnlnq/+ziDjr78zVyj4kUJuTcsR/UeueVUNc1lkHpIiq8o+keYP166KOa3kpSrrpd+Uj5i/n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 12:31:01.7674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 677c279d-c856-4b37-9294-08de7ea0e403
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
X-Rspamd-Queue-Id: 9168C24FC4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-9360-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v12:
No Changes

Changes in v11:
Replaced min_t() function with min().

Changes in v10:
For Xilinx VSEC function kept only HDMA map format as
Xilinx only supports HDMA.

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
 drivers/dma/dw-edma/dw-edma-pcie.c | 190 ++++++++++++++++++++++++++---
 1 file changed, 176 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a76d3c..b8208186a250 100644
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
@@ -157,6 +237,64 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
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
+	if (map != EDMA_MF_HDMA_NATIVE)
+		return;
+
+	pdata->mf = map;
+	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
+
+	pci_read_config_dword(pdev, vsec + 0xc, &val);
+	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
+			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
+	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
+			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
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
@@ -184,7 +322,29 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
@@ -367,6 +527,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
+	  (kernel_ulong_t)&xilinx_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
2.43.0


