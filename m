Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B853477A0B
	for <lists+dmaengine@lfdr.de>; Thu, 16 Dec 2021 18:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhLPRMK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Dec 2021 12:12:10 -0500
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:28608
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235791AbhLPRMK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Dec 2021 12:12:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NydutdDru7aC8w2P2/TtFV8EDVjexVF+ccBkd4ewo+j2JIJQnfjZ2HhuZPfmIuuEblwlpFNLUMdG2GGPAp7RGKCHKymH5J7rT61EgeJ1l6z8msSdc9IfoiELA1A3xk8Fi0BmmXPBOxizDJrt6i38DJr6YvKMk2O90oa4ZbZFKKDfjslK9FqH/bwxM8xO3F729PwROImfZH5HPFvBrssiaHhvZ7Hpb84/w7wUSE6goQmyH6HvF/NIkW1sVKmZvb3cJ845AYqBs4KFKMtyVfHHve4EIR7iCZm3EK+vnON/6Fp30Y3IqtW+sO6BvpuYTEITQh1svLUdCGHOkLsl6ceTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsZFi+p/kXxFzG00boegc4Wg46eq3NY0ldvychoVGpw=;
 b=XFXq8C06edwUZdrZuOI0KzgkXOtPflp0P5GkMHA800z8ZlkY5IBCfXJ6STjb/WgcdvNfuWYnivp/th3xHUs9vpDMG/rZyO42ev/pgF6Kf6wEpYA60psPZ79Zvd6lKP425OnGkDnDpJNj29g1xuPhNYO/YY9IXBEQpICJ362el3Bk0+Bs+BKbjfh8A9rIp5n6HOar2dzmQ+LOGTrnNuYT6tVinfFqMqqZLSAcKaItjTXUcHwrxnnrO852F8onRHaQD0FyifmvXDZOrTv9sYS/OawKGoeQnjvwerYIuxQAk7dWUonl2WX8v1Q/nm8qJEdowHySSedhCWQ5GnmggI8Psg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsZFi+p/kXxFzG00boegc4Wg46eq3NY0ldvychoVGpw=;
 b=RifDZnEhcFDjN/szSWtCGBejDivbbWx2nOkWg33r5jgSxrYUmyQCxbaNrNOWOPfxskLxkFF6bANifVpNaxo5WBkMxvzhSwgznLiafgHeqALoIJ+3A721Dd7Tvw0hg8dFXWCF0S1r5mjTOAPSnk3sJmhd/MaUDjsfZxf3LNa2jrGeKH3f1wLwXgblGfUmnhIvwjblVFRsz14hg9PIJr3SnS5pCOWNzBxRNtj1HNQdXnT09ocsu/6M/pJ7Sw/hOIV+Dy38P7huaKDll4a8YcQhtSEre+vY1nEExIB6Sb48unMuuUQKsVWrVB1G7xgf/dd+NxRhR4qqO3TKXB2U4JfFIQ==
Received: from MWHPR2201CA0059.namprd22.prod.outlook.com
 (2603:10b6:301:16::33) by DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 17:12:06 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::77) by MWHPR2201CA0059.outlook.office365.com
 (2603:10b6:301:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 17:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:12:06 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 17:12:05 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 17:12:05 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 16 Dec 2021 17:12:01 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v15 0/4] Add NVIDIA Tegra GPC-DMA driver
Date:   Thu, 16 Dec 2021 22:41:56 +0530
Message-ID: <1639674720-18930-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff2c07bc-7728-4999-57db-08d9c0b72ffd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB482786B4B596437E8117482FC0779@DM6PR12MB4827.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cDSje8vHy94hm09tVcHlbcL2dubLI1ePtnpCU0ApjTGGybAEHPegs/n6IwIi?=
 =?us-ascii?Q?T1r2TjFEew5WGiQh85lVCJYCfmT8eVjlFTiVInohWfDO1k4HHSMEabTCWVYf?=
 =?us-ascii?Q?0q282Zh5jayX0S7N0QusL0TDKjgIHescHyiw0ckg74pGm4A4UUyfmTpVmAU9?=
 =?us-ascii?Q?b0HNxunsx+huRhAhhrycV98PULxYNYI8scPOiHJvvnaXB++/Aik0spr1mdED?=
 =?us-ascii?Q?ldnSCse04v3wWHMa7HvYMhddOA1ll/Ba5OqW4qMKdgZOMRA/W+DVhWVCZg5I?=
 =?us-ascii?Q?AkWrtwqd75Pf4KC4Nl0YogZ4rH3OU3I1ugJ1LsFwJ1AM84QerqOyXCYB/f9R?=
 =?us-ascii?Q?OiYjhAp/U10+rttOYVFnHKTekfmKdxFMUt39tRKZioQ9NXGyqATF+mQzVoz7?=
 =?us-ascii?Q?SND16NGbZBhwM7AD14XLHjx69kSykSWpZ2cHNpxX5tYWHzXVlpc0dVBqfJOh?=
 =?us-ascii?Q?+wdRei+Q5E/UKoMeE+NQuTj0Z/8zzgv8Me83IhngdZUUD10oI8k2+Gbc5XDZ?=
 =?us-ascii?Q?VHVax07P93O7hhCQNMK3OmA1B+u1UqHNCvksHd15D6bLeacp3PleoecVlVDH?=
 =?us-ascii?Q?QUrStuemciD0BfJs9LChVDTvBcbxq1hOHc8OFRhgZw/USEOOajPunDel2lUn?=
 =?us-ascii?Q?9Sp1RtbcrxH+4+ZgMLo7Cmha90cMRWx+6AYtTGLgDA6kaPUL3zoeX73VGBRW?=
 =?us-ascii?Q?0af7ATxWfTS7mLow9Y4l5JQyuYjIrA8qYAKCWkUn78MnPRrxwiM9fQsV+o+F?=
 =?us-ascii?Q?cssPi+8SRy153Eq8wQfjv3+lJZYKLx5Oe2jyQtBxaIfRl8ydlBsdsRlR7IEW?=
 =?us-ascii?Q?IkbbAXw79ToctAHRNAbS92iZk/3Ns/g6dRIugyQ8VmX+c5eXAhrxe1fINgqa?=
 =?us-ascii?Q?9ETfE3L4WqLLeEDiB+0NvjQhyV1d7Kc+he0ksLevcJI4nBIpeZjF2eBSwNCk?=
 =?us-ascii?Q?635z/EaX3lXahVFGUJOnR5fWHVEnVhK+xgXejZCEEHo=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(4326008)(356005)(36756003)(2906002)(110136005)(40460700001)(36860700001)(5660300002)(2616005)(86362001)(70206006)(7696005)(107886003)(4744005)(70586007)(316002)(966005)(82310400004)(34020700004)(81166007)(508600001)(426003)(26005)(8936002)(47076005)(921005)(186003)(8676002)(336012)(6666004)(83380400001)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:12:06.4910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2c07bc-7728-4999-57db-08d9c0b72ffd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4827
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for NVIDIA Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

v14 -> v15:
  * Removed late suspend.
  * Removed unneeded prototype
  * Updated kfree to free tdc->vc instead of tdc->dma_desc.
  * Updated Kconfig to use ARCH_TEGRA instead of specific chips.

v14 - https://lkml.org/lkml/2021/12/6/370

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
 drivers/dma/tegra186-gpc-dma.c                     | 1281 ++++++++++++++++++++
 7 files changed, 1489 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

