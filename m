Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDFF5679B5
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 23:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiGEVxR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 17:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiGEVxB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 17:53:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4345A1A38F
        for <dmaengine@vger.kernel.org>; Tue,  5 Jul 2022 14:52:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so19375278wra.9
        for <dmaengine@vger.kernel.org>; Tue, 05 Jul 2022 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWVsoJ84nebg5qEzx/IyFZjNfcxxChmP9JWxkkGh06M=;
        b=bNjVpXzmlR/oWM523pD7Hne1AQQQiJuJz7eymu4r8tKUB0QnUyvNkL1aZIAxqUooj1
         7ihDvcph+Hv85n2NhhFyIcvChV6ZYHBSuL0TfLXBN28IINhNsV8hUqQz/SlKfVTjTsb7
         LknjMoulh7s2k46gfpL15T51BpP11SIJPktkH4UR9iuaLkRyzjbYSadCvPzXbLcBjhoB
         tDXWYHDOa57EAjaRLpeFhmKYG2PSTbvCNdceBjvnTYwGHKteRI+1wFGI640cAeey0kmB
         IOuARbRZuqQW3V3qs8fqjCY+OmQ8YhPuJW4/bE1xcuBIY3hi1nCOP0qRr6w884X/VAxd
         dbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWVsoJ84nebg5qEzx/IyFZjNfcxxChmP9JWxkkGh06M=;
        b=Auq4SXk09Y2yUPbf4n4thFiWdGRanekHGPh1r5BMfrWw2YTBPMR+7yZtxbpgmWUbKP
         6ye6HRbsqzh2E2xaqkKx6akVs+HchbBd3p9MRRfPtqSG6Pyu9IJXIAotVj9fr63JQC1F
         sao7ZlF6QHqKUfWQk9BP2gdeeoSdJaxeXiC31MtpT8MOiO7/FyxCdnlfBpfO8DiGYFIo
         czFEhHj9jQMiLtKSd+/WNshvc7f+MVhy085fIDa6zvzZuOdI3asQZcnMvOzQJ3jy92Yf
         EZp9BSF/VP+3bryt66E2sVe87X9RLh42PNxXPLK2y60GXX/cRywWw2zA7zgTPbYRJDxE
         CwgQ==
X-Gm-Message-State: AJIora8yOfpWquAv9P34NL06B0Km5MTsMuGmZ4VP5dvlqkrOIBDfCM9d
        BHT0EcpljuH46GAnXQP9fpr/Qw==
X-Google-Smtp-Source: AGRyM1tU1s0Kd36TQuvH5KjPiRqTOb3JL0g6qqv8u238NyO/YXr5MyXJLGr8xZQuXd4xQnYkdnCjzg==
X-Received: by 2002:adf:9cc7:0:b0:21d:642b:85f2 with SMTP id h7-20020adf9cc7000000b0021d642b85f2mr16256358wre.21.1657057960735;
        Tue, 05 Jul 2022 14:52:40 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm18353920wmp.19.2022.07.05.14.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:52:40 -0700 (PDT)
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
Subject: [PATCH v5 12/13] riscv: dts: canaan: add specific compatible for kd233's LCD
Date:   Tue,  5 Jul 2022 22:52:13 +0100
Message-Id: <20220705215213.1802496-13-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705215213.1802496-1-mail@conchuod.ie>
References: <20220705215213.1802496-1-mail@conchuod.ie>
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

Add the recently introduced compatible for the LCD on the Canaan KD233.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/canaan_kd233.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/canaan/canaan_kd233.dts b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
index 4a540158f287..b0cd0105a5bd 100644
--- a/arch/riscv/boot/dts/canaan/canaan_kd233.dts
+++ b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
@@ -127,7 +127,7 @@ &spi0 {
 	cs-gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
 
 	panel@0 {
-		compatible = "ilitek,ili9341";
+		compatible = "canaan,kd233-tft", "ilitek,ili9341";
 		reg = <0>;
 		dc-gpios = <&gpio0 21 GPIO_ACTIVE_HIGH>;
 		spi-max-frequency = <10000000>;
-- 
2.37.0

