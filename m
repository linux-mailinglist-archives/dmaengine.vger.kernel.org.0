Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403816039F0
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 08:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJSGk3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 02:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiJSGkL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 02:40:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6202E183AD;
        Tue, 18 Oct 2022 23:39:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sc25so37560689ejc.12;
        Tue, 18 Oct 2022 23:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HwispDUz/zmZOxZOQfRBMDPdwbQJsbMK56653OL67w=;
        b=cuN7lWEiaUtYv3fpMZdZdqzVlWk025u7+JSeAWp4vmVflIvhxdf2248hhYaVIZsaeq
         e02I3loX7Jt6whvAG/LFcheqxxyYI6N8krm0xSYWd9RDLV/PaUDf0xh5/k4MES2ryTEF
         zxjFFQlWhCwjfCY96rZL1aM1Zd4Y3V41FmNAu5LiRw0Ew+p2RbeCtvH+GBNcFpocUvME
         6gmd0O5iVOahfoCh4PwC8RK6IpvVEs7XdFalVmA/2A1VfWMlciYI7E1EDcctiZw/I2VX
         pGt8YEoufr82lZri1Lu7KXNYWXZS8ydr5kRQNULG5ZPHDcaaH5CLS+UBcUmlKngOBQuV
         xgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HwispDUz/zmZOxZOQfRBMDPdwbQJsbMK56653OL67w=;
        b=veA7gG5KIJFX34ycI/H+ZN8DR+jPkMdjFqUPkK6dC1BR2GN7vmIKTxxKxY7oXK5fbx
         y8jOtRNa//B9QviEh+ukrRDQ57UxMNEWb6x6WdRtOD9dE0HWXHR0vyva1TBBurVDC9QK
         7yHjskVgrZfX7XzJ0qB5RJnqt+X9AUQuoyNL6H8UPc5hr0lfIMbhVh8qYiNUu/zEgWkk
         nuS2I/yiTRSDP1nVIwTZsAWVFwTRekfiDhP0ytUYykC0pCXHqgywPNLmYrYIyPaZtoN4
         cAumpXK9dgYuwV76xAjy8InPVOiEWsMjSKxNsJFRa9BlI5yUuXtkHKNaS3v6PrzNZ641
         OPTQ==
X-Gm-Message-State: ACrzQf3ajs84b55bBNpkaAkx8uWmh7ntW4DA5gXAfAjWTWL9CrbskbMQ
        TkxMrHTNsj9f67RnQE9UCVY=
X-Google-Smtp-Source: AMsMyM5lMXUDUnZpYCvNSpQh/PmwFghdajNap2f9MwQUZM+uVLBxp/JzdjR6zpqHYXb99X+AOfzOxw==
X-Received: by 2002:a17:907:7f24:b0:78d:ee20:5c62 with SMTP id qf36-20020a1709077f2400b0078dee205c62mr5422199ejc.177.1666161584954;
        Tue, 18 Oct 2022 23:39:44 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-4-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.4.39])
        by smtp.gmail.com with ESMTPSA id fy19-20020a170906b7d300b00781dbdb292asm8467168ejb.155.2022.10.18.23.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 23:39:44 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 2/2] dmaengine: JZ4780: Add support for the JZ4755.
Date:   Wed, 19 Oct 2022 09:39:34 +0300
Message-Id: <20221019063934.3278444-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221019063934.3278444-1-lis8215@gmail.com>
References: <20221019063934.3278444-1-lis8215@gmail.com>
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

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
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

