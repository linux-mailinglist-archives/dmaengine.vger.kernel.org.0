Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71AA5F8CD4
	for <lists+dmaengine@lfdr.de>; Sun,  9 Oct 2022 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJISOY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Oct 2022 14:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiJISOV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Oct 2022 14:14:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2151C2495C;
        Sun,  9 Oct 2022 11:14:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a3so14158696wrt.0;
        Sun, 09 Oct 2022 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FJ7/YP2hXS1vCrLDjBwuedubr0y59mrPeF+JZZ90fI=;
        b=HOQsCG7/5sEuE+sXETwrV0GdnbxNu1rYLJhzlV67aXmNgjs6EEnKcBlzzIlsFlC1c0
         xpwabvivtRl9cr8ry8UC56ONOxIXjyBcslf3jP65BHGvbtORGNFLcZONPxJssg+PjeGi
         VY/TUFawu1hwdAB+FtS2pEH2XLGYP7AeHMuS6WD9QLLcgTiHkYdjVHPpVj3rOHFbtIYi
         aViizom8bwaOcl6c7Vf1Yv5ik8zuDGFSilF7coAjOiBEj7Pfwzdt19/j6kFFQH9dD0Nx
         gAkQC0Jiztqw+ciu8K+32J+5WaIXLa+I2xBnXhQUU6B/MomE1VEOtXnbs1Vt4sQlx3un
         ccKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FJ7/YP2hXS1vCrLDjBwuedubr0y59mrPeF+JZZ90fI=;
        b=27Hl18ZCeVA+i8cEPHLoTWgW6hPkicM8hPG34QoMV/x5qFtRQZJ+54jRol0jlal6nn
         nPUKivORSd6gPW00xi6/nxtNsv3ID7NYEtEfK0OMPEdnjDHk9C08C8u8NN1ltzSpzLNY
         XKyQU3/M/KgYhbFjgKxXtlVQ1D5iiR4wUhsL5KQASBTTlxmCBw1D5RY5qmIsNwjjsrvY
         T5mMQ0VJOrA3Sgqeb60qX+Hv12Gu2lO/QZYrNCaT6rGBS9E1H2eJVKjBKi4H0QKdX4gn
         o4EGSkoZ9+mOj3BkWSvSqP3+xp/drV6OiwiCw6//sOTz8CKwPVxnckq48GTn7wiaG/yl
         Gj0g==
X-Gm-Message-State: ACrzQf0lCKfRi1CiRc90ZI28r68EWVwuO3pUvCpOuztyTyFFChnBa0Nn
        S0g8Qha4aKxv1AIS6dqGCPg=
X-Google-Smtp-Source: AMsMyM5F541hi01H5pJzigVsnUROtGbwwQfwT6y0mpnuHDAIezsFEFLBed7xExdy9xDzskCWxXPehw==
X-Received: by 2002:adf:e109:0:b0:225:4ca5:80d5 with SMTP id t9-20020adfe109000000b002254ca580d5mr9140902wrz.465.1665339256338;
        Sun, 09 Oct 2022 11:14:16 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-190-37-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.37.190])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b0022cd0c8c696sm6860581wrn.103.2022.10.09.11.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:14:15 -0700 (PDT)
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
Subject: [PATCH 2/8] MIPS: ingenic: add new machine type MACH_JZ4755
Date:   Sun,  9 Oct 2022 21:13:31 +0300
Message-Id: <20221009181338.2896660-3-lis8215@gmail.com>
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

which is close to jz4725b because it is actually a low price
successor of the jz4755.
It has the same MIPS32r1 core with Xburst(R) extension
MXU version 1 release 2.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 arch/mips/ingenic/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/ingenic/Kconfig b/arch/mips/ingenic/Kconfig
index f595b339a..edd84cf13 100644
--- a/arch/mips/ingenic/Kconfig
+++ b/arch/mips/ingenic/Kconfig
@@ -4,6 +4,7 @@ config MACH_INGENIC_GENERIC
 	bool
 	select MACH_INGENIC
 	select MACH_JZ4740
+	select MACH_JZ4755
 	select MACH_JZ4725B
 	select MACH_JZ4770
 	select MACH_JZ4780
@@ -53,6 +54,10 @@ config MACH_JZ4740
 	bool
 	select SYS_HAS_CPU_MIPS32_R1
 
+config MACH_JZ4755
+	bool
+	select SYS_HAS_CPU_MIPS32_R1
+
 config MACH_JZ4770
 	bool
 	select MIPS_CPU_SCACHE
-- 
2.36.1

