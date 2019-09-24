Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85065BC2AE
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 09:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438502AbfIXHcm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 03:32:42 -0400
Received: from mail-eopbgr700043.outbound.protection.outlook.com ([40.107.70.43]:45953
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438460AbfIXHcm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 03:32:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4Y8dfNW+3bh3G0+E1hta6YdeSRIj2GyzETKW9mx1k1KPBaVTtJqgCmzBKS/K0KXLHDM2r1C+TAN+zka1E5wmhmGZTHDzLXybMZ47ewMZWKWFdwATwFdqT5KPbxVODgPzgxo286YqaIOLUp7+iNh0+gjHTHSbcYHG2GOhHLvc+FPm9w80DVzCKiHKcC/OFpF7TiinK6JjNz/JWJKmHmOCyxAv/zMf4A4crKeYEwQiyWJpezQudlhibewY6aAsXIG+A1q7KmlaRbwXvclq+wwsM+Rz/blgstHkGLoFb6Ay4z6z6rVi/iD5LGVD2kl5CTrxSniqcjqHrRs9pa9pBv+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQuQdOX0gmr7KjhPKS/Nw1w6G/eyBUvz7TeHHH4ZVpE=;
 b=i0LUGF7OzZRzH583ZVfiFn0p/9keqqCgcjRw1xcvEUj6wqAUc34n7xbKkUsGAhNXt+ulN73XsHiN8z4o0QqyyearVwS3si4CHu6P3RlrUUEzZiz+89g8D3tBL8XFFQb4z9yKyHvaAINOcgukjPd807bmP5Ihmi5FRTHy4GYTNaJkgJ0HrGUh075bOVYRsJOmixs/u/ERuSz2znxtf+/Vl6GstO5DYkLfDjWjABhXJij/2S1ibxUNm3ejB03pnBkkUuhc1aBw+2Df4VTFsFrmfP3OzuUOy/RUVpt2E8b5kRcvm+aWIuVQuY89YHCK0q+tHGvDTzEPwyAe4OFxNsHEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQuQdOX0gmr7KjhPKS/Nw1w6G/eyBUvz7TeHHH4ZVpE=;
 b=KYvTwDO5iXLZKu8cCk7q2g8nS2kPYJM6/A0ssIAk0KchW3gbGkO4ik1zromC2G5bpuXUMu3rbyhZ68A3BQTEB+mZMM+UIY3uTnHj6sH64gUKx//G5h/M5PVYBu8iy0l7FckkE4Xwxn74zC/SQTA7g0Qu7Tr90+b5d7pevI54gCw=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3359.namprd12.prod.outlook.com (20.178.243.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:32:32 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:32:32 +0000
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
Subject: [PATCH 3/4] dmaengine: Register as a DMA resource
Thread-Topic: [PATCH 3/4] dmaengine: Register as a DMA resource
Thread-Index: AQHVcqo6pilHx0YAekuNM/A872tNBQ==
Date:   Tue, 24 Sep 2019 07:32:32 +0000
Message-ID: <1569310332-29232-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::16) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 370ec222-0a1b-499e-a04c-08d740c15c7b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3359;
x-ms-traffictypediagnostic: MN2PR12MB3359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB335975A919225EAF404568B3E5840@MN2PR12MB3359.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:252;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(189003)(199004)(3846002)(6116002)(476003)(14454004)(478600001)(102836004)(25786009)(7736002)(2201001)(256004)(99286004)(186003)(2501003)(6506007)(14444005)(2616005)(305945005)(30864003)(4326008)(54906003)(66946007)(6512007)(86362001)(6436002)(5660300002)(7416002)(2906002)(66066001)(386003)(110136005)(6486002)(71190400001)(71200400001)(66476007)(8676002)(64756008)(52116002)(66446008)(66556008)(26005)(50226002)(486006)(36756003)(81166006)(316002)(8936002)(81156014)(921003)(1121003)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3359;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XEfk9mDT96ym340rs36M5k8JiS334QoVO/Jk6xQRbpDAFrBQMb0yVgNA7i2g+PzkZgZmA+Hfx143EFyZiMZBTIQYdFPH1rTfdPOXmx6jNAl6XWQS1QjJwFj6LD6HiqfzSw7kh31Pml62a/JyBWO1JM4Z47qEiRawrcTpqIfx2BVcmBQf8jJq483N91Y0S4rz3/qTK1pV+5IDq3LZ7AUhlmDnTpQblc1+EkinjHntdT2QBy9Z55R0RK4yG+KljC5TcGtB1Ue2+Hl/svi34En+qChoFRoiafNxHUM510PVnHXZV6ZMYQNXylNitxpuG751Us3Quc/35Pk0F11QWc4GgGhpszoZcXf57sBsB4JR669t2iCe2ekK9C/oMYN7T7p4Bg9tLTafEqFO7jAufSzdyz3lHF3Napk10YHdo9j7aJA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370ec222-0a1b-499e-a04c-08d740c15c7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:32:32.6722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AHqbQ2vA8bKfpDZH4o/0T8hMBdV8dUTZg4u8IcxCmWh4SJZ/U1hwpwGfmyCfhDNqRD1efGXToTSMkdxlvDE9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3359
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This Registers the ptdma to Linux dmaengine
framework as general purpose DMA channels.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Rajesh Kumar <Rajesh1.Kumar@amd.com>
---
 drivers/dma/ptdma/Kconfig           |   1 +
 drivers/dma/ptdma/Makefile          |   3 +-
 drivers/dma/ptdma/ptdma-dev.c       |   8 +
 drivers/dma/ptdma/ptdma-dmaengine.c | 700 ++++++++++++++++++++++++++++++++=
