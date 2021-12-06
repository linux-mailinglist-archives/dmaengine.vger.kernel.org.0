Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB6B469623
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 14:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243646AbhLFNEr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 08:04:47 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:47584
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243408AbhLFNEq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Dec 2021 08:04:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR6TlNMAj0hcSXc2JX3rUzi0aKs7svqfq4YPkisWXu6YUvLO6ADxmYreq4wbuqYESiJjyfhaYtrYRNrPM9O2pOfITeyiv8dnK8WYBvVeFP2Ae3G3YJus9QYyAXX0aTo/CgcFxj7U91hglK2ReTeKS+VPsSOrLNRepIEXdZZCoS8cV/7hKKmizTaiEZZmNf55r4WaGbRqOiqQKSULkGkJSAW4qVkalo73mFpYcxx3pUEV8LQNgQgk24XH9k4FiYNbd0B2St5i/UYjijHP2ckJH9F3JGs3OkFQR6L0EofcZgz5TJjAi1f5FuRt8QdS561T7jwofXQ2nNkEWGH8LndiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30VsQX7u8hLE/xblv3LsGFKi+ewopqo8JRaliIeA9R0=;
 b=WsenBoghCI26/JQJ+a6W16wOaDr6xBn17pR4h5IIjaCc0+h0ddch+kO6G80ouB0OixpcyRYjSGt0Xfep3nKvNjPjEOgUI011DRM4k1p11RzEmf1kiMJMVZz/j/IRKq0l/TQzVtLRV2VgJ9yJ47LORiopEm5WdF0PRgnjNChO/i6rRlXp0f9qTYIMInvomUpYx2wF8zmNbmH1XgfVJ8iZqIh6xbR+taVoVhQAz/0MJSgHAHFWOFLgpOoA1D37/UCF3pwr0NExkIh5u8QUmG5Ar8wv4V8qMlX7MNvJYt4+AIFIDMun1tJq8ByJaAkamKm0qheYaPRSubll8zgo3bVQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30VsQX7u8hLE/xblv3LsGFKi+ewopqo8JRaliIeA9R0=;
 b=IhxtASpUDrX9lDY+3J4kX3J31J37fs2UbpFAw0JGGtNSg9BuNJabP2BFlxPp56OvBO0TI/eUnZ0ynwMprN5pJRaso14/LdFmaXKGe7a551SCFklQXmCs6gZSuqZrCRL6DGPTKWXEZuOSTjxotvrkgROO+vN7jzjHddanRIvP2dp/mgT9dtGnCzR9iRM3pcStGifqGklppxzW1kPyuhHejWZqAQ3UBIbvTzLoRUIyZxoTUPh1FiKfjFtvcDCWkf8PBmz2PPDDWdzgFgX08iR7GGNZvmg8Il50VYcDgrGZQN7jAlrDEQUuRTRM34pfB1O8+4slt2UWIBRLu8GBJ0O7pQ==
Received: from BN9PR03CA0878.namprd03.prod.outlook.com (2603:10b6:408:13c::13)
 by MN2PR12MB3069.namprd12.prod.outlook.com (2603:10b6:208:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 6 Dec
 2021 13:01:15 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::35) by BN9PR03CA0878.outlook.office365.com
 (2603:10b6:408:13c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Mon, 6 Dec 2021 13:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 13:01:14 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 6 Dec
 2021 13:01:05 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 6 Dec 2021 05:01:01 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v14 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Mon, 6 Dec 2021 18:30:36 +0530
Message-ID: <1638795639-3681-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
References: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebf2ae05-9675-47af-8977-08d9b8b87c85
X-MS-TrafficTypeDiagnostic: MN2PR12MB3069:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30693762D123D493F27C8F5DC06D9@MN2PR12MB3069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1rY8t9ClIIN8nW7VwthxefzhAvfruiwSFn1nAtSZxXj5C95IQrVF8jplS67s?=
 =?us-ascii?Q?YkA6zJuPAgZYqrBhsgE5Z8ipbAMY3389DpE/JC0bI1ABV5prPchrOVF+zUuL?=
 =?us-ascii?Q?GDqKLnUofy699A7vwtVbu2LLWvxBfkZJ0AbHrkZBDVU72FlMjfdYvvER539f?=
 =?us-ascii?Q?apVy87QQyD3feDBx+xeETkn0u3/h63UAtSHWivuyZt18NKTPzPz7/sDcIVjn?=
 =?us-ascii?Q?qNTAxUbMGQHf0Q/0fhE7qTqtCIr8AxQ692t4GrYw/27Y5fjZooKiPhNX/M8/?=
 =?us-ascii?Q?rl3CCwjtTi7LrKwDEYWhSjAB+8kHkvntQAMPM/T1Ckg8VNQOBdya1yFJ0jS4?=
 =?us-ascii?Q?KWbOZ7mb1Pb6NNzZkF+ysHwHSRVc6KMI6WmkPuhfukmp1bxzxXMzoRG8b9sk?=
 =?us-ascii?Q?FHnGw1qdTnYJ3pN4WcyDFQ9rni+RfXYKxrUKFTly4tDpvYAev+tb3698n4l2?=
 =?us-ascii?Q?jC/7H/QANuIpt8d6T0G41plTLHYVm8H9ZaUvyg0Rb/hIcIq55pM70QKjlnoQ?=
 =?us-ascii?Q?fcQfESuYlYzI1EMGTAzJj+iSG5eaC1tHFWh2eJju+tOTlN9N0Yg+QL7KFAHL?=
 =?us-ascii?Q?xH0nc+en/EvUe6L7Ut2B113qI4sFV8ZBxq1DTGYmj4qWtvyt6BCycZz0hc6k?=
 =?us-ascii?Q?+fdc0flMhaZuRfky7uUl0hSgeBw3Hk/6cBXoRwHhoa0jwYPcXYgXUTR7K9zj?=
 =?us-ascii?Q?xbtIwO/d7vAQ2cbpZsztxldaZGBTpXbmpvy83uM16l5Tt09//h9/Xvm/XCc/?=
 =?us-ascii?Q?Y7eqlc6kHIauXV99SgfXZGJ7Zwj6IwA//mNBQXrI8XzPTy9G6uueo6KsiwKq?=
 =?us-ascii?Q?K1fLD6+esOlDDSmA2J+bixhwZVaXlZcwDPkf3tyYN/VSz5tLgJ/5z/toeNoT?=
 =?us-ascii?Q?6C2NgzO4b+1cLcGtxAsVdCGI/pKMXN//eONV4EjOM6ghPsiMvFnI/+IUojKC?=
 =?us-ascii?Q?KiD2WAvLFRpOZ6TU+xGBrQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(6666004)(107886003)(110136005)(316002)(82310400004)(83380400001)(36860700001)(26005)(336012)(186003)(36756003)(921005)(86362001)(7696005)(356005)(40460700001)(2906002)(7636003)(426003)(2616005)(5660300002)(8676002)(70586007)(4326008)(70206006)(508600001)(8936002)(47076005)(966005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 13:01:14.9911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf2ae05-9675-47af-8977-08d9b8b87c85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
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

