Return-Path: <dmaengine+bounces-8103-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA358D01DF7
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 10:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D03AC347560A
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 08:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C15395D90;
	Thu,  8 Jan 2026 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShgggO9+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D172C2374
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859453; cv=none; b=ilYGBJy+Mo13QzOdq8r0dTieuLZgAVORi3gJgL/bydLGgcAZP0lF2hQ0bB9NxrMDPRRlw0eiKCQh+9Nmsn05rybM/mAjA5+hyE1eJOyJFZxViDep8/P82yh2OQxRprhM7neEjKwTAfLuD0nUX3bHCV3Ao/RDA9KXGiDKf83BEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859453; c=relaxed/simple;
	bh=zpUZc3T435msSu1SJ1BG3K14/hJMKlYtWpIP176EsMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTyK5OPEzKbrk8CwAoSYFO0bQKo6bkx6voZbA00hwjNPOslExZX2tFhIsCTccUV1Hda0VCEmn4xjAz6gnmrXyua2+cWyjqs7bP7VUNb3IbQ0ykS3QDfOKhO7oPg0SFDLrOOxpNhgyiJbm0ka/PMjPx3e/V1bOZgCW5qN/QvLDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShgggO9+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso22782655ad.1
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 00:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767859417; x=1768464217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/tzbOA+1IHkoRIw/lhz1F5yQGhPM9qE3QnUiAF+STg=;
        b=ShgggO9+DM8SKAasWTarJiRk/bRUarE9/d1Gw39mOoCeP9Tx4egFW/mrPChQJ5qv5L
         Qj2qAgPWk9M9LVNfX5I0DUWiFYaKSbj1mq5KwiieTx/d7VnxkAVRaiFvmA+xLKOXcAA7
         uq4rFKpc9Fxklh5XojmzE3S0r1CRBDuZ8tFxBjeW1K5DAI4mDCbd5jdPSi1OihVal14O
         A8ho3luos2fGRGTgftKsGr3JJxj5FymVXGIpYb/rkjYm+oM1hzsbgCcPfnN/7rkULwoz
         06D3sVb4C5OroH5IR4DcRAIZzuj6t5KUUJMY/su+DOQJU4m+k6JrrHWa5rTHRdJk1hyI
         weiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767859417; x=1768464217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/tzbOA+1IHkoRIw/lhz1F5yQGhPM9qE3QnUiAF+STg=;
        b=Aleg2gayh+Ovut0sG5kgjUAbUxrRCV8ErVImvJFUB2vE3zfCAMjfKdv/UUqDlEsgq2
         IlX1+Ac3rMuZCDPeHly+jXsOD6UHbkUDkh2Mr16LFus/uwAiXtHZLQ1JbCwcbqNqCcr6
         /Ku3znhSMr0xMmGrEvP7ePQs0mfMWwYfIwSG9IKv+MaNkcvCdx9SBA90I3AlbBk9j5th
         w02ywd2YYyui7yeIlVNlO8brf9JLrvazd+sAcYiNZdbND7Ecpwst1Xu2qqfFaiB8c66m
         qkNMACsHmj+C9vXWk9peDsYRGrRzgIWWs1UNamwPDQM3u8oEf/b56ipbCanPb/JKoqp2
         1Ohw==
X-Forwarded-Encrypted: i=1; AJvYcCXk0/I04eLoTzXGV+kp53IMBhcJM7ZsEbrXnpvS3+H0J/Mpot8sUE41zYqKvW7w/8+DPcIni4kRNMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpwDaaQGtgso2K1aCNqYpCiuri6yPPfWpdYHkZEf8MV1oGAWU
	DW/3GhCMwGVmAi9ryke4m0Bzgf86dWUDMrIkjSNbuxvim5fb8klRYv6Z
