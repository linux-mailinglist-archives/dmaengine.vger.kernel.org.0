Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D766C557A61
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jun 2022 14:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiFWMeD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jun 2022 08:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiFWMeD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jun 2022 08:34:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66BD41338
        for <dmaengine@vger.kernel.org>; Thu, 23 Jun 2022 05:34:02 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l24-20020a0568301d7800b0060c1ebc6438so15223783oti.9
        for <dmaengine@vger.kernel.org>; Thu, 23 Jun 2022 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7lh7wGIijm5Qy/7/1nvu2I6k52J07wCjQDIVmBhkyv4=;
        b=dbMq+CREpIHjXqUEehGbtixHFAOAd4368iz5/0x1dGld3utckQOTbhkCQyOtKtW7qS
         R9Yk5kWTFs824NcKNQZs3LKsh3TOrXjVp2xNoEyy3v/VxrxewlcAU4CCbP15ELJG6HrC
         6FdMj91nO1ZO2QVVTAIjM87/lQr/5LPAle8MZICnBQ/mG6RR2YFKeo8Ib4xUa2yDOpk1
         La2PSb96JTG2opldhVU/kd4SaqbcLJLRvyLiZzGVIkuvaLEligTeENiSCS5HMSAktP2+
         pIBD/7iKxp8YZ/cDtSIYn1hU/P1mFs94P33ClGmEX23EaDLU0tm63aCcnOyitGEFBIb6
         tQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7lh7wGIijm5Qy/7/1nvu2I6k52J07wCjQDIVmBhkyv4=;
        b=6K/OaiaR/PMAVma9Uho5qQIzIqNxJr61IN21nLlEMFStLFKAmnn7G1FlNX46txXwWu
         E0pdPuEzlFccuM+jrNSLdvwUAGH1+w2FTVWa00iVmKtu6x9ycww7hP3/iPoJ9SgO7BAy
         hycheGZI0TTP+IgJ8UP7eSShgYaXBKhcHbdgqbWD5XzYI70dRkBCxoqvWrOSN5s9UBh2
         Xvw/SIzkrr7KWHKc3OgnObjNmM71Dt98q+oKq85+DlP+hvkxqHA1hbWxdkmHODiuBRUN
         9DRRwF9Z4KA0OY16MdnFu7EvpkKiXIChJmILRf8UZ9xJFQuf3yUF2foSYWND7Fq80pfN
         e2yg==
X-Gm-Message-State: AJIora/u7MgcokdWLB49RmrqOCo+p8IZWx62PTcTfuqoOnqsG/fxXkai
        27F7D/NckgxpzbWbqKNRJIQIb5zH73xmWg==
X-Google-Smtp-Source: AGRyM1u5q582SJNlBfJ+dO01qx9WC8icoSBujdSO1QBa5bJZ2N5xl+Qd5VVA/DsAkGnOXSupl4XTLA==
X-Received: by 2002:a9d:6a57:0:b0:616:9957:35c4 with SMTP id h23-20020a9d6a57000000b00616995735c4mr856875otn.63.1655987642100;
        Thu, 23 Jun 2022 05:34:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:485:4b69:26de:50ac:e17b:4c8e])
        by smtp.gmail.com with ESMTPSA id f21-20020a05680814d500b0032f2ccdafc9sm13182608oiw.3.2022.06.23.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 05:34:01 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dmaengine: imx-sdma: Improve the SDMA irq name
Date:   Thu, 23 Jun 2022 09:33:53 -0300
Message-Id: <20220623123353.2570410-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

On SoCs with several SDMA instances, such as i.MX8M for example,
all the SDMA related interrupts appear with the same "sdma" name.

Improve the SDMA irq name by associating it with the SDMA instance
via dev_name(), so that the SDMA irq names can be unique.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/dma/imx-sdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 900cafdaf359..9710b2ba5978 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2183,8 +2183,8 @@ static int sdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
-	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0, "sdma",
-			       sdma);
+	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
+				dev_name(&pdev->dev), sdma);
 	if (ret)
 		goto err_irq;
 
-- 
2.25.1

