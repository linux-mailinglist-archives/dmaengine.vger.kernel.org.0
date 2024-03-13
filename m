Return-Path: <dmaengine+bounces-1359-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E807A87A914
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 15:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000C91C22831
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E944779E;
	Wed, 13 Mar 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ClGAc5JM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47246447
	for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338934; cv=none; b=IzWxD8m80sf85l9XLAcaj4ko9w6vrMxgCMF6X05ETRIo79UaKoqdjLNcloZWaES8dxT9IunCO+IG6sYylvmpDvPhJXnwcdcEvST9FccNpgHKRL0rtC53VKFCy3QueG14bPBUF/bb5SfEu4iJj5ZDZht/i+L3VnC6jrGweI5yIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338934; c=relaxed/simple;
	bh=VoefusMX7Ytod/wgz/c8WF/mjN+oMfRNOX8FE9P8irY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlbRmdOemLiAzZckFHJ/oYXtv1ZayDvLUC97exzoA3uJjXU/KbpW1BmEbWu5Fmilyf3dnQlwWBNmt8uw/ENcXVBbzYqYemu9BaPof+p5BIhOeYfbUPHqDelcVWn/jP4gG1pN7azl3M/B1S3GBlsNe+pyZZoCqNWoA3Edq9Bq8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ClGAc5JM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3122b70439so858814666b.3
        for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710338931; x=1710943731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7L2vUwfipr2gKOB26ZSV+Vf7Bi2o+2MhICmn4R7KPa0=;
        b=ClGAc5JMtY+aNJ6AxXFoanQBROAcg5+EYNSdibz3tFRSsRX1eyWyKcr+Fdp6HvxaXA
         a4Cyw5tVrzOlNXHvOQ8dv0z2gcF2/TRyMXSNE5HItLqwN6eF4wLz1Z+iY+1aY2NQh3bm
         S2q2I4Vjd06r4cP5Dp3zVVan+9AFJL6ZBLph8iXl+ZUlf07c1U4Dkn/yKmgHQLoh5HFk
         caFnJ07eZqF3DnAMAv54oFYvx7fGijrqgjEOBw7RPUoJPiwVlRyE+Gn1zv/sh1NZ9L2D
         SbrpliJnU2u8Y2AM/bae/9pXWmWnCLZq3JecfQfHSViV8g6En4MsnjW2Y6b8D4Lpcufd
         D7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338931; x=1710943731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7L2vUwfipr2gKOB26ZSV+Vf7Bi2o+2MhICmn4R7KPa0=;
        b=nl9iYAswLJjJJVCZZq1ThDfqECuFYa8bs+55xCiXB/ahm+4gwX/JTRBQFAVClcUbZv
         Jwdo8ehw58w6eM8mjafbCqjpYDyZw1yn/uURaW9cxsL1pXa0seWvqldpRTx69dbCqH69
         tmKncdCvm4c5XrBVOxQ1lakQG7sNw4g2Tsn106pn+aahQQIOWO+h213kh81LCtlTcEor
         Hmt47dWLL3lu0xGtOPRoJyKTbf6EuuRPy2JOudzsng1xQJNhMxfcoYj6sYeH183jQeRr
         J3Ds8f1JZVZS9Ucjlp/WneJEhTtDAvi6ARJW/+mqVQJ6WUy48PVKAZfyhXTJ45t8DEc1
         fc8A==
X-Forwarded-Encrypted: i=1; AJvYcCXFjuN7QURfN9+iyfzNSngPE/2hloP2THtbZP7bMf1mnVruduLsl9N8WGv3LFFbLMb/xaySGDyl9KKR/he1KWtpTJpedWXSyEaL
X-Gm-Message-State: AOJu0YwPOivPeG5RpkaMxZvwSAk25NDpZpQMJAzDPxw7J3xsykyvE7Op
	UvL/WHmzF5gGQwJ8ykMKmbq1JHCgXqv7qBxDZP3gZil6IoCW7tj19QdPdkfbZ4g=
