Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30E4603216
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 20:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJRSMr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJRSMp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 14:12:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D1B74365;
        Tue, 18 Oct 2022 11:12:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k2so34325403ejr.2;
        Tue, 18 Oct 2022 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9BWsdOmt2DdZ9rM9JV+zrPCJi6ZcySjb5J/mdJmGW4=;
        b=apFEQeVUoC9kYaMCL1ZrShTVl2Gbz8Nn7EAwFWSkjNo2A1a4YetvqT6i8zUUqI5IIT
         xrARLa2v1tCo02v0oXYnrSoPMR+Fn6mTme6LzAwbFUNSuzNrUy2FiPC4pA20QQbJOJTy
         PZGJQTa6xdg4EWYlGPQOiK+hOZMP4l6pOrQvKgL0vaEktZA/qvvQepSnJT+S7HI0jH4r
         XlZpbKEimyAoahZsewt5h3/pweuL/Rh0eVd3XTVqRVIhkYJpC/vs6LVB7Q1shy/HJnJd
         jN7WySWufLuZi9ciS2BkvKOH8OyxxQYxF0L8X8tHmdskoM0UjGaxEVL4OXM5b48RjQ2B
         fBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9BWsdOmt2DdZ9rM9JV+zrPCJi6ZcySjb5J/mdJmGW4=;
        b=pz/Si6goxQAt/2EFchCx5fXbuQLd4x+86Dyih+4wEijwEGgF/9uROjPeMT7ql9+3yi
         SIaYZBKZ0jFuVcIlyGhudTN1qnKXVqImH9N7aPjGpTb3zCvDCYQKA0T6XTgNxZVaU6SV
         d7rrMNDf1f8T4JVZRqXx3UaeD4LXVX2ugWQLEnBvx8IrQr7L/tNziym3ivA2s7dtsX9u
         V1LhaHzTxn4cNsG6IioYcAjlLpbN3Uktvgyw1e/azd0OWsoDNCGNziwwx9Ih1zkbjkXs
         Y3f5HEvpc2ixIjcDd9gXsrcF/EmLZ1itaTsRzXFGlm2EcEep6tfxx7mDEUpeyCp/3LKB
         6aiA==
X-Gm-Message-State: ACrzQf0ajtoKESJRZxfjq3IXXGfGvwF2//hmFtiJZUzXk6WxJLUJSpmc
        hiduqjNb54Ogdy8aZW2IuAk=
X-Google-Smtp-Source: AMsMyM7ZPyVPQTXkr1zo3sQa8iuQFw0eBMml+7HJB05GhzwuI3WK14gZpi3PKA6rlXKa5IHuze1OOA==
X-Received: by 2002:a17:907:1b1e:b0:783:8e33:2d1c with SMTP id mp30-20020a1709071b1e00b007838e332d1cmr3506475ejc.304.1666116762780;
        Tue, 18 Oct 2022 11:12:42 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-1-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.1.39])
        by smtp.gmail.com with ESMTPSA id u22-20020a056402111600b00458dc7e8ecasm9253043edv.72.2022.10.18.11.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:12:42 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 2/2] dmaengine: JZ4780: Add support for the JZ4755.
Date:   Tue, 18 Oct 2022 21:12:19 +0300
Message-Id: <20221018181219.3251309-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221018181219.3251309-1-lis8215@gmail.com>
References: <20221018181219.3251309-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The JZ4755 has 4 DMA channels per DMA unit, two idential DMA units.

The JZ4755 has the similar DMA engine to JZ4725b and it has the
same bug as JZ4725b, see commit a40c94be2336.
At least the JZ_SOC_DATA_BREAK_LINKS flag make it work much better,
although not ideal.

Tested-by: Siarhei Volkau <lis8215@gmail.com>
Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/dma/dma-jz4780.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 2a483802d..9c1a6e9a9 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1038,6 +1038,13 @@ static const struct jz4780_dma_soc_data jz4725b_dma_soc_data = {
 		 JZ_SOC_DATA_BREAK_LINKS,
 };
 
+static const struct jz4780_dma_soc_data jz4755_dma_soc_data = {
+	.nb_channels = 4,
+	.transfer_ord_max = 5,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC |
+		 JZ_SOC_DATA_BREAK_LINKS,
+};
+
 static const struct jz4780_dma_soc_data jz4760_dma_soc_data = {
 	.nb_channels = 5,
 	.transfer_ord_max = 6,
@@ -1101,6 +1108,7 @@ static const struct jz4780_dma_soc_data x1830_dma_soc_data = {
 static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = &jz4740_dma_soc_data },
 	{ .compatible = "ingenic,jz4725b-dma", .data = &jz4725b_dma_soc_data },
+	{ .compatible = "ingenic,jz4755-dma", .data = &jz4755_dma_soc_data },
 	{ .compatible = "ingenic,jz4760-dma", .data = &jz4760_dma_soc_data },
 	{ .compatible = "ingenic,jz4760-mdma", .data = &jz4760_mdma_soc_data },
 	{ .compatible = "ingenic,jz4760-bdma", .data = &jz4760_bdma_soc_data },
-- 
2.36.1

