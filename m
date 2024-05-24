Return-Path: <dmaengine+bounces-2169-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8F98CE9C9
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 20:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E5B282E18
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34C3D0C5;
	Fri, 24 May 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="l0IgCMzK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B857301
	for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575288; cv=none; b=fff3EiCjhA8Z5VzBWws3Vr2p7vEV2mw4Ck4Z0jdcJgYk9c3TCHv7bmtWoPmgmEN/kaIjGsSs+S9zjfOrtiRcRbSi/woXeQSFY4kl3/q8CAfqj8hu66+852MaC1KbMpTXBBoLYquk8O+Giu0vDeFp8RwbHe3Xv+EiGu6e5+p+Cpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575288; c=relaxed/simple;
	bh=WfcHrNiYZ1rUh5ZyFbpbA7wYQtF/ZVKkB0GXxiX6I+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FwcMk043YOmgBYV/I8NNzCdxLmZFiszSMsR7UiLuKadfMuuZWc1M9FnucPVZJ1wwOXG9yz5+oW51/QGXcj7wdVQsoHtsEkhlmkBrZ0pvesbWtJ+D2XmYlvy+4G6IYgvq2U6suENP14MwhiiOPvn0zs99nXzhAWuG8X5uwn95cC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=l0IgCMzK; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-42108739ed8so13343805e9.0
        for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575281; x=1717180081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0fkVyk6q1d4tTjNi28+nVqK2ri87Lnbs7bXh9cTiug=;
        b=l0IgCMzKayqPSpiSaOfEjaUxi7Xb5gpOxwaSeJeBQW4L4hUjXABzfWycLEL/u5Dq7t
         gu7ojxEmvGT6eeV2pCKUlRGjiGIuh4uJktn1c51/v726sTlmuji08gdJGt3yYLevm/59
         gqvcaQh2knAcmzejRhAtS0yk8M4cbOkqS9rFNVPBDc//B7E+b2eaTJTTBIg8SMFSkIA9
         06hbrAC/6JviK3Np2dd+FTYCEl168sR2y7TgDVDc4Lc1Xd+GlfnTbQbcXeZR0ifxM9rv
         DD4QIDmwMRLiZE7rY3i8NkR2gyCcfPK9Dd97mbkP1SIfBlI1UxzBez5y8bRTMmj2FCEa
         W4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575281; x=1717180081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0fkVyk6q1d4tTjNi28+nVqK2ri87Lnbs7bXh9cTiug=;
        b=aLSs5o6wSdtQigsTowhJ6jDh1MRl7wQfJllu0qZVhwclOQhwom1k33ZcP9eaGBvEJo
         JwgMyLzL8MHTXICqeHE578iQCnmRsWVaTGQOP3IorJM4QEBJbXqcLQ1fNvwxfbo1yEP/
         p6rPpA/hLsqj1NqQhPKZgJ62JJATh2YuSZHp9uu7NnJ5/J9EmXfL+G7IvJROs1oa9VDo
         SID+oSq7BN9+AfyHnsphBh03x1neHXTqHejad3QcisyTScU8NLbEaz6Bd/5I2T4ytal4
         cYXGiqe0R3Sf+8VqrW0KLaEPYExZEirNqzWj+dGSyd50zWtGCNIZCZvAQzIpkjwfa9++
         PMqg==
X-Forwarded-Encrypted: i=1; AJvYcCVeAsH/+XrOavsF6IecQpT/aDjlKlx8oW7FMIIRCvN7BNFQr4jiLiu5B3FuCrU8IIQEv1hIjPbw3ZLKmXwGYDv9tKR4g3V/soK7
X-Gm-Message-State: AOJu0YybGR3Fo2vBgr0qe3Xnmv10vj2Te+r8z0HVgrwbFm6lW9jS4U1F
	9Jf0EyffyQvBUso4mYlg91A8HqfFXWsR5xKnnPIV+NG5Mitged0+3YvIs2RCQCALz/lm/lZbX1j
	rUX+I4lvc3QCWFdLPCU7U3Gt53tiaabxa
X-Google-Smtp-Source: AGHT+IGBxnWkfl21ZWcAGGbY9pK5CCtvRZEInE2s9wbG2L53cMYgxcodxHXuIlPQ/f02qRVKa1ge9AFPlvFh
X-Received: by 2002:a05:600c:3152:b0:421:757:4d3e with SMTP id 5b1f17b1804b1-42108a40f7emr33721035e9.16.1716575280608;
        Fri, 24 May 2024 11:28:00 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42100fb1394sm5457725e9.43.2024.05.24.11.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:28:00 -0700 (PDT)
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
Subject: [PATCH 16/18] drm/vc4: Use phys addresses for slave DMA config
Date: Fri, 24 May 2024 19:27:00 +0100
Message-Id: <20240524182702.1317935-17-dave.stevenson@raspberrypi.com>
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

From: Phil Elwell <phil@raspberrypi.com>

Slave addresses for DMA are meant to be supplied as physical addresses
(contrary to what struct snd_dmaengine_dai_dma_data does).

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index d30f8e8e8967..c2afd72bd96e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2696,7 +2696,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	struct snd_soc_card *card = &vc4_hdmi->audio.card;
 	struct device *dev = &vc4_hdmi->pdev->dev;
 	struct platform_device *codec_pdev;
-	const __be32 *addr;
+	struct resource *iomem;
 	int index, len;
 	int ret;
 
@@ -2732,22 +2732,15 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	}
 
 	/*
-	 * Get the physical address of VC4_HD_MAI_DATA. We need to retrieve
-	 * the bus address specified in the DT, because the physical address
-	 * (the one returned by platform_get_resource()) is not appropriate
-	 * for DMA transfers.
-	 * This VC/MMU should probably be exposed to avoid this kind of hacks.
+	 * Get the physical address of VC4_HD_MAI_DATA.
 	 */
 	index = of_property_match_string(dev->of_node, "reg-names", "hd");
 	/* Before BCM2711, we don't have a named register range */
 	if (index < 0)
 		index = 1;
+	iomem = platform_get_resource(vc4_hdmi->pdev, IORESOURCE_MEM, index);
 
-	addr = of_get_address(dev->of_node, index, NULL, NULL);
-	if (!addr)
-		return -EINVAL;
-
-	vc4_hdmi->audio.dma_data.addr = be32_to_cpup(addr) + mai_data->offset;
+	vc4_hdmi->audio.dma_data.addr = iomem->start + mai_data->offset;
 	vc4_hdmi->audio.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	vc4_hdmi->audio.dma_data.maxburst = 2;
 
-- 
2.34.1


