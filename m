Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234592D7513
	for <lists+dmaengine@lfdr.de>; Fri, 11 Dec 2020 12:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405216AbgLKL5z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Dec 2020 06:57:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9193 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395386AbgLKL5g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Dec 2020 06:57:36 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Csq482XnLzkpRc;
        Fri, 11 Dec 2020 19:55:52 +0800 (CST)
Received: from huawei.com (10.151.151.249) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Dec 2020
 19:56:26 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <p.zabel@pengutronix.de>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <gengdongjiu@huawei.com>
Subject: [PATCH v6 3/4] dt: bindings: dma: Add DT bindings for HiSilicon Hiedma Controller
Date:   Sat, 12 Dec 2020 13:08:39 +0000
Message-ID: <20201212130840.402-4-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212130840.402-1-gengdongjiu@huawei.com>
References: <20201212130840.402-1-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.249]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Hiedma Controller v310 Provides eight DMA channels, each
channel can be configured for one-way transfer. The data can
be transferred in 8-bit, 16-bit, 32-bit, or 64-bit mode. This
documentation describes DT bindings of this controller.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 .../bindings/dma/hisilicon,hiedmacv310.yaml   | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml

diff --git a/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml b/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
new file mode 100644
index 000000000000..f57703fbbe7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier:  GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/hisilicon,hiedmacv310.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon Hiedma Controller v310 Device Tree Bindings
+
+description: |
+  These bindings describe the DMA engine included in the HiSilicon Hiedma
+  Controller v310 Device.
+
+maintainers:
+  - Dongjiu Geng <gengdongjiu@huawei.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 2
+
+  compatible:
+    const: hisilicon,hiedmacv310
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  hisi,misc-control:
+    $ref: /schemas/types.yaml#definitions/phandle-array
+    description: phandle pointing to the misc controller provider node and base register.
+
+  clocks:
+    items:
+      - description: apb clock
+      - description: axi clock
+
+  clock-names:
+    items:
+      - const: apb_pclk
+      - const: axi_aclk
+
+  resets:
+    description: phandle pointing to the dma reset controller provider node.
+
+  reset-names:
+    items:
+      - const: dma-reset
+
+  dma-requests:
+    maximum: 32
+
+  dma-channels:
+    maximum: 8
+
+
+required:
+  - "#dma-cells"
+  - compatible
+  - hisi,misc-control
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - dma-requests
+  - dma-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/hi3559av100-clock.h>
+
+    dma: dma-controller@10040000 {
+      compatible = "hisilicon,hiedmacv310";
+      reg = <0x10040000 0x1000>;
+      hisi,misc-control = <&misc_ctrl 0x144>;
+      interrupts = <0 82 4>;
+      clocks = <&clock HI3559AV100_EDMAC1_CLK>, <&clock HI3559AV100_EDMAC1_AXICLK>;
+      clock-names = "apb_pclk", "axi_aclk";
+      resets = <&clock 0x16c 7>;
+      reset-names = "dma-reset";
+      dma-requests = <32>;
+      dma-channels = <8>;
+      #dma-cells = <2>;
+    };
+
+...
-- 
2.17.1

