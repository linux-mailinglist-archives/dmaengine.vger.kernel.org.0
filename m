Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DE05F8CDD
	for <lists+dmaengine@lfdr.de>; Sun,  9 Oct 2022 20:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiJISO0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Oct 2022 14:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiJISOX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Oct 2022 14:14:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9BE24BD4;
        Sun,  9 Oct 2022 11:14:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n12so14080798wrp.10;
        Sun, 09 Oct 2022 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2QEPdO6PsCVuF/mW/121ufzLvPL8MU/4rRXsN1QWts=;
        b=bMuaJ85gtHfYIlAiEvzbRVp/4afACs8FvoRuQ4Ql2ia6fqPXo2ASKqRn1ESwnpptN9
         fvh/zdnX/QHbgiCHsXLXVZVxiwx8I/78J2IX4C+hAvxj+Pzu+UZUcpgAfUICNDas3rRs
         Q0zA+fusiGxQz0zHQXSWhGaCPQqAaQOpEiFhcsu6AqPAaxMp9u912LaE117SqiBBuEIV
         RQX8rjPXGz2+zQs8jK1O2076gywqh8RtIITn110gDN64EsOOUE3lRgdv2j9dRc/8xGuU
         FhrKb4UTDYCK0EEmT4XKIXCar4sP3+3FH4u1iSPJQyg5jKnwLmbXVMtAPwyIj3+ddArp
         sfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2QEPdO6PsCVuF/mW/121ufzLvPL8MU/4rRXsN1QWts=;
        b=s8ahV4DVHicaGSLqy3/Nu4h/NRrN0h8HCa6b2GKv29WgRfOoKSXTxCPAIZWGkoXV1x
         UO65G1b9PjySCSa12x4xY7ChG0w7dX5dYadHlfayTX2qjw3lxmrk01gVVVbcfhjamNPs
         oJYR18w5QP95eDHzMYPEwGyjjrbGdLF/WgK+885l5DBF8du3/2/+kvaY9yGj5GATXQiB
         +GuIuLNjeJJZzztbbY28RPDOqRlgZOIjF/AmoQ75oj0WQECp5NdCf9JvN8K1IO7zM+0v
         VUckdiGe60z0v6mChlzEPgO6VWQ7uGAN1b673zl79jrif4JLUn4KdG7YQP3SXKKMvoOz
         w+Pg==
X-Gm-Message-State: ACrzQf2iutoOxSuK2T9vI/zaWhp0738vXE7ipX7UX/3KxFe0N3tUFgde
        zs69997w93f6w0RPgAa0mss=
X-Google-Smtp-Source: AMsMyM4Xz69Xa/lHS04ZpSnTpGZcIlJj+f56cX0ujPGoFycMW4Vj/7wx7XzbWfJU/hOndUBITMmc6Q==
X-Received: by 2002:adf:eecc:0:b0:22e:3e6d:fb62 with SMTP id a12-20020adfeecc000000b0022e3e6dfb62mr9203290wrp.302.1665339259207;
        Sun, 09 Oct 2022 11:14:19 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-190-37-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.37.190])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b0022cd0c8c696sm6860581wrn.103.2022.10.09.11.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:14:18 -0700 (PDT)
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
Subject: [PATCH 3/8] dt-bindings: clock: Add Ingenic JZ4755 CGU header
Date:   Sun,  9 Oct 2022 21:13:32 +0300
Message-Id: <20221009181338.2896660-4-lis8215@gmail.com>
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

This will be used from the devicetree bindings to specify the clocks
that should be obtained from the jz4755-cgu driver.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 .../dt-bindings/clock/ingenic,jz4755-cgu.h    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 include/dt-bindings/clock/ingenic,jz4755-cgu.h

diff --git a/include/dt-bindings/clock/ingenic,jz4755-cgu.h b/include/dt-bindings/clock/ingenic,jz4755-cgu.h
new file mode 100644
index 000000000..32307f68c
--- /dev/null
+++ b/include/dt-bindings/clock/ingenic,jz4755-cgu.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides clock numbers for the ingenic,jz4755-cgu DT binding.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_JZ4755_CGU_H__
+#define __DT_BINDINGS_CLOCK_JZ4755_CGU_H__
+
+#define JZ4755_CLK_EXT		0
+#define JZ4755_CLK_OSC32K	1
+#define JZ4755_CLK_PLL		2
+#define JZ4755_CLK_PLL_HALF	3
+#define JZ4755_CLK_EXT_HALF	4
+#define JZ4755_CLK_CCLK		5
+#define JZ4755_CLK_H0CLK	6
+#define JZ4755_CLK_PCLK		7
+#define JZ4755_CLK_MCLK		8
+#define JZ4755_CLK_H1CLK	9
+#define JZ4755_CLK_UDC		10
+#define JZ4755_CLK_LCD		11
+#define JZ4755_CLK_UART0	12
+#define JZ4755_CLK_UART1	13
+#define JZ4755_CLK_UART2	14
+#define JZ4755_CLK_DMA		15
+#define JZ4755_CLK_MMC		16
+#define JZ4755_CLK_MMC0		17
+#define JZ4755_CLK_MMC1		18
+#define JZ4755_CLK_EXT512	19
+#define JZ4755_CLK_RTC		20
+#define JZ4755_CLK_UDC_PHY	21
+#define JZ4755_CLK_I2S		22
+#define JZ4755_CLK_SPI		23
+#define JZ4755_CLK_AIC		24
+#define JZ4755_CLK_ADC		25
+#define JZ4755_CLK_TCU		26
+#define JZ4755_CLK_BCH		27
+#define JZ4755_CLK_I2C		28
+#define JZ4755_CLK_TVE		29
+#define JZ4755_CLK_CIM		30
+#define JZ4755_CLK_AUX_CPU	31
+#define JZ4755_CLK_AHB1		32
+#define JZ4755_CLK_IDCT		33
+#define JZ4755_CLK_DB		34
+#define JZ4755_CLK_ME		35
+#define JZ4755_CLK_MC		36
+#define JZ4755_CLK_TSSI		37
+#define JZ4755_CLK_IPU		38
+
+#endif /* __DT_BINDINGS_CLOCK_JZ4755_CGU_H__ */
-- 
2.36.1

