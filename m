Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6CC58DCAC
	for <lists+dmaengine@lfdr.de>; Tue,  9 Aug 2022 19:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245236AbiHIRBm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Aug 2022 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245381AbiHIRBj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Aug 2022 13:01:39 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83AFBA2;
        Tue,  9 Aug 2022 10:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxvkIxT6bLj5DMZ6khRup82AI0SuivB6LZYGAIKRNCkiTDm3oKfi8p8Dz8fFXcLsAR3kXjASEtnZr35b2Zv5w5eUZl4eATaNl772IV5iW15j2OQiTpzUthHEhEBYelLoHmo4QKIoDvHeHRtPhPNCEk+Xc3bw5Trbzqyf3gfAHAIBol1myxWVytzc1bWjoFaERArWw7v4E3a7L+3wYbb6E2l5+ti2mel0MyCPa5004LXEKlKwosOU7oI9ZqalAEZTC7O4rnGgdQXtGTXa4mGT2uVHiCtfpJFd69axuLzGy+bpwrp3Z08GiWFly2Ie+NhiQBmVg4zeXhXauEOFh7J5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVdhejuULALhLVS34UmZpEcZYgsD1mNTse7fAQ+cdXU=;
 b=USn/2LKMQJ7MMHRpgGvV9nRNZ+7ZEZNCJt1CuLB/AIOzQ8pYIwXXbx3CdTxEFLcONrwmnDjXZZwondWwSQzbWbx7G5xFd35va/nlLzbMKpYazhEfstNs0AujI7qbCBIxshJhrFYgamkjr61D3ara70yhAhVXOKRlwOisqKC5DCfT5TvxZ2+2cz5T1Fv5q/UhcUHZR2MDUnE+A1OrIOb9SxkbisbCz1H1DbFj3QWlgA+ZZqMQTwPyFW57yQL+cedx3Gam7ACZxkAhXnPur62FhtP+e1izLMpdk3dh9PL81Zq7EzYBgAfqZAhxD5xZXoZKI8TtZIjBfg2xCnNVS1K8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVdhejuULALhLVS34UmZpEcZYgsD1mNTse7fAQ+cdXU=;
 b=a7/XeOPqHLxt3YdHLNAIuu95m/aI1/v1sl2x6WVAWIY4uZTajCdQVloPBe8CPGUSJVB2i9cavsVa22zPomPX8oK/atNdtlZLMMak1aRxHpCguRTkguq6pko3aBCogexyDVZBbZwmxQ5Ao5Za6DSChvjgI/7zZCD6G3V87bpRCL0=
