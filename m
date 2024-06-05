Return-Path: <dmaengine+bounces-2263-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C591E8FC8A8
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 12:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F81F28596A
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEC0257B;
	Wed,  5 Jun 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="XEz4auoR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378A190050
	for <dmaengine@vger.kernel.org>; Wed,  5 Jun 2024 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582057; cv=none; b=t9DH3osmWpqmur5DFtvRi+B5uGIkeGiE/dNYVkXHEuK3LEn+SnbwuJNFaMiOG1SKf8pRqL/lgq1ZFXnJ8J5aakHgly2fwejE5FHLsYtlApL3WsNyLz78JsXoL3+9RLZyECmItdYmueYmCBlQmSr96ILT7djEFSW6IvOI5SV0QAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582057; c=relaxed/simple;
	bh=Z1cmO6rPxlcqil03+PLEWeKEDxanAwUup6VEPlIsJRg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HXbQac7pKsHjupTU4suloe34AH+7Rl/qp1hCjL4ATyNUHhgxGykoXZF5+dvFguZwyhMKp5MQfK22TyQ3eyldZwKYMPfJ+5RLlWnUgdLceFZz/n/SMHKe2ken8BtVM8KdC9Izy6y2JJz6tkKPUqcMevb2tZwBns1/UsPpVI8ge6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=XEz4auoR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b919d214cso4061832e87.2
        for <dmaengine@vger.kernel.org>; Wed, 05 Jun 2024 03:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1717582054; x=1718186854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZyXYMsbHdj75aClIqd976E9cE6JwMK9h0UyQ5uxPRw=;
        b=XEz4auoR2wBXzUZ67wJ3A1vg6yxOeVUFti6qGLrBfl7TYFSJ7uo2lqV8lFRZWk4pVk
         rmewbMff5fgRw/H7vlRoekEAbq9FFzO8pWx950YQiLvjX/vCqsauyfHjjL8WR0tS/6k6
         8aY1GFA62E8NRxG4GeHTx9MQlXagt4I2VOXP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582054; x=1718186854;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZyXYMsbHdj75aClIqd976E9cE6JwMK9h0UyQ5uxPRw=;
        b=DIszPFBLOXIZAOHjeDNZy6oZQ6VOTuo1iBaGxkAaViPK4iZPxhdLgE/od0Xgeh6js0
         qa0/KGjNV9nVmbzev6bNxZWlYDCbvQPgawROQ0nXJR24oM2ytYSHU/2y/t2ewcM98bXm
         eHvv2qcXebZTCyyO6icRD6yeXK67msukxIzn+tL/Xu0sG7Vy9MAXUwmQIDXV69qebt2l
         KhTyyUYmYJzjsxZAXaqRRU4tJUMACO91UgokVg4vHklAqnK74ztMRe4boLAUpO2lmFqy
         0NAgEF784A2+jkBW1awpgycbnYTRfZdqdB6Kg6I1rFJDexq/ApDZ1FZUhE0199ByOoe2
         375w==
X-Gm-Message-State: AOJu0Yy8KZzokAzn3vFS7mWF0l85/Ew1ptzLLMJ4TfMSAuFTj828XlNh
	dw54aVaRRJoKLbsokf5LooKAo3vP62pJ1DxaNHJtpnMdebtplGqdP53nn7489zr0qp6IWnbWaED
	rtTP95r6X64jF1GVW876NxCvxM/vDruAMdyo2WY0YLLT43d+mhLtkTaLFwGDTPuWjyH+SWptqaE
	QMoJIRsT4xqI3u1qoDEl5IUE2jx3XEtKjxNslLPbkc4w==
X-Google-Smtp-Source: AGHT+IHihZdyHyfULq3k3SPbHSjAVf2aBdLL59RQgVmDVcATLaNxfdiJV+DFZw7TPrHh1QfnsePt6jF/F74ck4/2KvA=
X-Received: by 2002:a05:6512:3986:b0:52b:796f:8af5 with SMTP id
 2adb3069b0e04-52bab4db844mr1651507e87.34.1717582053818; Wed, 05 Jun 2024
 03:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Debief <debief@digigram.com>
