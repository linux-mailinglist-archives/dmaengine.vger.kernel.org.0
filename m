Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B47BC2BA
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 09:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502516AbfIXHdk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 03:33:40 -0400
Received: from mail-eopbgr770081.outbound.protection.outlook.com ([40.107.77.81]:13703
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438456AbfIXHdh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 03:33:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+DhFMPDTGR0oniPxlSlA16e+2D4o5M36qNaXETyV63aT9VGDlZF55LvweDvInIw41GDNFdBrWWxo2eVeMaLYr1LcWtSMBJyq3sro3whn58NUbdCOTikRYX1ys+vFQh1OKHqkAYIQjuPLJ5btefr34G1J+oqpX0OVqJ9EDFtPT+h0CCRbNd22D3c3NYbq93//9CByf092LxDJu2+Vc60DGZcZS0XnbLvbdYW3rpY1+3gj11oQR2UFXdtdgEXTNrDzzTBLP02D5RPCcivJZOS7gPkgjewWNIeX0D4TOYxvUPSuIy0A41+/HNhY59eyLCZmTdxfxhrHW5miN3hSVojdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDsy85Noqwl/sCJByYeyWlcr62jd/RkZTQDKjaj8F+Y=;
 b=AvslV2iTJPbHQtJjzy7if/gnykM3V26qpgMUQ5UZAHE+GVIBp3zRaeiJN9azcj51vkTbuzbsdaWA9xTmR+GAo3UGJtZ3nV84M+x11/IHOLCF9VskWsUItkaEjFH5xZ1Xtw583tdY0avN6zRRW8cvrUjJTYJDR7hwE6OnVSLZp+vdp/rfLFwV+U0kqpMW8fBrLlF0Z7wxaiEMKJb1Pa1EHbOB2ML628Z7qWmL/oLbACgCT4DaMVTrmHVF19wHpB0w5hScaYawEOUmJO8QtB6T0m/DB3Q60GIwoZvlmH322WgxgrHrgBRViUZ+AUPVXejifVV5YAGOmdTOZZbAmIC/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDsy85Noqwl/sCJByYeyWlcr62jd/RkZTQDKjaj8F+Y=;
 b=lKNmRAceAhgypNNqQEHPSZXOUUtloT7tTObXr1+5V5/vUusQjPl03S/Un504XwKoFmZPKWYHtep6OluzD9ugeUiC6A3bB3TJlMnAd+lWsQyTyLucCI/jwSbZf3oSph+REZQNkQT1gVnn/Y1xschszTWmd8d/fuTDcKTJSDAYhOo=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3007.namprd12.prod.outlook.com (20.178.244.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:33:02 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:33:02 +0000
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
Subject: [PATCH 4/4] dmaengine: Add debugfs entries for PTDMA information
Thread-Topic: [PATCH 4/4] dmaengine: Add debugfs entries for PTDMA information
Thread-Index: AQHVcqpMx6HFMYask0qZb2sW/KwVyQ==
Date:   Tue, 24 Sep 2019 07:33:02 +0000
Message-ID: <1569310357-29271-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::25) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b08e08d2-1d7b-4443-0ca5-08d740c16e97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3007;
x-ms-traffictypediagnostic: MN2PR12MB3007:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB30072B35E82A6F9732A8560FE5840@MN2PR12MB3007.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(110136005)(186003)(99286004)(52116002)(7736002)(6506007)(305945005)(50226002)(66476007)(4326008)(478600001)(2501003)(66946007)(66556008)(66446008)(64756008)(86362001)(386003)(2201001)(6436002)(6486002)(71190400001)(71200400001)(54906003)(6512007)(5660300002)(25786009)(6116002)(3846002)(14454004)(36756003)(14444005)(256004)(81156014)(8676002)(486006)(7416002)(8936002)(81166006)(476003)(2616005)(66066001)(316002)(26005)(102836004)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3007;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nD9xIcaY1e5Nt4M2Wu9SbJOn5DJe1nJETrFEbWu6fRmOsJ7+0fNwjw8TwkS/E5x6jdzMber1KT76T2w6AhpntLwxrXHdnc+7KmEdnuIB8oWdnnU19DqUk1lNUQq2s5ILKfhEwqE6dKGmZMGfC52P6/PoX67Kl+n0VhZWeujxbks/3V/Gu/pSp4PdNc4yVbry0Zf/NwxaJ2Ct+AWvnxFyNuR6mr7aKBEBz2O4S9TAEKMSZ+UJuDxlEb/3eTp01SzFH4kfDOMyKK1Bu5BknCjLJX8m0DHLJI1uRY+FDSvZr2UebKovxA43cn0ycVU0L4mTT9D25ZLY9p0jG525bsWc+ub2wYX110UBHhReg2zL5KX3qDh7FhAy/DjmRKY9FjwLk56/FG49V7pLW0wZwjVOygcwJ9xSnDW92H4T+wCXZI0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08e08d2-1d7b-4443-0ca5-08d740c16e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:33:02.7411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApX7Xr6qKjtk3efd7/+ewarkqh7sV+xyzutNnp8wH9XGvDzZjnahzCeVBa9jOwBbDN0KmCFAnm0JwWXUGnakUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3007
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Expose data about the configuration and operation of the PTDMA
through debugfs entries: device name, capabilities, configuration,
statistics.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Rajesh Kumar <Rajesh1.Kumar@amd.com>
---
 drivers/dma/ptdma/Makefile        |   3 +-
 drivers/dma/ptdma/ptdma-debugfs.c | 249 ++++++++++++++++++++++++++++++++++=
++++
 drivers/dma/ptdma/ptdma-dev.c     |  15 +++
 drivers/dma/ptdma/ptdma.h         |  14 +++
 4 files changed, 280 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c

diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/ptdma/Makefile
index 5fc174a..0c8ee97 100644
--- a/drivers/dma/ptdma/Makefile
+++ b/drivers/dma/ptdma/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_AMD_PTDMA) +=3D ptdma.o
=20
 ptdma-objs :=3D ptdma-ops.o \
 	      ptdma-dev.o \
