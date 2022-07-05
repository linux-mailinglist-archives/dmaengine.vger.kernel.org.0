Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6285679BD
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 23:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiGEVxV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 17:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiGEVxN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 17:53:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61791A39A
        for <dmaengine@vger.kernel.org>; Tue,  5 Jul 2022 14:52:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q9so19383819wrd.8
        for <dmaengine@vger.kernel.org>; Tue, 05 Jul 2022 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lj8lQBl+rzKhHnZ+Xd+ZIX70dBba4zQ87/hMtZKztKo=;
        b=SWBLyNd34TD/mZu6n2FRfmU1HE1CDonJi13qsFyhAyqnSyEQ/KmdR1UWXQSWh8Lc4S
         wboztDYyEl0cB6dNxkPhLH8Vut8eQklDlAzLAba8wD+ncpM0c/ss1G9HZw6iwywvQYDc
         Wp4EiJ8gFj2NtEhHkoHzq6BO5iZJQV8yqDNi/hV+TI3EdwxWa8PyiRtclVAhofmrQMv1
         O4MgZCyDw4sYc3gDgn4HyTIQC0OgktoApwqj7hpRysjTLfmxTwmhIL9038u47rfi3QnR
         TEsjdMTU0aXj0ZC25wthUzJnFtFa+8G8sy0GbjfRv+uUUgqNTVhurKapbgEb8iTWOR1w
         qZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lj8lQBl+rzKhHnZ+Xd+ZIX70dBba4zQ87/hMtZKztKo=;
        b=OmnXHRWvG5+NCzeN6pEM3MDC3jJa2t/VOEgAhiJ8JQiH64hW5sp+lX42V8am+VZCsf
         JCBnP74E7AGwqf8bV9fjzQw/BzfQ+tXya69urDVzUYAfwjIknG0GLoCaJUN/oJHiRftD
         BvAET4UMHrAG6cjMo1Y2dd+KhvhtSlYOCBEU1+gkF1LI0HM++DHrQPJ+t+Q0BqE+nLwy
         xU3qMbZWVigz6/qi0CvhD2vHRkH0i+oQI7qcd2EN8F+caBiM1aE39yQEBroXzx5QJCbt
         R7emp41b+Zka70WCpD+K4QLGefgB2mcVmKL6JdxeKnz4ABqwKn6CyoQEPTjA1wjAjDnN
         dF/Q==
X-Gm-Message-State: AJIora8vjLKcJwucmqvO+H2M+KzjvUym3AO3x6pqbQnejYy6Ybw9BCuL
        QantuDNaVutUh67oKiIJ0vEtdw==
X-Google-Smtp-Source: AGRyM1tr0mSvjiKuETZ7gcWxREDHaUXAsNoHFiE497jvmcwKxLKMvl+jTlZGzJe6mijwSzLjNBUwQQ==
X-Received: by 2002:a5d:64aa:0:b0:21b:c38b:bb81 with SMTP id m10-20020a5d64aa000000b0021bc38bbb81mr33626354wrp.666.1657057962100;
        Tue, 05 Jul 2022 14:52:42 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm18353920wmp.19.2022.07.05.14.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:52:41 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 13/13] riscv: dts: canaan: build all devicetress if SOC_CANAAN
Date:   Tue,  5 Jul 2022 22:52:14 +0100
Message-Id: <20220705215213.1802496-14-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705215213.1802496-1-mail@conchuod.ie>
References: <20220705215213.1802496-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Testing & checking the Canaan devicetrees is inconvenient as only the
devicetree corresponding to SOC_CANAAN_K210_DTB_BUILTIN will be built.
Change the Makefile so that all devicetrees are built by default if
SOC_CANAAN but only the one specified by SOC_CANAAN_K210_DTB_BUILTIN
gets built as an object.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
index c61b08ac8554..befe4eb7527b 100644
--- a/arch/riscv/boot/dts/canaan/Makefile
+++ b/arch/riscv/boot/dts/canaan/Makefile
@@ -1,3 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += $(addsuffix .dtb, $(CONFIG_SOC_CANAAN_K210_DTB_SOURCE))
-obj-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += $(addsuffix .o, $(dtb-y))
+dtb-$(CONFIG_SOC_CANAAN) += canaan_kd233.dtb
+dtb-$(CONFIG_SOC_CANAAN) += k210_generic.dtb
+dtb-$(CONFIG_SOC_CANAAN) += sipeed_maix_bit.dtb
+dtb-$(CONFIG_SOC_CANAAN) += sipeed_maix_dock.dtb
+dtb-$(CONFIG_SOC_CANAAN) += sipeed_maix_go.dtb
+dtb-$(CONFIG_SOC_CANAAN) += sipeed_maixduino.dtb
+
+obj-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += $(addsuffix .dtb.o, $(CONFIG_SOC_CANAAN_K210_DTB_SOURCE))
-- 
2.37.0

