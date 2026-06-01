Return-Path: <dmaengine+bounces-11081-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOqUKNnUHGqUTAkAu9opvQ
	(envelope-from <dmaengine+bounces-11081-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:39:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA0A6187D9
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B8A3051CA7
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 00:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4D21E5B88;
	Mon,  1 Jun 2026 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSh5bwWT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6297261A
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274179; cv=none; b=NSH88xwmfwZmWkP2eL5+WgRAYuqYwwalNKPkpbhpBTk6hjqPHcq58DTYHKwPu0Ncn2LIE26u5yTW1ln/uUnv+5xk7fL4IAfCzYDl8KcIjdSgLO5vE6Kf6pmKXfUsykhOVca5t/kzmbG1lNAxgKcbX7nSbAL6cE/GqZEexuoIwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274179; c=relaxed/simple;
	bh=IXal1n7+ZETZvFREA5V3rXNx8P5RBdGRelFW0RYF+ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYCVzOtfyiKdnoFShzd5VWB6W7w4NYy/VD5pxq2DUym3gz6MCLxnx6HHKHXUGuQVk+XOjjAVVTGava0fJhwXzh6lGWdTt1U4IzwPUhAbKQZ7B4wSH+VEj6eSyzJ59IwTbbSADrTjYjgYAqmjx3G2L7T6PY2dTKQtpJx3fisNNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSh5bwWT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf3781ca51so15957485ad.0
        for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780274176; x=1780878976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFhVfMwhRWdAZl7eEyRfgzenuQkgzBp5jMXHeHSYMMw=;
        b=KSh5bwWTGBFTBJ6H1NnCuZsuQGZZZJQ9qNOZ6x+fy3tzUJoPXOR4cXSKfuBPXDGpeP
         i1QcdfjuV/vqZCtGvAzBouIAcRbOuRm3HE5zpqacqc2iRGEnGIin0GBOB8iTKZVCBVK2
         AJX+mSjfJsxDvOtiT0pPU7hZ053TJPgvqDbjfAJbUzpk/qHEs7Y2wR1b7/6fRQ4t+Fla
         C5BAY+NhALzHDD1v+20be+m5xf6Q8sgWZ6YyT0GkbllTyNPG8UuGsYpD5gl5G2aQCKIc
         mefsl7txlZr+8+EPD6o5PAKYyyhkdpErQ8sqMYxfyfAvWYzxH9iNb2VDMl9vWvhLZhwx
         xtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780274176; x=1780878976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fFhVfMwhRWdAZl7eEyRfgzenuQkgzBp5jMXHeHSYMMw=;
        b=prEvQWSLtbvML/2AnsLrKt1c3dwLb5VYcn9nuif1QZNAHDfN/t5hyGtSqWvzRZqnoR
         YQKQWes3EpIwStRdXXPn5ys3wm7hiXjumtjWs32z1YwFQ+VrdPe10fk80wwyLPAlwEZv
         0TsDTo9vcqQhnyQ0Iaas4Tk/NpVitKa8S0L6DLlIlpPxh1nS+db9HAcS/ULl0wM4dzdQ
         JAy5z+Ysn1cwJyswhMaZCIdTtjwb2MpOa+FsDEy39Mrd2CJZNP3SJZWaEVc7+R7vzb3j
         ZebfZLJWIyZsMxvVp5fSY/ny9Pj0hv0QgbtDqqzNuPYM50W2d15obiMVIhbJ2/4945nm
         heow==
X-Gm-Message-State: AOJu0YzMJwP36l18m7iTkIZhFCM8Fk9H4+BNNtkWeeMKGEwOGAFbvzck
	ibqXpphb7neArpYxVwdHJr1m2LN8Q+Y2K95VF5KzE3PBSMZhFeRvjhrExMP9fg==
X-Gm-Gg: Acq92OGGLePDakYD0mmIpVTHz9Ssim9jr1yJ6zoXmiqkca7P6EYqzDNt7iQvfwsUC2L
	wRn8hjjdSSO1Nj99iW4ipFSug5ZFWtgkov3PLf6BULMO2txKrTXTHi/r5Bnb1Df9whfQlasGtfl
	GL7/ZzsPtZUTaBKsnuioeN/YsES8x/uUjB/ZMwKFTU2C28zI6MyDDWt2aDGE3og7u0+Dv7eMK+U
	WetnY/Pq9Ho8lnnzNDDDUy+zq0Oc7FwPeio7WgWVv1/UWSktP1G4k/m6+ZsWtRNXT3+PWTAUSTd
	4eX9Njd4e6EdB2ZNNaVEDTeTsKYUeWjQX/LGEANiVjGVgA1zVXyZL3k/4nYTwVOHtUSNjGHm4rZ
	srfLwJqOzZsR0H3pAo5wjQ16xZaKkBC7fy6uLkJ1Qx62fg1p/HQSrBmbvLOVs9YSyqYO5P/aUjn
	xwYsTU7ng65MD4cBAn8FurFHi5Ho2IJ4DZ4wEu6Za6WhAKHaPRcPZQOpb3rMNz78/38sSxwRKc2
	JlFe5axjlT+booI7P8Q6LHLRb6aTIqLhaeOAav2UpcISyZFZYubFgVt
X-Received: by 2002:a17:903:22c3:b0:2c0:b35d:ed49 with SMTP id d9443c01a7336-2c0b35deee9mr59897065ad.2.1780274175781;
        Sun, 31 May 2026 17:36:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm111929565ad.41.2026.05.31.17.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 17:36:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/5] dmaengine: ti: omap-dma: fix interrupt handling in remove
