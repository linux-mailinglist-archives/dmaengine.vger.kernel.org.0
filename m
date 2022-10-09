Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936A85F8CF6
	for <lists+dmaengine@lfdr.de>; Sun,  9 Oct 2022 20:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJISPP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Oct 2022 14:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJISOj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Oct 2022 14:14:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27B625585;
        Sun,  9 Oct 2022 11:14:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso7314849wmq.4;
        Sun, 09 Oct 2022 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neMO/Xv6+/M8nxm7VBGkm586LqlZgH70RZd7S709kIk=;
        b=KwDJ6RXnWX8FBRYCwyMKFMioyd7aKSjSZbTr0pdA8dRLrBqv/LVTf4eFz9VdbZgHPY
         aNhWuOV0ExDv8xAszdAjmAsxQCVuTrA38c1sFTxo2lDeCIuPh4dpND/7//rqn6UyLSpb
         DjjgRZxJhCT/y9Q3iob9eRxg0ZxokdBp9fSxFICfcVucyh5YSFhDTUuSFo21quWKt1jB
         +PWCjwA4gqNurBrAVEoxl2C6wAjgwNBOhf9kSlg0btd00ASzAnkyZxYNS0kFbBZAcq1n
         eG1y9/oiiCL6D+eN/lJreruvvJQgnZw9EdOx5hq7fj/6GqbBesBnk/KnFbujzqx8HU0o
         aP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neMO/Xv6+/M8nxm7VBGkm586LqlZgH70RZd7S709kIk=;
        b=uPv61sl3ESESKo0G/Kuf7inZhkf6D4tPWQ08kLv+zNrvCh/PZxTi/R5wsxg4meYNLE
         Tgl53s8sTpq6iTliRzMG3NNTVIrPZn7ge2RfHko4dpmjy5vaQX+uwagWAAiMyHOONuYA
         wVpHWbCwk3ycWLrfLbf07cNKhFH/dP6crf1dmmXGiAxqbf21uvocXq6f7j/6SxiEC5pC
         VW0QU9eZ7YbEg/HLjUmCIU/1NHFpXUloauufcW3zO+EwmLbHoxE0qrDYhjJzfmCOVks5
         SxJlzFVyGZowPBIack/H6U46MVv4xTGZLGINnHnfR9aqvE9HZvm7e8XRfhdnW5IrOw7l
         csEw==
X-Gm-Message-State: ACrzQf296hA53wF7eiZT3dEe5qbLtiiyn4B/IEcOus7HJ4xsyaepraAg
        Rico78UWZXZiC/7x6/VUCAI=
X-Google-Smtp-Source: AMsMyM7HqocwrUtk98mJbiSx2PpDDdWbQLQCvcQ2JoyZhMGa1/R6iNMH5wbDT1jn7fOGaTTnYA5n8A==
X-Received: by 2002:a05:600c:2104:b0:3c6:b7f0:cfd0 with SMTP id u4-20020a05600c210400b003c6b7f0cfd0mr310489wml.128.1665339267904;
        Sun, 09 Oct 2022 11:14:27 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-190-37-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.37.190])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b0022cd0c8c696sm6860581wrn.103.2022.10.09.11.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:14:27 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 6/8] dmaengine: JZ4780: Add support for the JZ4755.
Date:   Sun,  9 Oct 2022 21:13:35 +0300
Message-Id: <20221009181338.2896660-7-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221009181338.2896660-1-lis8215@gmail.com>
References: <20221009181338.2896660-1-lis8215@gmail.com>
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

