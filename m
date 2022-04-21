Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8C509AEE
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 10:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386815AbiDUIsH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 04:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386821AbiDUIsG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 04:48:06 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76381173;
        Thu, 21 Apr 2022 01:45:16 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q75so3074265qke.6;
        Thu, 21 Apr 2022 01:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKD1G0TxQ0FViMYSyYhesbGvgSZMTzA6rl+8jw/l3Bw=;
        b=WhBcXGi6CJ31duWMxgDx/pwBSst1ebEn8hrDU6caqcNA0X9gTJzReDF62DIY9AP8B5
         NsMHWQDariVBc4Tj1q2rmKY3J91QMZEoY+EBx+bIuTvBMjUjJwWN9uB+t1TRU8IfkmSZ
         QpzUulvEPPJHnQZZyyBZXA64kk4keSxHy8kUJretDVe/IjMwPsLGM2yIorIP5g1v4JJZ
         OuZm5XVbB004kweaCRm1Pw81UAq0QCQSIRy61+6o08Fw5wHfHIOlSwZX2kfhepwVksR7
         4wsb4OUVUEuqFN2l1kbistlj+gntugE7+IHQzzX3N2UPdBuMiDQw7N+vTkHkjH1qldOG
         x5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKD1G0TxQ0FViMYSyYhesbGvgSZMTzA6rl+8jw/l3Bw=;
        b=0Cj/VD4UrEnHjc0yjSwai5smzreQdP0gBaNR+UnzVGL/06GVVTJ1M8k2HaA0Lv9ENv
         Axvfb09qqc9iPzBFouyv5/afqbmCa/PtGuU/9tz6R3S99qySYRky/ROVlaQfmvtnvRBC
         KY/hFefRPIdpqW9KXWaJMaxUtbVEzGdGTsBz+vu5+DydHaovjhUkE90qu+j3QcP/YMpy
         Gep5jfgP61rssKHRyQdHdiNCKEFcfheWn8USY8AzNISW7dYtdgErGs8lPCloc7VBwJPX
         ScBEsdFYdYWsurkjBBpUoWRx7gkOewUbjAEZViTbyeBZCgkAZz7DB8z2cLFjfGwmif42
         cCXQ==
X-Gm-Message-State: AOAM533qC6qnEhO8mhOmidMFXb9Y9ebP6AColVKh6ZjDvrHZtgmjGSRG
        W3mUsN5rdPMp4YCA0fv9md0=
X-Google-Smtp-Source: ABdhPJwvmYRFcj2yjb/bRmq2ixiLjbBQRMuVyg0QIfdvM5fW5Gxj+MFvIjgxnGImYjgI2SjsoHOibQ==
X-Received: by 2002:a05:620a:4451:b0:69e:c6a0:7506 with SMTP id w17-20020a05620a445100b0069ec6a07506mr6975909qkp.313.1650530716017;
        Thu, 21 Apr 2022 01:45:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v14-20020a05622a144e00b002f1f32f86a6sm3070004qtx.5.2022.04.21.01.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:45:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] dma: Make use of the helper function devm_platform_ioremap_resource()
Date:   Thu, 21 Apr 2022 08:45:09 +0000
Message-Id: <20220421084509.2615252-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/dma/imx-sdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 6196a7b3956b..cf4667d10f6a 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2073,7 +2073,6 @@ static int sdma_probe(struct platform_device *pdev)
 	const char *fw_name;
 	int ret;
 	int irq;
-	struct resource *iores;
 	struct resource spba_res;
 	int i;
 	struct sdma_engine *sdma;
@@ -2096,8 +2095,7 @@ static int sdma_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sdma->regs = devm_ioremap_resource(&pdev->dev, iores);
+	sdma->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sdma->regs))
 		return PTR_ERR(sdma->regs);
 
-- 
2.25.1

