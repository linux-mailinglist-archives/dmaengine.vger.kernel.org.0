Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ECE415999
	for <lists+dmaengine@lfdr.de>; Thu, 23 Sep 2021 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhIWHxI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 03:53:08 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:51233
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231977AbhIWHxH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Sep 2021 03:53:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfDGHshtgr4dwS2cMYGkUB5L5hmniXFDaEtVhzfUpd0lTqKHQwW0hFzn/5f002G7Of4lImY5ejH45pVFdFAFif5dEr9QeNH9Cz4DW3lr28mhbTbqPcX+nFlaG5P1OzjA4Im8rXUjHwJxFEsj+9/bL5df+LNBiOy1L24UlgrF7sWzTXhLN0zvNCa60x8ttQwwyn5J2QTkiUtGuNZBiLlQ7Voy2dPI7fMN06qKwP0nOyJl5lPZsZkRpw4jIM/Vu9FFsbL+rxZ0H05TwWYa0yFGd2klVnZ9B86HEPBmxGim9d24D2jZ1BLpXpr3YHr1Ig9+s7ThSqvg+gDq4M5oOd5adA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0xIE+1sFbx9EkgLpO9lTBQlQvOjcBETAJCkeKY8yrNA=;
 b=AdpHwrkMBJ4kh7n3hG39XJm9fevByEwl8Yuk8u55JHt/kra4y1Plhj+WIaUKDVEDctwtxwfSBskX7uFJo7lzH9NgUJLuwU6hYcH4LccB8W6/K5m3QGMR+1J8F7zYbpcoeqg+Nai7qpEopnYPbYFfbTt2YARICvjL5T6mdMFXbXmS7GZpvW+ArbFO6/q0iy7d8PgJP3edhUIHZh/kcky3S0MQBvd4gN3+U6mL+e9744SIo3dlhOmoF/oPhgJZc/FBrr+yzR4PXaOd2JqoYGSqTodgb5peYlR+DcqtaKYPZ+NBRiu4aU8G+JNAKK2FZmITEP6dfDzRzXBW+q1pi9k+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xIE+1sFbx9EkgLpO9lTBQlQvOjcBETAJCkeKY8yrNA=;
 b=c2KyfzxsaRPJothPySTjKs04LbgoIFbaQe5uU2qLiK6ewGXQJelnLHALHEyrR5nZHVxOGtuPNdwRBpVTEQTMcKBtuyyzy+uWgT+bapX23YLhJ4h4NfsNVhE3ROkQXBvtQ5NC5Lk1Uz+QvgIJkunkFXBKaq+epP834k264mwWndeMXyPuxME/Lk069wEjRd5CVmc2LwiI/xsQhuu2X1Byt4+uaWBPCpEDuAAM48MvZW1lW+N+L9nERxuxV3wjHkfuAx1Oesr0b4MirhDsM6YPxtaAIsAdmwg1BDOF2d7HyLbOH/sCGYfgA1E3V0hw5642vK4k/Bh9EFz82PXC64Y+gQ==
Received: from MW4PR04CA0149.namprd04.prod.outlook.com (2603:10b6:303:84::34)
 by BL0PR12MB2419.namprd12.prod.outlook.com (2603:10b6:207:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 07:51:33 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::67) by MW4PR04CA0149.outlook.office365.com
 (2603:10b6:303:84::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Thu, 23 Sep 2021 07:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 07:51:33 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 07:51:32 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 07:51:32 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 23 Sep 2021 07:51:29 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v7 0/4] Add Nvidia Tegra GPC-DMA driver
Date:   Thu, 23 Sep 2021 13:21:20 +0530
Message-ID: <1632383484-23487-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0ed5cbc-4a45-4e69-f2cf-08d97e66f63d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2419:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2419FAC229DCF96794E2B5BBC0A39@BL0PR12MB2419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDnUtKo6gLwwXMYZzP6XqdCU/sm6NMdMTDShLlLVNQbsY+P6DdhOysCqKF96eMAv0PQFQ8YMWXAC/weN3Iu6+G0INZyCmz0sKN6ssfCh4gKg3zt0Qoei/gOtNbCIy3ZzkU1DMCTWAiy47OyOXtQL4C7WNLFWLgvSt5l2q5yKvbo7UCM99LEApBVV1LVOIeNSKxyZGgS1RKbx7rtaw5CImNMFOZL2rioleXF/GbOrZyOwVxpXAuUervGXqdu038uyCbbWE39Iak8krSCPx6bhs8tcawZqY7sXs7bKsPYlGx+Ruh2WSXa198t3T6MhbdV/x8Z8XvDfU9WOj4neHDlpsdQneX906gHQNOz08lUcWv8Bqpv/AxDsoTyTiUSc+LlX/rxRaYuVWhExAWoSsQtq0BZevjudGlrgiJ8Fz/gov/ctsSVClJp6fhTMzPHojEcTKIT3vAnJywNa19knR9qo+wg92o2Z71oPQJSDoE2ZjBP/JbTMXJRBYEIg/QQN1gEeKfvcHlXJFjqoAYIUA6VwQCinum5YRJE2RYhyfB5ypOvPOJibUM5f+gopTkbWGqd1KlwGgg+N6sabp39b3D/Kx9t79GhlQFLAWmknG0qwT2khI4K2PVllCRn3/JDQv0Qw93wpLlSwahZ6A66EM1cv1ey7aXq+ZNolk6qUzkJqVFhGt7tEYlJxmCe0j67XZRpBq1sa90AKW7aC6lyaLjLu7BEz77Oa+mswQgXit5pD1kAj28woOsH5dGIU+0tLoVONPaVvqmYXqW+z/A5P/dSOZOA5ZzUDTm+gos/3O+hrgd1qIHTD3gG9JA+TxEoh4/XRNihztVLG8E26XZBIedM+Cw==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(7636003)(508600001)(5660300002)(36756003)(356005)(8936002)(6200100001)(2616005)(6862004)(36860700001)(8676002)(26005)(82310400003)(47076005)(7696005)(36906005)(966005)(316002)(7049001)(83380400001)(336012)(70206006)(37006003)(4326008)(186003)(6666004)(54906003)(86362001)(426003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 07:51:33.1475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ed5cbc-4a45-4e69-f2cf-08d97e66f63d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2419
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Nvida Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Changes in patch v7:
	* changed function name / position changes for consistency.
	* moved tegra_dma_start to isr and removed to_terminate flag.
	* Updates in register reads, variables and checks based
	  on comments in v6.
	* Corrections in prints as per comments in v6
	* Updated the logic to get dma burst size
	* Handled the case where the vchan_find_desc() return NULL, but the
	  descriptor is in progress

v6 - https://lkml.org/lkml/2021/9/17/652
v2..v5 - https://lkml.org/lkml/2021/9/16/455
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
 drivers/dma/tegra186-gpc-dma.c                     | 1354 ++++++++++++++++++++
 9 files changed, 1562 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

