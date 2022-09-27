Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DCC5EB725
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 03:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiI0BtJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 21:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiI0BtI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 21:49:08 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72702A8311;
        Mon, 26 Sep 2022 18:49:07 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r5so3018818ilm.10;
        Mon, 26 Sep 2022 18:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GOUzxTauu90OFmkFtorzOce0Sm+kwoFJd0CaWPrRcqY=;
        b=MuMAzlTKuTxJkpW7Vq6SVCGbzWGLRWUjcDJ1X6xhujt+wCtTdhb7Rw6YZskVDmD/lw
         cnDnXqW2jE/0cQc7UkcR+HDJpmfoVcCjdqRIpmVmPQi0jaKRW8MS+/bLeu6yO6Oun8dR
         EeQ7kqzWADhXFqQjhf8Hk6hztoHdDr8T6BX/fO+7zbLGgY62Ck5+6TqpFIIRs+kJ1fzb
         SwdeYs+/hjuvrqHw1Lqkst701kxLpE6gC4To1Ehuhe1gT4hOl7qy35M8NnuTM9gOTceU
         HX95GbMnSmMwuzeCg9q5THwuI46uQl6AtksRhaqjch9UoNyNnWjZyrkrmjN71dUp43Bf
         vftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GOUzxTauu90OFmkFtorzOce0Sm+kwoFJd0CaWPrRcqY=;
        b=Dptt9iRVHgaqj5MeZvPcs8qdr6wzskHXcjnovZn6dCDTBJp+7d5w/GSUrcWnOAwlVL
         insLlgVbqhg1049iXBzn8R5PMhgOx33x3RdUQW6YAyxduXA4VwQsJ7Y6XU/JMrPtsMS7
         2PrR/t92QhN7OzzLGoaZiuvs4p4TFuCxYE7q++aEKaY2+XsEF7/8LklAZneg5Kf1c4s5
         g6DD6Fkn0jiooSMxtKCXkW8k2xqtFrg3QZIbWdl+zBgYISSpevP0rWXGefz7CPoaMOmq
         2TE4WpmGgksw50s8itgsGnnCDL0dsodPXLtxuYplu3HgahoX0yPcRH1p9a3vUUmHn9HO
         94bg==
X-Gm-Message-State: ACrzQf1wK0d0cMLK1i0w9dHfaGW8Qnhz0sqrRwMBqc3g5Ya3XzvdGqKL
        Zyl5m/MHkG4+dmi5ebtzBcfUFFrgYuE=
X-Google-Smtp-Source: AMsMyM6TUHLf/H9NNFgBueABIdnQ7ZiHz/0+7klGk14haj9UDIrV+wl3oY8aCoRq2muel66T6Vcp2Q==
X-Received: by 2002:a05:6e02:d4f:b0:2f6:31eb:1c37 with SMTP id h15-20020a056e020d4f00b002f631eb1c37mr11464037ilj.199.1664243346661;
        Mon, 26 Sep 2022 18:49:06 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::ac99])
        by smtp.gmail.com with UTF8SMTPSA id j14-20020a0566022cce00b006a153f7e34asm208347iow.6.2022.09.26.18.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 18:49:06 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 4/4] dmaengine: qcom: gpi: drop redundant of_device_id entries
Date:   Mon, 26 Sep 2022 21:48:46 -0400
Message-Id: <20220927014846.32892-5-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927014846.32892-1-mailingradian@gmail.com>
References: <20220927014846.32892-1-mailingradian@gmail.com>
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

The drivers are transitioning from matching against lists of specific
compatible strings to matching against smaller lists of more generic
compatible strings. Continue the transition in the GPI DMA driver.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/dma/qcom/gpi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 89839864b4ec..e5f37d61f30a 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2289,8 +2289,6 @@ static const struct of_device_id gpi_of_match[] = {
 	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
-	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
-	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sm8450-gpi-dma", .data = (void *)0x10000 },
 	{ },
-- 
2.37.3

