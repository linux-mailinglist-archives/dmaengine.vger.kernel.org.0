Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C18979BAE1
	for <lists+dmaengine@lfdr.de>; Tue, 12 Sep 2023 02:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbjIKWmo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Sep 2023 18:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244167AbjIKTZx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Sep 2023 15:25:53 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0C410D;
        Mon, 11 Sep 2023 12:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEhDxKvysdoqn19yB9dCbEENP+62p7gtySMCrSgr5HZOa0XOze4YdSaPDbfVLv8W5sK3OBpTzhiQ/0YIwvJ08DHf+7Aa5Ats9O3t5v3fXFyYtKIj3PHHHNIOsAhyuzuTtn6B4VmONacIeGw6ECZxMKqIazv1B2B9qkKy8Tu6N7uY/j4rqxBKWkag7fZjfjlcskHJ/YHIhpRyFXfkSGTr0V1CJhrvZhbVeC395fJzFOWY7V78VVLYgSr8VHX3sgvOWkO3IeXKsiVXEYhBMSt7527cUVhr4/SbxIHey0T+h+tz+vt08CYCO60r9wJvMW7ym3n+sX+fFfzgiKnKmSHagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwpNuGhoVQSoZahZvusrtbcnOKK0+qa556MgGUk6FQI=;
 b=AucFInafZKn5JTIprfU+e7ho/MS71bfLLwjQVCrVLCAmI2+msEKlFgzDRNSsvXCwT0hjOnkUeYB7ti0Q/3FYNmuWOhHo3PKeZ32zUzlqKdCKNw4RnSBjfkuDygamUH7a5yi0vjwyOs+ei9LKqryRrYt5ikoR4Ecaa7Z1wALMmveBp8Wkgeu157KHpAi8OtPgVXZci1GKYa82dlFFtxmoSWqYyZYoA6aUit1eobT/CQY9jGm5BcQ2aEak5nZNcwQfQKIjpr3nQ54B4S1qYM4iM7bI/8BeDj3i/n924tzHjJmJ97ugiRNx8JNnqt0/0E6qKAMe9ZYsxoL9bZ3NXDwdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwpNuGhoVQSoZahZvusrtbcnOKK0+qa556MgGUk6FQI=;
 b=SV9Rr2fHmzyeB6VJBiUBbhwkr4KPTi0bAGTvjSmEKo2QHMl8bK83qi7Wo9w9CrKQeoGpROwfYLVkTehzKrRH/AwpecGCa6TctGdVqo0VdszSXyWkEtF0ZPY09retrGsnHJIEu04LP/IoJkEKOd7b1Q6oLbwxG34xWxOEvNoC6OA=
Received: from CH0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::15)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 19:25:42 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::65) by CH0P223CA0003.outlook.office365.com
 (2603:10b6:610:116::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 19:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Mon, 11 Sep 2023 19:25:42 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 14:25:37 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <robh@kernel.org>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH 1/3] dmaengine: ae4dma: Initial ae4dma controller driver with multi channel
