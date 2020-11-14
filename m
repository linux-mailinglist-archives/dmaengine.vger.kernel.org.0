Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7B2B1FA4
	for <lists+dmaengine@lfdr.de>; Fri, 13 Nov 2020 17:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKMQJl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Nov 2020 11:09:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7238 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMQJl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Nov 2020 11:09:41 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CXk1b1Mtfzkk74;
        Sat, 14 Nov 2020 00:09:23 +0800 (CST)
Received: from huawei.com (10.151.151.249) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 14 Nov 2020
 00:09:34 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <dan.j.williams@intel.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt: bindings: dma: Add DT bindings for HiSilicon Hiedma Controller
Date:   Sat, 14 Nov 2020 00:34:08 +0000
Message-ID: <20201114003409.36406-1-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.17.1
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
 .../bindings/dma/hisilicon,hiedmacv310.yaml   | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml

diff --git a/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml b/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
new file mode 100644
index 000000000000..c04603316b40
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only
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
+    const: hisilicon,hiedmacv310_n
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+required:
+  - "#dma-cells"
+  - "#clock-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - dma-requests
+  - dma-channels
+  - devid
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/hi3559av100-clock.h>
+
+    dma: dma-controller@10040000 {
+      compatible = "hisilicon,hiedmacv310_n";
+      reg = <0x10040000 0x1000>;
+      misc_regmap = <&misc_ctrl>;
+      misc_ctrl_base = <0x144>;
+      interrupts = <0 82 4>;
+      clocks = <&clock HI3559AV100_EDMAC1_CLK>, <&clock HI3559AV100_EDMAC1_AXICLK>;
+      clock-names = "apb_pclk", "axi_aclk";
+      #clock-cells = <2>;
+      resets = <&clock 0x16c 7>;
+      reset-names = "dma-reset";
+      dma-requests = <32>;
+      dma-channels = <8>;
+      devid = <1>;
+      #dma-cells = <2>;
+    };
+
+...
-- 
2.17.1

