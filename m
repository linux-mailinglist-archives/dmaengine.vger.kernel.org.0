Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7D12B54B
	for <lists+dmaengine@lfdr.de>; Fri, 27 Dec 2019 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfL0OsA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Dec 2019 09:48:00 -0500
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:7265
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbfL0OsA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Dec 2019 09:48:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GItMxf6rEX5UZigKVGBFAbeZTlSqJFq8bUqEQVop3DVG/VT8TSheVDurvTpAB6ERQNJ31xs6hEq+E18QVKb9KStqf2woPZFhwLFIPGojcgO/dQflGDNOEUg3zo0VAqO8oYF1c1lRfIxrhZbYzaU3FIcR7eqEmf8eRztw4tJiJtstr9cTgYtR3eAPc0bSs4G1PMoxcca7VW6PwZlGPxiCmCPo1rbaYfzaReyEGcBYEN7PN/mqq/t5wpDF+lndOL93xubT+0BQyR7qfgZWv8mqEqvE+QqPYoixwj4Z2TiHgT1xNc5M6zOvRXW3sOxB+MKHxDa+FznGyrbCLjpd3gfsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZmvw0kKrlBlD2JuxV0KXaWgH9q7xD3YQW6EhZizg24=;
 b=j7W+zh5f7lkGg/EguHNRFXGJIZkJ1onWpwIkv4DJlZV+TFrvxjsMxd8lj+4CFErMG9/2xovnxb4u+Z2X/NDjDV0jnlYfjdxsfNM+C5XMKrfs28wdAMF9qCSwEqMsZSs5UZsqHIuvWscTMavHNHzTUTZg+XyKP7xL7HkXWR1O4Egr85qUuZM7tYd6j99ULeEzL1aMpfyeYzUUgjULlL2wfqbVvJAvGRxpYsMLrqsBqFQdNa1x7mvcggBwiP5tTQx8Jw8AApcxzxO2r3b4J4FjAH+HYzTgBE3qN98MK9Fovf7bdFu5FkVgY8fVJau/s7H431PZi+4a4JwH7LrF+4TrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZmvw0kKrlBlD2JuxV0KXaWgH9q7xD3YQW6EhZizg24=;
 b=M2rBYffU5gKX/UfHRwj6OxSF9sCV+u1sF0lgBJDY4BgPUC7ZFJV2aJdlwHodpek0cVZwmOQHAc0wRqOYk0JoEZ9KuNA9lkpXpN9GDqA3wk2BC/CetTEFOrWJ+pIB8GgYmI26+neL74IYEuwu7JAyQr2bYApsukik5/mYgPFOt8Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3485.namprd12.prod.outlook.com (20.178.242.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Fri, 27 Dec 2019 14:47:49 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c%4]) with mapi id 15.20.2581.007; Fri, 27 Dec 2019
 14:47:49 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, Gary.Hook@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>,
        Gary R Hook <gary.hook@amd.com>
Subject: [PATCH v2 1/3] dmaengine: ptdma: Initial driver for the AMD PassThru DMA engine
Date:   Fri, 27 Dec 2019 08:47:27 -0600
Message-Id: <1577458047-109654-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::14) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0004.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2581.11 via Frontend Transport; Fri, 27 Dec 2019 14:47:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86f75fbc-e843-41f9-a6f7-08d78adbbe6f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:|MN2PR12MB3485:|MN2PR12MB3485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34854A9AC22EFE0F662624CDE52A0@MN2PR12MB3485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-Forefront-PRVS: 0264FEA5C3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(189003)(199004)(2906002)(5660300002)(52116002)(54906003)(6666004)(6636002)(4326008)(316002)(26005)(7696005)(30864003)(16526019)(186003)(2616005)(6486002)(478600001)(81156014)(8676002)(66556008)(66946007)(66476007)(81166006)(8936002)(86362001)(36756003)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3485;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1r3aUD+5KV+39tHevHu6UAIxV2JDybz88T/KonLG//4fcFwb44kbEzareSFYpSpgdZ0+Pz+DbawJEqzWxHff4yi75DwcGWZ3UyXePKbSwPifgXi12IpfChT95GfpsTCZkwozpcqTWIQIa1AC3ssIA8AK/4XxExxjShJk9bd5ejqVYkDIEG21oM8cpE77OV2moWJK6F+bfmYiqCG2fbN3raGUZqjVyKWYrG4MfDv3vqXD3h6i6aQoS8XMky+hGptUy8fVR4XZFgklPcuVKtUNOJAJ/mMnqPqm4aZyAKxgFvuSp7yeWhR5atRXGsJBsX0uwVkUHDowBZjljp1TZsfuV2wI3qNC8JUQyJlgHl4hRwsb+DG03kWePvqZOKEFSFllHUBmHf2KiNHKXuDYEs4Lhezp5xNalJQseIXE6jnA6aaX+ZpGy9qJ8X1m+g36Q6M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f75fbc-e843-41f9-a6f7-08d78adbbe6f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2019 14:47:49.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peBe5s3NrlsABGtSkBweHC3j6dEXODiH6snYaRNIPQWNDtB1k3dSexP/O5bpK8C7Cjyizg+v5G6lHmHF59RX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3485
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This device performs high-bandwidth memory-to-memory
transfer operations.

