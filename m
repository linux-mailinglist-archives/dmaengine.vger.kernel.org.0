Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0CBC2B1
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 09:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438585AbfIXHcn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 03:32:43 -0400
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:6779
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438461AbfIXHcm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 03:32:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThzAvW9KVGW8iCmFpgU47fzKd+EjpO9MLbOzlBpmE1s+nd6krxR23+2WoLRCbROOY6SeGLRxykfPt2mYGJo4tkqM+yu/KjL1ck1RsHx+PGMiKKx8EhuchVbqtBi5I6x+vQr66G1OQKxehJIC07oJvvm83aD8LtlRAb0HVFH34Tw18ImkhIFxiIiLK66Ond2hxSOlJeDimNQbwJ1gc0ebS1N7PMvDwC1YjmAVwr32i5bUAi2AdsK++r8J7pM/KfL4TJ6UMb+KIG+SSFUagjScItDThHAEJwqiwGTs9ZeqNE7NPE0sWbeg+cLQ3ySZk5NY6Sm5tRTQQfyAV6DP8Xdkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op651GlNrF8E/aJjc2jlphUzODSbeA30QyKeJjFR/TM=;
 b=Bh/5cukFde2gxZymFdWn1wmr9imry/p1NbqF2hDrfFC2SOzu+xvhAMgaDsgNpN2byvJWF/tUub+1DkcX9Fk4MCopuToWna6Xl4VJLpz2vv2tq4nKuGVN9xUy3ogRJcpfUB3ulqDlgz+POcBnQogXL2ZHIKyox2uLZvjtsYV8+iW6aYVWnCeOFBi2Xy/zFkcyBQr3XXi2dfLOehW+Qu0SfeJkajB29MunxqufKJ53l95QH7ZP+Gnh4yVK1M01ISbpA4p6GAwhEe4K4Zy4ENrIWjA/2vkv7v89VyJxeyThw5dV0yKQyx9QKkH3g8br+8qtnqcUkyDBDikwAyFXSDOeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op651GlNrF8E/aJjc2jlphUzODSbeA30QyKeJjFR/TM=;
 b=wc6PbA14jiPGZL9iG8EFqtG0WgDIzQniGEQifjuT39y2UV4Yv0+u3vRt9xK5AuGURVt23/opUKEBJdOk3e6/psirXj799jNLGBlni2d9qRILWUZvdHGsBnig6NDtG7pes/vtfbmp8FINnT/Z70FxdzEUGmgUGqntpSDSrXB5cMA=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3007.namprd12.prod.outlook.com (20.178.244.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:32:04 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:32:04 +0000
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
Subject: [PATCH 2/4] dma: Support for multiple PTDMA
Thread-Topic: [PATCH 2/4] dma: Support for multiple PTDMA
Thread-Index: AQHVcqootptACWnc5EmUuX46Z1lL4A==
Date:   Tue, 24 Sep 2019 07:32:03 +0000
Message-ID: <1569310303-29192-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::32) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9428b692-b86a-4cd9-2b56-08d740c14b4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3007;
x-ms-traffictypediagnostic: MN2PR12MB3007:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3007CDCB259209F52D53755EE5840@MN2PR12MB3007.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(110136005)(186003)(99286004)(52116002)(7736002)(6506007)(305945005)(50226002)(66476007)(4326008)(478600001)(2501003)(66946007)(66556008)(66446008)(64756008)(86362001)(386003)(2201001)(6436002)(6486002)(71190400001)(71200400001)(54906003)(6512007)(5660300002)(25786009)(6116002)(3846002)(14454004)(36756003)(14444005)(256004)(81156014)(8676002)(486006)(7416002)(8936002)(81166006)(476003)(2616005)(66066001)(316002)(26005)(102836004)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3007;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i5PuE/8T64yd8tBzTJrrxSnKlwnBOTk/mO33T9FbO3C/8Xjw7iQMtDc4gOgsVdOodTzk/3XgkWhh1yldWdOTzGOFRZAsc1wEuBX1+aBgHURZYwFb0rVSeeHdI2RORHSA+TjKPWRS9w1JOgNo8Qlkeutkxk9P7RPTsqDhAFcKdZ+7TaMKS/UK9rE2s8ta/2CW3/m8UN8mtwugIXApoL/FBDx1dH3bjRzkrnr7/qmj9980vSWXIpWhqZ+ujFtgiRf53UpsFvv73JpQBZG3Bf4NatrdS3UPrzU83DrMLkYP3RSkUmOe8iec72jFNuzZbMmg6cqZo6z/gH2zSj05ChCxLG7q4Q0/5za5nybEvHq+rQcyWmaX3wm3bnYQexsjoXph4x/+JxfK08RGmmeJsEh/efb75O0wat1WnxOr07waxmk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9428b692-b86a-4cd9-2b56-08d740c14b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:32:03.8556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZ3wYbfDGcIQTuMpVR2aDzchJSVQwDd0yCwjZ2xcNOVW9XXmvRh037hrchWZ9ZZogKWMjl0ouC9mDv4cYr/iJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3007
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Enable management of multiple PTDMA engine in a system.
Each device will get a unique identifier, as well as
uniquely named resources. Treat each PTDMA as an orthogonal
unit and register resources individually.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Rajesh Kumar <Rajesh1.Kumar@amd.com>
---
 drivers/dma/ptdma/ptdma-dev.c |   7 +--
 drivers/dma/ptdma/ptdma-ops.c | 111 ++++++++++++++++++++++++++++++++++++++=
