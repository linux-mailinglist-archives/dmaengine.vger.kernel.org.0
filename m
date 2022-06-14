Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2793254B48D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jun 2022 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356752AbiFNPZ0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jun 2022 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356666AbiFNPZW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jun 2022 11:25:22 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F179022532;
        Tue, 14 Jun 2022 08:25:21 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id r5so9747969iod.5;
        Tue, 14 Jun 2022 08:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjT5wGmHJgG0eNHLr4sx2SWsu7TpquOvBLbiZspfnLQ=;
        b=srfn9jObIM3MtrT/qS9s59A0H1fyY3CuREhlcHr0ObC++u4LmQWNV40eWOCTpDyHg6
         x5n7Bs8en1mTOCphzcr1L3iv3MBQ/JE6mIi5lho4WZA4Hi1B5uU2Uco1c+7l+jgLnFse
         lnCftZ3ympQdZNv1c7fJ5ZnVuTcJk65mWs8UdodiiDovOZwGRDsjdZXrFYdl3EGx97kg
         OgIhYjarBq0139iE+cY8ZbRHr/6zpqNtYyn5OyP+yQ7PSF35Vrgy1bZGrR3Ey4zw5bqG
         bHGT87xrGatqoJwPc4y5x3yxNjnur4Y//C3i9KkMSEDigLyfwfpymcO/dNju/fdvbYR/
         121A==
X-Gm-Message-State: AOAM530edXfq052V5BW7bXEkOdBQ4Xf5uROgdfnCM4sTh32m+Z8e0M8Z
        3+bsF/WEHped6n/uQKTO6DQ26sREpQ==
X-Google-Smtp-Source: ABdhPJw/DPeqW+0POs50/HnxbvLUIDrEmh4RkEsS8T5HKrNb19A1r7LyOf/9fn00kIqqkBVOBaRgiA==
X-Received: by 2002:a05:6638:2ac:b0:331:84fd:c630 with SMTP id d12-20020a05663802ac00b0033184fdc630mr3167135jaq.113.1655220321262;
        Tue, 14 Jun 2022 08:25:21 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id l44-20020a02666c000000b0032b3a781767sm4957033jaf.43.2022.06.14.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:25:20 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: apple,admac: Fix example interrupt parsing
Date:   Tue, 14 Jun 2022 09:25:03 -0600
Message-Id: <20220614152503.1410755-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit 873971f8fb08 ("dt-bindings: dma: Add Apple ADMAC") has a warning
in its example:

Documentation/devicetree/bindings/dma/apple,admac.example.dtb: dma-controller@238200000: interrupts-extended: [[0], [4294967295, 0, 626, 4, 0, 0]] is too short
	From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/dma/apple,admac.yaml

The problem is the number of interrupt cells can't be guessed when
there are empty '0' entries. So the example must have a valid interrupt
controller defining the number of interrupt cells.

Fixes: 873971f8fb08 ("dt-bindings: dma: Add Apple ADMAC")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/apple,admac.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
index ab8a4ec7779f..bdc8c129c4f5 100644
--- a/Documentation/devicetree/bindings/dma/apple,admac.yaml
+++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
@@ -63,6 +63,11 @@ examples:
     #include <dt-bindings/interrupt-controller/apple-aic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
+    aic: interrupt-controller {
+      interrupt-controller;
+      #interrupt-cells = <3>;
+    };
+
     admac: dma-controller@238200000 {
       compatible = "apple,t8103-admac", "apple,admac";
       reg = <0x38200000 0x34000>;
-- 
2.34.1

