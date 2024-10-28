Return-Path: <dmaengine+bounces-3632-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8682B9B39E8
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 20:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84431C21AC8
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 19:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47171DE2D2;
	Mon, 28 Oct 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTITOVI0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A718FC7F;
	Mon, 28 Oct 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142228; cv=none; b=pgLIj/gshWPHXMRv2TmoCyfcZYoHO1fdZ3pjuBf43wNjvWPIbB0Q/E6bfc9YeJeoW/BYnpjjcSzf5yU4P4yTexJpMeS4bOOhOQh0u6x4KxZ7UTbIW24BPxQjHIWV851Of4ma5i0rEw4ydzacVD1wOMmJ0RfSAvKqzwFcaPTlESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142228; c=relaxed/simple;
	bh=ulUP69L6OJ8qwxELaCLyAPm0tpDL3q8IauoU40wSzPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tQE3feCc6B3y1J9Z/Kx2LFx9mGCChcBvg9r31s2j7qAv7WGgGxfKeTb8Xk4n077ieNzsKIJn1M3T6BobGvVptw0ssNE6P/CL7jkzPtRIJ5XYJzWY2v26tvKKiruJApeM+cThjLxACnLdaS48JK39OlYCt001j690A6nfyf4Fq3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTITOVI0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso619480f8f.1;
        Mon, 28 Oct 2024 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730142224; x=1730747024; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EumjPlqo/OwaKuDLCplZJLv7GsAu7zXdwCFO9fyVbt0=;
        b=UTITOVI0PL0n6ijwqZaumOlfolqdcRVCpCR2/YpFOp5nm+gj6q+MNuDhmWhmegMTZy
         Y2+vT3VpJlrcCG1SzwaDUod/8PLsMIqpz7t3ZTFmw3eGlM8BDo751k2G0/ZpQL84QCF/
         5K5OpW/q3C2OqnRe56v6JTFDU85RqeCJtAZ0LeM8y/ivU2AqKJRZO8+rB7fFlqKQEaht
         /IZMKHKaohIpfKqMmyo+qbLVU61VdcreAZx1L4gYfAQmCCaR44WMdh4IL5huRHt5yG35
         HfN02qgTjyfKG3OxuaqjNrh78tyrYjaMOMPo3i5/MyMVdmt0ET3whTEuaw3ayMLQ/R1O
         Zgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730142224; x=1730747024;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EumjPlqo/OwaKuDLCplZJLv7GsAu7zXdwCFO9fyVbt0=;
        b=pAJoIbCk/QF9nhCrsQ5aN45YRCfw8z1KJXiKfbbtpwC3+xp3dwUX6h8RsN4i2SMmyA
         gXnN030tfG/ZfHdUCETwS1tHLSHp08a1oBBzABSj1zICGf83YFmM0o9833eKN6h2HiCg
         PjdZ3xwrZdcmou2VNTrLgG2svJCEr50YlYkNyemBi0NltsV31Vlhf9Hv4MxRi0BNKBOR
         2atHrbx+Tm+sPWRGkSTb/hAeOS2ndWM49HiJ9PvtpuCR4mwxz7dh4phZ88R6VagXylfU
         OICpVoB0nuau9PyUEZ0wu3ucnFP2J3tMKFwWbFuimblb8o1Oc3+mJY20mDvZ1WAJvhoK
         J4yw==
X-Forwarded-Encrypted: i=1; AJvYcCVgXDLd9wWXXpiNRcK+0/FtAbeuLRgd380DTZUVCLvJUj2YX9vY7v/Lb44Ap1RtdR6MGlRTHV2EMSps5xbu@vger.kernel.org, AJvYcCWGIGc5tHJI3Wp1Ijn6+a03Eo9S3QjckqkupyXzKPJGQNt69waD6ziAfV7ObHvkPapbyDbFxJrs9t8=@vger.kernel.org, AJvYcCWWjfyNwX6/fzujiz4dyxiBM7CH9pLpgpFylVRuwdU38Y+HeibIG0pf+E95g9X+DTVlG+U9jHRF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2oYsbM8BPUQRJo5YUjXhYyEvfqNIJCorulc7L8bB5G/R3ufrw
	0zVz6bQQZGP7IitHnwciS95J14vkDZw0mHWoRVyvBHamUy1kitm0HQw8jQ==
