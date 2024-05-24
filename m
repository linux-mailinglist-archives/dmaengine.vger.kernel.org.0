Return-Path: <dmaengine+bounces-2166-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045ED8CE9B7
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 20:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3DD1F229EF
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6315CDD0;
	Fri, 24 May 2024 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="OnA3QUt5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f228.google.com (mail-lj1-f228.google.com [209.85.208.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C3481A6
	for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575285; cv=none; b=AmVEqnK9Y3kq/G+uEgNOfQ9ctx/a7IU/ohCQ0uLrJfjGRWeAoGCM8/1mbdUDDcrg6Dapoakufm7vef8KNUm9V+aVfRscnaF0JxIYY+QPGkGVAigMmwksEhz4x1FOw6vzc1IjczAFgsEjc4aL26XJIYIyGtadKCbnaVnDj6CAu2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575285; c=relaxed/simple;
	bh=HeQH+726CyNd6SDwiRedJyMRoX6cs3MUOfByWaM6V4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxBQrJ7F12RBK2VvwppzQQh4MTEZEYMFXKS7+4fzbiZXzxl4RGx7T5Tl6xj/Pcd9jajEdoT9TI/QVZETXg4y4I+Si09xDaHgUr4qRhlpany2jdcPj0uGb42ZzuRaQ2E1alv5Ybr3FyJu3OZ9lim4MQYQ6/k2hrs+y8kD16mivWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=OnA3QUt5; arc=none smtp.client-ip=209.85.208.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-lj1-f228.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so23931881fa.0
        for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575277; x=1717180077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5/0PmDw861toPHKUvcW29ls0QVOfTRw5AjJ+CnPD2s=;
        b=OnA3QUt5z9UlqM+IzEmWliXQWN3Vih7wB/ZkTOLwpyO5zMFF1eG0xzF8cVkMtptg7U
         E7gm5r4ljsNTKp9a9y0mu2ieIbhfXnGqXaKXkGHy/ajn67eQPrp3NAEXoD1JA/LH+FkZ
         BGl15AKaR2Lwtswzi59KB61XRm/fOmKlXbNcsubDNI7OYA3AD8DI1OYsfaNqaRTkv6nk
         hpsKa3nN8GEvn1TR6M5mqRFTmFHVsE0kMYiY9+08IxJAiNLHW8LvvqEUSZyYrtxat9oG
         nb8ChHxsIlAdRQymUTID5X1imGJLXM2nL7WjmN5Y5FP9UZE7fSInfbCZvrYqeKYLR448
         dhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575277; x=1717180077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5/0PmDw861toPHKUvcW29ls0QVOfTRw5AjJ+CnPD2s=;
        b=qWKmGdx3q+hmWSYUfXwKY52VPxBMu81SJggBjO1LvF97w1I89z9w9+c1QF+Ww+bFif
         rgMZJtXoqGKi/U36y4l+6uqQZt+o7mUCyO2nd8MNazT90ttQAJo1qG5NDHxLEUItakc2
         p0tNRa4l0UXgqyfPOLbh70gMZ22k3zegw2Un0pRgKl36uXXJAdMiLsvB/JZqPDb1zhFe
         jtT/gHTFJAvlpxxYs4t9hJcrsJuCnhtM2Zper0mLRzXEFgGAWJw8HgeXGrNLZ1yDJPKd
         gNd7S9KglPcBlrZkAPSyaP2MgQ7k07Zw4vzxruIH+0zqGFL1bd6WdXlmbtiP0+Ntscn2
         bKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKIAKW5AelxMkv2CQYUL0/Lphhpb9V0gZ0rBcXBJvm9f5+Gd8e5snuwqwMBTTMhLVDjckPqKVH0QYkHtPaLfJvf1MpsNskpghj
