Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6854A30B0
	for <lists+dmaengine@lfdr.de>; Sat, 29 Jan 2022 17:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352156AbiA2Qlx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Jan 2022 11:41:53 -0500
Received: from mail-sn1anam02on2063.outbound.protection.outlook.com ([40.107.96.63]:64276
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243121AbiA2Qlx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 29 Jan 2022 11:41:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMBElDRhrFiyYFLohlXrgdHGuQo8W9dqR2lWO8+HkFTPgk76zmyLrKmHztGSshGpuRceqMgy6lhJJ8zqwa8oqcKX4tzLKnP0PKxgr7Y9TnphF64JiAewB/DvE6/cUO8jV87lh7lsWJLIPmICmMUeAxb+XrHf95xsDwrAjhqEaCjQrDgJXDhwNLahwhQMpGTNpPf4lri0gR0JXqclI9et7a0K904H50NF06FkGWykbfcyDevB4pR20sXjmZKRIWOaVyjyHryvsaFd3xLHimiGc6kfvB3x2sog5rh4ZmFmBh7UxRSbj+KkGUSqmAv6dcQdjm/hWxlxRkvPBgx4shCyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYDtTPlxXooczPT/6qlNnN1W5DBM7LDqxAdcyrEMGb4=;
 b=gyQemlFpfaThOXvIFQngDPSnmRxQtT0KEdoMyNWbKqVmTAcYQmjpJbB6Ea/Ce4jLwlmFog5qiIZnS5qxeQA0qL1k56M18XkpHPsuYi3XGB1d5H5WYtYEBe1xP7GymfbN+w+BiLAqpBnhkCd7wyDw1+pMKMKbP2lQlj4Zvm9TYCUWJdfXjLx7LZv2wQwbFZH5/CyQiCW5ogDAmHFao+R5IHVVmcNCQ/KPQwo1NmPWpTzP2we4okfAgUjiQODhkdwnPRC6oBxXrnudHn477CIRmsdrFP1ja6iW0Z1fI1ZvWExEsXZYC0QqHZ11nbxcIxUBEwL8RbH5a2z/Kuf4R8txIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYDtTPlxXooczPT/6qlNnN1W5DBM7LDqxAdcyrEMGb4=;
 b=SAo8a6ePv5LzDLAPQL+W7zLoYf8x/Y+JxQBW2mHjx73lqKcm3ifo3nJW24Binba+x3xRyW8wupj9q6GfwuIWAdmJ5m4HrGmooHsEzsc4zxkshAteTj/sAqiOb3F8pEj+lhamKppStVUaIJnQPUEgT7EceseLwObfWidj4vooI0eNgrXB9rV2ndL4QLphk+LafAQFfj4rSOAhPkMrdLXxAJKL7DklsWQjbynMIBpyLPnr8BU43RkPFZoIvZtZZ0X52cXYBtBb3Odv0NZw/SQPE8KYL+LcelGcg1XkA83J/ToOd5LEKLKH1w/ua4yw8lfpK/OhaVJOXQMTCXi1nYuSzw==
Received: from BN9PR03CA0160.namprd03.prod.outlook.com (2603:10b6:408:f4::15)
 by DM5PR1201MB0076.namprd12.prod.outlook.com (2603:10b6:4:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sat, 29 Jan
 2022 16:41:50 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::8a) by BN9PR03CA0160.outlook.office365.com
 (2603:10b6:408:f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Sat, 29 Jan 2022 16:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Sat, 29 Jan 2022 16:41:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Sat, 29 Jan 2022 16:41:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Sat, 29 Jan 2022 08:41:47 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sat, 29 Jan 2022 08:41:43 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v17 0/4] Add NVIDIA Tegra GPC-DMA driver
Date:   Sat, 29 Jan 2022 22:10:49 +0530
Message-ID: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6663132-31b2-4803-308f-08d9e3463f03
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0076:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB007616D4E0F7843FDE524B49C0239@DM5PR1201MB0076.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U02Hv8NFFM4fTJqgJiI0m6aFqvhmy+y6dPeUCuAAXoo0xrBWpUeMOKdiLunI9P8MNRvJCzLSZ/Mw/coV4tOUNJNysjgWxAbk4oQ9FVuUYeLF2WafLLEqcnE+vmTiAMaeBteIybSOBR/jjXDuBg8wJ83fkTMgc3qc0zQJhpKoy35ue4jzse87YbYE0HxDbLi4SCduNGP7NGncV1TEs1jFMNXrqf13spib+URoUWTaV6STeQygtqBfwAxaypMSkT4OMjwc21fJL719lEPGARVmW/6WICPrcUH1FxWPftQblL2wPHNi9M42fdZIRuepvUUZBBy04OmiJ3/TxaQ0qNHi+wIcJ4BPjSgCYtej19Tiq7UyHpoV5FRGxzEkw83NxUzDdbUuhtiibiAni6VSUSI7SftiRUMyrgb8EPiA16Z9zng7uynaIY+dQ8oIx6dfJcpSapn7CTLwI3TNVBVl5JzZJY0keO3BQkRh0gI5Usm0Q9N5aisae0DRYJX4XItp5Omq5PxuzXJjY5GhTNEy5DD+YUhRZTLE9f8Gh9ynvONX8bwOPgbvBnP+jgWH62/fWy2NGmLZNDseByeTgvc5AkTDVt2oxVCWOfGItr/gfe0v9rCYOgVJY6zL1hREpl6yK309KiIOIOna0KhM0D0JvaW41YSLhi+zQ+iFwZDsNlHqyqhWIx01tPHsAoAAYZHclJa7dKK38ROr8JP+38IuW66ylCv0lIPJwx5GCgddpXbaLu5WV8Odgh8KMCSkN68STajgO7uhlaJ+e1iPlJDcnuHKFQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(107886003)(70206006)(8936002)(110136005)(82310400004)(316002)(7696005)(83380400001)(70586007)(186003)(26005)(4326008)(8676002)(921005)(86362001)(356005)(81166007)(40460700003)(2616005)(2906002)(508600001)(36756003)(47076005)(426003)(336012)(36860700001)(5660300002)(36900700001)(2101003)(83996005)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 16:41:49.2306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6663132-31b2-4803-308f-08d9e3463f03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0076
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for NVIDIA Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

v16 -> v17:
  * Updates in terminate_all() and pause().
  * Moved DMA busy check to configure_next_sg() from issue_pending()
  * shortened variable names -
    bytes_requested -> bytes_req; bytes_transferred -> bytes_xfer
  * Correction in burst_size calculation

Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  110 ++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   42 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   43 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   11 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra186-gpc-dma.c                     | 1488 ++++++++++++++++++++
 7 files changed, 1696 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

