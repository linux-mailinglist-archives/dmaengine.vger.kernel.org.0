Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6258477A10
	for <lists+dmaengine@lfdr.de>; Thu, 16 Dec 2021 18:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbhLPRMT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Dec 2021 12:12:19 -0500
Received: from mail-dm6nam11on2062.outbound.protection.outlook.com ([40.107.223.62]:7033
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239701AbhLPRMT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Dec 2021 12:12:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtydVV8JgHvKF8MZSbmBtsF9omJAT/FZoadwvjeEP8nSTlLHEIKHPwhF26xwDJWMk6UCNt/3QE9jka656hXFMXkJEM8ZNTKH7tXspt+UPrfhTtJ07FHznmndYF0hzHv9Tp03Eztg2U3m2dXOkvfbQU9ZTEcs4jt2UruytHoDvRcYEoxeBYHkw+Z+fbCobgvZQw2xsYfdoemejPn506MCeKbjqlx62/+Z2Udp0UazWEFyRRxguTw+lNgX1w4yDdpHZk8lqMVy+D9uaHqUH0CTVdHqHkDfEInYeq001ytaJ1pNBT7LHqFop0Izin9LhArB8S8z1aZn9QFlFewCaS0H+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WndexYVCK98d38b2fVEzcBXyUysSWHywX1VgnTCHrA=;
 b=VGQ+6SuuYcqIj8NhdxQ82hJOpCqyY/Z9w8F+qknqBnGUAsBzhMHcWLNBgV6lhgeR3URYoZJBrsIzUIvzRBrYG7KSKc0gonB9eiYiFcIcAhZQfAsfA1JVHAAwsD+JxBY3uiqgmRBqw14GhIZLDRk33RuDImdtK3QL3ki4EYFj535Bv4fsn+xmwfzmD9UcHHfGiwIIoetsrAXMT4I3iBwCeYb+16YdGzz5TP3/dmGoE8grrRgz011M/bUs9eVkYMm/jAwhuX1iBI+VFa8XL8oxH1wR/PQkSsoyFDT332RVtgV9D3kELdFbmqkC9DtKDZdQ+tw4tSTa/A9qoYMNq0H7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WndexYVCK98d38b2fVEzcBXyUysSWHywX1VgnTCHrA=;
 b=OjSOh+RlBk8jWKIAmxfiveCzrkDZiWRzRks/TBO8IJ3r8sonoGtR2jPWyK3C6T6gjvAqcecIopHbtBud6QZX6kfpzg+uqjO5oZwxD9dewgvB0PZfw6hWt0S8FtRxaTmTdxCnDKG4SOc2gFuT471WeZASBsN/sWNJrwKTw7tcd7C1HBzWs3ny1zoE6VBDhibO86A+sQQT5SANIGrQXJlyAVDMyCxREonyh9Fm1CW/jaXYNJukEkJE0EFNKNdWF9Lr0sR+3oVlZ1umd3fmE1FOI8DiL+/KC3hkMYwtywZgM486umKscldjJwEHC1vppeqcdLtw88FYwVeCcLCv7UaLig==
Received: from MW4PR02CA0027.namprd02.prod.outlook.com (2603:10b6:303:16d::32)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 17:12:17 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::80) by MW4PR02CA0027.outlook.office365.com
 (2603:10b6:303:16d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 17:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.16 via Frontend Transport; Thu, 16 Dec 2021 17:12:16 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 17:12:15 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 17:12:15 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 16 Dec 2021 17:12:12 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v15 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Thu, 16 Dec 2021 22:41:57 +0530
Message-ID: <1639674720-18930-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639674720-18930-1-git-send-email-akhilrajeev@nvidia.com>
References: <1639674720-18930-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18251bf2-f92f-4ad1-dfc6-08d9c0b73620
X-MS-TrafficTypeDiagnostic: DM4PR12MB5360:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53606E2775485DF2F0E4C2C4C0779@DM4PR12MB5360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UGZ955P9+MMfMk1MLF+72u0lqEoNMXN00gyl/hiPPQxWfimskM125flaXB9m?=
 =?us-ascii?Q?s50LlNsGB8Pks0ly+zkrrnnPvQLquADf//cCVmFNyvJtLRqkcwotjq37EM+u?=
 =?us-ascii?Q?P86EOmOLVmleCDWZ7eqsHBAiidIAzJIMy5+g+NyVpHVsDKMDZiBHfJBn8y1t?=
 =?us-ascii?Q?8SF8DYc14l4h21IQobkQc0vgpq2hwLVE0CE6GHdO6CmH2b4lv4c26WHc17wI?=
 =?us-ascii?Q?KrZn7LN1Ca+yJ2IHmBQjUPO+CZm9fvZ9MRCQhDBTKKeB+oeN2iCZn+bL5yn8?=
 =?us-ascii?Q?+NOvw6oNJBjScCBvFopTb+cU7lvIJ/Ub0C0s9THqcZNoflb4cx4ct9+EihEa?=
 =?us-ascii?Q?AsHuugPX7GFAp/wO9yDUDRYMRPkoWbOcCEgps0JoJAQyf6Hl5KAD00P7jWF1?=
 =?us-ascii?Q?xPxKn91VNeGZ/Rah4sFMH55Gctnr39i+DdfQYyy+/H7S/i1bmSBayzzi8Lm3?=
 =?us-ascii?Q?nxNCUWQXXW3EjG/92iGklSgp7FwczmO8gIFOECv6KunFeJ/xn/LFCAe2FJFH?=
 =?us-ascii?Q?xut6OeFLk+YzrSeOh35rwG4akIUtGTAYcrp876wFMbqYYNhUYU5uBNLXQUyP?=
 =?us-ascii?Q?IHLdmq77JKfl5y/GksCXgMm4V4TTEdfrZIS4ATpdUaz14vJW1yZdomfaLCIy?=
 =?us-ascii?Q?Sq4GZqD1PHch6yd/YIeLlelI4spqlVe9vEs+viyOGHZaxIiVT+Q3p2iJW9Z6?=
 =?us-ascii?Q?A6przNTfiGmiDQdhlNICURtJCns6mwLDN9ttjVw2bjSm9BWBBWTwRRiYb5U9?=
 =?us-ascii?Q?iLDc2D0ev7GCXTJ3MOVRej/lYHKlOSOHeSZ473u96CRtj8bvcvrHgcRVsXg8?=
 =?us-ascii?Q?aXockwuXvbvVZTYOoF3MNxXFaq0nhsX8IGcchgTTvlwQi6gOhvZkKhivdgs8?=
 =?us-ascii?Q?SJpqBSm80a9i5bi32qA9pEzyTkoH+uhR1DVima9/2GjrWmJMyXCoslJ2/nLF?=
 =?us-ascii?Q?SOS+0dHD2t25nz87Q70JmI+WTk34haTRR5Ink2VyF69re3k1ZT+g2Yi0dMic?=
 =?us-ascii?Q?pjB+P59ZdJkfB5YnNZ2HoZFZfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(8676002)(110136005)(26005)(2616005)(316002)(4326008)(107886003)(83380400001)(34020700004)(47076005)(336012)(186003)(508600001)(921005)(82310400004)(426003)(86362001)(40460700001)(7696005)(8936002)(6666004)(36860700001)(356005)(81166007)(5660300002)(70206006)(36756003)(2906002)(70586007)(966005)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:12:16.8250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18251bf2-f92f-4ad1-dfc6-08d9c0b73620
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
new file mode 100644
index 0000000..9dd1476
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -0,0 +1,110 @@
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
+      - const: nvidia,tegra186-gpcdma
+      - items:
+          - const: nvidia,tegra194-gpcdma
+          - const: nvidia,tegra186-gpcdma
+
+  "#dma-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Should contain all of the per-channel DMA interrupts in
+      ascending order with respect to the DMA channel index.
+    minItems: 1
+    maxItems: 31
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
+  dma-coherent: true
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
+    dma-controller@2600000 {
+        compatible = "nvidia,tegra186-gpcdma";
+        reg = <0x2600000 0x210000>;
+        resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+        reset-names = "gpcdma";
+        interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+        #dma-cells = <1>;
+        iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
+        dma-coherent;
+    };
+...
-- 
2.7.4

