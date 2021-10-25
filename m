Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2487D439BDB
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 18:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhJYQnx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 12:43:53 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:20352
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234061AbhJYQnw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 12:43:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuXBvHChNQ48wi/1KFe4GXWNpdjyTnZUx4+09rP1m4GPiiFRDrBDoqEaLpviXo6BRw+osVOW3bj7GITa7DaHaXGVzWQMK0GA3ey59xedDIksEQZ+kiMGasS4KVwlWZmeVuScsj/clULaEVYZbWm8S9jkhAQdBSNoiYe+wqofp6N0rz0OAR9Prjiwt5gw03QHl6kDiTOk2OchBtTgNdhyMdRwcrhOZVhEnROUZmqCYEJcNLIYvimxnpK4SLJHT66MZsjd0HpIsdU+HXSrlRdU1Gt6hri1qtIBPxghT3GhyB/U0mv26FMQDXYVa/W4d8kMTo8/uPvxAbQ3gbMITcXjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCc4HZxmQxbFhMHaLCwO8Bw7VvYoKYE46xxG49EPdYU=;
 b=lvfiRLygacv2LB9vrYPfEVXWN9ePWyd9rYUKcZgctXkoYhdc/MsHnh06tbyBUeoSSyTGos0m5BtNSfW8/UwG9SpZCbtiIdEbRDaj3nUbiQz5eweugD24INkX8uMYqhN04NxhVv/JOGrefbNk7rOCq8guWk7OWTgt4maOsPjqD7BskgkWPTYNgruvnZxUHVwPggSd6qVPEqQvYXHK5/UqCmbQtik47jkJsVM7FGc7y+oJ4lhAH1d4FVlwEGBbPA098lToLMYbZ8ggFltTksxngE4qDKLKRJ3G0Oyr56gp7DBakSTiBAdKDQilT9gu6rsEd/LXDnGvA4gRk4UQ4VO/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCc4HZxmQxbFhMHaLCwO8Bw7VvYoKYE46xxG49EPdYU=;
 b=LBxLxG1qRhyDFz1w5Cflzxgv/1EoxjCrXQbbcps5HJmPY41ehKeb9YA2lHBhr/egPh+m01Fn19z9pYwa3hT8CODkOsqYuLR5q7PbTmbunkfGpzvAC/h6f+ekFxMRa4oI6gSunJJNF0WTSqn+YhCwx25AmZTwgDWWg5gfIq731D5KUzPADdfZVNkEwbn7fCdat+qP0b9O7rlce8hKVqqDT6I0QuoBbyLjFYNby50bpCjGb3Yus4rXAV6XU9B1sh/YvNOcN2Rai0u8e2M7AprSSHjzlk8OuG5Cp7cEG8j2we/NCyimLGBFHO1Iy9B+8oZBNybr4FsTKDYhG2Qbxesmew==
Received: from MWHPR12CA0050.namprd12.prod.outlook.com (2603:10b6:300:103::12)
 by CH2PR12MB3973.namprd12.prod.outlook.com (2603:10b6:610:2c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 16:41:24 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::b6) by MWHPR12CA0050.outlook.office365.com
 (2603:10b6:300:103::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 16:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 16:41:23 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct
 2021 16:41:21 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 25 Oct 2021 09:41:18 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v10 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Mon, 25 Oct 2021 22:10:45 +0530
Message-ID: <1635180046-15276-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635180046-15276-1-git-send-email-akhilrajeev@nvidia.com>
References: <1635180046-15276-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4029ad89-f1a5-4b3b-4b67-08d997d64831
X-MS-TrafficTypeDiagnostic: CH2PR12MB3973:
X-Microsoft-Antispam-PRVS: <CH2PR12MB397383A5E596E7B55EC3C504C0839@CH2PR12MB3973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxxjbMWLgqD/f/Ykb95aoW5LiJsiU3QI8TDTnzg4aFFyHk96yOc4h1STUcmEGWOTbHTE32f/DDUe2D1tU4Cv7upeE8f4QJKMI4TCK5xeAPScJuHUHdbajhBYczn9JxGWXpOZBbKAhwd7O84h50aKRLEc9sDSPZAJDC+Lf6n+613YcMiOflvHhVrO02s4S9583YwLldhSEX0N9g8RQpSi7Q9Cv1OJMrmPSk4K5T6URCqQYAFBntFCzj31npfvJokAJVgwY8Je6liwIh79p0iPUDVtAmzIzY18Ps4TefZaOseY6Jpbz0xW3Ch9fJ/ABeKHB27J+SmWYksOdYFrPQIYmRNw2WD6Wu5oEi8iK2XZ+H34/aaAN3rydFk6XUViywqQDEewgtBatjNfUXDTnX9h+x4ydAd2Y1Mb1szLkxBycAopytQrZkl6YjUpVgXfrGcbYM1sa1Lldgw41ii1ABo3nkKbS3dnLC9xYy+8R8l5ASpcsptXVkv6wUh8iA/G+QL0VOj3jczf1qk2mNoNiUywqVib5wbZA2QdmAFoYTSQx8M0UpE99Y1O9Tw8dQXBatkO2hURYx34PsqZNsf39Lr1zOAkiKtZ7ceIC2UDH+p3lh9KMEC8OxXWQgdh6WFRIZtOaTq8C+4akbStrKjrET2uHt/9pHeRK2oMAfEMDRS56doaObvZoLkBsK32Kisl9Oyawjf+BPxBg8gX2C80LMQQvg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(8676002)(70586007)(508600001)(82310400003)(4326008)(186003)(54906003)(356005)(7696005)(6200100001)(6862004)(5660300002)(2906002)(316002)(336012)(36756003)(36906005)(36860700001)(37006003)(426003)(2616005)(86362001)(47076005)(4744005)(7636003)(26005)(6666004)(8936002)(7049001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:41:23.8492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4029ad89-f1a5-4b3b-4b67-08d997d64831
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3973
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

