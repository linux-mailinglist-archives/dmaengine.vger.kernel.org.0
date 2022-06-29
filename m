Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC2956096C
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 20:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiF2Sou (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jun 2022 14:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiF2Sos (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jun 2022 14:44:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0DF286E5
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e28so18633253wra.0
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1sKeykQQRtYj4kj+xEuSgs82fAmu7DyyvRULZ2/Pb6I=;
        b=BMdHLMoOwn6zAxEtDDa7k0h1f/DZxYTgThu3U2sNuU1A+J2K+WADunh8MBK6GQasvX
         bZvbX2AUE3WkwwdX1tNkMtXNA8L7f1blGzcC68saXHEBzsdK22yycaVeMLYkxq7AyhLL
         0C4t2FTjsmp0VGR7E+AoaIvn0ZeON/zWIol2+bxphxTssK2+9gqxMql6G//GigObaYxf
         /NoPS2HGfbugk99X8z9aoWaMuWtx6qv4eWquj/tnR5Pol/4lsSCRVCWYtIA+UAXYn6Mr
         TDsy1g8lVTt47WmMpnvavQWY3UdJ+fGtNafwfqqmqUbeYTMgSgBnM66BgnnczfD5P+y+
         Hv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1sKeykQQRtYj4kj+xEuSgs82fAmu7DyyvRULZ2/Pb6I=;
        b=mSrrNEW93SAbuAUJnOeBXTIfg7TLSg536SmvpvCRjzyvBPlw7NtltOh8RhOLrDXJsC
         o2bMe8N3SGiQjc5NFkq2k3rfDfpYrQ+IzNUixnPZ8TdAPOcqis28VEptHGzXQ2NUluE6
         2MN4m7aLzfIdCsC0/W42MiT5AwEgIacr+U1mDCpJUI0WjMyjzDeh2Cbew4i9+wH80oC8
         9d2NC8fk/OfrHTizehUE9TlRLezLbHTLIq7Ha6Ksn8k+c0vLcLEboAWFwbV8GrvqC39E
         DzOQ4+QX1IgqMWaAfZLMNkbxgYwNhBl1k51cP6guF/WYrI3uPoHQPtc/xKwOi+4kFw2s
         OCaQ==
X-Gm-Message-State: AJIora8kGJi28qycRrRVzYGq1lvl2Hy0SQh4YocCNrWZ0r1lR7V8DZtb
        nTGY4Zsv5VYjoefhODgJ14kz/Q==
X-Google-Smtp-Source: AGRyM1txmcVZd3QPq2DQpn3PG07YMXIn7w8Wmsh9JviOd6mCe5xqRBVB6TunKvps0uLWXYGFL6mRJA==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr4479112wrd.552.1656528284293;
        Wed, 29 Jun 2022 11:44:44 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:43 -0700 (PDT)
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
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 05/15] dt-bindings: dma: dw-axi-dmac: extend the number of interrupts
Date:   Wed, 29 Jun 2022 19:43:34 +0100
Message-Id: <20220629184343.3438856-6-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629184343.3438856-1-mail@conchuod.ie>
References: <20220629184343.3438856-1-mail@conchuod.ie>
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

The Canaan k210 apparently has a Sysnopsys Designware AXI DMA
controller, but according to the documentation & devicetree it has 6
interrupts rather than the standard one. Support the 6 interrupt
configuration by unconditionally extending the binding to a maximum of
8 per-channel interrupts thereby matching the number of possible
channels.

Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 51
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 4324a94b26b2..e33ef22aec9c 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -34,7 +34,9 @@ properties:
       - const: axidma_apb_regs
 
   interrupts:
-    maxItems: 1
+    description: per channel interrupts
+    minItems: 1
+    maxItems: 8
 
   clocks:
     items:
-- 
2.36.1

