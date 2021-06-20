Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9897E3ADF67
	for <lists+dmaengine@lfdr.de>; Sun, 20 Jun 2021 18:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFTQoU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Jun 2021 12:44:20 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:13600
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229943AbhFTQoQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 20 Jun 2021 12:44:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYHFdFHxUP59N+LiwkWDIwbiAiK4Y3HaLgmJLkUO90tGlIQZnQn7sxMrVZb7r9h73L3qF3fsylqeimojijomKyAhHb1Yzp8c7iTK/eRBzxSK1FRhgDpsVn/p/Sq0LPSHRCz5VzTVvI3qtx/GRbj34x6fj9bn/h5A4lciM0+gQLfSGKhCYnoTEvnu7VzufiL3VjkJGas/vAE5RYrc8U8FUSiBQ7In9GYASL1uCbV1oeIkcivqgf6M2bTXaJz4DZzl52MsnSjlmfWnN09WJOELEbV4XgQ5t5fyI68QdpBrOSRNPJDAWeOWgXsdO9LqlC4Ojn2hfaF6kBXpaLudy8Pefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9fBO5MP+8IRvRuAtDlKLwNyHIs6E9m8Txkcis5AR6Y=;
 b=PuSqlDjNhX1jbuVKoqHCGCgP+Ni7Fu7yRYW5uJDJhXFlgRifxDuuUKRHHxtDSCgZIMUURIUAWCQd0rRTIvCu9ntq2Y3XkKjNdh1GlaMq5uHh6xRQZ2UZGTqyvrJ1YabKD2RTxX1MFA4aUUB66m8+M1bTXHMZ72ssX3h5etfNBCqghhVwTeZyt+MBBFTpQSgj/JZvcJAHjOl9wCpJ0RT/ljCoHMiXiOBEWhrhjKBFYwojJLg0biZq2MQQl8uXeWP1fB5ERI4kBqLZ/sHk5xVdQnhPYgSltPeJSLF7hEqjaOpTXvLU0GH+3GtJJ8RXhPHzDS7gi4esqRHH3hvBAcC37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9fBO5MP+8IRvRuAtDlKLwNyHIs6E9m8Txkcis5AR6Y=;
 b=oDg8eS0IN0+iZ0HDSfVhuDPUTdDazCzGjLU3GexTbGp52pJq6rKCQEW74AnTe/WmyKQvja1dWN9Klr+pw88+hKhidCn9EreitON3StGSlNFnqcqUW6iNRdN+N8LYHbpFVbQ3ZAgp47krI+j9FAgSJ1cMkYXDEwJkGstBliTkkh8=
