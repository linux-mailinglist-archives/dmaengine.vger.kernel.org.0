Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0C5F8CED
	for <lists+dmaengine@lfdr.de>; Sun,  9 Oct 2022 20:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiJISOw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Oct 2022 14:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiJISOd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Oct 2022 14:14:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8470B24F27;
        Sun,  9 Oct 2022 11:14:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso5223933wmq.2;
        Sun, 09 Oct 2022 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6MWLfpMgm36Hh1hdddoNd7Zm9YtO8WyrpQujvG1QVw=;
        b=djHQqmiknPzKppm8tgLpEvoh0YV4JZ3I80KoovZK9iSYJhvUv+pLG9JgkrzzxP2kJM
         ffxL4m4b0GrT3gw/vBLHkn/KK4r94giSXADx4Np9jil5YYcZK1RmRl1wrMxg2Lcz94CU
         x0bObo3u4JfRG4KTUG1cLx2+bUqiKXpucrFkpe/6t3EfpOlleEY8fJ4jsrZSgeBZ+3hn
         hRFTjAAEMu875nBQXODYeAeL1dTQ/ZrWWDw6jRzYVdzJaIioZxq5WWeOEq/SKHhBtY32
         LPti9r6MPCPCQfgBZH+D5wP0mn1mQpsbp70GX3nDblIQYSuAah+MQgr4/wrjSfY7flQh
         wOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6MWLfpMgm36Hh1hdddoNd7Zm9YtO8WyrpQujvG1QVw=;
        b=Nd2y6IYjiKMvhJTKn/5P1m2B7LPTC4BUNSOocai8Lckom/QyP5PZA8wP2BDvodkXQr
         dda2ed3XAJYgW1Qg8NbiG9TxjlnExkM2vQ9YHK3pUTFFj6d1ozZvJGfXXAqvfW2neybu
         BuSog3E/vuPR6E6Vnzxcxst/rA5iSA6wNZs2y8dLnHJ5g4zDVIMvnq+wrfwMnLHqVWFv
         mNs8248DrFmmDo1hUIBvCsgoiRKYjbW9TqmKoWYzMJ5Ir8hsUNZkuGt5ze8CsJLUbhOm
         TuXp/Gx1dr0OYuXkvusjcweixxd4QCk0o7IvfvYnIQcIPfiUV5gvn0bH6qgPgNoSFa47
         HDJw==
X-Gm-Message-State: ACrzQf3EIVZI2neLjD+azwqi8RnahXcqrEba9pZVIewOdxEMrVpjIMH+
        3Vo0xKf9iwlAuc3ygJOYSBc=
X-Google-Smtp-Source: AMsMyM7pssZHnhz/cFPK8Be1Wjt1f5ZwipfpiRdfOpcSN7gLSVrOu+bXwV+yX5avGUESQrBuPuZSiQ==
X-Received: by 2002:a05:600c:281:b0:3b5:a5:7c9c with SMTP id 1-20020a05600c028100b003b500a57c9cmr16894980wmk.202.1665339265036;
        Sun, 09 Oct 2022 11:14:25 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-190-37-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.37.190])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b0022cd0c8c696sm6860581wrn.103.2022.10.09.11.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:14:24 -0700 (PDT)
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
Subject: [PATCH 5/8] pinctrl: ingenic: JZ4755 minor bug fixes
Date:   Sun,  9 Oct 2022 21:13:34 +0300
Message-Id: <20221009181338.2896660-6-lis8215@gmail.com>
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

Fixes UART1 function bits and mmc groups typo.

For pins 0x97,0x99 function 0 is designated to PWM3/PWM5
respectively, function is 1 designated to the UART1.

Tested-by: Siarhei Volkau <lis8215@gmail.com>
Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/pinctrl/pinctrl-ingenic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 3a9ee9c8a..2991fe0bb 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -667,7 +667,7 @@ static u8 jz4755_lcd_24bit_funcs[] = { 1, 1, 1, 1, 0, 0, };
 static const struct group_desc jz4755_groups[] = {
 	INGENIC_PIN_GROUP("uart0-data", jz4755_uart0_data, 0),
 	INGENIC_PIN_GROUP("uart0-hwflow", jz4755_uart0_hwflow, 0),
-	INGENIC_PIN_GROUP("uart1-data", jz4755_uart1_data, 0),
+	INGENIC_PIN_GROUP("uart1-data", jz4755_uart1_data, 1),
 	INGENIC_PIN_GROUP("uart2-data", jz4755_uart2_data, 1),
 	INGENIC_PIN_GROUP("ssi-dt-b", jz4755_ssi_dt_b, 0),
 	INGENIC_PIN_GROUP("ssi-dt-f", jz4755_ssi_dt_f, 0),
@@ -721,7 +721,7 @@ static const char *jz4755_ssi_groups[] = {
 	"ssi-ce1-b", "ssi-ce1-f",
 };
 static const char *jz4755_mmc0_groups[] = { "mmc0-1bit", "mmc0-4bit", };
-static const char *jz4755_mmc1_groups[] = { "mmc0-1bit", "mmc0-4bit", };
+static const char *jz4755_mmc1_groups[] = { "mmc1-1bit", "mmc1-4bit", };
 static const char *jz4755_i2c_groups[] = { "i2c-data", };
 static const char *jz4755_cim_groups[] = { "cim-data", };
 static const char *jz4755_lcd_groups[] = {
-- 
2.36.1

