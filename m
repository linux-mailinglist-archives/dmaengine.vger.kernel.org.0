Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94825C9A78
	for <lists+dmaengine@lfdr.de>; Thu,  3 Oct 2019 11:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfJCJKz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Oct 2019 05:10:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43939 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfJCJKz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Oct 2019 05:10:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so1312861pfo.10
        for <dmaengine@vger.kernel.org>; Thu, 03 Oct 2019 02:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cl61NZhY5d45/Lbiju2rWHR/95fvQW/rzQHybTAnNrk=;
        b=UXdpOExk+DjqpI/3nuWER3Cht8DW7Do+r38+1fLADJv0vQ4hNM1f0Ag+4C9yGsB/VT
         zKWib8P0kpXAnS/PC2MSlK2mTflHfsCAav/ICDSntt8nvfmkm7FcYbRvA4jN0dElY8Rx
         vG2fIfbBtsHQwsEnulSya+KIj2MLK722ZMeDS0pumkvmQiozd6U/IBhEAiVNCbUinUVq
         2y5t9eWzfu6Z0i8iXDZb9OHImA8FnVb56aPXeTRguPG4FpaQGKEK5i6MUb17I84bJ9pG
         LPIw85fwBbdKx3g/sOEZDWFumMBxSOWOfJaqclkg4yt9Uj2UMNXnTap+8sb7nwmfSM86
         8cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cl61NZhY5d45/Lbiju2rWHR/95fvQW/rzQHybTAnNrk=;
        b=noC5jDxw+GtbUVueiItCLgg3+oQTUuRO580TQMGuIYnuus6PNiuZNw8JnOBiOxsERA
         hVPMNx8+sG5LswGMIBa8qztp9WzLBc2UANjhyo585JcuTJd266YgrXy+GlXxfgVK1roY
         kIMfkIRKg2GuGGp6WDslDj70o+/0IdfNBCGs3NM6O6zUkRaOVPdlem0XRkZFwb2IHM//
         wHoc76+lE8ie3+5QF5O/8C0WumN/WW6Ti1ktgokFZN+eOtdmUv1flTWjSk8nPnppqS12
         lVXweCtC07eB3X3mxg3oPuiRq2hxJkNSprViOgcoPdwEUAfK/6vn4zTjtwpSHLBsm6Rl
         GVBQ==
X-Gm-Message-State: APjAAAXx5Oo4u/LVg6R+vWrfb2xsJZh19MbgnR0cR4PGymoSuuVLpJSW
        BWOuesT0RYYqX89UGLefv5iZQg==
X-Google-Smtp-Source: APXvYqzlBZJdgGNxd7XyFiEOJlwPzViCn8Ox6kTrAJFA7m0/z333Jav775/eeVAQrCP1PSa2KM2oZA==
X-Received: by 2002:a62:e109:: with SMTP id q9mr9618993pfh.231.1570093854790;
        Thu, 03 Oct 2019 02:10:54 -0700 (PDT)
Received: from localhost.localdomain (111-241-164-136.dynamic-ip.hinet.net. [111.241.164.136])
        by smtp.gmail.com with ESMTPSA id f128sm3445422pfg.143.2019.10.03.02.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 02:10:54 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
To:     linux-hackers@sifive.com
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yash Shah <yash.shah@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
Date:   Thu,  3 Oct 2019 17:09:01 +0800
Message-Id: <20191003090945.29210-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191003090945.29210-1-green.wan@sifive.com>
References: <20191003090945.29210-1-green.wan@sifive.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT bindings document for Platform DMA(PDMA) driver of board,
HiFive Unleashed Rev A00.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
new file mode 100644
index 000000000000..2ca3ddbe1ff4
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/sifive,fu540-c000-pdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive Unleashed Rev C000 Platform DMA
+
+maintainers:
+  - Green Wan <green.wan@sifive.com>
+  - Palmer Debbelt <palmer@sifive.com>
+  - Paul Walmsley <paul.walmsley@sifive.com>
+
+description: |
+  Platform DMA is a DMA engine of SiFive Unleashed. It supports 4
+  channels. Each channel has 2 interrupts. One is for DMA done and
+  the other is for DME error.
+
+  In different SoC, DMA could be attached to different IRQ line.
+  DT file need to be changed to meet the difference. For technical
+  doc,
+
+  https://static.dev.sifive.com/FU540-C000-v1.0.pdf
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu540-c000-pdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+
+  '#dma-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#dma-cells'
+
+examples:
+  - |
+    dma@3000000 {
+      compatible = "sifive,fu540-c000-pdma";
+      reg = <0x0 0x3000000 0x0 0x8000>;
+      interrupts = <23 24 25 26 27 28 29 30>;
+      #dma-cells = <1>;
+    };
+
+...
-- 
2.17.1

