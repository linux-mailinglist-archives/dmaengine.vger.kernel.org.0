Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5111C43E220
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhJ1N3n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 09:29:43 -0400
Received: from mail-co1nam11on2067.outbound.protection.outlook.com ([40.107.220.67]:15328
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230383AbhJ1N3i (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 Oct 2021 09:29:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeWOgXHbkxzvW8FKTrOBR0OEB/Xjm93mbaRiLlrknraiu+YTTryJgMar0A0xLk11pVrQy2NV3GouCUKl+2cBKARFvCvBUy53LeIO0NUqlEm7iwYSbP2cUpezmMAF+6abY3+bGYl7fOP0XRjM48LvvEwsuWZ3EsyoKG8rRt7l1NWeRILHk6O/szpFlIj1QiEwzwuV+d1d/wxz9yv0oVG7A+IMSlb4NgUK1y6kDnUNEu83VvmJLS363ZTIGfDYJBZeJh57yBslf5xLUK5RW1cZma6pFcEJcUsAcr0QI/co3geG5MxJfg+SplE+L/B6UXzUV984Sof78+O+haGFPaH/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld02bGS47am7hRTHoyU5isg2Dj2FUaXSMARkf6DHsgI=;
 b=NXmb8Y6PEfB5OGOn3G1smmuTlKNsMQZegphMv7gCcj8sa/+xXmbCCj/wZXTCtcFeVU0ZkSw4ZJRgsbkUeLe+wgK0LLA/XwUqxIhBq3AMG9tBPIJYt9EEG9BrJMrCK++Fud0ZL0CwyOeo7Io2doM3rblz35pv2rHcOPB07DHAmIGWr+jt/vawJCC1EU/Hlwog9i+L3tHSrN6Be9cuQlRCHh8kR9VLwZZPdALy/SXPITtnN6Aa0+4JRNZnJHs5jz14+pWVA66HuL8f3EqKB6BUqEmGRhHFM21miB/iBT0D5cETU9CNdg0qgx0a5ltQxbKvl4oqAWfCNBcSjMopRIXh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld02bGS47am7hRTHoyU5isg2Dj2FUaXSMARkf6DHsgI=;
 b=axnCedG/zIeYGfZxFM9fmqNY2ffg7NgJdWKFvZFPgdfn17+UCVGaXTP4GqZXIFCPEkCaylGpJU2g+na61vgKdtLPEvixamfzz6+KG4CF4H77JbpLqSIvj22s8B36Daf6F0gr5VOpuhXO25aAcEYmU5pH2tSpfW/AHLVXN3EIDp8NOA00Bjgxu3z85SQ0z91X7+5JX1uqXnAwWKb+2WUGypfi8HjhbkAji8g5kEC75BN7galePB6OsjCJQf3X1Hgi6sv9gWUMecDstY7+8YYzOl8MB956F6xgmooA2U35osUI4sdpr4Sd+cQePorvXrk5Uts0j0fY+tZCobt7WIQtsg==
Received: from DM6PR06CA0035.namprd06.prod.outlook.com (2603:10b6:5:120::48)
 by DM6PR12MB3675.namprd12.prod.outlook.com (2603:10b6:5:14a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 28 Oct
 2021 13:27:10 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::68) by DM6PR06CA0035.outlook.office365.com
 (2603:10b6:5:120::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 13:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 13:27:09 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 28 Oct
 2021 13:27:09 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 28 Oct 2021 13:27:05 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>, Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v11 0/4] Add NVIDIA Tegra GPC-DMA driver
Date:   Thu, 28 Oct 2021 18:53:35 +0530
Message-ID: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79e01514-9741-45db-86e2-08d99a16a512
X-MS-TrafficTypeDiagnostic: DM6PR12MB3675:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3675B22BAF9D2C6288FC4B52C0869@DM6PR12MB3675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOZukUIhnfVHyF99YwR2DqkzI1SqOrJZuaR9OWrySCL5kblRV3kmJsEJ1xVTjv0r9t9AywxkK8s1GsiPTDn9FntYFWediwUNTLA5jfKwG24cVTtXXMa8qT1VTwQqeI51cxRqFvxelYoY+PLsZk8LxPZyanlYEf1ilDHcLX8Hpxg53g2QXrD/LLpuXTF3hMu8YQveYjlWVjzPlrrGkMUHUqEfgMfN+7fYiKRDg0/KG8Sz0TCDsA4D1ZNtun5egxD+TO7NiB5/GR+OGq5jPu86j4ofRL6+JIuMnDyv8RxPw6nRoDrjaVGwgN0iVB/J4s7OR/XCGFDbuN5T2GKcspcMeKsv+NE57SnD/xxeFtU6VaPKDlHpJTO2ZyUI1XiQpOg7NIH2G7iGc2LhlDO7BaT7So5uiGTOj06DWv7vDkjbyA590D4qMSjIh6HM78kHH66VSb9E0BNxF8xka82FX7baZq2G1+ddDXYeyAKoixloxGRIKpKe/rFX+MJcicq+1Hvo4hbU6vAClUa/JQhWbtWdP8PjxZmecxEqhFGvz22RYey8jhlo1zU4OsHhQyGdZgByDpTV3K+k21YzghLSEboj5MVULANwRPBK3StK2mOCGNXSbj3L9/4AoX/lYTQ6fFlRX1GWbvmTfKSPBUUFlrM8tryXXGpkabWzPZnvp9KV8nRh0oV/9j4Ben6VXFjSBqJZWYhJQrDugm/NrV2DdzCaMhFqYnIxaWksA9gOpEW9hqxacHW3QedqlsgfI8cdL0Uf2KjlY0LCXA04b/aVND9pwy+W6mhfcFkZ388TCm8dlSCGk42iYPX7kOgkEqGiHyWd
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(83380400001)(426003)(47076005)(70586007)(70206006)(508600001)(6666004)(36756003)(316002)(2906002)(7636003)(107886003)(356005)(4326008)(186003)(36906005)(336012)(8936002)(86362001)(8676002)(54906003)(109986005)(7696005)(26005)(966005)(36860700001)(82310400003)(5660300002)(2616005)(266003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 13:27:09.7829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e01514-9741-45db-86e2-08d99a16a512
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3675
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for NVIDIA Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v11:
  * Removed unused label. Added description in doc
  * Fixed dt_binding_check warnings.

v10 - https://lkml.org/lkml/2021/10/25/854

Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  115 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   44 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   44 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra186-gpc-dma.c                     | 1279 ++++++++++++++++++++
 9 files changed, 1504 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

