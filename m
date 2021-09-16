Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8942A40D9AE
	for <lists+dmaengine@lfdr.de>; Thu, 16 Sep 2021 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbhIPMUV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Sep 2021 08:20:21 -0400
Received: from mail-sn1anam02on2049.outbound.protection.outlook.com ([40.107.96.49]:21369
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239198AbhIPMUT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Sep 2021 08:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idfxtyuD0x/BI48pPoBFtgx14PXgV4/YjGDUxspuQJPNdfwsiEro+XD2jNHwxHnsXutv9HPruLcYd1b/R2R88uWOg7nVW6g8+udPwo/hiI7CV186bApy73IqB86URJtEkXiiyHRSnD3tIVZpjJkFvFM3Kq6jOJqYeZ9aliGwa/Ac/JItaFUJNnlbEnKXVKlrSw4+TBSLy2WFKLCgFN7Icyx8GpbW8QeeyANBsJYlDKY09gAcPO6eLIMJVmqpNcMALIoM4WtV4FaKFfxMYMbhgi/rEQ9nGyYU612lLPPmsYEhD9FfyTA7d2qWsHtd3UhLcTfQySjD0r7bIv/JJwT/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JYL0w5uQ/FWFI0ZGgh3PohyAMKs+B29SGApw4fswqn4=;
 b=Zg6P4BgfOrcGG6u9X/p2LgyYoRAG855nai7no3xwuxyJuYwLCOyk0qV35gOAUch1umCjElkGIx040paoo5MtdWYwv/B1PtQYSLMJVgRU7aN1j4y2kZtLX2/u+wFDncLvATO2rqG2XwYfne0jgvJ9KkPL+Xals9HmrHtpzTuMDNZ6uZe59KGd8ppXdNiCWIxQDAZpeE3yae2K10ECGIsK0yJF5k6vvI4GMWMGkPlyIOoiPc0xRPy3jHIxYYsOG2jFfuqewOldISqYB8BiFqd1xpSrCeWd7lXtzCsALHnr9kjARPV1g+Q1Y+JxRsPPdFMA2j2bvql5uV5+pRAeyv/bkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYL0w5uQ/FWFI0ZGgh3PohyAMKs+B29SGApw4fswqn4=;
 b=WwvVBpB50alkIhjtmXFv86ygbiMyZqVmVjQF9E7+9NOZUmC2X6HkaAwKKvLsKxSL3BbfzRHyQziSRSk2VOcjZ2XakOempYuvG7d6obg/IIYEP/rqjUBq4ahR7flmBYcK7Whd84n7VNXpq/5PviL+OKx1Up6zEbfVssAKGyb4kUtllpDEgJp9uLPr8R7j411VJ/rQkUufFIH41+x9CxmdqrDnRiBMNwe/5tFRfDeWgAxlOUnRlCud2WI9LZY+isTpFUgKSPjqWkPQR/ld7gLXmGG5Hf6OxdNEXs7ojzcVKP/y3Oqj8iB4TyEjYWX2uAp2AZ3s4LvQPvFKb22iWgOmQw==
Received: from MW4PR04CA0072.namprd04.prod.outlook.com (2603:10b6:303:6b::17)
 by DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 16 Sep
 2021 12:18:57 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::1e) by MW4PR04CA0072.outlook.office365.com
 (2603:10b6:303:6b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 12:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 12:18:57 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 12:18:57 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 16 Sep 2021 12:18:53 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v5 0/4] Add Nvidia Tegra GPC-DMA driver
Date:   Thu, 16 Sep 2021 17:48:47 +0530
Message-ID: <1631794731-15226-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
References: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c09acbbb-221b-4ba8-3abf-08d9790c2889
X-MS-TrafficTypeDiagnostic: DM4PR12MB5104:
X-Microsoft-Antispam-PRVS: <DM4PR12MB510427FF77165A233401785CC0DC9@DM4PR12MB5104.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvI3MsojuYblxIB1ZpBsqVNIrc5B60S6pkmfc50NZW1KPndWolIyyM02jWbJyVbOkqgpSsdbmimo1L7ljSuoO2NjTbG6DzrHA+xL8qkyWpG3J897ncGAsXdmZFGmJugUctaQl3HPj7pNAtV+QmdpOmgpKYAT5Qpg4FsEjlKU+f9I62RwzGXIIXlaUefhBMeT7Dmv74VNBkOHZtjvHbFgdoc4fKcH3gkq/dKDVaSfqzTUudAvQMMlcBg0sF9Qv1duZpJYGAi2uKVANnarArlnoW5xK4R1LTjJhPWqoqmP8VZltIZ+buTbNMlD+m+ZyzTZ+VWKbBcXpzXI6QbJ/aC5UZyZpVss+WGOCVkDQ9uYmv9GINVJ0iy29IBAdyMpjAIMG4bPaagMDeHxZv+xJq/P0HkWtA8cxoLTjTHI+FB/VfKMHB6/zIav3BUgqQZ7TBMpSKyRthyg9iHSR4EaDtAycse61wR8ccsLw4SmmH9Oiarg5e/5XxBGZQqI+PNn6RJscZ07an1gweLvk42OjuQkGlnXIVbA0TXS3hMRNyd1Fr3f280wzFmOFw0hc/FA1EA8eUqoOeP879nnPZrQoelPrxoSMizwisx960E0hS4pQaxumlsjYQUVd4mHp3tYpuRoDVJpd5IO0XguKCqmEZAtzXtzMRKJH/aQ2eErifgAH5sUQXDgRmOhCFAmv2WkNQnJ7jyGeGAUugfBYxx2sTTk+TTvBgngaJQ7Yx6frs1x8F4BV6CeFEn14FF5ZNSZVHHdTPaJrQcTwPAuhOhrVx3PCzofkRtwkJ1xRw4EuiVtlevC2jvyKHBDRfKAEp9sqzEMVmlxFH0Nyp8GLJMhkuSVIg==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7636003)(966005)(36906005)(6200100001)(37006003)(508600001)(2906002)(316002)(426003)(54906003)(70586007)(36756003)(7049001)(8936002)(4326008)(26005)(186003)(6862004)(8676002)(7696005)(47076005)(70206006)(5660300002)(2616005)(6666004)(82310400003)(336012)(356005)(86362001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 12:18:57.5097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c09acbbb-221b-4ba8-3abf-08d9790c2889
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5104
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Nvida Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v5:
	* Corrections/indentation in nvidia,tegra186-gpc-dma.yaml
	* Enabled gpcdma in dts for tegra194

v4 - https://lkml.org/lkml/2021/9/8/513
v3 - https://lkml.org/lkml/2021/8/27/34
v2 - https://lkml.org/lkml/2020/8/6/90
v1 - https://lkml.org/lkml/2020/7/20/96

Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  107 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   44 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   44 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra186-gpc-dma.c                     | 1371 ++++++++++++++++++++
 9 files changed, 1588 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

