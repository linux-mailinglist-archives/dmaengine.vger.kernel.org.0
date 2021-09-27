Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA5419894
	for <lists+dmaengine@lfdr.de>; Mon, 27 Sep 2021 18:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhI0QNW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Sep 2021 12:13:22 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:45568
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235373AbhI0QNQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Sep 2021 12:13:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiLz7SJLvz2FE6cfNxnXy8nZP2Rbm/QuHBukLuCuSVakNXT3ru2BjMYyRrHzm7LtWLlb/sKpRuIAOgKwS2bXziPkJrQtZ0NitYTUSRLUwbrJSpuf7/pEoMX3Uqh6lpzhj59MnCnHbdmBxgyNNddUPb+Ai0Hhgi/qWrCqg6o6EcjcL4TkNjiemkwEu07ZiGbkm6n9bycx2hLHdi+oMHPEbBofk5rnfeQXVQq96Jt59MN2MNY6UArzssd9X/aiG2rB9oXzOmVxu1qJ9hTJrF7pt7+Hd070ssdytCSnY/J+Skhm+2LfqAerXr2eycSzYp486zcwSUEr3TUZ6O3/U/OjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XDaTmwh261oOg2FsjRllHSw1iEQPRE51CIEOTmpv9LY=;
 b=cDgw+X6WfKK1JUqvHthLchwRsRBE7LIHPDaqSj0X5vOepK/6SHorJi30rApErvHHI7VkOu16E3Nq2qarReP2LGDoeHzqXWWTFfWMZWZ6IffVoTSzmkFGwZ73lvFCsfBbEeHi9V35z3BSqGIcSCNDd5QZB8YADls/tPH1Ej/bKHaW4ezXKHqnah/eZNjFYaJ9vbabZSevyp1JyZd9dZb38DXVtfo2yPmkuucjFuM8/xietm9aEz8hR7UnPV7y9mc4ccArHvYGln/isKu6l2fgMzI2IXSvz+ASaa3/elWzII7OzPHnJZzadRbsvfx7UgH+jad4NlSytZyBqegrlSsMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDaTmwh261oOg2FsjRllHSw1iEQPRE51CIEOTmpv9LY=;
 b=VmmluLQxdFSSUUb6PQ4njr4osbpySrdnqyxma90GVnBELhIemvsosA9HVxSxNzzd9WFR8JNuFTUfz35xzNfmu2zpZaoh+/oXb1tL1cdEcwLe66EzJHmWO85T3Zpc1uzk4+oAKFXWI1j9uxfY+4py4GxBTzXfVnkLLNaZvRRFgNVb2r5oKdANZVHloe68Gml43YC0Sc27/aRMB7UNL71UPHSUBU97QRRoMqIA2C9hkfjzFwromGk91Ndp+97CwoQ7byi5cNencPqrFoDjFTvVZ0fKRVeXUQG7TEbTx7F6HzOwOOWjYWMlULnteh1sLlByWyxpPGnUI0HIqGvVQVW43g==
Received: from DM5PR22CA0014.namprd22.prod.outlook.com (2603:10b6:3:101::24)
 by CH0PR12MB5234.namprd12.prod.outlook.com (2603:10b6:610:d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 16:11:35 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::4f) by DM5PR22CA0014.outlook.office365.com
 (2603:10b6:3:101::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Mon, 27 Sep 2021 16:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 16:11:35 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 27 Sep
 2021 09:11:34 -0700
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 27 Sep 2021 16:11:31 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v8 0/4] Add Nvidia Tegra GPC-DMA driver
Date:   Mon, 27 Sep 2021 21:41:26 +0530
Message-ID: <1632759090-7965-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e0213b4-ed71-40d3-796c-08d981d17abd
X-MS-TrafficTypeDiagnostic: CH0PR12MB5234:
X-Microsoft-Antispam-PRVS: <CH0PR12MB52348ADE45C2D43F863AF3DBC0A79@CH0PR12MB5234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYSKkGtGxwZYODT0dRcbeSDVVkt2nb+mn3IlCX/z1o8rVl+8UYS70uMzmrT/oc2oyEyPSA7y5Dg6NWnYWyN9WRzqLcLRifWjyr6/iY3T4Va4m4PZG53TYwS2CdQHfmiNUvcgCf2FLiTdFPMQVwWtAEQVsQ+zEsvZGAhuU+Q2oHdZ0CN/gbT0G5Cx9e3tS1uHggb6RQrI4V0iZMYaqXRaoUTg9dhYD3399X0bQ0apCISsquOODe8eVQRMzwOEIG5F9p3+coKTPzjcFU3q8TCTdCDdv2FJACRwbI9sTUsnECsa/QcTHWj+5PVY+MScN4M7UrmZN6wHYFPgdCktvFy7yrpUFAKo2P/L6Ja2QLKNzRO9YTofWOTXglU80GdETP1m88zw/Yqx0W+kHbikn0jNV00T4YqFPwjwQqTvPU5fffbWk0EUJoWjmhGTi6F89hIIECe7KOOplNbeN5VFuwAirCgi+XCr0dx8pcUsmTxSetXa+eV7mq4QumRQ3AueRVLjHRvDPodBm2Lh8sRzJpIu+/p4GFozxtQ0EL/WLMxeU4UET3dUubU9AvzU2qPVnJpQx0aKOy1IT0gu0oLeQeu7jFXfRLpOugAFp2XPzs9SKM2CR8eZEEuUVpk4l+udgx0xk5dHkIex8YfexMSzH25Q9spWvjXSMWNC5ggga+xDB8K5L3nGY3YVOgrzMBhmtDEg/JPglYKHdrdE7RQ2Od2/fnilJu8+3H4KhvtGenIAQD38pgk57s/+N0rblsGMob7UhYx0YWQ6vBTzX4UDl7C2RnItF1xL8GUlcD1U87UQqIYEMuwStXtk4+CrgJ2L31vp3QFfKEoGtSmzSlo6viagsA==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(508600001)(7696005)(83380400001)(70586007)(70206006)(356005)(4326008)(6862004)(86362001)(47076005)(966005)(26005)(7636003)(8676002)(7049001)(8936002)(186003)(336012)(2616005)(2906002)(82310400003)(6666004)(316002)(426003)(36860700001)(36756003)(54906003)(37006003)(6200100001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 16:11:35.5882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0213b4-ed71-40d3-796c-08d981d17abd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5234
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Nvida Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v8:
  * Fixed dt_binding_check errors in binding doc .
  * Updated get_burst_size and dma_tx_status functions.
  * Removed slave_id assigning in tegra_dma_slave_config
  * dt node name changed from dma to dma-controller

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
 drivers/dma/tegra186-gpc-dma.c                     | 1298 ++++++++++++++++++++
 9 files changed, 1516 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