++++
 drivers/dma/ptdma/ptdma.h           |  43 +++
 5 files changed, 754 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c

diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
index a373431..3954501 100644
--- a/drivers/dma/ptdma/Kconfig
+++ b/drivers/dma/ptdma/Kconfig
@@ -3,5 +3,6 @@ config AMD_PTDMA
 	tristate  "AMD Passthru DMA Engine"
 	default m
 	depends on X86_64 && PCI
+	select DMA_ENGINE
 	help
 	  Provides the support for AMD Passthru DMA engine.
diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/ptdma/Makefile
index a5b4cef..5fc174a 100644
--- a/drivers/dma/ptdma/Makefile
+++ b/drivers/dma/ptdma/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_AMD_PTDMA) +=3D ptdma.o
=20
 ptdma-objs :=3D ptdma-ops.o \
-	      ptdma-dev.o
+	      ptdma-dev.o \
+	      ptdma-dmaengine.o
=20
 ptdma-$(CONFIG_PCI) +=3D ptdma-pci.o
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index e69999b..1a7a982 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -357,6 +357,11 @@ int pt_core_init(struct pt_device *pt)
 	/* Put this on the unit list to make it available */
 	pt_add_device(pt);
=20
+	/* Register the DMA engine support */
+	ret =3D pt_dmaengine_register(pt);
+	if (ret)
+		goto e_kthread;
+
 	return 0;
=20
=20
@@ -382,6 +387,9 @@ void pt_core_destroy(struct pt_device *pt)
 	struct pt_cmd_queue *cmd_q =3D &pt->cmd_q;
 	struct pt_cmd *cmd;
=20
+	/* Unregister the DMA engine */
+	pt_dmaengine_unregister(pt);
+
 	/* Remove this device from the list of available units first */
 	pt_del_device(pt);
