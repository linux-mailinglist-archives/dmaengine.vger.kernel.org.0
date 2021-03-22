Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086D1343817
	for <lists+dmaengine@lfdr.de>; Mon, 22 Mar 2021 06:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCVFAe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 01:00:34 -0400
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:51476
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229764AbhCVFAE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 01:00:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaR1XuKaZOW2JtAxAYNNP/+dCyKG/KUR/mLjxQif78Ze4h2fPZpe04MCx9G6yek6MLmJb3ea0v1N8VvLbQpIjPDIudeXi/oBflCPbrbPraazeQfJKnwUKWOmfZOLPS/Hg899g+sV8qlShmvbJtgrQhW0rlQnUgGQZmX3wne0LRTfyRLoV+ddiB5NEjlktfFOIUljMoc44q+Sx/A4dpz67CoiAqoWoMWeRS3LiCrOxgTuTs+3nYF4hCJmF0q/AlWsPxXDhgjbEPCIvFvHqr089o+roCej7PZ/l4jE86hth495vzJ1nBpBvgRFFzYPDx7YC/2cmjyrNg3EpoKFP5Tyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aY6T2zFhhV8BIfxNBggWRnL5HuJainfLvaMcsEOvS8=;
 b=mOE2+7XUuPbVmRe0AysEan/E1d452TdBaGNJr1isNsElvu8IjoBbrYKQXic6aSn2SkIzpJNiQWFAo0BMJtwmLPk946+/vfeajIudaR8ScPYYSjCNoE4cv11v7pKO7ihnbillTmnMx8LIjBJzBzxuiRo0p/PC9GDUyz3/ebLw7HHfZ80CHrD8TUsvvSvuTbNHCJJhsBn/HZUP2XJUsBRtwQNqLJpY3BjkAGU/5CJHF355MrdhTtAhkHY5+z74CQfXaRWOh2srly4wkkcm7+zpPbygXzwIK11cAXpnF1/qpZyE1vXhhUG0MRfR99ZGBAqngastcB7cRbUvJx40JnM1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aY6T2zFhhV8BIfxNBggWRnL5HuJainfLvaMcsEOvS8=;
 b=fyhJNL5KL4cPtD6kRoGxy0dqw5B7JcVZKB4pti8QUF9389XvUvuq8aqCr5fMeUTpull4mCIdI9eEQ7H2DLqTzzZJjoa4S07tAKyvQFrN/hBPxwSep+5MnEE7TfA7O7ltTNMsQxoSUSIbKkAzp6ltHwQJTolqblGTdma3MhBX20o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com (10.172.121.10) by
 CY4PR1201MB0040.namprd12.prod.outlook.com (10.172.77.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Mon, 22 Mar 2021 05:00:00 +0000
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6]) by CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6%4]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 05:00:00 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v8 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
Date:   Sun, 21 Mar 2021 23:59:30 -0500
Message-Id: <1616389172-6825-2-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616389172-6825-1-git-send-email-Sanju.Mehta@amd.com>
References: <1616389172-6825-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 04:59:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8845e03-9882-4192-8843-08d8ecef585a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0040033C417DAF3F621ECC66E5659@CY4PR1201MB0040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvF/rG+Ub8TZYCu/K/GI/3BDavicSHZShw1uWMhshkz6hUAWvdIzBy3sjia/wpsdz63Kzir9wTvH8k10HF3F0A3U+hSC5HTDE6PdopU//GxPRwxsn0Xg+u4xjphkVQKC/yEj+BGlMhXFJBo/9AOH4wDpzScacUjdHcdz14lZs2j7bnEiwCpAvUtjWOdo+YWrAjcI29v4KgKmXi8KzrFg/1jkFc05AOGH+B0RWPyRYByCNDDpxLveD/uosZOCJsf423q5REh1x+Ibf2EEIfkIhMIN/fxZ7Ul0RaUmziVLrKw45vGxPvh2aNFZcriJd87mET4IAg8ZrtuRGakYZrKjYgZVsPo0uFsuYeW2uRP7kfmtP81AtvxWsh713+jGTzLJU6JFKjId5JBZdxQ4+R3swtqbzJyA2DcynVkW3Rvu0ntV3Aj1VV4/olCvaElfaNQ33q0A7JTcyCnih9D2/7WzZYECzL3v/ALg+4awbgfZUnPEsmJ1+vB2PoRdpLmKp5nRkIiyOYD29NotQ/gAlQpvSY6hAzmfcXx7WX1bHRWh5VMf7HghyN/gQlMuwA6O9OE3GPwgWxYi06diGvGMQYcNLXT9HMYxrThBoiBuNCSaEAulsJRsbb/Nk+SJj8Le6bDTSpdxtQ6OHFdONqTBxCRZCzQuy68wGnle2vfKqp0MXE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB2549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(316002)(186003)(7696005)(26005)(6666004)(4326008)(2616005)(956004)(2906002)(52116002)(86362001)(6916009)(478600001)(36756003)(6486002)(38100700001)(66946007)(16526019)(5660300002)(30864003)(8676002)(66556008)(8936002)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qIyDNemZ7MWTt7ql19wsIbdhZgfeIkkFbor57t90cSPAFR5zbHseTODVwWut?=
 =?us-ascii?Q?cV3woYClwzZakXOc2iy2LXDHUcxolttDr26FNBx4OB05hHxIrpfeO62KylvG?=
 =?us-ascii?Q?upyJ+sGopFH4fcqwoPs1DKtv6AfrQ0f/l51okg5W2HTiu5brgwEsDaCzVORO?=
 =?us-ascii?Q?3tWA38q6sXdvh87I/0xBzG2ZO56Vvdf3f7Vc8Eij+8yZTxX0eAxqguAtM/Br?=
 =?us-ascii?Q?yKmfVUi7EIFvV6oWSKGzWWg666Mmssn436Dr5F9W82cr6rBxR7BdIPFoLbtz?=
 =?us-ascii?Q?cDGm/1CQXqvKWrpO0+gQuEORoXocUWLSW5bODbKBaN5MEhb7kNBx0WIxjFT6?=
 =?us-ascii?Q?c4kucFrSSlJ1bc4Bg4w+NXvEpfMvVc5pwLI9wPqva56bHI3B18K11IXBRAhm?=
 =?us-ascii?Q?V/apPGAIJYAByDoPqMuAU4/PrXSKoaIXvvnuGWRmwSiWgDvhEl+X7Ze+/A8v?=
 =?us-ascii?Q?d5EKu/7m+V/z2xh5Hz80BUlHUEIeZCX/N6+YomIXYb8sAS5IfaYtxb6qsest?=
 =?us-ascii?Q?hxlJoXIC26g6kgWWqW6pmDeItbILEjH+HzHa0fieKBuXHaTnBiWDJG1+/hTQ?=
 =?us-ascii?Q?KSH661zYBxgwW1XcUm9utveDmbHtBoncTPDyjzRPVwbU019NSXUfLFpPk4b9?=
 =?us-ascii?Q?1x/KOxMUXB5zbitp6gXuof54eo6SSl54Go4JV/9/n6vbM8G1Q0copOixitl3?=
 =?us-ascii?Q?AGkTYVKdUXCU6xNmQ74hXYUeX4krg0riHIhqswXKNddItE4YMSb6Ew+DmnuH?=
 =?us-ascii?Q?/bvYM0HHwVgGefyNO7GPBM0j0hVFmVMIdue6fv/HYeiOAu5RWRgZMjedIw08?=
 =?us-ascii?Q?5+TT7dWbGYDPu6vPj9xKy0Mz77984N3VNewuvqytsW7CS5ka2Pel1fIk9y6F?=
 =?us-ascii?Q?/wKQlsjXgZfvIsf2Mrq9YtYh7NmXFDCNz7igOXkh1Vyd1/l6CpJ0UVW8ISpc?=
 =?us-ascii?Q?A1I1XBlJ/mX/JvrynXrElnbAshyoRsjDnSGW2K00lbUFKBq8S8sEQfsl3LAZ?=
 =?us-ascii?Q?OY1HHZBo8NY9u5/MO8xraL1fjwN2zVWK4ArZp0GDYLwfpK+IrnMkVPnZBTUl?=
 =?us-ascii?Q?WYk8kr5oqLOsKW0/PHI2ITuzlE+T+y46R4J5Z5m/57bSfoFFPkIIpg2zS0BW?=
 =?us-ascii?Q?F7Vg2aq72u+1A7w7a3q6VrQnY06jFIr4t7pcfK9vlcRvdq8vyQI5EbBVgc5Y?=
 =?us-ascii?Q?9dHHVRcSLdhnAGsnOeTbDvVljpt0Sge4OJ8ny0eIFy7kv4TRnILPpVCVzQ7x?=
 =?us-ascii?Q?CGgkP9boNYXNCphcUjri58IV/oiY6eKL9okGvMoLJHXxfPDCW2L6SKngO2ye?=
 =?us-ascii?Q?R4DBfKu6jfwSnw3pmnIzIJgo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8845e03-9882-4192-8843-08d8ecef585a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 05:00:00.2959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muXF4r3XANb9iLtxP4Bm/QO8OID9qDZMINCoLCnK5tGUMoTCwMQPZjrZjNXttlyzfeESSXIcXt+FJGdTZSk6Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0040
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
 drivers/dma/ptdma/ptdma-dev.c | 290 +++++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c | 251 ++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h     | 305 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 876 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bfc1b86..9a4c04bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -941,6 +941,12 @@ S:	Supported
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
index d242c76..861492e 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -724,6 +724,8 @@ source "drivers/dma/bestcomm/Kconfig"
 
 source "drivers/dma/mediatek/Kconfig"
 
