Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638DA7809B4
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 12:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354775AbjHRKMJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Aug 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376345AbjHRKLh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Aug 2023 06:11:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAC2469E;
        Fri, 18 Aug 2023 03:11:07 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRyGF33ywzFqlx;
        Fri, 18 Aug 2023 18:07:01 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 18:10:00 +0800
From:   Guo Mengqi <guomengqi3@huawei.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <guomengqi3@huawei.com>, <xuqiang36@huawei.com>,
        <chenweilong@huawei.com>
Subject: [PATCH v2 2/2] dt-bindings: dma: hisi: Add bindings for Hisi Ascend sdma
Date:   Fri, 18 Aug 2023 18:01:28 +0800
Message-ID: <20230818100128.112491-3-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818100128.112491-1-guomengqi3@huawei.com>
References: <20230818100128.112491-1-guomengqi3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device-tree binding documentation for the Hisi Ascend sdma
controller.

Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
---
 .../bindings/dma/hisi,ascend-sdma.yaml        | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml b/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
new file mode 100644
index 000000000000..eab8192fac67
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/hisi,ascend-sdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HISI Ascend System DMA (SDMA) controller
+
+description: |
+  The Ascend SDMA controller is used for transferring data
+  in system memory. It utilizes IOMMU SVA feature and accepts
+  virtual address from user process.
+
+maintainers:
+  - Guo Mengqi <guomengqi3@huawei.com>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - hisi,ascend310-sdma
+      - hisi,ascend910-sdma
+
+  reg:
+    maxItems: 1
+
+  '#dma-cells':
+    const: 1
+    description:
+      Clients specify a single cell with channel number.
+
+  hisi,ascend-sdma-channel-map:
+    description: |
+      bitmap, each bit stands for a channel that is allowed to
+      use by this system. Maximum 64 bits.
+    $ref: /schemas/types.yaml#/definitions/uint64
+
+  iommus:
+    maxItems: 1
+
+  pasid-num-bits:
+    description: |
+      sdma utilizes iommu sva feature to transfer user space data.
+      It acts as a basic dma controller if not bound to user space.
+    const: 0x10
+
+  dma-coherent: true
+
+  dma-can-stall: true
+
+required:
+  - compatible
+  - reg
+  - hisi,ascend-sdma-channel-map
+  - '#dma-cells'
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    dma-controller@880e0000 {
+        compatible = "hisilicon,ascend310-sdma";
+        reg = <0x880e0000 0x10000>;
+        hisi,ascend-sdma-channel-map = <0x00000000 0x0000ff00>;
+        iommus = <&smmu 0x7f46>;
+        pasid-num-bits = <0x10>;
+        dma-coherent;
+        dma-can-stall;
+        #dma-cells = <1>;
+    };
+
+...
-- 
2.17.1

