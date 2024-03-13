Return-Path: <dmaengine+bounces-1367-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C987A92C
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 15:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5CD289190
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEEA4AEFD;
	Wed, 13 Mar 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yskxdo81"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447350255
	for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338946; cv=none; b=lxRxmo+MgKHH18vK18Z53nqjJGvi3TG/3lutws1v9uEE9YqMIqNej3/FP4TVs1E5OHvF8CMBgpBqJFdfATRhj3/2D7GExKQNI0nNsK0kQpds4389Zv2Xo4caUG5tc02Y+FkkbC71cHoN+SwH6OELzzzF9HSI24vZ98w2rxhc7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338946; c=relaxed/simple;
	bh=9UBZzqJurtY0u7fZf0OUMVFrBl93Pr0uetCSdgjkIi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZFkUdoirAW0/hYwf8MVIQt7gz1jDFlMpfi8cIJ7TOpV6R7sKg6d+GLcSRjrG0YXei+lUsZB/NMrEm/NZIGEHj8gVBG0g4mevnQcywRIHu7nUW43dgErWSXj831ygfL4fJrrPvOAvW69GRuUogSGlHGvAYWdy2QEIg80qHWS/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yskxdo81; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4645485da6so262789966b.1
        for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710338942; x=1710943742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F0Go8/yyuHye8yt6k5vc23oD+JipLNS/6TGYAxgmkY=;
        b=Yskxdo814Hx6Vpcvz0DpKkotdDA+kf3atgPONI2J3Gjpw+739QTFta39h/RfsdMRsv
         iscEMGZpHulS+xOgpLSwbgC7adw/3KcREq6ATsFJV2TgHRuEhNgD4LvO52lIyra1AQ9B
         F958Fs2Yo9JB/KlMrKWugdNyDh4SsTbtpqdRuGpCXvTCfHmarhcn4NNhi92IwS9OrXA5
         9rGX2VJ+suIEa84uAu80FkwAJuXLzlS0dl+N+KfrNU7W8MBCc4CodaqKhkUwdBKT4A1l
         enD0KjzFSk6Kl31Zi/PBTacJ9Ss4ShZGEvZY8G9XKpcQIkfjI+jn0/AL0tvoVrjCL5P8
         dMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338942; x=1710943742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F0Go8/yyuHye8yt6k5vc23oD+JipLNS/6TGYAxgmkY=;
        b=gFNLsuVUSlbI20LQwuj52dfLpsk9MjXbbMiw2LOojVIVB6+CSgW6QFC6TXckJqwJro
         Lnh+uNGE9txTCjOgVh7tAOf3xwd48udzEf7bQTUTZff01o85LFUHkusewnCY1CTW3TJz
         JJTRUgAxsIEXxna6pPGQqz9XZSFeoYLMWTzEDfWlPc7qC1ivk9ywer7/hmuLrGLMu0af
         WrUxYV3eK9AKuHoM6Gc0HTjE8nFm/JayKZhP1H60bFITBid8xLpNx2UGNCK/ioQFXbs3
         c+vmP40P9v89nhlinOAXlbDmh94qiU/7kVRWg/c+ghq/pp/EzXzufB5TAWqjE83oVp1F
         rn/g==
X-Forwarded-Encrypted: i=1; AJvYcCXXd4u5H0DK/e88XICYdNVfZsDZ8M7Qoq9DYbiGNl0Gc7cgXOBY0vhEGc5g9Wc250APqbt5lwj7BRXD+Eym9tYs2M1Nolk/YANf
X-Gm-Message-State: AOJu0Yw1nyXmz+n6DHlLFcOVf4TSmMQV2nVeKyl4M/e5PD6VghtIJvlV
	g7//C2Mu8fiYEGKE7vD6MMvhLxWViVwELlw9CMy3wlPBItNv2j6IcF7vzlFFKjk=
