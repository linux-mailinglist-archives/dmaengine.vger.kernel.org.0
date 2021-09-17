Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F24340F9FE
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 16:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbhIQONo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 10:13:44 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:37088
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242050AbhIQONc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 10:13:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByeXw7q423LsrdeIiEHxJmFAlli6Ke2y3vTiezchhAGlFqy3fG7J2cSmxzIYaCsIluReTUSbIf0elQMjDWp2BhF2w8Eu2pqVSDkPZ/wAXQ8O1lfaTczDFFf9mc/3GpXPpwDf5qXI3+qwpoGqs6Wz5fJboKYCR8Oxlrja7nIbwU3ltJO+4n52kYM76+RXkJOegndfDRYcABDVAna4ZPpS+PwSneRUgqtb5EmTfakWJZtghiZKP9Ezl2aDrDyFKarDqsO6wbCILTAe8JIxDj3HvIVPv+PCkKLCJ923UAg449hPV7kJf5LU/j3TJubJqDmC5EjylqshVrP1AvaXPzCVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ycPzBocCtwuKkbtCK1eVpz3nVNDAPmxeENd33W4CCVk=;
 b=lseM3ioFhbNPUMr1U6s8qyeV1FYdjRPGGSCQ4P2yYWSWIxFKgUa+tHn1c8DfA2u0w5K7iNLg+ZA+//+rSPzJKspui8Rs1Z2GrAK/GaNdiPrl7nNX3BWsylMeFSCBmcINQV/fbKnGxYSbQ1wsuXGq2EJEriCioHCFM+Z2yaYqbuKmjhA/lzxXmc16/yBM+18Mzj/Du9Nx4j3u7I2L9XjGpJ/1uyPvsApJaj/14R4pxasQgWQM2uieGPvNSarprGWbqGW+szZobSK+psILMUCXPWaM8VLBSWpwFGSg6Nj6NBIZqN9dnodOFpCi0TxwrYuBkxifNPaAEGMML+yo8CxgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycPzBocCtwuKkbtCK1eVpz3nVNDAPmxeENd33W4CCVk=;
 b=g6/p41jW3P+zYjgHNmDr274FX77cKRQ/ke3/aNLQUoBYrVmJMCi1hNe0rEirGEkuvQzztmiCEFzwim4+6Uw7G0lGyDRSZ0/YGwB/g7BRTMyXsJhkmsn/VRWHwHjPtUAdzwS35lFALhDHXlYudo/yLLXBYmnmav6AJHlsZuBTXrcwmkWraqEouN2DIf1ForgRaPDymxEbSsdSMw/Qcno854Tyh+I6QBTjrarV2LaiGYmr6U5fODUbDX2yuEPqpKfD8KDusaPtNcjrTpA1/P7tELIEEQo/PvI0Hf1l8fC34MCIz7GwGJB5Y7l1ieSPGERrwhIDvfpuT4ZS14mHv2HYfg==
Received: from BN9PR03CA0388.namprd03.prod.outlook.com (2603:10b6:408:f7::33)
 by SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 14:12:08 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::f5) by BN9PR03CA0388.outlook.office365.com
 (2603:10b6:408:f7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 14:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 14:12:08 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 14:12:07 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Sep 2021 07:12:04 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Fri, 17 Sep 2021 19:41:24 +0530
Message-ID: <1631887887-18967-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 697354b1-ff64-4a52-fd9c-08d979e522c7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2560:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2560FCB8E2C5A095969D7B61C0DD9@SN1PR12MB2560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqH907TXbnm0HIRR0vjqntMUBj85dF0ksDoGo1zgctQmDqPjNyPQgbu51CIJ7JTzIzQCgZC2UiKKSKPhKW9umywkhG2jUuKmxsyS+zYdfNIi1WHvvao3HGPtgyBlZD8yongWnwkzd70nFnshlqrnBiBPLl86NQiEAPDm/MPK6iSQ5IFSnPSXrUbWG/dArx91oUZWGFJ/AXspZDsACu0iKza4Ra7DVwa9ooN0sErdrq+PGm+sIgzkF/nBMvMZbCfcUv3JJ8aONKjR6tPQ6WL7O7Rc1A/Zvg0cr+hdGzwr/+CYREmYYLjxBP1QHTvkzVipCZnCC8o3MhwTqDyp3kM1zcNEGScn2gJzta8kmY8NfAdnR45g7KWjXFvSKns7Hzi3bSFoP6onw3xj5jCSHNCQCj4We8jS3SwvNvYneWXs7pvlIbQMVW/EWn+hKp0T9XM5QCPyl+y9k+z6r5zsamOpPLwm+++E1/2PhCFrMR1/jRzClAv4VfDcaozb17q70UDXSEcMKhkK0QI48JY2yHMf8EKRef+jyhIeZu0qr4dVjTQKbOXYSKWVfqll9yI4LRlLWPcdts3MPYhqo08cck8ClWGFurs/HCs9IOhCI/h9PgKgJ3CzC9T7kNW/LtGjKfWd0f5jW42AmvHF4dR5pDLcQ3RQT9zl+CTgcWeljIFjZkCG6upBK1upRSIeN8/IHNl2ri5RuoNA0yGzw7sFG5ghqemwS7weTDY/TB8BIdEaaNcOwmpZ3xoxmGFfbNSH4kZfUpmsGYM1D6016ILBlKWfjTmPQP3YCYcem5J3dmSTUBXKKl8bCKPWNbc9gcbisEp39f4k0b/WQfgd7fVxLa8xGw==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(54906003)(2616005)(37006003)(70206006)(478600001)(5660300002)(8936002)(8676002)(36860700001)(26005)(36906005)(316002)(7049001)(82310400003)(336012)(6666004)(6200100001)(356005)(966005)(6862004)(47076005)(7636003)(4326008)(82740400003)(186003)(70586007)(426003)(86362001)(7696005)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 14:12:08.5930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697354b1-ff64-4a52-fd9c-08d979e522c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2560
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
new file mode 100644
index 0000000..3dcf5a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nvidia,tegra186-gpc-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvidia Tegra GPC DMA Controller Device Tree Bindings
+
+description: |
+  The Tegra Genernal Purpose Central (GPC) DMA controller is used for faster
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
+  "#dma-cells":
+    const: 1
+
+  compatible:
+    - enum:
+      - nvidia,tegra186-gpcdma
+      - nvidia,tegra194-gpcdma
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
+examples:
+  - |
+	gpcdma: dma@2600000 {
+		compatible = "nvidia,tegra186-gpcdma";
+		reg = <0x0 0x2600000 0x0 0x210000>;
+		resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+		reset-names = "gpcdma";
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+		#dma-cells = <1>;
+		iommus = <&smmu TEGRA_SID_GPCDMA_0>;
+		dma-coherent;
+	};
+...
-- 
2.7.4

