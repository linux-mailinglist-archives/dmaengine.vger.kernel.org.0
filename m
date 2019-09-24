Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E243BC2B7
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 09:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440591AbfIXHdg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 03:33:36 -0400
Received: from mail-eopbgr770048.outbound.protection.outlook.com ([40.107.77.48]:33251
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391051AbfIXHdg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 03:33:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO9PbPs3pF3UzRenxRqpZQSSriN9A8XyWYEJMHvcVYmNSH/NHqow1LCQbjGlFnsAmCHtmbnkGNDlJOmxCQ7X55h/Mvts/WgeKPajViH3VrClYNHk735ahjJy3X4QD4a3ImZ6yWj17JK6aTYUpetMXUdX/kwFpfoodCFbLheYRrtgmnx67EhkjNDDuPSftva1UdfyBC0F07VBgGX3wjTcTwnCbyGCf+/+oB81SCdGwD2yJnWiO80OsFshnlfHyES6rWy6TkwgvheYU5ENPvnhGIhGy5zow9itkLTq7QFyBl7cISwQ3C/9K0TE7clk5QCLnTj1CdoEBWdVg5azfbtCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qWnhg97kC0FpWbGPe276yHpyfe1sKBnVq33Cx27yhA=;
 b=E/FISLg14gwDJMJdIZr/boTat1+GwlyrHSYogk0rQf01KiWp2itG9KC5Eqbh4xxRBTYzzr77jFmrJms32ot1TIeuC4SwexDNrX6ocva5JbfD604R9Qjd+oEcfaEWMAoKOSpPeTJR/1eIwVfF65UtnhnnTsrpXnl+gTzYJUuw7iQnl+LHblDo00k0Tm34pWY0AUqjFH88gkjPdfsy8BIN0tdQMRon8kctkWJhqbifC3vm1kJhSz0dgRP1j63iBKvdPLiVLIvNEU3SaWUQrM41gVDXmiazBJMZ80fc0YmQGbjYWH7nQVkUfSqS5b2rsqHYHrDu/MOg5TXvCldOp5fASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qWnhg97kC0FpWbGPe276yHpyfe1sKBnVq33Cx27yhA=;
 b=0UEtrbeKfksf5FX9avJSwjhpsxwzU1a/wMemi9S6eXFO9V+0JRmVU6gDff/WrH5Alf77nP7o/+2Rn7Dy7LnCwutJiShMEyI/7MnvScCmF2gfbi5cQOPsybECIFyDFLCqzSLA+UCWXW1oZnzg+7f/CvF3GDVUGCC6DlDR5hmlBgg=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3007.namprd12.prod.outlook.com (20.178.244.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:31:35 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:31:35 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Kumar, Rajesh" <Rajesh1.Kumar@amd.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 1/4] dma: Add PTDMA Engine driver support
Thread-Topic: [PATCH 1/4] dma: Add PTDMA Engine driver support
Thread-Index: AQHVcqoYFCdjRu+vbE6D9/1LZkEgHg==
Date:   Tue, 24 Sep 2019 07:31:35 +0000
Message-ID: <1569310272-29153-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::14) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 849d056f-3325-4604-898f-08d740c13a6a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3007;
x-ms-traffictypediagnostic: MN2PR12MB3007:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB300792721B9DB2021A02B7F0E5840@MN2PR12MB3007.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(110136005)(186003)(99286004)(52116002)(7736002)(6506007)(305945005)(50226002)(66476007)(4326008)(478600001)(2501003)(66946007)(66556008)(66446008)(64756008)(86362001)(386003)(2201001)(6436002)(6486002)(71190400001)(71200400001)(54906003)(6512007)(5660300002)(25786009)(6116002)(3846002)(14454004)(36756003)(14444005)(256004)(81156014)(8676002)(486006)(7416002)(8936002)(81166006)(476003)(30864003)(2616005)(66066001)(316002)(26005)(102836004)(2906002)(921003)(1121003)(579004)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3007;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: blVPJCgi29/7xzgn93Eti722sLc1YVHfHZUjjvyAvHfNDnW31JjGSluOSaI4zcEgR5QVF6J+qYE/l3TWq64qwMB1vqnO+D5dj+qbrOZr7d9Qa+ROR/3OgPJgNjD6JbmsUE0Mk6vtDj2mo0y4+RzXlKDImGtT31wEfnIfdv2RLauiUGXRTL/7J/LQbucSqtdsWsEmlhmOAN3SakVJLIdt6GpD+1/C6s16XsnZdGCLNFd71IZ39M3ngO1VPrdaiIq1vZ+y/X8UXHXflEEVCMpC5Y7t/x3Vc8bAxpgYsENLjEgjyqQSnTshw7qIEkFu7ikWbeoAK26t8BrinCc6U9y1vjGXR1udJDx+FXWFp7X2dHDNCYDp4m54/NtwbKvwIkFLoOoCiXh1udYv43DrnU957hCcicGmbvyT1MbFssMkquo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849d056f-3325-4604-898f-08d740c13a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:31:35.5957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcFwcu2S45l6gwTULo5PiXttC4tAg9tFcgj+SpLUMfsyr/uAfUXVs7JR3A6V/1Scv8XcVFicLf93OUsQAhIwRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3007
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This is the driver for the AMD passthrough DMA Engine

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Rajesh Kumar <Rajesh1.Kumar@amd.com>
---
 MAINTAINERS                   |   6 +
 drivers/dma/Kconfig           |   2 +
 drivers/dma/Makefile          |   1 +
 drivers/dma/ptdma/Kconfig     |   7 +
 drivers/dma/ptdma/Makefile    |  11 +
 drivers/dma/ptdma/ptdma-dev.c | 421 +++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-ops.c | 373 +++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c | 244 ++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h     | 501 ++++++++++++++++++++++++++++++++++++++=
++++
 9 files changed, 1566 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-ops.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a400af0..5ddc5d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -876,6 +876,12 @@ S:	Supported
 F:	drivers/net/ethernet/amd/xgbe/
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
=20
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
index 7af874b..a11ecb3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -669,6 +669,8 @@ source "drivers/dma/sh/Kconfig"
=20
 source "drivers/dma/ti/Kconfig"
=20
+source "drivers/dma/ptdma/Kconfig"
+
 # clients
 comment "DMA Clients"
 	depends on DMA_ENGINE
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index f5ce866..08842fb 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_UNIPHIER_MDMAC) +=3D uniphier-mdmac.o
 obj-$(CONFIG_XGENE_DMA) +=3D xgene-dma.o
 obj-$(CONFIG_ZX_DMA) +=3D zx_dma.o
 obj-$(CONFIG_ST_FDMA) +=3D st_fdma.o
