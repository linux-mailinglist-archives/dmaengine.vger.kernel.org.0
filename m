Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80E35EE0D6
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiI1PtJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 11:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiI1PtH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 11:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C456DB94A
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664380143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8iXSt8WzWBUtnBIXzMF8YQXU9I0wokZDuZdEFFhaww=;
        b=YM+Ow3Crvcim7ibByAPBkwDhYa3BkIehixMsB7DhgawIro9eoexKfFimKhVvpKH2aXyf9q
        LRrNjaG+aLu0MkODKVOP3wSvKWf3UtHu1iZLeAHeAA7IN+CxdkjDZ/AA4XSazohwoTL8VC
        B5pKsXZQllQsVseQqKdTpxPG+VSsoik=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-nwHbtGnTMD-JfeoH6EyjUA-1; Wed, 28 Sep 2022 11:49:00 -0400
X-MC-Unique: nwHbtGnTMD-JfeoH6EyjUA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A738382C965;
        Wed, 28 Sep 2022 15:49:00 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.17.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89D33492B04;
        Wed, 28 Sep 2022 15:48:59 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 2/2] dmaengine: idxd: track enabled workqueues in bitmap
Date:   Wed, 28 Sep 2022 08:48:56 -0700
Message-Id: <20220928154856.623545-3-jsnitsel@redhat.com>
In-Reply-To: <20220928154856.623545-1-jsnitsel@redhat.com>
References: <20220928154856.623545-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Now that idxd_wq_disable_cleanup() sets the workqueue state to
IDXD_WQ_DISABLED, use a bitmap to track which workqueues have been
enabled. This will then be used to determine which workqueues
should be re-enabled when attempting a software reset to recover
from a device halt state.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
v2: Clear bit in case where idxd_wq_enable fails during re-init

 drivers/dma/idxd/device.c | 2 ++
 drivers/dma/idxd/idxd.h   | 2 ++
 drivers/dma/idxd/init.c   | 6 ++++++
 drivers/dma/idxd/irq.c    | 5 +++--
 drivers/dma/idxd/sysfs.c  | 1 +
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 31911e255ac1..f0c7d6d348e3 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -196,6 +196,7 @@ int idxd_wq_enable(struct idxd_wq *wq)
 	}
 
 	wq->state = IDXD_WQ_ENABLED;
+	set_bit(wq->id, idxd->wq_enable_map);
 	dev_dbg(dev, "WQ %d enabled\n", wq->id);
 	return 0;
 }
@@ -223,6 +224,7 @@ int idxd_wq_disable(struct idxd_wq *wq, bool reset_config)
 
 	if (reset_config)
 		idxd_wq_disable_cleanup(wq);
+	clear_bit(wq->id, idxd->wq_enable_map);
 	wq->state = IDXD_WQ_DISABLED;
 	dev_dbg(dev, "WQ %d disabled\n", wq->id);
 	return 0;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index fed0dfc1eaa8..f527a7f88b92 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <linux/ioasid.h>
+#include <linux/bitmap.h>
 #include <linux/perf_event.h>
 #include <uapi/linux/idxd.h>
 #include "registers.h"
@@ -299,6 +300,7 @@ struct idxd_device {
 	int rdbuf_limit;
 	int nr_rdbufs;		/* non-reserved read buffers */
 	unsigned int wqcfg_size;
+	unsigned long *wq_enable_map;
 
 	union sw_err_reg sw_err;
 	wait_queue_head_t cmd_waitq;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index aa3478257ddb..7e27e69ff741 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -151,6 +151,12 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	if (!idxd->wqs)
 		return -ENOMEM;
 
+	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
+	if (!idxd->wq_enable_map) {
+		kfree(idxd->wqs);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < idxd->max_wqs; i++) {
 		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
 		if (!wq) {
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 743ead5ebc57..3fcfbb7bf6e3 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -49,11 +49,12 @@ static void idxd_device_reinit(struct work_struct *work)
 		goto out;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = idxd->wqs[i];
+		if (test_bit(i, idxd->wq_enable_map)) {
+			struct idxd_wq *wq = idxd->wqs[i];
 
-		if (wq->state == IDXD_WQ_ENABLED) {
 			rc = idxd_wq_enable(wq);
 			if (rc < 0) {
+				clear_bit(i, idxd->wq_enable_map);
 				dev_warn(dev, "Unable to re-enable wq %s\n",
 					 dev_name(wq_confdev(wq)));
 			}
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 3f262a57441b..3325b16ed959 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1405,6 +1405,7 @@ static void idxd_conf_device_release(struct device *dev)
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	kfree(idxd->groups);
+	bitmap_free(idxd->wq_enable_map);
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
 	ida_free(&idxd_ida, idxd->id);
-- 
2.37.2

