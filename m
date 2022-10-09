Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3515F8CCA
	for <lists+dmaengine@lfdr.de>; Sun,  9 Oct 2022 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJISOO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Oct 2022 14:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJISOM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Oct 2022 14:14:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4723BFB;
        Sun,  9 Oct 2022 11:14:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f11so14122635wrm.6;
        Sun, 09 Oct 2022 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jyv46wHrohyjxRVTV7juENiF484l/IXY21r1YB8awFg=;
        b=YmytiBVwOi3FoMguaG4m9bJ7ZA80YdsK6YtZshsLAVGOLTRJolaSxiVxSRL6XaqC5G
         B+VThplxbizoDcfjcmntD+vV/4yBmnYRdi/pmXBlr1MCGv0jKhscJGkDORZuJcVVo8Ke
         xQu3NZoEzl3oi86vuXGpy2mS2AyVWEG0wJYSb4FUQ4ilYJ9przoAiKNEMYaqhrPaDJeX
         eX23268NSV1k+AJxs9s4dlCxLMJKcnfs+DcIJA/dx0S3GBt6RxLU+U7d5n0ZFTe67ZKh
         z/g3+1CkfoVXz5XLJyHgDhdsZVF/3PmI6xWChdRkB2o8sbZBnye57M6rQg+W8aGgP3C5
         XHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyv46wHrohyjxRVTV7juENiF484l/IXY21r1YB8awFg=;
        b=dYTWqzlC3HuU6jXPAticz1F/xrJ4yEyb1q8YhuCiTJAlDZiH7DlqBtigJgXm3lr1c4
         QKTbT0IyRjZ3zmjS6q+kGu/hLBBKXfAvnUIkzdn7qmQft+zy8URT6Q8k1M6iOu6dwSwD
         7Y2qgqf5NGblnX0v6iAUFys/uGsaXFDkJ7Nh7lfhphxFvrGnpeQEyVn6gBA0rfmUC3Y8
         Rl5Il+HKHNJJlOOKgiR82WTxbECab2aloBAwgI5oPkctpH47ByU6M4S8YnHGLVsDjFo8
         DkvHD5XwKMDrx8sNXSyYq1+L+xSHe7w322nXkH65PkjxTpCpxlmaBe6ofVrnvHKdxo2l
         hsow==
X-Gm-Message-State: ACrzQf1Ly2RKT5/UkKqvnZtVj/5auMoHDD565jopCPOuJ64yvHZeQOFA
        F91jdytRHyMH0uG8/JMGoMLVVTDCXqB5KtVu
X-Google-Smtp-Source: AMsMyM6AiHWX3jidTTduy8Y68gPr/X8AJcI3OEMlSI4PocegufSlOCg35/H6UrIUxYEjkCBSjy2F9Q==
X-Received: by 2002:a5d:58d3:0:b0:22c:e8e4:1461 with SMTP id o19-20020a5d58d3000000b0022ce8e41461mr9203920wrf.227.1665339250549;
        Sun, 09 Oct 2022 11:14:10 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-190-37-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.37.190])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b0022cd0c8c696sm6860581wrn.103.2022.10.09.11.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:14:10 -0700 (PDT)
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
Subject: [PATCH 0/8] MIPS: ingenic: Add support for the JZ4755 SoC
Date:   Sun,  9 Oct 2022 21:13:29 +0300
Message-Id: <20221009181338.2896660-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Add preliminary support for boards based on the JZ4755 SoC from
Ingenic.

It is a low-power SoC with a MIPS32r1 core running at ~432 MHz,
and has no FPU.

The JZ4755 SoC is supposed to be newer than the JZ4725B SoC, but its
internals are very close to each other. Also the Ingenic's kernel
source tree calls JZ4755 as JZ4750D and JZ4725B as JZ4750L, this might
mean that JZ4725B is a pin to pin compatible replacement for older
JZ4725 (both are LQFP128) but belongs to newer generation JZ475x. Who
knows?

I guess Ingenic released their SoCs in the following order:
 JZ4720  (MXU ?)
 JZ4725  (MXU ?)
 JZ4730  (MXU ?)
 JZ4740  (MXU1 r1)
 JZ4750  (MXU1 r2)
 JZ4755  (MXU1 r2)
 JZ4725b (MXU1 r2)
 JZ4760  ...

So JZ4755 DT is reusing many JZ4725B drivers because their support
in mainline kernel appears earlier.

Siarhei Volkau (8):
  dt-bindings: ingenic: Add support for the JZ4755 SoC
  MIPS: ingenic: add new machine type MACH_JZ4755
  dt-bindings: clock: Add Ingenic JZ4755 CGU header
  clk: Add Ingenic JZ4755 CGU driver
  pinctrl: ingenic: JZ4755 minor bug fixes
  dmaengine: JZ4780: Add support for the JZ4755.
  serial: 8250/ingenic: Add support for the JZ4750/JZ4755 SoCs
  MIPS: ingenic: Add support for the JZ4755 SoC

 .../bindings/clock/ingenic,cgu.yaml           |   2 +
 .../devicetree/bindings/dma/ingenic,dma.yaml  |   1 +
 .../bindings/serial/ingenic,uart.yaml         |   4 +
 arch/mips/boot/dts/ingenic/jz4755.dtsi        | 439 ++++++++++++++++++
 arch/mips/ingenic/Kconfig                     |   5 +
 drivers/clk/ingenic/Kconfig                   |  10 +
 drivers/clk/ingenic/Makefile                  |   1 +
 drivers/clk/ingenic/jz4755-cgu.c              | 350 ++++++++++++++
 drivers/dma/dma-jz4780.c                      |   8 +
 drivers/pinctrl/pinctrl-ingenic.c             |   4 +-
 drivers/tty/serial/8250/8250_ingenic.c        |  39 +-
 .../dt-bindings/clock/ingenic,jz4755-cgu.h    |  49 ++
 12 files changed, 905 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/boot/dts/ingenic/jz4755.dtsi
 create mode 100644 drivers/clk/ingenic/jz4755-cgu.c
 create mode 100644 include/dt-bindings/clock/ingenic,jz4755-cgu.h

-- 
2.36.1

