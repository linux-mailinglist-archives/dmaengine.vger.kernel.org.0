Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C95E299C
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2019 06:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390590AbfJXEn4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Oct 2019 00:43:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39975 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390452AbfJXEn4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Oct 2019 00:43:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so14305018pfb.7;
        Wed, 23 Oct 2019 21:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DGvsutXz3Va8MZNR1BWYtmUMeqR2Mgk81F6e8jFyn/0=;
        b=nOfQByySorFjQbh+5XHg4z1JE9rR8h0M8SSTlVPR/zghBnVyu72YPX8wJRhTZRxxpr
         H/RNFGKcUMUu7c+eRPCiFJN2EN4pmF7PNL+S4Dn01if5myQ1PREqCl+1Fdlt/8+h953W
         1+ExVi8jfHpU6zlcX7/qxt9/F7BDVq+ztye0UYRGYDTr2RuBCiquQW8kPzzA8Ty9X6WJ
         GCjkkj+R3BByaQ6JNb0+sQTmtH4nCagRiaKKtA3ZXmcQAFGJbozjBtwuZYyKaQQpTNKi
         KkJUcNZPLH13JIrRR0MjJxmUMIFodZpheDdCHoZ3zH/rju5gAP3aCVcNEuUD0Sf44gS8
         5UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DGvsutXz3Va8MZNR1BWYtmUMeqR2Mgk81F6e8jFyn/0=;
        b=o1tYSr3vaCM3fo/erWvbYrwxHjFc6oXzh8I+QV+QYO/Goam9lX83C9N58I0YDdyB1F
         MyeSKW7VI3I5R4hzKF4t6MqFn05vWwBZjTl2hvMDGb0Do6H+583CWd7ZpoERbUL7E2Lq
         uS2Rwr6T6DmDqNDipMzngXGLi5cIcuA1+BSrFH42eKhJ0QXxfFotjRZiSbZmJvwhdBtp
         g4YyhCELlKt1Mrk7vA+nR/vYgWD8ATwX6jU2W88tAp+Ig0nsF0Wfz3/+73tXQF5a6LUE
         VjeivljFA6r5n9dmZcke388HKGHYpzPFJzSJ4zNxQU9dv2iBUwdYZV0Wn+tDRjH4fvxa
         /ZYg==
X-Gm-Message-State: APjAAAUAkQr/XSFE069RTzHYCi7IPyH31sjmRY4Uv65YTTqkB5uFeSUQ
        BJDSCHPol5IF8Bjd0XjdhNY=
X-Google-Smtp-Source: APXvYqx2nGeXw6VcyQoFHX/I2YmFJtdNkule4SJatnqCVY9Vbw31cONtoNPkW8QbG7QvD2DDir0s2A==
X-Received: by 2002:aa7:9295:: with SMTP id j21mr14876195pfa.87.1571892235729;
        Wed, 23 Oct 2019 21:43:55 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.60])
        by smtp.gmail.com with ESMTPSA id m9sm1064593pjf.11.2019.10.23.21.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 21:43:54 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     Satendra Singh Thakur <sst2005@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma/mediatek-hs/probe: Fixed a memory leak when devm_request_irq fails
Date:   Thu, 24 Oct 2019 10:13:19 +0530
Message-Id: <20191024044320.1097-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
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