X-Gm-Message-State: AOJu0Yz7L44NRPEiB8QaH0qawS9F7UIqPj0FkadOJJUt7fl+qkkSETU8
	o5nF2XFNU90L9leYh0yLMSFNQX3DuB0wsbG3SBL3wGGt6Nd4siPSsBB0uyM9+bAkLtXoRbQxuAc
	vdY8dcSqyMC6r3tdssmcnC0UajDRF1WnJ
X-Google-Smtp-Source: AGHT+IEHAWM6BIO0Edq+CWHOn6Y+ZIrJttwNlxlncG6HGF/KksFdkfl8n2+vvBn5hfO9zRO5ovw/15yBiAgP
X-Received: by 2002:a05:651c:4d4:b0:2e9:61c7:cad3 with SMTP id 38308e7fff4ca-2e961c7cceemr12892461fa.25.1716575276717;
        Fri, 24 May 2024 11:27:56 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 38308e7fff4ca-2e95bcedd3dsm330901fa.19.2024.05.24.11.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:56 -0700 (PDT)
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
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 09/18] dmaengine: bcm2835: Add function to handle DMA mapping
Date: Fri, 24 May 2024 19:26:53 +0100
Message-Id: <20240524182702.1317935-10-dave.stevenson@raspberrypi.com>
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

The code handling DMA mapping is currently incorrect and
needs a sequence of fixups.
Move the mapping out into a separate function and structure
to allow for those fixes to be applied more cleanly.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 46 ++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index aefaa1f01d7f..ef1d95bae84e 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -65,6 +65,10 @@ struct bcm2835_cb_entry {
 	dma_addr_t paddr;
 };
 
+struct bcm2835_dma_chan_map {
+	dma_addr_t addr;
+};
+
 struct bcm2835_chan {
 	struct virt_dma_chan vc;
 
@@ -74,6 +78,7 @@ struct bcm2835_chan {
 	int ch;
 	struct bcm2835_desc *desc;
 	struct dma_pool *cb_pool;
+	struct bcm2835_dma_chan_map map;
 
 	void __iomem *chan_base;
 	int irq_number;
@@ -268,6 +273,19 @@ static inline bool need_dst_incr(enum dma_transfer_direction direction)
 	}
 
 	return false;
+};
+
+static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
+				      phys_addr_t dev_addr,
+				      size_t dev_size,
+				      enum dma_data_direction dev_dir)
+{
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
+	struct bcm2835_dma_chan_map *map = &c->map;
+
+	map->addr = dev_addr;
+
+	return 0;
 }
 
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
@@ -734,13 +752,19 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	}
 
 	if (direction == DMA_DEV_TO_MEM) {
-		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
+		if (bcm2835_dma_map_slave_addr(chan, c->cfg.src_addr,
+					       c->cfg.src_addr_width,
+					       DMA_TO_DEVICE))
 			return NULL;
-		src = c->cfg.src_addr;
+
+		src = c->map.addr;
 	} else {
-		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
+		if (bcm2835_dma_map_slave_addr(chan, c->cfg.dst_addr,
+					       c->cfg.dst_addr_width,
+					       DMA_FROM_DEVICE))
 			return NULL;
-		dst = c->cfg.dst_addr;
+
+		dst = c->map.addr;
 	}
 
 	/* count frames in sg list */
@@ -795,14 +819,20 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 			      __func__, buf_len, period_len);
 
 	if (direction == DMA_DEV_TO_MEM) {
-		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
+		if (bcm2835_dma_map_slave_addr(chan, c->cfg.src_addr,
+					       c->cfg.src_addr_width,
+					       DMA_TO_DEVICE))
 			return NULL;
-		src = c->cfg.src_addr;
+
+		src = c->map.addr;
 		dst = buf_addr;
 	} else {
-		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
+		if (bcm2835_dma_map_slave_addr(chan, c->cfg.dst_addr,
+					       c->cfg.dst_addr_width,
+					       DMA_FROM_DEVICE))
 			return NULL;
-		dst = c->cfg.dst_addr;
+
+		dst = c->map.addr;
 		src = buf_addr;
 	}
 
-- 
2.34.1


