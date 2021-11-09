Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790AC44AF8F
	for <lists+dmaengine@lfdr.de>; Tue,  9 Nov 2021 15:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhKIOjN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Nov 2021 09:39:13 -0500
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:16397
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229880AbhKIOjM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Nov 2021 09:39:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/h8p+2SL3DAZ6kbWAuToVl02rvCD9lAHStIitNgJuEFHxUMhfcb8tMJF5sanVPyrkvZUy3dbOB1Lzc9HabrnyX1jffacvbImyE8LwOtLTl92nP5v+ayOtkpdpf3tojJYendkH/ezLFwar/dvAZsPh78KQ/xtBzUB7YMGsM/3Rw/1LCC7KzcPLgBpgksYj0ljhXSlKzHFoniP8ECyFIgV9IA8KIM/jTaZRGqcFNdupk7yeQt46n1C7YPX1OEpIe1U4SDXYMwOHaeUGy4A4g4RMqaJZzpAWVFwIKYSIPLNYoWxY2F9DMMmD8TrTkOvvhSqltt2UBEBmtehswomm8RAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL49eba/6TXRn/mTV1T0jbGrd9oZ6VITe0u/lCdpkgY=;
 b=MeeyaqMsGdPJZTMrB4ya/RWXR1pEGwjjSoKCvMPVPzWBZVL52VnEjkhAr/y96pxowJZ+m1BhO78XlMMsouYEg+DmwdAnHSyracB/kIqFnYCWmRHcZb41DxFPOa+YVD/wHKB2RieJa6Urg2X3th5M3TmNlRkl9QvUMSyNqsoBLG0dmoEj2bI2g95koCqLP/dFvGaprA8uP8wObmEgkl6hSKq52M4gDXNPIiKJUXIKi1TR5UgjhTZpeVncDQmfpBSQ66xNCwISSWEofU3u7eTU5HYrQjcMbvRxPewAnwsj0tZdi9hOABHtqdtVZLbZ1F7FK1qI/JoEuEl3EJXV5o0SAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL49eba/6TXRn/mTV1T0jbGrd9oZ6VITe0u/lCdpkgY=;
 b=qLrDjsKOEoKMs8lrRZFGstbU7tsJ6LbxVNWskO3CZdgTIZ35M9nlzM2Kyl+acpctcx/9OwtJMdpSl+kpk8XcKtPr9HJ59tTSPPVoHOtgOn4eEj4P2247uSgjOYXWFUkxAYYW8veR1PNXYJ2L1DxjTO7f3fCrqvFJTZ+4vIjsR+09mcA5aoJAlmpcPhoPkNR+QRYlAear2QWxfQEXdT4DRKL+64kIpbwc92hCLwEflBhlqJwSjAT1Wbhd+k9jCnclU94b68k6aFI1dAgD/lDVxz7PsApBZEtwZl7SsGTP/mhE9YXyRRqOR6UR+UNqTcSL1dbHHnBKoClS4xFJdEVp6A==
Received: from MW2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:907:1::23)
 by MN2PR12MB3215.namprd12.prod.outlook.com (2603:10b6:208:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 14:36:22 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::4a) by MW2PR16CA0046.outlook.office365.com
 (2603:10b6:907:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Tue, 9 Nov 2021 14:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 14:36:22 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 9 Nov
 2021 14:36:07 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 9 Nov 2021 14:36:02 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v12 0/4] Add NVIDIA Tegra GPC-DMA driver 
Date:   Tue, 9 Nov 2021 20:05:48 +0530
Message-ID: <1636468552-1120-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
References: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7244865d-3139-4d09-bbd6-08d9a38e4d06
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3215F766FA5F062A44A6CC2BC0929@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2TDPiVPeBwxPr1W4UnOV9H0tiltE7FqiYXkz4nj2h7TNW1HIdaHJhjBbKTTRxWbOyPyAxxaWXmXu1OCshFuD6ZBvi8j+oB85dWajHl1gavhzQu6C/x8z1Pyz3zheGT4FolTn9wmFmsKr3SqdG9/6amaXWCimbVNcFZ9IaYEFK178spq4ZMqtomYoekH8seuGZfWyyAnVorp0ukeEEw2i5+fv9hvBKNn0XxnH2AJM5hg1tAu3h7rx5jcI8oAvcK+WokLjPPrHWfHGLGfmHSKF0ODPh0Yq5z1IoV49ywk3kNzf+xb0MNaYYs0R3AiL2+R2JlSw5XYaGTfoYvlAT3efIuDlGwnn3OAMFoKM/nYjDBM+yFTGrY2wFfizyFJyPJFEu+QsQkB1ySGvDPnfdX5dRlZ2q4BVBH2qwbC9RRyiu2sVJ3iV0XystPmOFE074HCtkA9yiOYM1vzJC3l+F4hx4j5fJhmLjSCeXwhOR5B6P0dGl8OrSHD6+Fa9x7k3S7MsC7iGk8mnvDv2ivk0+SxCZh83ncpRRWsue/XyrwAO5BIohW+gthIiXveFPIJbWkZwSEdxzXvlm4p9ZQtDzsROEzqdvWou4j9qsAB8k+VIWroBBeTJXcyPeB4hdFupDc9V1vkRV/fOz5zHzPLtOnACQHjWbL2s44hE+is98WnLMBllWYEUvGZ8QGiNoeLpTKlqPgh3ni3aeX1v2L00l/Wk21pOavKvxyFaJcAOCtuS8aOjCSNNJpNqQRteOKgFJG3NOGuRuxEJl2o3aZerQusMgkrs7l2HSqK1Spug3Qfq20=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2616005)(70206006)(4326008)(26005)(7636003)(36756003)(508600001)(6200100001)(86362001)(5660300002)(336012)(8936002)(54906003)(82310400003)(7049001)(316002)(6862004)(4743002)(83380400001)(966005)(70586007)(36906005)(47076005)(6666004)(2906002)(37006003)(186003)(36860700001)(426003)(356005)(8676002)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 14:36:22.1476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7244865d-3139-4d09-bbd6-08d9a38e4d06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for NVIDIA Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v11:
	* corrections in dt-binding doc
	* fixes for warnings reported-by: kernel test robot <lkp@intel.com>

v11 - https://lkml.org/lkml/2021/10/28/454


Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  113 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   44 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   44 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra186-gpc-dma.c                     | 1281 ++++++++++++++++++++
 9 files changed, 1504 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