Received: from BN6PR1401CA0011.namprd14.prod.outlook.com
 (2603:10b6:405:4b::21) by CH0PR12MB5153.namprd12.prod.outlook.com
 (2603:10b6:610:b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Sun, 20 Jun
 2021 16:42:02 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::cd) by BN6PR1401CA0011.outlook.office365.com
 (2603:10b6:405:4b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Sun, 20 Jun 2021 16:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Sun, 20 Jun 2021 16:42:02 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 20 Jun
 2021 11:41:57 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <Nehal-bakulchandra.Shah@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v10 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
Date:   Sun, 20 Jun 2021 11:41:36 -0500
Message-ID: <1624207298-115928-2-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
References: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc4f53e2-fc81-4314-6461-08d9340a546f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5153:
X-Microsoft-Antispam-PRVS: <CH0PR12MB51539EFCF4E6F479E7835791E50B9@CH0PR12MB5153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOLp0L9BZ/ye94u8dPK/+vpI1ZlDduJwm0lTcMF0Fzf8vmLmL53H95YqHexw5R7jpcHmJ1zufK+ZHWbSn4lt3Qg3+l0vpW6sjX5rP7H//omV2/LD+3oH1STrSTkkpFTp5cv+RKxDsTVoSVQJLJ4hLmqWkJWS/2q8Bocz3AQDWwjaWv3gPjGNBy26JKeFCdBv0E+hCO0To5eAZYR56caG4U+YyIj8p5FdeAyMx/+/RJ6bHVJc34BiwDxVhMJJDoh2veLQDlbNNMKlR+VloLP7DoY1BXVS2rwpkXCWBCPa4VPqDM5xCXaq/5j7SsLkt1nSsXjTOYTA4xz7RcvT4be7OEcXJS8i6sF0ROyLOUYTWxhx10tyh45ggSf1pbBBWjIENX6L7IKwjqs+PsEyk5L77DAFHy9wJTCGolGpywz708UIRZEANz3CxylfCFdss4rzLUdvXIZMhDl2sgfzGZuRa6m4r9QUSK00Ok3sPKVMzov/6mi98sWq0Wjd4NU3wpP+nN4MUluTxV3BqTmNcUkjaOR+TEXf2Pi5s8phQOZsnBu7cKpmEHYNaoTaUZS3cIqPda33oTE4gyjArhUF+WOZ4LCNq75pDD+EYTUb2FIea4pYYHDKJOWFsSv1V6AaxwH+9+8gcmR77M6lPuIKBfho+hovX+2EWIIuC9zJG4q21S3ZWqeM3RBQS1cfz5+P8Fjc
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(36840700001)(46966006)(7696005)(81166007)(316002)(83380400001)(47076005)(2616005)(54906003)(82310400003)(70586007)(4326008)(6916009)(8936002)(5660300002)(26005)(356005)(70206006)(2906002)(16526019)(8676002)(336012)(86362001)(36756003)(30864003)(186003)(426003)(6666004)(478600001)(36860700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2021 16:42:02.0019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4f53e2-fc81-4314-6461-08d9340a546f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Add support for AMD PTDMA controller. It performs high-bandwidth
memory to memory and IO copy operation. Device commands are managed
via a circular queue of 'descriptors', each of which specifies source
and destination addresses for copying a single buffer of data.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 MAINTAINERS                   |   6 +
 drivers/dma/Kconfig           |   2 +
 drivers/dma/Makefile          |   1 +
 drivers/dma/ptdma/Kconfig     |  11 ++
 drivers/dma/ptdma/Makefile    |  10 ++
 drivers/dma/ptdma/ptdma-dev.c | 290 ++++++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c | 245 ++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h     | 302 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 867 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c..2c897fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -957,6 +957,12 @@ S:	Supported
 T:	git git://people.freedesktop.org/~agd5f/linux
 F:	drivers/gpu/drm/amd/pm/powerplay/
 
++AMD PTDMA DRIVER
++M:	Sanjay R Mehta <sanju.mehta@amd.com>
++L:	dmaengine@vger.kernel.org
++S:	Maintained
++F:	drivers/dma/ptdma/
+
 AMD SEATTLE DEVICE TREE SUPPORT
 M:	Brijesh Singh <brijeshkumar.singh@amd.com>
 M:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6ab9d9a..7900f1a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -714,6 +714,8 @@ source "drivers/dma/bestcomm/Kconfig"
 
 source "drivers/dma/mediatek/Kconfig"
 
+source "drivers/dma/ptdma/Kconfig"
+
 source "drivers/dma/qcom/Kconfig"
 
 source "drivers/dma/dw/Kconfig"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index aa69094..bf9ffc2 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_DMATEST) += dmatest.o
 obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
 obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
+obj-$(CONFIG_AMD_PTDMA) += ptdma/
 obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
 obj-$(CONFIG_AT_XDMAC) += at_xdmac.o
 obj-$(CONFIG_AXI_DMAC) += dma-axi-dmac.o
diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
new file mode 100644
index 0000000..e6b8ca1
--- /dev/null
+++ b/drivers/dma/ptdma/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AMD_PTDMA
+	tristate  "AMD PassThru DMA Engine"
+	depends on X86_64 && PCI
+	help
+	  Enable support for the AMD PTDMA controller. This controller
+	  provides DMA capabilities to perform high bandwidth memory to
+	  memory and IO copy operations. It performs DMA transfer through
+	  queue-based descriptor management. This DMA controller is intended
+	  to be used with AMD Non-Transparent Bridge devices and not for
+	  general purpose peripheral DMA.
diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/ptdma/Makefile
new file mode 100644
index 0000000..320fa82
--- /dev/null
+++ b/drivers/dma/ptdma/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AMD Passthru DMA driver
+#
+
+obj-$(CONFIG_AMD_PTDMA) += ptdma.o
+
+ptdma-objs := ptdma-dev.o
+
+ptdma-$(CONFIG_PCI) += ptdma-pci.o
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
new file mode 100644
index 0000000..4f9ae0b
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Passthru DMA device driver
+ * -- Based on the CCP driver
+ *
+ * Copyright (C) 2016,2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/dma-mapping.h>
+#include <linux/debugfs.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "ptdma.h"
+
+/* Human-readable error strings */
+static char *pt_error_codes[] = {
+	"",
+	"ERR 01: ILLEGAL_ENGINE",
+	"ERR 03: ILLEGAL_FUNCTION_TYPE",
+	"ERR 04: ILLEGAL_FUNCTION_MODE",
+	"ERR 06: ILLEGAL_FUNCTION_SIZE",
+	"ERR 08: ILLEGAL_FUNCTION_RSVD",
+	"ERR 09: ILLEGAL_BUFFER_LENGTH",
+	"ERR 10: VLSB_FAULT",
+	"ERR 11: ILLEGAL_MEM_ADDR",
+	"ERR 12: ILLEGAL_MEM_SEL",
+	"ERR 13: ILLEGAL_CONTEXT_ID",
+	"ERR 15: 0xF Reserved",
+	"ERR 18: CMD_TIMEOUT",
+	"ERR 19: IDMA0_AXI_SLVERR",
+	"ERR 20: IDMA0_AXI_DECERR",
+	"ERR 21: 0x15 Reserved",
+	"ERR 22: IDMA1_AXI_SLAVE_FAULT",
+	"ERR 23: IDMA1_AIXI_DECERR",
+	"ERR 24: 0x18 Reserved",
+	"ERR 27: 0x1B Reserved",
+	"ERR 38: ODMA0_AXI_SLVERR",
+	"ERR 39: ODMA0_AXI_DECERR",
+	"ERR 40: 0x28 Reserved",
+	"ERR 41: ODMA1_AXI_SLVERR",
+	"ERR 42: ODMA1_AXI_DECERR",
+	"ERR 43: LSB_PARITY_ERR",
+};
+
+static void pt_log_error(struct pt_device *d, int e)
+{
+	dev_err(d->dev, "PTDMA error: %s (0x%x)\n", pt_error_codes[e], e);
+}
+
+void pt_start_queue(struct pt_cmd_queue *cmd_q)
+{
+	/* Turn on the run bit */
+	iowrite32(cmd_q->qcontrol | CMD_Q_RUN, cmd_q->reg_control);
+}
+
+void pt_stop_queue(struct pt_cmd_queue *cmd_q)
+{
+	/* Turn off the run bit */
+	iowrite32(cmd_q->qcontrol & ~CMD_Q_RUN, cmd_q->reg_control);
+}
+
+static int pt_core_execute_cmd(struct ptdma_desc *desc, struct pt_cmd_queue *cmd_q)
+{
+	bool soc = FIELD_GET(DWORD0_SOC, desc->dw0);
+	u8 *q_desc = (u8 *)&cmd_q->qbase[cmd_q->qidx];
+	u32 tail;
+
+	if (soc) {
+		desc->dw0 |= FIELD_PREP(DWORD0_IOC, desc->dw0);
+		desc->dw0 &= ~DWORD0_SOC;
+	}
+	mutex_lock(&cmd_q->q_mutex);
+
+	/* Copy 32-byte command descriptor to hw queue. */
+	memcpy(q_desc, desc, 32);
+	cmd_q->qidx = (cmd_q->qidx + 1) % CMD_Q_LEN;
+
+	/* The data used by this command must be flushed to memory */
+	wmb();
+
+	/* Write the new tail address back to the queue register */
+	tail = lower_32_bits(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);
+	iowrite32(tail, cmd_q->reg_tail_lo);
+
+	/* Turn the queue back on using our cached control register */
+	pt_start_queue(cmd_q);
+	mutex_unlock(&cmd_q->q_mutex);
+
+	return 0;
+}
+
+int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
+			     struct pt_passthru_engine *pt_engine)
+{
+	struct ptdma_desc desc;
+
+	cmd_q->cmd_error = 0;
+	memset(&desc, 0, sizeof(desc));
+	desc.dw0 = CMD_DESC_DW0_VAL;
+	desc.length = pt_engine->src_len;
+	desc.src_lo = lower_32_bits(pt_engine->src_dma);
+	desc.dw3.src_hi = upper_32_bits(pt_engine->src_dma);
+	desc.dst_lo = lower_32_bits(pt_engine->dst_dma);
+	desc.dw5.dst_hi = upper_32_bits(pt_engine->dst_dma);
+
+	return pt_core_execute_cmd(&desc, cmd_q);
+}
+
+static inline void pt_core_disable_queue_interrupts(struct pt_device *pt)
+{
+	iowrite32(0, pt->cmd_q.reg_int_enable);
+}
+
+static inline void pt_core_enable_queue_interrupts(struct pt_device *pt)
+{
+	iowrite32(SUPPORTED_INTERRUPTS, pt->cmd_q.reg_int_enable);
+}
+
+static irqreturn_t pt_core_irq_handler(int irq, void *data)
+{
+	struct pt_device *pt = data;
+	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
+	u32 status;
+	bool err = true;
+
+	pt_core_disable_queue_interrupts(pt);
+
+	status = ioread32(cmd_q->reg_interrupt_status);
+	if (status) {
+		cmd_q->int_status = status;
+		cmd_q->q_status = ioread32(cmd_q->reg_status);
+		cmd_q->q_int_status = ioread32(cmd_q->reg_int_status);
+
+		/* On error, only save the first error value */
+		if ((status & INT_ERROR) && !cmd_q->cmd_error) {
+			cmd_q->cmd_error = CMD_Q_ERROR(cmd_q->q_status);
+			err = false;
+		}
+
+		/* Acknowledge the interrupt */
+		iowrite32(status, cmd_q->reg_interrupt_status);
+	}
+
+	pt_core_enable_queue_interrupts(pt);
+
+	return err ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static void pt_init_cmdq_regs(struct pt_cmd_queue *cmd_q)
+{
+	void __iomem *io_regs = cmd_q->reg_control;
+
+	cmd_q->reg_tail_lo = io_regs + CMD_Q_TAIL_LO_BASE;
+	cmd_q->reg_head_lo = io_regs + CMD_Q_HEAD_LO_BASE;
+	cmd_q->reg_status = io_regs + CMD_Q_STATUS_BASE;
+	cmd_q->reg_int_enable = io_regs + CMD_Q_INT_ENABLE_BASE;
+	cmd_q->reg_int_status = io_regs + CMD_Q_INT_STATUS_BASE;
+	cmd_q->reg_dma_status = io_regs + CMD_Q_DMA_STATUS_BASE;
+	cmd_q->reg_dma_read_status = io_regs + CMD_Q_DMA_READ_STATUS_BASE;
+	cmd_q->reg_dma_write_status = io_regs + CMD_Q_DMA_WRITE_STATUS_BASE;
+	cmd_q->reg_interrupt_status = io_regs + CMD_Q_INTERRUPT_STATUS_BASE;
+}
+
+int pt_core_init(struct pt_device *pt)
+{
+	char dma_pool_name[MAX_DMAPOOL_NAME_LEN];
+	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
+	u32 dma_addr_lo, dma_addr_hi;
+	struct device *dev = pt->dev;
+	struct dma_pool *dma_pool;
+	int ret;
+
+	/* Allocate a dma pool for the queue */
+	snprintf(dma_pool_name, sizeof(dma_pool_name), "%s_q", pt->name);
+
+	dma_pool = dma_pool_create(dma_pool_name, dev,
+				   PT_DMAPOOL_MAX_SIZE,
+				   PT_DMAPOOL_ALIGN, 0);
+	if (!dma_pool)
+		return -ENOMEM;
+
+	/* ptdma core initialisation */
+	iowrite32(CMD_CONFIG_VHB_EN, pt->io_regs + CMD_CONFIG_OFFSET);
+	iowrite32(CMD_QUEUE_PRIO, pt->io_regs + CMD_QUEUE_PRIO_OFFSET);
+	iowrite32(CMD_TIMEOUT_DISABLE, pt->io_regs + CMD_TIMEOUT_OFFSET);
+	iowrite32(CMD_CLK_GATE_CONFIG, pt->io_regs + CMD_CLK_GATE_CTL_OFFSET);
+	iowrite32(CMD_CONFIG_REQID, pt->io_regs + CMD_REQID_CONFIG_OFFSET);
+
+	cmd_q->pt = pt;
+	cmd_q->dma_pool = dma_pool;
+	mutex_init(&cmd_q->q_mutex);
+
+	/* Page alignment satisfies our needs for N <= 128 */
+	cmd_q->qsize = Q_SIZE(Q_DESC_SIZE);
+	cmd_q->qbase = dma_alloc_coherent(dev, cmd_q->qsize,
+					  &cmd_q->qbase_dma,
+					  GFP_KERNEL);
+	if (!cmd_q->qbase) {
+		dev_err(dev, "unable to allocate command queue\n");
+		ret = -ENOMEM;
+		goto e_dma_alloc;
+	}
+
+	cmd_q->qidx = 0;
+
+	/* Preset some register values */
+	cmd_q->reg_control = pt->io_regs + CMD_Q_STATUS_INCR;
+	pt_init_cmdq_regs(cmd_q);
+
+	/* Turn off the queues and disable interrupts until ready */
+	pt_core_disable_queue_interrupts(pt);
+
+	cmd_q->qcontrol = 0; /* Start with nothing */
+	iowrite32(cmd_q->qcontrol, cmd_q->reg_control);
+
+	ioread32(cmd_q->reg_int_status);
+	ioread32(cmd_q->reg_status);
+
+	/* Clear the interrupt status */
+	iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_interrupt_status);
+
+	/* Request an irq */
+	ret = request_irq(pt->pt_irq, pt_core_irq_handler, 0, pt->name, pt);
+	if (ret)
+		goto e_pool;
+
+	/* Update the device registers with queue information. */
+	cmd_q->qcontrol &= ~CMD_Q_SIZE;
+	cmd_q->qcontrol |= FIELD_PREP(CMD_Q_SIZE, QUEUE_SIZE_VAL);
+
+	cmd_q->qdma_tail = cmd_q->qbase_dma;
+	dma_addr_lo = lower_32_bits(cmd_q->qdma_tail);
+	iowrite32((u32)dma_addr_lo, cmd_q->reg_tail_lo);
+	iowrite32((u32)dma_addr_lo, cmd_q->reg_head_lo);
+
+	dma_addr_hi = upper_32_bits(cmd_q->qdma_tail);
+	cmd_q->qcontrol |= (dma_addr_hi << 16);
+	iowrite32(cmd_q->qcontrol, cmd_q->reg_control);
+
+	pt_core_enable_queue_interrupts(pt);
+
+	return 0;
+
+e_dma_alloc:
+	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase, cmd_q->qbase_dma);
+
+e_pool:
+	dev_err(dev, "unable to allocate an IRQ\n");
+	dma_pool_destroy(pt->cmd_q.dma_pool);
+
+	return ret;
+}
+
+void pt_core_destroy(struct pt_device *pt)
+{
+	struct device *dev = pt->dev;
+	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
+	struct pt_cmd *cmd;
+
+	/* Disable and clear interrupts */
+	pt_core_disable_queue_interrupts(pt);
+
+	/* Turn off the run bit */
+	pt_stop_queue(cmd_q);
+
+	/* Clear the interrupt status */
+	iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_interrupt_status);
+	ioread32(cmd_q->reg_int_status);
+	ioread32(cmd_q->reg_status);
+
+	free_irq(pt->pt_irq, pt);
+
+	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase,
+			  cmd_q->qbase_dma);
+
+	/* Flush the cmd queue */
+	while (!list_empty(&pt->cmd)) {
+		/* Invoke the callback directly with an error code */
+		cmd = list_first_entry(&pt->cmd, struct pt_cmd, entry);
+		list_del(&cmd->entry);
+		cmd->pt_cmd_callback(cmd->data, -ENODEV);
+	}
+}
diff --git a/drivers/dma/ptdma/ptdma-pci.c b/drivers/dma/ptdma/ptdma-pci.c
new file mode 100644
index 0000000..ec75ec2
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-pci.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Passthru DMA device driver
+ * -- Based on the CCP driver
+ *
+ * Copyright (C) 2016,2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/pci_ids.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+
+#include "ptdma.h"
+
+struct pt_msix {
+	int msix_count;
+	struct msix_entry msix_entry;
+};
+
+/*
+ * pt_alloc_struct - allocate and initialize the pt_device struct
+ *
+ * @dev: device struct of the PTDMA
+ */
+static struct pt_device *pt_alloc_struct(struct device *dev)
+{
+	struct pt_device *pt;
+
+	pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
+
+	if (!pt)
+		return NULL;
+	pt->dev = dev;
+
+	INIT_LIST_HEAD(&pt->cmd);
+
+	snprintf(pt->name, MAX_PT_NAME_LEN, "pt-%s", dev_name(dev));
+
+	return pt;
+}
+
+static int pt_get_msix_irqs(struct pt_device *pt)
+{
+	struct pt_msix *pt_msix = pt->pt_msix;
+	struct device *dev = pt->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	pt_msix->msix_entry.entry = 0;
+
+	ret = pci_enable_msix_range(pdev, &pt_msix->msix_entry, 1, 1);
+	if (ret < 0)
+		return ret;
+
+	pt_msix->msix_count = ret;
+
+	pt->pt_irq = pt_msix->msix_entry.vector;
+
+	return 0;
+}
+
+static int pt_get_msi_irq(struct pt_device *pt)
+{
+	struct device *dev = pt->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	ret = pci_enable_msi(pdev);
+	if (ret)
+		return ret;
+
+	pt->pt_irq = pdev->irq;
+
+	return 0;
+}
+
+static int pt_get_irqs(struct pt_device *pt)
+{
+	struct device *dev = pt->dev;
+	int ret;
+
+	ret = pt_get_msix_irqs(pt);
+	if (!ret)
+		return 0;
+
+	/* Couldn't get MSI-X vectors, try MSI */
+	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
+	ret = pt_get_msi_irq(pt);
+	if (!ret)
+		return 0;
+
+	/* Couldn't get MSI interrupt */
+	dev_err(dev, "could not enable MSI (%d)\n", ret);
+
+	return ret;
+}
+
+static void pt_free_irqs(struct pt_device *pt)
+{
+	struct pt_msix *pt_msix = pt->pt_msix;
+	struct device *dev = pt->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (pt_msix->msix_count)
+		pci_disable_msix(pdev);
+	else if (pt->pt_irq)
+		pci_disable_msi(pdev);
+
+	pt->pt_irq = 0;
+}
+
+static int pt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct pt_device *pt;
+	struct pt_msix *pt_msix;
+	struct device *dev = &pdev->dev;
+	void __iomem * const *iomap_table;
+	int bar_mask;
+	int ret = -ENOMEM;
+
+	pt = pt_alloc_struct(dev);
+	if (!pt)
+		goto e_err;
+
+	pt_msix = devm_kzalloc(dev, sizeof(*pt_msix), GFP_KERNEL);
+	if (!pt_msix)
+		goto e_err;
+
+	pt->pt_msix = pt_msix;
+	pt->dev_vdata = (struct pt_dev_vdata *)id->driver_data;
+	if (!pt->dev_vdata) {
+		ret = -ENODEV;
+		dev_err(dev, "missing driver data\n");
+		goto e_err;
+	}
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		dev_err(dev, "pcim_enable_device failed (%d)\n", ret);
+		goto e_err;
+	}
+
+	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
+	ret = pcim_iomap_regions(pdev, bar_mask, "ptdma");
+	if (ret) {
+		dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
+		goto e_err;
+	}
+
+	iomap_table = pcim_iomap_table(pdev);
+	if (!iomap_table) {
+		dev_err(dev, "pcim_iomap_table failed\n");
+		ret = -ENOMEM;
+		goto e_err;
+	}
+
+	pt->io_regs = iomap_table[pt->dev_vdata->bar];
+	if (!pt->io_regs) {
+		dev_err(dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto e_err;
+	}
+
+	ret = pt_get_irqs(pt);
+	if (ret)
+		goto e_err;
+
+	pci_set_master(pdev);
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
+	if (ret) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n",
+				ret);
+			goto e_err;
+		}
+	}
+
+	dev_set_drvdata(dev, pt);
+
+	if (pt->dev_vdata)
+		ret = pt_core_init(pt);
+
+	if (ret)
+		goto e_err;
+
+	return 0;
+
+e_err:
+	dev_err(dev, "initialization failed\n");
+
+	return ret;
+}
+
+static void pt_pci_remove(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pt_device *pt = dev_get_drvdata(dev);
+
+	if (!pt)
+		return;
+
+	if (pt->dev_vdata)
+		pt_core_destroy(pt);
+
+	pt_free_irqs(pt);
+}
+
+static const struct pt_dev_vdata dev_vdata[] = {
+	{
+		.bar = 2,
+	},
+};
+
+static const struct pci_device_id pt_pci_table[] = {
+	{ PCI_VDEVICE(AMD, 0x1498), (kernel_ulong_t)&dev_vdata[0] },
+	/* Last entry must be zero */
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, pt_pci_table);
+
+static struct pci_driver pt_pci_driver = {
+	.name = "ptdma",
+	.id_table = pt_pci_table,
+	.probe = pt_pci_probe,
+	.remove = pt_pci_remove,
+};
+
+module_pci_driver(pt_pci_driver);
+
+MODULE_AUTHOR("Sanjay R Mehta <sanju.mehta@amd.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD PassThru DMA driver");
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
new file mode 100644
index 0000000..f8082c9
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma.h
@@ -0,0 +1,302 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD Passthru DMA device driver
+ * -- Based on the CCP driver
+ *
+ * Copyright (C) 2016,2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#ifndef __PT_DEV_H__
+#define __PT_DEV_H__
+
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/wait.h>
+#include <linux/dmapool.h>
+
+#define MAX_PT_NAME_LEN			16
+#define MAX_DMAPOOL_NAME_LEN		32
+
+#define MAX_HW_QUEUES			1
+#define MAX_CMD_QLEN			100
+
+#define PT_ENGINE_PASSTHRU		5
+#define PT_OFFSET			0x0
+
+/* Register Mappings */
+#define IRQ_MASK_REG			0x040
+#define IRQ_STATUS_REG			0x200
+
+#define CMD_Q_ERROR(__qs)		((__qs) & 0x0000003f)
+
+#define CMD_QUEUE_PRIO_OFFSET		0x00
+#define CMD_REQID_CONFIG_OFFSET		0x04
+#define CMD_TIMEOUT_OFFSET		0x08
+#define CMD_PT_VERSION			0x10
+
+#define CMD_Q_CONTROL_BASE		0x0000
+#define CMD_Q_TAIL_LO_BASE		0x0004
+#define CMD_Q_HEAD_LO_BASE		0x0008
+#define CMD_Q_INT_ENABLE_BASE		0x000C
+#define CMD_Q_INTERRUPT_STATUS_BASE	0x0010
+
+#define CMD_Q_STATUS_BASE		0x0100
+#define CMD_Q_INT_STATUS_BASE		0x0104
+#define CMD_Q_DMA_STATUS_BASE		0x0108
+#define CMD_Q_DMA_READ_STATUS_BASE	0x010C
+#define CMD_Q_DMA_WRITE_STATUS_BASE	0x0110
+#define CMD_Q_ABORT_BASE		0x0114
+#define CMD_Q_AX_CACHE_BASE		0x0118
+
+#define CMD_CONFIG_OFFSET		0x1120
+#define CMD_CLK_GATE_CTL_OFFSET		0x6004
+
+#define CMD_DESC_DW0_VAL		0x500012
+
+/* Address offset for virtual queue registers */
+#define CMD_Q_STATUS_INCR		0x1000
+
+/* Bit masks */
+#define CMD_CONFIG_REQID		0
+#define CMD_TIMEOUT_DISABLE		0
+#define CMD_CLK_DYN_GATING_DIS		0
+#define CMD_CLK_SW_GATE_MODE		0
+#define CMD_CLK_GATE_CTL		0
+#define CMD_QUEUE_PRIO			GENMASK(2, 1)
+#define CMD_CONFIG_VHB_EN		BIT(0)
+#define CMD_CLK_DYN_GATING_EN		BIT(0)
+#define CMD_CLK_HW_GATE_MODE		BIT(0)
+#define CMD_CLK_GATE_ON_DELAY		BIT(12)
+#define CMD_CLK_GATE_OFF_DELAY		BIT(12)
+
+#define CMD_CLK_GATE_CONFIG		(CMD_CLK_GATE_CTL | \
+					CMD_CLK_HW_GATE_MODE | \
+					CMD_CLK_GATE_ON_DELAY | \
+					CMD_CLK_DYN_GATING_EN | \
+					CMD_CLK_GATE_OFF_DELAY)
+
+#define CMD_Q_LEN			32
+#define CMD_Q_RUN			BIT(0)
+#define CMD_Q_HALT			BIT(1)
+#define CMD_Q_MEM_LOCATION		BIT(2)
+#define CMD_Q_SIZE_MASK			GENMASK(4, 0)
+#define CMD_Q_SIZE			GENMASK(7, 3)
+#define CMD_Q_SHIFT			GENMASK(1, 0)
+#define QUEUE_SIZE_VAL			((ffs(CMD_Q_LEN) - 2) & \
+								  CMD_Q_SIZE_MASK)
+#define Q_PTR_MASK			(2 << (QUEUE_SIZE_VAL + 5) - 1)
+#define Q_DESC_SIZE			sizeof(struct ptdma_desc)
+#define Q_SIZE(n)			(CMD_Q_LEN * (n))
+
+#define INT_COMPLETION			BIT(0)
+#define INT_ERROR			BIT(1)
+#define INT_QUEUE_STOPPED		BIT(2)
+#define INT_EMPTY_QUEUE			BIT(3)
+#define SUPPORTED_INTERRUPTS		(INT_COMPLETION | INT_ERROR)
+
+/****** Local Storage Block ******/
+#define LSB_START			0
+#define LSB_END				127
+#define LSB_COUNT			(LSB_END - LSB_START + 1)
+
+#define PT_DMAPOOL_MAX_SIZE		64
+#define PT_DMAPOOL_ALIGN		BIT(5)
+
+#define PT_PASSTHRU_BLOCKSIZE		512
+
+struct pt_device;
+
+struct pt_tasklet_data {
+	struct completion completion;
+	struct pt_cmd *cmd;
+};
+
+/*
+ * struct pt_passthru_engine - pass-through operation
+ *   without performing DMA mapping
+ * @mask: mask to be applied to data
+ * @mask_len: length in bytes of mask
+ * @src_dma: data to be used for this operation
+ * @dst_dma: data produced by this operation
+ * @src_len: length in bytes of data used for this operation
+ *
+ * Variables required to be set when calling pt_enqueue_cmd():
+ *   - bit_mod, byte_swap, src, dst, src_len
+ *   - mask, mask_len if bit_mod is not PT_PASSTHRU_BITWISE_NOOP
+ */
+struct pt_passthru_engine {
+	dma_addr_t mask;
+	u32 mask_len;		/* In bytes */
+
+	dma_addr_t src_dma, dst_dma;
+	u64 src_len;		/* In bytes */
+};
+
+/*
+ * struct pt_cmd - PTDMA operation request
+ * @entry: list element
+ * @work: work element used for callbacks
+ * @pt: PT device to be run on
+ * @ret: operation return code
+ * @flags: cmd processing flags
+ * @engine: PTDMA operation to perform (passthru)
+ * @engine_error: PT engine return code
+ * @passthru: engine specific structures, refer to specific engine struct below
+ * @callback: operation completion callback function
+ * @data: parameter value to be supplied to the callback function
+ *
+ * Variables required to be set when calling pt_enqueue_cmd():
+ *   - engine, callback
+ *   - See the operation structures below for what is required for each
+ *     operation.
+ */
+struct pt_cmd {
+	struct list_head entry;
+	struct work_struct work;
+	struct pt_device *pt;
+	int ret;
+	u32 engine;
+	u32 engine_error;
+	struct pt_passthru_engine passthru;
+	/* Completion callback support */
+	void (*pt_cmd_callback)(void *data, int err);
+	void *data;
+};
+
+struct pt_cmd_queue {
+	struct pt_device *pt;
+
+	/* Queue dma pool */
+	struct dma_pool *dma_pool;
+
+	/* Queue base address (not neccessarily aligned)*/
+	struct ptdma_desc *qbase;
+
+	/* Aligned queue start address (per requirement) */
+	struct mutex q_mutex ____cacheline_aligned;
+	unsigned int qidx;
+
+	unsigned int qsize;
+	dma_addr_t qbase_dma;
+	dma_addr_t qdma_tail;
+
+	unsigned int active;
+	unsigned int suspended;
+
+	/* Register addresses for queue */
+	void __iomem *reg_control;
+	void __iomem *reg_tail_lo;
+	void __iomem *reg_head_lo;
+	void __iomem *reg_int_enable;
+	void __iomem *reg_interrupt_status;
+	void __iomem *reg_status;
+	void __iomem *reg_int_status;
+	void __iomem *reg_dma_status;
+	void __iomem *reg_dma_read_status;
+	void __iomem *reg_dma_write_status;
+	u32 qcontrol; /* Cached control register */
+
+	/* Status values from job */
+	u32 int_status;
+	u32 q_status;
+	u32 q_int_status;
+	u32 cmd_error;
+} ____cacheline_aligned;
+
+struct pt_device {
+	struct list_head entry;
+
+	unsigned int ord;
+	char name[MAX_PT_NAME_LEN];
+
+	struct device *dev;
+
+	/* Bus specific device information */
+	struct pt_msix *pt_msix;
+
+	struct pt_dev_vdata *dev_vdata;
+
+	unsigned int pt_irq;
+
+	/* I/O area used for device communication */
+	void __iomem *io_regs;
+
+	spinlock_t cmd_lock ____cacheline_aligned;
+	unsigned int cmd_count;
+	struct list_head cmd;
+
+	/*
+	 * The command queue. This represent the queue available on the
+	 * PTDMA that are available for processing cmds
+	 */
+	struct pt_cmd_queue cmd_q;
+
+	wait_queue_head_t lsb_queue;
+
+	struct pt_tasklet_data tdata;
+};
+
+/*
+ * descriptor for PTDMA commands
+ * 8 32-bit words:
+ * word 0: function; engine; control bits
+ * word 1: length of source data
+ * word 2: low 32 bits of source pointer
+ * word 3: upper 16 bits of source pointer; source memory type
+ * word 4: low 32 bits of destination pointer
+ * word 5: upper 16 bits of destination pointer; destination memory type
+ * word 6: reserved 32 bits
+ * word 7: reserved 32 bits
+ */
+
+#define DWORD0_SOC	BIT(0)
+#define DWORD0_IOC	BIT(1)
+
+struct dword3 {
+	unsigned int  src_hi:16;
+	unsigned int  src_mem:2;
+	unsigned int  lsb_cxt_id:8;
+	unsigned int  rsvd1:5;
+	unsigned int  fixed:1;
+};
+
+struct dword5 {
+	unsigned int  dst_hi:16;
+	unsigned int  dst_mem:2;
+	unsigned int  rsvd1:13;
+	unsigned int  fixed:1;
+};
+
+struct ptdma_desc {
+	u32 dw0;
+	u32 length;
+	u32 src_lo;
+	struct dword3 dw3;
+	u32 dst_lo;
+	struct dword5 dw5;
+	__le32 rsvd1;
+	__le32 rsvd2;
+};
+
+/* Structure to hold PT device data */
+struct pt_dev_vdata {
+	const unsigned int bar;
+};
+
+int pt_core_init(struct pt_device *pt);
+void pt_core_destroy(struct pt_device *pt);
+
+int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
+			     struct pt_passthru_engine *pt_engine);
+
+void pt_start_queue(struct pt_cmd_queue *cmd_q);
+void pt_stop_queue(struct pt_cmd_queue *cmd_q);
+
+#endif
-- 
2.7.4

