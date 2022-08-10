Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB6158E74B
	for <lists+dmaengine@lfdr.de>; Wed, 10 Aug 2022 08:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiHJGZk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Aug 2022 02:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiHJGZi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Aug 2022 02:25:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E216580C
        for <dmaengine@vger.kernel.org>; Tue,  9 Aug 2022 23:25:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p18so13379821plr.8
        for <dmaengine@vger.kernel.org>; Tue, 09 Aug 2022 23:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sUpsNHANFcShn0HQeXyxkRhGNXAAKdB8GlTRa9756ww=;
        b=cD/Akxf8gMrdZtq2GbG0V3VmDJcVVsnvzOND8/sTuzCFhkrhk2mS7aYzFuFhe2QNq4
         FmlINk9LOESsm7XLBQ3VCctg6dInKlEk/H2KZtQFdS5CbWrpPbgh5+xD8dlJCPyoe8gN
         9120GeWmebPblMNEzOAZNBTYM7g+3Ul6zw0pUYKiGNDYMxqhLC1tT7hkF0co7VpIUP1K
         Ow0fKP7rRl9EsvCKJnmk/WGC6k8aYfGiYB594rvSSUDLmGfMmuIkXP05NqzBvfIdStg3
         jkszGhMtmdcerf6ZKtyHyW5kSRCWqLfREsmy2lQFSAQQjaahmATLJNKtbHzlfaGGC0pW
         IDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sUpsNHANFcShn0HQeXyxkRhGNXAAKdB8GlTRa9756ww=;
        b=g8EDfmTlPOci6uPh0FMuTAR+moMC9Dwu2KvsEGEDpbs6b4ZnV+isIS3sZWHvRXaABB
         4THPDlow3aKM0k38whjiuZeWOwitzm5ZwLH8zZAhNauM3hjxK1Xl4eSDlyUEUxiiV1OE
         jqHDtoM6cKh92uvA3j1EliedwXDGhUx9qPRJD45gJ+hF6+XARMkAKZvaTT0cU/DxF/M7
         82nPWXozFKYKLfvtZD2hawVcRwiTluOJalCov7+3rK/3NWTtCFqhSgfJtbesqrRx0wsE
         be58RFSp9Iew3qczYZlV9iP9lG0g9VNUSuGu7BIoiWsOU/YdaNatHwF37u1wE0lcp5jX
         CTyw==
X-Gm-Message-State: ACgBeo0BScXqXIv2dHSBeIxrA6KD33hugZP98gruzNvu9srD+wpDw8tU
        xUiThZaDFqRoWd9KDstJUraqMvh9WKs=
X-Google-Smtp-Source: AA6agR6MJ7fb75HacoXOGREwXweyE7cwmZ6GpYVIeslKp+8l3dWl9nEoSxQYjoY4+OWzYbGkffdlcQ==
X-Received: by 2002:a17:90b:4c8d:b0:1f5:29ef:4a36 with SMTP id my13-20020a17090b4c8d00b001f529ef4a36mr2137025pjb.127.1660112736673;
        Tue, 09 Aug 2022 23:25:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e80c00b0015e8d4eb26esm12032216plg.184.2022.08.09.23.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 23:25:36 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     vkoul@kernel.org
Cc:     green.wan@sifive.com, dmaengine@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] dmaengine: sf-pdma:Remove the print function dev_err()
Date:   Wed, 10 Aug 2022 06:25:32 +0000
Message-Id: <20220810062532.13425-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

From the coccinelle check:

./drivers/dma/sf-pdma/sf-pdma.c
Error:line 409 is redundant because platform_get_irq() already prints an
error

./drivers/dma/sf-pdma/sf-pdma.c
Error:line 424 is redundant because platform_get_irq() already prints an
error

So,remove the unnecessary print function dev_err()

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/dma/sf-pdma/sf-pdma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 4f8b8498c5c6..6b524eb6bcf3 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -405,10 +405,8 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
 		chan = &pdma->chans[i];
 
 		irq = platform_get_irq(pdev, i * 2);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "ch(%d) Can't get done irq.\n", i);
+		if (irq < 0)
 			return -EINVAL;
-		}
 
 		r = devm_request_irq(&pdev->dev, irq, sf_pdma_done_isr, 0,
 				     dev_name(&pdev->dev), (void *)chan);
@@ -420,10 +418,8 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
 		chan->txirq = irq;
 
 		irq = platform_get_irq(pdev, (i * 2) + 1);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "ch(%d) Can't get err irq.\n", i);
+		if (irq < 0)
 			return -EINVAL;
-		}
 
 		r = devm_request_irq(&pdev->dev, irq, sf_pdma_err_isr, 0,
 				     dev_name(&pdev->dev), (void *)chan);
-- 
2.25.1
