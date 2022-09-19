Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BCF5BD6A6
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 23:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiISV4G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 17:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiISV4E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 17:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5938452
        for <dmaengine@vger.kernel.org>; Mon, 19 Sep 2022 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663624561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cYvxKc5DlaYhK9l6PE82liKF9DEhv340Jc5UQRPm/Ms=;
        b=QEAXCL+CRJ0UTu0U2G0ndXs/3ZhUjU7Cqpz0oFe7nc/iBa2DTb9CdFk+jZoEPKpNAufjI+
        SrbG4f480aue1by9iuw6ga7jBKmIIhKBYfXYwRR1teHM0r/T33xkt7xQW7eDyLdlFDcNa6
        nVtvzNwrVGj4+Al3wMW2n8LgURFSiks=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-9IlhLMZVNI2wO58mAxm7uQ-1; Mon, 19 Sep 2022 17:55:57 -0400
X-MC-Unique: 9IlhLMZVNI2wO58mAxm7uQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EAA5382578E;
        Mon, 19 Sep 2022 21:55:57 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E80940C2064;
        Mon, 19 Sep 2022 21:55:56 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 2/2] dmaengine: idxd: track enabled workqueues in bitmap
Date:   Mon, 19 Sep 2022 14:55:53 -0700
Message-Id: <20220919215553.600246-3-jsnitsel@redhat.com>
In-Reply-To: <20220919215553.600246-1-jsnitsel@redhat.com>
References: <20220919215553.600246-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
 drivers/dma/idxd/device.c | 2 ++
 drivers/dma/idxd/idxd.h   | 2 ++
 drivers/dma/idxd/init.c   | 6 ++++++
 drivers/dma/idxd/irq.c    | 4 ++--
 drivers/dma/idxd/sysfs.c  | 1 +
 5 files changed, 13 insertions(+), 2 deletions(-)

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
index 743ead5ebc57..8efaf137fc65 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -49,9 +49,9 @@ static void idxd_device_reinit(struct work_struct *work)
 		goto out;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = idxd->wqs[i];
+		if (test_bit(i, idxd->wq_enable_map)) {
+			struct idxd_wq *wq = idxd->wqs[i];
 
-		if (wq->state == IDXD_WQ_ENABLED) {
 			rc = idxd_wq_enable(wq);
 			if (rc < 0) {
 				dev_warn(dev, "Unable to re-enable wq %s\n",
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

