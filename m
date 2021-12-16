Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD5F477A21
	for <lists+dmaengine@lfdr.de>; Thu, 16 Dec 2021 18:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbhLPRNV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Dec 2021 12:13:21 -0500
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com ([40.107.93.66]:48993
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239821AbhLPRNT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Dec 2021 12:13:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3TZ7fsLb20wRn1XZ1EjtjHAV/PDSSiPymjNbw5qnaQ4otr0DNnDZjftr/GIqxSZLYZ0caxQ5drgzqhOGc6l8MFIBIUyce7uQNYPzzC2w2DDdOc3Ex4najIjHd2fX3MUUTwET6tmG0nO01KlnoaZzo+y/8/Jlme/i/50R4+nBUjXanM/RjY799tsG4rg4dyxkRubc9CFdfconWByYHXVFM4yAgsdhkg5Js60CgUXHR8Kva5cQFTopA0XOWuEOWaj+v9GCAEZzAS4RXvm/kv0Sa5E3lfoVkdvNrVsI+JD0OUq+c8zi3XlcjvnOWUDAFB+xgzp3jyXfDIyllVeLJ6RUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4xw/PCtLXlKUEyjXlGQmjvK68YhescVKqZ3RHEVAQs=;
 b=jb7dhKzzmMjI1t+p23DFOVlO75RHi6cB43ILOmwOHZpxkvGOiDe5lgBnDyM//eHqoWkHLzihtk/SImVLUts2mRn/bQ3TapJK2aSaGS9uqCADG/6Qi47h5BZiImhzmOrgrEB43c7U3AVHRIGoCLBun744shkYNACbaqi9did5PnEiUkijS4Ev1ZA+PEYSW+jNw6E8jDlgGiLrqdk2H9/34+INhCgqvGpfHo3Q1QIJCnZshAerB4vcffzyV7wQXhYEf6aZabe8gp0LUwewljwkZdgxVpkp+DVg5Uv5/XQC5HslkcyYwlvQ06uBrckrB2YkcKKznuCcc+PpTcpaB0DQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4xw/PCtLXlKUEyjXlGQmjvK68YhescVKqZ3RHEVAQs=;
 b=LOtZdFSFsk7DT6qO7np17+k5qaECMeJkokJVynm8bpGUs8JqUbCwlBxfzKYENGFDvI3JhMydxVZ+qTjudMeU7sacjMXM3CTsQO4UZZ6KJvfDhIL0oKst5hHlrUu431Xa2N6ATeX3vbL0QaRZqcsBWeR2QJc+lysaxI6749+TJA9b7fjPv8NzicSyoQJubacic8UmXnXoCHKP3xU+rqowWQfUvRx+Vp28Q2TS+6/XpXsqDleOnIjrxfTv8GNG4M1d+fcvKd9pNSMf+MsAabt0khKDdJ7zx4F79QynwA+w5zVkX/uDqbWMThtS6wHOug1x0zb1I2DutpuYGq/Ov/p1Nw==
Received: from BN9PR03CA0539.namprd03.prod.outlook.com (2603:10b6:408:131::34)
 by CY4PR1201MB0104.namprd12.prod.outlook.com (2603:10b6:910:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 17:13:17 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::de) by BN9PR03CA0539.outlook.office365.com
 (2603:10b6:408:131::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 17:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:13:16 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 17:12:50 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 17:12:50 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 16 Dec 2021 17:12:46 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v15 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Thu, 16 Dec 2021 22:41:59 +0530
Message-ID: <1639674720-18930-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639674720-18930-1-git-send-email-akhilrajeev@nvidia.com>
References: <1639674720-18930-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e424a89-0db2-4c1d-4227-08d9c0b75a07
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0104:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0104B2C36ED3008D924F5AA6C0779@CY4PR1201MB0104.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mMGZcuxQ7ure/dCsl3WNFPx8uaMrLstxA6T3s/ctt6xaXf+aZaxW8hAe1SeU1tWRb59xRbrFLc1tn5WwXfIy6NNB06e86W6mRJInLcETh/1dHyv/PBZcEmJuS3YOjtlcuGL8VQkLgvfNDpGPo3V/UNEmhRas8zqv02IudrTcbVNjR/X040dZkwaCGHn1uZmXrGjSKwOvhPkQR2x4tJiFfuz8x5MQQlBSnvolglEI+9ZkrJSY9cf/BcwysEl/VM0uMTZn7Fe8N1uOg9sHTfq5HUD7Asqa/NFDexdJkDe3IaMd8noXAYo21vhanYsNhzLS9gpVTI1ujxClb10DrlIEsI4GdMfSci4tPXnn1CyJq7gCE9U7qXFHx8yJv8QrTg4+c8SKVdtQojDa5LQcFuYtDLhrXInGr4clkt3dlu3jBxOvSUvVjvMyQMgnboJ5F5ieVdqd+C5MWHFson9Dmv2VrbvNZC0cxqNo6AOO7Ni57Jm+OsfiKPJsogDy+rV+SJYQsA6QVlTkFgEuAAJZubLpXRWQBusdYLoehPL5+oqufW7aln4IaUnCuFz5etUQuXkYIlEVUZMAVVlXIjcgw9Qt3XKCk9FzhNhTyPzJK47Rs9AvqXZUhM9iObAurfzI5aAYzEqASJvI3SzcAZjRltXJsQLxxTKEhhDQbkQXpGCZe5TrlpNisldzkl7YSDrF1PJVa1i/i29bxwmhHmAmTo+uGcWeUk/82Ijw4Cjt8gdgcLmFkkD9O8PK9/+ryDCovGwN8SQw3qYPO43TPf8qDVckgffcouwecu2o6xpNX+gW5zMk3mEK76qqP60huzUfCHHsUFc8kgT+X4ZldSwip8FhDzqBb/i6MHUx3M2+3DYHd1a3Mu7HJZizmCSJBSjVtT+SOjqTH0Nup/smR2J2Dzc0A==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(8936002)(2906002)(508600001)(81166007)(36860700001)(36756003)(356005)(70586007)(47076005)(4744005)(921005)(34020700004)(5660300002)(82310400004)(8676002)(86362001)(6666004)(40460700001)(26005)(426003)(4326008)(107886003)(336012)(186003)(2616005)(110136005)(70206006)(7696005)(316002)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:13:16.9892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e424a89-0db2-4c1d-4227-08d9c0b75a07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0104
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
index 382c327..bb06aac 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -944,6 +944,7 @@ CONFIG_MV_XOR=y
 CONFIG_MV_XOR_V2=y
 CONFIG_OWL_DMA=y
 CONFIG_PL330_DMA=y
+CONFIG_TEGRA186_GPC_DMA=m
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_TEGRA210_ADMA=m
 CONFIG_QCOM_BAM_DMA=y
-- 
2.7.4

