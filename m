Return-Path: <dmaengine+bounces-1971-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68EE8B5A82
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 15:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3552F1F20EC4
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D82538396;
	Mon, 29 Apr 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="EaTRyNy+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF3E2E401
	for <dmaengine@vger.kernel.org>; Mon, 29 Apr 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398596; cv=none; b=gGvrenkjaAJwwAB1wBO1+ilv64kAle/vTlqKuONjHCYmx8xn9SnMr3kLXCXSGkMSa4iYZvTsjAK6IcXfxeL79nKc+7+lVhzGcnjQH5xyrrF8A3008hIGR8rFjnomIk8Qt2p9SGhPvOeQC99jpFIi660TlCijTjChIDa64MidZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398596; c=relaxed/simple;
	bh=shTwkpdWD8nDsya1QMg24T4PeHiloIgT5Oa9aZqobss=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KhX0P7QpsA0HbXsVYVL36P5Dcim7eUIO/FkWDVbcKcTWQFIui+gGOFCfY4sVd8H8osAeSOO8TOcRCFRrJ+6DpKVTroh2Mpog7FalEdcK7xeNeYWRCW3jOsC6GJVGsg5WgztXK463nJiiD24Rl3BeIWvSWf77gX2WY31hPAQFNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=EaTRyNy+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b4ff362a8so39806645e9.0
        for <dmaengine@vger.kernel.org>; Mon, 29 Apr 2024 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1714398592; x=1715003392; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dZhm1GMjZVlDRbqaA30av5S8DUdjRayI9dDKqT0i3J0=;
        b=EaTRyNy+HvnXL749mLvymRoYHYEhVFxVy8Expfa/5C2NR8DAZxG9pwa+O5aIKS2Ye2
         aLUwPQkdRnz1YF+dZKJp5qezUS0T/4/D5xRwfPowQ1RR1bsY8x/amQ8HBk1E1L9HFhQd
         nQ4XFr6su97l1x+nLNlX7QnaWT8dtNVXje1hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398592; x=1715003392;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZhm1GMjZVlDRbqaA30av5S8DUdjRayI9dDKqT0i3J0=;
        b=L50D/8KpMOEFbQwdeT0yPX67SZ8FvF4TnFvnJ6JLC3HznDntfeqw6ehRpfursc4DC0
         vpaXVemS0PUUUNA41r9E4xsQH8SgRs85JKeO7b7f00L/Y7jgfTDyR/acqc3Pnnz8w/ML
         fxJVGZat1drDbA/DTcWtQX3rmSLGLdiXBe8wKYVRY6SRcPgZuydtTa7blh/8GRHF+3+J
         lv4MGJWfau3GOT85Ll2yB1J0X8syJxKzig4OQfGoaIy+Kr6BmY+AZZPT34BxC+TtDemJ
         rGLBehxTT1D1V8dqs/67/7CFL+aoXI+Ik7BjklLrjGANd03aYb0hT+aVvLpIIAREd0i4
         OI8g==
X-Gm-Message-State: AOJu0YyJC47R6a85SbcXcbangeATzsl8c1LNyefG5B54sq7opSeWP2nK
	BeiF9lkaeD/BcoNIzmaC7K8nDGBkX/KHOVRtFW7bW5aZSSzKlzgy+iVpp7WgMQTWK2SYCaFRJza
	hAH+fO6fzGED3NppEVUtiSIJFUCXGeLshmPX99GF7Pby/3SKLGVzau9iqEE8m4AAHw89/oQCELS
	U72xekGC2J0haMvcT6cAsT9QbMx5dmJYP3yl0KFnc=
X-Google-Smtp-Source: AGHT+IFLVcZLurxOzawQATyxrST2QDbQzU9npSTJRNCPBBdInBsIWNzHnMi+DjEkZO2fh4Df/yfFXJrqU9IcFeWUr0w=
X-Received: by 2002:a5d:6d83:0:b0:34c:d9f5:c5e0 with SMTP id
 l3-20020a5d6d83000000b0034cd9f5c5e0mr4832697wrs.53.1714398592480; Mon, 29 Apr
 2024 06:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Debief <debief@digigram.com>
Date: Mon, 29 Apr 2024 15:49:26 +0200
Message-ID: <CALYqZ9mmA5RUNn=vn9OxPToDCYzB3RS_3MC2rE9BEQzS4e_nSQ@mail.gmail.com>
Subject: [PATCH]: Fix DMAR Error NO_PASID when IOMMU is enabled
To: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We had a "DMAR Error  NO PASID" error reported in the kernel's log
when the IOMMU was enabled.

This is due to the missing WriteBack area for the C2H stream.
Below my patch.
One point : I didn't compile it within the latest kernel's sources'
tree as it is an extract of our backport of the XDMA support.
Feel free to contact me on any issue with this.

Hope this helps,
Eric.


