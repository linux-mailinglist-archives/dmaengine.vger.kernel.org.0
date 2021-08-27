Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DD23F9448
	for <lists+dmaengine@lfdr.de>; Fri, 27 Aug 2021 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244234AbhH0GGU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Aug 2021 02:06:20 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:52288
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234948AbhH0GGT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Aug 2021 02:06:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxovEDw0Pp2KgcyZpiny2kZigBRq6h8tAMltRbhWxGLLFH6b2AZYrYJn5NdT3AEgt4pfZSlYblcgNTvrWbuKQxVec56tpgyHvuqEhCsGB+BP/iD/qzZzBuKxPTMtglKQWCkegm5FZzrgTd7cQhWLBwdqJZIJ3Tud8Eq+i7ejYy87+9eiKOOkqrHtKWnmDqhiYQP3uklPDUkbctDfXggEaeWwAts04q+C6sYXVcKEiez4Dpz9k8Db2fhnC3X+XB6bvjaKUSdFXhx5GRKihqlZTjkWJgV2BpLCaUWwtAQ+zXZo8uZrANsE692hPSblLDosN7vnoNkkmfaJxjmki+5e8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9drskmvOcWhcZxQIEyGpKONhNetIXdDdicG9c3Dh/c=;
 b=KGaBEINrKl2yBe4yeuRSaQ9w5nfVAxg5LZ2EZQK9LvWPZ3tGz/HHRx02+2saq8EJpAEk+b2i64xGDDVr2D00nDtfzbAckOx+74dfjwwES3Sm5CdXlWwlYf0JT5Im60FT9Os/W8Sg2wJd9+ju62bd5GTbYsitA1ykQvbEDeHpp78ct5OpGC5XRXe9drHCJfAo1uDGKefD/DI3Y5rXRODceP8CFLt65ZhLbdxjOSB2fcV6TC6mxdPv+1/bBpt2jE9D0ERyoR2UP4itUlhRX6Nf0NDMpZhOI0+UAwSShYOK1jbA/TKkJIKP3gMkzoW+roTBgBUEnQPOFBGeBAq/SHudOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9drskmvOcWhcZxQIEyGpKONhNetIXdDdicG9c3Dh/c=;
 b=iBN+WpCKx3VgjNi1gIYPLh21J1fae9eAT4+KKoI6RatcGg8YNO8IV7ReVCuYea7t+3AAZqaEtGE4sQu+k0VxYXstIOVQHscLk7RVcr7n4rtF+WbXKfVuDmixpbQ0gb0wxbgn64WdeuKFgG3btcIdaSyLn/c8YWGPVQs/vlltwAk9EiOq647nc5wpCyCA+xGnXG13ZO8YOWn6tHU3Q1j70nnR7rK7o4w4vze1L1W8HTzaic+b8g5RBPzALKDAlZ9ZBFhRNoGCOgVoaQpJRVtgKyIoxBSymlmW39tJ9usgTt+F7X6UhTs5ahDvCgURe1VrpxkJgLuxiIvMljWBs0F5Cg==
Received: from BN9PR03CA0254.namprd03.prod.outlook.com (2603:10b6:408:ff::19)
 by BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 06:05:29 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::b7) by BN9PR03CA0254.outlook.office365.com
 (2603:10b6:408:ff::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 27 Aug 2021 06:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 06:05:28 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Aug
 2021 06:05:28 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Aug 2021 06:05:24 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <rgumasta@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Fri, 27 Aug 2021 11:34:53 +0530
Message-ID: <1630044294-21169-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
References: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
 <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 749339f8-3b9d-4b97-a9b6-08d96920abd3
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4758F438AB446D07CC47D4C1C0C89@BYAPR12MB4758.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uyvrqg3tpZmo/Yagfj5THdGHacHfbVMOvFxsGSOmgxUWUyQNYKJtcMeIwSvwQ0M21p7PiGBL5owfsSlNf0TblIcn5IVeePWS1/gJ+44nYkXlEwPKX2YNZUdKhQ2gLlTiqRzhc2S27N5bw/cQOHWUravgTBbuYCvrKbohSek9NLWz09pT39JSLn6SC+LkL750SrwOSWSqTJdEjPL6R2ee2HJL/rWFWMKUIiJsLH+6sXIqq+7UgStEN3S+wSyBBdogrFVZQRvniDrfvWLalfrgDCC2LDBwPRG28p1qGmOW43yJCUFouR5/O28BwQpqFPHLsYMtf5wtTDEBg7pLer2vhMCZgUYQcIwz08LG9oPUiwodVQwWqNbmFlIzbeMgSuV/5UsU9RQrrDQjZO02AFChRAChonP1m2Py/ZC0Okz+Oeg0sz1ME4Key39G0NW3ma45WeegBkvjGNcb5u05meitw9pQ12Ez0CNaqH/U3q/KjtWlup7wWfiYrUBk/+aiYMkVN6mk5nvwlht5O+ENcafdQPDOcSk9ofUgwsj86+Yj4YZ1sM0sE3Nzz92Jd3wwM8F+Nb5EkAHx6YJf4YOisjcuBiUObv77z+edDily4rcF2h66pgbFPIqXhS931VzWas3gwT/+rSE1/gZoqllwkgmjw/e28NDBRfMQj19l5o5h+hvxfbhpxW+asrRSidWW0D1GkaWAqq0nSGDfR+mBJ+ci8w==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(107886003)(86362001)(356005)(186003)(8676002)(36906005)(6862004)(4744005)(82310400003)(54906003)(26005)(6636002)(5660300002)(36860700001)(2906002)(70586007)(37006003)(4326008)(2616005)(70206006)(47076005)(478600001)(316002)(36756003)(82740400003)(7636003)(7696005)(336012)(6666004)(8936002)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 06:05:28.9992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 749339f8-3b9d-4b97-a9b6-08d96920abd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4758
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enable TEGRA_GPC_DMA in defconfig for Tegra186 and Tegra196 gpc
dma controller driver

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f423d08..d247a7e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -930,6 +930,7 @@ CONFIG_OWL_DMA=y
 CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_TEGRA210_ADMA=m
+CONFIG_TEGRA_GPC_DMA=m
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_QCOM_HIDMA_MGMT=y
 CONFIG_QCOM_HIDMA=y
-- 
2.7.4

