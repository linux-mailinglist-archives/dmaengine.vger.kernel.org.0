Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA1AB76D5
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388956AbfISJ7W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 05:59:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36321 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388981AbfISJ7W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Sep 2019 05:59:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so2428413wrd.3;
        Thu, 19 Sep 2019 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hft77d490JmLJKBoVSy/JIsXGtbcCfU/LGbyPoVIByA=;
        b=rZZKFLDCapFlU80ainNSoDAgfwcgjxtyuMygbUNlZsz561pHZxC2Zo0GSrB7Xnn1vD
         yzh2JR9V9eHbUzIK73srLQ7j5qdm9ii9nPohC/UlMrydAmVBL+NhAJ7CNM1CYrpDWAQf
         XT+xHy/URBtGCiKd6rnD2ly8n1XIhqFupeQFhqZPp+arAmepzb7Hug7Bs7f1ZnzE41Av
         6X9tJ2UVPI/abPn0CAnw89J0emmUpk4RccwI3/KwbDrKsyIuqoGr4DIIt1F7q07+0olX
         80SoxMNtInRiwKCpEqGf1VZppZzNYuoxuwSYbkaC6dVDrE24ZXVpzH6YmcEmUc48z6sS
         dv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hft77d490JmLJKBoVSy/JIsXGtbcCfU/LGbyPoVIByA=;
        b=MSYpIJ0jvolTaOIj6lWnQI9NJz53pW4oXCitMp4c7hxkHoQenO7X8JpWieIBWMsq3/
         xChgBcIKFzH6VCEaUcDRbHFRv/17lmBJKh8ItEPfc7ZGJXEEe4JWl/m802FP02edPrAG
         KGQvMZtatQu5gYdO2o3sUqyLWveAFhHOOZpnyLK/Usq3jmBaV1U2QoFplrHt/ecN8ssk
         RUDcEwD2E3MfEw3yz3y3eaWZVYMF8PZV+lyMoCIk5Qdt5WiscnQPe/P9eqgjLzNpPJSi
         xZxWsSEsAwd5o2+lSiCJ17umSzau4F10Zk9guYBWsPtFcjaiQe85wIrFnvb4FF7eJ2Be
         qpIg==
X-Gm-Message-State: APjAAAUB7p/ht4MXXt9A429pXqD55zY1i1y1N56Z+iU+cWipxk3zprMv
        1wOiFMLdmoSrgCmZJTix8J18Crij
X-Google-Smtp-Source: APXvYqxgavBTVVj9FwbAODiMpIh9H5arbGrcLC9jX6dkZg4BsE4+jikhUdlWvQZggFYg9nPOnqF4xA==
X-Received: by 2002:adf:f150:: with SMTP id y16mr6090523wro.71.1568887157608;
        Thu, 19 Sep 2019 02:59:17 -0700 (PDT)
Received: from localhost.localdomain ([213.86.25.14])
        by smtp.googlemail.com with ESMTPSA id y186sm10037704wmb.41.2019.09.19.02.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 02:59:17 -0700 (PDT)
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        Michael Chen <micchen@altera.com>, devel@driverdev.osuosl.org,
        dmaengine@vger.kernel.org
Subject: [PATCH RFC 1/2] staging: avalon-dma: Avalon DMA engine
Date:   Thu, 19 Sep 2019 11:59:12 +0200
Message-Id: <6499f97c811f1fd7e7cf229cc41977e23b9765f2.1568817357.git.a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568817357.git.a.gordeev.box@gmail.com>
References: <cover.1568817357.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Basic support for Avalon-MM DMA Interface for PCIe found in
hard IPs for Intel Arria, Cyclone or Stratix FPGAs. This is
an alternative (though minimal functionality) implementation
of reference design driver from Intel.

Unlike the reference design, the introduced interface allows
submitting contiguous buffers, scatterlists and DMA completion
callbacks - much like "dmaengine" does.

CC: Michael Chen <micchen@altera.com>
CC: devel@driverdev.osuosl.org
CC: dmaengine@vger.kernel.org

Signed-off-by: Alexander Gordeev <a.gordeev.box@gmail.com>
---
 drivers/staging/Kconfig                       |   2 +
 drivers/staging/Makefile                      |   1 +
 drivers/staging/avalon-dma/Kconfig            |  45 ++
 drivers/staging/avalon-dma/Makefile           |  11 +
 drivers/staging/avalon-dma/avalon-dma-core.c  | 515 ++++++++++++++++++
 drivers/staging/avalon-dma/avalon-dma-core.h  |  52 ++
 .../staging/avalon-dma/avalon-dma-interrupt.c | 118 ++++
 .../staging/avalon-dma/avalon-dma-interrupt.h |  13 +
 drivers/staging/avalon-dma/avalon-dma-util.c  | 196 +++++++
 drivers/staging/avalon-dma/avalon-dma-util.h  |  25 +
 include/linux/avalon-dma-hw.h                 |  72 +++
 include/linux/avalon-dma.h                    |  68 +++
 12 files changed, 1118 insertions(+)
 create mode 100644 drivers/staging/avalon-dma/Kconfig
 create mode 100644 drivers/staging/avalon-dma/Makefile
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-core.c
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-core.h
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-interrupt.c
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-interrupt.h
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-util.c
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-util.h
 create mode 100644 include/linux/avalon-dma-hw.h
 create mode 100644 include/linux/avalon-dma.h

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 7c96a01eef6c..31c732ececd1 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -120,4 +120,6 @@ source "drivers/staging/kpc2000/Kconfig"
 
 source "drivers/staging/isdn/Kconfig"
 