X-Gm-Gg: AY/fxX6U6d7nYMcz1US3guHFmu9ju1WsbhiN5Dxuoy+8BXlCeHMK2moyDRGy1Dd0VyK
	FDXREkS8dxmZ+sl3qhduWatAhdvHULbVuzlaKDpvv5N/DmaI098PalRPJ2lth1NIhEmHBioS3p0
	+M2heFxEFzlWQypDhKUykT02cVqAu9wClQmzEQTebbb6hQvGMra6ZsYZlpA20CIjZHTAEFvg/XG
	m6pWnVrsYmf0ZuyPmMNR5mvE3y8fWGJqPOayxki/YrWp2WSce1+2z1z8ClgLVsDu5OF92CBXW0Q
	8ghImScSVoysNupdLS5ruuGVv8KjKpp3HPV/y5vpfc2QGG+MW2mevRmbuool15dA9D1SWJniIgm
	+Rdo2rg7c/8BzyB6gVuzDX9VpwYH+JmIcSD7Y2IVBdkLiGC2r16r/zcUU2Z/fjkmzgpZ4t7G2Jr
	6OMUjwppBHLQ50qxGwy/GCFOE=
X-Google-Smtp-Source: AGHT+IHZ6BlQf1lnXJWcoLZR2Hea1KpPth6/85Sk8DpSOVG+0om7ExNZg57MjmwKzD3J7N+NTbRKbQ==
X-Received: by 2002:a17:903:244d:b0:297:f8d9:aad7 with SMTP id d9443c01a7336-2a3ee4a1f19mr47039785ad.50.1767859417384;
        Thu, 08 Jan 2026 00:03:37 -0800 (PST)
