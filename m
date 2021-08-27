Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1453F9442
	for <lists+dmaengine@lfdr.de>; Fri, 27 Aug 2021 08:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbhH0GGG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Aug 2021 02:06:06 -0400
Received: from mail-bn1nam07on2064.outbound.protection.outlook.com ([40.107.212.64]:25828
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244234AbhH0GGG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Aug 2021 02:06:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4Aie2WfEXKijRM4z/Yte8eQxmVr28EfEwzqOtKd7GxHV+8HtAjw+n4w6JhsDpHbfiJc4NvQdk7WBaTlM5zgrLmUnAnLAooOYnF9G7pRtf6WFW5kfntUHNxW6VUodtwnFlWHGV5GCWkyemG3iQMjc3MQowEdtWl0FDqIiDLmuJpevzXoxQQ/fnNDx7mT9n5SrS7zC8yqrzYHweHMr3AwxcZ+2IKH+MNtCBORnjxbF/dZvN2kswSQyuxvdraurfJkE6rNOpLvnORpN97J0G5oqoAEPvfBZObe4uZZQtYZVTBL88JT25eV1d7rKbuzcxLBZEVqLAswnsun5NTq06BTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqeaJ3H8tihKlSYopICBGWyeH7CQk1ejVt18JLQegq8=;
 b=fIdwzB0vGvGExB793XK2pcvZ/dGpDkafpvGUoniv2Uf/n7eNn73ahCaG3AfN9TjeXeXRbBnHci2D7VORx/OwpjNviquqdubuzVI7pG9InJ75JjFKdwH4qLvgQzgX3Iu4HPUxjLOXrzw63N08BPeZDIcFXzcVWyEz9iNNeecyn+hSyz2/OX0/9HhPwoEGcd55ij4sku1kuRSBKetCTTr90FaFuvr9vucEfC7NUMiCk5Rr/YMB710xKONTsk8x62hheBbIVaGJJf4w/FTwQ8mZSY7yObkm5eAbQnvDBgHuDJORpBusGvQk/mAWAExe+eMZUglLOYt3rlB0qL1mZ21eWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqeaJ3H8tihKlSYopICBGWyeH7CQk1ejVt18JLQegq8=;
 b=G8jpQAPveKB42fVEyKmH5Oh0NXoX3xzJ2wZXc6DgzGuAKCHqkAGXn3WABhvK9AdEzXzDoUH6xnct9wPJS79KV1b0JyRG5OGC8e7dFL27d4ct3nA+hYyf7/IdUUIaYkteQdzM79F/cZ4PYX5hTtL7vwgO8wCzlo0/R7YgiWdTJ1L0zWECYVd41T+TB5haxXYy+lvy40a/6Zf3jM7rEzP46fn88VPA3OGA+Xfos4kB0RXOZ0jVi82EEhDJOuUIZYZqMMPcUkLG0KkBfIko7wzhkOE1CfzekxA288Ls88nL7zXNsmlk/YKTEXTUq5m5XR5lprpM2sJlxhaEJAxBoojX7w==
Received: from MW4PR03CA0031.namprd03.prod.outlook.com (2603:10b6:303:8e::6)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 06:05:14 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::c) by MW4PR03CA0031.outlook.office365.com
 (2603:10b6:303:8e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Fri, 27 Aug 2021 06:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 06:05:13 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Aug
 2021 06:05:12 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Aug
 2021 06:05:11 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Aug 2021 06:05:08 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <rgumasta@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 0/4] Add Nvidia Tegra GPC-DMA driver
Date:   Fri, 27 Aug 2021 11:34:50 +0530
Message-ID: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
References: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4626aacb-2655-41f7-4f96-08d96920a2db
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
X-Microsoft-Antispam-PRVS: <SN1PR12MB236741A153E00B933226EC4AC0C89@SN1PR12MB2367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wg+miu/j5MaMe0PVWiRi2u0DNfQzl1NE8L/M26b27GB/AountWZZ1a8XPRAlkWoh5+fTYxZPTWs4VkH0n8oJxKXHnsBW0dsT/VhEOol35/nZ4EP5XAgcBwXbsh5HkR3jqKLb4pWAMKzqAjBdkVDefXZdCLkrr0wNIsWhCymNRxWJGoLOab6IitZHmdV0N79JBuN/Onu05qn/Yemx7Nx7ioj+JhdmXIAOTdj1qgXo/sxplmjNaeJ+UOUCTAOMumrcQt8bDadHAWnbCadqeOXqSwyt9dd8acJ7zxKw8+a+mxgefHWXSIT4gq9A3rdQisSzSUz0NYZqhf3yxuwyVj7rNPgcCdFNyl4wf+BbYU+g7XK3mEN4nD+TIGu4rubuLt4TZbKBUz3URb43GC2xMgSav5UB8dDthQI2+O+oi/Tbb2zGAw0Z0TQV2Icnvv6dQQXbyI+pBMhrUMwooE9+00i8Dr+VPYWsmyNBIvIBVy2UTYmTmS2JWxmvH0Q62o5yJ6vgVhRb97dq1sgbeI2IsabJ1YLwsBhG2i0ZOVq4N+k2mMjkySq0bGLrKXtwWo0CITZaCs+LRBdIaihfRn8ULLFs+B8FMCeqCdrDFewMDLbt5aCVtcAiyfrsndXDe8cFf6KinRs86PT9Yea3pvK5GlUYg+VQuMSwKo3iHPmyMTKkvkyQ0gHucDsKrZYHVGrBY/VFyU+rRcL7upU8/y+iFfXmkKb8uKFu3svY4tx2Np3DxyDqBNa11PhOSjJ+R7kV2jMN5h6r5Fr4qEFO3paAsOdixyPnnhgIWbjPe4xtpILTH4Q=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(6666004)(7636003)(7696005)(70586007)(36906005)(966005)(316002)(6862004)(4326008)(508600001)(5660300002)(54906003)(37006003)(8676002)(47076005)(82310400003)(36756003)(70206006)(107886003)(356005)(336012)(426003)(2906002)(8936002)(186003)(86362001)(26005)(4744005)(6636002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 06:05:13.9938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4626aacb-2655-41f7-4f96-08d96920a2db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Nvida Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v3:
	Addressed review comments in patch v2

v2 - https://lkml.org/lkml/2020/8/6/90
v1 - https://lkml.org/lkml/2020/7/20/96

Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra-gpc-dma.yaml         |   99 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   46 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   46 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra-gpc-dma.c                        | 1343 ++++++++++++++++++++
 8 files changed, 1552 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra-gpc-dma.c

-- 
2.7.4

