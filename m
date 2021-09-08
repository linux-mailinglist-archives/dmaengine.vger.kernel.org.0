Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC43403B9D
	for <lists+dmaengine@lfdr.de>; Wed,  8 Sep 2021 16:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349196AbhIHOe0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Sep 2021 10:34:26 -0400
Received: from mail-dm6nam08on2045.outbound.protection.outlook.com ([40.107.102.45]:48800
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349052AbhIHOeZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Sep 2021 10:34:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKMZVSI8oPwl6OObETOKdE1Dlu2GMpu0QsYPupuIbastXAQk7ohrtpRGCvAEQ+SZeBYwrg4FeAZoocPbXbDMMwM1ojiWcMTv2lKxD+gm52B/jolhcwI5s1bKuID4rttXqLlGIhOldasVTV+bl6Nt7AaP4hh7HzESZQejnPAmweDUKEnkOZ/Hu24GH3IG3B1/L9oQTER6zN5IezujGTQfwHy6HLjYuFnNVT4gjFJFq+sAALwGpqV2FXWdkinMsU8qVrudjFnoohlRgXxyfSJRO4jZbEMASb/dYdT1eReQEs2qwv2ctXw/eMgSqyELJpQKACxqFBW1OwTTxIUGZBLtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ixv5xKmcamnNZlum/L5cCxXznLClS5CQFV41TFsifr8=;
 b=Rz7XRuFeYjsu+LHWBhwQlWp0EABmDNveWUiwQ8m3eCseow67cjJ8fLKPuYzGCUKbmgmc7xwB5VzEP4rvQBIvDMrBePlNdLSjQ+FAQU6MIoXw84HlLYs8hoWR3klt1n41tTNEqlvGWVtqIUn843763PGvFE1SQ5t0orGpvN6a2agVs1MNTI6j1wVHFTh5wmZKes6DCc4+IFDaAUWyHabN+N0QhXqw3/ZJohPFMsXQoZh6i/av3UPQRvSdwilyKJY8rE5URfjAQRul/E5xdSzlfhHtPiELSitUTC7Vn25vQiehmqa2NAWwDRsektUGZ3geHPa4SE1r/4/+NqzNYsA0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixv5xKmcamnNZlum/L5cCxXznLClS5CQFV41TFsifr8=;
 b=nCUSe+C/0Iv3nXpd7nJtM8YAUo/eTU1LGZ4P82xQBMP1whVr6Sb4fKB2nmwMKe5n5816EbSNCXZVvm8LWtKRleZvAJqBpsVxnnTUCn8hfDiL8LWNVGtFMz55VrxS2w5juj55BIP1tiSCubSezX6BPLOjZvFNCD2pDj6z5GL67HSoNG4RaFQM0jrqaB6Khr1+oPGg8KLmu8q0KpaqcQRLVW6awSNSYygpXXV+6cA1zVB5922yNXGXBZG00g70pIMZRrbVWXCTk6pMdirw/Y6Gpaa6WaA61+tI8i5zrLceAjF1IoLiBUm65KsB+QIPix78wvrBZiHDfO3m2WIP6Qvc9g==
Received: from BN9P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::22)
 by BN6PR12MB1586.namprd12.prod.outlook.com (2603:10b6:405:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 14:33:16 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::5d) by BN9P220CA0017.outlook.office365.com
 (2603:10b6:408:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Wed, 8 Sep 2021 14:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:33:16 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 07:33:15 -0700
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 14:33:12 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Wed, 8 Sep 2021 20:02:15 +0530
Message-ID: <1631111538-31467-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
References: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94b95e9a-5d3f-4ab0-c848-08d972d5989a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1586:
X-Microsoft-Antispam-PRVS: <BN6PR12MB158642A0002C71D099F6C10CC0D49@BN6PR12MB1586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLdIO1P7pNHMW0Mbht61vKHFRv0u6QBgIHRcGEjk5u+jtCOwCaqN30Vm4XEMFNOSEDUQHr2siAOSpfMpXeRlwqeYcDd1tMvSW8ra7HmAVtfoXchSoccGn1rUQeoJnrN6n3MtBFr0f5SdnjOj9NGfRQOT9kIbQtj/qVatiGZrR3d9rnP0ukaKYAwKJxCZOMnO5XMhlbWJWKeB0sCDfSdXqGdsBDaQ9FOjuIKKHvS8DQYCAa5ggzqWZfHZ+CLal6RBGY+mfmnBGjyfl+Z6c28+tQ6Iy2IoxMGs1M6FIdkheWW+bkE8vs4d08jMuAi1rm8yViPmj1c2t7k2aW1o6tcgW/rIcGixXpBmXkqgEz/upv+2ro9lPPCr4IT3e1IsChCkvJ4giE+bqCnAyz/p9/PkjWZDOEF1slZ3uH4+MRsTxc7pil3GPm4xmyLh7cU0sAUVJahlQEHqi8ci8hU3QIwike5il7o9ywcO+VQXfgVrT7VQwJwxStE5JACCYtyMymtAWxdEcygEL06cg7wNeZGwN42hksJqTAUcOI6OjHmGNoUUpiLBu9Rw3SnYXRbEuhkJeyiBtUcKqCHfC/1QT4ktnwWA2o4XPxpamDpyokAPuWpeloFfc3LKHc4gUIvuBO2HVs0mJl8+fUSp3QdVkiNKy2N8juiJuHg4j1iqnXquO8Bje6ayJxSU7VM/K9T/qHa2z0FooST4rjgiCxMCF1bKItCxcJX3yPcK/17K75dgU92Dto4VSDtjwZqiv7EhNDAtMk9QvcNriNPvdG9Ywqbcok4knuMiRXca7+UbrUfXjIObI1N2uSaKtBR11U/3UmbTIQ/50yHp3r8ibkEWjoz1aQ==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(46966006)(2616005)(426003)(70586007)(966005)(478600001)(36756003)(336012)(47076005)(4326008)(82740400003)(316002)(54906003)(37006003)(7696005)(8936002)(2906002)(7049001)(6862004)(356005)(8676002)(7636003)(6200100001)(186003)(26005)(86362001)(36860700001)(82310400003)(5660300002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:33:16.1767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b95e9a-5d3f-4ab0-c848-08d972d5989a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1586
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
new file mode 100644
index 0000000..00c5582
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nvidia,tegra-gpc-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvidia Tegra GPC DMA Controller Device Tree Bindings
+
+description: |
+  Tegra GPC DMA is the Genernal Purpose Central (GPC) DMA controller used for faster data
+  transfers between memory to memory, memory to device and device to memory.
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
+	minItems: 1
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
+  nvidia,stream-id:
+	description: |
+	 stream-id corresponding to GPC DMA clients.
+	 Defaults to TEGRA186_SID_GPCDMA_0 if not given
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
+optional:
+  - nvidia,stream-id
+
+examples:
+  - |
+	gpcdma: dma@2600000 {
+		compatible = "nvidia,tegra186-gpcdma";
+		reg = <0x0 0x2600000 0x0 0x210000>;
+		resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+		reset-names = "gpcdma";
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+		#dma-cells = <1>;
+		iommus = <&smmu TEGRA_SID_GPCDMA_0>;
+		dma-coherent;
+	};
+...
-- 
2.7.4

