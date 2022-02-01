Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3624E4A600F
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 16:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbiBAP2J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 10:28:09 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:9728
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240294AbiBAP2I (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 10:28:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIa/3/MnZzIi1BIBakfzfUkzvx36SUWseBAR41hdeSWc4iINJzb0SHW+YWVsq7+ZXROlH6Zs3IuWUyoPnMayQgW42yviKo43tK4iUGc7IzF08utLO0c4tsRnee+Up99Q0e6EwspCmCyCvrBJHJffMeKfQH5t/t96Hr0N+O4Fdi/vbhnzEo/FecMg8h7T60P03jEh0QE7+syJdacpF147khVwGZZS8HWaaI5ZxFazECGlSsTdz/tZScQYDGlbRSOhuzgNcVJHdecb8sb5CXH4f6pNeQ7G1/P59Nd/YHlaVoS/qvSUuYfviFEYt3awquDm0rMFVYbK4sm/d38+tgBXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKFa6OiohdYASq+oTTIEjbVRDI9TAxJQnDuk0f/hbZo=;
 b=KeaDA0+f/Ek/8XenAL/H3oWwvF57a6UMYDiqu88b9WVqOSsh6VywHPiVTeaZafD70OxQsPdAAa5vnIRwgFqhq+Gy+aNWRfGFB3FM2jG4R9CfasLgROGCg1dFRYHNfTJr3os4NQhw869ES6WLxdnnfr1/OZt606HfB3rbbZ+1lyI1GWHiq0yy0A7EVcHOIB2hzSm23RAxBnpZjQRu15L8jYAGze0nq+51XyGbydpQz1EjiZqAZCTD3Fib+H9zYRMgCT9epcFZfnalLBrz3qZ3mdkiNj/PiYQOuw3otajTNfqiqpKBsCiCNK2p6/vuOuPtuWhOBJD6i2cSAz5vwLpsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKFa6OiohdYASq+oTTIEjbVRDI9TAxJQnDuk0f/hbZo=;
 b=gMdTGEVKhtqNYMNTUONkUDx1hWALTj4TLSCSkB7ZvesQ2uvTJ8DDZJiL1XJvlRwZ8yYtzZjlTQPs9pnlxJq8Mzt3FjMNQ4oVd8bbf79usdciGfRntcZWUsBXXaS+hjcEOpxMgjLr2lSPXEIexC+nDBVToNtyQrQqt6zpO3B//ODWL8eNJpIZ4xyefU/599xCw1XdDcHiJlgHts1/6qI1BZ8tL7mEsubEf7w1unVfGW+lkzANymQvrjq4tzDfeszJQ22L4tzXvxRBu6ZvkVyghYGDRkPgR51001S2CBqtTMcDzd4KSQ4gQdPyDt+Eal2MTjbLVg6tAAaja4BmOoxTuw==
Received: from BN6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:404:121::17)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 1 Feb
 2022 15:28:04 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::ef) by BN6PR18CA0007.outlook.office365.com
 (2603:10b6:404:121::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Tue, 1 Feb 2022 15:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 15:28:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 15:27:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 07:27:59 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 07:27:55 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v18 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Tue, 1 Feb 2022 20:56:38 +0530
Message-ID: <1643729199-19161-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
References: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c86da08-cfb5-4db4-c5d2-08d9e5977059
X-MS-TrafficTypeDiagnostic: SA0PR12MB4351:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4351B4A725EB1E840CA0BC30C0269@SA0PR12MB4351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKKWVPOSmY2a1Ajy7DEwc1XGo01FbTQIynLB3aoEjWi8peCh+OTR+1HtChNHfQ1TDy/PJVRFzD5xzR8Y1h/AKrzavZGIcsI0gx5h3MamAB3tcNj9/jg0z8IgX/Rh7bRLKw+XcF6PfiuM7jPL+FTJ6XpXIzuJq79UwvNDY9XN6LJi8v8khfkvrjbV7XJZxaEjwx6LwTFnl5V+LtCfwgEBxuMbqGwwahVlUZCbpe9HweWtU/+wXyju7PNhc7SecxFWmMW1/F+BQibP0g5PRc4hWQLBIjyJ/MVbbF9natisCrDcrqvKWHLENFQ99UjUqMsifzOcAkmW0jo99ac+tJ64x43B9ASODma9LdIqMOVc4v1lkDSsr1LZ08GPG686p4maNGRCqVi8mwSZySVewCvVs3mB4zzs63y1AX3IoiHv+oqLLaXP/YhrTv4X1Z37/PtPi3eAddonG0pgrl/h6Ao8ERQtibJyeTwGiJxgEsHMhfuabelxnp0Yf4GEimeNbe3JNen0Wbcc1ilP8T1hvcRSojQBXJCde1Z6HP4uh5zh9n7wHuNxfnBoKamb7BrL6TOBWKxZYpgH1p3bX6eI59a8913nMWKwck9WtV3AIMI2OuDZDb5IvPpbz5KQ+giaStk8keo1579QeVWdoVeRbs1vrC7uxGYfwyF3GUjoX9bVtyDpEQCYS4jW6hB9lOxNzaYtEvFtziz5zQGml2NkaXhbWFELkdkYg8u5cqqhz2wdohXb87TQk4a5tibtO5W2MYncwzbu7UFUOS0AV93hGPIFlA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(921005)(356005)(81166007)(2906002)(7696005)(6666004)(40460700003)(5660300002)(4744005)(47076005)(107886003)(86362001)(70206006)(36756003)(70586007)(8676002)(8936002)(4326008)(110136005)(2616005)(426003)(186003)(336012)(36860700001)(26005)(508600001)(316002)(83996005)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 15:28:03.5671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c86da08-cfb5-4db4-c5d2-08d9e5977059
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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
index ee4bd77..96a796d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -956,6 +956,7 @@ CONFIG_MV_XOR=y
 CONFIG_MV_XOR_V2=y
 CONFIG_OWL_DMA=y
 CONFIG_PL330_DMA=y
+CONFIG_TEGRA186_GPC_DMA=m
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_TEGRA210_ADMA=m
 CONFIG_QCOM_BAM_DMA=y
-- 
2.7.4