X-Google-Smtp-Source: AGHT+IFuoxBmQfVemyQzXiLcXvQk5/Bj3gVOpZYZDujxntAraTAYvlG61Hp66sCW3jmCCSgQmgCMXA==
X-Received: by 2002:a17:906:c784:b0:a46:61ef:2846 with SMTP id cw4-20020a170906c78400b00a4661ef2846mr871027ejb.66.1710338931040;
        Wed, 13 Mar 2024 07:08:51 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906469500b00a4667190a35sm88005ejr.37.2024.03.13.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:08:50 -0700 (PDT)
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
	Phil Elwell <phil@raspberrypi.com>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 03/15] dmaengine: bcm2835: Add NO_WAIT_RESP, DMA_WIDE_SOURCE and DMA_WIDE_DEST flag
Date: Wed, 13 Mar 2024 15:08:28 +0100
Message-ID: <af8732c6640eb8f914b712e819c5fcc23f85b86e.1710226514.git.andrea.porta@suse.com>
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

From: Phil Elwell <phil@raspberrypi.com>

Use bit 27 of the dreq value (the second cell of the DT DMA descriptor)
to request that the WAIT_RESP bit is not set.

Use (reserved) bits 24 and 25 of the dreq value
(the second cell of the DT DMA descriptor) to request
that wide source reads or wide dest writes are required

Originally-by: Dom Cobley <popcornmix@gmail.com>
Originally-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 3d9973dd041d..69a77caf78cc 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -145,6 +145,21 @@ struct bcm2835_desc {
 #define BCM2835_DMA_WAIT(x)	(((x) & 31) << 21) /* add DMA-wait cycles */
 #define BCM2835_DMA_NO_WIDE_BURSTS BIT(26) /* no 2 beat write bursts */
 
+/* A fake bit to request that the driver doesn't set the WAIT_RESP bit. */
+#define BCM2835_DMA_NO_WAIT_RESP BIT(27)
+#define WAIT_RESP(x) (((x) & BCM2835_DMA_NO_WAIT_RESP) ? \
+		      0 : BCM2835_DMA_WAIT_RESP)
+
+/* A fake bit to request that the driver requires wide reads */
+#define BCM2835_DMA_WIDE_SOURCE BIT(24)
+#define WIDE_SOURCE(x) (((x) & BCM2835_DMA_WIDE_SOURCE) ? \
+		      BCM2835_DMA_S_WIDTH : 0)
+
+/* A fake bit to request that the driver requires wide writes */
+#define BCM2835_DMA_WIDE_DEST BIT(25)
+#define WIDE_DEST(x) (((x) & BCM2835_DMA_WIDE_DEST) ? \
+		      BCM2835_DMA_D_WIDTH : 0)
+
 /* debug register bits */
 #define BCM2835_DMA_DEBUG_LAST_NOT_SET_ERR	BIT(0)
 #define BCM2835_DMA_DEBUG_FIFO_ERR		BIT(1)
@@ -621,8 +636,9 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 {
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
-	u32 info = BCM2835_DMA_D_INC | BCM2835_DMA_S_INC;
-	u32 extra = BCM2835_DMA_INT_EN | BCM2835_DMA_WAIT_RESP;
+	u32 info = BCM2835_DMA_D_INC | BCM2835_DMA_S_INC |
+		   WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
+	u32 extra = BCM2835_DMA_INT_EN;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -652,7 +668,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src = 0, dst = 0;
-	u32 info = BCM2835_DMA_WAIT_RESP;
+	u32 info = WAIT_RESP(c->dreq) |
+		   WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
 	u32 extra = BCM2835_DMA_INT_EN;
 	size_t frames;
 
@@ -704,7 +721,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src, dst;
-	u32 info = BCM2835_DMA_WAIT_RESP;
+	u32 info = WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
 	u32 extra = 0;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
-- 
2.35.3


