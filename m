Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC6458B61
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 10:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhKVJbX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 04:31:23 -0500
Received: from mail-co1nam11on2087.outbound.protection.outlook.com ([40.107.220.87]:26208
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229806AbhKVJbV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 04:31:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0LkOz61/rcVcxw7P1XzbZo6u7/uV3me6HpJuJFWuQlWf+t0LeaSR1te1/L3lSOvLSHv5SFuZHkzpoGLEYzL4d3510D30e9qjrGXitBkQ5hW5lQztd22A1+MqaMD2IfABEo7pw+twK/osw8ziR++BvZ03O4VmWMeAOLmvNJ6G5IsaHAcSP+2k+XAV3TQfAxLE97pdhxpG0FdTtCL3YXZDw3UgYQjiIXjFsVZ3+Ze/ZP19/YvlwSdcOF6MBVA9ZT85BYEda7zT0VbFDhRqYAeJmQGAcMnt9xAoxLgT3PtTUMd5bayLbM58R2dEhy/EIuUMoP60B17arlQv5OzJSIFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0uwj3VkeQtQ2KXjoi56tvmxMLsY2FKOLGgmp+X+3H8=;
 b=B4GkrES8DE8FUpsnQDSjUhuYgQAp+xc8s6l4ImDaC2PSOoyegoeyvJAPsaBFScMfYlWcmMVF8lthfuPDzvj6TULmELF6uv7e0VPgoG8jW/VHvmwHzdeCGQaBBjzGUyiKuUeWq0pQEbpgIeFsKvNXxgi9aPZbWH4q0MS4qdN3bAT8S2HI60K4w+0t5nvWCUOi5oaugipUjTGursF2s9ojfyqqY1QTUmx0a7GZ8ihqZEmI+1I/wOxTvSbLQnNiwCKkEYqFoZzohsGLGOkIKjlubpwF2RKBTU1ayDYe0IahVjPBuxvlE7G8VyiVI3MLJ6uV1lhrQnZvKaYWZdqVNEU2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0uwj3VkeQtQ2KXjoi56tvmxMLsY2FKOLGgmp+X+3H8=;
 b=H5dBwfafs9JxrMXWHSktn+WEsn2fxGlYA72b7MTe60On1P4Hx0op4vWRiCK3VtZhnHQBXZJ+YlYZkVpwuQyhJrgQBFjf2YcHkBCrixuweVgoYQFiIAnk7LVlB+zKqli6LS3F6MApNiawxZJFHk8yCGb1e1EHvSwe3yYpITWUuFkBu1CaagE0FT7A9Rmz+T/yNc41j1AIrLRWHAGialsc0GVWup3hrLv3nw1Fzt+b4PTMGzH4/vymHx8FQGP4qub7CDyEEeMSVGShq4Ge1eG/wkiQ6CTkNxb7cTJ9rGkwA0uVZ8rINcEtuFJEcbDvxhqGcWtHhrQE6xgw1NjiY/yKHA==
Received: from DS7PR06CA0028.namprd06.prod.outlook.com (2603:10b6:8:54::33) by
 DM5PR12MB1260.namprd12.prod.outlook.com (2603:10b6:3:78::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Mon, 22 Nov 2021 09:28:13 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::f0) by DS7PR06CA0028.outlook.office365.com
 (2603:10b6:8:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend
 Transport; Mon, 22 Nov 2021 09:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 09:28:13 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 22 Nov
 2021 09:28:12 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 22 Nov 2021 01:28:08 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v13 0/4] Add NVIDIA Tegra GPC-DMA driver
Date:   Mon, 22 Nov 2021 14:58:08 +0530
Message-ID: <1637573292-13214-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0efa620-a3e2-4399-736d-08d9ad9a6804
X-MS-TrafficTypeDiagnostic: DM5PR12MB1260:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1260B4A281FE9D13B5EBFD1DC09F9@DM5PR12MB1260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XG2l8T65lZ4w+wr7wIP1IxReAjD8vrUaRyCN2RJUrTOMbs0wWIa6GLJaDyCIjO0kxnl4OJxP3o9quGvV0xOc/7XMVBgUpTW+EE4Ifchml7iEX4ESE8F1lAyktIc8aerVnGk80BtX+VbDgfYMue/5FVXlEahZQcUuTmx7aF3wa/XnKeRFIn2Nkf+lupypA3ZlatDFdfEgc+Sf6jKjWIrAdzMubmnPWdQ8DcbkO7WSGamK3onVnJiuatd238Uv87mYSdfCEHVN95t2wVn4TNwkq7qn4oGWovzLRMHWFIOGtK5D69IZh5uxl/5VMFR6Q9Fjaxf3UFLrQGgoDq1jTwGlQSqTafyBEFI/W5Kn3XMJqKHUbPXSzcL7lZd6+Ru2ChMKYPzgwi2fT5A7UHZiSJILLnuvrZRCNPq021pJ9YJTegaa018se/FwBbxzvsvPy5U9SdubQk0+mopZblhSXRvMjea5vo9sRJpByYVB9Sb/NOn+1H/oTD0Hcj3+agRjWr2/ureO9awZeWGjvKxuIsPPYuUz1ndWIlACjLTUp5tRM45tIARI8cTd5/nKRTvlCbawZQU//brKuMSnH5bvd2lDgLJX7mpe97RvxOXSp2ivgCK0opEYDOiLSSrayrYyNcEJAnWvBweJWkx1BN6i0Ua+bw4sgPubIDkg8hqO6n+LLYgjxG7ZGxoTbTV+tiJZ3ilsvVms/fsIJ67z1WWVebnbvM5xnTtQoC+J+Adr2hgGqQQZmMox+et4BhN8VOb7aFuV3vhLZWQgR2E4YPrN8ERSf1ORRRbY9La+L7dA/dff4VhwvRbRh+NwyZGO+UcTcGhTctb5Tap9gyK4w6C9UVUT3flUA21T/8XZ9lpeXRqMGQs=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(426003)(70586007)(921005)(186003)(966005)(36860700001)(36756003)(8676002)(86362001)(36906005)(508600001)(316002)(107886003)(2616005)(82310400003)(70206006)(4744005)(110136005)(8936002)(2906002)(4326008)(356005)(7636003)(47076005)(26005)(5660300002)(7696005)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 09:28:13.0117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0efa620-a3e2-4399-736d-08d9ad9a6804
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1260
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for NVIDIA Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v13:
	* corrections in dt-binding doc

v12- https://lkml.org/lkml/2021/11/9/533

Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  111 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   44 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   44 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra186-gpc-dma.c                     | 1285 ++++++++++++++++++++
 9 files changed, 1506 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