Date: Wed, 5 Jun 2024 12:07:07 +0200
Message-ID: <CALYqZ9=rqzRHn4en0oXSx0QNybizqq2hMbsO6+X_hLynT5RXZw@mail.gmail.com>
Subject: [PATCH 1/3] : XDMA's channel Stream mode support
To: dmaengine@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"

From ffe05a12ee7d9e9450f24deb54c2b5b901a5eebb Mon Sep 17 00:00:00 2001
From: Eric DEBIEF <debief@digigram.com>
Date: Thu, 23 May 2024 17:21:23 +0200
Subject: XDMA stream mode initial support.

If the Channel is in STREAM Mode, a C2H Write back
structure is allocated and used.
This is an initial support as the write back is allocated
even if the feature is disabled for the Channel.
The End of Packet condition is not handled yet.
So, the stream CAN only be correctly closed
by the host and not the XDMA.

Signed-off-by: Eric DEBIEF <debief@digigram.com>
---
 drivers/dma/xilinx/xdma-regs.h |  5 +++
 drivers/dma/xilinx/xdma.c      | 64 +++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
index 6ad08878e938..780ac3c9d34d 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -95,6 +95,11 @@ struct xdma_hw_desc {
 #define XDMA_CHAN_CHECK_TARGET(id, target)        \
     (((u32)(id) >> 16) == XDMA_CHAN_MAGIC + (target))

+/* macro about channel's interface mode */
+#define XDMA_CHAN_ID_STREAM_BIT        BIT(15)
+#define XDMA_CHAN_IN_STREAM_MODE(id)    \
+    (((u32)(id) & XDMA_CHAN_ID_STREAM_BIT) != 0)
+
 /* bits of the channel control register */
 #define CHAN_CTRL_RUN_STOP            BIT(0)
 #define CHAN_CTRL_IE_DESC_STOPPED        BIT(1)
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index e2c3f629681e..c2a56f8ff1ac 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -51,6 +51,20 @@ struct xdma_desc_block {
     dma_addr_t    dma_addr;
 };

+/**
+ * struct xdma_c2h_stream_write_back  - Write back block , written by the XDMA.
+ * @magic_status_bit : magic (0x52B4) once written
+ * @length: effective transfer length (in bytes)
+ * @PADDING to be aligned on 32 bytes
+ * @associated dma address
+ */
+struct xdma_c2h_stream_write_back {
+    __le32 magic_status_bit;
+    __le32 length;
+    u32 padding_1[6];
+    dma_addr_t dma_addr;
+};
+
 /**
  * struct xdma_chan - Driver specific DMA channel structure
  * @vchan: Virtual channel
@@ -61,6 +75,8 @@ struct xdma_desc_block {
  * @dir: Transferring direction of the channel
  * @cfg: Transferring config of the channel
  * @irq: IRQ assigned to the channel
+ * @c2h_wback : Meta data write back only for C2H channels in stream mode
+
  */
 struct xdma_chan {
     struct virt_dma_chan        vchan;
@@ -73,6 +89,8 @@ struct xdma_chan {
     u32                irq;
     struct completion        last_interrupt;
     bool                stop_requested;
+    bool                stream_mode;
+    struct xdma_c2h_stream_write_back *c2h_wback;
 };

 /**
@@ -472,6 +490,8 @@ static int xdma_alloc_channels(struct xdma_device *xdev,
         xchan->base = base + i * XDMA_CHAN_STRIDE;
         xchan->dir = dir;
         xchan->stop_requested = false;
+        xchan->stream_mode = XDMA_CHAN_IN_STREAM_MODE(identifier);
+        xchan->c2h_wback = NULL;
         init_completion(&xchan->last_interrupt);

         ret = xdma_channel_init(xchan);
@@ -480,6 +500,11 @@ static int xdma_alloc_channels(struct xdma_device *xdev,
         xchan->vchan.desc_free = xdma_free_desc;
         vchan_init(&xchan->vchan, &xdev->dma_dev);

+        dev_dbg(&xdev->pdev->dev, "configured channel %s[%d] in %s Interface",
+            (dir == DMA_MEM_TO_DEV) ? "H2C" : "C2H",
+            j,
+            (xchan->stream_mode == false) ? "Memory Mapped" : "Stream");
+
         j++;
     }

@@ -628,7 +653,8 @@ xdma_prep_device_sg(struct dma_chan *chan, struct
scatterlist *sgl,
         src = &addr;
         dst = &dev_addr;
     } else {
-        dev_addr = xdma_chan->cfg.src_addr;
+        dev_addr = xdma_chan->cfg.src_addr ?
+            xdma_chan->cfg.src_addr : xdma_chan->c2h_wback->dma_addr;
         src = &dev_addr;
         dst = &addr;
     }
@@ -705,7 +731,8 @@ xdma_prep_dma_cyclic(struct dma_chan *chan,
dma_addr_t address,
         src = &addr;
         dst = &dev_addr;
     } else {
-        dev_addr = xdma_chan->cfg.src_addr;
+        dev_addr = xdma_chan->cfg.src_addr ?
+            xdma_chan->cfg.src_addr : xdma_chan->c2h_wback->dma_addr;
         src = &dev_addr;
         dst = &addr;
     }
@@ -801,8 +828,16 @@ static int xdma_device_config(struct dma_chan *chan,
 static void xdma_free_chan_resources(struct dma_chan *chan)
 {
     struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+    struct xdma_device *xdev = xdma_chan->xdev_hdl;
+    struct device *dev = xdev->dma_dev.dev;

     vchan_free_chan_resources(&xdma_chan->vchan);
+    if (xdma_chan->c2h_wback != NULL) {
+        dev_dbg(dev, "Free C2H write back: %p", xdma_chan->c2h_wback);
+        dma_pool_free(xdma_chan->desc_pool,
+                    xdma_chan->c2h_wback,
+                xdma_chan->c2h_wback->dma_addr);
+    }
     dma_pool_destroy(xdma_chan->desc_pool);
     xdma_chan->desc_pool = NULL;
 }
@@ -816,6 +851,7 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
     struct xdma_chan *xdma_chan = to_xdma_chan(chan);
     struct xdma_device *xdev = xdma_chan->xdev_hdl;
     struct device *dev = xdev->dma_dev.dev;
+    dma_addr_t c2h_wback_addr;

     while (dev && !dev_is_pci(dev))
         dev = dev->parent;
@@ -824,13 +860,33 @@ static int xdma_alloc_chan_resources(struct
dma_chan *chan)
         return -EINVAL;
     }

-    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan), dev,
XDMA_DESC_BLOCK_SIZE,
-                           XDMA_DESC_BLOCK_ALIGN, XDMA_DESC_BLOCK_BOUNDARY);
+    //Allocate the pool WITH the C2H write back
+    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
+                dev,
+                XDMA_DESC_BLOCK_SIZE +
+                    sizeof(struct xdma_c2h_stream_write_back),
+                XDMA_DESC_BLOCK_ALIGN,
+                XDMA_DESC_BLOCK_BOUNDARY);
     if (!xdma_chan->desc_pool) {
         xdma_err(xdev, "unable to allocate descriptor pool");
         return -ENOMEM;
     }

+    /* Allocate the C2H write back out of the pool in streaming mode only*/
+    if ((xdma_chan->dir == DMA_DEV_TO_MEM) &&
+        (xdma_chan->stream_mode == true)) {
+        xdma_chan->c2h_wback = dma_pool_alloc(xdma_chan->desc_pool,
+                              GFP_NOWAIT,
+                              &c2h_wback_addr);
+        if (!xdma_chan->c2h_wback) {
+            xdma_err(xdev, "unable to allocate C2H write back block");
+            return -ENOMEM;
+        }
+        xdma_chan->c2h_wback->dma_addr = c2h_wback_addr;
+        dev_dbg(dev, "Allocate C2H write back: %p", xdma_chan->c2h_wback);
+    }
+
+
     return 0;
 }

-- 
2.34.1

-- 
 
<https://www.digigram.com/digigram-critical-audio-at-eurosatory-2024-in-paris/>

