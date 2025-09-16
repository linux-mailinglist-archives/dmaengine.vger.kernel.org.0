Return-Path: <dmaengine+bounces-6529-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E38BFB593F6
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 12:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE231B221F3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89733043D4;
	Tue, 16 Sep 2025 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="153Wrhsk"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A9302758;
	Tue, 16 Sep 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019414; cv=fail; b=qUyXIG3dVK99sTMxgcUjBnf4y4i7x+CyRnwUjMUEh5DhXMoDjdCJOqSNDMzckhAIcFFwCBgBWj1Asw+9axcrOZ9R0oEjeH3h8tBX5sLC7vYu+Xl/XpLWvZhIaNPAdI4D+qh6eLiCI53TBjX2k4Mrz3vLO33bZVVE3hhxX8GwPDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019414; c=relaxed/simple;
	bh=GyNqAZ3ggVeSdwsVGrbp2FIiX0vexN5StiqXyNxoJr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwENpowvofD+xwto7xRhIbbmajSgJGiw7x+qY960VNDyzUvEB711O9P9J3mYZhYKWlJ1AF1RFCb+9d/KVk4vSP8LTchEDM8tmH38lLhfyInx+MZHwXP1RRyFiuY1YcJUndKiCrzJnotSalDljYRZluuojRplOu879iTwlQKp09g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=153Wrhsk; arc=fail smtp.client-ip=40.93.198.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz34GO6vYPGU6cdJzB6iNOm+XOe2KzcDlEqgATzfjYFZ3ePxI8ZuV+MspNC6gqZct+uPZoJh5KRsp57SEzhfZaK3P0l0/E30RuOjWj/3v4AgJzilJfXcY0knl4A7fBDz6STY5V4Q3WSUhADZ5dazjtkmquh4ZOSoQXWGOWGbCLjaAXDbFdWa+bBZHILRNjHrF68mUvFhZuE3MmAA/BV0wBw9g4Xhss3Uz3oWPR4LQLW0E/Uqw1aGpbqVsi5Af4LdJv2KvYSfFFQm1kBgkRuNNJwsNsTdebaM3xz8aU6KNSE5E5A+d8Sm84U7ssayZJh2+Ob+uUX+CKY5lCPG7a3LNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WJObh6/OoHgwaUDpoHNoY1a5IZxN6qlf/XU54rAKEk=;
 b=VhlLYHIzIGcANOlvvObWF8QO6ERghuniqD51/ymHJavp6HGtqSZBQF1rlBMhv3MsJNUYMJuOg8O68ymZftN3UN3KyCkkqHd4G+eVEucANDR3Yf1JLE3aNxQP7IrJD4oXVBUTzhDghwm0dyUIZ63SGCI06oPRUHYhW1WZYLrDoTIpWPlSZ9LYMRwUhXTTiphpueB5u5cjiVVeDOdW6EnkAIjeMEqrJmuC7TzRSOonV87586DFOfKtleL4u5kK9Es0d4oC5wCcx7O4kj/L4CApx9FLF5ax0nQ/zmlDYTbR/X8GvKNJ9ZOKOH4Zy/q1Podc+TcJxgIzw6jfeeKLJ3qWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WJObh6/OoHgwaUDpoHNoY1a5IZxN6qlf/XU54rAKEk=;
 b=153Wrhskhp3xv1RAqeAfBwiWOdReQ1w6pmI8a+2s/9ewJDzIm9Y1oWwsqOrYn6HJ7tE/l4gMyOa0qGL7+fKkqdkoGUUvT+0fH1CJhGVzUFoJhNNtEBGTU3yxhpVQb6yVvoJ25FPMdvjbiOQQjHG8AFmmyfYwZYCKw/YQN49mZCg=
