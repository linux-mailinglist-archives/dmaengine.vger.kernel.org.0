Return-Path: <dmaengine+bounces-2171-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BF38CE9CF
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 20:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB4DB22659
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 18:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40616EB4E;
	Fri, 24 May 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="pbw6huoW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799F56B7A
	for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575289; cv=none; b=JOHOQ9Z4IEFUJS6c0iPJ1oG7L7tBYPB3aQC3mq4BC01OXMrSLfkAEacBw3Ma5idEYQbLsaEJP/OpN4+d99J0lgpcXYgb5qX6VI3jir3AopQDGCCIDwRzD5qS9vIkoyKZUnk6zEL5dyEflhEVKmcw0Vhv+7J0sWLTeKKhO5h8SMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575289; c=relaxed/simple;
	bh=HegCCdIEY4pR36AZ8QiWEFIcmksLTJsNsXIyFUq7yl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNNaJVlkKWvauuRn8MHrKzpghYTGyyjOgrqLf4NKZfEqjjw3Q1kQpp7xJMEAwih2GUoz0GpwaNWGqoAsNWEkIBokihUdS0L2YYDzkc1Uu14JO75/QbJZblxAIb04lTuGHo+84Rihrl2eCfDIP9TSQ7EPr244unS+hG9oNtw6s5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=pbw6huoW; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so67782821fa.2
        for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575279; x=1717180079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtSsjB9R4+UVIqScRuc1I4bk33cfKERDT5iPQWCGPm4=;
        b=pbw6huoWpJHSkW6rnnTfQHXZo+T89snmADZc68eQy+0rB5V25z3dVo7uOfjJ0fDEEd
         zFOtb8HeB4NlGE20heQin92G9n1stH9HhEBMXEvJ++dDmD/nS4f1XuSN5zuaDgxKHLcH
         whvf3vUUxc2AL520bsjKTzHKcZFtnB95vKCUg6lpQzyO47SiNk82Rj9b0zZE9EcklSkO
         1HK/YSTdz1Kwnxnn7wACrWjXXfVXdoUMyE7OlbAe9Vwe9vcTyNFnqlQ2+yVeytmpe6ku
         xIqExOH/FcBwmEOlQDaQzIBuDKrw4Gd6iuvvPp1lLfNK5yxju917WcONYsLkk3Chit2u
         z53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575279; x=1717180079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtSsjB9R4+UVIqScRuc1I4bk33cfKERDT5iPQWCGPm4=;
        b=JzxX7WCibwP9lIoAULoCQKhR464GO9J+VPB0a1mIyw8R1tT6fBPwztHbTVynk6JfSy
         mxaGWuqHgG4PLfxmHSsEitdIk1u58Iq7BURfytlOXJq2p59O0FaX/L2WrGMu5BUZve5G
         PXndSFlwY3ArWqtFvKMtkRhaOaod4lBbATCQbWmvJRvAMUG8LRPvlrZfZamUVB+Ujlt8
         fU3NtxQNt/gYmy5OSOU5Z1g3xy2g48RQHm2/ua9gMRwWDDxuPbdj3+BFKFAPWEqhRraM
         XCXL3na+PEuevx0PLf6EbdQoh8SKSDmf3nQGSvpP3W0wXyUl7P8ZD/lombDuWFakK2c4
         /vZw==
X-Forwarded-Encrypted: i=1; AJvYcCUqGw5sPsicg+uxFRcuDM6keW6bWJIyUDhQCWvQ84ouCIJu0s6rkthEgB/lj4qytyAJsibki0P+0vL3iPjXcnLMdjINSR8aSEsI
X-Gm-Message-State: AOJu0Yw+TPqLcXGivCWP+fvSdTsi6NqvqwsuLefkmqMuH5NPgirp0vbI
	UrUF1fqesUOsGYOc1jdOXBdTgFyhTFRw16hQzU7TwQHlNDRr93w034spNN9aNNYxBAZkInG9Ikv
	S8NaNeY5Nx0RchTjtfkMNVcWwE42CP90R
X-Google-Smtp-Source: AGHT+IEUZDsi7SCR4IVByAOz4hmEEdc/AaRCJ/JoMT6C0FVxhy9anVd20JxEW5NHN8g2XEYbzyFyk0QQFB+O
X-Received: by 2002:a2e:9c8f:0:b0:2e6:f59e:226f with SMTP id 38308e7fff4ca-2e95b0bce90mr19539971fa.5.1716575279453;
        Fri, 24 May 2024 11:27:59 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 38308e7fff4ca-2e95be01800sm348091fa.53.2024.05.24.11.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:59 -0700 (PDT)
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
Subject: [PATCH 14/18] mmc: bcm2835: Use phys addresses for slave DMA config
Date: Fri, 24 May 2024 19:26:58 +0100
Message-Id: <20240524182702.1317935-15-dave.stevenson@raspberrypi.com>
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

Contrary to what struct snd_dmaengine_dai_dma_data suggests, the
configuration of addresses of DMA slave interfaces should be done in
CPU physical addresses.

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/mmc/host/bcm2835.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 35d8fdea668b..746a60fac0f0 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -38,7 +38,6 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
@@ -1347,8 +1346,8 @@ static int bcm2835_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct clk *clk;
 	struct bcm2835_host *host;
+	struct resource *iomem;
 	struct mmc_host *mmc;
-	const __be32 *regaddr_p;
 	int ret;
 
 	dev_dbg(dev, "%s\n", __func__);
@@ -1361,23 +1360,13 @@ static int bcm2835_probe(struct platform_device *pdev)
 	host->pdev = pdev;
 	spin_lock_init(&host->lock);
 
-	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
+	host->ioaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &iomem);
 	if (IS_ERR(host->ioaddr)) {
 		ret = PTR_ERR(host->ioaddr);
 		goto err;
 	}
 
-	/* Parse OF address directly to get the physical address for
-	 * DMA to our registers.
-	 */
-	regaddr_p = of_get_address(pdev->dev.of_node, 0, NULL, NULL);
-	if (!regaddr_p) {
-		dev_err(dev, "Can't get phys address\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	host->phys_addr = be32_to_cpup(regaddr_p);
+	host->phys_addr = iomem->start;
 
 	host->dma_chan = NULL;
 	host->dma_desc = NULL;
-- 
2.34.1


