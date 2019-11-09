Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5FAF5EC3
	for <lists+dmaengine@lfdr.de>; Sat,  9 Nov 2019 12:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfKILfz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Nov 2019 06:35:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44002 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfKILfz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 9 Nov 2019 06:35:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id a18so5460553plm.10;
        Sat, 09 Nov 2019 03:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RPkvyrfedBbWeyTZwzNlXB9DkGbGD3+8P8FOhsdkoDw=;
        b=fA9LXUTy+uzBaE6ACg3sMciWy/pmk8bafM5PrJlxx+/61IoyBypuhoZDWhxguCQnzZ
         QIZ0rNbf0hHAtHzx2qkbaM+RGfY7lmNfNNfhWRrXvlW0tXIgSBlV+QFPhHux2JYxcjC4
         tbhF5VYQ/4ZBVisASZmfOqMwvCuOZeJiZ84fu98M//x1ppDOx2iLkfVpdRDueEwNv8pT
         ryA/6FtYt8U70JlR8won7D8N+SzDgUf98jjOUxXow0UTBpHQMub1r5DDaQmPVxw2Jcmk
         gI7EKyGdV4ya4aplh5FnQzsnWJi1KtiQDeCaY+olpoVnIj/04Vp/uKV3y9Z0GggREPHk
         HcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RPkvyrfedBbWeyTZwzNlXB9DkGbGD3+8P8FOhsdkoDw=;
        b=WR6SUS8Yt+wWbQm1rYwDc2AScdQQ25jKy/wc11YRGs6jh7cpojmMigcN/hd/edif82
         V5uDmcI6D4iDnuH6Z6LmFsy1Q7VJi8OJWT/9ZvSVD0F2rOkXme/Dx+pGy0rx8dWy0Vos
         U1yqT8sJSg0yU8/RbcV+GnAHvtcXBUZttJeGnDMf1OTEXzGBIf6g9JDwyevJTdhpEVV9
         DmO0hc5y14poQdMqObUcNY0eP836ihXAL3xa3he/CD+/c6Unc6G6VeXw73UeMgao+HPz
         Sxl8q0M6jRaaMFB4GqriNSN5dSCLDb/sOFJ5G0UMIghwom1uw2bLLcR8SOkLqCwiHUP7
         6D8w==
X-Gm-Message-State: APjAAAWKHUdGZr9LRCQgNQyxr8wH7QI6+pvJvUGRTF7253oGzNQc95vv
        ecNlkbPGR6u9MuszcbKfMAY=
X-Google-Smtp-Source: APXvYqzwtXIY+k0OyvUU4Bkg5AOcucS9hxURQZLsvnV9PlC6QBWMaauMMsyzwgYYWy1wRwhboZNu/w==
X-Received: by 2002:a17:902:9681:: with SMTP id n1mr16143620plp.87.1573299354291;
        Sat, 09 Nov 2019 03:35:54 -0800 (PST)
Received: from localhost.localdomain ([103.82.150.242])
        by smtp.gmail.com with ESMTPSA id x29sm10518172pfj.131.2019.11.09.03.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 03:35:53 -0800 (PST)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     Satendra Singh Thakur <sst2005@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: mediatek: hsdma_probe: fixed a memory leak when devm_request_irq fails
Date:   Sat,  9 Nov 2019 17:05:23 +0530
Message-Id: <20191109113523.6067-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105165914.GD952516@vkoul-mobl>
References: <20191105165914.GD952516@vkoul-mobl>
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When devm_request_irq fails, currently, the function
dma_async_device_unregister gets called. This doesn't free
the resources allocated by of_dma_controller_register.
Therefore, we have called of_dma_controller_free for this purpose.

Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 v1: modified the subject line with new tags

 drivers/dma/mediatek/mtk-hsdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index 1a2028e1c29e..4c58da742143 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -997,7 +997,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"request_irq failed with err %d\n", err);
-		goto err_unregister;
+		goto err_free;
 	}
 
 	platform_set_drvdata(pdev, hsdma);
@@ -1006,6 +1006,8 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_free:
+	of_dma_controller_free(pdev->dev.of_node);
 err_unregister:
 	dma_async_device_unregister(dd);
 
-- 
2.17.1