=20
diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-=
dmaengine.c
new file mode 100644
index 0000000..265cdaa
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -0,0 +1,700 @@
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
+#include "ptdma.h"
+#include "../dmaengine.h"
+
+#define PT_DMA_WIDTH(_mask)		\
+({					\
+	u64 mask =3D _mask + 1;		\
+	(mask =3D=3D 0) ? 64 : fls64(mask);	\
+})
+
+static void pt_free_cmd_resources(struct pt_device *pt,
+				   struct list_head *list)
+{
+	struct pt_dma_cmd *cmd, *ctmp;
+
+	list_for_each_entry_safe(cmd, ctmp, list, entry) {
+		list_del(&cmd->entry);
+		kmem_cache_free(pt->dma_cmd_cache, cmd);
+	}
+}
+
+static void pt_free_desc_resources(struct pt_device *pt,
+				    struct list_head *list)
+{
+	struct pt_dma_desc *desc, *dtmp;
+
+	list_for_each_entry_safe(desc, dtmp, list, entry) {
+		pt_free_cmd_resources(pt, &desc->active);
+		pt_free_cmd_resources(pt, &desc->pending);
+
+		list_del(&desc->entry);
+		kmem_cache_free(pt->dma_desc_cache, desc);
+	}
+}
+
+static void pt_free_chan_resources(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan =3D container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	unsigned long flags;
+
+	dev_dbg(chan->pt->dev, "%s - chan=3D%p\n", __func__, chan);
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	pt_free_desc_resources(chan->pt, &chan->complete);
+	pt_free_desc_resources(chan->pt, &chan->active);
+	pt_free_desc_resources(chan->pt, &chan->pending);
+	pt_free_desc_resources(chan->pt, &chan->created);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+static void pt_cleanup_desc_resources(struct pt_device *pt,
+				       struct list_head *list)
+{
+	struct pt_dma_desc *desc, *dtmp;
+
+	list_for_each_entry_safe_reverse(desc, dtmp, list, entry) {
+		if (!async_tx_test_ack(&desc->tx_desc))
+			continue;
+
+		dev_dbg(pt->dev, "%s - desc=3D%p\n", __func__, desc);
+
+		pt_free_cmd_resources(pt, &desc->active);
+		pt_free_cmd_resources(pt, &desc->pending);
+
+		list_del(&desc->entry);
+		kmem_cache_free(pt->dma_desc_cache, desc);
+	}
+}
+
+static void pt_do_cleanup(unsigned long data)
+{
+	struct pt_dma_chan *chan =3D (struct pt_dma_chan *)data;
+	unsigned long flags;
+
+	dev_dbg(chan->pt->dev, "%s - chan=3D%s\n", __func__,
+		dma_chan_name(&chan->dma_chan));
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	pt_cleanup_desc_resources(chan->pt, &chan->complete);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+static int pt_issue_next_cmd(struct pt_dma_desc *desc)
+{
+	struct pt_dma_cmd *cmd;
+	int ret;
+
+	cmd =3D list_first_entry(&desc->pending, struct pt_dma_cmd, entry);
+	list_move(&cmd->entry, &desc->active);
+
+	dev_dbg(desc->pt->dev, "%s - tx %d, cmd=3D%p\n", __func__,
+		desc->tx_desc.cookie, cmd);
+
+	ret =3D pt_enqueue_cmd(&cmd->pt_cmd);
+	if (!ret || (ret =3D=3D -EINPROGRESS) || (ret =3D=3D -EBUSY))
+		return 0;
+
+	dev_dbg(desc->pt->dev, "%s - error: ret=3D%d, tx %d, cmd=3D%p\n", __func_=
_,
+		ret, desc->tx_desc.cookie, cmd);
+
+	return ret;
+}
+
+static void pt_free_active_cmd(struct pt_dma_desc *desc)
+{
+	struct pt_dma_cmd *cmd;
+
+	cmd =3D list_first_entry_or_null(&desc->active, struct pt_dma_cmd,
+				       entry);
+	if (!cmd)
+		return;
+
+	dev_dbg(desc->pt->dev, "%s - freeing tx %d cmd=3D%p\n",
+		__func__, desc->tx_desc.cookie, cmd);
+
+	list_del(&cmd->entry);
+	kmem_cache_free(desc->pt->dma_cmd_cache, cmd);
+}
+
+static struct pt_dma_desc *__pt_next_dma_desc(struct pt_dma_chan *chan,
+						struct pt_dma_desc *desc)
+{
+	/* Move current DMA descriptor to the complete list */
+	if (desc)
+		list_move(&desc->entry, &chan->complete);
+
+	/* Get the next DMA descriptor on the active list */
+	desc =3D list_first_entry_or_null(&chan->active, struct pt_dma_desc,
+					entry);
+
+	return desc;
+}
+
+static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
+						   struct pt_dma_desc *desc)
+{
+	struct dma_async_tx_descriptor *tx_desc;
+	unsigned long flags;
+
+	/* Loop over descriptors until one is found with commands */
+	do {
+		if (desc) {
+			/* Remove the DMA command from the list and free it */
+			pt_free_active_cmd(desc);
+
+			if (!list_empty(&desc->pending)) {
+				/* No errors, keep going */
+				if (desc->status !=3D DMA_ERROR)
+					return desc;
+
+				/* Error, free remaining commands and move on */
+				pt_free_cmd_resources(desc->pt,
+						       &desc->pending);
+			}
+
+			tx_desc =3D &desc->tx_desc;
+		} else {
+			tx_desc =3D NULL;
+		}
+
+		spin_lock_irqsave(&chan->lock, flags);
+
+		if (desc) {
+			if (desc->status !=3D DMA_ERROR)
+				desc->status =3D DMA_COMPLETE;
+
+			dev_dbg(desc->pt->dev,
+				"%s - tx %d complete, status=3D%u\n", __func__,
+				desc->tx_desc.cookie, desc->status);
+
+			dma_cookie_complete(tx_desc);
+			dma_descriptor_unmap(tx_desc);
+		}
+
+		desc =3D __pt_next_dma_desc(chan, desc);
+
+		spin_unlock_irqrestore(&chan->lock, flags);
+
+		if (tx_desc) {
+			dmaengine_desc_get_callback_invoke(tx_desc, NULL);
+
+			dma_run_dependencies(tx_desc);
+		}
+	} while (desc);
+
+	return NULL;
+}
+
+static struct pt_dma_desc *__pt_pending_to_active(struct pt_dma_chan *chan=
)
+{
+	struct pt_dma_desc *desc;
+
+	if (list_empty(&chan->pending))
+		return NULL;
+
+	desc =3D list_empty(&chan->active)
+		? list_first_entry(&chan->pending, struct pt_dma_desc, entry)
+		: NULL;
+
+	list_splice_tail_init(&chan->pending, &chan->active);
+
+	return desc;
+}
+
+static void pt_cmd_callback(void *data, int err)
+{
+	struct pt_dma_desc *desc =3D data;
+	struct pt_dma_chan *chan;
+	int ret;
+
+	if (err =3D=3D -EINPROGRESS)
+		return;
+
+	chan =3D container_of(desc->tx_desc.chan, struct pt_dma_chan,
+			    dma_chan);
+
+	dev_dbg(chan->pt->dev, "%s - tx %d callback, err=3D%d\n",
+		__func__, desc->tx_desc.cookie, err);
+
+	if (err)
+		desc->status =3D DMA_ERROR;
+
+	while (true) {
+		/* Check for DMA descriptor completion */
+		desc =3D pt_handle_active_desc(chan, desc);
+
+		/* Don't submit cmd if no descriptor or DMA is paused */
+		if (!desc || (chan->status =3D=3D DMA_PAUSED))
+			break;
+
+		ret =3D pt_issue_next_cmd(desc);
+		if (!ret)
+			break;
+
+		desc->status =3D DMA_ERROR;
+	}
+
+	tasklet_schedule(&chan->cleanup_tasklet);
+}
+
+static dma_cookie_t pt_tx_submit(struct dma_async_tx_descriptor *tx_desc)
+{
+	struct pt_dma_desc *desc =3D container_of(tx_desc, struct pt_dma_desc,
+						 tx_desc);
+	struct pt_dma_chan *chan;
+	dma_cookie_t cookie;
+	unsigned long flags;
+
+	chan =3D container_of(tx_desc->chan, struct pt_dma_chan, dma_chan);
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	cookie =3D dma_cookie_assign(tx_desc);
+	list_del(&desc->entry);
+	list_add_tail(&desc->entry, &chan->pending);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	dev_dbg(chan->pt->dev, "%s - added tx descriptor %d to pending list\n",
+		__func__, cookie);
+
+	return cookie;
+}
+
+static struct pt_dma_cmd *pt_alloc_dma_cmd(struct pt_dma_chan *chan)
+{
+	struct pt_dma_cmd *cmd;
+
+	cmd =3D kmem_cache_zalloc(chan->pt->dma_cmd_cache, GFP_NOWAIT);
+
+	return cmd;
+}
+
+static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
+					       unsigned long flags)
+{
+	struct pt_dma_desc *desc;
+
+	desc =3D kmem_cache_zalloc(chan->pt->dma_desc_cache, GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	dma_async_tx_descriptor_init(&desc->tx_desc, &chan->dma_chan);
+	desc->tx_desc.flags =3D flags;
+	desc->tx_desc.tx_submit =3D pt_tx_submit;
+	desc->pt =3D chan->pt;
+	INIT_LIST_HEAD(&desc->pending);
+	INIT_LIST_HEAD(&desc->active);
+	desc->status =3D DMA_IN_PROGRESS;
+
+	return desc;
+}
+
+static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
+					    struct scatterlist *dst_sg,
+					    unsigned int dst_nents,
+					    struct scatterlist *src_sg,
+					    unsigned int src_nents,
+					    unsigned long flags)
+{
+	struct pt_dma_chan *chan =3D container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	struct pt_device *pt =3D chan->pt;
+	struct pt_dma_desc *desc;
+	struct pt_dma_cmd *cmd;
+	struct pt_cmd *pt_cmd;
+	struct pt_passthru_engine *pt_engine;
+	unsigned int src_offset, src_len;
+	unsigned int dst_offset, dst_len;
+	unsigned int len;
+	unsigned long sflags;
+	size_t total_len;
+
+	if (!dst_sg || !src_sg)
+		return NULL;
+
+	if (!dst_nents || !src_nents)
+		return NULL;
+
+	desc =3D pt_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	total_len =3D 0;
+
+	src_len =3D sg_dma_len(src_sg);
+	src_offset =3D 0;
+
+	dst_len =3D sg_dma_len(dst_sg);
+	dst_offset =3D 0;
+
+	while (true) {
+		if (!src_len) {
+			src_nents--;
+			if (!src_nents)
+				break;
+
+			src_sg =3D sg_next(src_sg);
+			if (!src_sg)
+				break;
+
+			src_len =3D sg_dma_len(src_sg);
+			src_offset =3D 0;
+			continue;
+		}
+
+		if (!dst_len) {
+			dst_nents--;
+			if (!dst_nents)
+				break;
+
+			dst_sg =3D sg_next(dst_sg);
+			if (!dst_sg)
+				break;
+
+			dst_len =3D sg_dma_len(dst_sg);
+			dst_offset =3D 0;
+			continue;
+		}
+
+		len =3D min(dst_len, src_len);
+
+		cmd =3D pt_alloc_dma_cmd(chan);
+		if (!cmd)
+			goto err;
+
+		pt_cmd =3D &cmd->pt_cmd;
+		pt_cmd->pt =3D chan->pt;
+		pt_engine =3D &pt_cmd->passthru;
+		pt_cmd->flags =3D PT_CMD_MAY_BACKLOG;
+		pt_cmd->engine =3D PT_ENGINE_PASSTHRU;
+		pt_engine->bit_mod =3D PT_PASSTHRU_BITWISE_NOOP;
+		pt_engine->byte_swap =3D PT_PASSTHRU_BYTESWAP_NOOP;
+		pt_engine->src_dma =3D sg_dma_address(src_sg) + src_offset;
+		pt_engine->dst_dma =3D sg_dma_address(dst_sg) + dst_offset;
+		pt_engine->src_len =3D len;
+		pt_engine->final =3D 1;
+		pt_cmd->callback =3D pt_cmd_callback;
+		pt_cmd->data =3D desc;
+
+		list_add_tail(&cmd->entry, &desc->pending);
+
+		dev_dbg(pt->dev,
+			"%s - cmd=3D%p, src=3D%pad, dst=3D%pad, len=3D%llu\n", __func__,
+			cmd, &pt_engine->src_dma,
+			&pt_engine->dst_dma, pt_engine->src_len);
+
+		total_len +=3D len;
+
+		src_len -=3D len;
+		src_offset +=3D len;
+
+		dst_len -=3D len;
+		dst_offset +=3D len;
+	}
+
+	desc->len =3D total_len;
+
+	if (list_empty(&desc->pending))
+		goto err;
+
+	dev_dbg(pt->dev, "%s - desc=3D%p\n", __func__, desc);
+
+	spin_lock_irqsave(&chan->lock, sflags);
+
+	list_add_tail(&desc->entry, &chan->created);
+
+	spin_unlock_irqrestore(&chan->lock, sflags);
+
+	return desc;
+
+err:
+	pt_free_cmd_resources(pt, &desc->pending);
+	kmem_cache_free(pt->dma_desc_cache, desc);
+
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *pt_prep_dma_memcpy(
+	struct dma_chan *dma_chan, dma_addr_t dst, dma_addr_t src, size_t len,
+	unsigned long flags)
+{
+	struct pt_dma_chan *chan =3D container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	struct pt_dma_desc *desc;
+	struct scatterlist dst_sg, src_sg;
+
+	dev_dbg(chan->pt->dev,
+		"%s - src=3D%pad, dst=3D%pad, len=3D%zu, flags=3D%#lx\n",
+		__func__, &src, &dst, len, flags);
+
+	sg_init_table(&dst_sg, 1);
+	sg_dma_address(&dst_sg) =3D dst;
+	sg_dma_len(&dst_sg) =3D len;
+
+	sg_init_table(&src_sg, 1);
+	sg_dma_address(&src_sg) =3D src;
+	sg_dma_len(&src_sg) =3D len;
+
+	desc =3D pt_create_desc(dma_chan, &dst_sg, 1, &src_sg, 1, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->tx_desc;
+}
+
+static struct dma_async_tx_descriptor *pt_prep_dma_interrupt(
+	struct dma_chan *dma_chan, unsigned long flags)
+{
+	struct pt_dma_chan *chan =3D container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	struct pt_dma_desc *desc;
+
+	desc =3D pt_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->tx_desc;
+}
+
+static void pt_issue_pending(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan =3D container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	struct pt_dma_desc *desc;
+	unsigned long flags;
+
+	dev_dbg(chan->pt->dev, "%s\n", __func__);
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	desc =3D __pt_pending_to_active(chan);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	/* If there was nothing active, start processing */
+	if (desc)
+		pt_cmd_callback(desc, 0);
+}
+
+static enum dma_status pt_tx_status(struct dma_chan *dma_chan,
+				     dma_cookie_t cookie,
+				     struct dma_tx_state *state)
+{
+	struct pt_dma_chan *chan =3D container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	struct pt_dma_desc *desc;
+	enum dma_status ret;
+	unsigned long flags;
+
+	if (chan->status =3D=3D DMA_PAUSED) {
+		ret =3D DMA_PAUSED;
+		goto out;
+	}
+
+	ret =3D dma_cookie_status(dma_chan, cookie, state);
+	if (ret =3D=3D DMA_COMPLETE) {
+		spin_lock_irqsave(&chan->lock, flags);
+
+		/* Get status from complete chain, if still there */
+		list_for_each_entry(desc, &chan->complete, entry) {
+			if (desc->tx_desc.cookie !=3D cookie)
+				continue;
+
+			ret =3D desc->status;
+			break;
+		}
+
+		spin_unlock_irqrestore(&chan->lock, flags);
+	}
+
+out:
+	dev_dbg(chan->pt->dev, "%s - %u\n", __func__, ret);
+
+	return ret;
+}
+
+static int pt_pause(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan =3D container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+
+	chan->status =3D DMA_PAUSED;
+
+	/*TODO: Wait for active DMA to complete before returning? */
+
+	return 0;
+}
+
+static int pt_resume(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan =3D container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	struct pt_dma_desc *desc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	desc =3D list_first_entry_or_null(&chan->active, struct pt_dma_desc,
+					entry);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	/* Indicate the channel is running again */
+	chan->status =3D DMA_IN_PROGRESS;
+
+	/* If there was something active, re-start */
+	if (desc)
+		pt_cmd_callback(desc, 0);
+
+	return 0;
+}
+
+static int pt_terminate_all(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan =3D container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	unsigned long flags;
+
+	dev_dbg(chan->pt->dev, "%s\n", __func__);
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	pt_free_desc_resources(chan->pt, &chan->active);
+	pt_free_desc_resources(chan->pt, &chan->pending);
+	pt_free_desc_resources(chan->pt, &chan->created);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return 0;
+}
+
+int pt_dmaengine_register(struct pt_device *pt)
+{
+	struct pt_dma_chan *chan;
+	struct dma_device *dma_dev =3D &pt->dma_dev;
+	struct dma_chan *dma_chan;
+	char *dma_cmd_cache_name;
+	char *dma_desc_cache_name;
+	int ret;
+
+	pt->pt_dma_chan =3D devm_kcalloc(pt->dev, 1,
+					 sizeof(*(pt->pt_dma_chan)),
+					 GFP_KERNEL);
+	if (!pt->pt_dma_chan)
+		return -ENOMEM;
+
+	dma_cmd_cache_name =3D devm_kasprintf(pt->dev, GFP_KERNEL,
+					    "%s-dmaengine-cmd-cache",
+					    pt->name);
+	if (!dma_cmd_cache_name)
+		return -ENOMEM;
+
+	pt->dma_cmd_cache =3D kmem_cache_create(dma_cmd_cache_name,
+					       sizeof(struct pt_dma_cmd),
+					       sizeof(void *),
+					       SLAB_HWCACHE_ALIGN, NULL);
+	if (!pt->dma_cmd_cache)
+		return -ENOMEM;
+
+	dma_desc_cache_name =3D devm_kasprintf(pt->dev, GFP_KERNEL,
+					     "%s-dmaengine-desc-cache",
+					     pt->name);
+	if (!dma_desc_cache_name) {
+		ret =3D -ENOMEM;
+		goto err_cache;
+	}
+
+	pt->dma_desc_cache =3D kmem_cache_create(dma_desc_cache_name,
+						sizeof(struct pt_dma_desc),
+						sizeof(void *),
+						SLAB_HWCACHE_ALIGN, NULL);
+	if (!pt->dma_desc_cache) {
+		ret =3D -ENOMEM;
+		goto err_cache;
+	}
+
+	dma_dev->dev =3D pt->dev;
+	dma_dev->src_addr_widths =3D PT_DMA_WIDTH(dma_get_mask(pt->dev));
+	dma_dev->dst_addr_widths =3D PT_DMA_WIDTH(dma_get_mask(pt->dev));
+	dma_dev->directions =3D DMA_MEM_TO_MEM;
+	dma_dev->residue_granularity =3D DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
+	dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
+	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
+
+	INIT_LIST_HEAD(&dma_dev->channels);
+
+	chan =3D pt->pt_dma_chan;
+	dma_chan =3D &chan->dma_chan;
+
+	chan->pt =3D pt;
+
+	spin_lock_init(&chan->lock);
+	INIT_LIST_HEAD(&chan->created);
+	INIT_LIST_HEAD(&chan->pending);
+	INIT_LIST_HEAD(&chan->active);
+	INIT_LIST_HEAD(&chan->complete);
+
+	tasklet_init(&chan->cleanup_tasklet, pt_do_cleanup,
+		     (unsigned long)chan);
+
+	dma_chan->device =3D dma_dev;
+	dma_cookie_init(dma_chan);
+
+	list_add_tail(&dma_chan->device_node, &dma_dev->channels);
+
+	dma_dev->device_free_chan_resources =3D pt_free_chan_resources;
+	dma_dev->device_prep_dma_memcpy =3D pt_prep_dma_memcpy;
+	dma_dev->device_prep_dma_interrupt =3D pt_prep_dma_interrupt;
+	dma_dev->device_issue_pending =3D pt_issue_pending;
+	dma_dev->device_tx_status =3D pt_tx_status;
+	dma_dev->device_pause =3D pt_pause;
+	dma_dev->device_resume =3D pt_resume;
+	dma_dev->device_terminate_all =3D pt_terminate_all;
+
+	ret =3D dma_async_device_register(dma_dev);
+	if (ret)
+		goto err_reg;
+
+	return 0;
+
+err_reg:
+	kmem_cache_destroy(pt->dma_desc_cache);
+
+err_cache:
+	kmem_cache_destroy(pt->dma_cmd_cache);
+
+	return ret;
+}
+
+void pt_dmaengine_unregister(struct pt_device *pt)
+{
+	struct dma_device *dma_dev =3D &pt->dma_dev;
+
+	dma_async_device_unregister(dma_dev);
+
+	kmem_cache_destroy(pt->dma_desc_cache);
+	kmem_cache_destroy(pt->dma_cmd_cache);
+}
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index 4e89517..e8bb4e7 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/wait.h>
 #include <linux/dmapool.h>
+#include <linux/dmaengine.h>
=20
 #define MAX_PT_NAME_LEN			16
 #define MAX_DMAPOOL_NAME_LEN		32
@@ -227,6 +228,39 @@ struct pt_cmd {
 	void *data;
 };
=20
+struct pt_dma_cmd {
+	struct list_head entry;
+	struct pt_cmd pt_cmd;
+};
+
+struct pt_dma_desc {
+	struct list_head entry;
+
+	struct pt_device *pt;
+
+	struct list_head pending;
+	struct list_head active;
+
+	enum dma_status status;
+	struct dma_async_tx_descriptor tx_desc;
+	size_t len;
+};
+
+struct pt_dma_chan {
+	struct pt_device *pt;
+
+	spinlock_t lock;
+	struct list_head created;
+	struct list_head pending;
+	struct list_head active;
+	struct list_head complete;
+
+	struct tasklet_struct cleanup_tasklet;
+
+	enum dma_status status;
+	struct dma_chan dma_chan;
+};
+
 struct pt_cmd_queue {
 	struct pt_device *pt;
=20
@@ -310,6 +344,12 @@ struct pt_device {
 	 */
 	struct pt_cmd_queue cmd_q;
=20
+	/* Support for the DMA Engine capabilities */
+	struct dma_device dma_dev;
+	struct pt_dma_chan *pt_dma_chan;
+	struct kmem_cache *dma_cmd_cache;
+	struct kmem_cache *dma_desc_cache;
+
 	wait_queue_head_t lsb_queue;
 	unsigned int lsb_count;
 	u32 lsb_start;
@@ -460,6 +500,9 @@ int pt_cmd_queue_thread(void *data);
=20
 int pt_run_cmd(struct pt_cmd_queue *cmd_q, struct pt_cmd *cmd);
=20
+int pt_dmaengine_register(struct pt_device *pt);
+void pt_dmaengine_unregister(struct pt_device *pt);
+
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
=20
--=20
2.7.4

