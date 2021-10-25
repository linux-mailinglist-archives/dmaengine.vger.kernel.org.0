Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67676439BD0
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhJYQna (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 12:43:30 -0400
Received: from mail-co1nam11on2059.outbound.protection.outlook.com ([40.107.220.59]:48224
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230024AbhJYQn3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 12:43:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUapb1YyNdeE9aI6rAytNRcPCVX3sLFfSVJVq+cNcTtQLTgkEv2aVVrMKmzxqh3mMzR+AO3mDf3d+Cg2Si+/wQLj2ixFPvOMNXKN9jCADhpbVKdE7zhYuGk32QxMkD74jdMyL6KPvaml9UZay1oXSC+FnX+pTZ+a+rhetVy5qbFrWYMMJCj0wth3r8pBp6rVqtl+rNW5brt7w9PVLkzFe0YGgct/jaKrAwETcseR9XShfN7q2WKUMxR4ia65duRUjfzMdzKls9kuW0MBnWZjoYvAywGPljaGfGicAvYkamm+9zEK56iSUeseO05bAhKfJiRFca3cAZe668chOwZfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTFHxGbmh3DrTeftlM/xIZ3vC8KX/cvZJsBBrORfzHw=;
 b=AIqoEGVCFwa53KvYV4M68FYwPhxGjuanKKK8tLTLEyiDSQhomvrF//vnh9GnEMuJWQGfZnR57U9GrEvHEjyGMAhxNuTOUv6h1sfiIaTWRlDQcXv5+mbZUpndCP+q70YY2lKHOzQ5alkf4XWHGxKFYUSKk0soMbNOwiK/BRNNcSpQ3jNfAnIMIbScI7JkRB5u6/h+xamcepldVZDUGQKebMBIZqCG7631CWqyphufWKhPmV5Vwu3IoU5MdJBhkvoYisgPeiOKfM81b/xbG7kQ7D8HvA9w9IDe9rwa9lg3NzTEnZQdcL35H2J4gMp1H6shYmOGjKXml6WesXTxoZXOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTFHxGbmh3DrTeftlM/xIZ3vC8KX/cvZJsBBrORfzHw=;
 b=FDODjYZ1eEgK6Jcahw+qvWqFhq9GIoBzkdFq7WPbxS7WB7e4BqMVHY+PSO5rxbsBd8LchRLTWxmyhSjLafffhLTBt0ED4gex9RKx3/Zagh80X04oiROOqbqaXg+FQcesy8TqaojUbDiZzQ/WXF+sFq8iFm2V8DagKg/oVa0ZVq32RWjaPqR5rNGaHFvnk1SZmIDAb36K6jHYwsDHB5jF3cu/ItAaMLMxI6P/+83zzxm7+YoP8hI8gWpgrz0RAATC8NGIs8lpGQUd/kH97FPRfA4cw1utgRs9/M9qG+yyGjDO1tQ2rZnXula3ESrm569u7rsVgooH7BgTMbtNcEhB5w==
Received: from MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 16:40:54 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::31) by MW4P222CA0014.outlook.office365.com
 (2603:10b6:303:114::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Mon, 25 Oct 2021 16:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 16:40:53 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct
 2021 16:40:52 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 25 Oct 2021 09:40:48 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v10 0/4] Add NVIDIA Tegra GPC-DMA driver
Date:   Mon, 25 Oct 2021 22:10:42 +0530
Message-ID: <1635180046-15276-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e03183-668c-4ebf-9b9b-08d997d63652
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41753A1E7C4895FA280B5F3BC0839@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdhQXHv6HLr9S4vwGFjurvjg/yu8ccq7TVzvGOiAXNEEbrjn21GHhFe0jCQATilQx5eL/QBLjqbUT0ugVlepW1l50u99r9GRzWQeTr/x0276XexbNPP50sZdB0TmIE9NijhchbmFLy5gEphtl++EPnLKYSLSBx9/tuu5dwz8H48JCW1ZBLXhhY+G3rldZCdkZGCHHnk1mHLnFNVKqhRfoZFzRTPMDjERsNg66kYMZiOBFjl57wD4gBIDKj5AzsQw8fu+aVTUzZgcptigL9b91BRCpEFG5Mc3N9lPk51yFfTI1bf9MY1L+0YxRzUUaMWbXWxOo+U0YaARnA/U1Y8qdaa7oPUsW9A1z5Tujdl7THgtj2wzCulsCA3rRcLou0Q2SLburGCfN2TyciNJMPHSLHchNNrmgHBSiJ89zbTsHVBzkv6kxmsiPYyYr7kdQ5RQSnqeQUHQnSFsCZ9hGTn6/30Rv4rRONWbANQZ5lH/l7J8Toli4WUY1/0A5QMpE4nTLe6betQGOYqjZ7CFcF9IhUocFZ03gAuxZxUTXS6fgpaDdJLIHhZoo/kWTIozxReGHv/5qqyPTkWKe4+2rzsmkus6NZz2ktUhSZwGI2qMHJgf93bzrV1qcFnGBWhcJl2fPsAlU+64T8+FLqS9ahPQybDMsN23DJAS+5D3Nxw/e/t5du8m0eE19tdO6/l8xJmOGK7Y2maBCLz5HMQmscZo0CUexxRmI07d5wN8eoxVkj8lWgwFBJd/4/HznAuQL76gFpWghcgIZmLV0zeXjyCUxkyMusDLV3j6R+nE1nNJRiM=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(86362001)(36860700001)(7696005)(356005)(47076005)(4326008)(36756003)(7049001)(7636003)(966005)(36906005)(426003)(508600001)(8936002)(8676002)(2616005)(82310400003)(336012)(70586007)(26005)(83380400001)(186003)(37006003)(54906003)(2906002)(6200100001)(5660300002)(6666004)(6862004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:40:53.8855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e03183-668c-4ebf-9b9b-08d997d63652
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for NVIDIA Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v10:
  * Moved config TEGRA186 above TEGRA2xx.
  * Removed headers which are not required
  * Moved ch_regs to dma_channel
  * Updated dma_slave_config function 

v9 - https://lkml.org/lkml/2021/10/5/569

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
 drivers/dma/tegra186-gpc-dma.c                     | 1281 ++++++++++++++++++++
 9 files changed, 1499 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