Received: from BYAPR07CA0021.namprd07.prod.outlook.com (2603:10b6:a02:bc::34)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 10:43:28 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::7a) by BYAPR07CA0021.outlook.office365.com
 (2603:10b6:a02:bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 10:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 10:43:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 03:43:27 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 05:43:26 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 03:43:24 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Tue, 16 Sep 2025 16:13:18 +0530
Message-ID: <20250916104320.9473-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916104320.9473-1-devendra.verma@amd.com>
References: <20250916104320.9473-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcdfb5e-0294-494f-0795-08ddf50ddf0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9CVy1CVDqgHuG3xYHqvDe3ARj6dYhZe/mrWqsEYzzHe6FiEhtOQTM66Kb1mu?=
 =?us-ascii?Q?4RUmxhiE7mPW1VIYTify+tOATTdrSOzA/Y0GoHlHKrBknaQtMvy6rSnPnBBl?=
 =?us-ascii?Q?cwAuiR7KX387uvK4o6FQQUVMNSti7PK+v+vs+mRr1ju7PjE1Ve832mU8AugG?=
 =?us-ascii?Q?CaXGEX956okauRJJQUoKWgdSwvOpA/JvRLo0SATzMtp8Fz3tVb6p5ywUzBXe?=
 =?us-ascii?Q?xu7IyEJkghCuGZ1SAsH3ah7GtCmc4nQmRRzgkzkSr7sA59YMhtVYDMIJCG+e?=
 =?us-ascii?Q?ppmyR2TrB5hkb5TxAyLi1W3qVn0X3jTs7PVP21k2Y15WbZInS4oFSb0Qy10O?=
 =?us-ascii?Q?4slMQ/TC3K1kFtkWNv0mhqg9qQ7y2VBHJkV0CEMPcsUAK4rz0Jw/RN+ES5La?=
 =?us-ascii?Q?HSa4lLUon8+ag2CsJwOv7kdXq3XT0NT1ZXHVp9CZov6MUx5rBYbSZFMD5ZZH?=
 =?us-ascii?Q?S1JBvyK4/wf3s65eT61FxoJPD+08uq1SXbVhUUW58GeGnzQ6fZfX96kIWTB/?=
 =?us-ascii?Q?TbQjxHJLpglNlOzHwt2V8OX2Q8O83PaMrwfTSsDr/dBkdyDvsGbpkrInSjEC?=
 =?us-ascii?Q?P7utPtCDFTBh2iLeUz4Ns2X1I11UTff3RJELtgX2LxlOOvxdHljLCxd54TWP?=
 =?us-ascii?Q?BXkUNK7lwYkEFohdOOmS8RGvgLlRvUwpzzcrihffIpMZuwdBezZLvdZcm/AZ?=
 =?us-ascii?Q?7c/8z0C6TLL4t7GFqnozD0PILue00BV7Nr/zw+AQYtGAGj+v8H7g5a9cjbg6?=
 =?us-ascii?Q?KMrKZ6L0fifiyZLEb4GHAtECNPtU+GSczI9IgfCLZ/QkW+Zmf8BgMABVEtRC?=
 =?us-ascii?Q?wIj0A1+IqlA4bNXrVFpipir5fBil9tCqsmZLcWRUvmA5imGespfKUJfWppUg?=
 =?us-ascii?Q?WK7mgB3WOBdf+SRdIitJ9HOI9Z/givj+xuv/T+mX0U3pflArWzU+Dw9HHtm1?=
 =?us-ascii?Q?GDo0OyCF++TWN0ZmDgabn4D1G6GdoNBXEL0ZIWnK91tSOncjeTEuP1M4/zDh?=
 =?us-ascii?Q?Lejh6sPrZ/EnMsDgFVooqQnhjtMRvS8CaLJf8pADdaFNwFtdQojt4OUF/t4A?=
 =?us-ascii?Q?xnaVdM20Gmmmh2VCNu7OLV8DNZEfjMCmKg01bqIvuZ+nlGCHU55JJfw0k4Va?=
 =?us-ascii?Q?2m/Vm9cJThHxThm2YD8S58ZlYRer9lhooo5SVTJp7RglMVg4v6XGxjZpsrr6?=
 =?us-ascii?Q?facwPFFKoJaoIC99Yi5RM155QidjKUwE8Rh4VBKpX0TJIIul4Cs5Wi9rakkq?=
 =?us-ascii?Q?I9B90O9PGbUSgAAbpaPyKrPa7+wNt9pJaGhm5fCtQC/NJqfP2cSu39ute2HK?=
 =?us-ascii?Q?YNP/17A/EuJa5W1UxLeV7nP7xkviVNOPep6CLLvIcsNqqEiGUCiZ3KuG54VC?=
 =?us-ascii?Q?XwLJPsLTtaorleMdLYFBLgRRjdX6/UgDmIzxPN4B28z6tnhbSVOMQnv/CckR?=
 =?us-ascii?Q?MNUuDBnfTOncnKfA49st0zNmZ/VU8t9rtMC8IBJ/IGVVoSWip1mrnvKI1dAv?=
 =?us-ascii?Q?v3Wlttd3JQBBZeiA84IYQBf3GrKY8LpfFLhl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 10:43:28.0629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcdfb5e-0294-494f-0795-08ddf50ddf0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
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
 drivers/dma/dw-edma/dw-edma-pcie.c | 147 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a7..50f8002 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -17,12 +17,19 @@
 
 #include "dw-edma-core.h"
 
+/* Synopsys */
 #define DW_PCIE_VSEC_DMA_ID			0x6
 #define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
 #define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
 #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
 #define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
 
+/* AMD MDB specific defines */
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
+#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
+#define PCI_DEVICE_ID_AMD_MDB_B054		0xb054
+#define DW_PCIE_AMD_MDB_INVALID_ADDR		(~0ULL)
+
 #define DW_BLOCK(a, b, c) \
 	{ \
 		.bar = a, \
@@ -50,6 +57,7 @@ struct dw_edma_pcie_data {
 	u8				irqs;
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
+	u64				devmem_phys_off;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -90,6 +98,91 @@ struct dw_edma_pcie_data {
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
+static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
+					   enum pci_barno bar, off_t start_off,
+					   off_t off_gap, size_t size)
+{
+	u16 i;
+	off_t off;
+	u16 wr_ch = pdata->wr_ch_cnt;
+	u16 rd_ch = pdata->rd_ch_cnt;
+
+	if (wr_ch <= 2 || rd_ch <= 2)
+		return;
+
+	off = start_off;
+
+	/* Write channel LL region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->ll_wr[i].bar = bar;
+		pdata->ll_wr[i].off = off;
+		pdata->ll_wr[i].sz = size;
+		off += off_gap + size;
+	}
+
+	/* Read channel LL region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->ll_rd[i].bar = bar;
+		pdata->ll_rd[i].off = off;
+		pdata->ll_rd[i].sz = size;
+		off += off_gap + size;
+	}
+
+	/* Write channel data region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->dt_wr[i].bar = bar;
+		pdata->dt_wr[i].off = off;
+		pdata->dt_wr[i].sz = size;
+		off += off_gap + size;
+	}
+
+	/* Read channel data region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->dt_rd[i].bar = bar;
+		pdata->dt_rd[i].off = off;
+		pdata->dt_rd[i].sz = size;
+		off += off_gap + size;
+	}
+}
+
 static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
 {
 	return pci_irq_vector(to_pci_dev(dev), nr);
@@ -120,9 +213,22 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	u32 val, map;
 	u16 vsec;
 	u64 off;
+	u16 vendor = pdev->vendor;
+	int cap;
 
-	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
-					DW_PCIE_VSEC_DMA_ID);
+	/*
+	 * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
+	 * of map, channel counts, etc.
+	 */
+	if (vendor != PCI_VENDOR_ID_SYNOPSYS ||
+	    vendor != PCI_VENDOR_ID_XILINX)
+		return;
+
+	cap = DW_PCIE_VSEC_DMA_ID;
+	if (vendor == PCI_VENDOR_ID_XILINX)
+		cap = DW_PCIE_XILINX_MDB_VSEC_ID;
+
+	vsec = pci_find_vsec_capability(pdev, vendor, cap);
 	if (!vsec)
 		return;
 
@@ -155,6 +261,24 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	off <<= 32;
 	off |= val;
 	pdata->rg.off = off;
+
+	/* AMD specific VSEC capability */
+	vsec = pci_find_vsec_capability(pdev, vendor,
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
@@ -179,6 +303,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
+	vsec_data->devmem_phys_off = DW_PCIE_AMD_MDB_INVALID_ADDR;
 
 	/*
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
@@ -186,6 +311,22 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
+		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0, 0x200000, 0x800);
+	}
+
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
 	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
@@ -367,6 +508,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
+	  (kernel_ulong_t)&amd_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
1.8.3.1