Received: from cryptic.lan ([2001:569:7e17:d700:9e5a:c54:de19:a242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2fe3sm71065775ad.59.2026.01.08.00.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:03:35 -0800 (PST)
From: Allen Pais <allen.lkml@gmail.com>
To: vkoul@kernel.org
Cc: arnd@arndb.de,
	kees@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [RFC PATCH 1/1] dmaengine: introduce dmaengine_bh_wq and bh helpers
Date: Thu,  8 Jan 2026 00:03:31 -0800
Message-ID: <20260108080332.2341725-2-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108080332.2341725-1-allen.lkml@gmail.com>
References: <20260108080332.2341725-1-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a dedicated dmaengine bottom-half workqueue (WQ_BH | WQ_PERCPU)
and provide helper APIs for queue/flush/cancel of BH work items. Add
per-channel BH helpers in dma_chan so drivers can schedule a BH callback
without maintaining their own tasklets.

Convert virt-dma to use the new per-channel BH helpers and remove the
per-channel tasklet. Update existing drivers that only need tasklet
teardown to use dma_chan_kill_bh().

This provides a common BH execution path for dmaengine and establishes
the base for converting remaining DMA tasklets to workqueue-based BHs.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/amd/qdma/qdma.c                   |   1 +
 drivers/dma/bcm2835-dma.c                     |   2 +-
 drivers/dma/dmaengine.c                       | 109 +++++++++++++++++-
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |   2 +-
 drivers/dma/dw-edma/dw-edma-core.c            |   2 +-
 drivers/dma/hisi_dma.c                        |   2 +-
 drivers/dma/img-mdc-dma.c                     |   2 +-
 drivers/dma/imx-sdma.c                        |   2 +-
 drivers/dma/k3dma.c                           |   2 +-
 drivers/dma/loongson1-apb-dma.c               |   2 +-
 drivers/dma/mediatek/mtk-cqdma.c              |   2 +-
 drivers/dma/mediatek/mtk-hsdma.c              |   2 +-
 drivers/dma/mediatek/mtk-uart-apdma.c         |   4 +-
 drivers/dma/owl-dma.c                         |   2 +-
 drivers/dma/pxa_dma.c                         |   2 +-
 drivers/dma/qcom/bam_dma.c                    |   4 +-
 drivers/dma/qcom/qcom_adm.c                   |   2 +-
 drivers/dma/sa11x0-dma.c                      |   2 +-
 drivers/dma/sprd-dma.c                        |   2 +-
 drivers/dma/sun6i-dma.c                       |   2 +-
 drivers/dma/tegra186-gpc-dma.c                |   2 +-
 drivers/dma/tegra210-adma.c                   |   2 +-
 drivers/dma/ti/k3-udma.c                      |   8 +-
 drivers/dma/ti/omap-dma.c                     |   2 +-
 drivers/dma/virt-dma.c                        |   6 +-
 drivers/dma/virt-dma.h                        |   8 +-
 include/linux/dmaengine.h                     |  50 ++++++++
 27 files changed, 189 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/amd/qdma/qdma.c b/drivers/dma/amd/qdma/qdma.c
index 8fb2d5e1df20..b57f8ebf2446 100644
--- a/drivers/dma/amd/qdma/qdma.c
+++ b/drivers/dma/amd/qdma/qdma.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/amd_qdma.h>
 #include <linux/regmap.h>
+#include <linux/interrupt.h>
 
 #include "qdma.h"
 
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 321748e2983e..08a206cfbb76 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -846,7 +846,7 @@ static void bcm2835_dma_free(struct bcm2835_dmadev *od)
 	list_for_each_entry_safe(c, next, &od->ddev.channels,
 				 vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		dma_chan_kill_bh(&c->vc.chan);
 	}
 
 	dma_unmap_page_attrs(od->ddev.dev, od->zero_page, PAGE_SIZE,
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330b..d3df4e943d37 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -54,6 +54,7 @@
 #include <linux/of_dma.h>
 #include <linux/mempool.h>
 #include <linux/numa.h>
+#include <linux/workqueue.h>
 
 #include "dmaengine.h"
 
@@ -61,6 +62,7 @@ static DEFINE_MUTEX(dma_list_mutex);
 static DEFINE_IDA(dma_ida);
 static LIST_HEAD(dma_device_list);
 static long dmaengine_ref_count;
+static struct workqueue_struct *dmaengine_bh_wq;
 
 /* --- debugfs implementation --- */
 #ifdef CONFIG_DEBUG_FS
@@ -1425,6 +1427,92 @@ static void dmaengine_destroy_unmap_pool(void)
 	}
 }
 
+static void dmaengine_destroy_bh_wq(void)
+{
+	if (!dmaengine_bh_wq)
+		return;
+
+	destroy_workqueue(dmaengine_bh_wq);
+	dmaengine_bh_wq = NULL;
+}
+
+bool dmaengine_queue_bh_work(struct work_struct *work)
+{
+	if (WARN_ON(!dmaengine_bh_wq))
+		return false;
+
+	return queue_work(dmaengine_bh_wq, work);
+}
+EXPORT_SYMBOL_GPL(dmaengine_queue_bh_work);
+
+void dmaengine_flush_bh_work(struct work_struct *work)
+{
+	if (!work)
+		return;
+
+	flush_work(work);
+}
+EXPORT_SYMBOL_GPL(dmaengine_flush_bh_work);
+
+void dmaengine_cancel_bh_work_sync(struct work_struct *work)
+{
+	if (!work)
+		return;
+
+	cancel_work_sync(work);
+}
+EXPORT_SYMBOL_GPL(dmaengine_cancel_bh_work_sync);
+
+static void dma_chan_bh_entry(struct work_struct *work)
+{
+	struct dma_chan *chan = container_of(work, struct dma_chan, bh_work);
+	dma_chan_bh_work_fn fn = READ_ONCE(chan->bh_work_fn);
+
+	if (fn)
+		fn(chan);
+}
+
+void dma_chan_init_bh(struct dma_chan *chan, dma_chan_bh_work_fn fn)
+{
+	if (WARN_ON(!fn))
+		return;
+
+	if (WARN_ON(chan->bh_work_initialized))
+		return;
+
+	chan->bh_work_fn = fn;
+	INIT_WORK(&chan->bh_work, dma_chan_bh_entry);
+	chan->bh_work_initialized = true;
+}
+EXPORT_SYMBOL_GPL(dma_chan_init_bh);
+
+bool dma_chan_schedule_bh(struct dma_chan *chan)
+{
+	if (WARN_ON(!chan->bh_work_initialized))
+		return false;
+
+	return dmaengine_queue_bh_work(&chan->bh_work);
+}
+EXPORT_SYMBOL_GPL(dma_chan_schedule_bh);
+
+void dma_chan_flush_bh(struct dma_chan *chan)
+{
+	if (!chan->bh_work_initialized)
+		return;
+
+	dmaengine_flush_bh_work(&chan->bh_work);
+}
+EXPORT_SYMBOL_GPL(dma_chan_flush_bh);
+
+void dma_chan_kill_bh(struct dma_chan *chan)
+{
+	if (!chan->bh_work_initialized)
+		return;
+
+	dmaengine_cancel_bh_work_sync(&chan->bh_work);
+}
+EXPORT_SYMBOL_GPL(dma_chan_kill_bh);
+
 static int __init dmaengine_init_unmap_pool(void)
 {
 	int i;
@@ -1621,15 +1709,28 @@ EXPORT_SYMBOL_GPL(dma_run_dependencies);
 
 static int __init dma_bus_init(void)
 {
-	int err = dmaengine_init_unmap_pool();
+	int err;
 
+	dmaengine_bh_wq = alloc_workqueue("dmaengine_bh",
+					  WQ_BH | WQ_PERCPU, 0);
+	if (!dmaengine_bh_wq)
+		return -ENOMEM;
+
+	err = dmaengine_init_unmap_pool();
 	if (err)
-		return err;
+		goto err_destroy_wq;
 
 	err = class_register(&dma_devclass);
-	if (!err)
-		dmaengine_debugfs_init();
+	if (err)
+		goto err_destroy_pool;
 
+	dmaengine_debugfs_init();
+	return 0;
+
+err_destroy_pool:
+	dmaengine_destroy_unmap_pool();
+err_destroy_wq:
+	dmaengine_destroy_bh_wq();
 	return err;
 }
 arch_initcall(dma_bus_init);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..42018b21d2ab 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1649,7 +1649,7 @@ static void dw_remove(struct platform_device *pdev)
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
 			vc.chan.device_node) {
 		list_del(&chan->vc.chan.device_node);
-		tasklet_kill(&chan->vc.task);
+		dma_chan_kill_bh(&chan->vc.chan);
 	}
 }
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..378650bcc430 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1015,7 +1015,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	dma_async_device_unregister(&dw->dma);
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
 				 vc.chan.device_node) {
-		tasklet_kill(&chan->vc.task);
+		dma_chan_kill_bh(&chan->vc.chan);
 		list_del(&chan->vc.chan.device_node);
 	}
 
diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 25a4134be36b..a15491945329 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -720,7 +720,7 @@ static void hisi_dma_disable_qps(struct hisi_dma_dev *hdma_dev)
 
 	for (i = 0; i < hdma_dev->chan_num; i++) {
 		hisi_dma_disable_qp(hdma_dev, i);
-		tasklet_kill(&hdma_dev->chan[i].vc.task);
+		dma_chan_kill_bh(&hdma_dev->chan[i].vc.chan);
 	}
 }
 
diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
index fd55bcd060ab..d4f6d839acca 100644
--- a/drivers/dma/img-mdc-dma.c
+++ b/drivers/dma/img-mdc-dma.c
@@ -1031,7 +1031,7 @@ static void mdc_dma_remove(struct platform_device *pdev)
 
 		devm_free_irq(&pdev->dev, mchan->irq, mchan);
 
-		tasklet_kill(&mchan->vc.task);
+		dma_chan_kill_bh(&mchan->vc.chan);
 	}
 
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ed9e56de5a9b..9cbc95fbb4ee 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2427,7 +2427,7 @@ static void sdma_remove(struct platform_device *pdev)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		tasklet_kill(&sdmac->vc.task);
+		dma_chan_kill_bh(&sdmac->vc.chan);
 		sdma_free_chan_resources(&sdmac->vc.chan);
 	}
 
diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 0f9cd7815f88..36d5df545b57 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -981,7 +981,7 @@ static void k3_dma_remove(struct platform_device *op)
 
 	list_for_each_entry_safe(c, cn, &d->slave.channels, vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		dma_chan_kill_bh(&c->vc.chan);
 	}
 	tasklet_kill(&d->task);
 	clk_disable_unprepare(d->clk);
diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson1-apb-dma.c
index 255fe7eca212..49a78ea1514f 100644
--- a/drivers/dma/loongson1-apb-dma.c
+++ b/drivers/dma/loongson1-apb-dma.c
@@ -552,7 +552,7 @@ static void ls1x_dma_chan_remove(struct ls1x_dma *dma)
 
 		if (chan->vc.chan.device == &dma->ddev) {
 			list_del(&chan->vc.chan.device_node);
-			tasklet_kill(&chan->vc.task);
+			dma_chan_kill_bh(&chan->vc.chan);
 		}
 	}
 }
diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 9f0c41ca7770..3ba54df12bae 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -895,7 +895,7 @@ static void mtk_cqdma_remove(struct platform_device *pdev)
 		vc = &cqdma->vc[i];
 
 		list_del(&vc->vc.chan.device_node);
-		tasklet_kill(&vc->vc.task);
+		dma_chan_kill_bh(&vc->vc.chan);
 	}
 
 	/* disable interrupt */
diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index fa77bb24a430..0bbf865de24b 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -1020,7 +1020,7 @@ static void mtk_hsdma_remove(struct platform_device *pdev)
 		vc = &hsdma->vc[i];
 
 		list_del(&vc->vc.chan.device_node);
-		tasklet_kill(&vc->vc.task);
+		dma_chan_kill_bh(&vc->vc.chan);
 	}
 
 	/* Disable DMA interrupt */
diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 08e15177427b..257b9b77cc57 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -312,7 +312,7 @@ static void mtk_uart_apdma_free_chan_resources(struct dma_chan *chan)
 
 	free_irq(c->irq, chan);
 
-	tasklet_kill(&c->vc.task);
+	dma_chan_kill_bh(&c->vc.chan);
 
 	vchan_free_chan_resources(&c->vc);
 
@@ -463,7 +463,7 @@ static void mtk_uart_apdma_free(struct mtk_uart_apdmadev *mtkd)
 			struct mtk_chan, vc.chan.device_node);
 
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		dma_chan_kill_bh(&c->vc.chan);
 	}
 }
 
diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 57cec757d8f5..4e6ebf990688 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1055,7 +1055,7 @@ static inline void owl_dma_free(struct owl_dma *od)
 	list_for_each_entry_safe(vchan,
 				 next, &od->dma.channels, vc.chan.device_node) {
 		list_del(&vchan->vc.chan.device_node);
-		tasklet_kill(&vchan->vc.task);
+		dma_chan_kill_bh(&vchan->vc.chan);
 	}
 }
 
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 249296389771..634b723e4891 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1218,7 +1218,7 @@ static void pxad_free_channels(struct dma_device *dmadev)
 	list_for_each_entry_safe(c, cn, &dmadev->channels,
 				 vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		dma_chan_kill_bh(&c->vc.chan);
 	}
 }
 
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 2cf060174795..6ec82adb89ce 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1377,7 +1377,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&bdev->common);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
-		tasklet_kill(&bdev->channels[i].vc.task);
+		dma_chan_kill_bh(&bdev->channels[i].vc.chan);
 err_tasklet_kill:
 	tasklet_kill(&bdev->task);
 err_disable_clk:
@@ -1403,7 +1403,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
-		tasklet_kill(&bdev->channels[i].vc.task);
+		dma_chan_kill_bh(&bdev->channels[i].vc.chan);
 
 		if (!bdev->channels[i].fifo_virt)
 			continue;
diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
index 6be54fddcee1..0f9e906bd463 100644
--- a/drivers/dma/qcom/qcom_adm.c
+++ b/drivers/dma/qcom/qcom_adm.c
@@ -919,7 +919,7 @@ static void adm_dma_remove(struct platform_device *pdev)
 		/* mask IRQs for this channel/EE pair */
 		writel(0, adev->regs + ADM_CH_RSLT_CONF(achan->id, adev->ee));
 
-		tasklet_kill(&adev->channels[i].vc.task);
+		dma_chan_kill_bh(&adev->channels[i].vc.chan);
 		adm_terminate_all(&adev->channels[i].vc.chan);
 	}
 
diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index dc1a9a05252e..42940079efbf 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -893,7 +893,7 @@ static void sa11x0_dma_free_channels(struct dma_device *dmadev)
 
 	list_for_each_entry_safe(c, cn, &dmadev->channels, vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		dma_chan_kill_bh(&c->vc.chan);
 		kfree(c);
 	}
 }
diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 6207e0b185e1..5124fe0a93bf 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1253,7 +1253,7 @@ static void sprd_dma_remove(struct platform_device *pdev)
 	list_for_each_entry_safe(c, cn, &sdev->dma_dev.channels,
 				 vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		dma_chan_kill_bh(&c->vc.chan);
 	}
 
 	of_dma_controller_free(pdev->dev.of_node);
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 2215ff877bf7..6b3ab99272a5 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1073,7 +1073,7 @@ static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
 		struct sun6i_vchan *vchan = &sdev->vchans[i];
 
 		list_del(&vchan->vc.chan.device_node);
-		tasklet_kill(&vchan->vc.task);
+		dma_chan_kill_bh(&vchan->vc.chan);
 	}
 }
 
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 4d6fe0efa76e..3b9dc64eb635 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1279,7 +1279,7 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 	tegra_dma_terminate_all(dc);
 	synchronize_irq(tdc->irq);
 
-	tasklet_kill(&tdc->vc.task);
+	dma_chan_kill_bh(&tdc->vc.chan);
 	tdc->config_init = false;
 	tdc->slave_id = -1;
 	tdc->sid_dir = DMA_TRANS_NONE;
diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index d0e8bb27a03b..67ccb1d48361 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -793,7 +793,7 @@ static void tegra_adma_free_chan_resources(struct dma_chan *dc)
 
 	tegra_adma_terminate_all(dc);
 	vchan_free_chan_resources(&tdc->vc);
-	tasklet_kill(&tdc->vc.task);
+	dma_chan_kill_bh(&tdc->vc.chan);
 	free_irq(tdc->irq, tdc);
 	pm_runtime_put(tdc2dev(tdc));
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index aa2dc762140f..89dd7926705d 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4045,9 +4045,9 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
  * This tasklet handles the completion of a DMA descriptor by
  * calling its callback and freeing it.
  */
-static void udma_vchan_complete(struct tasklet_struct *t)
+static void udma_vchan_complete(struct dma_chan *chan)
 {
-	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
+	struct virt_dma_chan *vc = to_virt_chan(chan);
 	struct virt_dma_desc *vd, *_vd;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(head);
@@ -4112,7 +4112,7 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 	}
 
 	vchan_free_chan_resources(&uc->vc);
-	tasklet_kill(&uc->vc.task);
+	dma_chan_kill_bh(&uc->vc.chan);
 
 	bcdma_free_bchan_resources(uc);
 	udma_free_tx_resources(uc);
@@ -5628,7 +5628,7 @@ static int udma_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
-		tasklet_setup(&uc->vc.task, udma_vchan_complete);
+		dma_chan_init_bh(&uc->vc.chan, udma_vchan_complete);
 		init_completion(&uc->teardown_completed);
 		INIT_DELAYED_WORK(&uc->tx_drain.work, udma_check_tx_completion);
 	}
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 8c023c6e623a..f6aee92071e2 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1521,7 +1521,7 @@ static void omap_dma_free(struct omap_dmadev *od)
 			struct omap_chan, vc.chan.device_node);
 
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		dma_chan_kill_bh(&c->vc.chan);
 		kfree(c);
 	}
 }
diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index 7961172a780d..c311397f3bd7 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -80,9 +80,9 @@ EXPORT_SYMBOL_GPL(vchan_find_desc);
  * This tasklet handles the completion of a DMA descriptor by
  * calling its callback and freeing it.
  */
