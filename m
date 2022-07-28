Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A158466C
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 21:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiG1Szg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 14:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1Szf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 14:55:35 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B816205F4;
        Thu, 28 Jul 2022 11:55:33 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id w16so1399866ilh.0;
        Thu, 28 Jul 2022 11:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ygDDZAK0kTm4OImfggTWOYy2/qhBCyhklb1w0zcbi+A=;
        b=LpUDLKY6jJ+yHbz0aFvKI15low+3tBoqfmpzZ4IWrNOBHxaykVvkU71bRS2zqBVlbE
         Z032GZup287uSR5NDUrZiHC/2QqFZ8n6aXQY7O3iPfrj1aWnu8PqZFW6vCA2ESD6J6FX
         kCG3OLc3De33kv6CkZLeJPDmugV7QIEbX6ehNuY/3TTLYhJuJvaVf8MJ4dIAHA6NEAUC
         2pM2bi7/gxXlwyNPHBAPPanytQiRqgD8CKvXQRU/Y4TydM/Ru10ma6S2VjHwtgCebh7u
         wjtq+trrqy+1pyO2v8EgC+mom9KnJGZHFVnKeCu1YfaDa1i0f1XRtZG7/JSSZwJytKCx
         VGqw==
X-Gm-Message-State: AJIora9YHENjtHNl+PFSx4NpiMVzgCaulG1xaSCynhvn+nBXG7WXwtQ4
        VXf4sWCdyOIkBGYXkyN+4Q==
X-Google-Smtp-Source: AGRyM1uOV94o6o/LRv0RKpi+rsYtCnrOr5PU5H4FUNef114yiY6UBYAXaWwsZY+vQPqxo1yziudhzg==
X-Received: by 2002:a92:3603:0:b0:2dd:f09d:81f1 with SMTP id d3-20020a923603000000b002ddf09d81f1mr25163ila.246.1659034532806;
        Thu, 28 Jul 2022 11:55:32 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id ay6-20020a5d9d86000000b0067bf99ea25bsm641820iob.44.2022.07.28.11.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 11:55:32 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: arm,pl330: Add missing 'iommus' property
Date:   Thu, 28 Jul 2022 12:55:11 -0600
Message-Id: <20220728185512.1270964-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pl330 can be behind an IOMMU which is the case for Arm Juno board.
Add the 'iommus' property allowing for 1 IOMMU per channel.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/arm,pl330.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
index 2bec69b308f8..b9c4bee178ae 100644
--- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
+++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
@@ -55,6 +55,11 @@ properties:
 
   dma-coherent: true
 
+  iommus:
+    minItems: 1
+    maxItems: 8
+    description: Up to 1 IOMMU per DMA channel
+
   power-domains:
     maxItems: 1
 
-- 
2.34.1