-	      ptdma-dmaengine.o
+	      ptdma-dmaengine.o \
+	      ptdma-debugfs.o
=20
 ptdma-$(CONFIG_PCI) +=3D ptdma-pci.o
diff --git a/drivers/dma/ptdma/ptdma-debugfs.c b/drivers/dma/ptdma/ptdma-de=
bugfs.c
new file mode 100644
index 0000000..ec5d3d3
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-debugfs.c
@@ -0,0 +1,249 @@
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
+ *  Copyright (C) 2017 Advanced Micro Devices, Inc.
+ *
+ *  Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/debugfs.h>
+
+#include "ptdma.h"
+
+/* DebugFS helpers */
+#define	OBUFP		(obuf + oboff)
+#define	OBUFLEN		512
+#define	OBUFSPC		(OBUFLEN - oboff)
+#define	OSCNPRINTF(fmt, ...) \
+		scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)
+
+#define	MAX_NAME_LEN	20
+#define	BUFLEN	63
+#define	RI_VERSION_NUM	0x0000003F
+
+#define	RI_NUM_VQM	0x00078000
+#define	RI_NVQM_SHIFT	15
+#define	RI_NVQM(r)	(((r) * RI_NUM_VQM) >> RI_NVQM_SHIFT)
+#define	RI_LSB_ENTRIES	0x0FF80000
+#define	RI_NLSB_SHIFT	19
+#define	RI_NLSB(r)	(((r) * RI_LSB_ENTRIES) >> RI_NLSB_SHIFT)
+
+static struct dentry *pt_debugfs_dir;
+static DEFINE_MUTEX(pt_debugfs_lock);
+
+static ssize_t ptdma_debugfs_info_read(struct file *filp, char __user *ubu=
f,
+				      size_t count, loff_t *offp)
+{
+	struct pt_device *pt =3D filp->private_data;
+	unsigned int oboff =3D 0;
+	unsigned int regval;
+	ssize_t ret;
+	char *obuf;
+
+	if (!pt)
+		return 0;
+
+	obuf =3D kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	oboff +=3D OSCNPRINTF("Device name: %s\n", pt->name);
+	oboff +=3D OSCNPRINTF("   # Queues: %d\n", 1);
+	oboff +=3D OSCNPRINTF("     # Cmds: %d\n", pt->cmd_count);
+
+	regval =3D ioread32(pt->io_regs + CMD_PT_VERSION);
+
+	oboff +=3D OSCNPRINTF("    Version: %d\n", regval & RI_VERSION_NUM);
+	oboff +=3D OSCNPRINTF("    Engines:");
+	oboff +=3D OSCNPRINTF("\n");
+	oboff +=3D OSCNPRINTF("     Queues: %d\n",
+		   (regval & RI_NUM_VQM) >> RI_NVQM_SHIFT);
+	oboff +=3D OSCNPRINTF("LSB Entries: %d\n",
+		   (regval & RI_LSB_ENTRIES) >> RI_NLSB_SHIFT);
+
+	ret =3D simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+/* Return a formatted buffer containing the current
+ * statistics of queue for PTDMA
+ */
+static ssize_t ptdma_debugfs_stats_read(struct file *filp, char __user *ub=
uf,
+				       size_t count, loff_t *offp)
+{
+	struct pt_device *pt =3D filp->private_data;
+	unsigned long total_pt_ops =3D 0;
+	unsigned long total_ops =3D 0;
+	unsigned int oboff =3D 0;
+	ssize_t ret =3D 0;
+	char *obuf;
+	struct pt_cmd_queue *cmd_q =3D &pt->cmd_q;
+
+	total_ops +=3D cmd_q->total_ops;
+	total_pt_ops +=3D cmd_q->total_pt_ops;
+
+	obuf =3D kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	oboff +=3D OSCNPRINTF("Total Interrupts Handled: %ld\n",
+			    pt->total_interrupts);
+	oboff +=3D OSCNPRINTF("        Total Operations: %ld\n",
+			    total_ops);
+	oboff +=3D OSCNPRINTF("               Pass-Thru: %ld\n",
+			    total_pt_ops);
+
+	ret =3D simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+/* Reset the counters in a queue
+ */
+static void ptdma_debugfs_reset_queue_stats(struct pt_cmd_queue *cmd_q)
+{
+	cmd_q->total_ops =3D 0L;
+	cmd_q->total_pt_ops =3D 0L;
+}
+
+/* A value was written to the stats variable, which
+ * should be used to reset the queue counters across
+ * that device.
+ */
+static ssize_t ptdma_debugfs_stats_write(struct file *filp,
+					const char __user *ubuf,
+					size_t count, loff_t *offp)
+{
+	struct pt_device *pt =3D filp->private_data;
+
+	ptdma_debugfs_reset_queue_stats(&pt->cmd_q);
+	pt->total_interrupts =3D 0L;
+
+	return count;
+}
+
+/* Return a formatted buffer containing the current information
+ * for that queue
+ */
+static ssize_t ptdma_debugfs_queue_read(struct file *filp, char __user *ub=
uf,
+				       size_t count, loff_t *offp)
+{
+	struct pt_cmd_queue *cmd_q =3D filp->private_data;
+	unsigned int oboff =3D 0;
+	unsigned int regval;
+	ssize_t ret;
+	char *obuf;
+
+	if (!cmd_q)
+		return 0;
+
+	obuf =3D kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	oboff +=3D OSCNPRINTF("  Total Queue Operations: %ld\n",
+			    cmd_q->total_ops);
+	oboff +=3D OSCNPRINTF("               Pass-Thru: %ld\n",
+			    cmd_q->total_pt_ops);
+
+	regval =3D ioread32(cmd_q->reg_int_enable);
+	oboff +=3D OSCNPRINTF("      Enabled Interrupts:");
+	if (regval & INT_EMPTY_QUEUE)
+		oboff +=3D OSCNPRINTF(" EMPTY");
+	if (regval & INT_QUEUE_STOPPED)
+		oboff +=3D OSCNPRINTF(" STOPPED");
+	if (regval & INT_ERROR)
+		oboff +=3D OSCNPRINTF(" ERROR");
+	if (regval & INT_COMPLETION)
+		oboff +=3D OSCNPRINTF(" COMPLETION");
+	oboff +=3D OSCNPRINTF("\n");
+
+	ret =3D simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+/* A value was written to the stats variable for a
+ * queue. Reset the queue counters to this value.
+ */
+static ssize_t ptdma_debugfs_queue_write(struct file *filp,
+					const char __user *ubuf,
+					size_t count, loff_t *offp)
+{
+	struct pt_cmd_queue *cmd_q =3D filp->private_data;
+
+	ptdma_debugfs_reset_queue_stats(cmd_q);
+
+	return count;
+}
+
+static const struct file_operations pt_debugfs_info_ops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D simple_open,
+	.read =3D ptdma_debugfs_info_read,
+	.write =3D NULL,
+};
+
+static const struct file_operations pt_debugfs_queue_ops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D simple_open,
+	.read =3D ptdma_debugfs_queue_read,
+	.write =3D ptdma_debugfs_queue_write,
+};
+
+static const struct file_operations pt_debugfs_stats_ops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D simple_open,
+	.read =3D ptdma_debugfs_stats_read,
+	.write =3D ptdma_debugfs_stats_write,
+};
+
+void ptdma_debugfs_setup(struct pt_device *pt)
+{
+	struct pt_cmd_queue *cmd_q;
+	char name[MAX_NAME_LEN + 1];
+	struct dentry *debugfs_q_instance;
+
+	if (!debugfs_initialized())
+		return;
+
+	mutex_lock(&pt_debugfs_lock);
+	if (!pt_debugfs_dir)
+		pt_debugfs_dir =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
+	mutex_unlock(&pt_debugfs_lock);
+
+	pt->debugfs_instance =3D debugfs_create_dir(pt->name, pt_debugfs_dir);
+
+	debugfs_create_file("info", 0400, pt->debugfs_instance, pt,
+			    &pt_debugfs_info_ops);
+
+	debugfs_create_file("stats", 0600, pt->debugfs_instance, pt,
+			    &pt_debugfs_stats_ops);
+
+	cmd_q =3D &pt->cmd_q;
+
+	snprintf(name, MAX_NAME_LEN - 1, "q");
+
+	debugfs_q_instance =3D
+		debugfs_create_dir(name, pt->debugfs_instance);
+
+	debugfs_create_file("stats", 0600, debugfs_q_instance, cmd_q,
+			    &pt_debugfs_queue_ops);
+}
+
+void ptdma_debugfs_destroy(void)
+{
+	debugfs_remove_recursive(pt_debugfs_dir);
+}
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index 1a7a982..29a8c40 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/kthread.h>
+#include <linux/debugfs.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
=20
@@ -102,6 +103,8 @@ static int pt_core_execute_cmd(struct ptdma_desc *desc,
 	int	i;
 	int ret =3D 0;
=20
+	cmd_q->total_ops++;
+
 	if (PT_CMD_SOC(desc)) {
 		PT_CMD_IOC(desc) =3D 1;
 		PT_CMD_SOC(desc) =3D 0;
@@ -153,6 +156,8 @@ int pt_core_perform_passthru(struct pt_op *op)
 	union pt_function function;
 	struct pt_dma_info *saddr =3D &op->src.u.dma;
=20
+	op->cmd_q->total_pt_ops++;
+
 	memset(&desc, 0, Q_DESC_SIZE);
=20
 	PT_CMD_ENGINE(&desc) =3D PT_ENGINE_PASSTHRU;
@@ -222,6 +227,7 @@ static irqreturn_t pt_core_irq_handler(int irq, void *d=
ata)
 	struct pt_device *pt =3D (struct pt_device *)data;
=20
 	pt_core_disable_queue_interrupts(pt);
+	pt->total_interrupts++;
 	tasklet_schedule(&pt->irq_tasklet);
=20
 	return IRQ_HANDLED;
@@ -362,6 +368,9 @@ int pt_core_init(struct pt_device *pt)
 	if (ret)
 		goto e_kthread;
=20
+	/* Set up debugfs entries */
+	ptdma_debugfs_setup(pt);
+
 	return 0;
=20
=20
@@ -393,6 +402,12 @@ void pt_core_destroy(struct pt_device *pt)
 	/* Remove this device from the list of available units first */
 	pt_del_device(pt);
=20
+	/* We're in the process of tearing down the entire driver;
+	 * when all the devices are gone clean up debugfs
+	 */
+	if (pt_present())
+		ptdma_debugfs_destroy();
+
 	/* Disable and clear interrupts */
 	pt_core_disable_queue_interrupts(pt);
=20
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index e8bb4e7..ba23d50 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -53,6 +53,7 @@
 #define	CMD_QUEUE_PRIO_OFFSET		0x00
 #define	CMD_REQID_CONFIG_OFFSET		0x04
 #define	CMD_TIMEOUT_OFFSET		0x08
+#define	CMD_PT_VERSION			0x10
=20
 #define CMD_Q_CONTROL_BASE		0x0000
 #define CMD_Q_TAIL_LO_BASE		0x0004
@@ -312,6 +313,10 @@ struct pt_cmd_queue {
 	/* Interrupt wait queue */
 	wait_queue_head_t int_queue;
 	unsigned int int_rcvd;
+
+	/* Per-queue Statistics */
+	unsigned long total_ops;
+	unsigned long total_pt_ops;
 } ____cacheline_aligned;
=20
 struct pt_device {
@@ -357,6 +362,12 @@ struct pt_device {
 	/* Suspend support */
 	unsigned int suspending;
 	wait_queue_head_t suspend_queue;
+
+	/* Device Statistics */
+	unsigned long total_interrupts;
+
+	/* DebugFS info */
+	struct dentry *debugfs_instance;
 };
=20
 struct pt_dma_info {
@@ -503,6 +514,9 @@ int pt_run_cmd(struct pt_cmd_queue *cmd_q, struct pt_cm=
d *cmd);
 int pt_dmaengine_register(struct pt_device *pt);
 void pt_dmaengine_unregister(struct pt_device *pt);
=20
+void ptdma_debugfs_setup(struct pt_device *pt);
+void ptdma_debugfs_destroy(void);
+
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
=20
--=20
2.7.4

