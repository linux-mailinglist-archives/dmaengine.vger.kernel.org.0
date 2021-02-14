Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078B931B083
	for <lists+dmaengine@lfdr.de>; Sun, 14 Feb 2021 14:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhBNNW5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 14 Feb 2021 08:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhBNNWu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 14 Feb 2021 08:22:50 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4B3C061786;
        Sun, 14 Feb 2021 05:22:05 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t29so2556477pfg.11;
        Sun, 14 Feb 2021 05:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=io4iHnTgZXeBAwyR0M009LpKoVlt5BXlMqJVpP1ulmA=;
        b=T4D76JviFgcDdC1bPeB7r7a4KED2uBSQA8dJUwywsE9rPWykdFumtXczk6M8Ye7lZV
         JgKFfzMGyWSJhHtTvRdhp6u/jYSnzx0BnGs7wpJA5onQo3HmU0Qk7HnHjZJp3vX0rFy1
         3XV3KSzAkxRNm8hwvB13+QGTYeulqh9KGVaenGyJrOIeuBRyON2aj/mKr/sbeGHoJZzw
         sAIIcdBVPED2xQd7Br5HXa8Bhj39KJ1Zu+TI0KLyVVVQzQNa+yZ4CqPXajWjpA+D3ZuA
         wqdoKTDTC1mKsJgt4eJJPoV7X6QjUrQMpj0T9bzQpkrXxKUx9Mrl6nNQtWTf16CrP8eM
         fBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=io4iHnTgZXeBAwyR0M009LpKoVlt5BXlMqJVpP1ulmA=;
        b=SCVuY3M1TPz96sprz21xggKwzmAo86oyeQseF3BPHRaZFIjeBBo8oPagjeHD8OxC9P
         zJE+P9uOihC6dhoDZnWnfcbwcma5RYqdhwVfuDg/BPY9WERHoupq22bNNCl0YaMarSei
         VwobQSISwgU0dYcb5W+Fw8TcnUxdb9j7r74uZrBS8bGsx1PVvwCF65aqHuq1AT68gMOi
         xagVRL0kUoQQ26lr/XEZnm6PKmzxSgPpOUd0naC5yx57HpvQyhiO8XcqFqXIlBawqoCk
         dyjR70LCZp/RecubVf+cT8L/ViEdxmhveHPbRAH7tXIMzVLN5/qUtqEZYkN9OovHkPwx
         uwMA==
X-Gm-Message-State: AOAM530n27uktMbkr2YMMS5HTT8fFtAFrVLgntHx5znvTGtimLE2vkVy
        8ljH40SM4ZNl4+TQufv4pyc=
X-Google-Smtp-Source: ABdhPJy6LD3yc9tbWRqjFBiyGa61nK4R34eWEwezVk7WGzvXb/8BLxv6Lv2321icP6HNhR6XoHuduw==
X-Received: by 2002:aa7:88c7:0:b029:1d1:4f1f:5fb6 with SMTP id k7-20020aa788c70000b02901d14f1f5fb6mr11281851pff.14.1613308925401;
        Sun, 14 Feb 2021 05:22:05 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id ck10sm13847368pjb.5.2021.02.14.05.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 05:22:05 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gustavo.pimentel@synopsys.com, vkoul@kernel.org,
        wangzhou1@hisilicon.com, ftoth@exalondelft.nl,
        andy.shevchenko@gmail.com, qiuzhenfa@hisilicon.com,
        dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH 3/3] dmaengine: hisilicon: Add missing call to 'pci_free_irq_vectors()' in probe function
Date:   Sun, 14 Feb 2021 21:21:53 +0800
Message-Id: <20210214132153.575350-4-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210214132153.575350-1-zhengdejin5@gmail.com>
References: <20210214132153.575350-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Call to 'pci_free_irq_vectors()' is missing in the error handling path
of the probe function, So add it.

Fixes: e9f08b65250d73ab ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/dma/hisi_dma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index a259ee010e9b..9e894d7f5dab 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -553,7 +553,7 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ret = devm_add_action_or_reset(dev, hisi_dma_free_irq_vectors, pdev);
 	if (ret)
-		return ret;
+		goto err_free_irq;
 
 	dma_dev = &hdma_dev->dma_dev;
 	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
@@ -572,18 +572,24 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = hisi_dma_enable_hw_channels(hdma_dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable hw channel!\n");
-		return ret;
+		goto err_free_irq;
 	}
 
 	ret = devm_add_action_or_reset(dev, hisi_dma_disable_hw_channels,
 				       hdma_dev);
 	if (ret)
-		return ret;
+		goto err_free_irq;
 
 	ret = dmaenginem_async_device_register(dma_dev);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "failed to register device!\n");
+		goto err_free_irq;
+	}
+
+	return ret;
 
+err_free_irq:
+	pci_free_irq_vectors(pdev);
 	return ret;
 }
 
-- 
2.25.0

