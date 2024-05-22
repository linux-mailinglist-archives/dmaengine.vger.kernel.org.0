Return-Path: <dmaengine+bounces-2140-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308518CC106
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 14:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610871C23048
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871AA13D602;
	Wed, 22 May 2024 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="TsTrSReW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706A13D607
	for <dmaengine@vger.kernel.org>; Wed, 22 May 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379962; cv=none; b=Yz0soiHyJKaREOalb9GFQzOmJO5e8VHxxKUr7zsFOFyydF+g8z94h4bObcALpl/c43IT+Es6y4HRGfXE8rqs3fbmN29eqKqUw3x/8tG+uV9PctCGQ0OKkbCS362IsMMTJYs46UkrlrVWAeyVkkF67zoWGywPdOdPyyXmRP1EkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379962; c=relaxed/simple;
	bh=zmE38G46UidOOKOl70W646ArAOCvPgF53AqoJ6uNj7g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=itBb/5Apdh/6BIeN1WQxvCsTkseuO6fi3c2sXqjTvLsOhLqWy0ZhgWdnXgzUQSbhWPS85sJsSUmAUivjdnRlGL/F5+jutIw/VNJQmXBX7c9oisMdwfnx56Zjh3TVFTpJmbFIMfpNvAFnAEpCqBJXHaXFAJk2wXggLpVmTR5XiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=TsTrSReW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so776942f8f.3
        for <dmaengine@vger.kernel.org>; Wed, 22 May 2024 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1716379959; x=1716984759; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VqIoOMiOrxAVW145x0Ba22Bkgtdff01c/VQBrz6hzGI=;
        b=TsTrSReWbtS+l/3i6yFKFKu0R/cGggMSYDBuutzmTKuIbjm5zd+qzQY84vRhT1ILTl
         9+L4aM6hLM3AuXYiCKFGL8yE75gCF0vWfKaOJmdPKHDYJokyi7hE1eOfZdTYh0Tls5kl
         hW6wjb+JSaEq43MR/XmwNVQ1oWTBodGbZrrRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716379959; x=1716984759;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqIoOMiOrxAVW145x0Ba22Bkgtdff01c/VQBrz6hzGI=;
        b=b0QxGuudvjeQtC1V7VWWkgWUoFhYRpJs9MP0A7/MVAfK5zHivgH1YD+s1KZef7g62O
         DmyqCpvrgDFt/85sFvoM72PW8cOkM/4SIF9wlIPvGlgeSqPZ3p1LADigsP2LF8yamLM8
         VIIgR+K9kNx6FrWUVHo/vN3es+GX353HYBS6EUGK/I1QneEM+jrr1smeUkfcsqQrdbs8
         4iq4zgJDe+Tf2NRGRW1zrU6QkYt5EKcim463IpwVHoRhSMIzusOwFFrCgBg8krsfyACB
         N2e7Bm/b9x3Yoq+yrYz8JrFwGfbX2pmkHnNRAs9yV9mxULJyT9fqn1pJTOdE2knkSrxf
         uVKQ==
X-Gm-Message-State: AOJu0Yz7N6LbKej3mqCgu922LFuLBVEYjQhgGMmh97fx766L1aSji9F4
	I+QR6bvGiSwseNs2GFMln/n3TYEdDyMOtSLPpC9pRvNE3HC5WKdbLFdHbv+hEpfA9i7ExLvwxkm
	5Zb7ZRqEOw3ik4iik2qpskP/KheT8HLBAjEsoufRUqqNB5XZhHJU=
X-Google-Smtp-Source: AGHT+IGh0mEpZQ5um+ZPY5/OG3UKVEOEaHK2kmeLzbapTrNhWmHeZPu0JP7V/RmIGBorxVRPpT9ApLW2FxmzL4y11UY=
X-Received: by 2002:adf:a1c7:0:b0:354:de28:9eb3 with SMTP id
 ffacd0b85a97d-354de289feamr1313884f8f.0.1716379959019; Wed, 22 May 2024
 05:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Debief <debief@digigram.com>
Date: Wed, 22 May 2024 14:12:13 +0200
Message-ID: <CALYqZ9k3xtoLBUaaqhuzz4cebWnDyScobxA06uzk4Gg6vM2OEQ@mail.gmail.com>
Subject: [RESEND PATCH 2/2] : IRQ Pending signal's state leaved true once stopped
To: dmaengine@vger.kernel.org
Cc: lizhi.hou@amd.com
Content-Type: text/plain; charset="UTF-8"

Hi,

We've observed that the IRQ Pending signal's state stays TRUE once the
XDMA channel is stopped. This is due to the missg acknowledgement
(stats register read) on the last interrupt.
We simply move up the status register read.

Below my patch (corrected).

Hope this helps.
Eric.

From b57bd089b85db6ff65a01e126f104fedb223f04b Mon Sep 17 00:00:00 2001
From: Eric DEBIEF <debief@digigram.com>
Date: Wed, 22 May 2024 12:35:57 +0200
Subject: FIX: IRQ Pending TRUE once the transfer is stopped.

The last interrupt is not acknowledged so the IRQ Pending signal
is HIGH.
Move up the read of the status register to ack the IRQ.
Thus the IRQ Pending signal is lowered.

Signed-off-by: Eric DEBIEF <debief@digigram.com>
---
 drivers/dma/xilinx/xdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 9ae615165cb6..9064793f5d18 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -926,16 +926,16 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)

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

