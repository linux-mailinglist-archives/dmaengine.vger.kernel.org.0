Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B356B40F9FB
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 16:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhIQONX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 10:13:23 -0400
Received: from mail-dm6nam08on2060.outbound.protection.outlook.com ([40.107.102.60]:8524
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230105AbhIQONW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 10:13:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3Mr0meL/VmAJJfWJR6+k6clsmubuz0PBZj+0DniLBYTiSE/vu3UDasE+FbjKLrDff8yZL/kFrs6AGw0kjkJOeY6JXbBDJ3J1fH1gie31AlJ4VytK8vA2goo0zfPBFLkTj5HKPVfb2a4gC/xeCFKwgD6Mzdh6vT4iP2GxJGP3qgqXne/D13gojfvMAJVllMkHUGU38VCHsNVWv65FC9/Fds+w3bpY+5xHfcPdQNqEPQWyhUjfT+y05BU6l79Ghj50zMm/wmdZb+WYRbajDwx4A8huIOvEzFsqh58pLF60Pf2AOwlNACKHLb4DqkRKoXgGELSw4zs5Wg04e5wjLpoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yniD7B76sw7VbaHWn+kab7LIEhJQcyiv2x4aoG5wA8A=;
 b=AoL5w+nmaNBuZ3YcMdI1/WpTyddDN5+iNpCegw3Q5CpwLxYmGy/Z5Dy/YqGfmpJGKRHr8q285NZqaUDTolqiV+C2bLFyV+zw86+E3TiTCUypcULU+xnqboWRN2x0lNtZKRciyYzLvxrUfnQftS41+7s6QSEs0OAK3tYh6Cl6RJDUc222pTGJ/1R0vJ1aqu3rjyw+BvTbC8j2tfaVZmef3sEWr4fnoz46m4vO6O8VbdIkNp72BEgmdFCcPNv0I9NpTfTUB0NwW3qGTkVkkYNmj7bo2JSxe7dfYs7rk81A54t1Oehfaa45rmlszhordtfh9AKrDwb332DQHF9K8o9tiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yniD7B76sw7VbaHWn+kab7LIEhJQcyiv2x4aoG5wA8A=;
 b=oWEXok9wTxInMNrJiVsctYU3EQ8X6sxOlJII3NBtNV7RSKC1G7F2lqX4asBaxTOg9FIguQliLybIHFOhcZxNkI2E4jMOSM0P6JThdCJK44Lxlnkqm4wgiySna6LL/2lw+EZBjQ/iZvyIZZPSTpAj3gfRl9wNk86SAMed2rOa1qilVf1R/b9xlCLASAiIRa7J98p84SSvCAkcTcp0Vmi2GA+4JwFefmmq7GgLOB9sFOrWUKv7fTm/ZuwF3RDTxRGhMEB8KscyXat0YLhF+8M2Ekpc9IT3Yohy6AZWLngUUzQJCSGVt2Oyjilf+lPleHy4WCJR/WP9UQLBrbma2Q5qfA==
Received: from BN6PR11CA0003.namprd11.prod.outlook.com (2603:10b6:405:2::13)
 by BY5PR12MB4833.namprd12.prod.outlook.com (2603:10b6:a03:1f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 14:11:56 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::15) by BN6PR11CA0003.outlook.office365.com
 (2603:10b6:405:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 14:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 14:11:56 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 14:11:55 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Sep 2021 07:11:52 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v6 0/4] Add Nvidia Tegra GPC-DMA driver
Date:   Fri, 17 Sep 2021 19:41:23 +0530
Message-ID: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37ae21b2-1fff-4691-4558-08d979e51b8f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4833:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4833B1D066475F7CB03605D1C0DD9@BY5PR12MB4833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBBssBWg2Mj6ONG4cqvLKbH26EtNTaBoKBT/tQo5L2czntWxMVFRaJ7TFoWoHLINqBHOi9s03ubn9jxJZwSk33aEkODJHtKCdKyvFNMkF0mws9k96gJUJ4TeV8ogWTuUbqTAb+SBU43xYEG9Stw+8zXtUSnJWR9Kj8Cnu63JhYjuTBTzn4n9oVxAL8SNmUTLx6n7Pz+C0Tdx6IQ9CzYNL5iriyO/k7HP1Pm1d5iTLhNA45D4CFaoNKAo4a1h2n9vUaZXUJ9Rz6JAFeCaMcU4/Fo6CmlbTOK1oGGpCp6U/8pnpKfbsXtKUyK+HTGT//Pd2d1CzxDGXo0g5yCgr5mOWMXCf1+YA/f7oloCC4OLsebVSePKVMsHPa63nxXZaVEpCLGbnkVSB7BUhKw+dxc+JaxNWxs1RLCQiPNWJlDOJxxQRswLDVCO+qK+t/rcUe+Sw3kP4rd354NaGKsAJD/bf5ILvxg7cEHC/e+6DIpHydz87QaTfj1oEofXTs3wCkkLN81du2jH3HCzPUCYqrUKt8lTKdDb6Zvs7JXVf5ZcPziwJl94D2fy1dAQxJy+mklNhz1hi1kaqm378zQhJ/e48gKm/Ig+SLuEqYNUhCBoyyZ5ZWSahyKZBd1b1aqTicsDAAqJxUtk9Z2lEQ873IFAmz0B82WvMKotGwHmkULkOJ5enXW/nP7pO9T9r7ie+ZBxXGAmSXyisJ0dVFg3LsgQo3HV7QEXJ+goemXEVnwCusXR2pSE7mxgrcA58yIp3f6NEVTiqOpCvNhR6CqkkqTnp2frxTmwvEA9snpTSQjiv5bpiz8Uii53/Mkzqh0mieapgfmkWsmPxUbiM+mpbB1dsw==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(2906002)(6666004)(186003)(82740400003)(4326008)(5660300002)(36756003)(426003)(7696005)(70206006)(2616005)(26005)(7049001)(70586007)(82310400003)(8936002)(336012)(86362001)(36906005)(37006003)(36860700001)(478600001)(356005)(47076005)(6200100001)(6862004)(966005)(7636003)(316002)(54906003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 14:11:56.4782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ae21b2-1fff-4691-4558-08d979e51b8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4833
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Nvida Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v6:
	* Removed stream-id from DT. Get stream_id in driver using iommu api
	* Corrections/indentation in nvidia,tegra186-gpc-dma.yaml and dtsi

v5 - https://lkml.org/lkml/2021/9/16/455
v4 - https://lkml.org/lkml/2021/9/8/513
v3 - https://lkml.org/lkml/2021/8/27/34
v2 - https://lkml.org/lkml/2020/8/6/90
v1 - https://lkml.org/lkml/2020/7/20/96

Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |   98 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   44 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   44 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra186-gpc-dma.c                     | 1375 ++++++++++++++++++++
 9 files changed, 1583 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

