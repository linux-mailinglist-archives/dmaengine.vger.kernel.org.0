Return-Path: <dmaengine+bounces-2157-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE58CE982
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 20:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83214B220BF
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BA543AD5;
	Fri, 24 May 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="tyumMzdp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172C43F8F7
	for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575277; cv=none; b=WpgGpAZIpHC9r4QzwVhXh/+6quizdx1NPnjffalS1YIZ8nTLb57ItsL/6mQgtTE1jjDH64h4qlETyKLYEJBma/jM1k4CR9D+T1Uh64j/JV39fivW1QFaIQEfug8uUBQHMa0rSZaTkLJpT6569p+ovCvT5f0ceqq9QSZAxCRiChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575277; c=relaxed/simple;
	bh=t6EOXzX5NBCieefJXhaqEj/EuhQeMzBIdGFGnmyqFc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lVAzbYbvwP0vRtW7kn+7Q0du6Nssr/5L8N2OrYZRKDpm8z8Do/f4KxSSQdY902ekMnQZldmv/T3vrLy/UI19hT8S2zHK7wHOJk8d10D0umOJtQU5TOmqSlccIyXVGVJeqe/eYoSSiMGQ/cBqRjuW4IsmdsovTtfYakikMyyibi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=tyumMzdp; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-42016c8db2aso33480775e9.0
        for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575272; x=1717180072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmjLsXIH2Amncxc11ehW4fWxMk13TiDZ+O44YXe6Wgk=;
        b=tyumMzdp8FGH9YqbvdldjlPB0bjTiwCyYniuRFs67n7zZL41LXqMUi3apYcvJ/FTA5
         M3kAX0WE4j8SDbpzjxwWCCKxbw1u57Nguq/v2FMPSS4uI6dtAxizOCGZ0eBMI+giPfLs
         QvApk0fZcExSdaNCsei0Em4f1G/bHa02obSiWQYxPJYf2OTrcqNngtG7fqN92qpSMWd4
         qD7ebj+Y4Dpe1rZl9wjNyKqKRINFSoYAGtTAXt2pntSVMA26ch4aqH5QiFZPeqmkseQA
         K4fAR/cssGDV9rbvR/Vs87o/WpMpGCPjJua5UqgwybJZQDrXX7FDKs9zXG64mCd7eDD3
         osvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575272; x=1717180072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmjLsXIH2Amncxc11ehW4fWxMk13TiDZ+O44YXe6Wgk=;
        b=m2DjFMXdpSWZ8b6yfbZ6Bq7IG8gdZqWbHIGWFYzFQlT+OtouH6lNz2+8S5fm+vs3T2
         UlGY0+5Xcw3Qg1gns6arEL/EnaBehWD1hLRJtjM2f6J+9MV6l55yeklxmHrOGoGrH250
         5muu0wi/2Du5iIZ1MXcAaM7+Ymv3ZGbVO391JP3xh1ItAa6RCeEvkKi0g5A9XyIs2RyG
         C/hoGWReXD1M9yu1nr1NDq4AfGdEyqEoxU+8e/whBB3E3pi9feaoCIeB6JR6G6wRoDVi
         /pGrh9rwnFfRw28PjCUybnnu1D4ZReCX4R1ehwSw2hj1tFDZDdBrI5qWQ0SN7hPQrVMA
         qp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVf85/cU4rlo8cdG7y867udF9rTt1htz+BcSMtOVvU16jS305vNCFtltku+2Snn8i84eEq7lVe6JbUs0Hqjay+W8RYjspPrAZl0
X-Gm-Message-State: AOJu0YzrFDIl5DR11QoiQ1OmViF1jzIV7eDOrHK1+/7/Cazrk7GDPRv3
	Yaf0fKcX1Yr4d2mnrTeFmVpPVkDjLNB57h5otdMApV7sr5F+mGHcPXCgBdLJX8KffSwMPS1itXk
	Nlmgpq0rSL0hp/5oCBAXIEPYGKxcP/0rA
X-Google-Smtp-Source: AGHT+IGfOa5XBgeYIs/cH5TAMCHbRBfIruDizHffdZ+UPyoZ3jK796PR+KziATsAgtd+BnPEgr+Se5nRlYpt
X-Received: by 2002:a05:600c:3114:b0:420:2cbe:7ee8 with SMTP id 5b1f17b1804b1-421089f1394mr28435685e9.6.1716575272442;
        Fri, 24 May 2024 11:27:52 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-3557a1cd354sm56646f8f.101.2024.05.24.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:52 -0700 (PDT)
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
Subject: [PATCH 02/18] dmaengine: bcm2835: Support common dma-channel-mask
Date: Fri, 24 May 2024 19:26:46 +0100
Message-Id: <20240524182702.1317935-3-dave.stevenson@raspberrypi.com>
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

Nowadays there is a generic property for dma-channel-mask in the DMA
controller binding. So prefer this one instead of the old vendor specific
one. Print a warning in case the old one is used. Btw use the result of
of_property_read_u32() as return code in error case.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 9d74fe97452e..528c4593b45a 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -941,12 +941,19 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	}
 
 	/* Request DMA channel mask from device tree */
-	if (of_property_read_u32(pdev->dev.of_node,
-			"brcm,dma-channel-mask",
-			&chans_available)) {
-		dev_err(&pdev->dev, "Failed to get channel mask\n");
-		rc = -EINVAL;
-		goto err_no_dma;
+	rc = of_property_read_u32(pdev->dev.of_node, "dma-channel-mask",
+				  &chans_available);
+
+	if (rc) {
+		/* Try deprecated property */
+		if (of_property_read_u32(pdev->dev.of_node,
+					 "brcm,dma-channel-mask",
+					 &chans_available)) {
+			dev_err(&pdev->dev, "Failed to get channel mask\n");
+			goto err_no_dma;
+		}
+
+		dev_warn(&pdev->dev, "brcm,dma-channel-mask deprecated - please update DT\n");
 	}
 
 	/* get irqs for each channel that we support */
-- 
2.34.1


