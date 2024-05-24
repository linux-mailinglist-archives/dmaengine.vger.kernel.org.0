Return-Path: <dmaengine+bounces-2163-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6C8CE9A4
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 20:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282A71F229BB
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AE542052;
	Fri, 24 May 2024 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="EapH5Vzu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464E4642B
	for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575282; cv=none; b=mlXTnDTT9cKecsK92EICRiK+xEkJvouBjxZizUZ6dUooLwaFfTWKMbnXqoVdOLUI3XAGg0Wenx9wQloTetwcW+KtX2BbkZAlF//G0Y0Zytj1dtAm5suVsfPwoXHm49HvU2vstlXn/exugd+Qa2o+7uDEUvXGofUgkA7qLHtVme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575282; c=relaxed/simple;
	bh=CyDfQLvAvAnEQtfGBunWvar9mbFlVk8eB6mLlJLEUOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mr9n8/xWm5JRoEzQ5GROAMfFaLlkCBGYhKygDmbGuUCPBZWo/ImyGNxMqraQZ5ESLvnPfoh+dCllRtfyAUTEXqQhWZLg4+7kVRL3KjyF3zhLGSVIhHFZIvHOqlr2fzw90u3MV2cbbB8DuwHFtD7DluZUd2KFGgBZod8Uc4t7P98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=EapH5Vzu; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-4202ca70270so41001835e9.3
        for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575275; x=1717180075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA8wcVcwFLmtvy2VP3x9io/V3+kH7xE00SpBiNM4hDU=;
        b=EapH5Vzu3Obz7Ahca2lTgBLMN9X9XWhFwgHYbmtbRXfH7GYK1sfGzsjTP8n0kR1XLu
         iVSiPvtLJhD/y2WKGVMcO/vSW3X2T+YdfgAKsmoWRrvUauSAk0AMFVm0Pw9I0xejzI3+
         KnU/1V7gSLLv78YVq1d0C14qrNw/cnXB3dv1p1DbpH7UBv5iGhVkFlzvIoWQUIUHoo/6
         ZuIosgYxpyFAGUtGxbIF7REEP92uvoPlP2a6t6Z3l6G6jqYgpHfMO3JRUAAADVSCjeNH
         4ccZUzmKFtd7hVOL25cNAq+z435LauLEMx+xlT1nzZ0iJSsZJX+DAhGJgYqWOSvUBQg1
         uoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575275; x=1717180075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA8wcVcwFLmtvy2VP3x9io/V3+kH7xE00SpBiNM4hDU=;
        b=iJL4D9+n0v3dZXaVABILBVlszDSOXX3nvokT9H/RIfRw18nnKM1aWH0g1eCx4dGIbk
         Ol3eG86T7HNyh2VzINyiKHZwwyt3IzKQ2a9S+dsxuRtM1vzQageY756h7wNDuO6zwE28
         5sv3s9Mo8LzqxOydrkdcCpE07pTs+F7evR/rT9tKcO09f7bE3YX4D2eMd94JQlrs3ElP
         bayis+YZTX7LbyoOEsFFfyoeiv/VzOGuxlh6AZ5xUamyYqcJCVmepQgMUNwO9TM4Tdcs
         pH8hUp1TunQMvLSteYHUtSLxkyy4KUpCUoQ+4Y6UpGU6NpB/F2vhxrJIw8NGz56dC7VN
         0gvA==
X-Forwarded-Encrypted: i=1; AJvYcCVp9qjFtYIOX5NQG0bCIV1vXN7fPfLvoncojy8dpaPzcS0RxKEFIahtldiyhHC+1Dbu/0bU0RB7zPFoZhI288KHqVUoS0DPPhzx
X-Gm-Message-State: AOJu0YzWH2h82gBarLoyOVICnRV4l33FdSqqD+MxvX/0eUjgB3+xn6+a
	V9tnpKOYXHRhm4dm8lC1HQc8/+5f6pxPAm32Mh05mXWFxRy+SoeACzih6BuGUsaZDDxxyZ0F/8p
	CYKg0WJROsHtjSU6ptR7Te2H/RsVu9UEV
