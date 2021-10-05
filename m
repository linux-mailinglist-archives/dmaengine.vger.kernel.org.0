Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD2422731
	for <lists+dmaengine@lfdr.de>; Tue,  5 Oct 2021 14:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhJEM6H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Oct 2021 08:58:07 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:13153
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234912AbhJEM55 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Oct 2021 08:57:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbQinLnmsDeTJOztoPNUk7IIUp/6063Iuo983kthskDJKjMe1thDSgoo8zQWml9FjS5LPv6ZpM+/sNEkGsn4rYGNNwS4zprkpTqpaNfUCUVhszCNVtg6h8E++vra2uPdLDF3o0S9ealAcwDfBfc+eSN/p8+ETQ90rjWJl2tOyLcvjyPjR5wc1QQwoVk0tGvwCtaDzRxOAZ0e1LnpOMgy9OgApv5cYhb889F3VpTRdMm7WYVwvW0/g4gjuwAWwP8ITP5cumZbX+9WJU/sZyjtqX+UeZATHcG/PDPPrjOuJqZXX/ndWfQGVXiPJyX6ABtit9FTNjU8vOYpS7/aU+11bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnYIclwqEXfg9ZSNNrUQxfRoxq2PYmME00FC+N1Taeo=;
 b=SMLiNhKoVX4QbpAoP2QErHoQvBsBj3JqtC5AlVeKYdptMcGiJ/fulO0d8XK3DNMhJwSeZiH5NP+6x0McMYBJ+NCeK91josbQ8to0HEnKdF1MAYWaocW6o4G9XAxcOMH/XRxC+O0jJqEJpOA1a9PXjQ7WoyENGp0OTpMVJPALe88DFKuolcuOYq184LLTWTrlVQGC7xgwnoaiT9F9Q5bOcvxfvrs5075zAS08wEs1gP08i8L9eKkC3bZa0jo9xwZYOvvV9iDx+HTePam+/6jqOE5m1havam2/X8iKoUjiyByNoNy6ensYi67h1o5nXpfx8B3ZYktYBf0IWgUMq5YlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnYIclwqEXfg9ZSNNrUQxfRoxq2PYmME00FC+N1Taeo=;
 b=C6STXwScJIA0HFBVYeFzw6+y0dr+GoMIqC5Npujr7Dfc/4eY5wlHXThKxH0lKgAFe5SCkuFL4AdpiAAYV56IwzBa2SWGc/znibitBxRkz678qLFqg4iEmHRFEYPjcykc274kDq2CwdlVoIcsdU49xkUBMicD4vGICDCHYydesJDQSGLMIQNxStY/LEDyIIAn4seiIXprNsoLZXhX417EmB5wzYNjyt6ExO+1AgAjpf6JqxExs19OQPdoW4A/ZDmtDhTWVtINCbXFU1N/rP/TrUdxkEEavo869hc9q2TptxpLipLnjam1qRNJ6cqG7Cwd/mmYNCSLqsQrT4OV6a8V9w==
Received: from DM6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:5:15b::29)
 by BN6PR1201MB2514.namprd12.prod.outlook.com (2603:10b6:404:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 12:56:05 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::21) by DM6PR18CA0016.outlook.office365.com
 (2603:10b6:5:15b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Tue, 5 Oct 2021 12:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 12:56:04 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 05:56:00 -0700
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 5 Oct 2021 12:55:57 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <jonathanh@nvidia.com>
CC:     <akhilrajeev@nvidia.com>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v9 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Tue, 5 Oct 2021 18:25:35 +0530
Message-ID: <1633438536-11399-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633438536-11399-1-git-send-email-akhilrajeev@nvidia.com>
References: <1633438536-11399-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 784ab8e1-3f0f-48fa-55ae-08d987ff7ddd
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2514:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB251450BFD7459B5E4F780215C0AF9@BN6PR1201MB2514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KrafZQH48mAzFYX4qTWDykxBHTH2OMd8zzp5q6hvyqDcSiBL9p5C8PJoENZMMtYP6ODAemIkwoxT0Nu4iFIuwolcoTWWlarOT4UVv0y+yI1oC62ABBurWoJHn60x/qn+Q2WlhkYr0BwClFcV2bAWWDJvZJVGJ/1ju7gr1l3o7enI4HwXAMZO2oUXatEykBVgogPh6L+1MU+upui/qzxyO118xjdI9jJmacAVB8s2r+QZMYMblEkkS0356yKVMygW4HgMN+rrxPNkOtOCdMpNheghTRuhhlQRlGgnsCr8K7Ox9BvcOu7Vh/KlO/YUcNwsIwSvJXUMv0Bgcblv+sthiZuV3H7ZQVUbK4iDjBS4r5yTvUcASdeVUnStx9zVY2s3YWo+4R5IDcZTLtwOFlMkKVF4UyVY2kwDSM7+inya5s9iokCM7ec/zU27OuZNI5xBKRZzLEypIbV1D2E69NNxVULHCib9fE1B1CIcVVyLJBrmRmx6dJsnPqTOr4460+Vh9zSGaSrmpAhs6VG9o7r9EckwAHEJvqI8pu51iMkdOkcFPyMuu9hzueHaCmwptcuFEXH4/+zIU7e+20ON/gCQnOanXMsq+mXf3OBjhyxMv8TSPmMXPULK+1ClyZ321OaMIMvRjVQ6SnJBqoGbmfgUMANQqi9jc1Y5RhKAwMIJhDFGU26T8uknIuJnC+ZDK6GdDGHoSSaCfSd/KADX3B4GA==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(86362001)(70586007)(36860700001)(7696005)(70206006)(2616005)(6862004)(4326008)(47076005)(508600001)(426003)(82310400003)(356005)(26005)(6636002)(336012)(37006003)(8936002)(4744005)(36756003)(8676002)(316002)(6666004)(7636003)(186003)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 12:56:04.6574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 784ab8e1-3f0f-48fa-55ae-08d987ff7ddd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2514
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
index 156d96a..06a6737 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -930,6 +930,7 @@ CONFIG_OWL_DMA=y
 CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_TEGRA210_ADMA=m
+CONFIG_TEGRA186_GPC_DMA=m
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_QCOM_HIDMA_MGMT=y
 CONFIG_QCOM_HIDMA=y
-- 
2.7.4