================================================
From 7db026854cd291677b08e8d137ef4238c8ea96db Mon Sep 17 00:00:00 2001
From: Eric DEBIEF <debief@digigram.com>
Date: Mon, 29 Apr 2024 15:36:24 +0200
Subject: FIX: DMAR Error with IO_MMU.C2H write-back was not set and leads to
 DMAR Error with IOMMU. Add the Writeback structure, allocate it, set it as
 the Src field in the descriptor. Done for all preps functions.

---
 drivers/dma/xilinx/xdma.c | 41 +++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 9c84211d26a1..306099c920bb 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -51,6 +51,20 @@ struct xdma_desc_block {
  dma_addr_t dma_addr;
 };

+/**
+ * struct xdma_c2h_write_back  - Write back block , written by the XDMA.
+ * @magic_status_bit : magic (0x52B4) once written
+ * @length: effective transfer length (in bytes)
+ * @PADDING to be aligned on 32 bytes
+ * @associated dma address
+ */
+struct xdma_c2h_write_back {
+ __le32 magic_status_bit;
+ __le32 length;
+ u32 padding_1[6];
+ dma_addr_t dma_addr;
+};
+
 /**
  * struct xdma_chan - Driver specific DMA channel structure
  * @vchan: Virtual channel
@@ -61,6 +75,8 @@ struct xdma_desc_block {
  * @dir: Transferring direction of the channel
  * @cfg: Transferring config of the channel
  * @irq: IRQ assigned to the channel
+ * @write_back : C2H meta data write back
+
  */
 struct xdma_chan {
  struct virt_dma_chan vchan;
@@ -73,6 +89,7 @@ struct xdma_chan {
  u32 irq;
  struct completion last_interrupt;
  bool stop_requested;
+ struct xdma_c2h_write_back* write_back;
 };

 /**
@@ -628,7 +645,7 @@ xdma_prep_device_sg(struct dma_chan *chan, struct
scatterlist *sgl,
  src = &addr;
  dst = &dev_addr;
  } else {
- dev_addr = xdma_chan->cfg.src_addr;
+ dev_addr = xdma_chan->cfg.src_addr ? xdma_chan->cfg.src_addr :
xdma_chan->write_back->dma_addr;
  src = &dev_addr;
  dst = &addr;
  }
@@ -705,7 +722,7 @@ xdma_prep_dma_cyclic(struct dma_chan *chan,
dma_addr_t address,
  src = &addr;
  dst = &dev_addr;
  } else {
- dev_addr = xdma_chan->cfg.src_addr;
+ dev_addr = xdma_chan->cfg.src_addr ? xdma_chan->cfg.src_addr :
xdma_chan->write_back->dma_addr;
  src = &dev_addr;
  dst = &addr;
  }
@@ -803,6 +820,9 @@ static void xdma_free_chan_resources(struct dma_chan *chan)
  struct xdma_chan *xdma_chan = to_xdma_chan(chan);

  vchan_free_chan_resources(&xdma_chan->vchan);
+ dma_pool_free(xdma_chan->desc_pool,
+ xdma_chan->write_back,
+   xdma_chan->write_back->dma_addr);
  dma_pool_destroy(xdma_chan->desc_pool);
  xdma_chan->desc_pool = NULL;
 }
@@ -816,6 +836,7 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
  struct xdma_chan *xdma_chan = to_xdma_chan(chan);
  struct xdma_device *xdev = xdma_chan->xdev_hdl;
  struct device *dev = xdev->dma_dev.dev;
+ dma_addr_t write_back_addr;

  while (dev && !dev_is_pci(dev))
  dev = dev->parent;
@@ -824,13 +845,25 @@ static int xdma_alloc_chan_resources(struct
dma_chan *chan)
  return -EINVAL;
  }

- xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan), dev,
XDMA_DESC_BLOCK_SIZE,
-       XDMA_DESC_BLOCK_ALIGN, XDMA_DESC_BLOCK_BOUNDARY);
+ //Allocate the pool WITH the H2C write back
+ xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
+ dev,
+ XDMA_DESC_BLOCK_SIZE + sizeof(struct xdma_c2h_write_back),
+ XDMA_DESC_BLOCK_ALIGN,
+ XDMA_DESC_BLOCK_BOUNDARY);
  if (!xdma_chan->desc_pool) {
  xdma_err(xdev, "unable to allocate descriptor pool");
  return -ENOMEM;
  }

+ /* Allocate the C2H write back out of the pool*/
+ xdma_chan->write_back = dma_pool_alloc(xdma_chan->desc_pool,
GFP_NOWAIT, &write_back_addr);
+ if (!xdma_chan->write_back) {
+ xdma_err(xdev, "unable to allocate C2H write back block");
+ return -ENOMEM;
+ }
+ xdma_chan->write_back->dma_addr = write_back_addr;
+
  return 0;
 }

-- 
2.34.1

-- 
 
<https://www.digigram.com/digigram-critical-audio-at-critical-communications-world/>

