Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8566B43E22D
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 15:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhJ1Nae (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 09:30:34 -0400
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:59105
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230437AbhJ1Nad (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 Oct 2021 09:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAFBkOTfncnJy5Aq6+ksnrrV5S+LMoPupsRc2RcZOflKP4BT8JZMHuMPMF3+lPwCMqJrS0WXY+68rObGZ3wHAgaV0B8JZxbmyJypTTo+SjSnAJ4XnxV1dvuqfAFUjEMUYDXfk0rsWIZ+OKyMPhjxlC1NnoJqYVIh6O8OceP0so0mJNjaOe9DUDhyGYfXe7J9Aq5++iaTb08GRbppUc78sBG0fYzi3nNZom+rEC6M/OIGjPn+D/ZpbrwlF/aua5Negu6z9aL3QaMjF2swhE5HDNz+S6Fj+Rbe/Mri916DginYknmb/FZZ9G6J93i1W/M6D5rEhKuMoic2nJdE5iOw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCc4HZxmQxbFhMHaLCwO8Bw7VvYoKYE46xxG49EPdYU=;
 b=mP4Uk9xaFfU+DcRseFpztr262AqeV16ScUfUN4/m1Xg/uJ8AygkYxs2ZYznDXr3CWSPJ2+l1OmTa+iILvfpF11Gzg9s3pni0oG++7Ygl513ciua8mPhnHM/gwZlCX2PCXmeAESgL4Ba0bbXjGvxXYxO2HSDpLlzSg9CmIMqvOWDrXA0KEJOJb9c+JIitcTeOq2X0ufflna71Y6WYRaKQCtZgabjy4aLimvdHwDIC61lHrgfgTOPtpQJVPpXCDgKoqdNYER0lYvv5h96vCgEUix/oBZHTux5neuZdHRb++bCqWCJ4sXFUNyx+Xtayy2UFhJVE8ROlH51TiUtIIE+4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCc4HZxmQxbFhMHaLCwO8Bw7VvYoKYE46xxG49EPdYU=;
 b=HKX1qjn4aTSq5pqvWM0lW3KtMwGnn+/TLb8IU44SYZel2umQJ6UDmYoWqByX6uIOs0viM9xDl7TclFxMfEQ7BmewmzAZ3BtnxRkoZwGIdndzYhvo4NV1IavZc/Q4ZyTq87NwSE2+3NMgF+380GMVnX4gGB7AF4jDUcdi95yo47Gt7moRJPo3qugYVW8yK347u9No1bKjtfJpuSzJPpahEEbSoLEOU7+MLCIdxQLgQmrmy+IGkKDr1WiVS71XcCy+vhWGgpDTfeqYRjg+SsgwSlHgF702jxfGuxWRS6vKWyBOrwkYIB8AohteHCzuKZQUIRgjxG7qN5kKh4NfOTdSHA==
Received: from DM5PR13CA0029.namprd13.prod.outlook.com (2603:10b6:3:7b::15) by
 CH0PR12MB5185.namprd12.prod.outlook.com (2603:10b6:610:b8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14; Thu, 28 Oct 2021 13:28:04 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::d8) by DM5PR13CA0029.outlook.office365.com
 (2603:10b6:3:7b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend
 Transport; Thu, 28 Oct 2021 13:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 13:28:03 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 28 Oct
 2021 13:28:00 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 28 Oct
 2021 13:27:59 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 28 Oct 2021 13:27:55 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>, Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v11 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Thu, 28 Oct 2021 18:53:38 +0530
Message-ID: <1635427419-22478-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
References: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d24b047-5647-4eb7-8353-08d99a16c564
X-MS-TrafficTypeDiagnostic: CH0PR12MB5185:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5185547EC11A9F50B2590CE1C0869@CH0PR12MB5185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vF5J4kLv9XCazr+fwe3heV2Vik/8C4ZLKM63oEKqDQg3kmX+bazqNJL/i47jvbyDWRJJ9kUhxySl/0aEQtMO5IcxLKcv+QUgnmDhHEMYaGsatKSMZ6OodMyTABtfJ6DAmdBmIfNmnZsT89IhscAEUoeRoYzZ/CwcBxVYqQgFs1PwLyDWsFnXKw5DXLVn4u9zbuXwClIQxgJMZwns2Fuu7u5/i3+lXJHDcZxBJR/2AQDqrsgmWgKmlENSTJXtqm0Bm9ZaH3JRMm0Df2FjM7A1nuBvEl5Pfqdf+4OWc/9wRJXHsoApoTQgdz1k65NRWUgfCmdzSmNcGz+Rr6UBhxFW38WudQFrGUT+UmQDaPhOeMMy+hlsCg7ohJv7+2ULHAOiuNBbNxXSbUhCLhXLx6KlcvzZfIEl9ZW6+Pzw+XkU26dLY0JyWKd2x4V0LaY5sX5zakHgOh1ciXiiur8Kfn5/sPQtHRpzkR4sy2ANh5XASdX3CVrrlqEBPQu9KeAZtGksU1i9Ovw7/2KxadDDELGfyaMcR1r+3aorklo6TVb42qSpyH6IqVt2lm517quzRCN7vQnvI+yrFffMJGQQcYQ6YzPyIi9oi3iWaZ7/4MZ+ndm6GtY0DiSfGWhQgGJX40XurJAfKHMUv4IV9xJXg2qhsnLkems8EJnsqr11hpXdmeUSygC/CugrbjfeW7dBay+zZO+NJt/Y+51uVZicO1teIs6voP7Ik9yn5gb2BlWirNA=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(109986005)(47076005)(107886003)(7636003)(426003)(2906002)(336012)(36756003)(356005)(54906003)(70586007)(70206006)(26005)(82310400003)(7696005)(86362001)(186003)(2616005)(8676002)(508600001)(5660300002)(36906005)(4326008)(36860700001)(316002)(6666004)(4744005)(8936002)(266003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 13:28:03.9683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d24b047-5647-4eb7-8353-08d99a16c564
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5185
To:     unlisted-recipients:; (no To-header on input)
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

