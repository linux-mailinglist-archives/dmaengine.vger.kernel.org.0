Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B78469620
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 14:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbhLFNEa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 08:04:30 -0500
Received: from mail-co1nam11on2059.outbound.protection.outlook.com ([40.107.220.59]:65451
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243408AbhLFNE3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Dec 2021 08:04:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbPIVROaPczIQWhHvX3AhM9PZ3AVj3BMSPfvHs7tRwFGy8Uq2bBDRv8IQa1HnFEjxFoiNVPR1nJkKyyIJiFJx9kexUJ6qXPpGWlcdhVubBPs6fBYnTvKnUrsLpHJgxT6alNRavAStqxUGJNnAl4lALZfO8XXaRUWSZBrLNhMujXMCS9vvQw+7rkTO/8Muz7rNLoxoZuwo/MoP1a39r2r/S5X6rEPtcPyggxIq3uE1wkcmB2x5zuUnos2QKCuf3/eYNnqYpmIEyLu3GoWl8+AYAdBMiaJGlEZBT+gU/uuafLURPqh9wTURI+sOu3RTyiJaS7iee955E19madkg6pZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhqoWxb1uCUjccSN9AqpmRQ77gKsiZmauerwWxVje44=;
 b=IoMAjyyZ29STauG6Co88YuapjwNRQHiP2yEK91yvuvaPjIeVI3PW5W6CLp6txQimh7onR53OKQBCP9aGjn9vypVWEz7nr8q2FxyzRBGUUi6+hdm0186gzt8bXRzGjYLIhEGV9DjLLlpweuj79xzh1stiGC33Ad5HuvCxWM01rwoY4a5pMqeaOo924IsQ/1o31jIWbj2bf4vaDbFVYKEa1CW5QOUDS03+SikeFy5lkFWYdy+Ga3vWAxFtWYQIg6VcJ6hErDbOFEyoGIVTY5Wg8HIKV66cwKAqixURFBfc5qvtmKtpcK6NtY//IS9Uhn1lwAK2Ib79w4DK5ketRj23Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhqoWxb1uCUjccSN9AqpmRQ77gKsiZmauerwWxVje44=;
 b=D4Omhm+EV3BUjuv8hdGIV4RB/iUQhenLxiwRclB0CdsGq26Ap/6pD2UI7oHv2L0xfxga9E2itQusVkgRWcstFC9MeIk6Vs5ZKiJlBeZniIEaFLhhFFu23Hi/xpRmOMQ6ej2bYi9uMmv/upZxoUXwA5tB7gmYVi279kbMg9sWaE0tnbxCpGLT1DGmU20DaDOyJC0PKp/1Y3y/m1w8mWQekEtNGC2NVsNQbLq6OSsaLM5r6XUdSwIRRBRz7XOt/EhCro0CrlBeC+hJCuoW0OIvGOtTE/3R6a96sIdpg5JjbqSLdoCPE3ckzjJsVUz/VbL+ax34n1xvzHECAnDnbZ9CNw==
Received: from MWHPR14CA0003.namprd14.prod.outlook.com (2603:10b6:300:ae::13)
 by BY5PR12MB3985.namprd12.prod.outlook.com (2603:10b6:a03:196::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 13:00:58 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::46) by MWHPR14CA0003.outlook.office365.com
 (2603:10b6:300:ae::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Mon, 6 Dec 2021 13:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 13:00:58 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 6 Dec
 2021 13:00:58 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 6 Dec 2021 05:00:54 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v14 0/4] Add NVIDIA Tegra GPC-DMA driver
Date:   Mon, 6 Dec 2021 18:30:35 +0530
Message-ID: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aca9386-7f59-4f95-0175-08d9b8b872b5
X-MS-TrafficTypeDiagnostic: BY5PR12MB3985:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB398569C5E205E9DBA0686198C06D9@BY5PR12MB3985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6Qzzgdv5rr5hIUqSYlCFYXxwOtb+zS1CZOEMzUikDPM4O1+ngf87PD30KRTU8LPy6RJfTCIXNqKnH+QiMoacPbXeU9UfTLKBz/fRcmBAE6UUfJOwK4EqV2xtUE2Z0+0d0/n0wC1ugJW2YH0EolTGMajgjP4Rpk6rZ8jmUTDvVBlBCGUpBOK17qCxJv4nvYlYnQ0nVPA3AjjAaGh7BNOGVr8patp3m5eMXBpVD4/MY+203ozDmohITwXT1T98x92Rc5Pvd50+DnCQvVegx9Io61OZP24gb8AfWdEuRbXntKzh3SgoIiOPWiIM9bgG6JxHJcOAwNxLkbxQdKgSHGfU/c1eoMMenMuYp5UuatMVTBrQPzrmDv2RzSzLWbGH4CWHmgDXDeMwqWdzOkwqbUxsDbjmSfC9VjEGG5Ai+z38sMZGfh879IZ+1hjbfF5BTYVBeKycAuoO199ZXOREHr1ARwbA+PRo3uGbynyah6c0BtgoNh7yiNGG9BxXdTXK17iZkKp5HFL3gfgJAzv0KxtD7IX8cIVTMyUA4OfB+k33MhpfEuEyl9nBXpS4wl9PUUo9MoDggsQt0FvoQGLy3K6kSZHSubRclJ3nc7xb5HTsw5S654NM7G2ruKpqwJ8MYF7ltalmbWkNJctmRtRZzZYlQap63aUBVf5Zi9pt2BKhFzmSxgNrSvZj4qNsYubyTL4s0nDDBbVyLeRQicgIt+LJbhv1cYrO3mTIRbf3YTNzeiOt83zLkPcbReZp96OuZQkot+paiK20VXjxEQoU3IvPOLg7eMc7WXrEgtszJvMxxb/5uA0Yt4vM9lNOslLFqprCI3HPeTXhgPIfZF31JwbH/4BXqptdo3z8mHZsV9ikYyPaM9vGG58ijwjvzHV2IwrFZ8MnTa12rzYrBBenJ7LhQIOCJOdWu8dcgQnRyY9U50=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(921005)(110136005)(83380400001)(86362001)(7696005)(4744005)(356005)(36860700001)(7636003)(5660300002)(40460700001)(47076005)(336012)(26005)(8936002)(966005)(2616005)(508600001)(107886003)(2906002)(70206006)(426003)(36756003)(316002)(70586007)(82310400004)(186003)(6666004)(4326008)(8676002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 13:00:58.6461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aca9386-7f59-4f95-0175-08d9b8b872b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3985
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for NVIDIA Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v14:
  * Fixes for warnings in dtbs_check, dt_binding_check etc.
  * Removed .owner and deprecated one element array
  * Update in no of channels and channel base as per hw

v13 - https://lkml.org/lkml/2021/11/22/145

Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  110 ++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   42 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   43 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra186-gpc-dma.c                     | 1284 ++++++++++++++++++++
 7 files changed, 1493 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

