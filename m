Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4E04DDEDD
	for <lists+dmaengine@lfdr.de>; Fri, 18 Mar 2022 17:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiCRQZa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Mar 2022 12:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiCRQZY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Mar 2022 12:25:24 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE9D2DE7A6
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 09:21:26 -0700 (PDT)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AE2733F607
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647620484;
        bh=O5YEItFojELUQ2ZVAdFWmd7QnNJFa0nT8LdWFM6nccM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=TtU6BB6Q3vLFAT+oK6RtC2Is1oRUFWAa+T4SIfl2ahSD/YFSbfW3OWEOEgPMOBueT
         1Nm6LV1aUqzMiJ0nfrIiVcl1pESt2bhN121xZAeOvSWfA9907OTbiCTJ7TF89Y0AEV
         PnVugt/0txuAv/VIO5+D2xaJTY3qgmGOVn1omw/CU0U54zs/qPyqnMpkg1cbumYQZi
         +f9gs/9u+966e3JcMzjTDeDy/asVDpYfugL1eB7giYktjNYzIZqgykQtZyd3NTxzFq
         c+aTr6kXr9HLAvEUXTY+x9qGciMIvXwXs0AoLqLTZeIeCQARtiFC+d2EMOqJ+OApHC
         ruPv0evmpMwIQ==
Received: by mail-lj1-f198.google.com with SMTP id 67-20020a2e0946000000b002493a3be913so3586724ljj.15
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 09:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5YEItFojELUQ2ZVAdFWmd7QnNJFa0nT8LdWFM6nccM=;
        b=4FrGqNOAPHPciwu6LLx9rV13ARF7q+xrJNALcczw0AUusqsuJV78cprq9HvHKG4Swm
         lX7cJcizhvTY1J4hGUj0T0SIZgmKI40anRjsd77P2pZgDFDG5Ojdfmn8LjygC4tMWID8
         YGqMd1Cgo9ut5akXv/ih3MLHVI36iNvNxDU4F+5KdEvkosf2FDbUvXcN4rtzKMuwTXrS
         Gb+fRvpkfKGUCGvDdodkh5/f9Xwk5KBbsres/J40gVfW/vkSVidPMlbSzmsCmCmMWhC0
         pQ9vL4XBHjQfR/BK4Wj+j3Npw/b9Zlhk1enQ0Fy7w4GD1NlPNiUy8V03jUYPSvLzSsC4
         DHMw==
X-Gm-Message-State: AOAM531gGN3rtwpQtwL888MWkd8iu9zu14nqu4yVWzkYHx9a62VYb/i3
        wFdQIz7rygAxa2zrKyLXYArgXrwsXPP7exgQZdpfIb1ATWgO47Vm6wO/qJBVZgj6SCIPVJSXo4r
        /5O0bZQuQb57rgMFve6vqIjyphsfTzSmQW6fD7g==
X-Received: by 2002:a05:6512:6c1:b0:448:6291:f135 with SMTP id u1-20020a05651206c100b004486291f135mr6405486lff.451.1647620483033;
        Fri, 18 Mar 2022 09:21:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7IhRjpip8ZxqWpdk/rNDzwPEQOlG6V0utFUzBi0pEzxIv6O5tJhNXTUklIfs5QHZNcJq1TQ==
X-Received: by 2002:a05:6512:6c1:b0:448:6291:f135 with SMTP id u1-20020a05651206c100b004486291f135mr6405475lff.451.1647620482814;
        Fri, 18 Mar 2022 09:21:22 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h5-20020a197005000000b00448287d1275sm906913lfc.298.2022.03.18.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:21:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Palmer Debbelt <palmer@sifive.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] dt-bindings: dmaengine: sifive,fu540-c000: include generic schema
Date:   Fri, 18 Mar 2022 17:20:43 +0100
Message-Id: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Include generic dma-controller.yaml schema, which enforces node naming
and other generic properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index 75ad898c59bc..47c46af25536 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -22,6 +22,9 @@ description: |
 
   https://static.dev.sifive.com/FU540-C000-v1.0.pdf
 
+allOf:
+  - $ref: "dma-controller.yaml#"
+
 properties:
   compatible:
     items:
@@ -41,13 +44,12 @@ required:
   - compatible
   - reg
   - interrupts
-  - '#dma-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-    dma@3000000 {
+    dma-controller@3000000 {
       compatible = "sifive,fu540-c000-pdma";
       reg = <0x3000000 0x8000>;
       interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>, <30>;
-- 
2.32.0

