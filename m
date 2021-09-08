Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6F4403B99
	for <lists+dmaengine@lfdr.de>; Wed,  8 Sep 2021 16:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351914AbhIHOdj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Sep 2021 10:33:39 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:38127
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233240AbhIHOdj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Sep 2021 10:33:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnGb80stGvwr32utOWH2U+xOawWZhJMsUaxan1XaQG9kD8X6hip8jGx8xy3+2/1r1/41Gv0/IZQn8ZoAgIoMU73a39Rw1XTbRnMQ6Tp+HtCBCEMeboHn/WvpC8bUo7ltV9m+N0R/b89UMd4QpJssufo+phbCHQZNiYq52QZ9SFASpGvNdhtFGP3uTVVC6P3vlkuaL1m232l/v8rcvXNLjoJ2RhpLoGYf5cI+JNbHsvpqH+1MoTJnZ9Ab3SMw7zmIc1CxvRMbIqTC9h5wKqd569vCKnJlWQXE33oGUDZAGyB8ff/DNJZHY9iWATrXHy09u7CvvbNBsQJDRlu2jqD8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5kvvEF9P8HK7a4F7xP3WuuCibIbWVoquV7Up/qipgCE=;
 b=GrNyPIoXUbPm7EaiI/0uAu8oENdd47nsmCHN74qEanHlQtGhvec2ZbMy+CCoB6X8x4wbOQva30wgVLTmVhDoQf2Bi7ISlLpLVqB3vWhYaMDwJArYhN7NOsj/Kti0S11mz1VnnaDNxXFrWw8UtLiH3r3Ip9fp+h6tF5f/q0N/Us8nG3xiWbLEue8HAEMNFThMTF2CVtygDsjsD58ssso3X/ue88cNY6biqPNlJEa5Bgn6VupP+3Rs2bJRFD6TSwo2cVI5w6Qh43FV47+jVtInrR/UkoORM51MIGI1jrhmwfSH9z1ovphLo5N8dxO66H4YQRF916EkQxY7+eCrDsSZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kvvEF9P8HK7a4F7xP3WuuCibIbWVoquV7Up/qipgCE=;
 b=TQcJI61zJOmlx7oKyAwl6WRiQo6IBbup9pfWUfSrvKR7V0ud+7zCDzcvXFaogm2WJ0LYF7yKCmn+Dc5FNy7Buy4L7rKA9ZVEsFEKk8bBC9JOAuQu4iSAkNpwEoDcPy8X6S31Hq5smyFhwMhN+QjOZdFGPlYJpG6ttmXl/EWlX4D2mj3LDycmqYL3xTNhK1Hy8n8n3b1L8xs+qeU1850IvN2RzDcpCing65EFyEqy0irEtLshOBECedMWRXXm11AbOrMIZDdPEmDyvf9ErNcnw8JFU6FImpDIFl56Z2Yxqfm5nzc2kNhlHKFFvU7NLT/Oeb4JnOSQopexbrWWQPRHXQ==
Received: from BN9P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::24)
 by MN2PR12MB3886.namprd12.prod.outlook.com (2603:10b6:208:16a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 14:32:29 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::b9) by BN9P222CA0019.outlook.office365.com
 (2603:10b6:408:10c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:32:29 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 07:32:28 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 14:32:27 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 14:32:24 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v4 0/4] Add Nvidia Tegra GPC-DMA driver
Date:   Wed, 8 Sep 2021 20:02:14 +0530
Message-ID: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
References: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a3f3201-1345-47b8-6ba1-08d972d57c7f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3886:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3886FCB778BA1086A75A8D10C0D49@MN2PR12MB3886.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFm+/rTlgcwO5Q4QSo6VovBL93dPh3+EKQdW/MZ6qQaoQDC1sjWqChUeg87sMYxq1ftGnMDVDlEByn6zm0sKpllyHeDcVMe2W30LkNyE1uJni9YI49Cb5+nVJbeta3qScpPgXv9j42hwZpmib1Wdac2dk07OpaHMGvxy+HZb+V38vo2/+m0KkXITVso+4+krvg4OlMaZBC8JNUBflPw/7iWrOr4R1muxWiDHryxuZxze3OFjFEcTfi7o8RcWDa+pd4S2Lyw69FQ409QIFp5B1XPau9zxAafTUeXau6h5KQo+BM0PwxCOXhKbwz/S9hCKVQhzoNZA10gIIYmn2J3lklnElMJtfflaBi+HFqV32swJ+OTLycpRpcH3jWFPX8pMA42bB7eAxRur1zJEqfHssLU+8sXBP0hebg30INaKraRZSpWS3nSV9kTqd0hqYiarv9ekWNUmtrp1/C6CN+mxDlSvrB1bs6dPo/g4mX1jybJghEdSChbSs3sJnoQtDfu6ZPaPC4OresSzdrY+nuekzDtyo4lnGT/SM35nNbSuVrgALW8yKQrMtl/NOmxmMXfZKroaxyh3BMrhPw7vBVsq9Y02kE17KQU9bGwKwtQsZiGma/DBviHjgdQWJwhG787yMVfqm7tA1pMPXUDu1P8zPyu8jL6ZUQdjeglLuTSmgoszxk6DZeSFtcP4pbei7iUiS/r3YyiJHFU1KGqNQe9D8kIkCTQWP98TPI7ugS1oV+Asb1mtd+5pCMfWvEg4Z6d+RUyMRu1XIzkYkn7nqi4933PxIr4NFhTlDI8vqpJR2ItctzsgD5gwlnrPvHyPOGe8bbRPm60yR1/Kn+4Z//lr6Q==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(336012)(508600001)(2906002)(966005)(37006003)(4326008)(8936002)(5660300002)(54906003)(7049001)(86362001)(426003)(26005)(82310400003)(36756003)(4744005)(8676002)(2616005)(356005)(7696005)(6666004)(186003)(47076005)(6862004)(7636003)(6200100001)(70586007)(70206006)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:32:29.0362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3f3201-1345-47b8-6ba1-08d972d57c7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3886
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Nvida Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v4:
	Addressed review comments in patch v3

v3 - https://lkml.org/lkml/2021/8/27/34
v2 - https://lkml.org/lkml/2020/8/6/90
v1 - https://lkml.org/lkml/2020/7/20/96

Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  106 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   46 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   46 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra186-gpc-dma.c                     | 1371 ++++++++++++++++++++
 8 files changed, 1587 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

