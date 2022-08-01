Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14D65872B4
	for <lists+dmaengine@lfdr.de>; Mon,  1 Aug 2022 23:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiHAVCq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Aug 2022 17:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiHAVCp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Aug 2022 17:02:45 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531A37FA4;
        Mon,  1 Aug 2022 14:02:45 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id 125so9328349iou.6;
        Mon, 01 Aug 2022 14:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=UWLMU/KM5qthMireVIdywA7pGmSk84uLopBUFlw01rk=;
        b=6M1fQKNuUBiUabSsOxhoxMyomS9uVO0nO5Xly2kvMJlzCXwfsZ/CuyjIAigbjxlrQQ
         Bd+PdWduDsCLgxj95mpXTEx0SF2O3ajaM13Z+O7wWRA6DMymF3LtUq9GpDd0HP0YmU2B
         M9Q0Xmff7qVV2feK+xMeuIg71fjDgXwcvZjUQgDCM+ZIozR1b7OJUGMfZIfbc1l20+T/
         wi+s7cZXb2/wQ7TN+NHkJGUG9bBlo8vliDKprKSDBO/1uxd7aQdzow8RGkPTxf8VhpxL
         YyVSNjUjjEp0Tnl5wbswMGKbHJmIHupsi2Nr7sdeXB0WGsGnyZCYN5KSIi160Mjlg3o4
         8XGw==
X-Gm-Message-State: AJIora8kH25SKKRMuWGnQeFyI0vfc2E5GOcIiXEYasxtFHqCke+tkSjc
        3Sbd+W/D+Cda1amQTFuZtw==
X-Google-Smtp-Source: AGRyM1v/mytZaineqXwNw7H/fOehJ7t8VBW56FOnKxiyUKOT9WmqvVAmUm2cMCPhAvyGnzD9w2Q8jw==
X-Received: by 2002:a05:6602:2c52:b0:67c:19d6:b628 with SMTP id x18-20020a0566022c5200b0067c19d6b628mr6204085iov.151.1659387764307;
        Mon, 01 Aug 2022 14:02:44 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id j10-20020a0566022cca00b00675a83bc1e3sm6045876iow.13.2022.08.01.14.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:02:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: dma: arm,pl330: Add missing 'iommus' property
Date:   Mon,  1 Aug 2022 15:02:37 -0600
Message-Id: <20220801210237.1501488-1-robh@kernel.org>
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
Add the 'iommus' property allowing for 1 IOMMU entry per channel for
writes and 1 IOMMU entry for reads.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Include IOMMU entry for read channel
---
 Documentation/devicetree/bindings/dma/arm,pl330.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
index 2bec69b308f8..4a3dd6f5309b 100644
--- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
+++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
@@ -55,6 +55,12 @@ properties:
 
   dma-coherent: true
 
+  iommus:
+    minItems: 1
+    maxItems: 9
+    description: Up to 1 IOMMU entry per DMA channel for writes and 1
+      IOMMU entry for reads.
+
   power-domains:
     maxItems: 1
 
-- 
2.34.1

