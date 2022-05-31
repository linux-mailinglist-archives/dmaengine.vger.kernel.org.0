Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52702539274
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbiEaNwQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 09:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345091AbiEaNvt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 09:51:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E166996A1
        for <dmaengine@vger.kernel.org>; Tue, 31 May 2022 06:51:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q21so7593542wra.2
        for <dmaengine@vger.kernel.org>; Tue, 31 May 2022 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+yIDk55VuOl9cCuSgTZgPbJurzlbWspdqV8YJPygQc=;
        b=htvgPMPg810HOgsL/n8G+IrY6CyzUgbcv6/I4+7ytTovj325fq0rZxlNfBK0vW4cxZ
         dyf/Ol5KAJmMoo+mtoe9pQg/dUaVR/6Pt6UTXEVZjNmaBZvLBVhbyGexuuiR2kLNsNbz
         qqIE10FVgfiFvCfxWNi1gDtrnALRyhQYJuUFe9NJze697OCY0g8smzNcDk4IISkgf3gQ
         Xd+KrwxJ+Rlpq7XT8sg07RD2pyyxXW+HHc5rLzhGtWdYfEcwdQYYl6fYtt+EBbTNWpsA
         ozL8VwXPxAsUfw3sNyrqnY32vcl5ygsCmI2j8zKnVQ1fIAlOBqoyoreGhlxLkdhfmWX6
         YvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+yIDk55VuOl9cCuSgTZgPbJurzlbWspdqV8YJPygQc=;
        b=VW6i15hyIwALo2S8HtpfiiWIUX9z89ADLaBFjsNCOQETisNSn9TNujoxIPfqLtsDTU
         1hiHzBpI2sQXQN0ytQMMiWwT1kHP7TAN7/86OzKYO+FOlRAQQtgUQ8H/fFhGFXFhRXO3
         gxz74KlIxEwIZICfsU3Ai9K4m36mpABhyrygFyRAJRF/xE7u191aWpz7HZzQXHg61JqI
         JRxIZOmEE2fIuniA2fgfzwv7huyQLkH1EPPu9oWze+ifpaRCdnM5WLxoy1nMxvLUsChU
         4DQ5WOkzsz3Wx0puHJOdIYhMZhTFTE5gcbdAiEe+vnjoI23ZFhZTV32WwWi8dsEuh6KB
         4rEg==
X-Gm-Message-State: AOAM531y8hSYOD1eAGk6JR48WeRjFub99m8xgQOBObdJVvq3v/N2lcMq
        mbMGlpH9qHHR/fuTRWeaOcX6EA==
X-Google-Smtp-Source: ABdhPJxRndr/fDoyjVrSbqXI6Y+AQpxP3kSIzUtyunLbOSK92Vlbw3Ep6IVSf+uKQoEqmyqn7EQXJA==
X-Received: by 2002:adf:f405:0:b0:210:2d2d:c8ef with SMTP id g5-20020adff405000000b002102d2dc8efmr11703498wro.256.1654005064855;
        Tue, 31 May 2022 06:51:04 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:51:04 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 14/17] dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC bindings
Date:   Tue, 31 May 2022 15:50:23 +0200
Message-Id: <20220531135026.238475-15-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 084d7135b2d9..65f0ce225f13 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -33,6 +33,7 @@ properties:
           - mediatek,mt8186-xhci
           - mediatek,mt8192-xhci
           - mediatek,mt8195-xhci
+          - mediatek,mt8365-xhci
       - const: mediatek,mtk-xhci
 
   reg:
-- 
2.36.1

