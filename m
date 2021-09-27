Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8472441989D
	for <lists+dmaengine@lfdr.de>; Mon, 27 Sep 2021 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhI0QNh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Sep 2021 12:13:37 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:24328
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235444AbhI0QN2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Sep 2021 12:13:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1H0ixQ5dGoP7dXkgQglIlpz3tRJ/8+xzpq+RqQnvyCmavijkB+vN52t7hLjDPzRkgbX48fC0eCUcDCcXkctJqnDOe575AqcxSi3/O/yfvymm5Tfgup7IOEAFuRgJQZYyQeEoo1An3MdP2qRGQW4136ccBOV9G7/Xw+Bl5AAJZDDTD5fGzzoUUdiq7q/32R3GXMx1IWU4kCD/Wl82wieTgLCm819zyhdG4ocIXw1aLa6W1gE12KYDQVTMv8sRj1VGfKF9blfaf8uiWfTakB6qhIGXAnx6b+VzS6h2vpnwCw3pZJ4o+OVvXJAsRDny96b2KJKnHj25o/zHi4ln1MN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LMk5MyATrD65r36BMMEUKF9z+V7PrTbVXxSgEyhBJWg=;
 b=E6uzapkZekug2bWs8SqqNZupn3T210sO+Ds62xmK6qc1Z6FioVm967uPJiPa0aRc1LGqL9ORIxV6F+RlnWGG34rxDavN22qRDXUTlmatCTI/jk4pFtJF8EFr25wAxlX/ysaslX/C4dq8rycgJcxrhqi7LeVuyteyqVkW3/wC0tnjvkb/YVyG4l693nopkC0IiOOH6J904PYoeBKLkzYkCXjW/Pll18s1ynDOR+le5k0hu5JOKh9pkVnzVZ+nfLWB0dnszjJIeLXia/zOaGGQRKf/Pqua1UDLgCThJgqM9K+fawj7CTx+9t8NQN2nZSaXo6vpmCnukmZPylSJj0905A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMk5MyATrD65r36BMMEUKF9z+V7PrTbVXxSgEyhBJWg=;
 b=jgQtig4jGH5bUYOwrWfMLe5Jd1zMqxzufdgngwHk20I0+MA1lTeL3r+0En62mXIrIYbJPCoskL5Me0nwLi+swihY4Ny4ey3qG7NsgzBsnIcuHK7sMdcgklIV70F9BSh4vWuuBZ50ieyTgsGbBBE7r9X2IqDjnId1Y9lgFsUMuoeIhLzSjFHrXhJCOqaCopX1THUWQeWYrV1eZYDq8tmiArHBpvFWZbgJOviUhsPNu4zzMttkj7vq2CnhnHo4jDxIVRg0aMEM0Zbcca5sc3ITAVOPIvGZggvw6qXogEZtebx2aZlnW21dHyARhA6rZWip9tlvSBfUgcnT8rhEVY264g==
Received: from DM3PR08CA0010.namprd08.prod.outlook.com (2603:10b6:0:52::20) by
 DM5PR12MB2501.namprd12.prod.outlook.com (2603:10b6:4:b4::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Mon, 27 Sep 2021 16:11:49 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::5a) by DM3PR08CA0010.outlook.office365.com
 (2603:10b6:0:52::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Mon, 27 Sep 2021 16:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 16:11:48 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 27 Sep
 2021 09:11:48 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 27 Sep
 2021 16:11:48 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 27 Sep 2021 16:11:45 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v8 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Mon, 27 Sep 2021 21:41:29 +0530
Message-ID: <1632759090-7965-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632759090-7965-1-git-send-email-akhilrajeev@nvidia.com>
References: <1632759090-7965-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a001afb-d1a7-4aac-13fe-08d981d182b3
X-MS-TrafficTypeDiagnostic: DM5PR12MB2501:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25019E95F52F5710B88AFBF8C0A79@DM5PR12MB2501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3wFAmcijB5OzV3yc425vylyKt0vvprTsCrTEzxKTx97EK0LQSLfeYf2f5flUtSHkrMW7is2aJ13oe1TXEfBZ2WYpp+ZI8V6YSfn8IoiR3UzrnowykaqmjY3kKIjLzJoiCqOs1CiBa76wXtWHjk/D9wyI6hYuqUvmvUMXwKHjFtRRg5wqugcTJHOQOKHLWTuoIEwP3y0yo9t42+oYt0pSZOfkfYbfOLKeSXiiMcoHyZMPVDj+4bdVbIlzM2Pczy8J8R5ZnrscdWax740zuECsLPQGtbFrhb4m84GZShZyLbshji+j6Iks8NiNAUKdKS6CYqky2iEh9YfclI+mnZM2hg+eDYRLq1VIYqAmZLVt3gGUUrDLmch3lqCciEwv2slKDQagcGVK0/XMKeuXF0VBWckfkBulUlbUsncrdApz478rl6OTcHtg9xP6FWQeDpLiF/aMuWz3HFCqS6i+BOPejDmLj663RhjjVQr/rX06IJTB0ca5DMIrmsImk5OpojOLrQdckTnhXc3Z+F+Ij4EVn77c0uVXzQb+f86XJNJTTAKiz5kRJn1qE8crTc2M31K3sXd/RwCTwPc2p/iI91fmpjc/DyDnY/TnHS3wmYAjdc+PxDtdvbeSnYCOGyAxnFuyOqtdQFNR3Dmid726eig5oymwCTpJDDtILMtWn9j6xE/+9TpSRTVCXyC4d8jP07yoMCXEb9no24oF89cvvVhHA==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(336012)(36756003)(426003)(2906002)(70206006)(6666004)(70586007)(6200100001)(7049001)(186003)(316002)(8676002)(8936002)(4744005)(2616005)(6862004)(26005)(54906003)(356005)(47076005)(5660300002)(82310400003)(36860700001)(7696005)(508600001)(4326008)(37006003)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 16:11:48.9388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a001afb-d1a7-4aac-13fe-08d981d182b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2501
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

