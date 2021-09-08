Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9781D403BA2
	for <lists+dmaengine@lfdr.de>; Wed,  8 Sep 2021 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351945AbhIHOej (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Sep 2021 10:34:39 -0400
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com ([40.107.237.43]:44513
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351948AbhIHOei (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Sep 2021 10:34:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4AOu/cKNmm+DcE8zxtyVZjxT8rEUb8EB/hS/az4+HUOaDORdqTm0zDSD+M+3dBSJIk6L9Us7+h9x2UiSTyu5F/d/SdpAKgfJjrJv86rQ7t2oNV4UMpmNBrDaxKMKfG9WhjH1jpngqeOTuI9RvNjCZabIkbgOYPJNcEm5lAs/hVbKYaYaslZcOYJbbOQH84xJvPv2Snkfg2rhCo3rMPb8wlQxfbFQgXt+ofvZa1ZSjfMIEtLXZURzmkc5KqjJS1mIdOOYE8XtxQdv9DZCzfmKbX9xxUxURNQc8Y/BJg0Ank/nFxdEMaIqnV0yhE+f84lmqtYS870BGNjpV+Q+jZwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dggXnp4rP5XOSrutaP1FDYEHuOVsehh71Yq/Kt3X87I=;
 b=K5sl/wYXpiDavZNS2ti5OgXoNXUXmfl3iAlY17lHbnRR5DqDYb/o5ApM8xogR0SyTFlBKtT/04zQuUZKXDKt6czYQ1F28cMdE3SG8l1gxSAy/J/CBsCoNjpebeZ9wjpyLDARTFOkxcd8V0UHpLj0mfmfp/SxV3RGBosU91E2nzp5KCqB6tQJ97pU09Yb4qiHAwBna9zn33qr5M3YCrlHVzfa9qKmoO1Mbx2qLVmwG/bNfcgEbcR86/d0AjyUI1EWgYhnGZLyd14cnv9O5Ig6d++/SrZVabqOrrzcoXKxeqlucYgi/sdpPfs3iOL+aR/o7H25qyp13fC8Qo/ML6MhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dggXnp4rP5XOSrutaP1FDYEHuOVsehh71Yq/Kt3X87I=;
 b=DpcWIrCcnZlfHJyHtr2WarIuHCRCm6mq2UMNBGRi3eH/xYBIKYy81lhC0Uq98rLblMnRUhydHjolfFezGk9mDtKgcDVKmaOyj6ci5fFLtl97uQ8k9iPKidXHwYIuU7SKb7XVIH8JvmLTHpQ3El1mx7K5oNH3+kKIH6NUp6hBBM88wlvv5SK/gOrcW3uryxlUw0uMr6CIgpAD8+EIBvgqpO/s45zj/DxfB5+y4iDJgCxCd3miwVRgV9aZj3FPBg+T7P65DWuPy90+UGwbNzFwkFx1TTUUq3j2Hz48wJ4vjknHHdvyjoD8dDtGLQjRGF7kBXziys9ZTowYGoEhw0eg6Q==
Received: from MW4PR03CA0337.namprd03.prod.outlook.com (2603:10b6:303:dc::12)
 by BYAPR12MB3624.namprd12.prod.outlook.com (2603:10b6:a03:aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Wed, 8 Sep
 2021 14:33:29 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::34) by MW4PR03CA0337.outlook.office365.com
 (2603:10b6:303:dc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:33:28 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 14:33:27 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 14:33:24 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v4 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Wed, 8 Sep 2021 20:02:17 +0530
Message-ID: <1631111538-31467-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
References: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35fb0be1-f545-41c6-10b8-08d972d59ffc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3624:
X-Microsoft-Antispam-PRVS: <BYAPR12MB362434FB7C54FAEDB88C9C6BC0D49@BYAPR12MB3624.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bp1K4B3C5wllTcRRAO3uqnwK0PJiBeLqUT67nN7afmEbfJNBA6wHp18vvlsx1YojV3UhdW213vI4h/z79eez12ZYXaSHucKY0ZxXpFXkenEdXqPizd4q7sZVYaG2b5T/QP/3f0/WUoxFLYo04xRChp2xSxxdQOg5IeMISrLpyDb0Z3GxM2S9VYtThhae+OoMZ82C85xL9FuHFr7e1vhqEeLlHvvRqzUK8sq8u3Ojs2vV9RmqtSvDOwSswm32J6Fuf9w9bQLTQ0+mHmLbo2oYZhEzSZV5vd+/1msVw0HwNI0Sl44n6YM3LxgrMABsEb9ZLwpEbmgFABZKh13YIi5x0/iGU+IBjRXvmy2wGCVZBJmDzmGBvpDguL3QFx9lyTpzZ/jrtpvvGJ0vy7Z6uePXYCZ3tTDxmE6ogkpBZxkVWAVMrTT+q+snVO3czWZ0nGOrJZ4KREcNTwWkbxu+F1OXnGBOv9h0PJzYSa1a6ZTGc0aFhMcmbSctlpiPwQ5Z4ufHaGw2+C3wHB5ZnIlGA/Q4kaFQJ9ck9JgrPVSOMbs/ohcRIib2dW3B/ZCnUaJVTKmtwOfLrNLCaZg9Hm0R6dDSNPDcYlPI/U3/Btd499OwFwpwPq1lxgNWmf9c5XIiPvgm/BAHOrMmdlvpxNGdUB6sSAJBXera6fHxr0YtHFeqAhH+WfZHcp55viSSdW4LU404V8MmxQA1BZchQF0MVUnVw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(6862004)(186003)(6200100001)(478600001)(5660300002)(37006003)(8676002)(54906003)(82740400003)(36906005)(82310400003)(356005)(26005)(316002)(2906002)(7636003)(6666004)(36860700001)(8936002)(4744005)(7049001)(70206006)(2616005)(426003)(70586007)(47076005)(7696005)(86362001)(36756003)(336012)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:33:28.6233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fb0be1-f545-41c6-10b8-08d972d59ffc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3624
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
index f423d08..54770c8 100644
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