X-Google-Smtp-Source: AGHT+IGXMqBBwhHc8UxZfuRc6tyRsx0ixk0d4f9PJQ9ZvmIEwc9xwdFe62Q4Pnz6/UXgK5gbabDlsQ==
X-Received: by 2002:a5d:61d2:0:b0:37c:cc4b:d1d6 with SMTP id ffacd0b85a97d-380611a495cmr8773753f8f.27.1730142224350;
        Mon, 28 Oct 2024 12:03:44 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b93006sm10275161f8f.93.2024.10.28.12.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:03:43 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 28 Oct 2024 20:03:36 +0100
Subject: [PATCH] dmaengine: ti: dma-crossbar: Add missing put_device in
 ti_am335x_xbar_route_allocate
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-ti-dma-crossbar-put_device-v1-1-e8087e1f0a59@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAfgH2cC/x3MOwqFQAxA0a1IagMzo4W6lcdD5hM1hR8SFUHcu
 4PlKe69QUmYFLriBqGTldclw5YFxMkvIyGnbHDG1da4BnfGNHuMsqoGL7gde59yGAmrloIPdds
 YayEPNqGBr2/++z/PC1oqTadsAAAA
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Vinod Koul <vkoul@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730142223; l=2313;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ulUP69L6OJ8qwxELaCLyAPm0tpDL3q8IauoU40wSzPA=;
 b=umrO+fvsT+aAbUufuLU+hzw3p1mvIrcGEdKUvl7A8J4BhzH4rv1wfFkRHojpXfw4y8zXcyFv9
 nxWOM3V9x1oA8Vtj1TDG67/YyfeNu/d8myMyhEXOzWpznvB3bKxG2CY
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The refcount of the device obtained with of_find_device_by_node() must
be decremented when the device is no longer required. Add the missing
calls to put_device(&pdev->dev) in the error paths of
ti_am335x_xbar_route_allocate().

Cc: stable@vger.kernel.org
Fixes: 42dbdcc6bf96 ("dmaengine: ti-dma-crossbar: Add support for crossbar on AM33xx/AM43xx")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Similar to what commit 615a4bfc426e ("dmaengine: ti: Add missing
put_device in ti_dra7_xbar_route_allocate") did for dra7, where the
calls to put_device were also missing in the error paths.
---
 drivers/dma/ti/dma-crossbar.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index 7f17ee87a6dc..ae596b3fc636 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -81,18 +81,22 @@ static void *ti_am335x_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	struct ti_am335x_xbar_data *xbar = platform_get_drvdata(pdev);
 	struct ti_am335x_xbar_map *map;
 
-	if (dma_spec->args_count != 3)
+	if (dma_spec->args_count != 3) {
+		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (dma_spec->args[2] >= xbar->xbar_events) {
 		dev_err(&pdev->dev, "Invalid XBAR event number: %d\n",
 			dma_spec->args[2]);
+		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (dma_spec->args[0] >= xbar->dma_requests) {
 		dev_err(&pdev->dev, "Invalid DMA request line number: %d\n",
 			dma_spec->args[0]);
+		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -100,12 +104,14 @@ static void *ti_am335x_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "Can't get DMA master\n");
+		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
 	}
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (!map) {
 		of_node_put(dma_spec->np);
+		put_device(&pdev->dev);
 		return ERR_PTR(-ENOMEM);
 	}
 

---
base-commit: dec9255a128e19c5fcc3bdb18175d78094cc624d
change-id: 20241028-ti-dma-crossbar-put_device-39ebab498011

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


