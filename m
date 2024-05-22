Return-Path: <dmaengine+bounces-2139-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505AB8CC107
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 14:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A871F24B15
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AC57D3E0;
	Wed, 22 May 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="ZaBdw0L5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85B13D602
	for <dmaengine@vger.kernel.org>; Wed, 22 May 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379959; cv=none; b=Ei4Al6VeNHQZUkXTXy5aAD51z8204NlKG2x3DgjJ0G7ekrO1eQpsRg5xaL1VI3x28WqWpXpZCpz1Nl1gzagN304l4JiT3mT+KZ4V8xP8rAZho2Bnv0qYzXFdPjSdcO0wgxsoek9/5BBvPy0za+ph28jgAx0LpXy1jYzU+blRbs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379959; c=relaxed/simple;
	bh=dMOvbRAJa5wZ9stnCajS/gdPE4E3YN4YZ6dG7fr2/bo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qlhAvQ9spynWs4abFyBp9uqnVlBd47Q+EemhHZHelR2AhRaQ8qbnwjnmU5KqRgeKx5Y9Fq87EEqKFyEWwaC+8ZWXr6kIgk7ogbqyXQnTBJBfrxBcAsBWYOsD/ZZLxxoDJ5Fc3ekUlhgT91ERduzo6Ni8fE8u1px+ULk2QOFh25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=ZaBdw0L5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3504f34a086so3799403f8f.1
        for <dmaengine@vger.kernel.org>; Wed, 22 May 2024 05:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1716379956; x=1716984756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L8DWJLRzs+3MrbohaLZolmh+hdHUUG22WY7jhC1OGDM=;
        b=ZaBdw0L5q36C8Qxgcs59H/feom1bf+J90rYLidpfJ5jwcdQAUujJIzqhdZSGPc6UF+
         0O8AWjEhnS/qyXCeQcS2bIk4GUIkQbuy21L2Q3FqndlMU1st/GwI8uH21bEcu3HjnWnm
         Qie4Z0/PSJqFsyQyaudlnmIgy++Pf0aSDsxwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716379956; x=1716984756;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8DWJLRzs+3MrbohaLZolmh+hdHUUG22WY7jhC1OGDM=;
        b=MN5T+pLoht3sHfDGCEmDHYhIAsOF3POdMi+2acN9LPP22OpkYXQ2axrT3G6+wbUDOP
         eQshac9RrRLJy3DdKCv+XkIj4Jd9t1JEj5ly2OQ559wa6w23MBL9j6ijxuR4rondkCz4
         dtUw/7e10gbKg/gYMnGNz31A/1MEiU7QMfSVI23BYIRth5kJyIYK9Xcv01sNSpAtplUg
         z8wJiSoM7DUC6meA2gOdF9uWKU3CwlLgVK3D695Z332Xs3C0KJKf44xYGAZ79eqDZyw/
         5hyGThoCVa2fgl1twvZOmD4qfGxGKqcPck0ttKUVsslRZyMkIR6hArkMrRndV1d7LJJM
         dKmw==
X-Gm-Message-State: AOJu0YxC6m56HtAmiW9P/GKLWkU4+2VQtVpP93gc5fcJdDRSH3+HkEfv
	Q40iiKTFRn3NwcGhcF9aKVPFmk98Q69qwMKnmV/qPvtIdaONvaSf8VbwfvAL3CBcuh4VVIpeVxZ
	BwZrLdgn0STewjoea/8CYEVKgBo/HQ7qZzP3gWzlB12r18122uDc=
X-Google-Smtp-Source: AGHT+IGVDhiBLpg89kLkxirpBkRxPC9qXtW1Qt4JDXb4mX+eD3LR917+gqEUQczdqTtre9hm763C8xkcjYxqFJZnG8k=
X-Received: by 2002:a5d:558e:0:b0:34c:c1c:8413 with SMTP id
 ffacd0b85a97d-354d8d9f738mr1404080f8f.58.1716379956081; Wed, 22 May 2024
 05:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Debief <debief@digigram.com>
Date: Wed, 22 May 2024 14:12:10 +0200
Message-ID: <CALYqZ9myK4rD6gds3j2WeuFq52i6_wghnZ9BVQAaEcVvZ6RxZA@mail.gmail.com>
Subject: [RESEND PATCH 1/2] : Fix DMAR Error NO_PASID when IOMMU is enabled
To: dmaengine@vger.kernel.org
Cc: lizhi.hou@amd.com
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

Below my patch (corrected).

