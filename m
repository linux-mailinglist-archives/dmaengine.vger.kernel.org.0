Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA3C7BE490
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 17:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376766AbjJIPVv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 11:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376366AbjJIPVu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 11:21:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D1E1;
        Mon,  9 Oct 2023 08:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK002E5CB6drvxJrXA++RebA6EGNGVWurzXnYoe5fDPRJvYC7H75Rvio+1jbdtNACsSN5xKG1KPskiuRdgWwYGB7vwb8Zf/SeRge+Hou9/HrbrYXKSSi23t3D3ZvTLLkeI9Ibevz9hEqb6YIqyUOxW+nrUJ9iK4cEINMy+kJrInAUAT0qDs0DscYtvQfkXa7yOTGFTp0u+3sTBFgnvFPYdeDs4wmInPBgq1KSUZMfdXDaKsgTCmzRbEj6J2E65DLWs60OEBp/pQ4HdvyI397MuQFz+SMV1qu2ZOl6Os/Fg5ByjG5j9nwRqIPZVqnPC8ufyMlds4KcDnCxpO9vJD/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiI65325xsHKFcdIhjkTha66JGqVC4U5HgGYkzq5XLw=;
 b=Vb7VMOmaOisowbD6X4KmTgL80TR677o+aB1rCh+m73G77E+Gy0QqGNA4us5RGMtFvM56Ofcx+r4EVAIbWunNmO0N5qkJ1ERImZv6ETYgIYHg1RExHc5fzKdH0CthFSISt6sDbd9ENUWZBgtl+ucjaeRLViFxxNgtlTXoYaTnrJB0iAMhQ4NYNO1hi6347VsrPHhhh/LN0IeZHZ4Tg0ynoTihUp1wiVpWX8ziF0NFxBZ6Ka4CPSv3WDdLZG6lzaLsUFkEq6uilfki5B/cexpzrkqTK20zwtT+k3l3xB9nXe6/n88XKftDQLGC7XC7sdNBTpOOvS9F7s5mVqSLKt2Gbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiI65325xsHKFcdIhjkTha66JGqVC4U5HgGYkzq5XLw=;
 b=2qn1XoPEwmftf4Xg21w/PBv1zVvXsGhtyFOE75zIbO90skBDHrwN9KUpigDwaT6EPaVFma8g1qSeIDJLtFORx/KwJSOVLUJLu/3uAVHRrRfKwmneI+l4+jGqzJoQFCmZ+uTDkXVdd7nnRls7m0IKBxv9wdb3nebQMKjYXnSg6fA=