Received: from BN9PR03CA0322.namprd03.prod.outlook.com (2603:10b6:408:112::27)
 by CH2PR12MB4840.namprd12.prod.outlook.com (2603:10b6:610:c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 17:01:33 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::1e) by BN9PR03CA0322.outlook.office365.com
 (2603:10b6:408:112::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Tue, 9 Aug 2022 17:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 17:01:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 12:01:32 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 9 Aug 2022 12:01:31 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>
Subject: [PATCH V1 XDMA 1/1] dmaengine: xilinx: xdma: add xilinx xdma driver
Date:   Tue, 9 Aug 2022 09:59:58 -0700
Message-ID: <1660064398-55898-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1660064398-55898-1-git-send-email-lizhi.hou@amd.com>
References: <1660064398-55898-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f39fcd-e657-403e-1054-08da7a28cfd9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4840:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZNhOSesBl6CZv4kPy8WE6onLDjQzb49dzW70mwmXc1+f9htiCK2GdB8h3E15ZtBYRxb7iSZz+XJEEDD1OwUYz1YkA1QuCXliK+OjQirIY7b6BhSPmC+0RNJrt2XZ9MpLJ6UzxlMndQ3aNmmSBHwhuW+9km4/f7b2xywDKTW4ASpa1qUQJ+u/jJDB9eVSomJ+DNZ/I1TfDM0w8e6+b5MI0IFakykvtPntRHOrUpfhXXwDAzpUPzNLUlXq5hwJOBVWlMjPeRgk0lSVUJj5nGp/RG7g8XwSZGafbYfowv2o2jogZmWvd7UqYTj/WHiLDKGJhr11os2VC0FcjP4JAp0D6OWvtvzqYGW3Xmpdti90fgZafYjfoHuT8uIHIw3Ul57exJIEAV3THhg1Cxf6SJB7qvqQGt7+kBzB/WSo7MsXe6pq48YeJqp37oCjfHGa54K+zlwu0rGK3Mv7rIgsLxu6RL4ZWEVWloIrNj/AnPkcxBATCNSrLnRzJ+zxETrLHARr5IsO0QNIthUobfkYU/we02WJ5koAQqwZIJ4x7ui+xCF8fpri+ShxkkBD+scwWG2aMiNW+nYV9Fxi7MeqpSYoLi0Tr1alNxX0NOf273zb0K0tmJkhkaq0bTJgeOWIyepGGvOO/unDIkGnBBXVZXK+4HqURVKPBX1/5v6BbbwNyC09GCId7euu2I4RHjQyQAcn2LG58qsJPrWyqkCqcwCFX1MWM5zTT1/1KPEW8cv3+HoOw0z6yiex5miWEDsJfZrcY/WO5aa9rhxVu1KLCwaJShoEUL9dGtBWjGTth4HdVPJGTCLqxXIK71S9XtxanJR5dn13snjXnFohOsE9ibMU7qwqRW5nWW/8txtiOBaU4NX61GSusiygn2X0p7kNwNB/eNXBOZUwSbk693Wh808JxKMlRa522cbGo+G1/gaq3M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(40470700004)(36840700001)(5660300002)(2616005)(26005)(81166007)(82740400003)(426003)(70586007)(70206006)(54906003)(316002)(356005)(86362001)(110136005)(40480700001)(40460700003)(966005)(4326008)(6666004)(8676002)(82310400005)(336012)(41300700001)(478600001)(8936002)(36756003)(83380400001)(44832011)(36860700001)(186003)(47076005)(30864003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 17:01:32.9955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f39fcd-e657-403e-1054-08da7a28cfd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add driver to enable PCIe board which uses XDMA (the DMA/Bridge Subsystem
for PCI Express). For example, Xilinx Alveo PCIe devices.
    https://www.xilinx.com/products/boards-and-kits/alveo.html

The XDMA engine support up to 4 Host to Card (H2C) and 4 Card to Host (C2H)
channels. Memory transfers are specified on a per-channel basis in
descriptor linked lists, which the DMA fetches from host memory and
processes. Events such as descriptor completion and errors are signaled
using interrupts. The hardware detail is provided by
    https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Introduction

This driver implements dmaengine APIs.
    - probe the available DMA channels
    - use dma_slave_map for channel lookup
    - use virtual channel to manage dmaengine tx descriptors
    - implement device_prep_slave_sg callback to handle host scatter gather
      list
    - implement device_config to config device address for DMA transfer

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Brian Xu <brian.xu@amd.com>
---
 MAINTAINERS                            |  10 +
 drivers/dma/Kconfig                    |  13 +
 drivers/dma/xilinx/Makefile            |   1 +
 drivers/dma/xilinx/xdma-regs.h         | 179 +++++
 drivers/dma/xilinx/xdma.c              | 952 +++++++++++++++++++++++++
 include/linux/platform_data/amd_xdma.h |  34 +
 6 files changed, 1189 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/platform_data/amd_xdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e8c52d0192a6..400055e3a725 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21683,6 +21683,16 @@ F:	Documentation/devicetree/bindings/media/xilinx/
 F:	drivers/media/platform/xilinx/
 F:	include/uapi/linux/xilinx-v4l2-controls.h
 
+XILINX XDMA DRIVER
+M:	Lizhi Hou <lizhi.hou@amd.com>
+M:	Brian Xu <brian.xu@amd.com>
+M:	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>
+L:	dmaengine@vger.kernel.org
+S:	Supported
+F:	drivers/dma/xilinx/xdma-regs.h
+F:	drivers/dma/xilinx/xdma.c
+F:	include/linux/platform_data/xdma.h
+
 XILINX ZYNQMP DPDMA DRIVER
 M:	Hyun Kwon <hyun.kwon@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d5de3f77d3aa..4d90f2f51655 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -733,6 +733,19 @@ config XILINX_ZYNQMP_DPDMA
 	  driver provides the dmaengine required by the DisplayPort subsystem
 	  display driver.
 
+config XILINX_XDMA
+	tristate "Xilinx DMA/Bridge Subsystem DMA Engine"
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	select REGMAP_MMIO
+	help
+	  Enable support for Xilinx DMA/Bridge Subsystem DMA engine. The DMA
+	  provides high performance block data movement between Host memory
+	  and the DMA subsystem. These direct memory transfers can be both in
+	  the Host to Card (H2C) and Card to Host (C2H) transfers.
+	  The core also provides up to 16 user interrupt wires that generate
+	  interrupts to the host.
+
 # driver files
 source "drivers/dma/bestcomm/Kconfig"
 
diff --git a/drivers/dma/xilinx/Makefile b/drivers/dma/xilinx/Makefile
index 767bb45f641f..c7a538a56643 100644
--- a/drivers/dma/xilinx/Makefile
+++ b/drivers/dma/xilinx/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_XILINX_DMA) += xilinx_dma.o
 obj-$(CONFIG_XILINX_ZYNQMP_DMA) += zynqmp_dma.o
 obj-$(CONFIG_XILINX_ZYNQMP_DPDMA) += xilinx_dpdma.o
+obj-$(CONFIG_XILINX_XDMA) += xdma.o
diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
new file mode 100644
index 000000000000..2296dfb90a8b
--- /dev/null
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2017-2020 Xilinx, Inc. All rights reserved.
+ * Copyright (C) 2022 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __DMA_XDMA_REGS_H
+#define __DMA_XDMA_REGS_H
+
+/* The length of register space exposed to host */
+#define XDMA_REG_SPACE_LEN	65536
+
+/*
+ * maximum number of DMA channels for each direction:
+ * Host to Card (H2C) or Card to Host (C2H)
+ */
+#define XDMA_MAX_CHANNELS	4
+
+/* macros to get higher and lower 32-bit address */
+#define XDMA_ADDR_H(addr)	((u64)(addr) >> 32)
+#define XDMA_ADDR_L(addr)	((u64)(addr) & 0xffffffffUL)
+
+/*
+ * macros to define the number of descriptor blocks can be used in one
+ * DMA transfer request.
+ * the DMA engine uses a linked list of descriptor blocks that specify the
+ * source, destination, and length of the DMA transfers.
+ */
+#define XDMA_DESC_BLOCK_NUM		BIT(7)
+#define XDMA_DESC_BLOCK_MASK		(XDMA_DESC_BLOCK_NUM - 1)
+
+/* descriptor definitions */
+#define XDMA_DESC_ADJACENT		BIT(5)
+#define XDMA_DESC_MAGIC			0xad4bUL
+#define XDMA_DESC_MAGIC_SHIFT		16
+#define XDMA_DESC_ADJACENT_SHIFT	8
+#define XDMA_DESC_STOPPED		BIT(0)
+#define XDMA_DESC_COMPLETED		BIT(1)
+#define XDMA_DESC_BLEN_BITS		28
+#define XDMA_DESC_BLEN_MAX		(BIT(XDMA_DESC_BLEN_BITS) - PAGE_SIZE)
+
+/* macros to construct the descriptor control word */
+#define XDMA_DESC_CONTROL(adjacent, flag)				\
+	((XDMA_DESC_MAGIC << XDMA_DESC_MAGIC_SHIFT) |			\
+	 (((adjacent) - 1) << XDMA_DESC_ADJACENT_SHIFT) | (flag))
+#define XDMA_DESC_CONTROL_LAST						\
+	XDMA_DESC_CONTROL(1, XDMA_DESC_STOPPED | XDMA_DESC_COMPLETED)
+
+/*
+ * Descriptor for a single contiguous memory block transfer.
+ *
+ * Multiple descriptors are linked by means of the next pointer. An additional
+ * extra adjacent number gives the amount of extra contiguous descriptors.
+ *
+ * The descriptors are in root complex memory, and the bytes in the 32-bit
+ * words must be in little-endian byte ordering.
+ */
+enum xdma_desc_field {
+	XDMA_DF_CONTROL,
+	XDMA_DF_BYTES,		/* transfer length in bytes */
+	XDMA_DF_SRC_ADDR_LO,	/* source address (low 32-bit) */
+	XDMA_DF_SRC_ADDR_HI,	/* source address (high 32-bit) */
+	XDMA_DF_DST_ADDR_LO,	/* destination address (low 32-bit) */
+	XDMA_DF_DST_ADDR_HI,	/* destination address (high 32-bit) */
+	/*
+	 * next descriptor in the single-linked list of descriptors;
+	 * this is the PCIe (bus) address of the next descriptor in the
+	 * root complex memory
+	 */
+	XDMA_DF_NEXT_LO,	/* next desc address (low 32-bit) */
+	XDMA_DF_NEXT_HI,	/* next desc address (high 32-bit) */
+	XDMA_DF_NUM
+};
+
+#define XDMA_DF_SZ		4
+#define XDMA_DESC_SIZE		(XDMA_DF_NUM * XDMA_DF_SZ)
+#define XDMA_DESC_BLOCK_SIZE	(XDMA_DESC_SIZE * XDMA_DESC_ADJACENT)
+
+/*
+ * Channel registers
+ */
+#define XDMA_CHAN_IDENTIFIER		0x0
+#define XDMA_CHAN_CONTROL		0x4
+#define XDMA_CHAN_CONTROL_W1S		0x8
+#define XDMA_CHAN_CONTROL_W1C		0xc
+#define XDMA_CHAN_STATUS		0x40
+#define XDMA_CHAN_COMPLETED_DESC	0x48
+#define XDMA_CHAN_ALIGNMENTS		0x4c
+#define XDMA_CHAN_INTR_ENABLE		0x90
+#define XDMA_CHAN_INTR_ENABLE_W1S	0x94
+#define XDMA_CHAN_INTR_ENABLE_W1C	0x9c
+
+#define XDMA_CHAN_STRIDE	0x100
+#define XDMA_CHAN_H2C_OFFSET	0x0
+#define XDMA_CHAN_C2H_OFFSET	0x1000
+#define XDMA_CHAN_H2C_TARGET	0x0
+#define XDMA_CHAN_C2H_TARGET	0x1
+
+/* macro to check if channel is available */
+#define XDMA_CHAN_MAGIC		0x1fc0
+#define XDMA_CHAN_CHECK_TARGET(id, target)		\
+	(((u32)(id) >> 16) == XDMA_CHAN_MAGIC + (target))
+
+/* bits of the channel control register */
+#define CHAN_CTRL_RUN_STOP			BIT(0)
+#define CHAN_CTRL_IE_DESC_STOPPED		BIT(1)
+#define CHAN_CTRL_IE_DESC_COMPLETED		BIT(2)
+#define CHAN_CTRL_IE_DESC_ALIGN_MISMATCH	BIT(3)
+#define CHAN_CTRL_IE_MAGIC_STOPPED		BIT(4)
+#define CHAN_CTRL_IE_IDLE_STOPPED		BIT(6)
+#define CHAN_CTRL_IE_READ_ERROR			(0x1FUL << 9)
+#define CHAN_CTRL_IE_DESC_ERROR			(0x1FUL << 19)
+#define CHAN_CTRL_NON_INCR_ADDR			BIT(25)
+#define CHAN_CTRL_POLL_MODE_WB			BIT(26)
+
+#define CHAN_CTRL_START	(CHAN_CTRL_RUN_STOP |				\
+			 CHAN_CTRL_IE_DESC_STOPPED |			\
+			 CHAN_CTRL_IE_DESC_COMPLETED |			\
+			 CHAN_CTRL_IE_DESC_ALIGN_MISMATCH |		\
+			 CHAN_CTRL_IE_MAGIC_STOPPED |			\
+			 CHAN_CTRL_IE_READ_ERROR |			\
+			 CHAN_CTRL_IE_DESC_ERROR)
+
+/* bits of the channel interrupt enable mask */
+#define CHAN_IM_DESC_ERROR			BIT(19)
+#define CHAN_IM_READ_ERROR			BIT(9)
+#define CHAN_IM_IDLE_STOPPED			BIT(6)
+#define CHAN_IM_MAGIC_STOPPED			BIT(4)
+#define CHAN_IM_DESC_COMPLETED			BIT(2)
+#define CHAN_IM_DESC_STOPPED			BIT(1)
+
+#define CHAN_IM_ALL	(CHAN_IM_DESC_ERROR | CHAN_IM_READ_ERROR |	\
+			 CHAN_IM_IDLE_STOPPED | CHAN_IM_MAGIC_STOPPED | \
+			 CHAN_IM_DESC_COMPLETED | CHAN_IM_DESC_STOPPED)
+
+/*
+ * Channel SGDMA registers
+ */
+#define XDMA_SGDMA_IDENTIFIER	0x0
+#define XDMA_SGDMA_DESC_LO	0x80
+#define XDMA_SGDMA_DESC_HI	0x84
+#define XDMA_SGDMA_DESC_ADJ	0x88
+#define XDMA_SGDMA_DESC_CREDIT	0x8c
+
+#define XDMA_SGDMA_BASE(chan_base)	((chan_base) + 0x4000)
+
+/* bits of the SG DMA control register */
+#define XDMA_CTRL_RUN_STOP			BIT(0)
+#define XDMA_CTRL_IE_DESC_STOPPED		BIT(1)
+#define XDMA_CTRL_IE_DESC_COMPLETED		BIT(2)
+#define XDMA_CTRL_IE_DESC_ALIGN_MISMATCH	BIT(3)
+#define XDMA_CTRL_IE_MAGIC_STOPPED		BIT(4)
+#define XDMA_CTRL_IE_IDLE_STOPPED		BIT(6)
+#define XDMA_CTRL_IE_READ_ERROR			(0x1FUL << 9)
+#define XDMA_CTRL_IE_DESC_ERROR			(0x1FUL << 19)
+#define XDMA_CTRL_NON_INCR_ADDR			BIT(25)
+#define XDMA_CTRL_POLL_MODE_WB			BIT(26)
+
+/*
+ * interrupt registers
+ */
+#define XDMA_IRQ_IDENTIFIER		0x0
+#define XDMA_IRQ_USER_INT_EN		0x04
+#define XDMA_IRQ_USER_INT_EN_W1S	0x08
+#define XDMA_IRQ_USER_INT_EN_W1C	0x0c
+#define XDMA_IRQ_CHAN_INT_EN		0x10
+#define XDMA_IRQ_CHAN_INT_EN_W1S	0x14
+#define XDMA_IRQ_CHAN_INT_EN_W1C	0x18
+#define XDMA_IRQ_USER_INT_REQ		0x40
+#define XDMA_IRQ_CHAN_INT_REQ		0x44
+#define XDMA_IRQ_USER_INT_PEND		0x48
+#define XDMA_IRQ_CHAN_INT_PEND		0x4c
+#define XDMA_IRQ_USER_VEC_NUM		0x80
+#define XDMA_IRQ_CHAN_VEC_NUM		0xa0
+
+#define XDMA_IRQ_BASE			0x2000
+#define XDMA_IRQ_VEC_SHIFT		8
+
+#endif /* __DMA_XDMA_REGS_H */
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
new file mode 100644
index 000000000000..9048bf6a5bdc
--- /dev/null
+++ b/drivers/dma/xilinx/xdma.c
@@ -0,0 +1,952 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DMA driver for Xilinx DMA/Bridge Subsystem
+ *
+ * Copyright (C) 2017-2020 Xilinx, Inc. All rights reserved.
+ * Copyright (C) 2022 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+/*
+ * The DMA/Bridge Subsystem for PCI Express allows for the movement of data
+ * between Host memory and the DMA subsystem. It does this by operating on
+ * 'descriptors' that contain information about the source, destination and
+ * amount of data to transfer. These direct memory transfers can be both in
+ * the Host to Card (H2C) and Card to Host (C2H) transfers. The DMA can be
+ * configured to have a single AXI4 Master interface shared by all channels
+ * or one AXI4-Stream interface for each channel enabled. Memory transfers are
+ * specified on a per-channel basis in descriptor linked lists, which the DMA
+ * fetches from host memory and processes. Events such as descriptor completion
+ * and errors are signaled using interrupts. The core also provides up to 16
+ * user interrupt wires that generate interrupts to the host.
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/dmaengine.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/amd_xdma.h>
+#include <linux/dma-mapping.h>
+#include "../virt-dma.h"
+#include "xdma-regs.h"
+
+/* mmio regmap config for all XDMA registers */
+static const struct regmap_config xdma_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = XDMA_REG_SPACE_LEN,
+};
+
+/**
+ * struct xdma_desc_block - Descriptor block
+ * @virt_addr: Virtual address of block start
+ * @dma_addr: DMA address of block start
+ * @desc_num: Number of descriptors in the block
+ */
+struct xdma_desc_block {
+	void		*virt_addr;
+	dma_addr_t	dma_addr;
+	u32		desc_num;
+};
+
+/**
+ * struct xdma_chan - Driver specific DMA channel structure
+ * @vchan: Virtual channel
+ * @xdev_hdl: Pointer to DMA device structure
+ * @base: Offset of channel registers
+ * @desc_blocks: Descriptor blocks
+ * @busy: Busy flag of the channel
+ * @dir: Transferring direction of the channel
+ * @dev_addr_field: Descriptor field for device address
+ * @host_addr_field: Descriptor field for host address
+ * @cfg: Transferring config of the channel
+ * @irq: IRQ assigned to the channel
+ * @tasklet: Channel tasklet
+ */
+struct xdma_chan {
+	struct virt_dma_chan		vchan;
+	void				*xdev_hdl;
+	u32				base;
+	struct xdma_desc_block		desc_blocks[XDMA_DESC_BLOCK_NUM];
+	bool				busy;
+	enum dma_transfer_direction	dir;
+	enum xdma_desc_field		dev_addr_field;
+	enum xdma_desc_field		host_addr_field;
+	struct dma_slave_config		cfg;
+	u32				irq;
+	struct tasklet_struct		tasklet;
+};
+
+/**
+ * struct xdma_request - DMA request structure
+ * @vdesc: Virtual DMA descriptor
+ * @dir: Transferring direction of the request
+ * @dev_addr: Physical address on DMA device side
+ * @sgl: Scatter gather list on host side
+ * @sg_off: Start offset of the first sgl segment
+ * @nents: Number of sgl segments to transfer
+ */
+struct xdma_request {
+	struct virt_dma_desc		vdesc;
+	enum dma_transfer_direction	dir;
+	u64				dev_addr;
+	struct scatterlist		*sgl;
+	u32				sg_off;
+	u32				nents;
+};
+
+#define XDMA_DEV_STATUS_REG_DMA		BIT(0)
+#define XDMA_DEV_STATUS_INIT_MSIX	BIT(1)
+
+/**
+ * struct xdma_device - DMA device structure
+ * @pdev: Platform device pointer
+ * @dma_dev: DMA device structure
+ * @regmap: MMIO regmap for DMA registers
+ * @h2c_chans: Host to Card channels
+ * @c2h_chans: Card to Host channels
+ * @h2c_chan_num: Number of H2C channels
+ * @c2h_chan_num: Number of C2H channels
+ * @irq_start: Start IRQ assigned to device
+ * @irq_num: Number of IRQ assigned to device
+ * @status: Initialization status
+ */
+struct xdma_device {
+	struct platform_device	*pdev;
+	struct dma_device	dma_dev;
+	struct regmap		*regmap;
+	struct xdma_chan	*h2c_chans;
+	struct xdma_chan	*c2h_chans;
+	u32			h2c_chan_num;
+	u32			c2h_chan_num;
+	u32			irq_start;
+	u32			irq_num;
+	u32			status;
+};
+
+/* Read and Write DMA registers */
+static inline int xdma_read_reg(struct xdma_device *xdev, u32 base, u32 reg,
+				u32 *val)
+{
+	return regmap_read(xdev->regmap, base + reg, val);
+}
+
+static inline int xdma_write_reg(struct xdma_device *xdev, u32 base, u32 reg,
+				 u32 val)
+{
+	return regmap_write(xdev->regmap, base + reg, val);
+}
+
+/* Write specified word of DMA descriptor */
+static inline void xdma_desc_set_field(void *desc, enum xdma_desc_field field,
+				       u32 val)
+{
+	*((__le32 *)desc + field) = cpu_to_le32(val);
+}
+
+/**
+ * xdma_desc_set - fill DMA descriptor
+ * @xdma_chan: DMA channel pointer
+ * @desc: Descriptor pointer
+ * @addr: Physical address on host side
+ * @dev_addr: Physical address on DMA device side
+ * @len: Data length
+ */
+static void xdma_desc_set(struct xdma_chan *xdma_chan, void *desc,
+			  dma_addr_t addr, u64 dev_addr, u32 len)
+{
+	xdma_desc_set_field(desc, XDMA_DF_CONTROL, XDMA_DESC_CONTROL(1, 0));
+	xdma_desc_set_field(desc, XDMA_DF_BYTES, len);
+	xdma_desc_set_field(desc, XDMA_DF_NEXT_LO, 0);
+	xdma_desc_set_field(desc, XDMA_DF_NEXT_HI, 0);
+
+	xdma_desc_set_field(desc, xdma_chan->dev_addr_field,
+			    XDMA_ADDR_L(dev_addr));
+	xdma_desc_set_field(desc, xdma_chan->dev_addr_field + 1,
+			    XDMA_ADDR_H(dev_addr));
+	xdma_desc_set_field(desc, xdma_chan->host_addr_field,
+			    XDMA_ADDR_L(addr));
+	xdma_desc_set_field(desc, xdma_chan->host_addr_field + 1,
+			    XDMA_ADDR_H(addr));
+}
+
+/**
+ * xdma_link_desc_blocks - Link descriptor blocks for DMA transfer
+ * @num_blocks: Number of descriptors to link
+ */
+static void xdma_link_desc_blocks(struct xdma_chan *xdma_chan, u32 num_blocks)
+{
+	struct xdma_desc_block *block, *next_block;
+	void *desc;
+	int i;
+
+	for (i = 0; i < num_blocks - 1; i++) {
+		block = &xdma_chan->desc_blocks[i];
+		next_block = &xdma_chan->desc_blocks[i + 1];
+
+		desc = block->virt_addr + (block->desc_num - 1) *
+			XDMA_DESC_SIZE;
+
+		xdma_desc_set_field(desc, XDMA_DF_CONTROL,
+				    XDMA_DESC_CONTROL(next_block->desc_num, 0));
+		xdma_desc_set_field(desc, XDMA_DF_NEXT_LO,
+				    XDMA_ADDR_L(next_block->dma_addr));
+		xdma_desc_set_field(desc, XDMA_DF_NEXT_HI,
+				    XDMA_ADDR_H(next_block->dma_addr));
+	}
+}
+
+static inline struct xdma_chan *to_xdma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct xdma_chan, vchan.chan);
+}
+
+static inline struct xdma_request *to_xdma_req(struct virt_dma_desc *vdesc)
+{
+	return container_of(vdesc, struct xdma_request, vdesc);
+}
+
+static int xdma_enable_intr(struct xdma_device *xdev)
+{
+	int ret;
+
+	ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_CHAN_INT_EN_W1S, ~0);
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "set channel intr mask failed: %d",
+			ret);
+	}
+
+	return ret;
+}
+
+static int xdma_disable_intr(struct xdma_device *xdev)
+{
+	int ret;
+
+	ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_CHAN_INT_EN_W1C, ~0);
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "clear channel intr mask failed: %d",
+			ret);
+	}
+
+	return ret;
+}
+
+/**
+ * xdma_channel_init - Initialize DMA channel registers
+ * @chan: DMA channel pointer
+ */
+static int xdma_channel_init(struct xdma_chan *chan)
+{
+	struct xdma_device *xdev = chan->xdev_hdl;
+	int ret;
+
+	ret = xdma_write_reg(xdev, chan->base, XDMA_CHAN_CONTROL_W1C,
+			     CHAN_CTRL_NON_INCR_ADDR);
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "failed to clear non incr addr: %d",
+			ret);
+		return ret;
+	}
+
+	ret = xdma_write_reg(xdev, chan->base, XDMA_CHAN_INTR_ENABLE,
+			     CHAN_IM_ALL);
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "failed to set interrupt mask: %d",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void xdma_free_tx_desc(struct virt_dma_desc *vdesc)
+{
+	struct xdma_request *req;
+
+	req = to_xdma_req(vdesc);
+	kfree(req);
+}
+
+/**
+ * xdma_xfer_start - Start DMA transfer
+ * @xdma_chan: DMA channel pointer
+ */
+static int xdma_xfer_start(struct xdma_chan *xdma_chan)
+{
+	struct virt_dma_desc *vd = vchan_next_desc(&xdma_chan->vchan);
+	struct xdma_device *xdev = xdma_chan->xdev_hdl;
+	u32 i, rest, len, sg_off, desc_num = 0;
+	struct xdma_desc_block *block;
+	struct xdma_request *req;
+	struct scatterlist *sg;
+	void *last_desc = NULL;
+	u64 dev_addr;
+	dma_addr_t addr;
+	int ret;
+
+	/*
+	 * check if there is not any submitted descriptor or channel is busy.
+	 * vchan lock should be held where this function is called.
+	 */
+	if (!vd || xdma_chan->busy)
+		return -EINVAL;
+
+	/* clear run stop bit to get ready for transfer */
+	ret = xdma_write_reg(xdev, xdma_chan->base, XDMA_CHAN_CONTROL_W1C,
+			     CHAN_CTRL_RUN_STOP);
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "write control failed: %d", ret);
+		return ret;
+	}
+
+	req = to_xdma_req(vd);
+	if (req->dir != xdma_chan->dir) {
+		dev_err(&xdev->pdev->dev, "incorrect request direction");
+		return -EINVAL;
+	}
+
+	sg = req->sgl;
+	sg_off = req->sg_off;
+	dev_addr = req->dev_addr;
+
+	/*
+	 * submit sgl segments to hardware. complete submission either
+	 * all descriptors are used or all segments are submitted.
+	 */
+	for (i = 0; i < XDMA_DESC_BLOCK_NUM && req->nents && sg; i++) {
+		void *desc;
+
+		block = &xdma_chan->desc_blocks[i];
+		desc = block->virt_addr;
+
+		/* set descriptor block */
+		while (desc_num < XDMA_DESC_ADJACENT && sg) {
+			addr = sg_dma_address(sg) + sg_off;
+			rest = sg_dma_len(sg) - sg_off;
+
+			/*
+			 * if the rest of segment greater than the maximum
+			 * data block can be sent by a hardware descriptor
+			 */
+			if (rest > XDMA_DESC_BLEN_MAX) {
+				len = XDMA_DESC_BLEN_MAX;
+				sg_off += XDMA_DESC_BLEN_MAX;
+			} else {
+				len = rest;
+				sg_off = 0;
+				sg = sg_next(sg);
+				req->nents--;
+			}
+
+			/* skip the zero length segment */
+			if (!len)
+				continue;
+
+			/* set hardware descriptor */
+			xdma_desc_set(xdma_chan, desc, addr, dev_addr,
+				      len);
+			last_desc = desc;
+			desc += XDMA_DESC_SIZE;
+			desc_num++;
+		}
+		block->desc_num = desc_num;
+		desc_num = 0;
+	}
+	if (!last_desc) {
+		dev_err(&xdev->pdev->dev, "invalid sgl");
+		return -EINVAL;
+	}
+
+	/* link all descriptors for transferring */
+	xdma_link_desc_blocks(xdma_chan, i);
+
+	/* record the rest of sgl */
+	req->sgl = sg;
+	req->sg_off = sg_off;
+
+	/* set control word of last descriptor */
+	xdma_desc_set_field(last_desc, XDMA_DF_CONTROL, XDMA_DESC_CONTROL_LAST);
+
+	/* set DMA engine to the first descriptor block */
+	block = &xdma_chan->desc_blocks[0];
+	ret = xdma_write_reg(xdev, XDMA_SGDMA_BASE(xdma_chan->base),
+			     XDMA_SGDMA_DESC_LO,
+			     XDMA_ADDR_L(block->dma_addr));
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "write hi addr failed: %d", ret);
+		return ret;
+	}
+
+	ret = xdma_write_reg(xdev, XDMA_SGDMA_BASE(xdma_chan->base),
+			     XDMA_SGDMA_DESC_HI,
+			     XDMA_ADDR_H(block->dma_addr));
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "write lo addr failed: %d", ret);
+		return ret;
+	}
+
+	ret = xdma_write_reg(xdev, XDMA_SGDMA_BASE(xdma_chan->base),
+			     XDMA_SGDMA_DESC_ADJ, block->desc_num - 1);
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "write adjacent failed: %d", ret);
+		return ret;
+	}
+
+	/* kick off DMA transfer */
+	ret = xdma_write_reg(xdev, xdma_chan->base, XDMA_CHAN_CONTROL,
+			     CHAN_CTRL_START);
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "write control failed: %d", ret);
+		return ret;
+	}
+
+	xdma_chan->busy = true;
+	return 0;
+}
+
+static void xdma_channel_tasklet(struct tasklet_struct *t)
+{
+	struct xdma_chan *xdma_chan = from_tasklet(xdma_chan, t, tasklet);
+
+	spin_lock(&xdma_chan->vchan.lock);
+	xdma_xfer_start(xdma_chan);
+	spin_unlock(&xdma_chan->vchan.lock);
+}
+
+/**
+ * xdma_config_channels - Detect and config DMA channels
+ * @xdev: DMA device pointer
+ * @dir: Channel direction
+ */
+static int xdma_config_channels(struct xdma_device *xdev,
+				enum dma_transfer_direction dir)
+{
+	struct xdma_platdata *pdata = dev_get_platdata(&xdev->pdev->dev);
+	enum xdma_desc_field dev_addr_field, host_addr_field;
+	u32 base, identifier, target;
+	struct xdma_chan **chans;
+	u32 *chan_num;
+	int i, j, ret;
+
+	if (dir == DMA_MEM_TO_DEV) {
+		base = XDMA_CHAN_H2C_OFFSET;
+		target = XDMA_CHAN_H2C_TARGET;
+		chans = &xdev->h2c_chans;
+		chan_num = &xdev->h2c_chan_num;
+		dev_addr_field = XDMA_DF_DST_ADDR_LO;
+		host_addr_field = XDMA_DF_SRC_ADDR_LO;
+	} else if (dir == DMA_DEV_TO_MEM) {
+		base = XDMA_CHAN_C2H_OFFSET;
+		target = XDMA_CHAN_C2H_TARGET;
+		chans = &xdev->c2h_chans;
+		chan_num = &xdev->c2h_chan_num;
+		dev_addr_field = XDMA_DF_SRC_ADDR_LO;
+		host_addr_field =  XDMA_DF_DST_ADDR_LO;
+	} else {
+		dev_err(&xdev->pdev->dev, "invalid direction specified");
+		return -EINVAL;
+	}
+
+	/* detect number of available DMA channels */
+	for (i = 0, *chan_num = 0; i < pdata->max_dma_channels; i++) {
+		ret = xdma_read_reg(xdev, base + i * XDMA_CHAN_STRIDE,
+				    XDMA_CHAN_IDENTIFIER, &identifier);
+		if (ret) {
+			dev_err(&xdev->pdev->dev,
+				"failed to read channel id: %d", ret);
+			return ret;
+		}
+
+		/* check if it is available DMA channel */
+		if (XDMA_CHAN_CHECK_TARGET(identifier, target))
+			(*chan_num)++;
+	}
+
+	if (!*chan_num) {
+		dev_err(&xdev->pdev->dev, "does not probe any channel");
+		return -EINVAL;
+	}
+
+	*chans = devm_kzalloc(&xdev->pdev->dev, sizeof(**chans) * (*chan_num),
+			      GFP_KERNEL);
+	if (!*chans)
+		return -ENOMEM;
+
+	for (i = 0, j = 0; i < pdata->max_dma_channels; i++) {
+		ret = xdma_read_reg(xdev, base + i * XDMA_CHAN_STRIDE,
+				    XDMA_CHAN_IDENTIFIER, &identifier);
+		if (ret) {
+			dev_err(&xdev->pdev->dev,
+				"failed to read channel id: %d", ret);
+			return ret;
+		}
+
+		if (!XDMA_CHAN_CHECK_TARGET(identifier, target))
+			continue;
+
+		if (j == *chan_num) {
+			dev_err(&xdev->pdev->dev, "invalid channel number");
+			return -EIO;
+		}
+
+		/* init channel structure and hardware */
+		(*chans)[j].xdev_hdl = xdev;
+		(*chans)[j].base = base + i * XDMA_CHAN_STRIDE;
+		(*chans)[j].dir = dir;
+		(*chans)[j].dev_addr_field = dev_addr_field;
+		(*chans)[j].host_addr_field = host_addr_field;
+
+		ret = xdma_channel_init(&(*chans)[j]);
+		if (ret)
+			return ret;
+		(*chans)[j].vchan.desc_free = xdma_free_tx_desc;
+		vchan_init(&(*chans)[j].vchan, &xdev->dma_dev);
+
+		j++;
+	}
+
+	dev_info(&xdev->pdev->dev, "configured %d %s channels", j,
+		 (dir == DMA_MEM_TO_DEV) ? "H2C" : "C2H");
+
+	return 0;
+}
+
+/**
+ * xdma_issue_pending - Issue pending transactions
+ * @chan: DMA channel pointer
+ */
+static void xdma_issue_pending(struct dma_chan *chan)
+{
+	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
+	if (vchan_issue_pending(&xdma_chan->vchan))
+		xdma_xfer_start(xdma_chan);
+	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
+}
+
+/**
+ * xdma_prep_device_sg - prepare a descriptor for a
+ *	DMA transaction
+ * @chan: DMA channel pointer
+ * @sgl: Transfer scatter gather list
+ * @sg_len: Length of scatter gather list
+ * @dir: Transfer direction
+ * @flags: transfer ack flags
+ * @context: APP words of the descriptor
+ */
+static struct dma_async_tx_descriptor *
+xdma_prep_device_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		    unsigned int sg_len, enum dma_transfer_direction dir,
+		    unsigned long flags, void *context)
+{
+	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+	struct xdma_request *req;
+
+	req = kzalloc(sizeof(*req), GFP_NOWAIT);
+	if (!req)
+		return NULL;
+
+	req->sgl = sgl;
+	req->dir = dir;
+	req->nents = sg_len;
+	if (dir == DMA_MEM_TO_DEV)
+		req->dev_addr = xdma_chan->cfg.dst_addr;
+	else
+		req->dev_addr = xdma_chan->cfg.src_addr;
+
+	return vchan_tx_prep(&xdma_chan->vchan, &req->vdesc, flags);
+}
+
+/**
+ * xdma_device_config - Configure the DMA channel
+ * @chan: DMA channel
+ * @cfg: channel configuration
+ */
+static int xdma_device_config(struct dma_chan *chan,
+			      struct dma_slave_config *cfg)
+{
+	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+
+	memcpy(&xdma_chan->cfg, cfg, sizeof(*cfg));
+
+	return 0;
+}
+
+/**
+ * xdma_free_chan_resources - Free channel resources
+ * @chan: DMA channel
+ */
+static void xdma_free_chan_resources(struct dma_chan *chan)
+{
+	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+	struct xdma_device *xdev = xdma_chan->xdev_hdl;
+
+	dma_free_coherent(&xdev->pdev->dev,
+			  XDMA_DESC_BLOCK_NUM * XDMA_DESC_BLOCK_SIZE,
+			  xdma_chan->desc_blocks[0].virt_addr,
+			  xdma_chan->desc_blocks[0].dma_addr);
+}
+
+/**
+ * xdma_alloc_chan_resources - Allocate channel resources
+ * @chan: DMA channel
+ */
+static int xdma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+	struct xdma_device *xdev = xdma_chan->xdev_hdl;
+	dma_addr_t dma_addr;
+	void *desc;
+	int i;
+
+	desc = dma_alloc_coherent(&xdev->pdev->dev,
+				  XDMA_DESC_BLOCK_NUM * XDMA_DESC_BLOCK_SIZE,
+				  &dma_addr, GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	for (i = 0; i < XDMA_DESC_BLOCK_NUM; i++) {
+		xdma_chan->desc_blocks[i].virt_addr = desc;
+		xdma_chan->desc_blocks[i].dma_addr = dma_addr;
+		desc += XDMA_DESC_BLOCK_SIZE;
+		dma_addr += XDMA_DESC_BLOCK_SIZE;
+	}
+
+	return 0;
+}
+
+/**
+ * xdma_channel_isr - XDMA channel interrupt handler
+ * @irq: IRQ number
+ * @dev_id: Pointer to the DMA channel structure
+ */
+static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
+{
+	struct xdma_chan *xdma_chan = dev_id;
+	struct virt_dma_desc *vd;
+	struct xdma_request *req;
+
+	spin_lock(&xdma_chan->vchan.lock);
+
+	/* get submitted request */
+	vd = vchan_next_desc(&xdma_chan->vchan);
+	if (!vd)
+		goto out;
+
+	xdma_chan->busy = false;
+	req = to_xdma_req(vd);
+
+	/*
+	 * if all data blocks are transferred, remove and complete the
+	 * request
+	 */
+	if (!req->sgl) {
+		list_del(&vd->node);
+		vchan_cookie_complete(vd);
+	} else {
+		/* transfer the rest of data */
+		tasklet_schedule(&xdma_chan->tasklet);
+	}
+
+out:
+	spin_unlock(&xdma_chan->vchan.lock);
+	return IRQ_HANDLED;
+}
+
+/**
+ * xdma_irq_fini - Uninitialize IRQ
+ * @xdev: DMA device pointer
+ */
+static void xdma_irq_fini(struct xdma_device *xdev)
+{
+	int ret, i;
+
+	/* disable interrupt */
+	ret = xdma_disable_intr(xdev);
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "failed to disable interrupts: %d",
+			ret);
+	}
+
+	/* free irq handler */
+	for (i = 0; i < xdev->h2c_chan_num; i++) {
+		free_irq(xdev->h2c_chans[i].irq, &xdev->h2c_chans[i]);
+		tasklet_kill(&xdev->h2c_chans[i].tasklet);
+	}
+	for (i = 0; i < xdev->c2h_chan_num; i++) {
+		free_irq(xdev->c2h_chans[i].irq, &xdev->c2h_chans[i]);
+		tasklet_kill(&xdev->c2h_chans[i].tasklet);
+	}
+}
+
+/**
+ * xdma_set_vector_reg - configure hardware IRQ registers
+ * @xdev: DMA device pointer
+ * @vec_tbl_start: Start of IRQ registers
+ * @irq_start: Start of IRQ
+ * @irq_num: Number of IRQ
+ */
+static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
+			       u32 irq_start, u32 irq_num)
+{
+	u32 shift, i, val = 0;
+	int ret;
+
+	/* Each IRQ register is 32 bit and contains 4 IRQs */
+	while (irq_num > 0) {
+		for (i = 0; i < 4; i++) {
+			shift = XDMA_IRQ_VEC_SHIFT * i;
+			val |= irq_start << shift;
+			irq_start++;
+			irq_num--;
+		}
+
+		/* write IRQ register */
+		ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, vec_tbl_start, val);
+		if (ret) {
+			dev_err(&xdev->pdev->dev, "failed to set vector: %d",
+				ret);
+			return ret;
+		}
+		vec_tbl_start += sizeof(u32);
+		val = 0;
+	}
+
+	return 0;
+}
+
+/**
+ * xdma_irq_init - initialize IRQs
+ * @xdev: DMA device pointer
+ */
+static int xdma_irq_init(struct xdma_device *xdev)
+{
+	u32 irq = xdev->irq_start;
+	int i, j, ret;
+
+	/* return failure if there are not enough IRQs */
+	if (xdev->irq_num < xdev->h2c_chan_num + xdev->c2h_chan_num) {
+		dev_err(&xdev->pdev->dev, "not enough irq");
+		return -EINVAL;
+	}
+
+	/* setup H2C interrupt handler */
+	for (i = 0; i < xdev->h2c_chan_num; i++) {
+		ret = request_irq(irq, xdma_channel_isr, 0,
+				  "xdma-h2c-channel", &xdev->h2c_chans[i]);
+		if (ret) {
+			dev_err(&xdev->pdev->dev,
+				"H2C channel%d request irq%d failed: %d",
+				i, irq, ret);
+			for (j = 0; j < i; j++) {
+				free_irq(xdev->h2c_chans[j].irq,
+					 &xdev->h2c_chans[j]);
+			}
+			return ret;
+		}
+		xdev->h2c_chans[i].irq = irq;
+		tasklet_setup(&xdev->h2c_chans[i].tasklet,
+			      xdma_channel_tasklet);
+		irq++;
+	}
+
+	/* setup C2H interrupt handler */
+	for (i = 0; i < xdev->c2h_chan_num; i++) {
+		ret = request_irq(irq, xdma_channel_isr, 0,
+				  "xdma-c2h-channel", &xdev->c2h_chans[i]);
+		if (ret) {
+			dev_err(&xdev->pdev->dev,
+				"H2C channel%d request irq%d failed: %d",
+				i, irq, ret);
+			for (j = 0; j < i; j++) {
+				free_irq(xdev->c2h_chans[j].irq,
+					 &xdev->c2h_chans[j]);
+			}
+			goto failed_init_c2h;
+		}
+		xdev->c2h_chans[i].irq = irq;
+		tasklet_setup(&xdev->c2h_chans[i].tasklet,
+			      xdma_channel_tasklet);
+		irq++;
+	}
+
+	/* config hardware IRQ registers */
+	ret = xdma_set_vector_reg(xdev, XDMA_IRQ_CHAN_VEC_NUM, 0,
+				  xdev->h2c_chan_num + xdev->c2h_chan_num);
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "failed to set channel vectors: %d",
+			ret);
+		goto failed;
+	}
+
+	/* enable interrupt */
+	ret = xdma_enable_intr(xdev);
+	if (ret) {
+		dev_err(&xdev->pdev->dev, "failed to enable interrupts: %d",
+			ret);
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	for (i = 0; i < xdev->c2h_chan_num; i++)
+		free_irq(xdev->c2h_chans[i].irq, &xdev->c2h_chans[i]);
+failed_init_c2h:
+	for (i = 0; i < xdev->h2c_chan_num; i++)
+		free_irq(xdev->h2c_chans[i].irq, &xdev->h2c_chans[i]);
+
+	return ret;
+}
+
+static bool xdma_filter_fn(struct dma_chan *chan, void *param)
+{
+	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+	struct xdma_chan_info *chan_info = param;
+
+	if (chan_info->dir != xdma_chan->dir)
+		return false;
+
+	return true;
+}
+
+/**
+ * xdma_remove - Driver remove function
+ * @pdev: Pointer to the platform_device structure
+ */
+static int xdma_remove(struct platform_device *pdev)
+{
+	struct xdma_device *xdev = platform_get_drvdata(pdev);
+
+	if (xdev->status & XDMA_DEV_STATUS_INIT_MSIX)
+		xdma_irq_fini(xdev);
+
+	if (xdev->status & XDMA_DEV_STATUS_REG_DMA)
+		dma_async_device_unregister(&xdev->dma_dev);
+
+	return 0;
+}
+
+/**
+ * xdma_probe - Driver probe function
+ * @pdev: Pointer to the platform_device structure
+ */
+static int xdma_probe(struct platform_device *pdev)
+{
+	struct xdma_platdata *pdata = dev_get_platdata(&pdev->dev);
+	struct xdma_device *xdev;
+	struct resource *res;
+	int ret = -ENODEV;
+	void *reg_base;
+
+	if (pdata->max_dma_channels > XDMA_MAX_CHANNELS) {
+		dev_err(&pdev->dev, "invalid max dma channels %d",
+			pdata->max_dma_channels);
+		return -EINVAL;
+	}
+
+	xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
+	if (!xdev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, xdev);
+	xdev->pdev = pdev;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get irq resource");
+		goto failed;
+	}
+	xdev->irq_start = res->start;
+	xdev->irq_num = res->end - res->start + 1;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get io resource");
+		goto failed;
+	}
+
+	reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (!reg_base) {
+		dev_err(&pdev->dev, "ioremap failed");
+		goto failed;
+	}
+
+	xdev->regmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
+					     &xdma_regmap_config);
+	if (!xdev->regmap) {
+		dev_err(&pdev->dev, "config regmap failed: %d", ret);
+		goto failed;
+	}
+	INIT_LIST_HEAD(&xdev->dma_dev.channels);
+
+	ret = xdma_config_channels(xdev, DMA_MEM_TO_DEV);
+	if (ret) {
+		dev_err(&pdev->dev, "config H2C channels failed: %d", ret);
+		goto failed;
+	}
+
+	ret = xdma_config_channels(xdev, DMA_DEV_TO_MEM);
+	if (ret) {
+		dev_err(&pdev->dev, "config C2H channels failed: %d", ret);
+		goto failed;
+	}
+
+	dma_cap_set(DMA_SLAVE, xdev->dma_dev.cap_mask);
+	dma_cap_set(DMA_PRIVATE, xdev->dma_dev.cap_mask);
+
+	xdev->dma_dev.dev = &pdev->dev;
+	xdev->dma_dev.device_free_chan_resources = xdma_free_chan_resources;
+	xdev->dma_dev.device_alloc_chan_resources = xdma_alloc_chan_resources;
+	xdev->dma_dev.device_tx_status = dma_cookie_status;
+	xdev->dma_dev.device_prep_slave_sg = xdma_prep_device_sg;
+	xdev->dma_dev.device_config = xdma_device_config;
+	xdev->dma_dev.device_issue_pending = xdma_issue_pending;
+	xdev->dma_dev.filter.map = pdata->device_map;
+	xdev->dma_dev.filter.mapcnt = pdata->device_map_cnt;
+	xdev->dma_dev.filter.fn = xdma_filter_fn;
+
+	ret = dma_async_device_register(&xdev->dma_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register Xilinx XDMA: %d", ret);
+		goto failed;
+	}
+	xdev->status |= XDMA_DEV_STATUS_REG_DMA;
+
+	ret = xdma_irq_init(xdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to init msix: %d", ret);
+		goto failed;
+	}
+	xdev->status |= XDMA_DEV_STATUS_INIT_MSIX;
+
+	return 0;
+
+failed:
+	xdma_remove(pdev);
+
+	return ret;
+}
+
+static const struct platform_device_id xdma_id_table[] = {
+	{ "xdma", 0},
+	{ },
+};
+
+static struct platform_driver xdma_driver = {
+	.driver		= {
+		.name = "xdma",
+	},
+	.id_table	= xdma_id_table,
+	.probe		= xdma_probe,
+	.remove		= xdma_remove,
+};
+
+module_platform_driver(xdma_driver);
+
+MODULE_DESCRIPTION("AMD XDMA driver");
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/amd_xdma.h b/include/linux/platform_data/amd_xdma.h
new file mode 100644
index 000000000000..04bcfc74ab36
--- /dev/null
+++ b/include/linux/platform_data/amd_xdma.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2022 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef _PLATDATA_AMD_XDMA_H
+#define _PLATDATA_AMD_XDMA_H
+
+#include <linux/dmaengine.h>
+
+/**
+ * struct xdma_chan_info - DMA channel information
+ *	This information is used to match channel when request dma channel
+ * @dir: Channel transfer direction
+ */
+struct xdma_chan_info {
+	enum dma_transfer_direction dir;
+};
+
+#define XDMA_FILTER_PARAM(chan_info)	((void *)(chan_info))
+
+struct dma_slave_map;
+
+/**
+ * struct xdma_platdata - platform specific data for XDMA engine
+ * @max_dma_channels: Maximum dma channels in each direction
+ */
+struct xdma_platdata {
+	u32 max_dma_channels;
+	u32 device_map_cnt;
+	struct dma_slave_map *device_map;
+};
+
+#endif /* _PLATDATA_AMD_XDMA_H */
-- 
2.27.0

