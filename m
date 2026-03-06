Return-Path: <dmaengine+bounces-9294-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNYiG3fAqmlXWQEAu9opvQ
	(envelope-from <dmaengine+bounces-9294-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 12:54:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1472621FEC2
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 12:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D70530AE24B
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68BB366062;
	Fri,  6 Mar 2026 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HgZY6QdN"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9B367F25;
	Fri,  6 Mar 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797960; cv=fail; b=r4o7xVig0Ve4baiPf5rjii2LqQcByBeITMxfVZfkYx/jZaG4fIwkNl+jw5Henz8igY2LV5DO33IsZgQwb+d90yxu5KwIIBQF8qyGKJ+FQDXB23RRQ70xuhbq/0Y6Bt9lzne+VkLvQV8vPEObhc/kL7SrR6PSqOGj3BL74M7AvEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797960; c=relaxed/simple;
	bh=aVavvT2zR2FnMQkHuUvk8zt5pYprERqJyS94FGHfGqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tepg5cFyxWoRRJVftaBjQ/CQEJtRpFOJzeIHrhWv5XleCiQUb5attzdTXDbUFkP6sqcVSu3o6HMcbVRojHCcGOxWvVLa+UfgudJD5W2wa+jmxNEoiUwhdAkTyMw/OjmXsEMFv4noRihVmLuW37HLPOI7JZtyJorwjCyMs+upnSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HgZY6QdN; arc=fail smtp.client-ip=40.93.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4PyqI1UArxA96byMiKsf20P1VEYnkKtXgglJ7kEWKf6E2NJpOg0dJtsmx8j+UA9HOGQ4DNTfH+GDxHnkdSYxoS2sfle66rl4olIF9z/EN9BH2P2bGJ+IoyQhl98f9ULH1KphBUKMQQZvpDfQfG2ilSK7uUqtN0vKkDE/H17flhSV/NioJfw13bVQnhez6S2n+IjL1MVb723J+2iB+pZWNX5n5MlCmbFGJPOiszqFrFr5CaUEauNNgYZBZJ9S2mh2nwPlm99VgAIVAr+UIcY1U18JRj8DT81JzvT60QbFM33k/5qPEq2DAfwwvlrXDV3Spq3DFY3Z5FH1dTjpha5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovvBdNdQ+PSD5nMK0OPUa3AI69+FFkLnYOnSa3ZPo2k=;
 b=d9wB4Unxj4K8sRrnKpr01v3hnW2OZe9bhghEb1hfKZTlmqVMf3gKcQsJ7y+yBhdU63hIlU+q5igJDcHDHfDCMr8058L9CFWOyUGuqnEQmnW12jdua0JSXWk65mXNPoZgIEJaeEcNDvWtPyYqMHTq2L5pXyEvb93nWV8rs6TKcn9R254Y/CBKGKJDdexKQc8FWUoAkotKZ1oBLtFrcr9N7pCOl/ysPZI/zatnpA6tgdShonJUNSZCwxA6FGWyWSwUP5Dy77bBxWlv/Bvl5p6yg2wSzT0SWR9GB8h78urzeALBtIqAhvf9ZZszMO0f6uCeiXZHkitbLNOjI3/zPSmkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovvBdNdQ+PSD5nMK0OPUa3AI69+FFkLnYOnSa3ZPo2k=;
 b=HgZY6QdNJdQ8nGw4fs0QKmbjsy8TzvgmKD6gWbFa9jTwLPm4HZ6dwm1fkSt8I+9CJM2i2Kraa9qk3eFwVF/6otyzeRWosRQIStISo4OI90yzo1T2/fsnXFIBUEZjzOttpXFRCFs2NGd2MYZ+PPI2yycWV91DLGTf8DBGKYQYNTQ=
Received: from SJ0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:a03:3a1::18)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 11:52:34 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::e0) by SJ0PR03CA0373.outlook.office365.com
 (2603:10b6:a03:3a1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 11:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 11:52:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 05:52:33 -0600
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 6 Mar 2026 05:52:31 -0600
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v11 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Fri, 6 Mar 2026 17:22:27 +0530
Message-ID: <20260306115228.3446528-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306115228.3446528-1-devendra.verma@amd.com>
References: <20260306115228.3446528-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c4667d-e441-4603-b678-08de7b76db27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	Eu7X9FArPkQdwby0s3IBRZRB4D5elhspdWo0LjOlSaLpu/5sHU4ygaAbpMjDTxxC21eEFjpvg58MPsCvwzRYoEvfTIYnMXc6WKW0qKWRoGHx1WzPDFw2eFKFXud69hjbyoHvc6mFj1J4P0kwyM/xdCtqsdR2lXideiqhnJZuZmBGbw0XeTsuopvwZJ+FbcNEbgFgwPnpjaqV+CHQwIgnVnhJ0MKqRuwA9eirXrrB0g995abO2gcWSrAkUYkVMByUCvM11ZANNcFeDqiTFP5ZAB/mOxYE0XCLgTtv81Aq9fEltDjjUsE/EcCnNcZAGHH81/dZDvth86PvIIqzQCM8LmK6k3LFBBoFm6DTuiAIiCpTgY29T3dZPFMUaokLgTnB79e8qCTZ2l2mGdN0+0ib0JyS+gyJcQ7d3S0/mXGn6zIKlvkW0vpxe0BnGHlC2iTZqnl1BsCnc2orIED1yGfssbB91iZDjKq0rgzCxbQO4//TUEtrcLFpRODdirIgPjCShWKcpb4psiA3WYNBU2TdGc2S1YrUEgaK3XBLHD4sLNz8rcQqYHsZbyZltbl2rgH+svQNR2v7aGSWASBiF+f0KLY5EvsSYeCk6urY8mcWVRp+3HFHq0ShwWAFkqXMLWjB7xeC5EF9VQ6EPPQXFFU4NIWa0Rrq+OZIRliAi8+8qmVsgJ2t3k+RpldURvBjAmzyU5Pk64rIY+wlsLByjkRgG679rnRTkEes1NEXUhaZ4wdNe9VER4oZmXjYGa0vMh2dMt9u0BCbOdj8YnPhf5TJ7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LPBjW92V3HPUF51isEOI3y6FvrpmPXMKdCdbeaOXmBTyBf7qMK+p6ZwRfavLzX/mQYa4CiaHz+uOJhBXouCoxju0tcksY9x+o3G19gmsgcCU1tarhMprVfJgXXw3oDUTZShBqr1M5rxqyvgubmz4RTivotsocRplX+KeB+HpO0XjyccGtYV/cNW5r5Zh8cgtgriFaL7KxjmdchUCwUBZplmyna2hhakqFaRuoJBGKzB1/WiI2Ev4D3wA+kqq0VJXOipW5uwiQu5RTll2x+aIDMpTY6H2tCFYz3QhHTETNd+kZvFlmc5Q3oTYDNkIpwvcxHhgNOf85f4EzCkwXaeqWeiRRPSz/SJroEpB0uTY0fCRicF+bmudirGrHmH/ftRWfAxcmivt1uFr/DW6YKV24QmW+Cyoh6xvpLKNrCSjQitzTre9F76pzuHo2AWg6zgU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 11:52:34.5018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c4667d-e441-4603-b678-08de7b76db27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004
X-Rspamd-Queue-Id: 1472621FEC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-9294-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
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