Received: from SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Mon, 9 Oct
 2023 15:21:38 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::42) by SJ0PR03CA0001.outlook.office365.com
 (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 15:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 15:21:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:21:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:21:37 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 9 Oct 2023 10:21:36 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Nishad Saraf <nishads@amd.com>, <nishad.saraf@amd.com>,
        <sonal.santan@amd.com>, <max.zhen@amd.com>,
        Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V6 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Date:   Mon, 9 Oct 2023 08:21:34 -0700
Message-ID: <1696864894-4860-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696864894-4860-1-git-send-email-lizhi.hou@amd.com>
References: <1696864894-4860-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 20286007-4399-48d6-1c2a-08dbc8db6eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldM0q4PyDplx/4yedLgWkZSJiPwjmK6RoiSGSZzixEJ9+HTHbubzOBzNe1L/KtejEAatSjXj0fh07HzkRZxcznP2INkO0pBtTV95jyZjX1aQsOIzuRtmhb/z4llz6KXhPzwwHPaIoVWvWu6tRuZnjaY5PTs2chCUHq3rjK/u2cCorfAwULe3Go+6LNKOtGIkNSirwAxiHt673gqA8ecdm8I8XTYuvEkCasnUguc/DcOZ1jlnU8FHDLBXJx7QD7jLVLUkwJBRbqqzn082oTmBW9Eb0kJWx0HmmQlWNQFHMceSrWjuoObj9MSxQiGhIZsJJ8Z5PVa3nKMxjFd5rgf5EOOLNTVlVkw8GWynORW5/PSj7qenJDRwN/oezXAk+Axsj4YQKmTY68xGPRxYpFe9pYh9oeoaARfsKprUnfKLRLS5UuHXWrhw0lF5dZuQXQB1A0ZyGee3XY2zn2IMgjQ6BTzhQWNm1j8VphQ3x2p14iJm09zY0cwjcHD7CnFKK2I4DFnC4S8GreqBd6H9evbZkeh6xnw+BrGJlE1/y+aRWhzI825sd8hwz6L7QrFs0gWocQ8OStoiOtv3NVOx0neJzJLJxnpiyd5OKtJNrCyrwDeimvf2Evl7HCdr8yt1RigFqjoxOfWPBvuUSE6ZUYhy6j1c8weQUaWc7wddB6mVMOnbLa6tA34TeyFz+IOuDhIeQ3YhGpMs8BCA2QPUhaH7ypOIhrQ5rlvastUS368gwOcmgg/dlWV8tG4ZufhIZbm/zgW520/qDW8gxvuxJjdlCcgBfnfl+J/1K7T1ogZ3BxU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(70586007)(316002)(54906003)(41300700001)(336012)(356005)(26005)(2616005)(36756003)(426003)(36860700001)(966005)(478600001)(82740400003)(83380400001)(86362001)(47076005)(40480700001)(110136005)(70206006)(30864003)(81166007)(44832011)(4326008)(8936002)(5660300002)(2906002)(8676002)(36900700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:21:38.3006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20286007-4399-48d6-1c2a-08dbc8db6eb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nishad Saraf <nishads@amd.com>

Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
Accelerator devices.
    https://www.xilinx.com/applications/data-center/v70.html

The QDMA subsystem is used in conjunction with the PCI Express IP block
to provide high performance data transfer between host memory and the
card's DMA subsystem.

            +-------+       +-------+       +-----------+
   PCIe     |       |       |       |       |           |
   Tx/Rx    |       |       |       |  AXI  |           |
 <=======>  | PCIE  | <===> | QDMA  | <====>| User Logic|
            |       |       |       |       |           |
            +-------+       +-------+       +-----------+

The primary mechanism to transfer data using the QDMA is for the QDMA
engine to operate on instructions (descriptors) provided by the host
operating system. Using the descriptors, the QDMA can move data in both
the Host to Card (H2C) direction, or the Card to Host (C2H) direction.
The QDMA provides a per-queue basis option whether DMA traffic goes
to an AXI4 memory map (MM) interface or to an AXI4-Stream interface.

The hardware detail is provided by
    https://docs.xilinx.com/r/en-US/pg302-qdma

Implements dmaengine APIs to support MM DMA transfers.
- probe the available DMA channels
- use dma_slave_map for channel lookup
- use virtual channel to manage dmaengine tx descriptors
- implement device_prep_slave_sg callback to handle host scatter gather
  list
- implement descriptor metadata operations to set device address for DMA
  transfer

Signed-off-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 MAINTAINERS                            |    9 +
 drivers/dma/Kconfig                    |   13 +
 drivers/dma/Makefile                   |    1 +
 drivers/dma/amd/Makefile               |    8 +
 drivers/dma/amd/qdma-comm-regs.c       |   66 ++
 drivers/dma/amd/qdma.c                 | 1187 ++++++++++++++++++++++++
 drivers/dma/amd/qdma.h                 |  269 ++++++
 include/linux/platform_data/amd_qdma.h |   36 +
 8 files changed, 1589 insertions(+)
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma.c
 create mode 100644 drivers/dma/amd/qdma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 81d5fc0bba68..803a9909ceb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1048,6 +1048,15 @@ L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	drivers/dma/ptdma/
 
+AMD QDMA DRIVER
+M:	Nishad Saraf <nishads@amd.com>
+M:	Lizhi Hou <lizhi.hou@amd.com>
+L:	dmaengine@vger.kernel.org
+S:	Supported
+F:	drivers/dma/amd/qdma.c
+F:	drivers/dma/amd/qdma.h
+F:	include/linux/platform_data/amd_qdma.h
+
 AMD SEATTLE DEVICE TREE SUPPORT
 M:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 M:	Tom Lendacky <thomas.lendacky@amd.com>
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 4ccae1a3b884..9b2d9f42c5a8 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -85,6 +85,19 @@ config AMCC_PPC440SPE_ADMA
 	help
 	  Enable support for the AMCC PPC440SPe RAID engines.
 
+config AMD_QDMA
+	tristate "AMD Queue-based DMA"
+	depends on HAS_IOMEM
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	select REGMAP_MMIO
+	help
+	  Enable support for the AMD Queue-based DMA subsystem. The primary
+	  mechanism to transfer data using the QDMA is for the QDMA engine to
+	  operate on instructions (descriptors) provided by the host operating
+	  system. Using the descriptors, the QDMA can move data in either the
+	  Host to Card (H2C) direction or the Card to Host (C2H) direction.
+
 config APPLE_ADMAC
 	tristate "Apple ADMAC support"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 83553a97a010..f1b4ce468a9b 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
 obj-$(CONFIG_INTEL_LDMA) += lgm/
 
+obj-y += amd/
 obj-y += mediatek/
 obj-y += qcom/
 obj-y += ti/
diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
new file mode 100644
index 000000000000..ba53971d2714
--- /dev/null
+++ b/drivers/dma/amd/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2023, Advanced Micro Devices, Inc.
+#
+
+obj-$(CONFIG_AMD_QDMA)			+= amd-qdma.o
+
+amd-qdma-$(CONFIG_AMD_QDMA)		:= qdma.o qdma-comm-regs.o
diff --git a/drivers/dma/amd/qdma-comm-regs.c b/drivers/dma/amd/qdma-comm-regs.c
new file mode 100644
index 000000000000..59d66b2fec54
--- /dev/null
+++ b/drivers/dma/amd/qdma-comm-regs.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DMA header for AMD CPM5 Queue-based DMA Subsystem variant
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef __QDMA_REGS_DEF_H
+#define __QDMA_REGS_DEF_H
+
+#include "qdma.h"
+
+const struct qdma_reg qdma_regos_default[QDMA_REGO_MAX] = {
+	[QDMA_REGO_CTXT_DATA] = QDMA_REGO(0x804, 8),
+	[QDMA_REGO_CTXT_CMD] = QDMA_REGO(0x844, 1),
+	[QDMA_REGO_CTXT_MASK] = QDMA_REGO(0x824, 8),
+	[QDMA_REGO_MM_H2C_CTRL] = QDMA_REGO(0x1004, 1),
+	[QDMA_REGO_MM_C2H_CTRL] = QDMA_REGO(0x1204, 1),
+	[QDMA_REGO_QUEUE_COUNT] = QDMA_REGO(0x120, 1),
+	[QDMA_REGO_RING_SIZE] = QDMA_REGO(0x204, 1),
+	[QDMA_REGO_H2C_PIDX] = QDMA_REGO(0x18004, 1),
+	[QDMA_REGO_C2H_PIDX] = QDMA_REGO(0x18008, 1),
+	[QDMA_REGO_INTR_CIDX] = QDMA_REGO(0x18000, 1),
+	[QDMA_REGO_FUNC_ID] = QDMA_REGO(0x12c, 1),
+	[QDMA_REGO_ERR_INT] = QDMA_REGO(0xb04, 1),
+	[QDMA_REGO_ERR_STAT] = QDMA_REGO(0x248, 1),
+};
+
+const struct qdma_reg_field qdma_regfs_default[QDMA_REGF_MAX] = {
+	/* QDMA_REGO_CTXT_DATA fields */
+	[QDMA_REGF_IRQ_ENABLE] = QDMA_REGF(53, 53),
+	[QDMA_REGF_WBK_ENABLE] = QDMA_REGF(52, 52),
+	[QDMA_REGF_WBI_CHECK] = QDMA_REGF(34, 34),
+	[QDMA_REGF_IRQ_ARM] = QDMA_REGF(16, 16),
+	[QDMA_REGF_IRQ_VEC] = QDMA_REGF(138, 128),
+	[QDMA_REGF_IRQ_AGG] = QDMA_REGF(139, 139),
+	[QDMA_REGF_WBI_INTVL_ENABLE] = QDMA_REGF(35, 35),
+	[QDMA_REGF_MRKR_DISABLE] = QDMA_REGF(62, 62),
+	[QDMA_REGF_QUEUE_ENABLE] = QDMA_REGF(32, 32),
+	[QDMA_REGF_QUEUE_MODE] = QDMA_REGF(63, 63),
+	[QDMA_REGF_DESC_BASE] = QDMA_REGF(127, 64),
+	[QDMA_REGF_DESC_SIZE] = QDMA_REGF(49, 48),
+	[QDMA_REGF_RING_ID] = QDMA_REGF(47, 44),
+	[QDMA_REGF_QUEUE_BASE] = QDMA_REGF(11, 0),
+	[QDMA_REGF_QUEUE_MAX] = QDMA_REGF(44, 32),
+	[QDMA_REGF_FUNCTION_ID] = QDMA_REGF(24, 17),
+	[QDMA_REGF_INTR_AGG_BASE] = QDMA_REGF(66, 15),
+	[QDMA_REGF_INTR_VECTOR] = QDMA_REGF(11, 1),
+	[QDMA_REGF_INTR_SIZE] = QDMA_REGF(69, 67),
+	[QDMA_REGF_INTR_VALID] = QDMA_REGF(0, 0),
+	[QDMA_REGF_INTR_COLOR] = QDMA_REGF(14, 14),
+	[QDMA_REGF_INTR_FUNCTION_ID] = QDMA_REGF(125, 114),
+	/* QDMA_REGO_CTXT_CMD fields */
+	[QDMA_REGF_CMD_INDX] = QDMA_REGF(19, 7),
+	[QDMA_REGF_CMD_CMD] = QDMA_REGF(6, 5),
+	[QDMA_REGF_CMD_TYPE] = QDMA_REGF(4, 1),
+	[QDMA_REGF_CMD_BUSY] = QDMA_REGF(0, 0),
+	/* QDMA_REGO_QUEUE_COUNT fields */
+	[QDMA_REGF_QUEUE_COUNT] = QDMA_REGF(11, 0),
+	/* QDMA_REGO_ERR_INT fields */
+	[QDMA_REGF_ERR_INT_FUNC] = QDMA_REGF(11, 0),
+	[QDMA_REGF_ERR_INT_VEC] = QDMA_REGF(22, 12),
+	[QDMA_REGF_ERR_INT_ARM] = QDMA_REGF(24, 24),
+};
+
+#endif	/* __QDMA_CPM5_H */
diff --git a/drivers/dma/amd/qdma.c b/drivers/dma/amd/qdma.c
new file mode 100644
index 000000000000..c1a7794b5f33
--- /dev/null
+++ b/drivers/dma/amd/qdma.c
@@ -0,0 +1,1187 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DMA driver for AMD Queue-based DMA Subsystem
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/dmaengine.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/dma-map-ops.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/amd_qdma.h>
+#include <linux/regmap.h>
+
+#include "../virt-dma.h"
+#include "qdma.h"
+
+#define CHAN_STR(q)		(((q)->dir == DMA_MEM_TO_DEV) ? "H2C" : "C2H")
+#define QDMA_REG_OFF(d, r)	((d)->roffs[r].off)
+
+/* MMIO regmap config for all QDMA registers */
+static const struct regmap_config qdma_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static inline struct qdma_queue *to_qdma_queue(struct dma_chan *chan)
+{
+	return container_of(chan, struct qdma_queue, vchan.chan);
+}
+
+static inline struct qdma_mm_vdesc *to_qdma_vdesc(struct virt_dma_desc *vdesc)
+{
+	return container_of(vdesc, struct qdma_mm_vdesc, vdesc);
+}
+
+static inline u32 qdma_get_intr_ring_idx(struct qdma_device *qdev)
+{
+	u32 idx;
+
+	idx = qdev->qintr_rings[qdev->qintr_ring_idx++].ridx;
+	qdev->qintr_ring_idx %= qdev->qintr_ring_num;
+
+	return idx;
+}
+
+static u64 qdma_get_field(const struct qdma_device *qdev, const u32 *data,
+			  enum qdma_reg_fields field)
+{
+	const struct qdma_reg_field *f = &qdev->rfields[field];
+	u16 low_pos, hi_pos, low_bit, hi_bit;
+	u64 value = 0, mask;
+
+	low_pos = f->lsb / BITS_PER_TYPE(*data);
+	hi_pos = f->msb / BITS_PER_TYPE(*data);
+
+	if (low_pos == hi_pos) {
+		low_bit = f->lsb % BITS_PER_TYPE(*data);
+		hi_bit = f->msb % BITS_PER_TYPE(*data);
+		mask = GENMASK(hi_bit, low_bit);
+		value = (data[low_pos] & mask) >> low_bit;
+	} else if (hi_pos == low_pos + 1) {
+		low_bit = f->lsb % BITS_PER_TYPE(*data);
+		hi_bit = low_bit + (f->msb - f->lsb);
+		value = ((u64)data[hi_pos] << BITS_PER_TYPE(*data)) |
+			data[low_pos];
+		mask = GENMASK_ULL(hi_bit, low_bit);
+		value = (value & mask) >> low_bit;
+	} else {
+		hi_bit = f->msb % BITS_PER_TYPE(*data);
+		mask = GENMASK(hi_bit, 0);
+		value = data[hi_pos] & mask;
+		low_bit = f->msb - f->lsb - hi_bit;
+		value <<= low_bit;
+		low_bit -= 32;
+		value |= (u64)data[hi_pos - 1] << low_bit;
+		mask = GENMASK(31, 32 - low_bit);
+		value |= (data[hi_pos - 2] & mask) >> low_bit;
+	}
+
+	return value;
+}
+
+static void qdma_set_field(const struct qdma_device *qdev, u32 *data,
+			   enum qdma_reg_fields field, u64 value)
+{
+	const struct qdma_reg_field *f = &qdev->rfields[field];
+	u16 low_pos, hi_pos, low_bit;
+
+	low_pos = f->lsb / BITS_PER_TYPE(*data);
+	hi_pos = f->msb / BITS_PER_TYPE(*data);
+	low_bit = f->lsb % BITS_PER_TYPE(*data);
+
+	data[low_pos++] |= value << low_bit;
+	if (low_pos <= hi_pos)
+		data[low_pos++] |= (u32)(value >> (32 - low_bit));
+	if (low_pos <= hi_pos)
+		data[low_pos] |= (u32)(value >> (64 - low_bit));
+}
+
+static inline int qdma_reg_write(const struct qdma_device *qdev,
+				 const u32 *data, enum qdma_regs reg)
+{
+	const struct qdma_reg *r = &qdev->roffs[reg];
+	int ret;
+
+	if (r->count > 1)
+		ret = regmap_bulk_write(qdev->regmap, r->off, data, r->count);
+	else
+		ret = regmap_write(qdev->regmap, r->off, *data);
+
+	return ret;
+}
+
+static inline int qdma_reg_read(const struct qdma_device *qdev, u32 *data,
+				enum qdma_regs reg)
+{
+	const struct qdma_reg *r = &qdev->roffs[reg];
+	int ret;
+
+	if (r->count > 1)
+		ret = regmap_bulk_read(qdev->regmap, r->off, data, r->count);
+	else
+		ret = regmap_read(qdev->regmap, r->off, data);
+
+	return ret;
+}
+
+static int qdma_context_cmd_execute(const struct qdma_device *qdev,
+				    enum qdma_ctxt_type type,
+				    enum qdma_ctxt_cmd cmd, u16 index)
+{
+	u32 value = 0;
+	int ret;
+
+	qdma_set_field(qdev, &value, QDMA_REGF_CMD_INDX, index);
+	qdma_set_field(qdev, &value, QDMA_REGF_CMD_CMD, cmd);
+	qdma_set_field(qdev, &value, QDMA_REGF_CMD_TYPE, type);
+
+	ret = qdma_reg_write(qdev, &value, QDMA_REGO_CTXT_CMD);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(qdev->regmap,
+				       QDMA_REG_OFF(qdev, QDMA_REGO_CTXT_CMD),
+				       value,
+				       !qdma_get_field(qdev, &value,
+						       QDMA_REGF_CMD_BUSY),
+				       QDMA_POLL_INTRVL_US,
+				       QDMA_POLL_TIMEOUT_US);
+	if (ret) {
+		qdma_err(qdev, "Context command execution timed out");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qdma_context_write_data(const struct qdma_device *qdev,
+				   const u32 *data)
+{
+	u32 mask[QDMA_CTXT_REGMAP_LEN];
+	int ret;
+
+	memset(mask, ~0, sizeof(mask));
+
+	ret = qdma_reg_write(qdev, mask, QDMA_REGO_CTXT_MASK);
+	if (ret)
+		return ret;
+
+	ret = qdma_reg_write(qdev, data, QDMA_REGO_CTXT_DATA);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void qdma_prep_sw_desc_context(const struct qdma_device *qdev,
+				      const struct qdma_ctxt_sw_desc *ctxt,
+				      u32 *data)
+{
+	memset(data, 0, QDMA_CTXT_REGMAP_LEN * sizeof(*data));
+	qdma_set_field(qdev, data, QDMA_REGF_DESC_BASE, ctxt->desc_base);
+	qdma_set_field(qdev, data, QDMA_REGF_IRQ_VEC, ctxt->vec);
+	qdma_set_field(qdev, data, QDMA_REGF_FUNCTION_ID, qdev->fid);
+
+	qdma_set_field(qdev, data, QDMA_REGF_DESC_SIZE, QDMA_DESC_SIZE_32B);
+	qdma_set_field(qdev, data, QDMA_REGF_RING_ID, QDMA_DEFAULT_RING_ID);
+	qdma_set_field(qdev, data, QDMA_REGF_QUEUE_MODE, QDMA_QUEUE_OP_MM);
+	qdma_set_field(qdev, data, QDMA_REGF_IRQ_ENABLE, 1);
+	qdma_set_field(qdev, data, QDMA_REGF_WBK_ENABLE, 1);
+	qdma_set_field(qdev, data, QDMA_REGF_WBI_CHECK, 1);
+	qdma_set_field(qdev, data, QDMA_REGF_IRQ_ARM, 1);
+	qdma_set_field(qdev, data, QDMA_REGF_IRQ_AGG, 1);
+	qdma_set_field(qdev, data, QDMA_REGF_WBI_INTVL_ENABLE, 1);
+	qdma_set_field(qdev, data, QDMA_REGF_QUEUE_ENABLE, 1);
+	qdma_set_field(qdev, data, QDMA_REGF_MRKR_DISABLE, 1);
+}
+
+static void qdma_prep_intr_context(const struct qdma_device *qdev,
+				   const struct qdma_ctxt_intr *ctxt,
+				   u32 *data)
+{
+	memset(data, 0, QDMA_CTXT_REGMAP_LEN * sizeof(*data));
+	qdma_set_field(qdev, data, QDMA_REGF_INTR_AGG_BASE, ctxt->agg_base);
+	qdma_set_field(qdev, data, QDMA_REGF_INTR_VECTOR, ctxt->vec);
+	qdma_set_field(qdev, data, QDMA_REGF_INTR_SIZE, ctxt->size);
+	qdma_set_field(qdev, data, QDMA_REGF_INTR_VALID, ctxt->valid);
+	qdma_set_field(qdev, data, QDMA_REGF_INTR_COLOR, ctxt->color);
+	qdma_set_field(qdev, data, QDMA_REGF_INTR_FUNCTION_ID, qdev->fid);
+}
+
+static void qdma_prep_fmap_context(const struct qdma_device *qdev,
+				   const struct qdma_ctxt_fmap *ctxt,
+				   u32 *data)
+{
+	memset(data, 0, QDMA_CTXT_REGMAP_LEN * sizeof(*data));
+	qdma_set_field(qdev, data, QDMA_REGF_QUEUE_BASE, ctxt->qbase);
+	qdma_set_field(qdev, data, QDMA_REGF_QUEUE_MAX, ctxt->qmax);
+}
+
+/*
+ * Program the indirect context register space
+ *
+ * Once the queue is enabled, context is dynamically updated by hardware. Any
+ * modification of the context through this API when the queue is enabled can
+ * result in unexpected behavior. Reading the context when the queue is enabled
+ * is not recommended as it can result in reduced performance.
+ */
+static int qdma_prog_context(struct qdma_device *qdev, enum qdma_ctxt_type type,
+			     enum qdma_ctxt_cmd cmd, u16 index, u32 *ctxt)
+{
+	int ret;
+
+	mutex_lock(&qdev->ctxt_lock);
+	if (cmd == QDMA_CTXT_WRITE) {
+		ret = qdma_context_write_data(qdev, ctxt);
+		if (ret)
+			goto failed;
+	}
+
+	ret = qdma_context_cmd_execute(qdev, type, cmd, index);
+	if (ret)
+		goto failed;
+
+	if (cmd == QDMA_CTXT_READ) {
+		ret = qdma_reg_read(qdev, ctxt, QDMA_REGO_CTXT_DATA);
+		if (ret)
+			goto failed;
+	}
+
+failed:
+	mutex_unlock(&qdev->ctxt_lock);
+
+	return ret;
+}
+
+static int qdma_check_queue_status(struct qdma_device *qdev,
+				   enum dma_transfer_direction dir, u16 qid)
+{
+	u32 status, data[QDMA_CTXT_REGMAP_LEN] = {0};
+	enum qdma_ctxt_type type;
+	int ret;
+
+	if (dir == DMA_MEM_TO_DEV)
+		type = QDMA_CTXT_DESC_SW_H2C;
+	else
+		type = QDMA_CTXT_DESC_SW_C2H;
+
+	ret = qdma_prog_context(qdev, type, QDMA_CTXT_READ, qid, data);
+	if (ret)
+		return ret;
+
+	status = qdma_get_field(qdev, data, QDMA_REGF_QUEUE_ENABLE);
+	if (status) {
+		qdma_err(qdev, "queue %d already in use", qid);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int qdma_clear_queue_context(const struct qdma_queue *queue)
+{
+	enum qdma_ctxt_type h2c_types[] = { QDMA_CTXT_DESC_SW_H2C,
+					    QDMA_CTXT_DESC_HW_H2C,
+					    QDMA_CTXT_DESC_CR_H2C,
+					    QDMA_CTXT_PFTCH, };
+	enum qdma_ctxt_type c2h_types[] = { QDMA_CTXT_DESC_SW_C2H,
+					    QDMA_CTXT_DESC_HW_C2H,
+					    QDMA_CTXT_DESC_CR_C2H,
+					    QDMA_CTXT_PFTCH, };
+	struct qdma_device *qdev = queue->qdev;
+	enum qdma_ctxt_type *type;
+	int ret, num, i;
+
+	if (queue->dir == DMA_MEM_TO_DEV) {
+		type = h2c_types;
+		num = ARRAY_SIZE(h2c_types);
+	} else {
+		type = c2h_types;
+		num = ARRAY_SIZE(c2h_types);
+	}
+	for (i = 0; i < num; i++) {
+		ret = qdma_prog_context(qdev, type[i], QDMA_CTXT_CLEAR,
+					queue->qid, NULL);
+		if (ret) {
+			qdma_err(qdev, "Failed to clear ctxt %d", type[i]);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int qdma_setup_fmap_context(struct qdma_device *qdev)
+{
+	u32 ctxt[QDMA_CTXT_REGMAP_LEN];
+	struct qdma_ctxt_fmap fmap;
+	int ret;
+
+	ret = qdma_prog_context(qdev, QDMA_CTXT_FMAP, QDMA_CTXT_CLEAR,
+				qdev->fid, NULL);
+	if (ret) {
+		qdma_err(qdev, "Failed clearing context");
+		return ret;
+	}
+
+	fmap.qbase = 0;
+	fmap.qmax = qdev->chan_num * 2;
+	qdma_prep_fmap_context(qdev, &fmap, ctxt);
+	ret = qdma_prog_context(qdev, QDMA_CTXT_FMAP, QDMA_CTXT_WRITE,
+				qdev->fid, ctxt);
+	if (ret)
+		qdma_err(qdev, "Failed setup fmap, ret %d", ret);
+
+	return ret;
+}
+
+static int qdma_setup_queue_context(struct qdma_device *qdev,
+				    const struct qdma_ctxt_sw_desc *sw_desc,
+				    enum dma_transfer_direction dir, u16 qid)
+{
+	u32 ctxt[QDMA_CTXT_REGMAP_LEN];
+	enum qdma_ctxt_type type;
+	int ret;
+
+	if (dir == DMA_MEM_TO_DEV)
+		type = QDMA_CTXT_DESC_SW_H2C;
+	else
+		type = QDMA_CTXT_DESC_SW_C2H;
+
+	qdma_prep_sw_desc_context(qdev, sw_desc, ctxt);
+	/* Setup SW descriptor context */
+	ret = qdma_prog_context(qdev, type, QDMA_CTXT_WRITE, qid, ctxt);
+	if (ret)
+		qdma_err(qdev, "Failed setup SW desc ctxt for queue: %d", qid);
+
+	return ret;
+}
+
+/*
+ * Enable or disable memory-mapped DMA engines
+ * 1: enable, 0: disable
+ */
+static int qdma_sgdma_control(struct qdma_device *qdev, u32 ctrl)
+{
+	int ret;
+
+	ret = qdma_reg_write(qdev, &ctrl, QDMA_REGO_MM_H2C_CTRL);
+	ret |= qdma_reg_write(qdev, &ctrl, QDMA_REGO_MM_C2H_CTRL);
+
+	return ret;
+}
+
+static int qdma_get_hw_info(struct qdma_device *qdev)
+{
+	struct qdma_platdata *pdata = dev_get_platdata(&qdev->pdev->dev);
+	u32 value = 0;
+	int ret;
+
+	ret = qdma_reg_read(qdev, &value, QDMA_REGO_QUEUE_COUNT);
+	if (ret)
+		return ret;
+
+	value = qdma_get_field(qdev, &value, QDMA_REGF_QUEUE_COUNT) + 1;
+	if (pdata->max_mm_channels * 2 > value) {
+		qdma_err(qdev, "not enough hw queues %d", value);
+		return -EINVAL;
+	}
+	qdev->chan_num = pdata->max_mm_channels;
+
+	ret = qdma_reg_read(qdev, &qdev->fid, QDMA_REGO_FUNC_ID);
+	if (ret)
+		return ret;
+
+	qdma_info(qdev, "max channel %d, function id %d",
+		  qdev->chan_num, qdev->fid);
+
+	return 0;
+}
+
+static inline int qdma_update_pidx(const struct qdma_queue *queue, u16 pidx)
+{
+	struct qdma_device *qdev = queue->qdev;
+
+	return regmap_write(qdev->regmap, queue->pidx_reg,
+			    pidx | QDMA_QUEUE_ARM_BIT);
+}
+
+static inline int qdma_update_cidx(const struct qdma_queue *queue,
+				   u16 ridx, u16 cidx)
+{
+	struct qdma_device *qdev = queue->qdev;
+
+	return regmap_write(qdev->regmap, queue->cidx_reg,
+			    ((u32)ridx << 16) | cidx);
+}
+
+/**
+ * qdma_free_vdesc - Free descriptor
+ * @vdesc: Virtual DMA descriptor
+ */
+static void qdma_free_vdesc(struct virt_dma_desc *vdesc)
+{
+	struct qdma_mm_vdesc *vd = to_qdma_vdesc(vdesc);
+
+	kfree(vd);
+}
+
+static int qdma_alloc_queues(struct qdma_device *qdev,
+			     enum dma_transfer_direction dir)
+{
+	struct qdma_queue *q, **queues;
+	u32 i, pidx_base;
+	int ret;
+
+	if (dir == DMA_MEM_TO_DEV) {
+		queues = &qdev->h2c_queues;
+		pidx_base = QDMA_REG_OFF(qdev, QDMA_REGO_H2C_PIDX);
+	} else {
+		queues = &qdev->c2h_queues;
+		pidx_base = QDMA_REG_OFF(qdev, QDMA_REGO_C2H_PIDX);
+	}
+
+	*queues = devm_kcalloc(&qdev->pdev->dev, qdev->chan_num, sizeof(*q),
+			       GFP_KERNEL);
+	if (!*queues)
+		return -ENOMEM;
+
+	for (i = 0; i < qdev->chan_num; i++) {
+		ret = qdma_check_queue_status(qdev, dir, i);
+		if (ret)
+			return ret;
+
+		q = &(*queues)[i];
+		q->ring_size = QDMA_DEFAULT_RING_SIZE;
+		q->idx_mask = q->ring_size - 2;
+		q->qdev = qdev;
+		q->dir = dir;
+		q->qid = i;
+		q->pidx_reg = pidx_base + i * QDMA_DMAP_REG_STRIDE;
+		q->cidx_reg = QDMA_REG_OFF(qdev, QDMA_REGO_INTR_CIDX) +
+				i * QDMA_DMAP_REG_STRIDE;
+		q->vchan.desc_free = qdma_free_vdesc;
+		vchan_init(&q->vchan, &qdev->dma_dev);
+	}
+
+	return 0;
+}
+
+static int qdma_device_verify(struct qdma_device *qdev)
+{
+	u32 value;
+	int ret;
+
+	ret = regmap_read(qdev->regmap, QDMA_IDENTIFIER_REGOFF, &value);
+	if (ret)
+		return ret;
+
+	value = FIELD_GET(QDMA_IDENTIFIER_MASK, value);
+	if (value != QDMA_IDENTIFIER) {
+		qdma_err(qdev, "Invalid identifier");
+		return -ENODEV;
+	}
+	qdev->rfields = qdma_regfs_default;
+	qdev->roffs = qdma_regos_default;
+
+	return 0;
+}
+
+static int qdma_device_setup(struct qdma_device *qdev)
+{
+	struct device *dev = &qdev->pdev->dev;
+	u32 ring_sz = QDMA_DEFAULT_RING_SIZE;
+	int ret = 0;
+
+	while (dev && get_dma_ops(dev))
+		dev = dev->parent;
+	if (!dev) {
+		qdma_err(qdev, "dma device not found");
+		return -EINVAL;
+	}
+	set_dma_ops(&qdev->pdev->dev, get_dma_ops(dev));
+
+	ret = qdma_setup_fmap_context(qdev);
+	if (ret) {
+		qdma_err(qdev, "Failed setup fmap context");
+		return ret;
+	}
+
+	/* Setup global ring buffer size at QDMA_DEFAULT_RING_ID index */
+	ret = qdma_reg_write(qdev, &ring_sz, QDMA_REGO_RING_SIZE);
+	if (ret) {
+		qdma_err(qdev, "Failed to setup ring %d of size %ld",
+			 QDMA_DEFAULT_RING_ID, QDMA_DEFAULT_RING_SIZE);
+		return ret;
+	}
+
+	/* Enable memory-mapped DMA engine in both directions */
+	ret = qdma_sgdma_control(qdev, 1);
+	if (ret) {
+		qdma_err(qdev, "Failed to SGDMA with error %d", ret);
+		return ret;
+	}
+
+	ret = qdma_alloc_queues(qdev, DMA_MEM_TO_DEV);
+	if (ret) {
+		qdma_err(qdev, "Failed to alloc H2C queues, ret %d", ret);
+		return ret;
+	}
+
+	ret = qdma_alloc_queues(qdev, DMA_DEV_TO_MEM);
+	if (ret) {
+		qdma_err(qdev, "Failed to alloc C2H queues, ret %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * qdma_free_queue_resources() - Free queue resources
+ * @chan: DMA channel
+ */
+static void qdma_free_queue_resources(struct dma_chan *chan)
+{
+	struct qdma_queue *queue = to_qdma_queue(chan);
+	struct qdma_device *qdev = queue->qdev;
+	struct device *dev = qdev->dma_dev.dev;
+
+	qdma_clear_queue_context(queue);
+	vchan_free_chan_resources(&queue->vchan);
+	dma_free_coherent(dev, queue->ring_size * QDMA_MM_DESC_SIZE,
+			  queue->desc_base, queue->dma_desc_base);
+}
+
+/**
+ * qdma_alloc_queue_resources() - Allocate queue resources
+ * @chan: DMA channel
+ */
+static int qdma_alloc_queue_resources(struct dma_chan *chan)
+{
+	struct qdma_queue *queue = to_qdma_queue(chan);
+	struct qdma_device *qdev = queue->qdev;
+	struct qdma_ctxt_sw_desc desc;
+	size_t size;
+	int ret;
+
+	ret = qdma_clear_queue_context(queue);
+	if (ret)
+		return ret;
+
+	size = queue->ring_size * QDMA_MM_DESC_SIZE;
+	queue->desc_base = dma_alloc_coherent(qdev->dma_dev.dev, size,
+					      &queue->dma_desc_base,
+					      GFP_KERNEL);
+	if (!queue->desc_base) {
+		qdma_err(qdev, "Failed to allocate descriptor ring");
+		return -ENOMEM;
+	}
+
+	/* Setup SW descriptor queue context for DMA memory map */
+	desc.vec = qdma_get_intr_ring_idx(qdev);
+	desc.desc_base = queue->dma_desc_base;
+	ret = qdma_setup_queue_context(qdev, &desc, queue->dir, queue->qid);
+	if (ret) {
+		qdma_err(qdev, "Failed to setup SW desc ctxt for %s",
+			 chan->name);
+		dma_free_coherent(qdev->dma_dev.dev, size, queue->desc_base,
+				  queue->dma_desc_base);
+		return ret;
+	}
+
+	queue->pidx = 0;
+	queue->cidx = 0;
+
+	return 0;
+}
+
+static bool qdma_filter_fn(struct dma_chan *chan, void *param)
+{
+	struct qdma_queue *queue = to_qdma_queue(chan);
+	struct qdma_queue_info *info = param;
+
+	return info->dir == queue->dir;
+}
+
+static int qdma_xfer_start(struct qdma_queue *queue)
+{
+	struct qdma_device *qdev = queue->qdev;
+	int ret;
+
+	if (!vchan_next_desc(&queue->vchan))
+		return 0;
+
+	qdma_dbg(qdev, "Tnx kickoff with P: %d for %s%d",
+		 queue->issued_vdesc->pidx, CHAN_STR(queue), queue->qid);
+
+	ret = qdma_update_pidx(queue, queue->issued_vdesc->pidx);
+	if (ret) {
+		qdma_err(qdev, "Failed to update PIDX to %d for %s queue: %d",
+			 queue->pidx, CHAN_STR(queue), queue->qid);
+	}
+
+	return ret;
+}
+
+static void qdma_issue_pending(struct dma_chan *chan)
+{
+	struct qdma_queue *queue = to_qdma_queue(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&queue->vchan.lock, flags);
+	if (vchan_issue_pending(&queue->vchan)) {
+		if (queue->submitted_vdesc) {
+			queue->issued_vdesc = queue->submitted_vdesc;
+			queue->submitted_vdesc = NULL;
+		}
+		qdma_xfer_start(queue);
+	}
+
+	spin_unlock_irqrestore(&queue->vchan.lock, flags);
+}
+
+static struct qdma_mm_desc *qdma_get_desc(struct qdma_queue *q)
+{
+	struct qdma_mm_desc *desc;
+
+	if (((q->pidx + 1) & q->idx_mask) == q->cidx)
+		return NULL;
+
+	desc = q->desc_base + q->pidx;
+	q->pidx = (q->pidx + 1) & q->idx_mask;
+
+	return desc;
+}
+
+static int qdma_hw_enqueue(struct qdma_queue *q, struct qdma_mm_vdesc *vdesc)
+{
+	struct qdma_mm_desc *desc;
+	struct scatterlist *sg;
+	u64 addr, *src, *dst;
+	u32 rest, len;
+	int ret = 0;
+	u32 i;
+
+	if (!vdesc->sg_len)
+		return 0;
+
+	if (q->dir == DMA_MEM_TO_DEV) {
+		dst = &vdesc->dev_addr;
+		src = &addr;
+	} else {
+		dst = &addr;
+		src = &vdesc->dev_addr;
+	}
+
+	for_each_sg(vdesc->sgl, sg, vdesc->sg_len, i) {
+		addr = sg_dma_address(sg) + vdesc->sg_off;
+		rest = sg_dma_len(sg) - vdesc->sg_off;
+		while (rest) {
+			len = min_t(u32, rest, QDMA_MM_DESC_MAX_LEN);
+			desc = qdma_get_desc(q);
+			if (!desc) {
+				ret = -EBUSY;
+				goto out;
+			}
+
+			desc->src_addr = cpu_to_le64(*src);
+			desc->dst_addr = cpu_to_le64(*dst);
+			desc->len = cpu_to_le32(len);
+
+			vdesc->dev_addr += len;
+			vdesc->sg_off += len;
+			vdesc->pending_descs++;
+			addr += len;
+			rest -= len;
+		}
+		vdesc->sg_off = 0;
+	}
+out:
+	vdesc->sg_len -= i;
+	vdesc->pidx = q->pidx;
+	return ret;
+}
+
+static void qdma_fill_pending_vdesc(struct qdma_queue *q)
+{
+	struct virt_dma_chan *vc = &q->vchan;
+	struct qdma_mm_vdesc *vdesc;
+	struct virt_dma_desc *vd;
+	int ret;
+
+	if (!list_empty(&vc->desc_issued)) {
+		vd = &q->issued_vdesc->vdesc;
+		list_for_each_entry_from(vd, &vc->desc_issued, node) {
+			vdesc = to_qdma_vdesc(vd);
+			ret = qdma_hw_enqueue(q, vdesc);
+			if (ret) {
+				q->issued_vdesc = vdesc;
+				return;
+			}
+		}
+		q->issued_vdesc = vdesc;
+	}
+
+	if (list_empty(&vc->desc_submitted))
+		return;
+
+	if (q->submitted_vdesc)
+		vd = &q->submitted_vdesc->vdesc;
+	else
+		vd = list_first_entry(&vc->desc_submitted, typeof(*vd), node);
+
+	list_for_each_entry_from(vd, &vc->desc_submitted, node) {
+		vdesc = to_qdma_vdesc(vd);
+		ret = qdma_hw_enqueue(q, vdesc);
+		if (ret)
+			break;
+	}
+	q->submitted_vdesc = vdesc;
+}
+
+static dma_cookie_t qdma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct virt_dma_chan *vc = to_virt_chan(tx->chan);
+	struct qdma_queue *q = to_qdma_queue(&vc->chan);
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+	dma_cookie_t cookie;
+
+	vd = container_of(tx, struct virt_dma_desc, tx);
+	spin_lock_irqsave(&vc->lock, flags);
+	cookie = dma_cookie_assign(tx);
+
+	list_move_tail(&vd->node, &vc->desc_submitted);
+	qdma_fill_pending_vdesc(q);
+	spin_unlock_irqrestore(&vc->lock, flags);
+
+	return cookie;
+}
+
+static void *qdma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
+				   size_t *payload_len, size_t *max_len)
+{
+	struct qdma_mm_vdesc *vdesc;
+
+	vdesc = container_of(tx, typeof(*vdesc), vdesc.tx);
+	if (payload_len)
+		*payload_len = sizeof(vdesc->dev_addr);
+	if (max_len)
+		*max_len = *payload_len;
+
+	return &vdesc->dev_addr;
+}
+
+static int qdma_set_metadata_len(struct dma_async_tx_descriptor *tx,
+				 size_t payload_len)
+{
+	struct qdma_mm_vdesc *vdesc;
+
+	vdesc = container_of(tx, typeof(*vdesc), vdesc.tx);
+	if (payload_len != sizeof(vdesc->dev_addr))
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct dma_descriptor_metadata_ops metadata_ops = {
+	.get_ptr = qdma_get_metadata_ptr,
+	.set_len = qdma_set_metadata_len,
+};
+
+static struct dma_async_tx_descriptor *
+qdma_prep_device_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		    unsigned int sg_len, enum dma_transfer_direction dir,
+		    unsigned long flags, void *context)
+{
+	struct qdma_queue *q = to_qdma_queue(chan);
+	struct dma_async_tx_descriptor *tx;
+	struct qdma_mm_vdesc *vdesc;
+
+	vdesc = kzalloc(sizeof(*vdesc), GFP_NOWAIT);
+	if (!vdesc)
+		return NULL;
+	vdesc->sgl = sgl;
+	vdesc->sg_len = sg_len;
+
+	tx = vchan_tx_prep(&q->vchan, &vdesc->vdesc, flags);
+	tx->tx_submit = qdma_tx_submit;
+	tx->metadata_ops = &metadata_ops;
+
+	return tx;
+}
+
+static int qdma_arm_err_intr(const struct qdma_device *qdev)
+{
+	u32 value = 0;
+
+	qdma_set_field(qdev, &value, QDMA_REGF_ERR_INT_FUNC, qdev->fid);
+	qdma_set_field(qdev, &value, QDMA_REGF_ERR_INT_VEC, qdev->err_irq_idx);
+	qdma_set_field(qdev, &value, QDMA_REGF_ERR_INT_ARM, 1);
+
+	return qdma_reg_write(qdev, &value, QDMA_REGO_ERR_INT);
+}
+
+static irqreturn_t qdma_error_isr(int irq, void *data)
+{
+	struct qdma_device *qdev = data;
+	u32 err_stat = 0;
+	int ret;
+
+	ret = qdma_reg_read(qdev, &err_stat, QDMA_REGO_ERR_STAT);
+	if (ret) {
+		qdma_err(qdev, "read error state failed, ret %d", ret);
+		goto out;
+	}
+
+	qdma_err(qdev, "global error %d", err_stat);
+	ret = qdma_reg_write(qdev, &err_stat, QDMA_REGO_ERR_STAT);
+	if (ret)
+		qdma_err(qdev, "clear error state failed, ret %d", ret);
+
+out:
+	qdma_arm_err_intr(qdev);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t qdma_queue_isr(int irq, void *data)
+{
+	struct qdma_intr_ring *intr = data;
+	struct qdma_queue *q = NULL;
+	struct qdma_device *qdev;
+	u32 index, comp_desc;
+	u64 intr_ent;
+	u8 color;
+	int ret;
+	u16 qid;
+
+	qdev = intr->qdev;
+	index = intr->cidx;
+	while (1) {
+		struct virt_dma_desc *vd;
+		struct qdma_mm_vdesc *vdesc;
+		unsigned long flags;
+		u32 cidx;
+
+		intr_ent = le64_to_cpu(intr->base[index]);
+		color = FIELD_GET(QDMA_INTR_MASK_COLOR, intr_ent);
+		if (color != intr->color)
+			break;
+
+		qid = FIELD_GET(QDMA_INTR_MASK_QID, intr_ent);
+		if (FIELD_GET(QDMA_INTR_MASK_TYPE, intr_ent))
+			q = qdev->c2h_queues;
+		else
+			q = qdev->h2c_queues;
+		q += qid;
+
+		cidx = FIELD_GET(QDMA_INTR_MASK_CIDX, intr_ent);
+
+		spin_lock_irqsave(&q->vchan.lock, flags);
+		comp_desc = (cidx - q->cidx) & q->idx_mask;
+
+		vd = vchan_next_desc(&q->vchan);
+		if (!vd)
+			goto skip;
+
+		vdesc = to_qdma_vdesc(vd);
+		while (comp_desc > vdesc->pending_descs) {
+			list_del(&vd->node);
+			vchan_cookie_complete(vd);
+			comp_desc -= vdesc->pending_descs;
+			vd = vchan_next_desc(&q->vchan);
+			vdesc = to_qdma_vdesc(vd);
+		}
+		vdesc->pending_descs -= comp_desc;
+		if (!vdesc->pending_descs && QDMA_VDESC_QUEUED(vdesc)) {
+			list_del(&vd->node);
+			vchan_cookie_complete(vd);
+		}
+		q->cidx = cidx;
+
+		qdma_fill_pending_vdesc(q);
+		qdma_xfer_start(q);
+
+skip:
+		spin_unlock_irqrestore(&q->vchan.lock, flags);
+
+		/*
+		 * Wrap the index value and flip the expected color value if
+		 * interrupt aggregation PIDX has wrapped around.
+		 */
+		index++;
+		index &= QDMA_INTR_RING_IDX_MASK;
+		if (!index)
+			intr->color = !intr->color;
+	}
+
+	/*
+	 * Update the software interrupt aggregation ring CIDX if a valid entry
+	 * was found.
+	 */
+	if (q) {
+		qdma_dbg(qdev, "update intr ring%d %d", intr->ridx, index);
+
+		/*
+		 * Record the last read index of status descriptor from the
+		 * interrupt aggregation ring.
+		 */
+		intr->cidx = index;
+
+		ret = qdma_update_cidx(q, intr->ridx, index);
+		if (ret) {
+			qdma_err(qdev, "Failed to update IRQ CIDX");
+			return IRQ_NONE;
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int qdma_init_error_irq(struct qdma_device *qdev)
+{
+	struct device *dev = &qdev->pdev->dev;
+	int ret;
+	u32 vec;
+
+	vec = qdev->queue_irq_start - 1;
+
+	ret = devm_request_threaded_irq(dev, vec, NULL, qdma_error_isr,
+					IRQF_ONESHOT, "amd-qdma-error", qdev);
+	if (ret) {
+		qdma_err(qdev, "Failed to request error IRQ vector: %d", vec);
+		return ret;
+	}
+
+	ret = qdma_arm_err_intr(qdev);
+	if (ret)
+		qdma_err(qdev, "Failed to arm err interrupt, ret %d", ret);
+
+	return ret;
+}
+
+static void qdma_free_qintr_rings(struct qdma_device *qdev)
+{
+	int i;
+
+	for (i = 0; i < qdev->qintr_ring_num; i++) {
+		if (!qdev->qintr_rings[i].base)
+			continue;
+
+		dma_free_coherent(&qdev->pdev->dev, QDMA_INTR_RING_SIZE,
+				  qdev->qintr_rings[i].base,
+				  qdev->qintr_rings[i].dev_base);
+	}
+}
+
+static int qdma_alloc_qintr_rings(struct qdma_device *qdev)
+{
+	u32 ctxt[QDMA_CTXT_REGMAP_LEN];
+	struct device *dev = &qdev->pdev->dev;
+	struct qdma_intr_ring *ring;
+	struct qdma_ctxt_intr intr_ctxt;
+	u32 vector;
+	int ret, i;
+
+	qdev->qintr_ring_num = qdev->queue_irq_num;
+	qdev->qintr_rings = devm_kcalloc(dev, qdev->qintr_ring_num,
+					 sizeof(*qdev->qintr_rings),
+					 GFP_KERNEL);
+	if (!qdev->qintr_rings)
+		return -ENOMEM;
+
+	vector = qdev->queue_irq_start;
+	for (i = 0; i < qdev->qintr_ring_num; i++, vector++) {
+		ring = &qdev->qintr_rings[i];
+		ring->qdev = qdev;
+		ring->msix_id = qdev->err_irq_idx + i + 1;
+		ring->ridx = i;
+		ring->color = 1;
+		ring->base = dma_alloc_coherent(dev, QDMA_INTR_RING_SIZE,
+						&ring->dev_base,
+						GFP_KERNEL);
+		if (!ring->base) {
+			qdma_err(qdev, "Failed to alloc intr ring %d", i);
+			ret = -ENOMEM;
+			goto failed;
+		}
+		intr_ctxt.agg_base = QDMA_INTR_RING_BASE(ring->dev_base);
+		intr_ctxt.size = (QDMA_INTR_RING_SIZE - 1) / 4096;
+		intr_ctxt.vec = ring->msix_id;
+		intr_ctxt.valid = true;
+		intr_ctxt.color = true;
+		ret = qdma_prog_context(qdev, QDMA_CTXT_INTR_COAL,
+					QDMA_CTXT_CLEAR, ring->ridx, NULL);
+		if (ret) {
+			qdma_err(qdev, "Failed clear intr ctx, ret %d", ret);
+			goto failed;
+		}
+
+		qdma_prep_intr_context(qdev, &intr_ctxt, ctxt);
+		ret = qdma_prog_context(qdev, QDMA_CTXT_INTR_COAL,
+					QDMA_CTXT_WRITE, ring->ridx, ctxt);
+		if (ret) {
+			qdma_err(qdev, "Failed setup intr ctx, ret %d", ret);
+			goto failed;
+		}
+
+		ret = devm_request_threaded_irq(dev, vector, NULL,
+						qdma_queue_isr, IRQF_ONESHOT,
+						"amd-qdma-queue", ring);
+		if (ret) {
+			qdma_err(qdev, "Failed to request irq %d", vector);
+			goto failed;
+		}
+	}
+
+	return 0;
+
+failed:
+	qdma_free_qintr_rings(qdev);
+	return ret;
+}
+
+static int qdma_intr_init(struct qdma_device *qdev)
+{
+	int ret;
+
+	ret = qdma_init_error_irq(qdev);
+	if (ret) {
+		qdma_err(qdev, "Failed to init error IRQs, ret %d", ret);
+		return ret;
+	}
+
+	ret = qdma_alloc_qintr_rings(qdev);
+	if (ret) {
+		qdma_err(qdev, "Failed to init queue IRQs, ret %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void amd_qdma_remove(struct platform_device *pdev)
+{
+	struct qdma_device *qdev = platform_get_drvdata(pdev);
+
+	qdma_sgdma_control(qdev, 0);
+
+	if (qdev->status & QDMA_DEV_STATUS_REG_DMA)
+		dma_async_device_unregister(&qdev->dma_dev);
+
+	if (qdev->status & QDMA_DEV_STATUS_INTR_INIT)
+		qdma_free_qintr_rings(qdev);
+
+	mutex_destroy(&qdev->ctxt_lock);
+}
+
+static int amd_qdma_probe(struct platform_device *pdev)
+{
+	struct qdma_platdata *pdata = dev_get_platdata(&pdev->dev);
+	struct qdma_device *qdev;
+	struct resource *res;
+	void __iomem *regs;
+	int ret;
+
+	qdev = devm_kzalloc(&pdev->dev, sizeof(*qdev), GFP_KERNEL);
+	if (!qdev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, qdev);
+	qdev->pdev = pdev;
+	mutex_init(&qdev->ctxt_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		qdma_err(qdev, "Failed to get IRQ resource");
+		ret = -ENODEV;
+		goto failed;
+	}
+	qdev->err_irq_idx = pdata->irq_index;
+	qdev->queue_irq_start = res->start + 1;
+	qdev->queue_irq_num = res->end - res->start;
+
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		qdma_err(qdev, "Failed to map IO resource, err %d", ret);
+		goto failed;
+	}
+
+	qdev->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
+					     &qdma_regmap_config);
+	if (IS_ERR(qdev->regmap)) {
+		ret = PTR_ERR(qdev->regmap);
+		qdma_err(qdev, "Regmap init failed, err %d", ret);
+		goto failed;
+	}
+
+	ret = qdma_device_verify(qdev);
+	if (ret)
+		goto failed;
+
+	ret = qdma_get_hw_info(qdev);
+	if (ret)
+		goto failed;
+
+	INIT_LIST_HEAD(&qdev->dma_dev.channels);
+
+	ret = qdma_device_setup(qdev);
+	if (ret)
+		goto failed;
+
+	ret = qdma_intr_init(qdev);
+	if (ret) {
+		qdma_err(qdev, "Failed to initialize IRQs %d", ret);
+		return ret;
+	}
+	qdev->status |= QDMA_DEV_STATUS_INTR_INIT;
+
+	dma_cap_set(DMA_SLAVE, qdev->dma_dev.cap_mask);
+	dma_cap_set(DMA_PRIVATE, qdev->dma_dev.cap_mask);
+
+	qdev->dma_dev.dev = &pdev->dev;
+	qdev->dma_dev.filter.map = pdata->device_map;
+	qdev->dma_dev.filter.mapcnt = qdev->chan_num * 2;
+	qdev->dma_dev.filter.fn = qdma_filter_fn;
+	qdev->dma_dev.desc_metadata_modes = DESC_METADATA_ENGINE;
+	qdev->dma_dev.device_alloc_chan_resources = qdma_alloc_queue_resources;
+	qdev->dma_dev.device_free_chan_resources = qdma_free_queue_resources;
+	qdev->dma_dev.device_prep_slave_sg = qdma_prep_device_sg;
+	qdev->dma_dev.device_issue_pending = qdma_issue_pending;
+	qdev->dma_dev.device_tx_status = dma_cookie_status;
+	qdev->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+
+	ret = dma_async_device_register(&qdev->dma_dev);
+	if (ret) {
+		qdma_err(qdev, "Failed to register AMD QDMA: %d", ret);
+		goto failed;
+	}
+	qdev->status |= QDMA_DEV_STATUS_REG_DMA;
+
+	return 0;
+failed:
+	qdma_err(qdev, "Failed to probe AMD QDMA driver");
+	amd_qdma_remove(pdev);
+	return ret;
+}
+
+static struct platform_driver amd_qdma_driver = {
+	.driver		= {
+		.name = "amd-qdma",
+	},
+	.probe		= amd_qdma_probe,
+	.remove_new	= amd_qdma_remove,
+};
+
+module_platform_driver(amd_qdma_driver);
+
+MODULE_DESCRIPTION("AMD QDMA driver");
+MODULE_AUTHOR("XRT Team <runtimeca39d@amd.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dma/amd/qdma.h b/drivers/dma/amd/qdma.h
new file mode 100644
index 000000000000..b4a0e23d3d79
--- /dev/null
+++ b/drivers/dma/amd/qdma.h
@@ -0,0 +1,269 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * DMA header for AMD Queue-based DMA Subsystem
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef __QDMA_H
+#define __QDMA_H
+
+#include <linux/bitfield.h>
+#include <linux/dmaengine.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "../virt-dma.h"
+
+#define DISABLE					0
+#define ENABLE					1
+
+#define QDMA_MIN_IRQ				3
+#define QDMA_INTR_NAME_MAX_LEN			30
+#define QDMA_INTR_PREFIX			"amd-qdma"
+
+#define QDMA_DEV_STATUS_REG_DMA			BIT(0)
+#define QDMA_DEV_STATUS_INTR_INIT		BIT(1)
+
+#define QDMA_IDENTIFIER				0x1FD3
+#define QDMA_DEFAULT_RING_SIZE			(BIT(10) + 1)
+#define QDMA_DEFAULT_RING_ID			0
+#define QDMA_POLL_INTRVL_US			10		/* 10us */
+#define QDMA_POLL_TIMEOUT_US			(500 * 1000)	/* 500ms */
+#define QDMA_DMAP_REG_STRIDE			16
+#define QDMA_CTXT_REGMAP_LEN			8		/* 8 regs */
+#define QDMA_MM_DESC_SIZE			32		/* Bytes */
+#define QDMA_MM_DESC_LEN_BITS			28
+#define QDMA_MM_DESC_MAX_LEN			(BIT(QDMA_MM_DESC_LEN_BITS) - 1)
+#define QDMA_MIN_DMA_ALLOC_SIZE			4096
+#define QDMA_INTR_RING_SIZE			BIT(13)
+#define QDMA_INTR_RING_IDX_MASK			GENMASK(9, 0)
+#define QDMA_INTR_RING_BASE(_addr)		((_addr) >> 12)
+
+#define QDMA_IDENTIFIER_REGOFF			0x0
+#define QDMA_IDENTIFIER_MASK			GENMASK(31, 16)
+#define QDMA_QUEUE_ARM_BIT			BIT(16)
+
+#define qdma_err(qdev, fmt, args...)					\
+	dev_err(&(qdev)->pdev->dev, fmt, ##args)
+
+#define qdma_dbg(qdev, fmt, args...)					\
+	dev_dbg(&(qdev)->pdev->dev, fmt, ##args)
+
+#define qdma_info(qdev, fmt, args...)					\
+	dev_info(&(qdev)->pdev->dev, fmt, ##args)
+
+enum qdma_reg_fields {
+	QDMA_REGF_IRQ_ENABLE,
+	QDMA_REGF_WBK_ENABLE,
+	QDMA_REGF_WBI_CHECK,
+	QDMA_REGF_IRQ_ARM,
+	QDMA_REGF_IRQ_VEC,
+	QDMA_REGF_IRQ_AGG,
+	QDMA_REGF_WBI_INTVL_ENABLE,
+	QDMA_REGF_MRKR_DISABLE,
+	QDMA_REGF_QUEUE_ENABLE,
+	QDMA_REGF_QUEUE_MODE,
+	QDMA_REGF_DESC_BASE,
+	QDMA_REGF_DESC_SIZE,
+	QDMA_REGF_RING_ID,
+	QDMA_REGF_CMD_INDX,
+	QDMA_REGF_CMD_CMD,
+	QDMA_REGF_CMD_TYPE,
+	QDMA_REGF_CMD_BUSY,
+	QDMA_REGF_QUEUE_COUNT,
+	QDMA_REGF_QUEUE_MAX,
+	QDMA_REGF_QUEUE_BASE,
+	QDMA_REGF_FUNCTION_ID,
+	QDMA_REGF_INTR_AGG_BASE,
+	QDMA_REGF_INTR_VECTOR,
+	QDMA_REGF_INTR_SIZE,
+	QDMA_REGF_INTR_VALID,
+	QDMA_REGF_INTR_COLOR,
+	QDMA_REGF_INTR_FUNCTION_ID,
+	QDMA_REGF_ERR_INT_FUNC,
+	QDMA_REGF_ERR_INT_VEC,
+	QDMA_REGF_ERR_INT_ARM,
+	QDMA_REGF_MAX
+};
+
+enum qdma_regs {
+	QDMA_REGO_CTXT_DATA,
+	QDMA_REGO_CTXT_CMD,
+	QDMA_REGO_CTXT_MASK,
+	QDMA_REGO_MM_H2C_CTRL,
+	QDMA_REGO_MM_C2H_CTRL,
+	QDMA_REGO_QUEUE_COUNT,
+	QDMA_REGO_RING_SIZE,
+	QDMA_REGO_H2C_PIDX,
+	QDMA_REGO_C2H_PIDX,
+	QDMA_REGO_INTR_CIDX,
+	QDMA_REGO_FUNC_ID,
+	QDMA_REGO_ERR_INT,
+	QDMA_REGO_ERR_STAT,
+	QDMA_REGO_MAX
+};
+
+struct qdma_reg_field {
+	u16 lsb; /* Least significant bit of field */
+	u16 msb; /* Most significant bit of field */
+};
+
+struct qdma_reg {
+	u32 off;
+	u32 count;
+};
+
+#define QDMA_REGF(_msb, _lsb) {						\
+	.lsb = (_lsb),							\
+	.msb = (_msb),							\
+}
+
+#define QDMA_REGO(_off, _count) {					\
+	.off = (_off),							\
+	.count = (_count),						\
+}
+
+enum qdma_desc_size {
+	QDMA_DESC_SIZE_8B,
+	QDMA_DESC_SIZE_16B,
+	QDMA_DESC_SIZE_32B,
+	QDMA_DESC_SIZE_64B,
+};
+
+enum qdma_queue_op_mode {
+	QDMA_QUEUE_OP_STREAM,
+	QDMA_QUEUE_OP_MM,
+};
+
+enum qdma_ctxt_type {
+	QDMA_CTXT_DESC_SW_C2H,
+	QDMA_CTXT_DESC_SW_H2C,
+	QDMA_CTXT_DESC_HW_C2H,
+	QDMA_CTXT_DESC_HW_H2C,
+	QDMA_CTXT_DESC_CR_C2H,
+	QDMA_CTXT_DESC_CR_H2C,
+	QDMA_CTXT_WRB,
+	QDMA_CTXT_PFTCH,
+	QDMA_CTXT_INTR_COAL,
+	QDMA_CTXT_RSVD,
+	QDMA_CTXT_HOST_PROFILE,
+	QDMA_CTXT_TIMER,
+	QDMA_CTXT_FMAP,
+	QDMA_CTXT_FNC_STS,
+};
+
+enum qdma_ctxt_cmd {
+	QDMA_CTXT_CLEAR,
+	QDMA_CTXT_WRITE,
+	QDMA_CTXT_READ,
+	QDMA_CTXT_INVALIDATE,
+	QDMA_CTXT_MAX
+};
+
+struct qdma_ctxt_sw_desc {
+	u64				desc_base;
+	u16				vec;
+};
+
+struct qdma_ctxt_intr {
+	u64				agg_base;
+	u16				vec;
+	u32				size;
+	bool				valid;
+	bool				color;
+};
+
+struct qdma_ctxt_fmap {
+	u16				qbase;
+	u16				qmax;
+};
+
+struct qdma_device;
+
+struct qdma_mm_desc {
+	__le64			src_addr;
+	__le32			len;
+	__le32			reserved1;
+	__le64			dst_addr;
+	__le64			reserved2;
+} __packed;
+
+struct qdma_mm_vdesc {
+	struct virt_dma_desc		vdesc;
+	struct qdma_queue		*queue;
+	struct scatterlist		*sgl;
+	u64				sg_off;
+	u32				sg_len;
+	u64				dev_addr;
+	u32				pidx;
+	u32				pending_descs;
+};
+
+#define QDMA_VDESC_QUEUED(vdesc)	(!(vdesc)->sg_len)
+
+struct qdma_queue {
+	struct qdma_device		*qdev;
+	struct virt_dma_chan		vchan;
+	enum dma_transfer_direction	dir;
+	struct dma_slave_config		cfg;
+	struct qdma_mm_desc		*desc_base;
+	struct qdma_mm_vdesc		*submitted_vdesc;
+	struct qdma_mm_vdesc		*issued_vdesc;
+	dma_addr_t			dma_desc_base;
+	u32				pidx_reg;
+	u32				cidx_reg;
+	u32				ring_size;
+	u32				idx_mask;
+	u16				qid;
+	u32				pidx;
+	u32				cidx;
+};
+
+struct qdma_intr_ring {
+	struct qdma_device		*qdev;
+	__le64				*base;
+	dma_addr_t			dev_base;
+	char				msix_name[QDMA_INTR_NAME_MAX_LEN];
+	u32				msix_vector;
+	u16				msix_id;
+	u32				ring_size;
+	u16				ridx;
+	u16				cidx;
+	u8				color;
+};
+
+#define QDMA_INTR_MASK_PIDX		GENMASK_ULL(15, 0)
+#define QDMA_INTR_MASK_CIDX		GENMASK_ULL(31, 16)
+#define QDMA_INTR_MASK_DESC_COLOR	GENMASK_ULL(32, 32)
+#define QDMA_INTR_MASK_STATE		GENMASK_ULL(34, 33)
+#define QDMA_INTR_MASK_ERROR		GENMASK_ULL(36, 35)
+#define QDMA_INTR_MASK_TYPE		GENMASK_ULL(38, 38)
+#define QDMA_INTR_MASK_QID		GENMASK_ULL(62, 39)
+#define QDMA_INTR_MASK_COLOR		GENMASK_ULL(63, 63)
+
+struct qdma_device {
+	struct platform_device		*pdev;
+	struct dma_device		dma_dev;
+	struct regmap			*regmap;
+	struct mutex			ctxt_lock; /* protect ctxt registers */
+	const struct qdma_reg_field	*rfields;
+	const struct qdma_reg		*roffs;
+	struct qdma_queue		*h2c_queues;
+	struct qdma_queue		*c2h_queues;
+	struct qdma_intr_ring		*qintr_rings;
+	u32				qintr_ring_num;
+	u32				qintr_ring_idx;
+	u32				chan_num;
+	u32				queue_irq_start;
+	u32				queue_irq_num;
+	u32				err_irq_idx;
+	u32				fid;
+	u32				status;
+};
+
+extern const struct qdma_reg qdma_regos_default[QDMA_REGO_MAX];
+extern const struct qdma_reg_field qdma_regfs_default[QDMA_REGF_MAX];
+
+#endif	/* __QDMA_H */
diff --git a/include/linux/platform_data/amd_qdma.h b/include/linux/platform_data/amd_qdma.h
new file mode 100644
index 000000000000..59fa0c174f70
--- /dev/null
+++ b/include/linux/platform_data/amd_qdma.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef _PLATDATA_AMD_QDMA_H
+#define _PLATDATA_AMD_QDMA_H
+
+#include <linux/dmaengine.h>
+
+/**
+ * struct qdma_queue_info - DMA queue information. This information is used to
+ *			    match queue when DMA channel is requested
+ * @dir: Channel transfer direction
+ */
+struct qdma_queue_info {
+	enum dma_transfer_direction dir;
+};
+
+#define QDMA_FILTER_PARAM(qinfo)	((void *)(qinfo))
+
+struct dma_slave_map;
+
+/**
+ * struct qdma_platdata - Platform specific data for QDMA engine
+ * @max_mm_channels: Maximum number of MM DMA channels in each direction
+ * @device_map: DMA slave map
+ * @irq_index: The index of first IRQ
+ */
+struct qdma_platdata {
+	u32			max_mm_channels;
+	u32			irq_index;
+	struct dma_slave_map	*device_map;
+};
+
+#endif /* _PLATDATA_AMD_QDMA_H */
-- 
2.34.1