Date:   Mon, 11 Sep 2023 14:25:22 -0500
Message-ID: <1694460324-60346-2-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694460324-60346-1-git-send-email-Sanju.Mehta@amd.com>
References: <1694460324-60346-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 905c4ff9-5023-4d3e-8643-08dbb2fce3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2m+6yi0adGQQh4SW2hERTsIeHmyjYAbafgWiMPagCPorvNLZpuU/WEbB0ZN4NfLa6yxB/6dlesBHSU9HvDC65SllZgCO4fnOUdoCzJDaXMIOI/KSmng55j5CNcFEkhj75YG+OcTNMzBZ8PVlNgI7TUzDn25IuKgOumCWMjveqUUE1IpmXZx5yur8yWLrd1GLLcYtBbFdolAoIXG9tNNDpp+lqtVaMMrhkjZtHlAYRF1JIO/MrWGRCthF/4zgszfJgxv+sdrfDeyDLv9n1zqJB1MsJuQSnHLoO6MVRUGXl0KvVCHb2D2ErIDr0o+3htD0CDD7wE+rJPqb4/vHi+6DYe1SYDg7ksKAwRSvwirco44rudD5ShBiFeoQ1l1PQR5Rr06IdpkW5KbFJ/sVxlG4d/KshO4xLEZymv45QJx6mzYGq84NvK64uoOAHwoXyUZ5BZGR2SFZjagdnoCiNODXexwjl1YB5BKdvnxCCy0wtnUAbUNH5uD6eiuDXri+qOC6YA9yzz/p2DvPSTxu+oNXxrPt2FCx/4CXaMiANgwr1R+YlvtrE1ev01ICFVOTG0HHPMoucXOTH12L6iHLV5NRi+bJk5s5lKunF+XoOB3L2jq4emqpYo666YFbr+yAa2HL3R3yStWz0UWzg475NA8miu2If0HnfUIcJzhTv24cGSdaXml9zSNE4Y/o4xWoQwli1wIg58H9RkdVa7WHE4ueqp1oqEdixx1+zY4eBMmtrg0qHVfYsr2gktERxL1BB6SioIwcwIyG76PHrYcGD5yCsRo5cXLQIYhiwlj2LUdKfbLddJgRcS46PneyE7mqH/t7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(7696005)(66899024)(6666004)(83380400001)(356005)(82740400003)(81166007)(86362001)(36860700001)(47076005)(36756003)(2616005)(426003)(336012)(40480700001)(26005)(16526019)(6916009)(316002)(41300700001)(4326008)(54906003)(2906002)(70206006)(8936002)(70586007)(30864003)(8676002)(5660300002)(966005)(478600001)(42413004)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 19:25:42.4536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905c4ff9-5023-4d3e-8643-08dbb2fce3be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Add support for AMD AE4DMA controller. It performs high-bandwidth
memory to memory and IO copy operation. Device commands are managed
via a circular queue of 'descriptors', each of which specifies source
and destination addresses for copying a single buffer of data.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 MAINTAINERS                     |   6 +
 drivers/dma/Kconfig             |   2 +
 drivers/dma/Makefile            |   1 +
 drivers/dma/ae4dma/Kconfig      |  11 ++
 drivers/dma/ae4dma/Makefile     |  10 ++
 drivers/dma/ae4dma/ae4dma-dev.c | 320 +++++++++++++++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma-pci.c | 247 +++++++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma.h     | 338 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 935 insertions(+)
 create mode 100644 drivers/dma/ae4dma/Kconfig
 create mode 100644 drivers/dma/ae4dma/Makefile
 create mode 100644 drivers/dma/ae4dma/ae4dma-dev.c
 create mode 100644 drivers/dma/ae4dma/ae4dma-pci.c
 create mode 100644 drivers/dma/ae4dma/ae4dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d590ce3..fdcc6d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -891,6 +891,12 @@ Q:	https://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/efa/
 F:	include/uapi/rdma/efa-abi.h
 
+AMD AE4DMA DRIVER
+M:	Sanjay R Mehta <sanju.mehta@amd.com>
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	drivers/dma/ae4dma/
+
 AMD CDX BUS DRIVER
 M:	Nipun Gupta <nipun.gupta@amd.com>
 M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 08fdd0e..b26dbfb 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -777,6 +777,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
 
 source "drivers/dma/lgm/Kconfig"
 
+source "drivers/dma/ae4dma/Kconfig"
+
 # clients
 comment "DMA Clients"
 	depends on DMA_ENGINE
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a4fd1ce..513d87f 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
 obj-$(CONFIG_INTEL_LDMA) += lgm/
+obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
 
 obj-y += mediatek/
 obj-y += qcom/