X-Google-Smtp-Source: AGHT+IEGWqP8QxjwPa6JxODEFxxNSr59dthiRT8AGN4nj6MeDLalxq+7j6Caf6aztQx6EziAU4lTLw==
X-Received: by 2002:a17:906:fb81:b0:a43:29e1:6db8 with SMTP id lr1-20020a170906fb8100b00a4329e16db8mr8168617ejb.9.1710338942448;
        Wed, 13 Mar 2024 07:09:02 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id t5-20020a170906064500b00a45ff821e09sm4778473ejb.150.2024.03.13.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:09:02 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dave.stevenson@raspberrypi.com
Cc: Phil Elwell <phil@raspberrypi.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 11/15] dmaengine: bcm2835: pass dma_chan to generic functions
Date: Wed, 13 Mar 2024 15:08:36 +0100
Message-ID: <2dedf0428cbc5229ea563a571d297a64c8e09c03.1710226514.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710226514.git.andrea.porta@suse.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to support more platforms pass the dma_chan to the
generic functions. This provides access to the DMA device and possible
platform specific data.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 03d97312a3f8..88ae5d05402e 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -308,13 +308,14 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
 	bcm2835_dma_free_cb_chain(container_of(vd, struct bcm2835_desc, vd));
 }
 
-static bool bcm2835_dma_create_cb_set_length(struct bcm2835_chan *chan,
+static bool bcm2835_dma_create_cb_set_length(struct dma_chan *chan,
 					     struct bcm2835_dma_cb *control_block,
 					     size_t len,
 					     size_t period_len,
 					     size_t *total_len)
 {
-	size_t max_len = bcm2835_dma_max_frame_length(chan);
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
+	size_t max_len = bcm2835_dma_max_frame_length(c);
 
 	/* set the length taking lite-channel limitations into account */
 	control_block->length = min_t(u32, len, max_len);
@@ -441,7 +442,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 		if (buf_len) {
 			/* calculate length honoring period_length */
 			if (bcm2835_dma_create_cb_set_length(
-				c, control_block,
+				chan, control_block,
 				len, period_len, &total_len)) {
 				/* add extrainfo bits in info */
 				control_block->info |= extrainfo;
@@ -508,8 +509,9 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
 	}
 }
 
-static void bcm2835_dma_abort(struct bcm2835_chan *c)
+static void bcm2835_dma_abort(struct dma_chan *chan)
 {
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	void __iomem *chan_base = c->chan_base;
 	long timeout = 100;
 
@@ -550,8 +552,9 @@ static void bcm2835_dma_abort(struct bcm2835_chan *c)
 	writel(BCM2835_DMA_RESET, chan_base + BCM2835_DMA_CS);
 }
 
-static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
+static void bcm2835_dma_start_desc(struct dma_chan *chan)
 {
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
 
 	if (!vd) {
@@ -570,7 +573,8 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 
 static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 {
-	struct bcm2835_chan *c = data;
+	struct dma_chan *chan = data;
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	unsigned long flags;
 
@@ -604,7 +608,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 			vchan_cyclic_callback(&d->vd);
 		} else if (!readl(c->chan_base + BCM2835_DMA_ADDR)) {
 			vchan_cookie_complete(&c->desc->vd);
-			bcm2835_dma_start_desc(c);
+			bcm2835_dma_start_desc(chan);
 		}
 	}
 
@@ -632,7 +636,7 @@ static int bcm2835_dma_alloc_chan_resources(struct dma_chan *chan)
 	}
 
 	return request_irq(c->irq_number, bcm2835_dma_callback,
-			   c->irq_flags, "DMA IRQ", c);
+			   c->irq_flags, "DMA IRQ", chan);
 }
 
 static void bcm2835_dma_free_chan_resources(struct dma_chan *chan)
@@ -721,7 +725,7 @@ static void bcm2835_dma_issue_pending(struct dma_chan *chan)
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 	if (vchan_issue_pending(&c->vc) && !c->desc)
-		bcm2835_dma_start_desc(c);
+		bcm2835_dma_start_desc(chan);
 
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 }
@@ -885,7 +889,7 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
 	if (c->desc) {
 		vchan_terminate_vdesc(&c->desc->vd);
 		c->desc = NULL;
-		bcm2835_dma_abort(c);
+		bcm2835_dma_abort(chan);
 	}
 
 	vchan_get_all_descriptors(&c->vc, &head);
-- 
2.35.3