Device commands are managed via a circular queue of
'descriptors', each of which specifies source and
destination addresses for copying a single buffer of data.

The driver must handle multiple devices, which are logged
on a linked list; all devices are treated equivalently.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 MAINTAINERS                   |   6 +
 drivers/dma/Kconfig           |   2 +
 drivers/dma/Makefile          |   1 +
 drivers/dma/ptdma/Kconfig     |   6 +
 drivers/dma/ptdma/Makefile    |  10 ++
 drivers/dma/ptdma/ptdma-dev.c | 387 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c | 269 +++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h     | 321 +++++++++++++++++++++++++++++++++++
 8 files changed, 1002 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e..42ef93c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -882,6 +882,12 @@ S:	Supported
 F:	drivers/net/ethernet/amd/xgbe/
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 
+AMD PTDMA DRIVER
+M:	Sanjay R Mehta <sanju.mehta@amd.com>
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	drivers/dma/ptdma/
+
 ANALOG DEVICES INC AD5686 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6fa1eba..d9856cc 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -697,6 +697,8 @@ source "drivers/dma/ti/Kconfig"
 
 source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
 
+source "drivers/dma/ptdma/Kconfig"
+
 # clients
 comment "DMA Clients"
 	depends on DMA_ENGINE
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 42d7e2f..a806824 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ZX_DMA) += zx_dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
+obj-$(CONFIG_AMD_PTDMA) += ptdma/
 
 obj-y += mediatek/
 obj-y += qcom/
diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
new file mode 100644
index 0000000..4ec259e
--- /dev/null
+++ b/drivers/dma/ptdma/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AMD_PTDMA
+	tristate  "AMD PassThru DMA Engine"
+	depends on X86_64 && PCI
+	help
+	  Provides the support for AMD PassThru DMA Engine.
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
index 0000000..7c8ddcb
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Passthru DMA device driver
+ * -- Based on the CCP driver
+ *
+ * Copyright (C) 2016,2019 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+
+#include "ptdma.h"
+
+static int cmd_queue_length = 32;
+module_param(cmd_queue_length, uint, 0644);
+MODULE_PARM_DESC(cmd_queue_length,
+		 " length of the command queue, a power of 2 (2 <= val <= 128)");
+
+/*
+ * List of PTDMAs, PTDMA count, read-write access lock, and access functions
+ *
+ * Lock structure: get pt_unit_lock for reading whenever we need to
+ * examine the PTDMA list. While holding it for reading we can acquire
+ * the RR lock to update the round-robin next-PTDMA pointer. The unit lock
+ * must be acquired before the RR lock.
+ *
+ * If the unit-lock is acquired for writing, we have total control over
+ * the list, so there's no value in getting the RR lock.
+ */
+static DEFINE_RWLOCK(pt_unit_lock);
+static LIST_HEAD(pt_units);
+
+static struct pt_device *pt_rr;
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
+/*
+ * pt_add_device - add a PTDMA device to the list
+ *
+ * @pt: pt_device struct pointer
+ *
+ * Put this PTDMA on the unit list, which makes it available
+ * for use.
+ *
+ * Returns zero if a PTDMA device is present, -ENODEV otherwise.
+ */
+static void pt_add_device(struct pt_device *pt)
+{
+	unsigned long flags;
+
+	write_lock_irqsave(&pt_unit_lock, flags);
+	list_add_tail(&pt->entry, &pt_units);
+	if (!pt_rr)
+		/*
+		 * We already have the list lock (we're first) so this
+		 * pointer can't change on us. Set its initial value.
+		 */
+		pt_rr = pt;
+	write_unlock_irqrestore(&pt_unit_lock, flags);
+}
+
+/*
+ * pt_del_device - remove a PTDMA device from the list
+ *
+ * @pt: pt_device struct pointer
+ *
+ * Remove this unit from the list of devices. If the next device
+ * up for use is this one, adjust the pointer. If this is the last
+ * device, NULL the pointer.
+ */
+static void pt_del_device(struct pt_device *pt)
+{
+	unsigned long flags;
+
+	write_lock_irqsave(&pt_unit_lock, flags);
+	if (pt_rr == pt) {
+		/*
+		 * pt_unit_lock is read/write; any read access
+		 * will be suspended while we make changes to the
+		 * list and RR pointer.
+		 */
+		if (list_is_last(&pt_rr->entry, &pt_units))
+			pt_rr = list_first_entry(&pt_units, struct pt_device,
+						 entry);
+		else
+			pt_rr = list_next_entry(pt_rr, entry);
+	}
+	list_del(&pt->entry);
+	if (list_empty(&pt_units))
+		pt_rr = NULL;
+	write_unlock_irqrestore(&pt_unit_lock, flags);
+}
+
+static int pt_core_execute_cmd(struct ptdma_desc *desc,
+			       struct pt_cmd_queue *cmd_q)
+{
+	u32 *mp;
+	__le32 *dp;
+	u32 tail;
+	int	i;
+	int ret = 0;
+
+	if (desc->dw0.soc) {
+		desc->dw0.ioc = 1;
+		desc->dw0.soc = 0;
+	}
+	mutex_lock(&cmd_q->q_mutex);
+
+	mp = (u32 *)&cmd_q->qbase[cmd_q->qidx];
+	dp = (__le32 *)desc;
+	for (i = 0; i < 8; i++)
+		mp[i] = cpu_to_le32(dp[i]); /* handle endianness */
+
+	cmd_q->qidx = (cmd_q->qidx + 1) % cmd_queue_length;
+
+	/* The data used by this command must be flushed to memory */
+	wmb();
+
+	/* Write the new tail address back to the queue register */
+	tail = lower_32_bits(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);
+	iowrite32(tail, cmd_q->reg_tail_lo);
+
+	/* Turn the queue back on using our cached control register */
+	iowrite32(cmd_q->qcontrol | CMD_Q_RUN, cmd_q->reg_control);
+	mutex_unlock(&cmd_q->q_mutex);
+
+	return ret;
+}
+
+int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
+			     struct pt_passthru_engine *pt_engine)
+{
+	struct ptdma_desc desc;
+
+	cmd_q->cmd_error = 0;
+
+	memset(&desc, 0, Q_DESC_SIZE);
+
+	desc.dw0.val = CMD_DESC_DW0_VAL;
+
+	desc.length = pt_engine->src_len;
+
+	desc.src_lo = lower_32_bits(pt_engine->src_dma);
+	desc.dw3.src_hi = upper_32_bits(pt_engine->src_dma);
+
+	desc.dst_lo = lower_32_bits(pt_engine->dst_dma);
+	desc.dw5.dst_hi = upper_32_bits(pt_engine->dst_dma);
+
+	return pt_core_execute_cmd(&desc, cmd_q);
+}
+
+static void pt_core_disable_queue_interrupts(struct pt_device *pt)
+{
+	iowrite32(0x0, pt->cmd_q.reg_int_enable);
+}
+
+static void pt_core_enable_queue_interrupts(struct pt_device *pt)
+{
+	iowrite32(SUPPORTED_INTERRUPTS, pt->cmd_q.reg_int_enable);
+}
+
+static irqreturn_t pt_core_irq_handler(int irq, void *data)
+{
+	struct pt_device *pt = (struct pt_device *)data;
+	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
+	u32 status;
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
+		if ((status & INT_ERROR) && !cmd_q->cmd_error)
+			cmd_q->cmd_error = CMD_Q_ERROR(cmd_q->q_status);
+
+		/* Acknowledge the interrupt */
+		iowrite32(status, cmd_q->reg_interrupt_status);
+	}
+
+	pt_core_enable_queue_interrupts(pt);
+
+	return IRQ_HANDLED;
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
+	struct device *dev = pt->dev;
+	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
+	struct dma_pool *dma_pool;
+	char dma_pool_name[MAX_DMAPOOL_NAME_LEN];
+	int ret;
+	u32 dma_addr_lo, dma_addr_hi;
+
+	/* Allocate a dma pool for the queue */
+	snprintf(dma_pool_name, sizeof(dma_pool_name), "%s_q", pt->name);
+
+	dma_pool = dma_pool_create(dma_pool_name, dev,
+				   PT_DMAPOOL_MAX_SIZE,
+				   PT_DMAPOOL_ALIGN, 0);
+	if (!dma_pool) {
+		dev_err(dev, "unable to allocate dma pool\n");
+		ret = -ENOMEM;
+		return ret;
+	}
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
+	/* Set the length module parameter */
+	if ((cmd_queue_length & (cmd_queue_length - 1)) ||
+	    cmd_queue_length < 2 || cmd_queue_length > 128) {
+		dev_err(dev, "invalid command queue length\n");
+		ret = -EINVAL;
+	}
+	dev_notice(dev, "Setting queue size to %d commands\n",
+		   cmd_queue_length);
+
+	/* Page alignment satisfies our needs for N <= 128 */
+	cmd_q->qsize = Q_SIZE(Q_DESC_SIZE);
+	cmd_q->qbase = dma_alloc_coherent(dev, cmd_q->qsize,
+					  &cmd_q->qbase_dma,
+					   GFP_KERNEL);
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
+	dev_dbg(dev, "queue available\n");
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
+	if (ret) {
+		dev_err(dev, "unable to allocate an IRQ\n");
+		goto e_pool;
+	}
+
+	/* Update the device registers with queue information.  */
+
+	cmd_q->qcontrol &= ~(CMD_Q_SIZE << CMD_Q_SHIFT);
+	cmd_q->qcontrol |= QUEUE_SIZE_VAL << CMD_Q_SHIFT;
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
+	dev_dbg(dev, "Enabling interrupts...\n");
+	pt_core_enable_queue_interrupts(pt);
+
+	/* Put this on the unit list to make it available */
+	pt_add_device(pt);
+
+	dev_dbg(dev, "PTDMA device %s registration successful...\n", pt->name);
+
+	return 0;
+
+e_dma_alloc:
+	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase, cmd_q->qbase_dma);
+
+e_pool:
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
+	/* Remove this device from the list of available units first */
+	pt_del_device(pt);
+
+	/* Disable and clear interrupts */
+	pt_core_disable_queue_interrupts(pt);
+
+	/* Turn off the run bit */
+	iowrite32(cmd_q->qcontrol & ~CMD_Q_RUN, cmd_q->reg_control);
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
index 0000000..8c8883d
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-pci.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Passthru DMA device driver
+ * -- Based on the CCP driver
+ *
+ * Copyright (C) 2016,2019 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/dma-mapping.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+
+#include "ptdma.h"
+
+/* Ever-increasing value to produce unique unit numbers */
+static atomic_t pt_ordinal;
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
+	if (!pt)
+		return NULL;
+	pt->dev = dev;
+	pt->ord = atomic_inc_return(&pt_ordinal);
+
+	INIT_LIST_HEAD(&pt->cmd);
+
+	snprintf(pt->name, MAX_PT_NAME_LEN, "pt-%u", pt->ord);
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
+	dev_notice(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
+	ret = pt_get_msi_irq(pt);
+	if (!ret)
+		return 0;
+
+	/* Couldn't get MSI interrupt */
+	dev_notice(dev, "could not enable MSI (%d)\n", ret);
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
+	if (ret) {
+		dev_notice(dev, "PTDMA initialization failed\n");
+		goto e_err;
+	}
+
+	dev_notice(dev, "PTDMA enabled\n");
+
+	return 0;
+
+e_err:
+	dev_notice(dev, "initialization failed\n");
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
+#ifdef CONFIG_PM
+static int pt_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	return -ENOSYS;
+}
+
+static int pt_pci_resume(struct pci_dev *pdev)
+{
+	return -ENOSYS;
+}
+#endif
+
+static const struct pt_dev_vdata dev_vdata[] = {
+	{
+		.bar = 2,
+		.version = PT_VERSION(5, 0),
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
+#ifdef CONFIG_PM
+	.suspend = pt_pci_suspend,
+	.resume = pt_pci_resume,
+#endif
+};
+
+module_pci_driver(pt_pci_driver);
+
+MODULE_AUTHOR("Sanjay R Mehta <sanju.mehta@amd.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD PassThru DMA driver");
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
new file mode 100644
index 0000000..0cabbf3
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma.h
@@ -0,0 +1,321 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD Passthru DMA device driver
+ * -- Based on the CCP driver
+ *
+ * Copyright (C) 2016,2019 Advanced Micro Devices, Inc.
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
+#define MAX_DMAPOOL_NAME_LEN	32
+
+#define MAX_HW_QUEUES		1
+#define MAX_CMD_QLEN		100
+
+#define PT_ENGINE_PASSTHRU	5
+#define PT_OFFSET			0x0
+
+#define	PT_VSIZE			16
+#define	PT_VMASK			((unsigned int)((1 << PT_VSIZE) - 1))
+#define	PT_VERSION(v, r)	((unsigned int)(((v) << PT_VSIZE) \
+					       | ((r) & PT_VMASK)))
+
+/* Register Mappings */
+#define IRQ_MASK_REG		0x040
+#define IRQ_STATUS_REG		0x200
+
+#define CMD_Q_ERROR(__qs)	((__qs) & 0x0000003f)
+
+#define	CMD_QUEUE_PRIO_OFFSET		0x00
+#define	CMD_REQID_CONFIG_OFFSET		0x04
+#define	CMD_TIMEOUT_OFFSET		0x08
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
+#define	CMD_CONFIG_OFFSET		0x1120
+#define	CMD_CLK_GATE_CTL_OFFSET		0x6004
+
+/* Address offset for virtual queue registers */
+#define CMD_Q_STATUS_INCR		0x1000
+
+/* Bit masks */
+#define	CMD_DESC_DW0_VAL		0x500012
+#define	CMD_CONFIG_REQID		0x0
+#define	CMD_CONFIG_VHB_EN		0x00000001
+#define	CMD_QUEUE_PRIO			0x00000006
+#define	CMD_TIMEOUT_DISABLE		0x00000000
+#define	CMD_CLK_DYN_GATING_EN	0x1
+#define	CMD_CLK_DYN_GATING_DIS	0x0
+#define	CMD_CLK_HW_GATE_MODE	0x1
+#define	CMD_CLK_SW_GATE_MODE	0x0
+#define	CMD_CLK_GATE_ON_DELAY	0x1000
+#define	CMD_CLK_GATE_CTL	0x0
+#define	CMD_CLK_GATE_OFF_DELAY	0x1000
+
+#define CMD_CLK_GATE_CONFIG	(CMD_CLK_GATE_CTL | \
+				CMD_CLK_HW_GATE_MODE | \
+				CMD_CLK_GATE_ON_DELAY | \
+				CMD_CLK_DYN_GATING_EN | \
+				CMD_CLK_GATE_OFF_DELAY)
+
+#define CMD_Q_RUN		0x1
+#define CMD_Q_HALT		0x2
+#define CMD_Q_MEM_LOCATION	0x4
+#define CMD_Q_SIZE		0x1F
+#define CMD_Q_SHIFT		3
+#define QUEUE_SIZE_VAL		((ffs(cmd_queue_length) - 2) & \
+							  CMD_Q_SIZE)
+#define Q_PTR_MASK		(2 << (QUEUE_SIZE_VAL + 5) - 1)
+#define Q_DESC_SIZE		sizeof(struct ptdma_desc)
+#define Q_SIZE(n)		(cmd_queue_length * (n))
+
+#define INT_COMPLETION		0x1
+#define INT_ERROR		0x2
+#define INT_QUEUE_STOPPED	0x4
+#define	INT_EMPTY_QUEUE		0x8
+#define SUPPORTED_INTERRUPTS	(INT_COMPLETION | INT_ERROR)
+
+/****** Local Storage Block ******/
+#define LSB_START		0
+#define LSB_END			127
+#define LSB_COUNT		(LSB_END - LSB_START + 1)
+
+#define PT_DMAPOOL_MAX_SIZE	64
+#define PT_DMAPOOL_ALIGN	BIT(5)
+
+#define PT_PASSTHRU_BLOCKSIZE	512
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
+ * @src: data to be used for this operation
+ * @dst: data produced by this operation
+ * @src_len: length in bytes of data used for this operation
+ * @final: indicate final pass-through operation
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
+
+	u32 final;
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
+
+	u32 engine;
+	u32 engine_error;
+
+	struct pt_passthru_engine passthru;
+
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
+
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
+	struct tasklet_struct tasklet;
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
+union dword0 {
+	struct {
+		unsigned int soc:1;
+		unsigned int ioc:1;
+		unsigned int rsvd1:1;
+		unsigned int init:1;
+		unsigned int eom:1;
+		unsigned int function:15;
+		unsigned int engine:4;
+		unsigned int prot:1;
+		unsigned int rsvd2:7;
+	};
+	u32 val;
+};
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
+	union dword0 dw0;
+	__le32 length;
+	__le32 src_lo;
+	struct dword3 dw3;
+	__le32 dst_lo;
+	struct dword5 dw5;
+	__le32 rsvd1;
+	__le32 rsvd2;
+};
+
+/* Structure to hold PT device data */
+struct pt_dev_vdata {
+	const unsigned int bar;
+	const unsigned int version;
+};
+
+int pt_core_init(struct pt_device *pt);
+void pt_core_destroy(struct pt_device *pt);
+
+int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
+			     struct pt_passthru_engine *pt_engine);
+
+#endif
-- 
2.7.4

