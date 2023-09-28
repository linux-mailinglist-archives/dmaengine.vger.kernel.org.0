Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB907B1C0F
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 14:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjI1MUT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjI1MUS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 08:20:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CD818F;
        Thu, 28 Sep 2023 05:20:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3af603da1d0so1129700b6e.3;
        Thu, 28 Sep 2023 05:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695903616; x=1696508416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bej93pKAZY6pGdcUKj7cDTtnV7lDIpgi1E7jduS7PN4=;
        b=J/ckmpm4a/PH4pKr6+8jK31WOTfUHwUqWTJjNW+i1YAV517FKeaOdqcRAJpYjQKGan
         6kHQuzF0rIvZQ5L6B1ZmkoOvmp3pgQhHi/qz8Fpqp6ZTXTYDZLWwDqyX+MHu0mVGe7ss
         ARKmnmNXI9GCmMQNAcBcQvRSBr/gcWvRF7ZKy6+0u5SRxrvaVA95mv+VyjTuc2kD4yt9
         rzFAYT2AImTn4VRqo3ApCZQpZ3rVuEOS4G8TuAf0BWZPvb9YeBRcRaBd872CnPKXIjGO
         8QatfyE3hzqo9KxSXO1d/94LFLxT8UZpvfsXUEsvnpwPzi8UFYTj2splmzXsI4w33b0Q
         BkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695903616; x=1696508416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bej93pKAZY6pGdcUKj7cDTtnV7lDIpgi1E7jduS7PN4=;
        b=a43FWUta7n0pqbXHsPDhfbjqLxy1hz/s0dT4LPBpDzDhYaA/UXYZLs2+RTVhHQJjsH
         R7wbC/WUQcQEkh59kXsMkUr6K17HgDfu2xV/a08TxHvawmlQ9YhtUrIHpCuQf1ECCD9K
         KFpEDZ/MzyghiBONLSBvvb4BYRPRG41vg+GYmv+36L18dNWODRQkh+P6HkBuTw2e+Efj
         6eLbQ+HItGFmto2SOX1+Pt0Iyz4AsFfbkLohCExSNwH18C6zr0UPb+3K0SXA/cnOsRWz
         WfAwAe8UCUDw6TXnuzmJ26JvSmsAmy0lW6jvb9p6emCftLCintIU06ZysKP+FKSsy4Y3
         jfTA==
X-Gm-Message-State: AOJu0YytZVJkZyn+CUBIG6PqgSo1h8izYDNx3VbCdDR0J6EqqgKAoigk
        Rw/gxcho+JyhnlwYbSQaZyYdR5V9vPY5Hg==
X-Google-Smtp-Source: AGHT+IHvrFLTDKw8ZI3LtSd8mz+GKvy4NkwlfH4f2yAyGtO5OyaOXOem8DxlaHFky48RpgrZaxzYSw==
X-Received: by 2002:a05:6808:1312:b0:3a7:44a1:512c with SMTP id y18-20020a056808131200b003a744a1512cmr1302930oiv.5.1695903615873;
        Thu, 28 Sep 2023 05:20:15 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id r20-20020aa78b94000000b006933f85bc29sm2183219pfd.111.2023.09.28.05.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:20:15 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v5 1/2] dt-bindings: dma: Add Loongson-1 DMA
Date:   Thu, 28 Sep 2023 20:19:52 +0800
Message-Id: <20230928121953.524608-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928121953.524608-1-keguang.zhang@gmail.com>
References: <20230928121953.524608-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add devicetree binding document for Loongson-1 DMA.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V4 -> V5:
   A newly added patch

 .../bindings/dma/loongson,ls1x-dma.yaml       | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
new file mode 100644
index 000000000000..51b45d998a58
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/loongson,ls1x-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 DMA Controller
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+description: |
+  Loongson-1 DMA controller provides 3 independent channels for
+  peripherals such as NAND and AC97.
+
+properties:
+  compatible:
+    enum:
+      - loongson,ls1b-dma
+      - loongson,ls1c-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Each channel has a dedicated interrupt line.
+    minItems: 1
+    maxItems: 3
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - pattern: ch0
+      - pattern: ch1
+      - pattern: ch2
+
+  '#dma-cells':
+    description: The single cell represents the channel index.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - '#dma-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    dma: dma-controller@1fd01160 {
+        compatible = "loongson,ls1b-dma";
+        reg = <0x1fd01160 0x18>;
+
+        interrupt-parent = <&intc0>;
+        interrupts = <13 IRQ_TYPE_EDGE_RISING>,
+        	     <14 IRQ_TYPE_EDGE_RISING>,
+        	     <15 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "ch0", "ch1", "ch2";
+
+        #dma-cells = <1>;
+    };
-- 
2.39.2