----
 drivers/dma/ptdma/ptdma.h     |   5 ++
 3 files changed, 110 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index ce3e85d..e69999b 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -245,7 +245,7 @@ int pt_core_init(struct pt_device *pt)
 	iowrite32(CMD_CONFIG_REQID, pt->io_regs + CMD_REQID_CONFIG_OFFSET);
=20
 	/* Allocate a dma pool for the queue */
-	snprintf(dma_pool_name, sizeof(dma_pool_name), "pt_q");
+	snprintf(dma_pool_name, sizeof(dma_pool_name), "%s_q", pt->name);
 	dma_pool =3D dma_pool_create(dma_pool_name, dev,
 				   PT_DMAPOOL_MAX_SIZE,
 				   PT_DMAPOOL_ALIGN, 0);
@@ -311,7 +311,7 @@ int pt_core_init(struct pt_device *pt)
=20
 	dev_dbg(dev, "Requesting an IRQ...\n");
 	/* Request an irq */
-	ret =3D request_irq(pt->pt_irq, pt_core_irq_handler, 0, "pt", pt);
+	ret =3D request_irq(pt->pt_irq, pt_core_irq_handler, 0, pt->name, pt);
 	if (ret) {
 		dev_err(dev, "unable to allocate an IRQ\n");
 		goto e_pool;
@@ -338,7 +338,8 @@ int pt_core_init(struct pt_device *pt)
 	dev_dbg(dev, "Starting threads...\n");
 	/* Create a kthread for command queue */
=20
-	kthread =3D kthread_create(pt_cmd_queue_thread, cmd_q, "pt-q");
+	kthread =3D kthread_create(pt_cmd_queue_thread, cmd_q,
+				 "%s-q", pt->name);
 	if (IS_ERR(kthread)) {
 		dev_err(dev, "error creating queue thread (%ld)\n",
 			PTR_ERR(kthread));
diff --git a/drivers/dma/ptdma/ptdma-ops.c b/drivers/dma/ptdma/ptdma-ops.c
index ca94802..0c3023a 100644
--- a/drivers/dma/ptdma/ptdma-ops.c
+++ b/drivers/dma/ptdma/ptdma-ops.c
@@ -20,13 +20,16 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
+#include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
=20
 #include "ptdma.h"
=20
-static struct pt_device *pt_dev;
+/* Ever-increasing value to produce unique unit numbers */
+static atomic_t pt_ordinal;
=20
 struct pt_tasklet_data {
 	struct completion completion;
@@ -63,24 +66,105 @@ static char *pt_error_codes[] =3D {
 	"ERR 43: LSB_PARITY_ERR",
 };
=20
-static inline struct pt_device *pt_get_device(void)
+void pt_log_error(struct pt_device *d, int e)
 {
-	return pt_dev;
+	dev_err(d->dev, "PTDMA error: %s (0x%x)\n", pt_error_codes[e], e);
 }
=20
+/* List of PTDMAs, PTDMA count, read-write access lock, and access functio=
ns
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
+/* Round-robin counter */
+static DEFINE_SPINLOCK(pt_rr_lock);
+static struct pt_device *pt_rr;
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
 void pt_add_device(struct pt_device *pt)
 {
-	pt_dev =3D pt;
+	unsigned long flags;
+
+	write_lock_irqsave(&pt_unit_lock, flags);
+	list_add_tail(&pt->entry, &pt_units);
+	if (!pt_rr)
+		/* We already have the list lock (we're first) so this
+		 * pointer can't change on us. Set its initial value.
+		 */
+		pt_rr =3D pt;
+	write_unlock_irqrestore(&pt_unit_lock, flags);
 }
=20
+/*
+ * pt_del_device - remove a PTDMA device from the list
+ *
+ * @pt: pt_device struct pointer
+ *
+ * Remove this unit from the list of devices. If the next device
+ * up for use is this one, adjust the pointer. If this is the last
+ * device, NULL the pointer.
+ */
 void pt_del_device(struct pt_device *pt)
 {
-	pt_dev =3D NULL;
+	unsigned long flags;
+
+	write_lock_irqsave(&pt_unit_lock, flags);
+	if (pt_rr =3D=3D pt) {
+		/* pt_unit_lock is read/write; any read access
+		 * will be suspended while we make changes to the
+		 * list and RR pointer.
+		 */
+		if (list_is_last(&pt_rr->entry, &pt_units))
+			pt_rr =3D list_first_entry(&pt_units, struct pt_device,
+						  entry);
+		else
+			pt_rr =3D list_next_entry(pt_rr, entry);
+	}
+	list_del(&pt->entry);
+	if (list_empty(&pt_units))
+		pt_rr =3D NULL;
+	write_unlock_irqrestore(&pt_unit_lock, flags);
 }
=20
-void pt_log_error(struct pt_device *d, int e)
+static struct pt_device *pt_get_device(void)
 {
-	dev_err(d->dev, "PTDMA error: %s (0x%x)\n", pt_error_codes[e], e);
+	unsigned long flags;
+	struct pt_device *dp =3D NULL;
+
+	/* We round-robin through the unit list.
+	 * The (pt_rr) pointer refers to the next unit to use.
+	 */
+	read_lock_irqsave(&pt_unit_lock, flags);
+	if (!list_empty(&pt_units)) {
+		spin_lock(&pt_rr_lock);
+		dp =3D pt_rr;
+		if (list_is_last(&pt_rr->entry, &pt_units))
+			pt_rr =3D list_first_entry(&pt_units, struct pt_device,
+						  entry);
+		else
+			pt_rr =3D list_next_entry(pt_rr, entry);
+		spin_unlock(&pt_rr_lock);
+	}
+	read_unlock_irqrestore(&pt_unit_lock, flags);
+
+	return dp;
 }
=20
 /*
@@ -90,10 +174,14 @@ void pt_log_error(struct pt_device *d, int e)
  */
 int pt_present(void)
 {
-	if (pt_get_device())
-		return 0;
+	unsigned long flags;
+	int ret;
+
+	read_lock_irqsave(&pt_unit_lock, flags);
+	ret =3D list_empty(&pt_units);
+	read_unlock_irqrestore(&pt_unit_lock, flags);
=20
-	return -ENODEV;
+	return ret ? -ENODEV : 0;
 }
=20
 /*
@@ -286,6 +374,7 @@ struct pt_device *pt_alloc_struct(struct device *dev)
 	if (!pt)
 		return NULL;
 	pt->dev =3D dev;
+	pt->ord =3D atomic_inc_return(&pt_ordinal);
=20
 	INIT_LIST_HEAD(&pt->cmd);
 	INIT_LIST_HEAD(&pt->backlog);
@@ -298,6 +387,8 @@ struct pt_device *pt_alloc_struct(struct device *dev)
 	init_waitqueue_head(&pt->lsb_queue);
 	init_waitqueue_head(&pt->suspend_queue);
=20
+	snprintf(pt->name, MAX_PT_NAME_LEN, "pt-%u", pt->ord);
+
 	return pt;
 }
=20
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index 75b8e25..4e89517 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -26,6 +26,7 @@
 #include <linux/wait.h>
 #include <linux/dmapool.h>
=20
+#define MAX_PT_NAME_LEN			16
 #define MAX_DMAPOOL_NAME_LEN		32
=20
 #define MAX_HW_QUEUES			1
@@ -280,7 +281,11 @@ struct pt_cmd_queue {
 } ____cacheline_aligned;
=20
 struct pt_device {
+	struct list_head entry;
+
 	unsigned int version;
+	unsigned int ord;
+	char name[MAX_PT_NAME_LEN];
=20
 	struct device *dev;
=20
--=20
2.7.4

