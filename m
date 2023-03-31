Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED86D27B3
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 20:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjCaSVt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 14:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjCaSVr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 14:21:47 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD6523697;
        Fri, 31 Mar 2023 11:21:46 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-177b78067ffso24077394fac.7;
        Fri, 31 Mar 2023 11:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680286906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x8s6XibaJobn+rZUHw+HgAP1W9NsygfPq2q+redF5I=;
        b=JHT11kyp3Ge2qHMyyJ0WW6BUL+8dr6nKN+C81FRHUmbz3IR+RpZP1CwSo13QG+ha+G
         8YE6UUD53TvWAU6hS88vC4uf77bWKwxzNlABDjzjQMF+dIkUeekXb8DlzzGzPIYyiefZ
         xJaDu6XWLWeL6t0MfLzkpLGrZe0bz3irSkIPlSpsPVaeRbmGK6qijzSTuFuugVudbn1N
         /kyTxzbwy4nQKcKHPDeyRNLC/0D/m8fnq5CMl6BM+hOQbRWSyfF9fTm53VrFy+zIMv0s
         gc1x8jASvUmx0IrCaAg7WWUAgVCo7/X4vsRi62k0WXHItFlZArHy1TRsStJ1OyXZqZ7F
         7Keg==
X-Gm-Message-State: AAQBX9emb4I9rph5/MxmfutxoDjJBZYfgI7AzXCL4cgXVVYVCH2/stVM
        m4VsoEkZB7XWcQDP3TBQ/Q==
X-Google-Smtp-Source: AKy350Y3ZJARANTt7iWkD+V2qMdhk1ynE3k9RRv2h4woqZf8NKJ4ZpTrMliLET8Pq36FFn8CdM9eXQ==
X-Received: by 2002:a05:6870:c112:b0:177:b463:9dcf with SMTP id f18-20020a056870c11200b00177b4639dcfmr18749257oad.46.1680286905726;
        Fri, 31 Mar 2023 11:21:45 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id vh20-20020a0568710d1400b001805a3e722csm426140oab.19.2023.03.31.11.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:21:45 -0700 (PDT)
Received: (nullmailer pid 1900431 invoked by uid 1000);
        Fri, 31 Mar 2023 18:21:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: dma: Drop unneeded quotes
Date:   Fri, 31 Mar 2023 13:21:41 -0500
Message-Id: <20230331182141.1900348-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/ti/k3-udma.yaml           | 2 +-
 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml     | 2 +-
 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
index 97f6ae9b1236..22f6c5e2f7f4 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
@@ -43,7 +43,7 @@ description: |
   configuration of the legacy peripheral.
 
 allOf:
-  - $ref: "../dma-controller.yaml#"
+  - $ref: ../dma-controller.yaml#
   - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
index c0a1408b12ec..23ada8f87526 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
@@ -15,7 +15,7 @@ maintainers:
   - Michael Tretter <m.tretter@pengutronix.de>
 
 allOf:
-  - $ref: "../dma-controller.yaml#"
+  - $ref: ../dma-controller.yaml#
 
 properties:
   "#dma-cells":
diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
index 825294e3f0e8..d6cbd95ec26d 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
@@ -16,7 +16,7 @@ maintainers:
   - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 
 allOf:
-  - $ref: "../dma-controller.yaml#"
+  - $ref: ../dma-controller.yaml#
 
 properties:
   "#dma-cells":
-- 
2.39.2

