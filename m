Return-Path: <dmaengine+bounces-2144-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A735B8CD7CC
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2024 17:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199B0B22D36
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB3F12B89;
	Thu, 23 May 2024 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="X/TnPHoQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4945125DE
	for <dmaengine@vger.kernel.org>; Thu, 23 May 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479700; cv=none; b=dmKd3LuEIJgyEXrsUWHU5m7GwYWAq/yog4UBbwIYAllb3EGCn3vVhhbZ/wwrLmfGmYvol6K4fYpqJy3g+tH7LXSDkXHzmOjOvxWX2Y+NESxVeOAFz+/EJuwud/8jE0SBia3rytCGo4gWYFxumr/bMNrsyKvbuMnASA2iC0Fkgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479700; c=relaxed/simple;
	bh=3l+BK379qy9Nwfry8Kx+ivH1hoaTbb/cXHz/WGQdPAg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mK4a8Yvizwo3TTKuhMLK7e/j5a33gPcxPyH+OzR9RzcN9Gup2qhqdDEPEIJmSjhuG3ddT22AuOZcmDO0HtcuASp5qnbMqon/DrsNzQWzue5OcdlWavyx4qLksmKZTPgPJXp8fU7aRcaj2Pc71+U9U2qyW+RopNTx03UyeIoDxNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=X/TnPHoQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-351ae94323aso1957160f8f.0
        for <dmaengine@vger.kernel.org>; Thu, 23 May 2024 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1716479696; x=1717084496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MS4AZl1itrc8fFEQdGOOd+E6I+KhxynunCgV1hyIkHs=;
        b=X/TnPHoQkdBRmA+O56JtPuTZyulLnOB/+W2mGoVU8tKMerq17vImQDHqIV1s51EAyj
         a00Z6nEbnT1QePXRmQtM9wDOhVABXNYDNok+QnwiuMgZNb/ofDg+kueGkBb6rAJtXXJ8
         sPoeSacz5ZbB7+iTlYak33655UatFL1FwDFaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479696; x=1717084496;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MS4AZl1itrc8fFEQdGOOd+E6I+KhxynunCgV1hyIkHs=;
        b=SEGvJPEwbs/A+J8oEGqNCX1CByRJiBj7gPpSwEC3A7ydTHFmXolRdeDgxgpgUs9JHP
         bu3uvgq3sm+OJOVj1m3IRO8QmTSXEeTe9sVbywWMHNIhj8qlX1f2cQHfCui3xybKsIGm
         pDzOjod8liKskf4rbtdI1uX/ofnyJA3pGXCFBNiA9vYrVRhgcrPxbJjH01PGDBFc38uI
         IXC4L70tTfF/lVI/lb8iw7CS5HSpO3JQhmt3L4IJlEEYUgVL1QiCizuTCbjDgqTjSsQC
         XDu8T0MX/xffbEMelBT9naQlj3ila/lNRY/WclHo5LRshB25RMQayH4RYn6o5oFh3Lft
         SJjw==
X-Gm-Message-State: AOJu0Yyx5l0YSRhOBlQfDErJgkUL5d/kOi1XtMA+ZG775m+NJ/B6Db2Z
	7DLPIx3lpIH9iFNUzXQVpjpCQu4PJi3mLpswEaJbOUZn3Y7wVYDJWzDMjYV2gs5+Ia+7gFf1+zi
	Ygfmt9mDWhY6Wee4v8im3EQmVeCki5sqR1Zzs8iaP/9uZ0Qxz/fDPsQ==
X-Google-Smtp-Source: AGHT+IEWhPX/EfbmQuqkik9/3nLIsygcyHhEom3uoxc+asl58C6glUBSw1aT185ZFHF3T2TnXT0nJPgrkcITHZ8HPg0=
X-Received: by 2002:a5d:4090:0:b0:354:be7c:954 with SMTP id
 ffacd0b85a97d-354d8ca6509mr4697879f8f.15.1716479695957; Thu, 23 May 2024
 08:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Debief <debief@digigram.com>
Date: Thu, 23 May 2024 17:54:30 +0200
Message-ID: <CALYqZ9mM611vq8k5m33Wx1PCw5WrfNNV9xOvrXef6YK2V+zinw@mail.gmail.com>
Subject: [PATCH] : XDMA's Channel in stream mode initial support
To: dmaengine@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

In order to correct a DMAR NO_PASID Error when IO_MMU is enabled with
the C2H XDMA's channels in STREAM Mode, I added an initial support of
the STREAM Mode in the XDMAdriver.
The error is due to the missing C2H write back structure. So it is now
allocated for C2H channel working in stream mode.

This is an initial support as it doesn't handle the End of Packet
condition occurring when the Card closes the stream. In my use, the
card never closes the stream, so I can't test it.

Hope this helps,
Regards,
Eric.

=============================================
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

