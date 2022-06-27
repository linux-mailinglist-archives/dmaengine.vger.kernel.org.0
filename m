Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6CE55C89E
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 14:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiF0Tlx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 15:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240531AbiF0Tlp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 15:41:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DF817E14
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso6656563wma.2
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/4pSTzmZJtMPfdZhp3nJkb++kMPSJ1FDzT5rHgbkyFo=;
        b=fUcGP1N8oyv9wbrxArow7bj9CcdpzDUZQAModO/c79V3MzgRbDNNV/8LgF4H1T1GQs
         IChP1zjgi/XOcXFhZIkbV0TCnP/aEmt30Qt/x1j/QHaiLaw6W7XR/ZcK5lCplaamVDzb
         m6w/B2QGiflnmfO1WZS7VEaMRJK0e3ugiRjiGSRO0gWg6iojMRzR5V4a0KyyQUXAI3fT
         ePAmN8ijusyEpXfItpVgKuiAKLDnsyTJqmZX5NWTsvckGK1LX1/XQ9zMdcZhLecowRCr
         rvyMkn21VBG8epRNjd1ed0nDT3oBvlHa57V6rwoKJH5h/ATmx4dpU3nicZ3JbdF7uof3
         6JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/4pSTzmZJtMPfdZhp3nJkb++kMPSJ1FDzT5rHgbkyFo=;
        b=3zPSigsQGgpksLLrdNv+x06/0ITSQdaEcW0mKi1a9Y88F9BzYJxKQ9aNstLFIYhOOS
         QMPGVON7DK0Wbt8vlqz0A6aoCXa1ch9DerlNY+X5roQTZINXgkj4YfZZac3+hBQ17nBU
         fuNye+ROWtWVt8obEEuCsqh2Do2vHOKg2+qXiqxjlEyaAj6NPlgsQkl8KlZi6GhTYPWk
         9axgwpk9mnm9aiC2CEBrPVI6u30wks7D0fThwOyILuraIn6yj/UW7U57lMPtYSKqV53y
         lYVlxH/lsvNrzn99Wsbd/2MhxWYi1FB9WO4d62YTkC+6pXdNzAf2ZQQBGPd7YjMF7Rcc
         HFeg==
X-Gm-Message-State: AJIora+MAaSVzjZJnv9r5t7Ng5ViAzwMf/501wpVocvR65qBUpOgv8y5
        Z+Fluw68si9koANE/gORUhaPTw==
X-Google-Smtp-Source: AGRyM1ulzUVwSrZMGumLgKk0IITcW4JskOSYSyGzeL5vL40TAZn2Pd2mkHEB4lIYztTEoPvb5D5DGQ==
X-Received: by 2002:a1c:ed08:0:b0:39c:80b1:b0b3 with SMTP id l8-20020a1ced08000000b0039c80b1b0b3mr17522441wmh.134.1656358890978;
        Mon, 27 Jun 2022 12:41:30 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:30 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 09/16] riscv: dts: canaan: add a specific compatible for k210's dma
Date:   Mon, 27 Jun 2022 20:39:57 +0100
Message-Id: <20220627194003.2395484-10-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627194003.2395484-1-mail@conchuod.ie>
References: <20220627194003.2395484-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The DMAC on the k210 has a non standard interrupt configuration, which
leads to dtbs_check warnings:

k210_generic.dtb: dma-controller@50000000: interrupts: [[27], [28], [29], [30], [31], [32]] is too long
From schema: Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml

Update the binding to use a custom compatible to avoid the warning.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index cd4eae82d8b2..45ccab36618a 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -143,7 +143,7 @@ gpio0: gpio-controller@38001000 {
 		};
 
 		dmac0: dma-controller@50000000 {
-			compatible = "snps,axi-dma-1.01a";
+			compatible = "canaan,k210-axi-dma", "snps,axi-dma-1.01a";
 			reg = <0x50000000 0x1000>;
 			interrupts = <27>, <28>, <29>, <30>, <31>, <32>;
 			#dma-cells = <1>;
-- 
2.36.1

