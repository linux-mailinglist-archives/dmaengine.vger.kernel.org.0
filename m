Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47B2458B71
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 10:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbhKVJby (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 04:31:54 -0500
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:33025
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238884AbhKVJbv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 04:31:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRS1kVj+f3E99CO7oZ+XZJNLyZuRuAO41Msp5Y7P5Lo5Y2k4KvGevcntOpJOo8FkAiNXOuA1Oxo7sEcpFV8joQcnPHYnPKY1DKTUkaBRpkoCRypUdmx7yx2m/gDrQrCPP+szbUxy+JD5VxZ6i+eG89d+Qi/aZe2JhKOG2Y3VnQZrNZBwvz9NnFkE11aOKmHJD4yQ2zs49wMbh2/XZXyEFFnPBA6Ot44uxqfExL0wgzTaUHl1th2rFpGKqNDZ6la2UiAWMPv+KMpAAnUloAIaEXMrYyB/H7Z4AvgaqSOxXq/HVq9IdbzbSt5UtG5svVNpT9vEfRI2ctsjAsCG+2VvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCc4HZxmQxbFhMHaLCwO8Bw7VvYoKYE46xxG49EPdYU=;
 b=WBtdsYhVpQ5KpLks62wQAiMbaLHmwwzwVSrckrxZiMGRujG2Ee+8/r+WozKR+WGXGVLQy16ig4shQ5D8cfU0G4BVcXcZOilSVkhCGW+ESYdoOy3qpHd7CjpreCa2hxiCeUx8cBWkMxraVOSoo9IOU/4qLqw16T/krjCHO/LK9DSHyXsEQ+dn5yTZ2baN8/HJhII95gyeFaYi6IrawRx2EuY/jPPY0IybkABxPyXdfC6JtzYVpOON/+Pa7nx9GabPl7BvYKYd5hC2W9OyyU3mOe7kWlyBewZmW/lNLqQp4PvAwqsrFzd0Z5DdOZz0a/xCccg6FBowoleHapeoskHK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCc4HZxmQxbFhMHaLCwO8Bw7VvYoKYE46xxG49EPdYU=;
 b=qtDRAkEhrGHQ85Vt3bs9oOOkJLejIXRD4S76LmuT+G7ovy/sGv/Bw+V40bx50T97d6QuVEU4mGRhQYnmT7Ofquor+JTK29Gkq6EhYxWiseEvB38nDf3mV1iqCV2xAyrDonQwMpWNDU0twiuBE5nxwQsUvaZIiD+Xr7SpRbXxz3Pv6/bYMMu+AXpWEPi68sbDUg9c+xWc6+Khse5LECGT2O8YDD+OLEgednqnCGHpIYxdqpK4PiHMmWprq3GdAOq4KbxKVqRBEnQT4vESiVd3INxDn/fpI5N9Bk4IG0a63/YXAznRekjQDkIbvZMNXflYQxDuU3WltG1kaePsm+TYeg==
Received: from DM5PR19CA0039.namprd19.prod.outlook.com (2603:10b6:3:9a::25) by
 MN2PR12MB3358.namprd12.prod.outlook.com (2603:10b6:208:d2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.20; Mon, 22 Nov 2021 09:28:43 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::9b) by DM5PR19CA0039.outlook.office365.com
 (2603:10b6:3:9a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Mon, 22 Nov 2021 09:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 09:28:42 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 22 Nov
 2021 01:28:41 -0800
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 22 Nov 2021 01:28:38 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v13 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Mon, 22 Nov 2021 14:58:11 +0530
Message-ID: <1637573292-13214-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637573292-13214-1-git-send-email-akhilrajeev@nvidia.com>
References: <1637573292-13214-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 394042a3-0476-40ea-6885-08d9ad9a79d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3358:
X-Microsoft-Antispam-PRVS: <MN2PR12MB335812AA4558934D929CDB60C09F9@MN2PR12MB3358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhvlUoY48BoMkpzU7jjXiJ2KAGOMIe1WbUhSReNLwZFvZEqnUpXK7VXqOSYqtUvznEWOyAOXv9begDTvxgeu0I7eo9dn9veYapjKNMFOkVIwuLYR1lg0opuf0wFTRA5doXCwTzwWFJhdR/LQqOw1zPovJWEmvP1xfFGa3yVsd4+yO4Ti6/3AitDcqGFijHVPdzsjJ7/nTbGpE0kluLEMt+HWNkc/WVylWIoedS8yUhFty6hrqHUc7CQ+X569s2MZuF52ignq5gNa1jB9pYIx89uchBuBv9ZbDViZueA6qipkTfMq0htTwIJ9BX8EeMyosDlvgE5nj23JEi1PPPccjPCMI+rwEOWp/xgZJr+nS66FXoHtkToM+7wTOf7dZyIT/HtQZksC2mrQzeE7Wn1iNx7JG+UWm4uyThypI0SmSVIC4M9YPwcRCM78HbUru+ud/Y4ZwUHn7CvSGpxwfIFPhLRBOUae3AWRhJPg4sBX/q/nOiZ4O7Spx+ow+s/Z15hLyLKq45XKDEQRW8vXaBiG3Rcf/RuoGtojV+eu8N3E/tGAiAYabE4nwEC6j2IK9J+BodCIoVTO8RCHwH56bsiyfeXoZE3bn4Tx6vW0nJRHgeQQvzA+9VNGcQBeZGlargismMU+2cVL5jhQ/NhmS0B1DBGdirGvRFIVhB92n+e5M84mK4ZVg2sNvqUl05SaMhn7QYX9VyYGec6ZI8K++x8S2XuQPc3CaoUv5E78NqGT7AR9MD8LcsfPjdUmmQv68U4tP09BgAtHbI2utihFScrsUg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(8676002)(508600001)(356005)(47076005)(107886003)(110136005)(316002)(7636003)(82310400003)(6666004)(4744005)(336012)(8936002)(86362001)(2616005)(26005)(426003)(70206006)(186003)(4326008)(7696005)(921005)(36860700001)(2906002)(70586007)(5660300002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 09:28:42.8767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 394042a3-0476-40ea-6885-08d9ad9a79d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3358
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enable TEGRA_GPC_DMA in defconfig for Tegra186 and Tegra196 gpc
dma controller driver

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 156d96a..6616148 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -928,6 +928,7 @@ CONFIG_MV_XOR=y
 CONFIG_MV_XOR_V2=y
 CONFIG_OWL_DMA=y
 CONFIG_PL330_DMA=y
+CONFIG_TEGRA186_GPC_DMA=m
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_TEGRA210_ADMA=m
 CONFIG_QCOM_BAM_DMA=y
-- 
2.7.4

