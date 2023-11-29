Return-Path: <dmaengine+bounces-305-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C07FCF81
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 07:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA111C20BEE
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 06:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4335A107A3;
	Wed, 29 Nov 2023 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9319A6;
	Tue, 28 Nov 2023 22:57:21 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sg95c6WYQzsRX9;
	Wed, 29 Nov 2023 14:53:40 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 Nov
 2023 14:57:18 +0800
From: Guo Mengqi <guomengqi3@huawei.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
CC: <guomengqi3@huawei.com>
Subject: [PATCH RESEND v6 2/2] dt-bindings: dma: HiSilicon: Add bindings for HiSilicon Ascend sdma
Date: Wed, 29 Nov 2023 14:53:05 +0800
Message-ID: <20231129065305.70364-3-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231129065305.70364-1-guomengqi3@huawei.com>
References: <20231129065305.70364-1-guomengqi3@huawei.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected

Add device-tree binding documentation for sdma hardware on
HiSilicon Ascend SoC families.

Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/dma/hisilicon,ascend-sdma.yaml   | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,ascend-sdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/hisilicon,ascend-sdma.yaml b/Documentation/devicetree/bindings/dma/hisilicon,ascend-sdma.yaml
new file mode 100644
index 000000000000..7b452b54fe0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/hisilicon,ascend-sdma.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/hisilicon,ascend-sdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon Ascend System DMA (SDMA) controller
+
+description: |
+  The Ascend SDMA controller is used for transferring data
+  in system memory.
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
+      - hisilicon,ascend310-sdma
+      - hisilicon,ascend910-sdma
+
+  reg:
+    maxItems: 1
+
+  '#dma-cells':
+    const: 1
+    description:
+      Clients specify a single cell with channel number.
+
+  dma-channel-mask:
+    minItems: 1
+    maxItems: 2
+
+  iommus:
+    maxItems: 1
+
+  pasid-num-bits:
+    description: |
+      This tells smmu that this device supports iommu-sva feature.
+      This determines the maximum number of digits in the pasid.
+    maximum: 0x10
+
+  dma-coherent: true
+
+  dma-can-stall: true
+
+required:
+  - compatible
+  - reg
+  - dma-channel-mask
+  - '#dma-cells'
+  - iommus
+  - pasid-num-bits
+
+additionalProperties: false
+
+examples:
+  - |
+    dma-controller@880e0000 {
+        compatible = "hisilicon,ascend310-sdma";
+        reg = <0x880e0000 0x10000>;
+        dma-channel-mask = <0xff00>;
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


