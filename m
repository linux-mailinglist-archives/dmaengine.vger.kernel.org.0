Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F644AF9A
	for <lists+dmaengine@lfdr.de>; Tue,  9 Nov 2021 15:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhKIOji (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Nov 2021 09:39:38 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:14736
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232237AbhKIOjg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Nov 2021 09:39:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZzUqzkAO6Nn55TDqMSeLCgOnfr3glZrrMNA4Cllde3/m79/pCCl2aCUsaK2bALiIohKSmhvgs4Uc4lp3bBHXLIfXsyEe4ZUcCVtU1yjInHU9Q0rlJMGHy1w4/KkeSutNDD3iAnhhCoSH5NDnXozh81Vv/aHCJLXqZ0XSyjUh0jPa07ae8I3x7FRxHbCF49FpJ/hLGc7sFe+PT0bTv4SDSExBNvUzTYZsEvvtmjTnhFf4bZ66Hdy7elRKTZUrrNk+tkgC826mYVBmFUqDcRYKHYCb3UYdEH1kCWHHQRFuPATIIH1Oun3zgS2A0LfJQdy0iuZRMXo1ynFpuykXQYD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCc4HZxmQxbFhMHaLCwO8Bw7VvYoKYE46xxG49EPdYU=;
 b=aFNs4oSPribYNnQBsnbmeUMCw6GffvvwEkd4Q9SUVEMxB7LZydPrMLu0wowaZuhZSZh1HPdtkQ45EkTriaS6USsL1323eMO6uf4LQcrNV7rehlv0PGLCzox/OZPrLjRUYP+sz8lxwwCmnbAfd7uxxxJJmSiJB9k2KVRS8VBzzt1jQaqi342P4u3yNpefFtjgvgH2W6AnUfQusV7FT7ZaE/O+TayPzmWxTi2VVoSXwQ69YKvgNZvh7/yf9lAJ2AcO30SNytQaOlcR1hhUNf5/NC+m6t0yOuWQfYasKWi6cLPZ1vZR0yxlxTEYm90z5bZcGD1B+mPTNuAWXTmK+enSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCc4HZxmQxbFhMHaLCwO8Bw7VvYoKYE46xxG49EPdYU=;
 b=FtmcTQtUAWIVOD3bnQSYGUpZSRg3b0Umrf9poXQ3xr0LW9wfl9C7sa9utwSL82EVJpTJ7hIAc8B5MbQYDucjl6Cn91mlktZqxv3QNjPCNvAH1JLNcUn9Zy61P3dWXYrUsGE0IhsKuTnQDhMk0bjRTeBsrbyAma2MwXpo94ds4S2AujqJOfl0W8tpN7wBCAkq2gicRs/5znT3dX+tDhHM8V31Jad81DVJYa1ut752Qx5Y5l67m6gSzX35peB8p6NxeUGy1kGCewSpX7y9kCuLMFV4JOIrvkdhC//pAQl6XtsZAW0xFkPVwq/lv+y0UNeC7AOpjYL7Km4tViAum9qW3Q==
Received: from MW2PR2101CA0005.namprd21.prod.outlook.com (2603:10b6:302:1::18)
 by DM5PR1201MB0249.namprd12.prod.outlook.com (2603:10b6:4:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 14:36:48 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::ef) by MW2PR2101CA0005.outlook.office365.com
 (2603:10b6:302:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.5 via Frontend
 Transport; Tue, 9 Nov 2021 14:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 14:36:47 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 9 Nov
 2021 14:36:45 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 9 Nov 2021 14:36:40 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v12 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Tue, 9 Nov 2021 20:05:51 +0530
Message-ID: <1636468552-1120-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636468552-1120-1-git-send-email-akhilrajeev@nvidia.com>
References: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
 <1636468552-1120-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31219366-c0d6-4efd-d967-08d9a38e5c66
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0249:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02490D2B9E5B39A92565A4B7C0929@DM5PR1201MB0249.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VjZnNQo8gFj9UH1XsbgSCfCqf8w7vju1ylrlxofrMMcK6xaXUS5DTTYMlNsa38+1x8GAQR5yDJU/2S5WjTnIJKqSjpXk77/dD7tdxOQwjoV08S9VGGHnAMtayhZ25eNS7nYlvLP8FyhDtnsIm6mRNsuHmxoAWE+plKVMB9Y/TvK8JOWeYV/grZcjrq3qPnKle1Xd2gGdtUGXSpME/H7ihjxgkgZ95eBi9w1Jz0wfv6HjjehQZc/yMixQY0rC+qJb8JX9zkq36qAXMct+SCxSrHTOxTyvcG0D39KKVzvet6wmmP3okGT04BvWEFVn7/9fvXREH8CjAjfF5HWNHih/rGpuJ21DKRqufssNDQPbemiW3V5mxLQ6O2MALPe/yBA5YnH30g1H2hJzCrjIEmzr8T55IFOUIzezW7NEYS7rkJMeT3QYhM8HBYV0uEoGffx99bvYZuu7STEO1k2gsUZoQwLKcanlU5hF8gK7gTdvgxQl6k/uY0AqyfuLSE+h3Yx0aAJjcPtrhIyI3Mmk6i+bxZ6OuJ/MUcurj842pSk3DX8JyIcpnk/O4jHQ+UWINx7vdav4wfjSF7ryUkALmGoPwajdVvivlF/RDDnds6XjY2jFnixE0cGd9jSHsyfnXy4MitCboGU1oI9vf0TGWrO6Lw7v3X9nAKY+FxFg6Jrkmibxsub/rhVQow2Jl2ppNo0/EuwuAmC2uP3qWh/L+3ZkQ==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(4744005)(36756003)(8676002)(7049001)(36906005)(54906003)(336012)(316002)(8936002)(82310400003)(186003)(6666004)(2906002)(70206006)(70586007)(4326008)(37006003)(5660300002)(2616005)(26005)(508600001)(7696005)(356005)(36860700001)(47076005)(426003)(6862004)(6200100001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 14:36:47.9514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31219366-c0d6-4efd-d967-08d9a38e5c66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0249
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

