Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D1360007C
	for <lists+dmaengine@lfdr.de>; Sun, 16 Oct 2022 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJPPNo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Oct 2022 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJPPNn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Oct 2022 11:13:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A4431DDE;
        Sun, 16 Oct 2022 08:13:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id l22so12846797edj.5;
        Sun, 16 Oct 2022 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neMO/Xv6+/M8nxm7VBGkm586LqlZgH70RZd7S709kIk=;
        b=cy1aqFE4kk2fK98HQUyCMX7gpk8Uh1wj2IO/y2KU/Te/tLpZ2wiuJ7mxthCkzzsfcr
         wv03BqE9+JoLzKjUpQp1RKCNY9TgsEKRGIA4DKgmqGmKB2zuMe8MrGykU6+BgTAEwCSk
         GNm5cN7Vlq85W6SlYBCTSBNiVwSZ/gL+dLlg+QMJwpEkNBINM7uWouQIdAiz6Vpg9F4S
         MtUccb89emjD1C7heJpJvV76Jcx0DM2YNACCFRLhRTss1nVdvSVgrbrL3On8T/eN3Wr2
         Ga/RvoaRlaZ7hLTB6LtBrkzjMLiaoNW5SuwR3/SJ2tR9pjmOEgr3os/al9k4iBd4Bila
         kMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neMO/Xv6+/M8nxm7VBGkm586LqlZgH70RZd7S709kIk=;
        b=fshGa36vu0XbJRuJX4vUEPhErZJE6jU5mPQcJRawC/fqZfVbYcNBMmTNGzVW7IvUOJ
         TJWICMSmWxHbLkAwsjcQZJqYBaXwlTh4HkbC6K53o+4QNxFqtDP1jS47j13SdzRBeLy1
         TqArrTi4z496v+oefE2KUAwkxV61PP8D0IbAGCZVGLKkBMGhc+Zpf1DNDXTm6414jze5
         bQgsuW9FMCkVdQeFIaUPXL5tRdSf/h+imX4FAJHOKVbTMAVncT5XWIJi69sltGRpo9QD
         T1YgFKRGI/DgA/qalQW5k3ZaJ2mDiVfVfXaHHTTYYpzNdiHViENgqPxRWMq+QBTPr+c/
         PlVg==
X-Gm-Message-State: ACrzQf2m6jA7h/OsZ+Gkp/lYPAMA+m8zzJYqNUjWxL85mvmO76YH6uFZ
        vReSkXven4H+rxk0vlIt8KSOx8XudjD1qA==
X-Google-Smtp-Source: AMsMyM4hKnQnxe1MFySDvSNeIEOl2P1+ij4oYtUV8RJ9KjhNtk+k2eFkRl0N9XKGtujv05+bwsDSbg==
X-Received: by 2002:a05:6402:3552:b0:45c:e4c:e6db with SMTP id f18-20020a056402355200b0045c0e4ce6dbmr6323433edd.403.1665933220594;
        Sun, 16 Oct 2022 08:13:40 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id i8-20020a1709061e4800b0078d4c72e2cesm4702735ejj.44.2022.10.16.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 08:13:40 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 2/2] dmaengine: JZ4780: Add support for the JZ4755.
Date:   Sun, 16 Oct 2022 18:12:56 +0300
Message-Id: <20221016151256.3021729-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221016151256.3021729-1-lis8215@gmail.com>
References: <20221016151256.3021729-1-lis8215@gmail.com>
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

The JZ4755 has the similar DMA engine to JZ4725b, so I assume it has the
same bug as JZ4725b, see commit a40c94be2336.

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