From b8d71851e6a146dcb448b01a671f455afb09ae90 Mon Sep 17 00:00:00 2001
From: Eric DEBIEF <debief@digigram.com>
Date: Wed, 22 May 2024 12:33:06 +0200
Subject: FIX: DMAR Error with IO_MMU enabled.

C2H write-back area was not allocated and set.
This leads to the DMAR Error.

Add the Writeback structure, allocate and set it as
the descriptors's Src field.
Done for all preps functions.

Signed-off-by: Eric DEBIEF <debief@digigram.com>
---
 drivers/dma/xilinx/xdma.c | 44 +++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 74d4a953b50f..9ae615165cb6 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -51,6 +51,20 @@ struct xdma_desc_block {
     dma_addr_t    dma_addr;
 };

+/**
+ * struct xdma_c2h_write_back  - Write back block , written by the XDMA.
+ * @magic_status_bit : magic (0x52B4) once written
+ * @length: effective transfer length (in bytes)
+ * @PADDING to be aligned on 32 bytes
+ * @associated dma address
+ */
+struct xdma_c2h_write_back {
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
+ * @write_back : C2H meta data write back
+
  */
 struct xdma_chan {
     struct virt_dma_chan        vchan;
@@ -73,6 +89,7 @@ struct xdma_chan {
     u32                irq;
     struct completion        last_interrupt;
     bool                stop_requested;
+    struct xdma_c2h_write_back *write_back;
 };

 /**
@@ -628,7 +645,8 @@ xdma_prep_device_sg(struct dma_chan *chan, struct
scatterlist *sgl,
         src = &addr;
         dst = &dev_addr;
     } else {
-        dev_addr = xdma_chan->cfg.src_addr;
+        dev_addr = xdma_chan->cfg.src_addr ?
+            xdma_chan->cfg.src_addr : xdma_chan->write_back->dma_addr;
         src = &dev_addr;
         dst = &addr;
     }
@@ -705,7 +723,8 @@ xdma_prep_dma_cyclic(struct dma_chan *chan,
dma_addr_t address,
         src = &addr;
         dst = &dev_addr;
     } else {
-        dev_addr = xdma_chan->cfg.src_addr;
+        dev_addr = xdma_chan->cfg.src_addr ?
+            xdma_chan->cfg.src_addr : xdma_chan->write_back->dma_addr;
         src = &dev_addr;
         dst = &addr;
     }
@@ -803,6 +822,9 @@ static void xdma_free_chan_resources(struct dma_chan *chan)
     struct xdma_chan *xdma_chan = to_xdma_chan(chan);

     vchan_free_chan_resources(&xdma_chan->vchan);
+    dma_pool_free(xdma_chan->desc_pool,
+                xdma_chan->write_back,
+               xdma_chan->write_back->dma_addr);
     dma_pool_destroy(xdma_chan->desc_pool);
     xdma_chan->desc_pool = NULL;
 }
@@ -816,6 +838,7 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
     struct xdma_chan *xdma_chan = to_xdma_chan(chan);
     struct xdma_device *xdev = xdma_chan->xdev_hdl;
     struct device *dev = xdev->dma_dev.dev;
+    dma_addr_t write_back_addr;

     while (dev && !dev_is_pci(dev))
         dev = dev->parent;
@@ -824,13 +847,26 @@ static int xdma_alloc_chan_resources(struct
dma_chan *chan)
         return -EINVAL;
     }

-    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan), dev,
XDMA_DESC_BLOCK_SIZE,
-                           XDMA_DESC_BLOCK_ALIGN, XDMA_DESC_BLOCK_BOUNDARY);
+    //Allocate the pool WITH the H2C write back
+    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
+                            dev,
+                            XDMA_DESC_BLOCK_SIZE +
+                                sizeof(struct xdma_c2h_write_back),
+                            XDMA_DESC_BLOCK_ALIGN,
+                            XDMA_DESC_BLOCK_BOUNDARY);
     if (!xdma_chan->desc_pool) {
         xdma_err(xdev, "unable to allocate descriptor pool");
         return -ENOMEM;
     }

+    /* Allocate the C2H write back out of the pool*/
+    xdma_chan->write_back = dma_pool_alloc(xdma_chan->desc_pool,
GFP_NOWAIT, &write_back_addr);
+    if (!xdma_chan->write_back) {
+        xdma_err(xdev, "unable to allocate C2H write back block");
+        return -ENOMEM;
+    }
+    xdma_chan->write_back->dma_addr = write_back_addr;
+
     return 0;
 }

--
2.34.1

