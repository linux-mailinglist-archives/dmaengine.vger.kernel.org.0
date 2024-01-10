Return-Path: <dmaengine+bounces-712-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24F82A3E0
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jan 2024 23:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1862897BB
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jan 2024 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938CC4F88D;
	Wed, 10 Jan 2024 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5wSflxF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55454F601;
	Wed, 10 Jan 2024 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e4f692d06so14706805e9.1;
        Wed, 10 Jan 2024 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704925417; x=1705530217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/QfoypIDMO0K2Ndnvr0HB3tyVcDqG7prMuOY7ywE+0=;
        b=M5wSflxFA6hBL0MG8HWJrcWPsCO93dZS5Xtw7PUZdF5GmRWF+5PheI4uQYVn/qaA5J
         ehBtNVjnCIhdUvktSaPYik56l71xhWWB7S/Ndf6TfEjDPZUPnIo4+Jn+hu+KBzk6oH0M
         lEPD+L8NbVbdGEl5PHu/Ny9vQNMCI9NefDvc+Dfmk+CNV+nBreMZhfUKDQh2+SgwbE4I
         EbaWbxZVF2q1pqEgPCw0qpAtHSX2s8MOs3Xt+U5l8u8Wdf/VZTZK3Y11UG6wfgW4b0hK
         2XrJ7oPf1+skl7+cn2pCsIDo65zfSydu4OaXDCtyYd5jNB3ux3dSlOT7FqwR9KK3KtIt
         sOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925417; x=1705530217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/QfoypIDMO0K2Ndnvr0HB3tyVcDqG7prMuOY7ywE+0=;
        b=f22ifJIgQhKIgZjVpBQFKvTKS9OmG273YSazQx8us9FPtkS6sI7tsENJ3ilssVgYzw
         Tj8x8qxu1xkHz2GwYHcaPaqOlLf55i0lPzvZNA+J+4OWq114EQQy2JdICJ1K8TNqZFDH
         eg6mV4Gisz0KSOV2X9nMuOpz8/ruiTmvi5BP8hVtMOOHW9/qRyj7ow2t9DraigeKOWT8
         ihlE5wM/t45HFnfXphYUqjFDOMQY6s3wF4FLWHfA4lg8reu9tglJLYzZguVvM7Gpfyhq
         GgXHNVMaCYA5gnQ2g5jHtswuzo227IyiHYvp3pduLXVRevN6SWJsLVwpRHa5/cqGp8/K
         LYfQ==
X-Gm-Message-State: AOJu0Yzvo2yqDdnIyULV8yKAVyCYVnfpirqiHmbtbqzfWSUFDrbcGmJF
	b/D2Wcu6t/rAqf64b1tRBYU=
X-Google-Smtp-Source: AGHT+IEQSzkrGcyzOzDt5HHZwxk+SVLjbEhbbOLOo1a99znKrBnoXfptSw+f92Jwo0GKCKhxJYyVRg==
X-Received: by 2002:a05:600c:a12:b0:40d:8a05:33a4 with SMTP id z18-20020a05600c0a1200b0040d8a0533a4mr74502wmp.33.1704925416622;
        Wed, 10 Jan 2024 14:23:36 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3989:437:3f03:172f])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040e3bdff98asm3494498wmn.23.2024.01.10.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:23:36 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Kees Cook <keescook@chromium.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dmaengine: usb-dmac: Avoid format-overflow warning
Date: Wed, 10 Jan 2024 22:22:10 +0000
Message-Id: <20240110222210.193479-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

gcc points out that the fix-byte buffer might be too small:
drivers/dma/sh/usb-dmac.c: In function 'usb_dmac_probe':
drivers/dma/sh/usb-dmac.c:720:34: warning: '%u' directive writing between 1 and 10 bytes into a region of size 3 [-Wformat-overflow=]
  720 |         sprintf(pdev_irqname, "ch%u", index);
      |                                  ^~
In function 'usb_dmac_chan_probe',
    inlined from 'usb_dmac_probe' at drivers/dma/sh/usb-dmac.c:814:9:
drivers/dma/sh/usb-dmac.c:720:31: note: directive argument in the range [0, 4294967294]
  720 |         sprintf(pdev_irqname, "ch%u", index);
      |                               ^~~~~~
drivers/dma/sh/usb-dmac.c:720:9: note: 'sprintf' output between 4 and 13 bytes into a destination of size 5
  720 |         sprintf(pdev_irqname, "ch%u", index);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Maximum number of channels for USB-DMAC as per the driver is 1-99 so use
u8 instead of unsigned int/int for DMAC channel indexing and make the
pdev_irqname string long enough to avoid the warning.

While at it use scnprintf() instead of sprintf() to make the code more
robust.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/usb-dmac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index a9b4302f6050..f7cd0cad056c 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -706,10 +706,10 @@ static const struct dev_pm_ops usb_dmac_pm = {
 
 static int usb_dmac_chan_probe(struct usb_dmac *dmac,
 			       struct usb_dmac_chan *uchan,
-			       unsigned int index)
+			       u8 index)
 {
 	struct platform_device *pdev = to_platform_device(dmac->dev);
-	char pdev_irqname[5];
+	char pdev_irqname[6];
 	char *irqname;
 	int ret;
 
@@ -717,7 +717,7 @@ static int usb_dmac_chan_probe(struct usb_dmac *dmac,
 	uchan->iomem = dmac->iomem + USB_DMAC_CHAN_OFFSET(index);
 
 	/* Request the channel interrupt. */
-	sprintf(pdev_irqname, "ch%u", index);
+	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
 	uchan->irq = platform_get_irq_byname(pdev, pdev_irqname);
 	if (uchan->irq < 0)
 		return -ENODEV;
@@ -768,8 +768,8 @@ static int usb_dmac_probe(struct platform_device *pdev)
 	const enum dma_slave_buswidth widths = USB_DMAC_SLAVE_BUSWIDTH;
 	struct dma_device *engine;
 	struct usb_dmac *dmac;
-	unsigned int i;
 	int ret;
+	u8 i;
 
 	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
 	if (!dmac)
@@ -869,7 +869,7 @@ static void usb_dmac_chan_remove(struct usb_dmac *dmac,
 static void usb_dmac_remove(struct platform_device *pdev)
 {
 	struct usb_dmac *dmac = platform_get_drvdata(pdev);
-	int i;
+	u8 i;
 
 	for (i = 0; i < dmac->n_channels; ++i)
 		usb_dmac_chan_remove(dmac, &dmac->channels[i]);
-- 
2.34.1


