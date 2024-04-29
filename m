Return-Path: <dmaengine+bounces-1973-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973E8B5B22
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1271C20CA1
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF0A76413;
	Mon, 29 Apr 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="Ge2R40hx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36C762DA
	for <dmaengine@vger.kernel.org>; Mon, 29 Apr 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400512; cv=none; b=ljKuo/Tyur3NJI1WZYk3I6u6EQ2TNBMWpenizrg6mHgaU1ck5omt+YqtbxZ5LG3ELK5hwB9S3MxSYJUsy3nnWuF45w1kc1sFugof1vw1mjM3p32/amIhUmABHwLV9o7TjXXOWzou8qbjjrFxvgeqokkoc7xUqU/oLaWWeHXNxjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400512; c=relaxed/simple;
	bh=Jl0bG548FkmJos6XtA5Bpp3QxhWOZohZ8p5aNHTKeqQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KfoaqR7rGbN3VN+fDGGzLwTNWXqFyVv5XBcs3imaxKbN+uM8qzQ4SsKBWGI41c/cyXXws43Ip1wkI2cbLwhdzokBCUaDXquVpwYdiM9320EqSD9Sl0alv//3rl9J2VwirzCNiaNNpF9shWa0XcoZ8yE/LjnMrOnmuY81cCvPN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=Ge2R40hx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34d0c053bf0so685387f8f.0
        for <dmaengine@vger.kernel.org>; Mon, 29 Apr 2024 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1714400509; x=1715005309; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=624/w2KDa7ygFTapZpkyXrvvWzU9w+nx8KMUb3+fu6o=;
        b=Ge2R40hxZrEZIvlrJ/+grVkn/3YWhaq2KzOmtcx7plygh59lQqtojtqF3BO0gURy/p
         50Mnh8bZbd/OH2DKZ/prN0R2r8HdXbhfmdzJz83yhJjYxrBuWnGAgS0o7Avlx+yvb+0b
         790V6calvbY+wI6YcRTxi8aoSdWicr2gh9GBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714400509; x=1715005309;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=624/w2KDa7ygFTapZpkyXrvvWzU9w+nx8KMUb3+fu6o=;
        b=r3TaDDUfYkHN7jRqLmrP2FgpHySd37VTKfeOEcjMjWiosIMDeDQctITk0bJ4Ai6xFI
         yfnObp5zKNEnUktgPPpxVNZamsUZCZfxPkIDb8PR2iIYDDSdVU3FUMMq+rXa/fZMGYE2
         cfFSlh41rlBQ4ZKo/Ye+NTKJUKYgqh5wG9GrqCOvxHnVDpCrdMm74f3YVwR4J5avWBVC
         XocLJm0ZRk+cEV7uSBeivdymJDBOovt7Jb88aoE+M69+3CzKEhn681EBSFylgGJUmKzZ
         PeR1Lk0ofGf62Ot8GKTMBWOn+BjARhi3DpELhSeSIKIsUEoEBgjTWXHLlOCaVNW20GnN
         QWeg==
X-Gm-Message-State: AOJu0Yx62bsLGhK/bjwWxNnmJrejRAzrMIZ/ROVx6hr3QBYy0mB/f2FO
	P4iRV7jQQq24cDFSx+y11AkYKwlwXWTXkSyaXt+Awxor3RO8VcLLwVY/i7SIp7F/PMoPSefqabG
	MqPMWVqzfn3TFz094HtzmSj2WwBm+Sd8skZkQASGqx8ksWHSY/ROJjemUHR0yO0m2Jup9SlqGnS
	1OY3YHCanu3pzjUh9SEG3P8thN6FHz37gb82GouL4=
X-Google-Smtp-Source: AGHT+IEzoQlx9y3XF+EzGFepi/06u5iIZkSubNw5Yxp2bUF7qCQoAMjGELflPuTHPXkW+ZIwJLIfEAC45krB7if5tuk=
X-Received: by 2002:adf:e90a:0:b0:34c:601b:1083 with SMTP id
 f10-20020adfe90a000000b0034c601b1083mr5412708wrm.65.1714400508974; Mon, 29
 Apr 2024 07:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Debief <debief@digigram.com>
Date: Mon, 29 Apr 2024 16:21:23 +0200
Message-ID: <CALYqZ9mqnT7pP6PsZUFvp5XpmrhHXjo+0pQt7mOX2AD0noUjAQ@mail.gmail.com>
Subject: [PATCH] IRQ Pending signal's state leaved true once stopped
To: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We've observed that the IRQ Pending signal's state stays TRUE once the
XDMA channel is stopped. This is due to the missg acknowledgement
(stats register read) on the last interrupt.
We simply move up the status register read.

Below my patch.

Hope this helps.
Eric.

=============================================
From 1f49f5e2537741949b6af90d09c8c22764333ff6 Mon Sep 17 00:00:00 2001
From: Eric DEBIEF <debief@digigram.com>
Date: Mon, 29 Apr 2024 16:16:45 +0200
Subject: FIX: IRQ Pending TRUE once stopped.

The last interrupt is not acknowledged so the IRQ Pending signal's
state is leaved TRUE. Move up the read of the status register to
acknowledge the IRQ lowering the IRQ Pending signal's state.
---
 drivers/dma/xilinx/xdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 306099c920bb..de23f75bc76f 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -923,16 +923,16 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)

     spin_lock(&xchan->vchan.lock);

-    /* get submitted request */
-    vd = vchan_next_desc(&xchan->vchan);
-    if (!vd)
-        goto out;
-
     /* Clear-on-read the status register */
     ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &st);
     if (ret)
         goto out;

+    /* get submitted request */
+    vd = vchan_next_desc(&xchan->vchan);
+    if (!vd)
+        goto out;
+
     desc = to_xdma_desc(vd);

     st &= XDMA_CHAN_STATUS_MASK;
-- 
2.34.1

-- 
 
<https://www.digigram.com/digigram-critical-audio-at-critical-communications-world/>