+obj-$(CONFIG_AMD_PTDMA) +=3D ptdma/
=20
 obj-y +=3D mediatek/
 obj-y +=3D qcom/
diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
new file mode 100644
index 0000000..a373431
--- /dev/null
+++ b/drivers/dma/ptdma/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AMD_PTDMA
+	tristate  "AMD Passthru DMA Engine"
+	default m
+	depends on X86_64 && PCI
+	help
+	  Provides the support for AMD Passthru DMA engine.
diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/ptdma/Makefile
new file mode 100644
index 0000000..a5b4cef
--- /dev/null
+++ b/drivers/dma/ptdma/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AMD pass-through DMA driver
+#
+
+obj-$(CONFIG_AMD_PTDMA) +=3D ptdma.o
+
+ptdma-objs :=3D ptdma-ops.o \
+	      ptdma-dev.o
+
+ptdma-$(CONFIG_PCI) +=3D ptdma-pci.o
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
new file mode 100644
index 0000000..ce3e85d
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Passthrough DMA device driver
+ *
+ * Copyright (C) 2019 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ *
+ * Based on CCP driver
+ *	Original copyright message:
+ *
+ *  Copyright (C) 2016,2017 Advanced Micro Devices, Inc.
+ *
+ *  Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kthread.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+
+#include "ptdma.h"
+
+/* Union to define the function field (cmd_reg1/dword0) */
+union pt_function {
+	struct {
+		u16 byteswap:2;
+		u16 bitwise:3;
+		u16 reflect:2;
+		u16 rsvd:8;
+	} pt;
+	u16 raw;
+};
+
+#define	PT_BYTESWAP(p)		((p)->pt.byteswap)
+#define	PT_BITWISE(p)		((p)->pt.bitwise)
+
+/* Word 0 */
+#define PT_CMD_DW0(p)		((p)->dw0)
+#define PT_CMD_SOC(p)		(PT_CMD_DW0(p).soc)
+#define PT_CMD_IOC(p)		(PT_CMD_DW0(p).ioc)
+#define PT_CMD_INIT(p)		(PT_CMD_DW0(p).init)
+#define PT_CMD_EOM(p)		(PT_CMD_DW0(p).eom)
+#define PT_CMD_FUNCTION(p)	(PT_CMD_DW0(p).function)
+#define PT_CMD_ENGINE(p)	(PT_CMD_DW0(p).engine)
+#define PT_CMD_PROT(p)		(PT_CMD_DW0(p).prot)
+
+/* Word 1 */
+#define PT_CMD_DW1(p)		((p)->length)
+#define PT_CMD_LEN(p)		(PT_CMD_DW1(p))
+
+/* Word 2 */
+#define PT_CMD_DW2(p)		((p)->src_lo)
+#define PT_CMD_SRC_LO(p)	(PT_CMD_DW2(p))
+
+/* Word 3 */
+#define PT_CMD_DW3(p)		((p)->dw3)
+#define PT_CMD_SRC_MEM(p)	((p)->dw3.src_mem)
+#define PT_CMD_SRC_HI(p)	((p)->dw3.src_hi)
+#define PT_CMD_LSB_ID(p)	((p)->dw3.lsb_cxt_id)
+#define PT_CMD_FIX_SRC(p)	((p)->dw3.fixed)
+
+/* Words 4/5 */
+#define PT_CMD_DST_LO(p)	((p)->dst_lo)
+#define PT_CMD_DW5(p)		((p)->dw5.dst_hi)
+#define PT_CMD_DST_HI(p)	(PT_CMD_DW5(p))
+#define PT_CMD_DST_MEM(p)	((p)->dw5.dst_mem)
+#define PT_CMD_FIX_DST(p)	((p)->dw5.fixed)
+
+static inline u32 low_address(unsigned long addr)
+{
+	return (u64)addr & 0x0ffffffff;
+}
+
+static inline u32 high_address(unsigned long addr)
+{
+	return ((u64)addr >> 32) & 0x00000ffff;
+}
+
+unsigned int pt_core_get_free_slots(struct pt_cmd_queue *cmd_q)
+{
+	unsigned int head_idx, n;
+	u32 head_lo, queue_start;
+
+	queue_start =3D low_address(cmd_q->qdma_tail);
+	head_lo =3D ioread32(cmd_q->reg_head_lo);
+	head_idx =3D (head_lo - queue_start) / sizeof(struct ptdma_desc);
+
+	n =3D head_idx + COMMANDS_PER_QUEUE - cmd_q->qidx - 1;
+
+	return n % COMMANDS_PER_QUEUE; /* Always one unused spot */
+}
+
+static int pt_core_execute_cmd(struct ptdma_desc *desc,
+		       struct pt_cmd_queue *cmd_q)
+{
+	u32 *mP;
+	__le32 *dP;
+	u32 tail;
+	int	i;
+	int ret =3D 0;
+
+	if (PT_CMD_SOC(desc)) {
+		PT_CMD_IOC(desc) =3D 1;
+		PT_CMD_SOC(desc) =3D 0;
+	}
+	mutex_lock(&cmd_q->q_mutex);
+
+	mP =3D (u32 *) &cmd_q->qbase[cmd_q->qidx];
+	dP =3D (__le32 *) desc;
+	for (i =3D 0; i < 8; i++)
+		mP[i] =3D cpu_to_le32(dP[i]); /* handle endianness */
+
+	cmd_q->qidx =3D (cmd_q->qidx + 1) % COMMANDS_PER_QUEUE;
+
+	/* The data used by this command must be flushed to memory */
+	wmb();
+
+	/* Write the new tail address back to the queue register */
+	tail =3D low_address(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);
+	iowrite32(tail, cmd_q->reg_tail_lo);
+
+	/* Turn the queue back on using our cached control register */
+	iowrite32(cmd_q->qcontrol | CMD_Q_RUN, cmd_q->reg_control);
+	mutex_unlock(&cmd_q->q_mutex);
+
+	if (PT_CMD_IOC(desc)) {
+		/* Wait for the job to complete */
+		ret =3D wait_event_interruptible(cmd_q->int_queue,
+					       cmd_q->int_rcvd);
+		if (ret || cmd_q->cmd_error) {
+			/* Log the error and flush the queue by
+			 * moving the head pointer
+			 */
+			if (cmd_q->cmd_error)
+				pt_log_error(cmd_q->pt,
+					      cmd_q->cmd_error);
+			iowrite32(tail, cmd_q->reg_head_lo);
+			if (!ret)
+				ret =3D -EIO;
+		}
+		cmd_q->int_rcvd =3D 0;
+	}
+
+	return ret;
+}
+
+int pt_core_perform_passthru(struct pt_op *op)
+{
+	struct ptdma_desc desc;
+	union pt_function function;
+	struct pt_dma_info *saddr =3D &op->src.u.dma;
+
+	memset(&desc, 0, Q_DESC_SIZE);
+
+	PT_CMD_ENGINE(&desc) =3D PT_ENGINE_PASSTHRU;
+
+	PT_CMD_SOC(&desc) =3D 0;
+	PT_CMD_IOC(&desc) =3D 1;
+	PT_CMD_INIT(&desc) =3D 0;
+	PT_CMD_EOM(&desc) =3D op->eom;
+	PT_CMD_PROT(&desc) =3D 0;
+
+	function.raw =3D 0;
+	PT_BYTESWAP(&function) =3D op->passthru.byte_swap;
+	PT_BITWISE(&function) =3D op->passthru.bit_mod;
+	PT_CMD_FUNCTION(&desc) =3D function.raw;
+
+	PT_CMD_LEN(&desc) =3D saddr->length;
+
+	PT_CMD_SRC_LO(&desc) =3D pt_addr_lo(&op->src.u.dma);
+	PT_CMD_SRC_HI(&desc) =3D pt_addr_hi(&op->src.u.dma);
+	PT_CMD_SRC_MEM(&desc) =3D PT_MEMTYPE_SYSTEM;
+
+	PT_CMD_DST_LO(&desc) =3D pt_addr_lo(&op->dst.u.dma);
+	PT_CMD_DST_HI(&desc) =3D pt_addr_hi(&op->dst.u.dma);
+	PT_CMD_DST_MEM(&desc) =3D PT_MEMTYPE_SYSTEM;
+
+	return pt_core_execute_cmd(&desc, op->cmd_q);
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
+static void pt_core_irq_bh(unsigned long data)
+{
+	struct pt_device *pt =3D (struct pt_device *)data;
+	struct pt_cmd_queue *cmd_q =3D &pt->cmd_q;
+	u32 status;
+
+	status =3D ioread32(cmd_q->reg_interrupt_status);
+
+	if (status) {
+		cmd_q->int_status =3D status;
+		cmd_q->q_status =3D ioread32(cmd_q->reg_status);
+		cmd_q->q_int_status =3D ioread32(cmd_q->reg_int_status);
+
+		/* On error, only save the first error value */
+		if ((status & INT_ERROR) && !cmd_q->cmd_error)
+			cmd_q->cmd_error =3D CMD_Q_ERROR(cmd_q->q_status);
+
+		cmd_q->int_rcvd =3D 1;
+
+		/* Acknowledge the interrupt and wake the kthread */
+		iowrite32(status, cmd_q->reg_interrupt_status);
+		wake_up_interruptible(&cmd_q->int_queue);
+	}
+	pt_core_enable_queue_interrupts(pt);
+}
+
+static irqreturn_t pt_core_irq_handler(int irq, void *data)
+{
+	struct pt_device *pt =3D (struct pt_device *)data;
+
+	pt_core_disable_queue_interrupts(pt);
+	tasklet_schedule(&pt->irq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+int pt_core_init(struct pt_device *pt)
+{
+	struct device *dev =3D pt->dev;
+	struct pt_cmd_queue *cmd_q;
+	struct dma_pool *dma_pool;
+	char dma_pool_name[MAX_DMAPOOL_NAME_LEN];
+	int ret;
+	u32 dma_addr_lo, dma_addr_hi;
+	struct task_struct *kthread;
+
+	/* ptdma core initialisation */
+	iowrite32(CMD_CONFIG_VHB_EN, pt->io_regs + CMD_CONFIG_OFFSET);
+	iowrite32(CMD_QUEUE_PRIO, pt->io_regs + CMD_QUEUE_PRIO_OFFSET);
+	iowrite32(CMD_TIMEOUT_DISABLE, pt->io_regs + CMD_TIMEOUT_OFFSET);
+	iowrite32(CMD_CLK_GATE_CONFIG, pt->io_regs + CMD_CLK_GATE_CTL_OFFSET);
+	iowrite32(CMD_CONFIG_REQID, pt->io_regs + CMD_REQID_CONFIG_OFFSET);
+
+	/* Allocate a dma pool for the queue */
+	snprintf(dma_pool_name, sizeof(dma_pool_name), "pt_q");
+	dma_pool =3D dma_pool_create(dma_pool_name, dev,
+				   PT_DMAPOOL_MAX_SIZE,
+				   PT_DMAPOOL_ALIGN, 0);
+	if (!dma_pool) {
+		dev_err(dev, "unable to allocate dma pool\n");
+		ret =3D -ENOMEM;
+		return ret;
+	}
+
+	cmd_q =3D &pt->cmd_q;
+
+	cmd_q->pt =3D pt;
+	cmd_q->dma_pool =3D dma_pool;
+	mutex_init(&cmd_q->q_mutex);
+
+	/* Page alignment satisfies our needs for N <=3D 128 */
+	cmd_q->qsize =3D Q_SIZE(Q_DESC_SIZE);
+	cmd_q->qbase =3D dma_alloc_coherent(dev, cmd_q->qsize,
+					  &cmd_q->qbase_dma,
+					   GFP_KERNEL);
+	if (!cmd_q->qbase) {
+		dev_err(dev, "unable to allocate command queue\n");
+		ret =3D -ENOMEM;
+		goto e_dma_alloc;
+	}
+
+	cmd_q->qidx =3D 0;
+	/* Preset some register values and masks that are queue
+	 * number dependent
+	 */
+	cmd_q->reg_control =3D pt->io_regs + CMD_Q_STATUS_INCR;
+	cmd_q->reg_tail_lo =3D cmd_q->reg_control + CMD_Q_TAIL_LO_BASE;
+	cmd_q->reg_head_lo =3D cmd_q->reg_control + CMD_Q_HEAD_LO_BASE;
+	cmd_q->reg_int_enable =3D cmd_q->reg_control +
+				CMD_Q_INT_ENABLE_BASE;
+	cmd_q->reg_interrupt_status =3D cmd_q->reg_control +
+				      CMD_Q_INTERRUPT_STATUS_BASE;
+	cmd_q->reg_status =3D cmd_q->reg_control + CMD_Q_STATUS_BASE;
+	cmd_q->reg_int_status =3D cmd_q->reg_control +
+				CMD_Q_INT_STATUS_BASE;
+	cmd_q->reg_dma_status =3D cmd_q->reg_control +
+				CMD_Q_DMA_STATUS_BASE;
+	cmd_q->reg_dma_read_status =3D cmd_q->reg_control +
+				     CMD_Q_DMA_READ_STATUS_BASE;
+	cmd_q->reg_dma_write_status =3D cmd_q->reg_control +
+				      CMD_Q_DMA_WRITE_STATUS_BASE;
+
+	init_waitqueue_head(&cmd_q->int_queue);
+
+	dev_dbg(dev, "queue available\n");
+
+	/* Turn off the queues and disable interrupts until ready */
+	pt_core_disable_queue_interrupts(pt);
+
+	cmd_q->qcontrol =3D 0; /* Start with nothing */
+	iowrite32(cmd_q->qcontrol, cmd_q->reg_control);
+
+	ioread32(cmd_q->reg_int_status);
+	ioread32(cmd_q->reg_status);
+
+	/* Clear the interrupt status */
+	iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_interrupt_status);
+
+	dev_dbg(dev, "Requesting an IRQ...\n");
+	/* Request an irq */
+	ret =3D request_irq(pt->pt_irq, pt_core_irq_handler, 0, "pt", pt);
+	if (ret) {
+		dev_err(dev, "unable to allocate an IRQ\n");
+		goto e_pool;
+	}
+	/* Initialize the ISR tasklet */
+	tasklet_init(&pt->irq_tasklet, pt_core_irq_bh,
+		     (unsigned long)pt);
+
+	dev_dbg(dev, "Configuring virtual queues...\n");
+	/* Configure size of each virtual queue accessible to host */
+
+	cmd_q->qcontrol &=3D ~(CMD_Q_SIZE << CMD_Q_SHIFT);
+	cmd_q->qcontrol |=3D QUEUE_SIZE_VAL << CMD_Q_SHIFT;
+
+	cmd_q->qdma_tail =3D cmd_q->qbase_dma;
+	dma_addr_lo =3D low_address(cmd_q->qdma_tail);
+	iowrite32((u32)dma_addr_lo, cmd_q->reg_tail_lo);
+	iowrite32((u32)dma_addr_lo, cmd_q->reg_head_lo);
+
+	dma_addr_hi =3D high_address(cmd_q->qdma_tail);
+	cmd_q->qcontrol |=3D (dma_addr_hi << 16);
+	iowrite32(cmd_q->qcontrol, cmd_q->reg_control);
+
+	dev_dbg(dev, "Starting threads...\n");
+	/* Create a kthread for command queue */
+
+	kthread =3D kthread_create(pt_cmd_queue_thread, cmd_q, "pt-q");
+	if (IS_ERR(kthread)) {
+		dev_err(dev, "error creating queue thread (%ld)\n",
+			PTR_ERR(kthread));
+		ret =3D PTR_ERR(kthread);
+		goto e_kthread;
+	}
+
+	cmd_q->kthread =3D kthread;
+	wake_up_process(kthread);
+
+	dev_dbg(dev, "Enabling interrupts...\n");
+	pt_core_enable_queue_interrupts(pt);
+
+	dev_dbg(dev, "Registering device...\n");
+	/* Put this on the unit list to make it available */
+	pt_add_device(pt);
+
+	return 0;
+
+
+e_kthread:
+	if (pt->cmd_q.kthread)
+		kthread_stop(pt->cmd_q.kthread);
+
+	free_irq(pt->pt_irq, pt);
+
+e_dma_alloc:
+	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase,
+		  cmd_q->qbase_dma);
+
+e_pool:
+	dma_pool_destroy(pt->cmd_q.dma_pool);
+
+	return ret;
+}
+
+void pt_core_destroy(struct pt_device *pt)
+{
+	struct device *dev =3D pt->dev;
+	struct pt_cmd_queue *cmd_q =3D &pt->cmd_q;
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
+	/* Stop the queue kthreads */
+
+	if (pt->cmd_q.kthread)
+		kthread_stop(pt->cmd_q.kthread);
+
+	free_irq(pt->pt_irq, pt);
+
+	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase,
+			  cmd_q->qbase_dma);
+
+	/* Flush the cmd and backlog queue */
+	while (!list_empty(&pt->cmd)) {
+		/* Invoke the callback directly with an error code */
+		cmd =3D list_first_entry(&pt->cmd, struct pt_cmd, entry);
+		list_del(&cmd->entry);
+		cmd->callback(cmd->data, -ENODEV);
+	}
+	while (!list_empty(&pt->backlog)) {
+		/* Invoke the callback directly with an error code */
+		cmd =3D list_first_entry(&pt->backlog, struct pt_cmd, entry);
+		list_del(&cmd->entry);
+		cmd->callback(cmd->data, -ENODEV);
+	}
+}
diff --git a/drivers/dma/ptdma/ptdma-ops.c b/drivers/dma/ptdma/ptdma-ops.c
new file mode 100644
index 0000000..ca94802
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-ops.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Passthrough DMA device driver
+ *
+ * Copyright (C) 2019 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ *
+ * Based on CCP driver
+ *	Original copyright message:
+ *
+ *  Copyright (C) 2013,2017 Advanced Micro Devices, Inc.
+ *
+ *  Author: Tom Lendacky <thomas.lendacky@amd.com>
+ *  Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/cpu.h>
+
+#include "ptdma.h"
+
+static struct pt_device *pt_dev;
+
+struct pt_tasklet_data {
+	struct completion completion;
+	struct pt_cmd *cmd;
+};
+
+/* Human-readable error strings */
+static char *pt_error_codes[] =3D {
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
+static inline struct pt_device *pt_get_device(void)
+{
+	return pt_dev;
+}
+
+void pt_add_device(struct pt_device *pt)
+{
+	pt_dev =3D pt;
+}
+
+void pt_del_device(struct pt_device *pt)
+{
+	pt_dev =3D NULL;
+}
+
+void pt_log_error(struct pt_device *d, int e)
+{
+	dev_err(d->dev, "PTDMA error: %s (0x%x)\n", pt_error_codes[e], e);
+}
+
+/*
+ * pt_present - check if a PTDMA device is present
+ *
+ * Returns zero if a PTDMA device is present, -ENODEV otherwise.
+ */
+int pt_present(void)
+{
+	if (pt_get_device())
+		return 0;
+
+	return -ENODEV;
+}
+
+/*
+ * pt_enqueue_cmd - queue an operation for processing by the PTDMA
+ *
+ * @cmd: pt_cmd struct to be processed
+ *
+ * Queue a cmd to be processed by the PTDMA. If queueing the cmd
+ * would exceed the defined length of the cmd queue the cmd will
+ * only be queued if the PT_CMD_MAY_BACKLOG flag is set and will
+ * result in a return code of -EBUSY.
+ *
+ * The callback routine specified in the pt_cmd struct will be
+ * called to notify the caller of completion (if the cmd was not
+ * backlogged) or advancement out of the backlog. If the cmd has
+ * advanced out of the backlog the "err" value of the callback
+ * will be -EINPROGRESS. Any other "err" value during callback is
+ * the result of the operation.
+ *
+ * The cmd has been successfully queued if:
+ *   the return code is -EINPROGRESS or
+ *   the return code is -EBUSY and PT_CMD_MAY_BACKLOG flag is set
+ */
+int pt_enqueue_cmd(struct pt_cmd *cmd)
+{
+	struct pt_device *pt;
+	unsigned long flags;
+	int ret;
+
+	/* Caller must supply a callback routine */
+	if (!cmd->callback)
+		return -EINVAL;
+
+	/* Some commands might need to be sent to a specific device */
+	pt =3D cmd->pt ? cmd->pt : pt_get_device();
+
+	if (!pt)
+		return -ENODEV;
+
+	cmd->pt =3D pt;
+
+	spin_lock_irqsave(&pt->cmd_lock, flags);
+
+	if (pt->cmd_count >=3D MAX_CMD_QLEN) {
+		if (cmd->flags & PT_CMD_MAY_BACKLOG) {
+			ret =3D -EBUSY;
+			list_add_tail(&cmd->entry, &pt->backlog);
+		} else {
+			ret =3D -ENOSPC;
+		}
+	} else {
+		ret =3D -EINPROGRESS;
+		pt->cmd_count++;
+		list_add_tail(&cmd->entry, &pt->cmd);
+	}
+
+	spin_unlock_irqrestore(&pt->cmd_lock, flags);
+
+	/* If we found an idle queue, wake it up */
+	wake_up_process(pt->cmd_q.kthread);
+
+	return ret;
+}
+
+static void pt_do_cmd_backlog(struct work_struct *work)
+{
+	struct pt_cmd *cmd =3D container_of(work, struct pt_cmd, work);
+	struct pt_device *pt =3D cmd->pt;
+	unsigned long flags;
+
+	cmd->callback(cmd->data, -EINPROGRESS);
+
+	spin_lock_irqsave(&pt->cmd_lock, flags);
+
+	pt->cmd_count++;
+	list_add_tail(&cmd->entry, &pt->cmd);
+
+	spin_unlock_irqrestore(&pt->cmd_lock, flags);
+
+	/* If we found an idle queue, wake it up */
+	wake_up_process(pt->cmd_q.kthread);
+}
+
+static struct pt_cmd *pt_dequeue_cmd(struct pt_cmd_queue *cmd_q)
+{
+	struct pt_device *pt =3D cmd_q->pt;
+	struct pt_cmd *cmd =3D NULL;
+	struct pt_cmd *backlog =3D NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pt->cmd_lock, flags);
+
+	cmd_q->active =3D 0;
+
+	if (pt->suspending) {
+		cmd_q->suspended =3D 1;
+
+		spin_unlock_irqrestore(&pt->cmd_lock, flags);
+		wake_up_interruptible(&pt->suspend_queue);
+
+		return NULL;
+	}
+
+	if (pt->cmd_count) {
+		cmd_q->active =3D 1;
+
+		cmd =3D list_first_entry(&pt->cmd, struct pt_cmd, entry);
+		list_del(&cmd->entry);
+
+		pt->cmd_count--;
+	}
+
+	if (!list_empty(&pt->backlog)) {
+		backlog =3D list_first_entry(&pt->backlog, struct pt_cmd,
+					   entry);
+		list_del(&backlog->entry);
+	}
+
+	spin_unlock_irqrestore(&pt->cmd_lock, flags);
+
+	if (backlog) {
+		INIT_WORK(&backlog->work, pt_do_cmd_backlog);
+		schedule_work(&backlog->work);
+	}
+
+	return cmd;
+}
+
+static void pt_do_cmd_complete(unsigned long data)
+{
+	struct pt_tasklet_data *tdata =3D (struct pt_tasklet_data *)data;
+	struct pt_cmd *cmd =3D tdata->cmd;
+
+	cmd->callback(cmd->data, cmd->ret);
+
+	complete(&tdata->completion);
+}
+
+/*
+ * pt_cmd_queue_thread - create a kernel thread to manage a PTDMA queue
+ *
+ * @data: thread-specific data
+ */
+int pt_cmd_queue_thread(void *data)
+{
+	struct pt_cmd_queue *cmd_q =3D (struct pt_cmd_queue *)data;
+	struct pt_cmd *cmd;
+	struct pt_tasklet_data tdata;
+	struct tasklet_struct tasklet;
+
+	tasklet_init(&tasklet, pt_do_cmd_complete, (unsigned long)&tdata);
+
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		schedule();
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		cmd =3D pt_dequeue_cmd(cmd_q);
+		if (!cmd)
+			continue;
+
+		__set_current_state(TASK_RUNNING);
+
+		/* Execute the command */
+		cmd->ret =3D pt_run_cmd(cmd_q, cmd);
+
+		/* Schedule the completion callback */
+		tdata.cmd =3D cmd;
+		init_completion(&tdata.completion);
+		tasklet_schedule(&tasklet);
+		wait_for_completion(&tdata.completion);
+	}
+
+	__set_current_state(TASK_RUNNING);
+
+	return 0;
+}
+
+/*
+ * pt_alloc_struct - allocate and initialize the pt_device struct
+ *
+ * @dev: device struct of the PTDMA
+ */
+struct pt_device *pt_alloc_struct(struct device *dev)
+{
+	struct pt_device *pt;
+
+	pt =3D devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
+	if (!pt)
+		return NULL;
+	pt->dev =3D dev;
+
+	INIT_LIST_HEAD(&pt->cmd);
+	INIT_LIST_HEAD(&pt->backlog);
+
+	spin_lock_init(&pt->cmd_lock);
+	pt->lsb_count =3D LSB_COUNT;
+	pt->lsb_start =3D 0;
+
+	/*  the wait queues */
+	init_waitqueue_head(&pt->lsb_queue);
+	init_waitqueue_head(&pt->suspend_queue);
+
+	return pt;
+}
+
+int pt_dev_init(struct pt_device *pt)
+{
+	struct device *dev =3D pt->dev;
+	int ret;
+
+	pt->version =3D PT_VERSION(5, 0);
+
+	pt->io_regs +=3D PT_OFFSET;
+
+	ret =3D pt_core_init(pt);
+	if (ret) {
+		dev_notice(dev, "PTDMA initialization failed\n");
+		return ret;
+	}
+
+	dev_notice(dev, "PTDMA enabled\n");
+
+	return 0;
+}
+
+static int pt_run_passthru_cmd(struct pt_cmd_queue *cmd_q,
+				      struct pt_cmd *cmd)
+{
+	struct pt_passthru_engine *pt_engine =3D &cmd->passthru;
+	struct pt_op op;
+	int ret;
+
+	if (!pt_engine->final)
+		return -EINVAL;
+
+	if (!pt_engine->src_dma || !pt_engine->dst_dma)
+		return -EINVAL;
+
+	memset(&op, 0, sizeof(op));
+	op.cmd_q =3D cmd_q;
+
+	/* Send data to the Passthru engine */
+	op.eom =3D 1;
+	op.soc =3D 1;
+
+	op.src.type =3D PT_MEMTYPE_SYSTEM;
+	op.src.u.dma.address =3D pt_engine->src_dma;
+	op.src.u.dma.offset =3D 0;
+	op.src.u.dma.length =3D pt_engine->src_len;
+
+	op.dst.type =3D PT_MEMTYPE_SYSTEM;
+	op.dst.u.dma.address =3D pt_engine->dst_dma;
+	op.dst.u.dma.offset =3D 0;
+	op.dst.u.dma.length =3D pt_engine->src_len;
+
+	ret =3D pt_core_perform_passthru(&op);
+	if (ret)
+		cmd->engine_error =3D cmd_q->cmd_error;
+
+	return ret;
+}
+
+int pt_run_cmd(struct pt_cmd_queue *cmd_q, struct pt_cmd *cmd)
+{
+	int ret;
+
+	cmd->engine_error =3D 0;
+	cmd_q->cmd_error =3D 0;
+	cmd_q->int_rcvd =3D 0;
+	cmd_q->free_slots =3D pt_core_get_free_slots(cmd_q);
+
+	ret =3D pt_run_passthru_cmd(cmd_q, cmd);
+
+	return ret;
+}
diff --git a/drivers/dma/ptdma/ptdma-pci.c b/drivers/dma/ptdma/ptdma-pci.c
new file mode 100644
index 0000000..ceb6b16
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-pci.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Passthrough DMA device driver
+ *
+ * Copyright (C) 2019 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ *
+ * Based on CCP driver
+ *	Original copyright message:
+ *
+ *  Copyright (C) 2013,2018 Advanced Micro Devices, Inc.
+ *
+ *  Author: Tom Lendacky <thomas.lendacky@amd.com>
+ *  Author: Gary R Hook <gary.hook@amd.com>
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
+struct pt_msix {
+	int msix_count;
+	struct msix_entry msix_entry;
+};
+
+static int pt_get_msix_irqs(struct pt_device *pt)
+{
+	struct pt_msix *pt_msix =3D pt->pt_msix;
+	struct device *dev =3D pt->dev;
+	struct pci_dev *pdev =3D to_pci_dev(dev);
+	int ret;
+
+	pt_msix->msix_entry.entry =3D 0;
+
+	ret =3D pci_enable_msix_range(pdev, &pt_msix->msix_entry, 1, 1);
+	if (ret < 0)
+		return ret;
+
+	pt_msix->msix_count =3D ret;
+
+	pt->pt_irq =3D pt_msix->msix_entry.vector;
+
+	return 0;
+}
+
+static int pt_get_msi_irq(struct pt_device *pt)
+{
+	struct device *dev =3D pt->dev;
+	struct pci_dev *pdev =3D to_pci_dev(dev);
+	int ret;
+
+	ret =3D pci_enable_msi(pdev);
+	if (ret)
+		return ret;
+
+	pt->pt_irq =3D pdev->irq;
+
+	return 0;
+}
+
+static int pt_get_irqs(struct pt_device *pt)
+{
+	struct device *dev =3D pt->dev;
+	int ret;
+
+	ret =3D pt_get_msix_irqs(pt);
+	if (!ret)
+		return 0;
+
+	/* Couldn't get MSI-X vectors, try MSI */
+	dev_notice(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
+	ret =3D pt_get_msi_irq(pt);
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
+	struct pt_msix *pt_msix =3D pt->pt_msix;
+	struct device *dev =3D pt->dev;
+	struct pci_dev *pdev =3D to_pci_dev(dev);
+
+	if (pt_msix->msix_count)
+		pci_disable_msix(pdev);
+	else if (pt->pt_irq)
+		pci_disable_msi(pdev);
+
+	pt->pt_irq =3D 0;
+}
+
+static int pt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *=
id)
+{
+	struct pt_device *pt;
+	struct pt_msix *pt_msix;
+	struct device *dev =3D &pdev->dev;
+	void __iomem * const *iomap_table;
+	int bar_mask;
+	int ret =3D -ENOMEM;
+
+	pt =3D pt_alloc_struct(dev);
+	if (!pt)
+		goto e_err;
+
+	pt_msix =3D devm_kzalloc(dev, sizeof(*pt_msix), GFP_KERNEL);
+	if (!pt_msix)
+		goto e_err;
+
+	pt->pt_msix =3D pt_msix;
+	pt->dev_vdata =3D (struct pt_dev_vdata *)id->driver_data;
+	if (!pt->dev_vdata) {
+		ret =3D -ENODEV;
+		dev_err(dev, "missing driver data\n");
+		goto e_err;
+	}
+
+	ret =3D pcim_enable_device(pdev);
+	if (ret) {
+		dev_err(dev, "pcim_enable_device failed (%d)\n", ret);
+		goto e_err;
+	}
+
+	bar_mask =3D pci_select_bars(pdev, IORESOURCE_MEM);
+	ret =3D pcim_iomap_regions(pdev, bar_mask, "ptdma");
+	if (ret) {
+		dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
+		goto e_err;
+	}
+
+	iomap_table =3D pcim_iomap_table(pdev);
+	if (!iomap_table) {
+		dev_err(dev, "pcim_iomap_table failed\n");
+		ret =3D -ENOMEM;
+		goto e_err;
+	}
+
+	pt->io_regs =3D iomap_table[pt->dev_vdata->bar];
+	if (!pt->io_regs) {
+		dev_err(dev, "ioremap failed\n");
+		ret =3D -ENOMEM;
+		goto e_err;
+	}
+
+	ret =3D pt_get_irqs(pt);
+	if (ret)
+		goto e_err;
+
+	pci_set_master(pdev);
+
+	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
+	if (ret) {
+		ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
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
+		ret =3D pt_dev_init(pt);
+
+	if (ret)
+		goto e_err;
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
+	struct device *dev =3D &pdev->dev;
+	struct pt_device *pt =3D dev_get_drvdata(dev);
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
+static const struct pt_dev_vdata dev_vdata[] =3D {
+	{
+		.bar =3D 2,
+		.version =3D PT_VERSION(5, 0),
+	},
+};
+static const struct pci_device_id pt_pci_table[] =3D {
+	{ PCI_VDEVICE(AMD, 0x1498), (kernel_ulong_t)&dev_vdata[0] },
+	/* Last entry must be zero */
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, pt_pci_table);
+
+static struct pci_driver pt_pci_driver =3D {
+	.name =3D "ptdma",
+	.id_table =3D pt_pci_table,
+	.probe =3D pt_pci_probe,
+	.remove =3D pt_pci_remove,
+#ifdef CONFIG_PM
+	.suspend =3D pt_pci_suspend,
+	.resume =3D pt_pci_resume,
+#endif
+};
+
+module_pci_driver(pt_pci_driver);
+
+MODULE_AUTHOR("Sanjay R Mehta <sanju.mehta@amd.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD Pass-through DMA driver");
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
new file mode 100644
index 0000000..75b8e25
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma.h
@@ -0,0 +1,501 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD Passthrough DMA device driver
+ *
+ * Copyright (C) 2019 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ *
+ * Based on CCP driver
+ *	Original copyright message:
+ *
+ *  Copyright (C) 2013,2017 Advanced Micro Devices, Inc.
+ *
+ *  Author: Tom Lendacky <thomas.lendacky@amd.com>
+ *  Author: Gary R Hook <gary.hook@amd.com>
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
+#define MAX_DMAPOOL_NAME_LEN		32
+
+#define MAX_HW_QUEUES			1
+#define MAX_CMD_QLEN			100
+
+#define PT_ENGINE_PASSTHRU		5
+#define PT_OFFSET			0x0
+
+/* Flag values for flags member of pt_cmd */
+#define PT_CMD_MAY_BACKLOG		0x00000001
+
+#define	PT_VSIZE			16
+#define	PT_VMASK			((unsigned int)((1 << PT_VSIZE) - 1))
+#define	PT_VERSION(v, r)	((unsigned int)((v << PT_VSIZE) \
+					       | (r & PT_VMASK)))
+
+/****** Register Mappings ******/
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
+#define	CMD_CONFIG_REQID	0x0
+#define	CMD_CONFIG_VHB_EN	0x00000001
+#define	CMD_QUEUE_PRIO		0x00000006
+#define	CMD_TIMEOUT_DISABLE	0x00000000
+#define	CMD_CLK_DYN_GATING_EN	0x1
+#define	CMD_CLK_DYN_GATING_DIS	0x0
+#define	CMD_CLK_HW_GATE_MODE	0x1
+#define	CMD_CLK_SW_GATE_MODE	0x0
+#define	CMD_CLK_GATE_ON_DELAY	0x1000
+#define	CMD_CLK_GATE_CTL	0x0
+#define	CMD_CLK_GATE_OFF_DELAY	0x1000
+
+#define CMD_CLK_GATE_CONFIG	(CMD_CLK_DYN_GATING_EN |	\
+				 CMD_CLK_HW_GATE_MODE | CMD_CLK_GATE_ON_DELAY |\
+				 CMD_CLK_GATE_CTL | CMD_CLK_GATE_OFF_DELAY)
+
+#define CMD_Q_RUN		0x1
+#define CMD_Q_HALT		0x2
+#define CMD_Q_MEM_LOCATION	0x4
+#define CMD_Q_SIZE		0x1F
+#define CMD_Q_SHIFT		3
+#define COMMANDS_PER_QUEUE	16
+#define QUEUE_SIZE_VAL		((ffs(COMMANDS_PER_QUEUE) - 2) & \
+							  CMD_Q_SIZE)
+#define Q_PTR_MASK		(2 << (QUEUE_SIZE_VAL + 5) - 1)
+#define Q_DESC_SIZE		sizeof(struct ptdma_desc)
+#define Q_SIZE(n)		(COMMANDS_PER_QUEUE*(n))
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
+struct pt_op;
+struct pt_device;
+
+/***** Passthru engine *****/
+/*
+ * pt_passthru_bitwise - type of bitwise passthru operation
+ *
+ * @PT_PASSTHRU_BITWISE_NOOP: no bitwise operation performed
+ * @PT_PASSTHRU_BITWISE_AND: perform bitwise AND of src with mask
+ * @PT_PASSTHRU_BITWISE_OR: perform bitwise OR of src with mask
+ * @PT_PASSTHRU_BITWISE_XOR: perform bitwise XOR of src with mask
+ * @PT_PASSTHRU_BITWISE_MASK: overwrite with mask
+ */
+enum pt_passthru_bitwise {
+	PT_PASSTHRU_BITWISE_NOOP =3D 0,
+	PT_PASSTHRU_BITWISE_AND,
+	PT_PASSTHRU_BITWISE_OR,
+	PT_PASSTHRU_BITWISE_XOR,
+	PT_PASSTHRU_BITWISE_MASK,
+	PT_PASSTHRU_BITWISE_LAST,
+};
+
+/*
+ * pt_passthru_byteswap - type of byteswap passthru operation
+ *
+ * @PT_PASSTHRU_BYTESWAP_NOOP: no byte swapping performed
+ * @PT_PASSTHRU_BYTESWAP_32BIT: swap bytes within 32-bit words
+ * @PT_PASSTHRU_BYTESWAP_512BIT: swap bytes within 512-bit words
+ */
+enum pt_passthru_byteswap {
+	PT_PASSTHRU_BYTESWAP_NOOP =3D 0,
+	PT_PASSTHRU_BYTESWAP_32BIT,
+	PT_PASSTHRU_BYTESWAP_512BIT,
+	PT_PASSTHRU_BYTESWAP_LAST,
+};
+
+/***** memory type *****/
+enum pt_memtype {
+	PT_MEMTYPE_SYSTEM =3D 0,
+	PT_MEMTYPE_SB,
+	PT_MEMTYPE_LOCAL,
+	PT_MEMTYPE_LAST,
+};
+
+/*
+ * struct pt_passthru_engine - pass-through operation
+ *   without performing DMA mapping
+ * @bit_mod: bitwise operation to perform
+ * @byte_swap: byteswap operation to perform
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
+	enum pt_passthru_bitwise bit_mod;
+	enum pt_passthru_byteswap byte_swap;
+
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
+ * @passthru: engine specific structures, refer to specific engine struct =
below
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
+	u32 flags;
+
+	u32 engine;
+	u32 engine_error;
+
+	struct pt_passthru_engine passthru;
+
+	/* Completion callback support */
+	void (*callback)(void *data, int err);
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
+	/* Queue processing thread */
+	struct task_struct *kthread;
+	unsigned int active;
+	unsigned int suspended;
+
+	/* Number of free command slots available */
+	unsigned int free_slots;
+
+	/* Interrupt masks */
+	u32 int_ok;
+	u32 int_err;
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
+	/* Interrupt wait queue */
+	wait_queue_head_t int_queue;
+	unsigned int int_rcvd;
+} ____cacheline_aligned;
+
+struct pt_device {
+	unsigned int version;
+
+	struct device *dev;
+
+	/* Bus specific device information */
+	struct pt_msix *pt_msix;
+
+	struct pt_dev_vdata *dev_vdata;
+
+	unsigned int pt_irq;
+	struct tasklet_struct irq_tasklet;
+
+	/* I/O area used for device communication */
+	void __iomem *io_regs;
+
+	spinlock_t cmd_lock ____cacheline_aligned;
+	unsigned int cmd_count;
+	struct list_head cmd;
+	struct list_head backlog;
+
+	/* The command queue. This represent the queue available on the
+	 * PTDMA that are available for processing cmds
+	 */
+	struct pt_cmd_queue cmd_q;
+
+	wait_queue_head_t lsb_queue;
+	unsigned int lsb_count;
+	u32 lsb_start;
+
+	/* Suspend support */
+	unsigned int suspending;
+	wait_queue_head_t suspend_queue;
+};
+
+struct pt_dma_info {
+	dma_addr_t address;
+	unsigned int offset;
+	unsigned int length;
+	enum dma_data_direction dir;
+} __packed __aligned(4);
+
+struct pt_dm_workarea {
+	struct device *dev;
+	struct dma_pool *dma_pool;
+
+	u8 *address;
+	struct pt_dma_info dma;
+	unsigned int length;
+};
+
+struct pt_sg_workarea {
+	struct scatterlist *sg;
+	int nents;
+	unsigned int sg_used;
+
+	struct scatterlist *dma_sg;
+	struct device *dma_dev;
+	unsigned int dma_count;
+	enum dma_data_direction dma_dir;
+
+	u64 bytes_left;
+};
+
+struct pt_data {
+	struct pt_sg_workarea sg_wa;
+	struct pt_dm_workarea dm_wa;
+};
+
+struct pt_mem {
+	enum pt_memtype type;
+	union {
+		struct pt_dma_info dma;
+		u32 sb;
+	} u;
+};
+
+struct pt_passthru_op {
+	enum pt_passthru_bitwise bit_mod;
+	enum pt_passthru_byteswap byte_swap;
+};
+
+struct pt_op {
+	struct pt_cmd_queue *cmd_q;
+
+	u32 ioc;
+	u32 soc;
+	u32 sb_key;
+	u32 sb_ctx;
+	u32 init;
+	u32 eom;
+
+	struct pt_mem src;
+	struct pt_mem dst;
+	struct pt_mem exp;
+
+	struct pt_passthru_op passthru;
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
+struct dword0 {
+	unsigned int soc:1;
+	unsigned int ioc:1;
+	unsigned int rsvd1:1;
+	unsigned int init:1;
+	unsigned int eom:1;
+	unsigned int function:15;
+	unsigned int engine:4;
+	unsigned int prot:1;
+	unsigned int rsvd2:7;
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
+	struct dword0 dw0;
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
+static inline u32 pt_addr_lo(struct pt_dma_info *info)
+{
+	return lower_32_bits(info->address + info->offset);
+}
+
+static inline u32 pt_addr_hi(struct pt_dma_info *info)
+{
+	return upper_32_bits(info->address + info->offset) & 0x0000ffff;
+}
+
+void pt_add_device(struct pt_device *pt);
+void pt_del_device(struct pt_device *pt);
+
+void pt_log_error(struct pt_device *d, int e);
+
+struct pt_device *pt_alloc_struct(struct device *dev);
+bool pt_queues_suspended(struct pt_device *pt);
+int pt_cmd_queue_thread(void *data);
+
+int pt_run_cmd(struct pt_cmd_queue *cmd_q, struct pt_cmd *cmd);
+
+int pt_core_init(struct pt_device *pt);
+void pt_core_destroy(struct pt_device *pt);
+
+int pt_dev_init(struct pt_device *pt);
+
+int pt_dev_suspend(struct pt_device *pt, pm_message_t state);
+int pt_dev_resume(struct pt_device *pt);
+
+int pt_core_perform_passthru(struct pt_op *op);
+unsigned int pt_core_get_free_slots(struct pt_cmd_queue *cmd_q);
+
+/*
+ * pt_present - check if a PTDMA device is present
+ *
+ * Returns zero if a PTDMA device is present, -ENODEV otherwise.
+ */
+int pt_present(void);
+
+/*
+ * pt_enqueue_cmd - queue an operation for processing by the PTDMA
+ *
+ * @cmd: pt_cmd struct to be processed
+ *
+ * Refer to the pt_cmd struct below for required fields.
+ *
+ * Queue a cmd to be processed by the PTDMA. If queueing the cmd
+ * would exceed the defined length of the cmd queue the cmd will
+ * only be queued if the PT_CMD_MAY_BACKLOG flag is set and will
+ * result in a return code of -EBUSY.
+ *
+ * The callback routine specified in the pt_cmd struct will be
+ * called to notify the caller of completion (if the cmd was not
+ * backlogged) or advancement out of the backlog. If the cmd has
+ * advanced out of the backlog the "err" value of the callback
+ * will be -EINPROGRESS. Any other "err" value during callback is
+ * the result of the operation.
+ *
+ * The cmd has been successfully queued if:
+ *   the return code is -EINPROGRESS or
+ *   the return code is -EBUSY and PT_CMD_MAY_BACKLOG flag is set
+ */
+int pt_enqueue_cmd(struct pt_cmd *cmd);
+
+#endif
--=20
2.7.4