-static void vchan_complete(struct tasklet_struct *t)
+static void vchan_complete(struct dma_chan *chan)
 {
-	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
+	struct virt_dma_chan *vc = to_virt_chan(chan);
 	struct virt_dma_desc *vd, *_vd;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(head);
@@ -131,7 +131,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
 	INIT_LIST_HEAD(&vc->desc_completed);
 	INIT_LIST_HEAD(&vc->desc_terminated);
 
-	tasklet_setup(&vc->task, vchan_complete);
+	dma_chan_init_bh(&vc->chan, vchan_complete);
 
 	vc->chan.device = dmadev;
 	list_add_tail(&vc->chan.device_node, &dmadev->channels);
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 59d9eabc8b67..5299fb7367ca 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -8,7 +8,6 @@
 #define VIRT_DMA_H
 
 #include <linux/dmaengine.h>
-#include <linux/interrupt.h>
 
 #include "dmaengine.h"
 
@@ -21,7 +20,6 @@ struct virt_dma_desc {
 
 struct virt_dma_chan {
 	struct dma_chan	chan;
-	struct tasklet_struct task;
 	void (*desc_free)(struct virt_dma_desc *);
 
 	spinlock_t lock;
@@ -106,7 +104,7 @@ static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
 		 vd, cookie);
 	list_add_tail(&vd->node, &vc->desc_completed);
 
-	tasklet_schedule(&vc->task);
+	dma_chan_schedule_bh(&vc->chan);
 }
 
 /**
@@ -137,7 +135,7 @@ static inline void vchan_cyclic_callback(struct virt_dma_desc *vd)
 	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
 
 	vc->cyclic = vd;
-	tasklet_schedule(&vc->task);
+	dma_chan_schedule_bh(&vc->chan);
 }
 
 /**
@@ -223,7 +221,7 @@ static inline void vchan_synchronize(struct virt_dma_chan *vc)
 	LIST_HEAD(head);
 	unsigned long flags;
 
-	tasklet_kill(&vc->task);
+	dma_chan_kill_bh(&vc->chan);
 
 	spin_lock_irqsave(&vc->lock, flags);
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea..00ad92a73c3b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -12,6 +12,7 @@
 #include <linux/scatterlist.h>
 #include <linux/bitmap.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 #include <asm/page.h>
 
 /**
@@ -295,6 +296,10 @@ enum dma_desc_metadata_mode {
 	DESC_METADATA_ENGINE = BIT(1),
 };
 
+struct dma_chan;
+
+typedef void (*dma_chan_bh_work_fn)(struct dma_chan *chan);
+
 /**
  * struct dma_chan_percpu - the per-CPU part of struct dma_chan
  * @memcpy_count: transaction counter
@@ -334,6 +339,9 @@ struct dma_router {
  * @router: pointer to the DMA router structure
  * @route_data: channel specific data for the router
  * @private: private data for certain client-channel associations
+ * @bh_work: bottom-half work item stored per-channel
+ * @bh_work_fn: callback executed when @bh_work runs
+ * @bh_work_initialized: indicates whether @bh_work has been initialized
  */
 struct dma_chan {
 	struct dma_device *device;
@@ -359,6 +367,9 @@ struct dma_chan {
 	void *route_data;
 
 	void *private;
+	struct work_struct bh_work;
+	dma_chan_bh_work_fn bh_work_fn;
+	bool bh_work_initialized;
 };
 
 /**
@@ -1528,6 +1539,14 @@ struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
 
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
+bool dmaengine_queue_bh_work(struct work_struct *work);
+void dmaengine_flush_bh_work(struct work_struct *work);
+void dmaengine_cancel_bh_work_sync(struct work_struct *work);
+
+void dma_chan_init_bh(struct dma_chan *chan, dma_chan_bh_work_fn fn);
+bool dma_chan_schedule_bh(struct dma_chan *chan);
+void dma_chan_flush_bh(struct dma_chan *chan);
+void dma_chan_kill_bh(struct dma_chan *chan);
 #else
 static inline struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type)
 {
@@ -1575,6 +1594,37 @@ static inline int dma_get_slave_caps(struct dma_chan *chan,
 {
 	return -ENXIO;
 }
+
+static inline bool dmaengine_queue_bh_work(struct work_struct *work)
+{
+	return false;
+}
+
+static inline void dmaengine_flush_bh_work(struct work_struct *work)
+{
+}
+
+static inline void dmaengine_cancel_bh_work_sync(struct work_struct *work)
+{
+}
+
+static inline void dma_chan_init_bh(struct dma_chan *chan,
+				    dma_chan_bh_work_fn fn)
+{
+}
+
+static inline bool dma_chan_schedule_bh(struct dma_chan *chan)
+{
+	return false;
+}
+
+static inline void dma_chan_flush_bh(struct dma_chan *chan)
+{
+}
+
+static inline void dma_chan_kill_bh(struct dma_chan *chan)
+{
+}
 #endif
 
 static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)
-- 
2.43.0