+source "drivers/dma/ptdma/Kconfig"
+
 source "drivers/dma/qcom/Kconfig"
 
 source "drivers/dma/dw/Kconfig"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 948a8da..30b8f91 100644
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
index 0000000..c4f8c6f
--- /dev/null
+++ b/drivers/dma/ptdma/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AMD_PTDMA
+	tristate  "AMD PassThru DMA Engine"
+	depends on X86_64 && PCI
+	help
+	  Enable support for the AMD PTDMA controller. This controller
+	  provides DMA capabilities to performs high bandwidth memory to
+	  memory and IO copy operation. It performs DMA transfer through
+	  queue based descriptor management. This DMA controller is intended
+	  to use with AMD Non-Transparent Bridge devices and not for general
+	  purpose peripheral DMA.
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
index 0000000..4617550
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
+	u8 *dp = (u8 *)desc;
+	u32 tail;
+
+	if (soc) {
+		desc->dw0 |= FIELD_PREP(DWORD0_IOC, desc->dw0);
+		desc->dw0 &= ~DWORD0_SOC;
+	}
+	mutex_lock(&cmd_q->q_mutex);
+
+	/* Copy 32-byte command descriptor to hw queue. */
+	memcpy(q_desc, dp, 32);
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
+	if (!dma_pool) {
+		dev_err(dev, "unable to allocate dma pool\n");
+		return -ENOMEM;
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
index 0000000..0945c27
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-pci.c
@@ -0,0 +1,251 @@
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
+
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
+	dev_dbg(dev, "PTDMA enabled\n");
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
index 0000000..a89a74ac
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma.h
@@ -0,0 +1,305 @@
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
+#define PT_VSIZE			16
+#define PT_VMASK			((unsigned int)((1 << PT_VSIZE) - 1))
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

