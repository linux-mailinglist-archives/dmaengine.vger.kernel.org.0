Return-Path: <dmaengine+bounces-1360-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB3E87A918
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 15:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F392890A2
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 14:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9F2481B3;
	Wed, 13 Mar 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fF3e3cVY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB347773
	for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338936; cv=none; b=C8wd1HjMhmHPfm2CV5nC+VxWON+XK7p054PoRyKT7I3LdGPCGJpiSilU0Z2yR3BbOdmuCmtBc21JNzPW5nq40jr4ll8NzPDyiCLw1lDkegKcQKDbafihxgr5+UymRH0d+QJ7qpLvZqvMjlDkDD2pDo0QNLnZS6pHgtrm2EEWXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338936; c=relaxed/simple;
	bh=mJw+46Z541uz+efuQnIUyj6yNxXFxaa2MsAksiuK++o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7UHngd3PdXVdQ6KbF1CIeqsXqBS0qW9OoV/JVEETzpLFaC+dt2vAwuWeLoaZ8pA4U4b2U7apNVedaGeAre5VuDFu/tDy9vn2MDy/m3woFh8wZDLcyWIPZh4kiwZUXUNKawIb6cVvtAji/omPhdHcpuieaFF8fSL6SUKj9R0WI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fF3e3cVY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5684c3313cdso4681152a12.3
        for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710338933; x=1710943733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I53kioFtQ9+NV3RahDpOPJUiNDTHamWrrm2d7gZ/rPs=;
        b=fF3e3cVY1Tu1XDBdM+Sqb/7j2yk4JeLRfz9BvbG5RGklo2y/TfQ0WZqczQR0zte0AX
         ZBF455QUcH+OfFSoBTCYsH8a+FL4CVGh7d3oeBiJcc0pu0+noYXBVHMMm4ity1uQw/m1
         3ly0pgVnen51TbUXzOZspC93n3LMPB4kmGEQdQqiVJ2FikCh1Sm10cWxgmm6X59amc5g
         ke27mhk9eNlfyaVM+39C4xYkY9nMQeMfv5Xr4AX+W8fUzNuinypSeTAU3ZklmOEGQuZr
         SXmlbEd4SDw/4Nr+3/eA/DgOVnsdVQVU+hdrFmB7TDcfyMV6HQEOQH0fPcdJzgJb+UUy
         UVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338933; x=1710943733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I53kioFtQ9+NV3RahDpOPJUiNDTHamWrrm2d7gZ/rPs=;
        b=SxZGN4+1eO8L1xRo8md8/lkvRzfMzThPP5OkmRw3U5AVWcwSdDyj3qqTEyAwvj8bJM
         5iQaoBAuwgB9/2+bGTFQ8IqLXj90ti8y3BEMuSQX1KPOcsxLYgzmgA5md0VwbYmFoAyY
         MsSBW6H0cNT1CAlCs6lllOlsyiDtlv3bh0Az6EhqANlj1UKdMcdP8/Yb9BV939J4Cd2e
         HPmlAeK9ObtJkXxzrtixUO5UGdbyWkAQXJORjngH0QOXRfgc8XfapfGwozcu0MWlQ8I5
         Du5yc07UT4FZb1uDUXaDGgT0uxe633EeA8OSddd/Mpc6VpnTjoJXFx5s4GbqJ+c7pnt1
         en7g==
X-Forwarded-Encrypted: i=1; AJvYcCV4d8AQFRa+M30oSOdqSkpL4UCq1PO61oj4jEaGuQ7MUuGUBc9KWfhl8jdGbGpqN2K+sbQjqdoZ0KvB+r4m7Z5haWkz/UGrvWJE
X-Gm-Message-State: AOJu0YwBM2DYSH7rM4A5W9C+TgthWaj7rqzEuD7aKXDdbRtCIMc90s5S
	CFaAmgBY4LzW6UxmxmWOB4zoJAMdUUlU8gRvVTKMjTLzOBHomSnZaXbo4hnJ4+A=
X-Google-Smtp-Source: AGHT+IHCQaImo5LItH4gVnqRjfNB/SPNM2IFdvzY8VY0xNFroLrYEX7IIpdpQjosUbug1fHTnON4rw==
X-Received: by 2002:a50:9ee2:0:b0:566:131b:5b5f with SMTP id a89-20020a509ee2000000b00566131b5b5fmr8554418edf.26.1710338932962;
        Wed, 13 Mar 2024 07:08:52 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id co25-20020a0564020c1900b00567f6310010sm5081840edb.59.2024.03.13.07.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:08:52 -0700 (PDT)
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
Subject: [PATCH v2 04/15] dmaengine: bcm2835: Support dma flags for multi-beat burst
Date: Wed, 13 Mar 2024 15:08:29 +0100
Message-ID: <897f4540ad1268f3a560a48de8667a6327ce6b7f.1710226514.git.andrea.porta@suse.com>
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

From: Dom Cobley <popcornmix@gmail.com>

Add a control bit to enable a multi-beat burst on a DMA.
This improves DMA performance and is required for HDMI audio.

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 69a77caf78cc..d442f8728c05 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -137,6 +137,7 @@ struct bcm2835_desc {
 #define BCM2835_DMA_S_DREQ	BIT(10) /* enable SREQ for source */
 #define BCM2835_DMA_S_IGNORE	BIT(11) /* ignore source reads - read 0 */
 #define BCM2835_DMA_BURST_LENGTH(x) (((x) & 15) << 12)
+#define BCM2835_DMA_GET_BURST_LENGTH(x) (((x) >> 12) & 15)
 #define BCM2835_DMA_CS_FLAGS(x) ((x) & (BCM2835_DMA_PRIORITY(15) | \
 				      BCM2835_DMA_PANIC_PRIORITY(15) | \
 				      BCM2835_DMA_WAIT_FOR_WRITES | \
@@ -160,6 +161,11 @@ struct bcm2835_desc {
 #define WIDE_DEST(x) (((x) & BCM2835_DMA_WIDE_DEST) ? \
 		      BCM2835_DMA_D_WIDTH : 0)
 
+/* A fake bit to request that the driver requires multi-beat burst */
+#define BCM2835_DMA_BURST BIT(30)
+#define BURST_LENGTH(x) (((x) & BCM2835_DMA_BURST) ? \
+			 BCM2835_DMA_BURST_LENGTH(3) : 0)
+
 /* debug register bits */
 #define BCM2835_DMA_DEBUG_LAST_NOT_SET_ERR	BIT(0)
 #define BCM2835_DMA_DEBUG_FIFO_ERR		BIT(1)
@@ -637,7 +643,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	u32 info = BCM2835_DMA_D_INC | BCM2835_DMA_S_INC |
-		   WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
+		   WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) |
+		   WIDE_DEST(c->dreq) | BURST_LENGTH(c->dreq);
 	u32 extra = BCM2835_DMA_INT_EN;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
@@ -668,8 +675,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src = 0, dst = 0;
-	u32 info = WAIT_RESP(c->dreq) |
-		   WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
+	u32 info = WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) |
+		   WIDE_DEST(c->dreq) | BURST_LENGTH(c->dreq);
 	u32 extra = BCM2835_DMA_INT_EN;
 	size_t frames;
 
@@ -721,7 +728,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src, dst;
-	u32 info = WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
+	u32 info = WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) |
+		   WIDE_DEST(c->dreq) | BURST_LENGTH(c->dreq);
 	u32 extra = 0;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
-- 
2.35.3


