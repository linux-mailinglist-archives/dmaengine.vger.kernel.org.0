Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E611C4159A6
	for <lists+dmaengine@lfdr.de>; Thu, 23 Sep 2021 09:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbhIWHyE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 03:54:04 -0400
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:46817
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239813AbhIWHyD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Sep 2021 03:54:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF6PXpN/O2mJlZeSPzDvDYFp3BvqonuG/ZRfoItCRBQKHa8QXyslVvx0SNgPvozwNSxURvLeu4dtrTOjBScZ2ridGQiE4F5zlTqkRNxS5rDRVWIOoNevj5tCSenXxLh7yu/7TFpyACLDI6B+E8J3udtb8Yfuvt2Y1Y+b022UKt5ofs7F8U2MIfXYYl0E0oCCurxkolIhcVDhH7YaVJjSpBEzSlRcWoCxsbCSZvLFIkD1Ne9f5dJRs5Ff+VTB/bnz8xlpvug1eGJTCylgbX9Z5Lj7C7jEbx69Ge+2RYhot14+eZM2V1NHK93TeiRcDTu9vVwzj03xQRDg8Fg3iRqaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ycPzBocCtwuKkbtCK1eVpz3nVNDAPmxeENd33W4CCVk=;
 b=bKIj+v4PcvhKiLIfBRsomfXCxThNqlgWDeVNw38KFbSxe+4ZwASKb+NPFNr2KoSP3DK/nIhhSGD4YhW3ecADQY3PosBAs/sp2CeMSuso/OQIoMs8hlEvempmrPvxFP6Ot/dIZIeK6qrJ/vlBNQHrD6yXhw7L9JBV/vu8/dNJetm+jccF6s/bzqdFN1/XcHxCYCzFn6Q0tRRD8JhsTGyiEXxTv8/nB8HZ7/8f2v7VwZ+mlnAM0AXNYh9fY+qxBn8Ql7FVH1G8S8bhO/0+4Jrudo80SvSL3jOeAIm5zhqjLZ9WnpaP+vKEO82qJHb4zgpG0LR1K260Nk5peG105SzO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycPzBocCtwuKkbtCK1eVpz3nVNDAPmxeENd33W4CCVk=;
 b=I00M1qamJZT2RZWUvXPejpukIM9ujNZUDQhqiKqyLG1chHDK/+5lL1LN/iqKKdwGOjxNATX+Cp2lMMqe7wIPU7iejZnW3+DJR5/6pIDZjr2cAjh3FDEsIbJhIhqEEQVZMKAtibm3PwGxvsr9ACt5nQKppwWwkuDb9cwggM9vz6Ur1c+5fw4S/OSLRnHMHSDm/mXdjOUHgfavvuNBLyGLaQYek129Rq23zDJXBFhXpFqE0RoAtr+v0oOM73cmwuZa21HkxhcAxVwMogVQIhU14qu9IL2EOqXCLFK/EknxCgS2Rtqr8YkFK6rJhuQFq4UNaIE6DTR/ke9k73R1QClGpg==
Received: from BN6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:404:13f::34)
 by BL0PR12MB4897.namprd12.prod.outlook.com (2603:10b6:208:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 07:52:31 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::ba) by BN6PR14CA0048.outlook.office365.com
 (2603:10b6:404:13f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 07:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 07:52:31 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 07:51:43 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 23 Sep 2021 07:51:40 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v7 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Thu, 23 Sep 2021 13:21:21 +0530
Message-ID: <1632383484-23487-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632383484-23487-1-git-send-email-akhilrajeev@nvidia.com>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
 <1632383484-23487-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a707f98-e75d-45a2-c299-08d97e6718f4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4897:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4897577B34105619B212B3B5C0A39@BL0PR12MB4897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncqhI4ar0Tqz9RY7VTxXAs0Ak6r2iYFxNMmaL7q2JzcJkMxJy0SMexNwuVwCBEiPpx3ZypQTqe6pCC1eCnODazH9rQQpKbGqi5qrwDWuecND+o+KZe2dIxTssHrCU29gOGBgD07wIXyz5INOV8g14M9Wr3sZRf5VagvhxZ5eHVJMOi7OThXnZxGkWO4P9iped44hZqOeBIers6KeWyxHtW2AiTseGsebs5D8wu5pwBmq2BrwdKRTjLAUuXD+kOHqJ/0lXkAFqg82a/dnWXcDw6KFHgfTuwEdKLdkH//VJol0Rc4Me2RneQYFwhB21EzVVeoLOntnh0TJnLiKFOXRbLLmLYqT6L42pUOr7sGYFeHpJFJ+7tRab2OLTYixdi4GEDnTnFxm3QUQ6royJ93Xvy+njlrTEp+nzmlr2xgphnSuQe0iqX96BAyVqdoB5sw++mLerqz+VIGWlV/d/JIV9v75u+NGQyRhqgSVBc3Ta5MdaQl22qWDZf/ylUuLo9quhWD9jWL5pPjWZywfTw1yz9NsFjjLteHoMPXoJ6NOWS6A01IWCL31128LhxIiL7KzquDa0b6iqSLRuk6smN5L8UeFKDrhV2bMMw8Vyd98sicYV4wISUkxYdS4AUFksgDYXbdtFX3HcvTNLPFV/ZI7hLz3f4VW9Dv/xEP3RzXga+MR1WGm0m8qDR4F78njkWmaweq0hKt3o67W5C5QWWQsBKhY0DpheNYupEyqMboTcHyYRdNlzQu/tueBdFPq7yQhBX3aYZ/QahCSlbYEgNyfJ7p32bnQ7FmWN1i8jzrJya5Zsj8p0Rs1tb5oNiDjh9/OZUSQV4C7lxW/PfyAlU3HDQ==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2616005)(6666004)(7636003)(36756003)(8936002)(7049001)(508600001)(70586007)(86362001)(6200100001)(2906002)(54906003)(70206006)(6862004)(966005)(37006003)(336012)(426003)(47076005)(4326008)(82310400003)(36906005)(356005)(5660300002)(7696005)(8676002)(26005)(36860700001)(186003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 07:52:31.3361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a707f98-e75d-45a2-c299-08d97e6718f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4897
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
+	minItems: 1
+	maxItems: 32
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: gpcdma
+
+  iommus:
+	maxItems: 1
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