Date: Sun, 31 May 2026 17:35:52 -0700
Message-ID: <20260601003553.72573-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601003553.72573-1-rosenp@gmail.com>
References: <20260601003553.72573-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11081-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3EA0A6187D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The remove path had several pre-existing bugs:

1. Interrupts are enabled via IRQENABLE_L1 in probe and alloc_chan_resources,
   but the remove path writes to IRQENABLE_L0, which has no effect on the L1
   interrupt line. The DMA engine can continue asserting its IRQ during
   removal. Write to IRQENABLE_L1 instead.

2. devm_free_irq() was called before disabling hardware interrupts. With
   IRQF_SHARED, the hardware may still assert the IRQ line after the handler
   is freed, causing unhandled interrupts that can lead to the kernel
   permanently disabling the shared IRQ line. Disable interrupts first.

3. platform_get_irq() return value was not checked before devm_free_irq().
   If it returns an error code (<= 0), passing it to devm_free_irq() is
   incorrect. Add a guard.

4. Clearing od->irq_enable_mask and writing to IRQENABLE_L1 raced with the
   interrupt handler, which reads irq_enable_mask under the spinlock.
   Hold irq_lock around the disable.

5. The posted write to IRQENABLE_L1 used _relaxed accessors with no
   readback to drain the write buffer. Add a readback flush before
   devm_free_irq() to ensure the hardware has actually disabled the
   interrupt line.

6. omap_dma_free() unconditionally freed all channel memory without
   checking whether clients still held references. A sysfs unbind of the
   DMA controller does not synchronously unbind consumers, so active
   clients could access freed channel memory. Skip freeing channels
   that still have active clients.

Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index dde270646bb9..8c32b7ab50f6 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1516,13 +1516,21 @@ static int omap_dma_chan_init(struct omap_dmadev *od)
 
 static void omap_dma_free(struct omap_dmadev *od)
 {
+	struct omap_chan *c;
+
 	while (!list_empty(&od->ddev.channels)) {
-		struct omap_chan *c = list_first_entry(&od->ddev.channels,
-			struct omap_chan, vc.chan.device_node);
+		c = list_first_entry(&od->ddev.channels,
+				     struct omap_chan, vc.chan.device_node);
 
 		list_del(&c->vc.chan.device_node);
 		tasklet_kill(&c->vc.task);
 		vchan_free_chan_resources(&c->vc);
+		if (c->vc.chan.client_count) {
+			dev_warn(od->ddev.dev,
+				 "chan%d freed with %u client(s)\n",
+				 c->dma_ch, c->vc.chan.client_count);
+			continue;
+		}
 		kfree(c);
 	}
 }
@@ -1870,16 +1878,20 @@ static void omap_dma_remove(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
 
-	irq = platform_get_irq(pdev, 1);
-	devm_free_irq(&pdev->dev, irq, od);
-
 	dma_async_device_unregister(&od->ddev);
 
 	if (!omap_dma_legacy(od)) {
-		/* Disable all interrupts */
-		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
+		spin_lock_irq(&od->irq_lock);
+		od->irq_enable_mask = 0;
+		omap_dma_glbl_write(od, IRQENABLE_L1, 0);
+		spin_unlock_irq(&od->irq_lock);
+		omap_dma_glbl_read(od, IRQENABLE_L1);
 	}
 
+	irq = platform_get_irq(pdev, 1);
+	if (irq > 0)
+		devm_free_irq(&pdev->dev, irq, od);
+
 	omap_dma_free(od);
 
 	if (od->ll123_supported)
-- 
2.54.0


