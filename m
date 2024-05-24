Return-Path: <dmaengine+bounces-2172-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14758CE9D4
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 20:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6811C215BC
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2988874420;
	Fri, 24 May 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Nmvhk/tz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105B5A0F5
	for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575290; cv=none; b=QQXpiQ59XN01jL63F9u/SEENvU3XAq2G7tJlwXmym4E8zbJhSDt1F8lHhINiw+zb+CgP+HArkeb2vnt1DScE3g0nmr8wB+5gMzsF2/zPHvluGpQ9XBOrLjPUpWtkFu0MpPhfwgnq9t+kSIJOt++sIhRqq3gYf990DBP5J9ZkRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575290; c=relaxed/simple;
	bh=+sLcs4QOO6S6PmRZbmAwV/bGLEFVH4urRpzSl6qADg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IUpj6IA2RzINEpQZtxE/7Wryd8POrL7CbmZ/+9DnyeXRq8fVmH72900EnH4eIVTDK9XCJrZwcFQQSsHnqAmuOjANeYH1iOtoa9KEW59yYCVHWFDWL8PUrNVdOmivkNY6HlqD31r4lDSzaD64+bRP5j/X0/K/6Z/Jp8mUSXyU5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Nmvhk/tz; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-4202959b060so65838745e9.2
        for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575282; x=1717180082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaJ2/2ZC9xmhH/6MleK2a1l8XHvCRgt0iv2l1bIIm7k=;
        b=Nmvhk/tzDQSX2UDe/IHZGuA20HUeVV6mdgNpw8qWHuAqivewQ4FGD/71Up1vrHDP7T
         d5Hz36auZWV55kV9GaywU+sQMX/ovYLo3E8AAM4SxVNhI3uww0/PeLR8Yx6/P2ySdeEx
         rNUST7NDHLGTizRbRYTBHzA3weELXzU3RaRj5zzZEk5zOETsdINCPnVK3xSS7LoaZnv7
         E4CCuOT3C4uBfUQMvedSmTxKoXzWW7l8YpCYfFJ9podFut3VqpIFBGZpLQL2xr2IA0ce
         ICWupmMAXOdQzNKhCom0S9F2cvqEFoFhoWHUXON6wLYmt31vIHC0rGblWvV1+Vg9yxPa
         Qy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575282; x=1717180082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaJ2/2ZC9xmhH/6MleK2a1l8XHvCRgt0iv2l1bIIm7k=;
        b=Bo9uJxsnW7PhpIQY60SjQJgQdqY7sP/iJHBvu5WCll75LDeA31HbC3jtPHIoXFhHcU
         zWhxh8yvtf3/xsdlM4LIDJXzGQnAXEZtiABxO94WePZpHn8KUcb5YHA0JglRsyLnQjoo
         ZVo+0fYF7WCN2d4futfFXkUHzFALHsjRKj8oIPy1oICEctQiuD9L+uHVLZoSNPdeCI5e
         KNgiLG/h/f9OvPlAV93kmIY3wwXV8JhT1WhrDvGoStAJXT/0aTA0ylkeCJUfAyoNkB21
         UOUR+aqODdiJqH51+tOGcxjAKijFYwLuVZ12Zg3gnDHBjwLWzFn7qN3mc4Baw4x5tEIK
         kHtw==
X-Forwarded-Encrypted: i=1; AJvYcCVguhJctboi5Vh6evp/Tnjril2WC9GGv0GraoPKoeQMOTXmT9e2ngo8Bc5qBu/7Z5MMyNQAVYXO87zuoENiP5/VFSF3Z6G5HMig
X-Gm-Message-State: AOJu0YyrxuPESCOEC4IPR1fD7zlZm2mO40cpq4cKvHd7/Yj6Y8LckJIH
	sSq8eU/bhrp+q5vK4GbV4yfhVhE2FVVHnUoy1D+9hvXTubODrmpSieEgtfsw1rwgDP3B5BdKrOU
	5uHrgGV64wwvLSw3iPAK16Zh+lXYJqUKk
X-Google-Smtp-Source: AGHT+IGW0tEBfx8ikBiBvNc7paeaC57bk88c6mQfl/2RM8CdfU5tVZ5vx+/JsN/a6nuR9BJ11cex+eTG9kUv
X-Received: by 2002:a7b:cb8e:0:b0:420:2b5e:1808 with SMTP id 5b1f17b1804b1-421089d8182mr27055785e9.16.1716575282092;
        Fri, 24 May 2024 11:28:02 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42100fbb0ffsm5433375e9.53.2024.05.24.11.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:28:02 -0700 (PDT)
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
Subject: [PATCH 18/18] dmaengine: bcm2835: Revert the workaround for DMA addresses
Date: Fri, 24 May 2024 19:27:02 +0100
Message-Id: <20240524182702.1317935-19-dave.stevenson@raspberrypi.com>
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

Now that all DMA clients are passing in CPU addresses, drop
the workaround that would accept those and not try mapping
them.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 06407691ef28..181f2c291109 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -405,17 +405,6 @@ static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_dma_chan_map *map = &c->map;
 
-	if ((dev_addr & 0xfe000000ULL) == 0x7e000000ULL) {
-		/*
-		 * Address is already in the 0x7e... peripherals range.
-		 * Assume this is an old client that hasn't been updated to
-		 * correctly pass a cpu phys_addr to the DMA subsystem.
-		 */
-		map->addr = dev_addr;
-
-		return 0;
-	}
-
 	if (dev_size != DMA_SLAVE_BUSWIDTH_4_BYTES)
 		return -EIO;
 
-- 
2.34.1