+source "drivers/staging/avalon-dma/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index fcaac9693b83..eb974cac85d3 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -50,3 +50,4 @@ obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_KPC2000)		+= kpc2000/
 obj-$(CONFIG_ISDN_CAPI)		+= isdn/
+obj-$(CONFIG_AVALON_DMA)	+= avalon-dma/
diff --git a/drivers/staging/avalon-dma/Kconfig b/drivers/staging/avalon-dma/Kconfig
new file mode 100644
index 000000000000..5164e990a62b
--- /dev/null
+++ b/drivers/staging/avalon-dma/Kconfig
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Avalon DMA engine
+#
+# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+#
+config AVALON_DMA
+	tristate "Avalon DMA engine"
+	help
+	  This selects a driver for Avalon DMA engine IP block
+
+config AVALON_DMA_TARGET_BASE
+	hex "Target device base address"
+	default "0x70000000"
+	depends on AVALON_DMA
+
+config AVALON_DMA_TARGET_SIZE
+	hex "Target device memory size"
+	default "0x10000000"
+	depends on AVALON_DMA
+
+config AVALON_DMA_CTRL_BASE
+	hex "Avalon DMA controllers base"
+	default "0x00000000"
+	depends on AVALON_DMA
+
+config AVALON_DMA_RD_EP_DST_LO
+	hex "Avalon DMA read controller base low"
+	default "0x80000000"
+	depends on AVALON_DMA
+
+config AVALON_DMA_RD_EP_DST_HI
+	hex "Avalon DMA read controller base high"
+	default "0x00000000"
+	depends on AVALON_DMA
+
+config AVALON_DMA_WR_EP_DST_LO
+	hex "Avalon DMA write controller base low"
+	default "0x80002000"
+	depends on AVALON_DMA
+
+config AVALON_DMA_WR_EP_DST_HI
+	hex "Avalon DMA write controller base high"
+	default "0x00000000"
+	depends on AVALON_DMA
diff --git a/drivers/staging/avalon-dma/Makefile b/drivers/staging/avalon-dma/Makefile
new file mode 100644
index 000000000000..61cb0ee7c7a8
--- /dev/null
+++ b/drivers/staging/avalon-dma/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Avalon DMA engine
+#
+# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+#
+obj-$(CONFIG_AVALON_DMA)	+= avalon-dma.o
+
+avalon-dma-objs :=	avalon-dma-core.o \
+			avalon-dma-util.o \
+			avalon-dma-interrupt.o
diff --git a/drivers/staging/avalon-dma/avalon-dma-core.c b/drivers/staging/avalon-dma/avalon-dma-core.c
new file mode 100644
index 000000000000..9e90c694785f
--- /dev/null
+++ b/drivers/staging/avalon-dma/avalon-dma-core.c
@@ -0,0 +1,515 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+
+#include <linux/avalon-dma.h>
+
+#include "avalon-dma-core.h"
+#include "avalon-dma-util.h"
+#include "avalon-dma-interrupt.h"
+
+#define AVALON_DMA_DESC_ALLOC
+#define AVALON_DMA_DESC_COUNT	0
+
+static struct avalon_dma_tx_desc *__alloc_desc(gfp_t flags)
+{
+	struct avalon_dma_tx_desc *desc;
+
+	desc = kzalloc(sizeof(*desc), flags);
+	if (!desc)
+		return NULL;
+
+	INIT_LIST_HEAD(&desc->node);
+	desc->direction = DMA_NONE;
+
+	return desc;
+}
+
+static void free_descs(struct list_head *descs)
+{
+	struct avalon_dma_tx_desc *desc;
+	struct list_head *node, *tmp;
+
+	list_for_each_safe(node, tmp, descs) {
+		desc = list_entry(node, struct avalon_dma_tx_desc, node);
+		list_del(node);
+
+		kfree(desc);
+	}
+}
+
+static int alloc_descs(struct list_head *descs, int nr_descs)
+{
+	struct avalon_dma_tx_desc *desc;
+	int i;
+
+	for (i = 0; i < nr_descs; i++) {
+		desc = __alloc_desc(GFP_KERNEL);
+		if (!desc) {
+			free_descs(descs);
+			return -ENOMEM;
+		}
+		list_add(&desc->node, descs);
+	}
+
+	return 0;
+}
+
+#ifdef AVALON_DMA_DESC_ALLOC
+struct avalon_dma_tx_desc *get_desc_locked(spinlock_t *lock,
+					   struct list_head *descs)
+{
+	struct avalon_dma_tx_desc *desc;
+
+	assert_spin_locked(lock);
+
+	if (unlikely(list_empty(descs))) {
+		gfp_t gfp_flags = GFP_KERNEL;
+
+		if (WARN_ON(in_interrupt()))
+			gfp_flags |= GFP_ATOMIC;
+
+		desc = __alloc_desc(gfp_flags);
+		if (!desc)
+			return NULL;
+
+		list_add(&desc->node, descs);
+	} else {
+		desc = list_first_entry(descs,
+					struct avalon_dma_tx_desc,
+					node);
+	}
+
+	return desc;
+}
+#else
+struct avalon_dma_tx_desc *get_desc_locked(spinlock_t *lock,
+					   struct list_head *descs)
+{
+	assert_spin_locked(lock);
+
+	if (unlikely(list_empty(descs)))
+		return NULL;
+
+	return list_first_entry(descs, struct avalon_dma_tx_desc, node);
+}
+#endif
+
+int avalon_dma_init(struct avalon_dma *avalon_dma,
+		    struct device *dev,
+		    void __iomem *regs,
+		    unsigned int irq)
+{
+	int ret;
+
+	memset(avalon_dma, 0, sizeof(*avalon_dma));
+
+	spin_lock_init(&avalon_dma->lock);
+
+	avalon_dma->dev		= dev;
+	avalon_dma->regs	= regs;
+	avalon_dma->irq		= irq;
+
+	avalon_dma->active_desc	= NULL;
+
+	avalon_dma->h2d_last_id = -1;
+	avalon_dma->d2h_last_id = -1;
+
+	INIT_LIST_HEAD(&avalon_dma->desc_allocated);
+	INIT_LIST_HEAD(&avalon_dma->desc_submitted);
+	INIT_LIST_HEAD(&avalon_dma->desc_issued);
+	INIT_LIST_HEAD(&avalon_dma->desc_completed);
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		goto dma_set_mask_err;
+
+	ret = alloc_descs(&avalon_dma->desc_allocated,
+			  AVALON_DMA_DESC_COUNT);
+	if (ret)
+		goto alloc_descs_err;
+
+	avalon_dma->dma_desc_table_rd.cpu_addr = dma_alloc_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		&avalon_dma->dma_desc_table_rd.dma_addr,
+		GFP_KERNEL);
+	if (!avalon_dma->dma_desc_table_rd.cpu_addr) {
+		ret = -ENOMEM;
+		goto alloc_rd_dma_table_err;
+	}
+
+	avalon_dma->dma_desc_table_wr.cpu_addr = dma_alloc_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		&avalon_dma->dma_desc_table_wr.dma_addr,
+		GFP_KERNEL);
+	if (!avalon_dma->dma_desc_table_wr.cpu_addr) {
+		ret = -ENOMEM;
+		goto alloc_wr_dma_table_err;
+	}
+
+	tasklet_init(&avalon_dma->tasklet,
+		     avalon_dma_tasklet, (unsigned long)avalon_dma);
+
+	ret = request_irq(irq, avalon_dma_interrupt, IRQF_SHARED,
+			  INTERRUPT_NAME, avalon_dma);
+	if (ret)
+		goto req_irq_err;
+
+	return 0;
+
+req_irq_err:
+	tasklet_kill(&avalon_dma->tasklet);
+
+	dma_free_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		avalon_dma->dma_desc_table_wr.cpu_addr,
+		avalon_dma->dma_desc_table_wr.dma_addr);
+
+alloc_wr_dma_table_err:
+	dma_free_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		avalon_dma->dma_desc_table_rd.cpu_addr,
+		avalon_dma->dma_desc_table_rd.dma_addr);
+
+alloc_rd_dma_table_err:
+	free_descs(&avalon_dma->desc_allocated);
+
+alloc_descs_err:
+dma_set_mask_err:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(avalon_dma_init);
+
+static void avalon_dma_sync(struct avalon_dma *avalon_dma)
+{
+	struct list_head *head = &avalon_dma->desc_allocated;
+	struct avalon_dma_tx_desc *desc;
+	int nr_retries = 0;
+	unsigned long flags;
+
+	/*
+	 * FIXME Implement graceful race-free completion
+	 */
+again:
+	synchronize_irq(avalon_dma->irq);
+
+	spin_lock_irqsave(&avalon_dma->lock, flags);
+
+	if (!list_empty(&avalon_dma->desc_submitted) ||
+	    !list_empty(&avalon_dma->desc_issued) ||
+	    !list_empty(&avalon_dma->desc_completed)) {
+
+		spin_unlock_irqrestore(&avalon_dma->lock, flags);
+
+		msleep(250);
+		nr_retries++;
+
+		goto again;
+	}
+
+	BUG_ON(avalon_dma->active_desc);
+
+	list_splice_tail_init(&avalon_dma->desc_submitted, head);
+	list_splice_tail_init(&avalon_dma->desc_issued, head);
+	list_splice_tail_init(&avalon_dma->desc_completed, head);
+
+	list_for_each_entry(desc, head, node)
+		desc->direction = DMA_NONE;
+
+	spin_unlock_irqrestore(&avalon_dma->lock, flags);
+
+	WARN_ON_ONCE(nr_retries);
+}
+
+void avalon_dma_term(struct avalon_dma *avalon_dma)
+{
+	struct device *dev = avalon_dma->dev;
+
+	avalon_dma_sync(avalon_dma);
+
+	free_irq(avalon_dma->irq, (void *)avalon_dma);
+	tasklet_kill(&avalon_dma->tasklet);
+
+	dma_free_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		avalon_dma->dma_desc_table_rd.cpu_addr,
+		avalon_dma->dma_desc_table_rd.dma_addr);
+
+	dma_free_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		avalon_dma->dma_desc_table_wr.cpu_addr,
+		avalon_dma->dma_desc_table_wr.dma_addr);
+
+	free_descs(&avalon_dma->desc_allocated);
+
+	iounmap(avalon_dma->regs);
+}
+EXPORT_SYMBOL_GPL(avalon_dma_term);
+
+static int submit_xfer(struct avalon_dma *avalon_dma,
+		       enum avalon_dma_xfer_desc_type type,
+		       enum dma_data_direction direction,
+		       union avalon_dma_xfer_info *xfer_info,
+		       avalon_dma_xfer_callback callback,
+		       void *callback_param)
+{
+	struct avalon_dma_tx_desc *desc;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&avalon_dma->lock, flags);
+
+	desc = get_desc_locked(&avalon_dma->lock, &avalon_dma->desc_allocated);
+	if (WARN_ON(!desc)) {
+		spin_unlock_irqrestore(&avalon_dma->lock, flags);
+		return -EBUSY;
+	}
+
+	desc->avalon_dma = avalon_dma;
+	desc->type = type;
+	desc->direction = direction;
+	desc->callback = callback;
+	desc->callback_param = callback_param;
+
+	if (type == xfer_buf)
+		desc->xfer_info.xfer_buf = xfer_info->xfer_buf;
+	else if (type == xfer_sgt)
+		desc->xfer_info.xfer_sgt = xfer_info->xfer_sgt;
+	else
+		BUG();
+
+	list_move_tail(&desc->node, &avalon_dma->desc_submitted);
+
+	spin_unlock_irqrestore(&avalon_dma->lock, flags);
+
+	return ret;
+}
+
+int avalon_dma_issue_pending(struct avalon_dma *avalon_dma)
+{
+	struct avalon_dma_tx_desc *desc;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&avalon_dma->lock, flags);
+
+	if (WARN_ON(list_empty(&avalon_dma->desc_submitted))) {
+		ret = -ENOENT;
+		goto err;
+	}
+
+	list_splice_tail_init(&avalon_dma->desc_submitted,
+			      &avalon_dma->desc_issued);
+
+	/*
+	 * We must check BOTH read and write status here!
+	 */
+	if (avalon_dma->d2h_last_id < 0 && avalon_dma->h2d_last_id < 0) {
+		BUG_ON(avalon_dma->active_desc);
+
+		desc = list_first_entry(&avalon_dma->desc_issued,
+					struct avalon_dma_tx_desc,
+					node);
+
+		ret = avalon_dma_start_xfer(avalon_dma, desc);
+		if (ret)
+			goto err;
+
+		avalon_dma->active_desc = desc;
+	} else {
+		BUG_ON(!avalon_dma->active_desc);
+	}
+
+err:
+	spin_unlock_irqrestore(&avalon_dma->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(avalon_dma_issue_pending);
+
+int avalon_dma_submit_xfer(struct avalon_dma *avalon_dma,
+			   enum dma_data_direction direction,
+			   dma_addr_t dev_addr,
+			   dma_addr_t host_addr,
+			   unsigned int size,
+			   avalon_dma_xfer_callback callback,
+			   void *callback_param)
+{
+	union avalon_dma_xfer_info xi;
+
+	xi.xfer_buf.dev_addr	= dev_addr;
+	xi.xfer_buf.host_addr	= host_addr;
+	xi.xfer_buf.size	= size;
+	xi.xfer_buf.offset	= 0;
+
+	return submit_xfer(avalon_dma, xfer_buf, direction, &xi,
+			   callback, callback_param);
+}
+EXPORT_SYMBOL_GPL(avalon_dma_submit_xfer);
+
+int avalon_dma_submit_xfer_sg(struct avalon_dma *avalon_dma,
+			      enum dma_data_direction direction,
+			      dma_addr_t dev_addr,
+			      struct sg_table *sg_table,
+			      avalon_dma_xfer_callback callback,
+			      void *callback_param)
+{
+	union avalon_dma_xfer_info xi;
+
+	xi.xfer_sgt.dev_addr	= dev_addr;
+	xi.xfer_sgt.sg_table	= sg_table;
+	xi.xfer_sgt.sg_curr	= sg_table->sgl;
+	xi.xfer_sgt.sg_offset	= 0;
+
+	return submit_xfer(avalon_dma, xfer_sgt, direction, &xi,
+			   callback, callback_param);
+}
+EXPORT_SYMBOL_GPL(avalon_dma_submit_xfer_sg);
+
+static int setup_dma_descs_buf(struct dma_desc *dma_descs,
+			       struct avalon_dma_tx_desc *desc)
+{
+	struct xfer_buf *xfer_buf = &desc->xfer_info.xfer_buf;
+	unsigned int offset = xfer_buf->offset;
+	unsigned int size = xfer_buf->size - offset;
+	dma_addr_t dev_addr = xfer_buf->dev_addr + offset;
+	dma_addr_t host_addr = xfer_buf->host_addr + offset;
+	unsigned int set;
+	int ret;
+
+	BUG_ON(size > xfer_buf->size);
+	ret = setup_descs(dma_descs, 0, desc->direction,
+			  dev_addr, host_addr, size, &set);
+	BUG_ON(!ret);
+	if (ret > 0)
+		xfer_buf->offset += set;
+
+	return ret;
+}
+
+static int setup_dma_descs_sg(struct dma_desc *dma_descs,
+			      struct avalon_dma_tx_desc *desc)
+{
+	struct xfer_sgt *xfer_sgt = &desc->xfer_info.xfer_sgt;
+	struct scatterlist *sg_stop;
+	unsigned int sg_set;
+	int ret;
+
+	ret = setup_descs_sg(dma_descs, 0,
+			     desc->direction,
+			     xfer_sgt->dev_addr, xfer_sgt->sg_table,
+			     xfer_sgt->sg_curr, xfer_sgt->sg_offset,
+			     &sg_stop, &sg_set);
+	BUG_ON(!ret);
+	if (ret > 0) {
+		if (sg_stop == xfer_sgt->sg_curr) {
+			xfer_sgt->sg_offset += sg_set;
+		} else {
+			xfer_sgt->sg_curr = sg_stop;
+			xfer_sgt->sg_offset = sg_set;
+		}
+	}
+
+	return ret;
+}
+
+static int setup_dma_descs(struct dma_desc *dma_descs,
+			   struct avalon_dma_tx_desc *desc)
+{
+	int ret;
+
+	if (desc->type == xfer_buf) {
+		ret = setup_dma_descs_buf(dma_descs, desc);
+	} else if (desc->type == xfer_sgt) {
+		ret = setup_dma_descs_sg(dma_descs, desc);
+	} else {
+		BUG();
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static void start_xfer(void __iomem *base, size_t ctrl_off,
+		       u32 rc_src_hi, u32 rc_src_lo,
+		       u32 ep_dst_hi, u32 ep_dst_lo,
+		       int last_id)
+{
+	av_write32(rc_src_hi, base, ctrl_off, rc_src_hi);
+	av_write32(rc_src_lo, base, ctrl_off, rc_src_lo);
+	av_write32(ep_dst_hi, base, ctrl_off, ep_dst_hi);
+	av_write32(ep_dst_lo, base, ctrl_off, ep_dst_lo);
+	av_write32(last_id, base, ctrl_off, table_size);
+	av_write32(last_id, base, ctrl_off, last_ptr);
+}
+
+int avalon_dma_start_xfer(struct avalon_dma *avalon_dma,
+			  struct avalon_dma_tx_desc *desc)
+{
+	size_t ctrl_off;
+	struct __dma_desc_table *__table;
+	struct dma_desc_table *table;
+	u32 rc_src_hi, rc_src_lo;
+	u32 ep_dst_lo, ep_dst_hi;
+	int last_id, *__last_id;
+	int nr_descs;
+
+	if (desc->direction == DMA_TO_DEVICE) {
+		__table = &avalon_dma->dma_desc_table_rd;
+
+		ctrl_off = AVALON_DMA_RD_CTRL_OFFSET;
+
+		ep_dst_hi = AVALON_DMA_RD_EP_DST_HI;
+		ep_dst_lo = AVALON_DMA_RD_EP_DST_LO;
+
+		__last_id = &avalon_dma->h2d_last_id;
+	} else if (desc->direction == DMA_FROM_DEVICE) {
+		__table = &avalon_dma->dma_desc_table_wr;
+
+		ctrl_off = AVALON_DMA_WR_CTRL_OFFSET;
+
+		ep_dst_hi = AVALON_DMA_WR_EP_DST_HI;
+		ep_dst_lo = AVALON_DMA_WR_EP_DST_LO;
+
+		__last_id = &avalon_dma->d2h_last_id;
+	} else {
+		BUG();
+	}
+
+	table = __table->cpu_addr;
+	memset(&table->flags, 0, sizeof(table->flags));
+
+	nr_descs = setup_dma_descs(table->descs, desc);
+	if (WARN_ON(nr_descs < 1))
+		return nr_descs;
+
+	last_id = nr_descs - 1;
+	*__last_id = last_id;
+
+	rc_src_hi = __table->dma_addr >> 32;
+	rc_src_lo = (u32)__table->dma_addr;
+
+	start_xfer(avalon_dma->regs, ctrl_off,
+		   rc_src_hi, rc_src_lo,
+		   ep_dst_hi, ep_dst_lo,
+		   last_id);
+
+	return 0;
+}
+
+MODULE_AUTHOR("Alexander Gordeev <a.gordeev.box@gmail.com>");
+MODULE_DESCRIPTION("Avalon DMA engine driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/avalon-dma/avalon-dma-core.h b/drivers/staging/avalon-dma/avalon-dma-core.h
new file mode 100644
index 000000000000..230f6ab9ca11
--- /dev/null
+++ b/drivers/staging/avalon-dma/avalon-dma-core.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DMA_CORE_H__
+#define __AVALON_DMA_CORE_H__
+
+#include <linux/interrupt.h>
+#include <linux/dma-direction.h>
+
+#include <linux/avalon-dma.h>
+
+#define INTERRUPT_NAME	"avalon_dma"
+
+struct avalon_dma_tx_desc {
+	struct list_head node;
+
+	struct avalon_dma *avalon_dma;
+
+	enum avalon_dma_xfer_desc_type {
+		xfer_buf,
+		xfer_sgt
+	} type;
+
+	enum dma_data_direction direction;
+
+	avalon_dma_xfer_callback callback;
+	void *callback_param;
+
+	union avalon_dma_xfer_info {
+		struct xfer_buf {
+			dma_addr_t dev_addr;
+			dma_addr_t host_addr;
+			unsigned int size;
+			unsigned int offset;
+		} xfer_buf;
+		struct xfer_sgt {
+			dma_addr_t dev_addr;
+			struct sg_table *sg_table;
+			struct scatterlist *sg_curr;
+			unsigned int sg_offset;
+		} xfer_sgt;
+	} xfer_info;
+};
+
+int avalon_dma_start_xfer(struct avalon_dma *avalon_dma,
+			  struct avalon_dma_tx_desc *desc);
+
+#endif
+
diff --git a/drivers/staging/avalon-dma/avalon-dma-interrupt.c b/drivers/staging/avalon-dma/avalon-dma-interrupt.c
new file mode 100644
index 000000000000..84261aee2d63
--- /dev/null
+++ b/drivers/staging/avalon-dma/avalon-dma-interrupt.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include "avalon-dma-core.h"
+
+static bool dma_desc_done(struct avalon_dma_tx_desc *desc)
+{
+	if (desc->type == xfer_buf) {
+		struct xfer_buf *xfer_buf = &desc->xfer_info.xfer_buf;
+
+		BUG_ON(xfer_buf->offset > xfer_buf->size);
+		if (xfer_buf->offset < xfer_buf->size)
+			return false;
+	} else if (desc->type == xfer_sgt) {
+		struct xfer_sgt *xfer_sgt = &desc->xfer_info.xfer_sgt;
+		struct scatterlist *sg_curr = xfer_sgt->sg_curr;
+		unsigned int sg_len = sg_dma_len(sg_curr);
+
+		if (!sg_is_last(sg_curr))
+			return false;
+
+		BUG_ON(xfer_sgt->sg_offset > sg_len);
+		if (xfer_sgt->sg_offset < sg_len)
+			return false;
+	} else {
+		BUG();
+	}
+
+	return true;
+}
+
+irqreturn_t avalon_dma_interrupt(int irq, void *dev_id)
+{
+	struct avalon_dma *avalon_dma = (struct avalon_dma *)dev_id;
+	struct avalon_dma_tx_desc *desc;
+	u32 *rd_flags = avalon_dma->dma_desc_table_rd.cpu_addr->flags;
+	u32 *wr_flags = avalon_dma->dma_desc_table_wr.cpu_addr->flags;
+	bool rd_done;
+	bool wr_done;
+	bool desc_done;
+
+	spin_lock(&avalon_dma->lock);
+
+	rd_done = (avalon_dma->h2d_last_id < 0);
+	wr_done = (avalon_dma->d2h_last_id < 0);
+
+	if (rd_done && wr_done) {
+		spin_unlock(&avalon_dma->lock);
+		return IRQ_NONE;
+	}
+
+	do {
+		if (!rd_done && rd_flags[avalon_dma->h2d_last_id])
+			rd_done = true;
+
+		if (!wr_done && wr_flags[avalon_dma->d2h_last_id])
+			wr_done = true;
+	} while (!rd_done || !wr_done);
+
+	avalon_dma->h2d_last_id = -1;
+	avalon_dma->d2h_last_id = -1;
+
+	BUG_ON(!avalon_dma->active_desc);
+	desc = avalon_dma->active_desc;
+
+	desc_done = dma_desc_done(desc);
+	if (desc_done) {
+		desc->direction = DMA_NONE;
+		list_move_tail(&desc->node, &avalon_dma->desc_completed);
+
+		if (list_empty(&avalon_dma->desc_issued)) {
+			avalon_dma->active_desc = NULL;
+		} else {
+			desc = list_first_entry(&avalon_dma->desc_issued,
+						struct avalon_dma_tx_desc,
+						node);
+			avalon_dma->active_desc = desc;
+		}
+	}
+
+	if (avalon_dma->active_desc) {
+		BUG_ON(desc != avalon_dma->active_desc);
+		avalon_dma_start_xfer(avalon_dma, desc);
+	}
+
+	spin_unlock(&avalon_dma->lock);
+
+	if (desc_done)
+		tasklet_schedule(&avalon_dma->tasklet);
+
+	return IRQ_HANDLED;
+}
+
+void avalon_dma_tasklet(unsigned long arg)
+{
+	struct avalon_dma *avalon_dma = (struct avalon_dma *)arg;
+	struct avalon_dma_tx_desc *desc;
+	LIST_HEAD(desc_completed);
+
+	spin_lock_irq(&avalon_dma->lock);
+	list_splice_tail_init(&avalon_dma->desc_completed, &desc_completed);
+	spin_unlock_irq(&avalon_dma->lock);
+
+	list_for_each_entry(desc, &desc_completed, node) {
+		if (desc->callback)
+			desc->callback(desc->callback_param);
+	}
+
+	spin_lock_irq(&avalon_dma->lock);
+	list_splice_tail(&desc_completed, &avalon_dma->desc_allocated);
+	spin_unlock_irq(&avalon_dma->lock);
+}
diff --git a/drivers/staging/avalon-dma/avalon-dma-interrupt.h b/drivers/staging/avalon-dma/avalon-dma-interrupt.h
new file mode 100644
index 000000000000..15603fe431c4
--- /dev/null
+++ b/drivers/staging/avalon-dma/avalon-dma-interrupt.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DMA_INTERRUPT_H__
+#define __AVALON_DMA_INTERRUPT_H__
+
+irqreturn_t avalon_dma_interrupt(int irq, void *dev_id);
+void avalon_dma_tasklet(unsigned long arg);
+
+#endif
diff --git a/drivers/staging/avalon-dma/avalon-dma-util.c b/drivers/staging/avalon-dma/avalon-dma-util.c
new file mode 100644
index 000000000000..038973a1b3b3
--- /dev/null
+++ b/drivers/staging/avalon-dma/avalon-dma-util.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/scatterlist.h>
+
+#include <linux/avalon-dma-hw.h>
+
+#include "avalon-dma-util.h"
+
+void setup_desc(struct dma_desc *desc, u32 desc_id,
+		u64 dst, u64 src, u32 size)
+{
+	BUG_ON(!size);
+	WARN_ON(!IS_ALIGNED(size, sizeof(u32)));
+	BUG_ON(desc_id > (DMA_DESC_MAX - 1));
+
+	desc->src_lo = cpu_to_le32(src & 0xfffffffful);
+	desc->src_hi = cpu_to_le32((src >> 32));
+	desc->dst_lo = cpu_to_le32(dst & 0xfffffffful);
+	desc->dst_hi = cpu_to_le32((dst >> 32));
+	desc->ctl_dma_len = cpu_to_le32((size >> 2) | (desc_id << 18));
+	desc->reserved[0] = cpu_to_le32(0x0);
+	desc->reserved[1] = cpu_to_le32(0x0);
+	desc->reserved[2] = cpu_to_le32(0x0);
+}
+
+int setup_descs(struct dma_desc *descs, unsigned int desc_id,
+		enum dma_data_direction direction,
+		dma_addr_t dev_addr, dma_addr_t host_addr, unsigned int len,
+		unsigned int *_set)
+{
+	int nr_descs = 0;
+	unsigned int set = 0;
+	dma_addr_t src;
+	dma_addr_t dest;
+
+	if (direction == DMA_TO_DEVICE) {
+		src = host_addr;
+		dest = dev_addr;
+	} else if (direction == DMA_FROM_DEVICE) {
+		src = dev_addr;
+		dest = host_addr;
+	} else {
+		BUG();
+		return -EINVAL;
+	}
+
+	if (unlikely(desc_id > DMA_DESC_MAX - 1)) {
+		BUG();
+		return -EINVAL;
+	}
+
+	if (WARN_ON(!len))
+		return -EINVAL;
+
+	while (len) {
+		unsigned int xfer_len = min_t(unsigned int, len, AVALON_DMA_MAX_TANSFER_SIZE);
+
+		setup_desc(descs, desc_id, dest, src, xfer_len);
+
+		set += xfer_len;
+
+		nr_descs++;
+		if (nr_descs >= DMA_DESC_MAX)
+			break;
+
+		desc_id++;
+		if (desc_id >= DMA_DESC_MAX)
+			break;
+
+		descs++;
+
+		dest += xfer_len;
+		src += xfer_len;
+
+		len -= xfer_len;
+	}
+
+	*_set = set;
+
+	return nr_descs;
+}
+
+int setup_descs_sg(struct dma_desc *descs, unsigned int desc_id,
+		   enum dma_data_direction direction,
+		   dma_addr_t dev_addr, struct sg_table *sg_table,
+		   struct scatterlist *sg_start, unsigned int sg_offset,
+		   struct scatterlist **_sg_stop, unsigned int *_sg_set)
+{
+	struct scatterlist *sg;
+	dma_addr_t sg_addr;
+	unsigned int sg_len;
+	unsigned int sg_set;
+	int nr_descs = 0;
+	int ret;
+	int i;
+
+	/*
+	 * Find the SGE that the previous xfer has stopped on - it should exist.
+	 */
+	for_each_sg(sg_table->sgl, sg, sg_table->nents, i) {
+		if (sg == sg_start)
+			break;
+
+		dev_addr += sg_dma_len(sg);
+	}
+
+	if (WARN_ON(i >= sg_table->nents))
+		return -EINVAL;
+
+	/*
+	 * The offset can not be longer than the SGE length.
+	 */
+	sg_len = sg_dma_len(sg);
+	if (WARN_ON(sg_len < sg_offset))
+		return -EINVAL;
+
+	/*
+	 * Skip the starting SGE if it has been fully transmitted.
+	 */
+	if (sg_offset == sg_len) {
+		if (WARN_ON(sg_is_last(sg)))
+			return -EINVAL;
+
+		dev_addr += sg_len;
+		sg_offset = 0;
+
+		i++;
+		sg = sg_next(sg);
+	}
+
+	/*
+	 * Setup as many SGEs as the controller is able to transmit.
+	 */
+	BUG_ON(i >= sg_table->nents);
+	for (; i < sg_table->nents; i++) {
+		sg_addr = sg_dma_address(sg);
+		sg_len = sg_dma_len(sg);
+
+		if (sg_offset) {
+			if (unlikely(sg_len <= sg_offset)) {
+				BUG();
+				return -EINVAL;
+			}
+
+			dev_addr += sg_offset;
+			sg_addr += sg_offset;
+			sg_len -= sg_offset;
+
+			sg_offset = 0;
+		}
+
+		ret = setup_descs(descs, desc_id, direction,
+				  dev_addr, sg_addr, sg_len, &sg_set);
+		if (ret < 0)
+			return ret;
+
+		if (unlikely((desc_id + ret > DMA_DESC_MAX) ||
+			     (nr_descs + ret > DMA_DESC_MAX))) {
+			BUG();
+			return -ENOMEM;
+		}
+
+		nr_descs += ret;
+		desc_id += ret;
+
+		if (desc_id >= DMA_DESC_MAX)
+			break;
+
+		if (unlikely(sg_len != sg_set)) {
+			BUG();
+			return -EINVAL;
+		}
+
+		if (sg_is_last(sg))
+			break;
+
+		descs += ret;
+		dev_addr += sg_len;
+
+		sg = sg_next(sg);
+	}
+
+	/*
+	 * Remember the SGE that next transmission should be started from.
+	 */
+	BUG_ON(!sg);
+	*_sg_stop = sg;
+	*_sg_set = sg_set;
+
+	return nr_descs;
+}
diff --git a/drivers/staging/avalon-dma/avalon-dma-util.h b/drivers/staging/avalon-dma/avalon-dma-util.h
new file mode 100644
index 000000000000..38d3bccba7ae
--- /dev/null
+++ b/drivers/staging/avalon-dma/avalon-dma-util.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DMA_UTIL_H__
+#define __AVALON_DMA_UTIL_H__
+
+#include <linux/scatterlist.h>
+#include <linux/dma-direction.h>
+
+#define DMA_DESC_MAX	AVALON_DMA_DESC_NUM
+
+int setup_descs(struct dma_desc *descs, unsigned int desc_id,
+		enum dma_data_direction direction,
+		dma_addr_t dev_addr, dma_addr_t host_addr, unsigned int len,
+		unsigned int *set);
+int setup_descs_sg(struct dma_desc *descs, unsigned int desc_id,
+		   enum dma_data_direction direction,
+		   dma_addr_t dev_addr, struct sg_table *sg_table,
+		   struct scatterlist *sg_start, unsigned int sg_offset,
+		   struct scatterlist **sg_stop, unsigned int *sg_set);
+
+#endif
diff --git a/include/linux/avalon-dma-hw.h b/include/linux/avalon-dma-hw.h
new file mode 100644
index 000000000000..d9dbee404143
--- /dev/null
+++ b/include/linux/avalon-dma-hw.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DMA_HW_H__
+#define __AVALON_DMA_HW_H__
+
+#define AVALON_DMA_DESC_NUM		128
+
+#define AVALON_DMA_FIXUP_SIZE		0x100
+#define AVALON_DMA_MAX_TANSFER_SIZE	(0x100000 - AVALON_DMA_FIXUP_SIZE)
+
+#define AVALON_DMA_CTRL_BASE		CONFIG_AVALON_DMA_CTRL_BASE
+#define AVALON_DMA_RD_CTRL_OFFSET	0x0
+#define AVALON_DMA_WR_CTRL_OFFSET	0x100
+
+#define AVALON_DMA_RD_EP_DST_LO		CONFIG_AVALON_DMA_RD_EP_DST_LO
+#define AVALON_DMA_RD_EP_DST_HI		CONFIG_AVALON_DMA_RD_EP_DST_HI
+#define AVALON_DMA_WR_EP_DST_LO		CONFIG_AVALON_DMA_WR_EP_DST_LO
+#define AVALON_DMA_WR_EP_DST_HI		CONFIG_AVALON_DMA_WR_EP_DST_HI
+
+struct dma_ctrl {
+	u32 rc_src_lo;
+	u32 rc_src_hi;
+	u32 ep_dst_lo;
+	u32 ep_dst_hi;
+	u32 last_ptr;
+	u32 table_size;
+	u32 control;
+} __packed;
+
+struct dma_desc {
+	u32 src_lo;
+	u32 src_hi;
+	u32 dst_lo;
+	u32 dst_hi;
+	u32 ctl_dma_len;
+	u32 reserved[3];
+} __packed;
+
+struct dma_desc_table {
+	u32 flags[AVALON_DMA_DESC_NUM];
+	struct dma_desc descs[AVALON_DMA_DESC_NUM];
+} __packed;
+
+static inline u32 __av_read32(void __iomem *base,
+			      size_t ctrl_off,
+			      size_t reg_off)
+{
+	size_t offset = AVALON_DMA_CTRL_BASE + ctrl_off + reg_off;
+
+	return ioread32(base + offset);
+}
+
+static inline void __av_write32(u32 value,
+				void __iomem *base,
+				size_t ctrl_off,
+				size_t reg_off)
+{
+	size_t offset = AVALON_DMA_CTRL_BASE + ctrl_off + reg_off;
+
+	iowrite32(value, base + offset);
+}
+
+#define av_read32(b, o, r) \
+	__av_read32(b, o, offsetof(struct dma_ctrl, r))
+#define av_write32(v, b, o, r) \
+	__av_write32(v, b, o, offsetof(struct dma_ctrl, r))
+
+#endif
diff --git a/include/linux/avalon-dma.h b/include/linux/avalon-dma.h
new file mode 100644
index 000000000000..bb34d414f2c2
--- /dev/null
+++ b/include/linux/avalon-dma.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DMA_H__
+#define __AVALON_DMA_H__
+
+#include <linux/dma-direction.h>
+#include <linux/interrupt.h>
+#include <linux/scatterlist.h>
+
+#include <linux/avalon-dma-hw.h>
+
+typedef void (*avalon_dma_xfer_callback)(void *dma_async_param);
+
+struct avalon_dma_tx_desc;
+
+struct avalon_dma {
+	spinlock_t lock;
+	struct device *dev;
+	struct tasklet_struct tasklet;
+	unsigned int irq;
+
+	struct avalon_dma_tx_desc *active_desc;
+
+	struct list_head desc_allocated;
+	struct list_head desc_submitted;
+	struct list_head desc_issued;
+	struct list_head desc_completed;
+
+	struct __dma_desc_table {
+		struct dma_desc_table *cpu_addr;
+		dma_addr_t dma_addr;
+	} dma_desc_table_rd, dma_desc_table_wr;
+
+	int h2d_last_id;
+	int d2h_last_id;
+
+	void __iomem *regs;
+};
+
+int avalon_dma_init(struct avalon_dma *avalon_dma,
+		    struct device *dev,
+		    void __iomem *regs,
+		    unsigned int irq);
+void avalon_dma_term(struct avalon_dma *avalon_dma);
+
+int avalon_dma_submit_xfer(struct avalon_dma *avalon_dma,
+			   enum dma_data_direction direction,
+			   dma_addr_t dev_addr, dma_addr_t host_addr,
+			   unsigned int size,
+			   avalon_dma_xfer_callback callback,
+			   void *callback_param);
+int avalon_dma_submit_xfer_sg(struct avalon_dma *avalon_dma,
+			      enum dma_data_direction direction,
+			      dma_addr_t dev_addr, struct sg_table *sg_table,
+			      avalon_dma_xfer_callback callback,
+			      void *callback_param);
+int avalon_dma_issue_pending(struct avalon_dma *avalon_dma);
+
+#define TARGET_MEM_BASE		CONFIG_AVALON_DMA_TARGET_BASE
+#define TARGET_MEM_SIZE		CONFIG_AVALON_DMA_TARGET_SIZE
+#define TARGET_DMA_SIZE		(2 * AVALON_DMA_MAX_TANSFER_SIZE)
+#define TARGET_DMA_SIZE_SG	TARGET_MEM_SIZE
+
+#endif
-- 
2.22.0