diff --git a/drivers/dma/ae4dma/Kconfig b/drivers/dma/ae4dma/Kconfig
new file mode 100644
index 0000000..1cda9de
--- /dev/null
+++ b/drivers/dma/ae4dma/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AMD_AE4DMA
+	tristate  "AMD AE4DMA Engine"
+	depends on X86_64 && PCI
+	help
+	  Enabling this option provides support for the AMD AE4DMA controller,
+	  which offers DMA capabilities for high-bandwidth memory-to-memory and
+	  I/O copy operations. The controller utilizes a queue-based descriptor
+	  management system for efficient DMA transfers. It is specifically
+	  designed to be used in conjunction with AMD Non-Transparent Bridge devices
+	  and is not intended for general-purpose peripheral DMA functionality.
diff --git a/drivers/dma/ae4dma/Makefile b/drivers/dma/ae4dma/Makefile
new file mode 100644
index 0000000..db9cab1
--- /dev/null
+++ b/drivers/dma/ae4dma/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AMD AE4DMA driver
+#
+
+obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
+
+ae4dma-objs := ae4dma-dev.o
+
+ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
diff --git a/drivers/dma/ae4dma/ae4dma-dev.c b/drivers/dma/ae4dma/ae4dma-dev.c
new file mode 100644
index 0000000..a3c50a2
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma-dev.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD AE4DMA device driver
+ * -- Based on the PTDMA driver
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/dma-mapping.h>
+#include <linux/debugfs.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+
+#include "ae4dma.h"
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+
+static unsigned int max_hw_q = 1;
+module_param(max_hw_q, uint, 0444);
+MODULE_PARM_DESC(max_hw_q, "Max queues per engine (any non-zero value less than or equal to 16, default: 1)");
+
+/* Human-readable error strings */
+static char *ae4_error_codes[] = {
+	"",
+	"ERR 01: INVALID HEADER DW0",
+	"ERR 02: INVALID STATUS",
+	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
+	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
+	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
+	"ERR 06: INVALID ALIGNMENT",
+	"ERR 07: INVALID DESCRIPTOR",
+};
+
+static void ae4_log_error(struct ae4_device *d, int e)
+{
+	if (e <= 7)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
+	else if (e > 7 && e <= 15)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
+	else if (e > 15 && e <= 31)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
+	else if (e > 31 && e <= 63)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
+	else if (e > 63 && e <= 127)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
+	else if (e > 127 && e <= 255)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
+}
+
+void ae4_start_queue(struct ae4_cmd_queue *cmd_q)
+{
+	/* Turn on the run bit */
+	iowrite32(cmd_q->qcontrol | CMD_Q_RUN, cmd_q->reg_control);
+}
+
+void ae4_stop_queue(struct ae4_cmd_queue *cmd_q)
+{
+	/* Turn off the run bit */
+	iowrite32(cmd_q->qcontrol & ~CMD_Q_RUN, cmd_q->reg_control);
+}
+
+static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct ae4_cmd_queue *cmd_q)
+{
+	bool soc = FIELD_GET(DWORD0_SOC, desc->dw0);
+	u8 *q_desc = (u8 *)&cmd_q->qbase[0];
+	u32 tail_wi;
+
+	cmd_q->int_rcvd = 0;
+
+	if (soc) {
+		desc->dw0 |= FIELD_PREP(DWORD0_IOC, desc->dw0);
+		desc->dw0 &= ~DWORD0_SOC;
+	}
+	mutex_lock(&cmd_q->q_mutex);
+
+	/* Write Index of circular queue */
+	tail_wi =  ioread32(cmd_q->reg_control + 0x10);
+	q_desc += (tail_wi * 32);
+
+	/* Copy 32-byte command descriptor to hw queue. */
+	memcpy(q_desc, desc, 32);
+	cmd_q->qidx = (cmd_q->qidx + 1) % CMD_Q_LEN; // Increment q_desc id.
+
+	/* The data used by this command must be flushed to memory */
+	wmb();
+
+	/* Write the new tail_wi address back to the queue register */
+	tail_wi = (tail_wi + 1) % CMD_Q_LEN;
+	iowrite32(tail_wi, cmd_q->reg_control + 0x10);
+
+	mutex_unlock(&cmd_q->q_mutex);
+
+	return 0;
+}
+
+int ae4_core_perform_passthru(struct ae4_cmd_queue *cmd_q, struct ae4_passthru_engine *ae4_engine)
+{
+	struct ae4dma_desc desc;
+	struct ae4_device *ae4 = cmd_q->ae4;
+
+	cmd_q->cmd_error = 0;
+	memset(&desc, 0, sizeof(desc));
+	desc.dw0 = CMD_DESC_DW0_VAL;
+	desc.dw1.status = 0;
+	desc.dw1.err_code = 0;
+	desc.dw1.desc_id = 0;
+	desc.length = ae4_engine->src_len;
+	desc.src_lo = upper_32_bits(ae4_engine->src_dma);
+	desc.src_hi = lower_32_bits(ae4_engine->src_dma);
+	desc.dst_lo = upper_32_bits(ae4_engine->dst_dma);
+	desc.dst_hi = lower_32_bits(ae4_engine->dst_dma);
+
+	if (cmd_q->int_en)
+		ae4_core_enable_queue_interrupts(ae4, cmd_q);
+	else
+		ae4_core_disable_queue_interrupts(ae4, cmd_q);
+
+	return ae4_core_execute_cmd(&desc, cmd_q);
+}
+
+static void ae4_do_cmd_complete(struct tasklet_struct *t)
+{
+	struct ae4_cmd_queue *cmd_q = from_tasklet(cmd_q, t, irq_tasklet);
+	unsigned long flags;
+	struct ae4_cmd *cmd;
+
+	spin_lock_irqsave(&cmd_q->cmd_lock, flags);
+	cmd = list_first_entry(&cmd_q->cmd, struct ae4_cmd, entry);
+	list_del(&cmd->entry);
+	spin_unlock_irqrestore(&cmd_q->cmd_lock, flags);
+
+	cmd->ae4_cmd_callback(cmd->data, cmd->ret);
+}
+
+void ae4_check_status_trans(struct ae4_device *ae4, struct ae4_cmd_queue *cmd_q)
+{
+	u8 status;
+	int head = ioread32(cmd_q->reg_control + 0x0C);
+	struct ae4dma_desc *desc;
+
+	head = (head - 1) & (CMD_Q_LEN - 1);
+	desc = &cmd_q->qbase[head];
+
+	status = desc->dw1.status;
+	if (status) {
+		cmd_q->int_status = status;
+		if (status != 0x3) {
+			/* On error, only save the first error value */
+			cmd_q->cmd_error = desc->dw1.err_code;
+			if (cmd_q->cmd_error) {
+				/*
+				 * Log the error and flush the queue by
+				 * moving the head pointer
+				 */
+				ae4_log_error(cmd_q->ae4, cmd_q->cmd_error);
+			}
+		}
+	}
+}
+
+static irqreturn_t ae4_core_irq_handler(int irq, void *data)
+{
+	struct ae4_cmd_queue *cmd_q = data;
+	struct ae4_device *ae4 = cmd_q->ae4;
+	u32 status = ioread32(cmd_q->reg_control + 0x4);
+	u8 q_intr_type = (status >> 24) & 0xf;
+
+	if (q_intr_type ==  0x4)
+		dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "queue desc error", q_intr_type);
+	else if (q_intr_type ==  0x2)
+		dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "queue stopped", q_intr_type);
+	else if (q_intr_type ==  0x1)
+		dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "queue empty", q_intr_type);
+	else
+		dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "unknown error", q_intr_type);
+
+	ae4_check_status_trans(ae4, cmd_q);
+
+	tasklet_schedule(&cmd_q->irq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+int ae4_core_init(struct ae4_device *ae4)
+{
+	char dma_pool_name[MAX_DMAPOOL_NAME_LEN];
+	struct ae4_cmd_queue *cmd_q;
+	u32 dma_addr_lo, dma_addr_hi;
+	struct device *dev = ae4->dev;
+	struct dma_pool *dma_pool;
+	unsigned int i;
+	int ret;
+	u32 q_per_eng = max_hw_q;
+
+	/* Update the device registers with queue information. */
+	iowrite32(q_per_eng, ae4->io_regs);
+
+	q_per_eng = ioread32(ae4->io_regs);
+
+	for (i = 0; i < q_per_eng; i++) {
+		/* Allocate a dma pool for the queue */
+		snprintf(dma_pool_name, sizeof(dma_pool_name), "%s_q%d", dev_name(ae4->dev), i);
+		dma_pool = dma_pool_create(dma_pool_name, dev,
+					   AE4_DMAPOOL_MAX_SIZE,
+					   AE4_DMAPOOL_ALIGN, 0);
+		if (!dma_pool)
+			return -ENOMEM;
+
+		/* ae4dma core initialisation */
+		cmd_q = &ae4->cmd_q[i];
+		cmd_q->id = ae4->cmd_q_count;
+		ae4->cmd_q_count++;
+		cmd_q->ae4 = ae4;
+		cmd_q->dma_pool = dma_pool;
+		mutex_init(&cmd_q->q_mutex);
+		spin_lock_init(&cmd_q->q_lock);
+
+		/* Preset some register values (Q size is 32byte (0x20)) */
+		cmd_q->reg_control = ae4->io_regs + ((i + 1) * 0x20);
+
+		/* Page alignment satisfies our needs for N <= 128 */
+		cmd_q->qsize = Q_SIZE(Q_DESC_SIZE);
+		cmd_q->qbase = dma_alloc_coherent(dev, cmd_q->qsize, &cmd_q->qbase_dma, GFP_KERNEL);
+
+		if (!cmd_q->qbase) {
+			ret = -ENOMEM;
+			goto e_destroy_pool;
+		}
+
+		cmd_q->qidx = 0;
+		cmd_q->q_space_available = 0;
+
+		init_waitqueue_head(&cmd_q->int_queue);
+		init_waitqueue_head(&cmd_q->q_space);
+
+		dev_dbg(dev, "queue #%u available\n", i);
+	}
+
+	if (ae4->cmd_q_count == 0) {
+		dev_notice(dev, "no command queues available\n");
+		ret = -EIO;
+		goto e_destroy_pool;
+	}
+	for (i = 0; i < ae4->cmd_q_count; i++) {
+		cmd_q = &ae4->cmd_q[i];
+		cmd_q->qcontrol = 0;
+		ret = request_irq(ae4->ae4_irq[i], ae4_core_irq_handler, 0,
+				  dev_name(ae4->dev), cmd_q);
+		if (ret) {
+			dev_err(dev, "unable to allocate an IRQ\n");
+			goto e_free_dma;
+		}
+
+		/* Update the device registers with cnd queue length (Max Index reg). */
+		iowrite32(CMD_Q_LEN, cmd_q->reg_control + 0x08);
+		cmd_q->qdma_tail = cmd_q->qbase_dma;
+		dma_addr_lo = lower_32_bits(cmd_q->qdma_tail);
+		iowrite32((u32)dma_addr_lo, cmd_q->reg_control + 0x18);
+		dma_addr_lo = ioread32(cmd_q->reg_control + 0x18);
+		dma_addr_hi = upper_32_bits(cmd_q->qdma_tail);
+		iowrite32((u32)dma_addr_hi, cmd_q->reg_control + 0x1C);
+		dma_addr_hi = ioread32(cmd_q->reg_control + 0x1C);
+		ae4_core_enable_queue_interrupts(ae4, cmd_q);
+		INIT_LIST_HEAD(&cmd_q->cmd);
+
+		/* Initialize the ISR tasklet */
+		tasklet_setup(&cmd_q->irq_tasklet, ae4_do_cmd_complete);
+	}
+
+	return 0;
+
+e_free_dma:
+	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase, cmd_q->qbase_dma);
+
+e_destroy_pool:
+	for (i = 0; i < ae4->cmd_q_count; i++)
+		dma_pool_destroy(ae4->cmd_q[i].dma_pool);
+
+	return ret;
+}
+
+void ae4_core_destroy(struct ae4_device *ae4)
+{
+	struct device *dev = ae4->dev;
+	struct ae4_cmd_queue *cmd_q;
+	struct ae4_cmd *cmd;
+	unsigned int i;
+
+	for (i = 0; i < ae4->cmd_q_count; i++) {
+		cmd_q = &ae4->cmd_q[i];
+
+		wake_up_all(&cmd_q->q_space);
+		wake_up_all(&cmd_q->int_queue);
+
+		/* Disable and clear interrupts */
+		ae4_core_disable_queue_interrupts(ae4, cmd_q);
+
+		/* Turn off the run bit */
+		ae4_stop_queue(cmd_q);
+
+		free_irq(ae4->ae4_irq[i], cmd_q);
+
+		dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase,
+				  cmd_q->qbase_dma);
+	}
+
+	/* Flush the cmd queue */
+	while (!list_empty(&ae4->cmd)) {
+		/* Invoke the callback directly with an error code */
+		cmd = list_first_entry(&ae4->cmd, struct ae4_cmd, entry);
+		list_del(&cmd->entry);
+		cmd->ae4_cmd_callback(cmd->data, -ENODEV);
+	}
+}
diff --git a/drivers/dma/ae4dma/ae4dma-pci.c b/drivers/dma/ae4dma/ae4dma-pci.c
new file mode 100644
index 0000000..a77fbb5
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma-pci.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD AE4DMA device driver
+ * -- Based on the PTDMA driver
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
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
+#include "ae4dma.h"
+
+struct ae4_msix {
+	int msix_count;
+	struct msix_entry msix_entry[MAX_HW_QUEUES];
+};
+
+/*
+ * ae4_alloc_struct - allocate and initialize the ae4_device struct
+ *
+ * @dev: device struct of the AE4DMA
+ */
+static struct ae4_device *ae4_alloc_struct(struct device *dev)
+{
+	struct ae4_device *ae4;
+
+	ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
+
+	if (!ae4)
+		return NULL;
+	ae4->dev = dev;
+
+	INIT_LIST_HEAD(&ae4->cmd);
+
+	return ae4;
+}
+
+static int ae4_get_msix_irqs(struct ae4_device *ae4)
+{
+	struct ae4_msix *ae4_msix = ae4->ae4_msix;
+	struct device *dev = ae4->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int v, i, ret;
+
+	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
+		ae4_msix->msix_entry[v].entry = v;
+
+	ret = pci_enable_msix_range(pdev, ae4_msix->msix_entry, 1, v);
+	if (ret < 0)
+		return ret;
+
+	ae4_msix->msix_count = ret;
+
+	for (i = 0; i < MAX_HW_QUEUES; i++)
+		ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
+
+	return 0;
+}
+
+static int ae4_get_msi_irq(struct ae4_device *ae4)
+{
+	struct device *dev = ae4->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret, i;
+
+	ret = pci_enable_msi(pdev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < MAX_HW_QUEUES; i++)
+		ae4->ae4_irq[i] = pdev->irq;
+
+	return 0;
+}
+
+static int ae4_get_irqs(struct ae4_device *ae4)
+{
+	struct device *dev = ae4->dev;
+	int ret;
+
+	ret = ae4_get_msix_irqs(ae4);
+	if (!ret)
+		return 0;
+
+	/* Couldn't get MSI-X vectors, try MSI */
+	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
+	ret = ae4_get_msi_irq(ae4);
+	if (!ret)
+		return 0;
+
+	/* Couldn't get MSI interrupt */
+	dev_err(dev, "could not enable MSI (%d)\n", ret);
+
+	return ret;
+}
+
+static void ae4_free_irqs(struct ae4_device *ae4)
+{
+	struct ae4_msix *ae4_msix = ae4->ae4_msix;
+	struct device *dev = ae4->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	unsigned int i;
+
+	if (ae4_msix->msix_count)
+		pci_disable_msix(pdev);
+	else if (ae4->ae4_irq)
+		pci_disable_msi(pdev);
+
+	for (i = 0; i < MAX_HW_QUEUES; i++)
+		ae4->ae4_irq[i] = 0;
+}
+
+static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct ae4_device *ae4;
+	struct ae4_msix *ae4_msix;
+	struct device *dev = &pdev->dev;
+	void __iomem * const *iomap_table;
+	int bar_mask;
+	int ret = -ENOMEM;
+
+	ae4 = ae4_alloc_struct(dev);
+	if (!ae4)
+		goto e_err;
+
+	ae4_msix = devm_kzalloc(dev, sizeof(*ae4_msix), GFP_KERNEL);
+	if (!ae4_msix)
+		goto e_err;
+
+	ae4->ae4_msix = ae4_msix;
+	ae4->dev_vdata = (struct ae4_dev_vdata *)id->driver_data;
+	if (!ae4->dev_vdata) {
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
+	ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
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
+	ae4->io_regs = iomap_table[ae4->dev_vdata->bar];
+	if (!ae4->io_regs) {
+		dev_err(dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto e_err;
+	}
+
+	ret = ae4_get_irqs(ae4);
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
+	dev_set_drvdata(dev, ae4);
+
+	if (ae4->dev_vdata)
+		ret = ae4_core_init(ae4);
+
+	if (ret)
+		goto e_err;
+
+	return 0;
+
+e_err:
+	dev_err(dev, "initialization failed ret = %d\n", ret);
+
+	return ret;
+}
+
+static void ae4_pci_remove(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ae4_device *ae4 = dev_get_drvdata(dev);
+
+	if (!ae4)
+		return;
+
+	if (ae4->dev_vdata)
+		ae4_core_destroy(ae4);
+
+	ae4_free_irqs(ae4);
+}
+
+static const struct ae4_dev_vdata dev_vdata[] = {
+	{
+		.bar = 0,
+	},
+};
+
+static const struct pci_device_id ae4_pci_table[] = {
+	{ PCI_VDEVICE(AMD, 0x14C8), (kernel_ulong_t)&dev_vdata[0] },
+	{ PCI_VDEVICE(AMD, 0x14DC), (kernel_ulong_t)&dev_vdata[0] },
+	/* Last entry must be zero */
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, ae4_pci_table);
+
+static struct pci_driver ae4_pci_driver = {
+	.name = "ae4dma",
+	.id_table = ae4_pci_table,
+	.probe = ae4_pci_probe,
+	.remove = ae4_pci_remove,
+};
+
+module_pci_driver(ae4_pci_driver);
+
+MODULE_AUTHOR("Sanjay R Mehta <sanju.mehta@amd.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD AE4DMA driver");
diff --git a/drivers/dma/ae4dma/ae4dma.h b/drivers/dma/ae4dma/ae4dma.h
new file mode 100644
index 0000000..0ae46ee
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma.h
@@ -0,0 +1,338 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD AE4DMA device driver
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ */
+
+#ifndef __AE4_DEV_H__
+#define __AE4_DEV_H__
+
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/wait.h>
+#include <linux/dmapool.h>
+
+#define MAX_AE4_NAME_LEN			16
+#define MAX_DMAPOOL_NAME_LEN		32
+
+#define MAX_HW_QUEUES			16
+#define MAX_CMD_QLEN			32
+
+#define AE4_ENGINE_PASSTHRU		5
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
+#define CMD_AE4_VERSION			0x10
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
+#define CMD_DESC_DW0_VAL		0x000002
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
+#define Q_DESC_SIZE			sizeof(struct ae4dma_desc)
+#define Q_SIZE(n)			(CMD_Q_LEN * (n))
+
+#define INT_DESC_VALIDATED		BIT(1)
+#define INT_DESC_PROCESSED			BIT(2)
+#define INT_COMPLETION			BIT(3)
+#define INT_ERROR			BIT(4)
+
+#define SUPPORTED_INTERRUPTS		(INT_COMPLETION | INT_ERROR)
+
+/****** Local Storage Block ******/
+#define LSB_START			0
+#define LSB_END				127
+#define LSB_COUNT			(LSB_END - LSB_START + 1)
+
+#define AE4_DMAPOOL_MAX_SIZE		64
+#define AE4_DMAPOOL_ALIGN		BIT(5)
+
+#define AE4_PASSTHRU_BLOCKSIZE		512
+
+struct ae4_device;
+
+struct ae4_tasklet_data {
+	struct completion completion;
+	struct ae4_cmd *cmd;
+};
+
+/*
+ * struct ae4_passthru_engine - pass-through operation
+ *   without performing DMA mapping
+ * @mask: mask to be applied to data
+ * @mask_len: length in bytes of mask
+ * @src_dma: data to be used for this operation
+ * @dst_dma: data produced by this operation
+ * @src_len: length in bytes of data used for this operation
+ *
+ * Variables required to be set when calling ae4_enqueue_cmd():
+ *   - bit_mod, byte_swap, src, dst, src_len
+ *   - mask, mask_len if bit_mod is not AE4_PASSTHRU_BITWISE_NOOP
+ */
+struct ae4_passthru_engine {
+	dma_addr_t mask;
+	u32 mask_len;		/* In bytes */
+
+	dma_addr_t src_dma, dst_dma;
+	u64 src_len;		/* In bytes */
+};
+
+/*
+ * struct ae4_cmd - AE4DMA operation request
+ * @entry: list element
+ * @work: work element used for callbacks
+ * @ae4: AE4 device to be run on
+ * @ret: operation return code
+ * @flags: cmd processing flags
+ * @engine: AE4DMA operation to perform (passthru)
+ * @engine_error: AE4 engine return code
+ * @passthru: engine specific structures, refer to specific engine struct below
+ * @callback: operation completion callback function
+ * @data: parameter value to be supplied to the callback function
+ *
+ * Variables required to be set when calling ae4_enqueue_cmd():
+ *   - engine, callback
+ *   - See the operation structures below for what is required for each
+ *     operation.
+ */
+struct ae4_cmd {
+	struct list_head entry;
+	struct work_struct work;
+	struct ae4_device *ae4;
+	int ret;
+	u32 engine;
+	u32 engine_error;
+	struct ae4_passthru_engine passthru;
+	/* Completion callback support */
+	void (*ae4_cmd_callback)(void *data, int err);
+	void *data;
+	u8 qid;
+};
+
+struct ae4_cmd_queue {
+	struct ae4_device *ae4;
+
+	/* Queue identifier */
+	u32 id;
+
+	/* Queue dma pool */
+	struct dma_pool *dma_pool;
+
+	/* Queue base address (not neccessarily aligned)*/
+	struct ae4dma_desc *qbase;
+
+	/* Aligned queue start address (per requirement) */
+	struct mutex q_mutex ____cacheline_aligned;
+	spinlock_t q_lock ____cacheline_aligned;
+	unsigned long qidx;
+
+	unsigned int qsize;
+	dma_addr_t qbase_dma;
+	dma_addr_t qdma_tail;
+
+	unsigned int active;
+	unsigned int suspended;
+
+	/* Interrupt flag */
+	bool int_en;
+
+	/* Register addresses for queue */
+	void __iomem *reg_control;
+	u32 qcontrol; /* Cached control register */
+
+	/* Status values from job */
+	u32 int_status;
+	u32 q_status;
+	u32 q_int_status;
+	u32 cmd_error;
+
+	/* Interrupt wait queue */
+	wait_queue_head_t int_queue;
+	unsigned int int_rcvd;
+
+	wait_queue_head_t q_space;
+	unsigned int q_space_available;
+
+	struct ae4_tasklet_data tdata;
+	struct tasklet_struct irq_tasklet;
+
+	struct list_head cmd;
+	spinlock_t cmd_lock ____cacheline_aligned;
+} ____cacheline_aligned;
+
+struct ae4_device {
+	struct list_head entry;
+
+	unsigned int ord;
+	char name[MAX_AE4_NAME_LEN];
+
+	struct device *dev;
+
+	/* Bus specific device information */
+	struct ae4_msix *ae4_msix;
+
+	struct ae4_dev_vdata *dev_vdata;
+
+	unsigned int ae4_irq[MAX_HW_QUEUES];
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
+	 * AE4DMA that are available for processing cmds
+	 */
+	struct ae4_cmd_queue cmd_q[MAX_HW_QUEUES];
+	unsigned int cmd_q_count;
+
+	wait_queue_head_t lsb_queue;
+};
+
+/*
+ * descriptor for AE4DMA commands
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
+#define DWORD0_SOM	BIT(3)
+#define DWORD0_EOM	BIT(4)
+#define DWORD0_DMT	GENMASK(5, 4)
+#define DWORD0_SMT	GENMASK(7, 6)
+
+#define DWORD0_DMT_MEM	0x0
+#define DWORD0_DMT_IO	BIT(4)
+#define DWORD0_SMT_MEM	0x0
+#define DWORD0_SMT_IO	BIT(6)
+
+struct dword1 {
+	u8	status;
+	u8	err_code;
+	u16	desc_id;
+};
+
+struct ae4dma_desc {
+	u32 dw0;
+	struct dword1 dw1;
+	u32 length;
+	__le32 rsvd;
+	u32 src_hi;
+	u32 src_lo;
+	u32 dst_hi;
+	u32 dst_lo;
+};
+
+/* Structure to hold AE4 device data */
+struct ae4_dev_vdata {
+	const unsigned int bar;
+};
+
+int ae4_core_init(struct ae4_device *ae4);
+void ae4_core_destroy(struct ae4_device *ae4);
+
+int ae4_core_perform_passthru(struct ae4_cmd_queue *cmd_q,
+			      struct ae4_passthru_engine *ae4_engine);
+
+void ae4_check_status_trans(struct ae4_device *ae4, struct ae4_cmd_queue *cmd_q);
+void ae4_start_queue(struct ae4_cmd_queue *cmd_q);
+void ae4_stop_queue(struct ae4_cmd_queue *cmd_q);
+
+static inline void ae4_core_disable_queue_interrupts(struct ae4_device *ae4,
+						     struct ae4_cmd_queue *cmd_q)
+{
+	iowrite32(0, cmd_q->reg_control);
+}
+
+static inline void ae4_core_enable_queue_interrupts(struct ae4_device *ae4,
+						    struct ae4_cmd_queue *cmd_q)
+{
+	iowrite32(0X7, cmd_q->reg_control);
+}
+
+static inline bool ae4_core_queue_full(struct ae4_device *ae4, struct ae4_cmd_queue *cmd_q)
+{
+	u32 q_sts = ioread32(cmd_q->reg_control + 0x4) & 0x06;
+
+	u32 rear_ri = ioread32(cmd_q->reg_control + 0x0C);
+	u32 front_wi  = ioread32(cmd_q->reg_control + 0x10);
+
+	q_sts >>= 1;
+
+	if (((MAX_CMD_QLEN + front_wi - rear_ri) % MAX_CMD_QLEN)  >= (MAX_CMD_QLEN - 1))
+		return true;
+
+	return false;
+}
+
+#endif
-- 
2.7.4

