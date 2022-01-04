Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2384843C6
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jan 2022 15:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiADOwR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jan 2022 09:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiADOwQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jan 2022 09:52:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC21C061761
        for <dmaengine@vger.kernel.org>; Tue,  4 Jan 2022 06:52:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o3so18490247wrh.10
        for <dmaengine@vger.kernel.org>; Tue, 04 Jan 2022 06:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXAzPQsg5I+E5DYLSQcCCKK+wJqUGxBemvQZ1bfwYvI=;
        b=Gqm+Uw7yxObjsdSzNZq+yLTAN7IuNuYwyVR/F6tcS3TV3LlIqnkNt7uLCf21E+L1M3
         wwmKzENS3zN2TCQjLD1SGcwCku2j2lCG3w1p3Cp5ACT2KHe015rZiTdNDjrpGGG4xiOk
         C/cXuFFK0F4gxQxQ0qv2BR0MJuxzjOcH2X6gtf5J/35Rbx3WiA5MnMKj/EZeDjhHbxMS
         Ej8ss1HxyCEyvILIJ4fYz/N55qrgaSjW9FRIi+3kaMVnKXEWvzddhCUaIQzL2vG3E+pa
         0XvhfbSdjsIOmGS7cxEQRM4O6BbSyiNYvqTp4I1KRUQasTwRj2ZhbGYI10Qh00Yi+NSa
         qDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXAzPQsg5I+E5DYLSQcCCKK+wJqUGxBemvQZ1bfwYvI=;
        b=ed5c1f39mjBCjuDnADWb78hmXijJOGRvgBSNPrO3a6dSU+w3v5DnCvTfGcp9jC6L3u
         KXZBlmr5G0dgERKr7BaCyrTpH4L8D5R7HkOn7FJCJxCNBxSl4QMI6lqqmO3rQkEKalSg
         HCppH1lx15KosChDcxNpWc8qSgoE5fqhIfjQqAHJE6miBZTKRaux7Jj2Y06MmjtaZpeR
         jcmhd/Fikmd7Ehi5IrN9FX7luLZ8hBkC9QsgdEDMTpH87sD4uaVw9Rgb+rNOY28DSCEc
         rPMdb6Re19SaOaO9BsBt1B+yZX9susBsCwrnPzj+FzL/G58fn9zy79ettlrQwBF3sgx3
         6LTA==
X-Gm-Message-State: AOAM5334mFeon+LibD1w5QBQM5UbfY0egwqNHY+P3R+gQVULQoQJb9gW
        hQ02lkX09Q5I2fe9b98FY3nt+VZPffQE3w==
X-Google-Smtp-Source: ABdhPJx4kQyL0ttnXdIRNhjV07Tkq2L16wjwU04mseESZ3DUxnFYbJE4jpsJy4ziJ7JFVSZc8x8LOw==
X-Received: by 2002:adf:ec46:: with SMTP id w6mr42885627wrn.288.1641307935035;
        Tue, 04 Jan 2022 06:52:15 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f6da:6ac:481:1df0])
        by smtp.gmail.com with ESMTPSA id s8sm44631911wra.9.2022.01.04.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:52:14 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     vkoul@kernel.org, devicetree@vger.kernel.org
Cc:     linux-oxnas@groups.io, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/4] dt-bindings: dma: Add bindings for ox810se dma engine
Date:   Tue,  4 Jan 2022 15:52:03 +0100
Message-Id: <20220104145206.135524-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104145206.135524-1-narmstrong@baylibre.com>
References: <20220104145206.135524-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This adds the YAML dt-bindings for the DMA engine found in the
Oxford Semiconductor OX810SE SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/dma/oxsemi,ox810se-dma.yaml      | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml b/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
new file mode 100644
index 000000000000..6efa28e8b124
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/oxsemi,ox810se-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Oxford Semiconductor DMA Controller Device Tree Bindings
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 1
+
+  compatible:
+    const: oxsemi,ox810se-dma
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: dma
+      - const: sgdma
+
+  interrupts:
+    maxItems: 5
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: dma
+      - const: sgdma
+
+  dma-channels: true
+
+  oxsemi,targets-types:
+    description:
+      Table with allowed memory ranges and memory type associated.
+    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
+    minItems: 4
+    items:
+      items:
+        - description:
+            The first cell defines the memory range start address
+        - description:
+            The first cell defines the memory range end address
+        - description:
+            The third cell represents memory type, 0 for SATA,
+            1 for DPE RX, 2 for DPE TX, 5 for AUDIO TX, 6 for AUDIO RX,
+            15 for DRAM MEMORY.
+          enum: [ 0, 1, 2, 5, 6, 15 ]
+
+required:
+  - "#dma-cells"
+  - dma-channels
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - reset-names
+  - oxsemi,targets-types
+
+additionalProperties: false
+
+examples:
+  - |
+    dma: dma-controller@600000 {
+        compatible = "oxsemi,ox810se-dma";
+        reg = <0x600000 0x100000>, <0xc00000 0x100000>;
+        reg-names = "dma", "sgdma";
+        interrupts = <13>, <14>, <15>, <16>, <20>;
+        clocks = <&stdclk 1>;
+        resets = <&reset 8>, <&reset 24>;
+        reset-names = "dma", "sgdma";
+
+        /* Encodes the authorized memory types */
+        oxsemi,targets-types =
+            <0x45900000 0x45a00000 0>,  /* SATA */
+            <0x42000000 0x43000000 0>,  /* SATA DATA */
+            <0x48000000 0x58000000 15>, /* DDR */
+            <0x58000000 0x58020000 15>; /* SRAM */
+
+        #dma-cells = <1>;
+        dma-channels = <5>;
+    };
+...
-- 
2.25.1

