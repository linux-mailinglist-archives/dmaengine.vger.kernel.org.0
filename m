Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56C67BFAD
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jan 2023 23:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjAYWN5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Jan 2023 17:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjAYWN4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Jan 2023 17:13:56 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200C623DB2;
        Wed, 25 Jan 2023 14:13:56 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-15085b8a2f7so346835fac.2;
        Wed, 25 Jan 2023 14:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tWONC2DLcG7UXmUT4V0Do7k6bI6Vt9ydBIFnBQ35+4=;
        b=pttknk3PAvp5RulR/ns3hKydYecMpCd9CgyhUglaKhGHSWpxTMCf2wWFJRcK8akjyB
         AgoaJDrG58ma1uoU9tN+M1olq8fS3boBLT4EcBX1xLd4cVbePZdo5YJtNKKqZWb8tiVM
         oPIufULy+R2HKtI4yHgBP1e66iuSNUXgUPWwcwaMbV1FCUnjitr9OrelK/noSBxUjhFw
         7D5+FuFo5WyStM17v7jQqPyeYA3I0yLXDf8Txrtpc6QbTGfXNrrRGDEO7iuYndGDalpa
         PIuVIuLp3i4sBIjGT+g34okNTDg/Fj6eSK6mjIx/6SV0jJ8o0t2Om8S38V5XYBScc2gw
         8tAw==
X-Gm-Message-State: AO0yUKWEqP/vM39i4K2ThIPFJDd8vEHwDN0Uzj5l+W1NbN+m9dh3W3py
        NwMbtV5OzH0nqy+D5KMPDxE3zG47Ug==
X-Google-Smtp-Source: AK7set8GB9AfhxSXqkGnrERdEvNo9/262Q8WBeb6t0dGbl1zqQu2Vy6FhBDOVSBFgocMGYQ2mCKiIQ==
X-Received: by 2002:a05:6870:9112:b0:163:4731:bf2b with SMTP id o18-20020a056870911200b001634731bf2bmr548656oae.53.1674684835268;
        Wed, 25 Jan 2023 14:13:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p30-20020a0568708a1e00b00140d421445bsm2429594oaq.11.2023.01.25.14.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 14:13:54 -0800 (PST)
Received: (nullmailer pid 3057607 invoked by uid 1000);
        Wed, 25 Jan 2023 22:13:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ti,k3: Use common ti,k3-sci-common.yaml schema
Date:   Wed, 25 Jan 2023 16:13:39 -0600
Message-Id: <20230125221339.3057322-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Instead of redefining the 'ti,sci' and 'ti,sci-dev-id' properties multiple
times, reference the common schema where they are defined. Most cases
using these properties already do this, just udma and ringacc need to be
fixed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/dma/ti/k3-udma.yaml         |  9 +--------
 .../devicetree/bindings/soc/ti/k3-ringacc.yaml      | 13 ++++---------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
index 7ff428ad3aae..97f6ae9b1236 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
@@ -44,6 +44,7 @@ description: |
 
 allOf:
   - $ref: "../dma-controller.yaml#"
+  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
 
 properties:
   "#dma-cells":
@@ -78,14 +79,6 @@ properties:
 
   msi-parent: true
 
-  ti,sci:
-    description: phandle to TI-SCI compatible System controller node
-    $ref: /schemas/types.yaml#/definitions/phandle
-
-  ti,sci-dev-id:
-    description: TI-SCI device id of UDMAP
-    $ref: /schemas/types.yaml#/definitions/uint32
-
   ti,ringacc:
     description: phandle to the ring accelerator node
     $ref: /schemas/types.yaml#/definitions/phandle
diff --git a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
index ddea3d41971d..22cf9002fee7 100644
--- a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
@@ -25,6 +25,9 @@ description: |
   The Ring Accelerator is a hardware module that is responsible for accelerating
   management of the packet queues. The K3 SoCs can have more than one RA instances
 
+allOf:
+  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
+
 properties:
   compatible:
     items:
@@ -54,14 +57,6 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: TI-SCI RM subtype for GP ring range
 
-  ti,sci:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    description: phandle on TI-SCI compatible System controller node
-
-  ti,sci-dev-id:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: TI-SCI device id of the ring accelerator
-
 required:
   - compatible
   - reg
@@ -72,7 +67,7 @@ required:
   - ti,sci
   - ti,sci-dev-id
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.39.0

