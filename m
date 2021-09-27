Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA495419895
	for <lists+dmaengine@lfdr.de>; Mon, 27 Sep 2021 18:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhI0QNX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Sep 2021 12:13:23 -0400
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com ([40.107.244.81]:58464
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235417AbhI0QNU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Sep 2021 12:13:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZcnFHEVl3t5KAxi5RAHcaE5YxYmVCaCTyOXYYmoD4KQXKQacJWI4PHjYHJTfK6QZiihkRnqFQe5Wqwo9XtpIWmgZgcrpJ95NPgpEZi7dowNLVCUq36kjtBd9/YD89ndx79l09fO4bZ1ljWZN5/rad2fgNYhNqlw8qbPsSXslZ0tZ3PnQKH1ByO+lCyHZBCKjD7C1GKZQGgeewvX6huTco+8qwuRGBSgzHNDU3pX+LyCHAgXF1tlefxjGKJ/9gFmyJ9MJrkdHepYBb6zZ2wA6IF9gSatQQgjtE7u37r7dPaagucE3J7mu5B+0fU02EgSrd0/qHNOMyD6jYz1/pMhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=D8pgWUBhqgiLH/Ell7bLACkgGuD/30pyqn5BFZLQ0SI=;
 b=lB9jCNMT0k9pQfWnn1FpZrhp1HEBApSIawAQfPboDm8YFXL7jvGOq69xIvtuAQ2ru1IWrJvgRXbE6wRP9kPhp7etWG576qvcDTQ/K4UXAzpdZjBzP14T1Wfb3qG8TR8sPG1S/9xniEOsgio0F66JzT8Iqs79XjEosmQs8eMK74oHeGOQT6kMabcLEMUa6s1nXiB5SqtSMesGaKqWX6HG9OlY5d0FEBYgw7g4FPid5ZuKUD50w0XcfadMJsBooYcSh6nW0IXR/tN+um50pjIbPhLq4wFJ0OnzAOVPyJizev+eZLz2Ugr4luwW7rU6j4v1MbZTw1cUGqWkk6Ifr2LGOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8pgWUBhqgiLH/Ell7bLACkgGuD/30pyqn5BFZLQ0SI=;
 b=Y5rU9A5K/JZzj8R+2ZRLLub6K9fZmR+5P1mhUbz4j87zakpsG2BvqIu8MV0QYij65tRGygaZi8MEpZKAO2rjwAFzItxPzfnOriECuHZtp1zON1ikLsaHkSpEy+kv1H9uMi5USQtQaCb369/WWS+elM/B7Y3SCRUQ4vTXL30ljwuAX76Uop3hNFTpyGBJiUxGEB50BEF2bMgwy+6MeUhiMriTpJ5zK+byA4Wf3uYtfP5kL+Pg1Mrr6ju5clC1Fzs5MHchVNJ7ByLpf+5bQaGN1hw1ootof6vbTeBh9hlSGpKh7Ca5WTBLaOYuhG/nP/DaJUR0AkFtm4Tsowf3w4Mjug==
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by CH0PR12MB5298.namprd12.prod.outlook.com (2603:10b6:610:d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 16:11:40 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::e6) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Mon, 27 Sep 2021 16:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 16:11:40 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 27 Sep
 2021 16:11:39 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 27 Sep 2021 16:11:35 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v8 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Mon, 27 Sep 2021 21:41:27 +0530
Message-ID: <1632759090-7965-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632759090-7965-1-git-send-email-akhilrajeev@nvidia.com>
References: <1632759090-7965-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 670e7989-5c46-47ab-f582-08d981d17d90
X-MS-TrafficTypeDiagnostic: CH0PR12MB5298:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5298F4728CD758EA396C6B58C0A79@CH0PR12MB5298.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEsZFDh3furvZndPYqSR44TtvcAx3iRN3YDaEMYgD6cfFQxMNB3pc/CMfq3yRVbvv3EfPKn2iSMYpbls2HcWFTLwWMIH4pxRdpp0h5YmkUt3G8Spfi2DCDmzev1eyt1TM3cmIrDICDn/ov9xakdgZF4d0PDDkX/Y6UMY4QxMyirBDFPs1ots0ThVpRc5QWfdhdiPTZJnfgZEBQ7+TErtIRJ0Jxvqxugt4xdDBE/U7w6CaBnchyV+otIUgw1CrxXqZ4zl9TbeDRufxiLeJ7RctEbIdynMXeJLcqGARKljPxRO9Hbkgj4tXg2gddUM4iv5bC1tMjzzqTyHFJ+bOvUgGT5Jbvvc8VLS/TjcN5TowHwg+4oSNO8oUfmnSPPXpLI4u0HBjo0o+00RGrg6ygGEvowdDAKu4Z14+puFV1YPcH/Z+XLN10SAm6s0jMk16wM2B8bOXKlOC6x1wu23wgo9Bzc2WV8VCQxvH1ZRdE7MlngfehyMXWpIieCtj4tvyrVm9IV54/4AZ566EsCnHy+rOW0qcSu7/2MUpGS9CIBeC815uS/dLrcXd1r86B3MS23VDDO43ijliMSgRK9vUK+SkvVifQTRaepnN//UNcP9XBE1+Lkw9Vh7QC0ytgt6Zt/dFCrgN+qwnZdL9M8yMXwPKWhNcJDBoCOy5hxACFjIz3lxoMK1qP3Kk5EDNZgfS3QNZOkSHduxz0PPalcd19FUal40Ygnmu0IP90a3UFvoKs92zuJaockU3GtDTroQoEo91l9syyLPPsrfvcKuZcXOLoMOku67XsFFt6/77dpwD6FbCIqEMOwfLm+9qx+s1eUwHZfyMK2fBbolxEC2WC2ekQ==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7049001)(26005)(186003)(70206006)(508600001)(966005)(36756003)(7696005)(6862004)(6200100001)(4326008)(316002)(36906005)(37006003)(70586007)(54906003)(36860700001)(7636003)(2616005)(82310400003)(336012)(8936002)(356005)(426003)(47076005)(6666004)(2906002)(5660300002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 16:11:40.3216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670e7989-5c46-47ab-f582-08d981d17d90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5298
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for NVIDIA Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 108 +++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
new file mode 100644
index 0000000..d3f58d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nvidia,tegra186-gpc-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra GPC DMA Controller Device Tree Bindings
+
+description: |
+  The Tegra General Purpose Central (GPC) DMA controller is used for faster
+  data transfers between memory to memory, memory to device and device to
+  memory.
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Rajesh Gumasta <rgumasta@nvidia.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+        - nvidia,tegra186-gpcdma
+        - nvidia,tegra194-gpcdma
+      - items:
+        - const: nvidia,tegra186-gpcdma
+        - const: nvidia,tegra194-gpcdma
+
+  "#dma-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 32
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: gpcdma
+
+  iommus:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - resets
+  - reset-names
+  - "#dma-cells"
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/tegra186-mc.h>
+    #include <dt-bindings/reset/tegra186-reset.h>
+
+    gpcdma:dma-controller@2600000 {
+        compatible = "nvidia,tegra186-gpcdma";
+        reg = <0x2600000 0x0>;
+        resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+        reset-names = "gpcdma";
+        interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+        #dma-cells = <1>;
+        iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
+        dma-coherent;
+    };
+...
-- 
2.7.4

