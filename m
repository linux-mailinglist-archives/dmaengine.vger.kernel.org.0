Return-Path: <dmaengine+bounces-2265-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868838FC8A9
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 12:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4BA1C20A19
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 10:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF43190050;
	Wed,  5 Jun 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="E9P3ao0f"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0419006F
	for <dmaengine@vger.kernel.org>; Wed,  5 Jun 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582064; cv=none; b=iTi8CZcINChA60sAbTP7KGC8PM9hpNI3k941fyT3X1aqFqPFqjfp1aFEFaoT+K6Zmmz/I0h1hrztZKt7MhW1O8HMypo4OZV3UKJ4k6NJ4vWINeRK7UGwYbFqiNIVDmJLrbpfKmrqZUSjW/C/fuJX/ZpVPRt9SBMb0e7TdPW/RiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582064; c=relaxed/simple;
	bh=CcGzG1hpNdJEFY4tqni4lhHA0GJzAXaDwyrHV+GJb9o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gJJV7tB05dJa+VYtbDBfTj6yGeEhavnrA30b8If0m69Cv544iKfa8NogZlqVT8aNiv2WI6w09DHIwRiNVG1iI9UeTwUYb6FCOZCoU8CkXZEi1Y66y2CfbnPL46viDsrebx1yrASFVxw3ic8Yik4LBjxFFRnNNt8MvN0ewBf83FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=E9P3ao0f; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b7ffd9f6eso6637223e87.3
        for <dmaengine@vger.kernel.org>; Wed, 05 Jun 2024 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1717582061; x=1718186861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GSIkQ7xeaTPYBDRPGg4aRUM5IWx1vIJgABOS8XYZ24A=;
        b=E9P3ao0ffQR69ATW3yy7YMQhUSGixHdRfpqwnYJVHlNY4pvG7ZZLQuDmEgOO9+0AA7
         3dPp71vfzz7NCtrk/DJ+nhlDN2d0rCaA6LT9eOlnKukDICpmchi8wUpxsYeEh0e4QWSy
         41EDQJNYHTfjYWFvIe3JCpqjuKdeH669F+mas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582061; x=1718186861;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSIkQ7xeaTPYBDRPGg4aRUM5IWx1vIJgABOS8XYZ24A=;
        b=cJMQsjmUslA8NmKAUCMA8xpq4HWSn0X9cN4zC/po6O2T2gyshLMjfWpWIuG6NXtiZP
         OSIwpEU0lZ7N4McWPm3QjH1MYRB23E6+8bO6KrkBwH2K8VP6LlMkaWO4MH0I27auBpkg
         Rb17v9581RrlLrdtEphJmo/ZFXsyUqIvmpJSyIn5baBscbWJzIX4QFObM8b8PJYYLezq
         EcOdHK5mAeX8I6z4IvVvN98EgTslfvGZauPmLsuMDRPcSHrgklTmZZSyaXWtucAoF1hy
         qSS+F+9lT3dPP/0mEISyEwF/Am7/XjCXHFfwSoJGAIO9Le0PnEY6oACBaTxlGraOd8jb
         /tvA==
X-Gm-Message-State: AOJu0YwXeT6kM3TkQkqIT5re/jwGv+Uaq8NcPB4AjViQl8FmwpMNrYIC
	X05w6rpFonld7Jzww6f15Dg8+cBEJ6xlESezsp0S6gB6I9eWdL7sfT1JEyM7N8r1En4UpbhfT2y
	gRoMAZTVuP35EZrTnn2RbTyblySB6L3RExDsjjsvUhzktO77MOFh64nrE22/RQ7J1rjuYMI5M4U
	A8H9BlRaqZooZAfmRXEWlJr4gQGEfdrWWxy6M19zs=
X-Google-Smtp-Source: AGHT+IGgjKyhJYWIk9VO6RsUz7mbHSDH0lyLsN4I/tcJ5qA0gNsGFp8u+ea7YU+aIuMFk41JebuWWqxp6d4wCb5sCvw=
X-Received: by 2002:ac2:4adc:0:b0:523:41ba:a297 with SMTP id
 2adb3069b0e04-52bab4b1291mr1250525e87.5.1717582061007; Wed, 05 Jun 2024
 03:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Debief <debief@digigram.com>
Date: Wed, 5 Jun 2024 12:07:15 +0200
Message-ID: <CALYqZ9=X6eLUQGUThiEYYfwErjC74HyBZAF5hoYucNQReoZvEA@mail.gmail.com>
Subject: [PATCH 3/3] : XDMA's channel Stream mode support
To: dmaengine@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"

From 0a2c8951b770e2791b5fa7f8ec242074bcbf5c1f Mon Sep 17 00:00:00 2001
From: Eric DEBIEF <debief@digigram.com>
Date: Mon, 27 May 2024 17:06:08 +0200
Subject: Add XDMA EOP support in C2H stream.

In XDMA'isr the C2H EOP condition is checked
with the Writeback descriptor.
If true, the stream transfer considered as completed.

Signed-off-by: Eric DEBIEF <debief@digigram.com>
---
 drivers/dma/xilinx/xdma-regs.h |  5 +++++
 drivers/dma/xilinx/xdma.c      | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
index 780ac3c9d34d..5765f8f5eb96 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -100,6 +100,11 @@ struct xdma_hw_desc {
 #define XDMA_CHAN_IN_STREAM_MODE(id)    \
     (((u32)(id) & XDMA_CHAN_ID_STREAM_BIT) != 0)

+/* C2H Write back */
+#define XDMA_CHAN_C2H_WB_EOP_BIT        BIT(0)
+#define XDMA_CHAN_C2H_WB_MAGIC_VAL        (0x52B4 << 16)
+#define XDMA_CHAN_C2H_WB_MAGIC_MASK        GENMASK(31, 16)
+
 /* bits of the channel control register */
 #define CHAN_CTRL_RUN_STOP            BIT(0)
 #define CHAN_CTRL_IE_DESC_STOPPED        BIT(1)
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 3c7fcad761e8..247d775ffec2 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -925,6 +925,22 @@ static enum dma_status xdma_tx_status(struct
dma_chan *chan, dma_cookie_t cookie
     return ret;
 }

+
+/**
+ * xdma_is_c2h_eop - C2H channel End of Packet condition status
+ * @xchan : the XDMA channel to be checked
+ */
+static bool xdma_is_c2h_eop(struct xdma_chan *xchan)
+{
+    if ((xchan->c2h_wback != NULL) &&
+    ((xchan->c2h_wback->magic_status_bit & XDMA_CHAN_C2H_WB_MAGIC_MASK) ==
+                XDMA_CHAN_C2H_WB_MAGIC_VAL)) {
+        return (xchan->c2h_wback->magic_status_bit &
XDMA_CHAN_C2H_WB_EOP_BIT) != 0;
+    } else {
+        return false;
+    }
+}
+
 /**
  * xdma_channel_isr - XDMA channel interrupt handler
  * @irq: IRQ number
@@ -941,7 +957,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
     u32 st;
     bool repeat_tx;

-    if (xchan->stop_requested)
+    if ((xchan->stop_requested) || xdma_is_c2h_eop(xchan))
         complete(&xchan->last_interrupt);

     spin_lock(&xchan->vchan.lock);
--
2.34.1

-- 
 
<https://www.digigram.com/digigram-critical-audio-at-eurosatory-2024-in-paris/>

