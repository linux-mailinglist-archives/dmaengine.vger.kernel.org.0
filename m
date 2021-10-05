Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2A2422729
	for <lists+dmaengine@lfdr.de>; Tue,  5 Oct 2021 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhJEM5l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Oct 2021 08:57:41 -0400
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com ([40.107.244.59]:5047
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233762AbhJEM5k (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Oct 2021 08:57:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZcGF747XkG6+F6nqX4EIhS2jIySwdCufYjmG/YybUULtl4L0lIqMAebcKujlgHz9wJQw2ga6i4qW4CXbH3/d/Y2axtM0gKYaq5wi2yV6wlTTKGNuiv0CuSPpV15A9oITOfLgUhE9rm7191BZ7JruGkedYE0PUJMsu4Zr3jMg5345djAiAzZIiH1gfkyPKqm1GWeQrwWeJB4R51eAqhbrva7Jk5OpP7tOi+5dKg88mR3L/lzz/v1q4PpMR3SMbuiviVErjrWveXy3P6Upz6F/uBrNbMwtIiAI3fQH9JirmTnWtKrQtBPR8ybj5XC3TBGwOv0WOdnkwnM+iRVSwfduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX4fBdbNIDzO7dhe9uMRmacG/IbbqXQhfOtINp1k+jg=;
 b=cDmODM9BdOd3lreI+N66w1NVuBb0epTaPzQY1KbCE0HXIEawMenbD2lb0PfIW/Y0zBwvXqJRxUjWNzspZrgEV9l5lNFoV5fp9zUrQ9Tj1MzlUWUExaDGFqxVEmUNHVohnLFloFki/OHEiNQ4WArHQWqhTijVHmlykR8zyMbebCfuOVC0pyevOAP6trHS3NntL9d5ucNP82IH0gGwO/JI2j1uiNNQuynesneE5E4fSfJ6kjqZokwNNfmkZXcfXh4oQyE5wVDoKUR2V/bsdnzRnakKevoyWFNONAMGVFtLu8waVqRpIQ/mXR0NQa4P8B1Fo//tPmfaPBWSdTXJENcwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX4fBdbNIDzO7dhe9uMRmacG/IbbqXQhfOtINp1k+jg=;
 b=mqHc9VWFFopZj5eSK9PjZZs7wFrggUac7oNDYjgBmRwLoGCfzHEXvb/dgS8eRnsulF/A5Q5yE+0/9G61/kD7pcU2cVEGyP5OwYLFKQCbsMnXb2MnOMj7JiFeoyX2oLU0bbwVmyAgq4OGsxTdDo063FsecpLESIUouAOMiBf7I9Qo+LGGE21WNh0v4+t7wZmiR4Ml40hsYO07Ol87KYVGOAPHIKYdgSHWJvWRTVHTOmqhIkFc/7vNzxZfznqp4YX1rjIlCT2Nd1hxcVvnWXPKRfsu+2mLmEFRddENhzjDVXAlRJb0UytLmQIN9HIlW1Kci5H5a+27AQ4b9b0R4xjVdw==
Received: from BN9PR03CA0439.namprd03.prod.outlook.com (2603:10b6:408:113::24)
 by DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Tue, 5 Oct
 2021 12:55:48 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::54) by BN9PR03CA0439.outlook.office365.com
 (2603:10b6:408:113::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Tue, 5 Oct 2021 12:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 12:55:46 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 12:55:46 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 12:55:45 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 5 Oct 2021 12:55:41 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <jonathanh@nvidia.com>
CC:     <akhilrajeev@nvidia.com>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v9 0/4] Add NVIDIA Tegra GPC-DMA driver
Date:   Tue, 5 Oct 2021 18:25:32 +0530
Message-ID: <1633438536-11399-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e361395e-e1a7-474f-2879-08d987ff7351
X-MS-TrafficTypeDiagnostic: DM6PR12MB4514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4514336FA47892737B80DE79C0AF9@DM6PR12MB4514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCHlvET/3Y4+k//iEfZUG1NMxlifWvwy4uYnezjq2RIEOiI+judCT9XSQXsG5TN30Xszynf6YeT2KAF/MBos013CMfFAPlTQE+gq9rTMNgRmcGa7/tWTsZWgFDT6yEWXrXW0hN3Q9PdnnF6WLYp7SlgOaKstn9WClOu1qZAXj9p9ipkLubfnC3G+Xs+XN9niJRSfWMui4EAsfImjOmdkoQ2YK5yTdNXJ5hxZGdX9ETpSVmnnKWqr1diGNClgWSjs2AEjg+GclrbFOlYumsLeDkkxfzE+IEsWqiNSpgaMkQY7O5GUwaD9RX42OZBjac+BfA5ZFpCNnCp4qAH5TmtZUhRXkZ5b9MyKqg6anE4YyVJpjVcZ8gEMHgs0sjz2SKX96Ym1mw3rIv005Hv7MYi2VPXkWgVu/ehhZNRsma0nno5sVfJDxYcxDiDhFZPHU0YuM+SET4U/Kdjps8lzStXGm+/T23w3ujaFBnqA8+byLrofIwkLV7C35K3gD5CDt65+m8cEzPK1tf84KyCHysj5sE+735TBZXzyUR/zOEBIXWJv+42A0R4YkSNBeXSkhzFROhwGxGSmHteICSuB5K1RObf4t/Il2mj8udpYjUDtg0b1rWlxKXl4lg3zfHMScFnF4xUIc5L5dW7wTurYiASs+QzYsR2rVKHiTtDl60YHCavmT2DflSyrSm54yiQJ2Dy4YCNiNByQUV5+UGGRl9MtdyH49PUX5Abdw/YqL4x5BTLlv7sTE9xkhSELVYZGZZkSDbWRg47A5r9O+wAh4Yy7GSUWLtElzK41FoNYZ6JgFOyBk+99g/TNEWmdqS3NURfyMFdqYssKnFpRqnG+3uZZGw==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(82310400003)(5660300002)(356005)(8676002)(2906002)(7636003)(8936002)(36860700001)(37006003)(70586007)(6862004)(70206006)(86362001)(6666004)(6636002)(186003)(7696005)(316002)(426003)(54906003)(966005)(26005)(36756003)(2616005)(47076005)(336012)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 12:55:46.9075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e361395e-e1a7-474f-2879-08d987ff7351
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for NVIDIA Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v9:
  * Indentation corrections
  * removed redundant check for tdc->dma_desc in tegra_dma_terminate_all

v8 - https://lkml.org/lkml/2021/9/27/668
v6..v7 - https://lkml.org/lkml/2021/9/17/652
v2..v5 - https://lkml.org/lkml/2021/9/16/455
v1 - https://lkml.org/lkml/2020/7/20/96

Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  108 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   44 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   44 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra186-gpc-dma.c                     | 1297 ++++++++++++++++++++
 9 files changed, 1515 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

