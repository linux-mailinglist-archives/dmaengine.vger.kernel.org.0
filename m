Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22318434DEB
	for <lists+dmaengine@lfdr.de>; Wed, 20 Oct 2021 16:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJTOiS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 10:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhJTOiQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Oct 2021 10:38:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3775DC06161C;
        Wed, 20 Oct 2021 07:36:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q19so3141932pfl.4;
        Wed, 20 Oct 2021 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cfz1Zt+WpCxZx3WpWtEfu9axg9w9nrknlqeCT2LYqKg=;
        b=TiEQgmCq8QCJKAkaZEhFfCgFqbbnx2CBXJ0ol7ukt12WSDD+37xEgSLYQE8k1s0slp
         nG7M6JvQ0645JM3IExH47ak1cZuV2nrtbdZEJMRKkXxKd7RSoqkq7uBPIy4dvDqQ00Rp
         BmOplSFhRgJwcBuBcoehFI/mpZuauYU8S1OIAOqo3ETMiOEjR+KVDJw22/qwyX/l0XjZ
         /5xFjhDYYf0CTLklJE/qFvTMyxAwgjX2O3DXZNgQqdBzZLtf9Gje995xTp0ggug3LyQo
         1hTpU0UgpRCWJVPmV0pWuUCjSO8Yo5Gf2/qAMEgZ+WfIijP5kOM8bdBRv0vgW64dbRH3
         ZNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cfz1Zt+WpCxZx3WpWtEfu9axg9w9nrknlqeCT2LYqKg=;
        b=XtuGbPAkSas4z6mz5XmI7bBfs/aH0uUjAJhTMm+b1UuhSCVRpWcbVZz//V++astkGe
         hFgWE9NHx1BK7ljOG8mRKohghDqAf4ypZmOjRBWBB0+OKN5H6FjQc0YDcoHy2o8v2pot
         IG/nrMbiPFvUr1fjg4csBoHKeCNLOgZEEqVU0b1tLRDbT2m36f3lkvOIZ6xky54eV1Cp
         ZZbmfpnQOTFhRxvSym4csHOfXBGWpJecdpelW7IumnxCR+x8A9Bhn25sy3v8h/+GEeiL
         8AJ8kMwGwEvHeKugjrAym7W7EkXF4XNjw1Z/EMAPWMJiP3PxrhWCx/19n5gZpj8QcYyz
         OJJQ==
X-Gm-Message-State: AOAM531t96nw5U0OUbHw/ztvAbU3OKrtuh4A2hvXZQtUGoo7622HDs2S
        KHHomadCjlH/FLUJ+uojAkI=
X-Google-Smtp-Source: ABdhPJxizZIfK/O3NaQ3AaE+iZnmb6nb6E6g+tM9VSovTFxUPDq6wUHumX7CfgB+fD215PhCx2d74Q==
X-Received: by 2002:a63:7e5c:: with SMTP id o28mr269142pgn.201.1634740561663;
        Wed, 20 Oct 2021 07:36:01 -0700 (PDT)
Received: from localhost.localdomain ([94.177.118.132])
        by smtp.gmail.com with ESMTPSA id j6sm2508771pgf.60.2021.10.20.07.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:36:00 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zou Wei <zou_wei@huawei.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: rcar-dmac: refactor the error handling code of rcar_dmac_probe
Date:   Wed, 20 Oct 2021 22:35:33 +0800
Message-Id: <20211020143546.3436205-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In rcar_dmac_probe, if pm_runtime_resume_and_get fails, it forgets to
disable runtime PM. And of_dma_controller_free should only be invoked
after the success of of_dma_controller_register.

Fix this by refactoring the error handling code.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/dma/sh/rcar-dmac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 6885b3dcd7a9..5c7716fd6bc5 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1916,7 +1916,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = rcar_dmac_init(dmac);
@@ -1924,7 +1924,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(&pdev->dev, "failed to reset device\n");
-		goto error;
+		goto err_pm_disable;
 	}
 
 	/* Initialize engine */
@@ -1958,14 +1958,14 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	for_each_rcar_dmac_chan(i, dmac, chan) {
 		ret = rcar_dmac_chan_probe(dmac, chan);
 		if (ret < 0)
-			goto error;
+			goto err_pm_disable;
 	}
 
 	/* Register the DMAC as a DMA provider for DT. */
 	ret = of_dma_controller_register(pdev->dev.of_node, rcar_dmac_of_xlate,
 					 NULL);
 	if (ret < 0)
-		goto error;
+		goto err_pm_disable;
 
 	/*
 	 * Register the DMA engine device.
@@ -1974,12 +1974,13 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	 */
 	ret = dma_async_device_register(engine);
 	if (ret < 0)
-		goto error;
+		goto err_dma_free;
 
 	return 0;
 
-error:
+err_dma_free:
 	of_dma_controller_free(pdev->dev.of_node);
+err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
-- 
2.25.1