X-Google-Smtp-Source: AGHT+IFDaLmabHJHQMgitln4OpgM8BEx4a9yXpbL9c/m5s+ybK8fzjM7KEITDWBXUomFqJVUNhNO7yZURk4G
X-Received: by 2002:a05:600c:5746:b0:420:29dd:84f8 with SMTP id 5b1f17b1804b1-42108a99ba4mr30406535e9.32.1716575275682;
        Fri, 24 May 2024 11:27:55 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42108905a6dsm1244535e9.9.2024.05.24.11.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:55 -0700 (PDT)
X-Relaying-Domain: raspberrypi.com
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 08/18] dmaengine: bcm2835: pass dma_chan to generic functions
Date: Fri, 24 May 2024 19:26:52 +0100
Message-Id: <20240524182702.1317935-9-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Wahren <stefan.wahren@i2se.com>

In preparation to support more platforms pass the dma_chan to the
generic functions. This provides access to the DMA device and possible
platform specific data.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index e2f9c8692e6b..aefaa1f01d7f 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -288,12 +288,13 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
 }
 
 static bool
-bcm2835_dma_create_cb_set_length(struct bcm2835_chan *chan,
+bcm2835_dma_create_cb_set_length(struct dma_chan *chan,
 				 struct bcm2835_dma_cb *control_block,
 				 size_t len, size_t period_len,
 				 size_t *total_len)
 {
-	size_t max_len = bcm2835_dma_max_frame_length(chan);
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
+	size_t max_len = bcm2835_dma_max_frame_length(c);
 
 	/* set the length taking lite-channel limitations into account */
 	control_block->length = min_t(u32, len, max_len);
@@ -417,7 +418,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 		/* set up length in control_block if requested */
 		if (buf_len) {
 			/* calculate length honoring period_length */
-			if (bcm2835_dma_create_cb_set_length(c, control_block,
+			if (bcm2835_dma_create_cb_set_length(chan, control_block,
 							     len, period_len,
 							     &total_len)) {
 				/* add extrainfo bits in info */
@@ -485,8 +486,9 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
 	}
 }
 
-static void bcm2835_dma_abort(struct bcm2835_chan *c)
+static void bcm2835_dma_abort(struct dma_chan *chan)
 {
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	void __iomem *chan_base = c->chan_base;
 	long int timeout = 10000;
 
@@ -513,8 +515,9 @@ static void bcm2835_dma_abort(struct bcm2835_chan *c)
 	writel(BCM2835_DMA_RESET, chan_base + BCM2835_DMA_CS);
 }
 
-static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
+static void bcm2835_dma_start_desc(struct dma_chan *chan)
 {
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
 	struct bcm2835_desc *d;
 
@@ -533,7 +536,8 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 
 static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 {
-	struct bcm2835_chan *c = data;
+	struct dma_chan *chan = data;
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	unsigned long flags;
 
@@ -566,7 +570,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 			vchan_cyclic_callback(&d->vd);
 		} else if (!readl(c->chan_base + BCM2835_DMA_ADDR)) {
 			vchan_cookie_complete(&c->desc->vd);
-			bcm2835_dma_start_desc(c);
+			bcm2835_dma_start_desc(chan);
 		}
 	}
 
@@ -594,7 +598,7 @@ static int bcm2835_dma_alloc_chan_resources(struct dma_chan *chan)
 	}
 
 	return request_irq(c->irq_number, bcm2835_dma_callback,
-			   c->irq_flags, "DMA IRQ", c);
+			   c->irq_flags, "DMA IRQ", chan);
 }
 
 static void bcm2835_dma_free_chan_resources(struct dma_chan *chan)
@@ -682,7 +686,7 @@ static void bcm2835_dma_issue_pending(struct dma_chan *chan)
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 	if (vchan_issue_pending(&c->vc) && !c->desc)
-		bcm2835_dma_start_desc(c);
+		bcm2835_dma_start_desc(chan);
 
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 }
@@ -846,7 +850,7 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
 	if (c->desc) {
 		vchan_terminate_vdesc(&c->desc->vd);
 		c->desc = NULL;
-		bcm2835_dma_abort(c);
+		bcm2835_dma_abort(chan);
 	}
 
 	vchan_get_all_descriptors(&c->vc, &head);
-- 
2.34.1


