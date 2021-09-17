Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB5D40FA04
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 16:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhIQOOA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 10:14:00 -0400
Received: from mail-dm6nam12on2066.outbound.protection.outlook.com ([40.107.243.66]:31968
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242113AbhIQON5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 10:13:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNk8vTynjNoXRjN27TBcn6UYN+zqJQOh8CNh+477t3NyrTTEE55bgRynJ4ztTLUd+pIsDLQ6U2L54XuSJzWXcvdLmYPG5XB2hWPKcqwBDP+vZn65GhuLRW0DSqwbwt/cIfiV4Qxf0kJGSiZR4Fuzf+S7aqihwIP2EqWsbluHMb/Aj9ZjxGP3cVzQTV846eMmenzf/yiKKknYioqSzgu+uACY6xQ07Rf1olqNjJrF84Fx+bXUljgXs1int5nO3JhiqACEDt3EcN2LekDeMnK3S7F3X8I5GEtFskuGQu1r+lIJrBONR50taL626n95NTs3valpxiBmlHblSjQT6RTkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dggXnp4rP5XOSrutaP1FDYEHuOVsehh71Yq/Kt3X87I=;
 b=n9J3dQAFM1iqUe9/a6dfqrFtdiIk0SYYwgZBRhajodDDHdHYUTbOq/5BxKWm5cnp9tc9qkXHPxSRY5HCvKMVSCasXR8QwICnB34Yysb78b+4JcYOku9m3B8wkSD0f8zWptY128js5K3WFAZPr99vWXhAh62yieJu+TuWCWcoUvBYqM7n9RjYxvvjZfX4mrFBgaNa5/jCu8RxZlEDNX+WKI0mojt9Np16/3S04/SaqWPJDVE5IsHumoa8hEanox4H1OXqgImfX6XiARjP4NvC9uU7zkxntiTpB2a6rtmYgPry7QgCYKUK0YkLf6T+rBEZmcfCLsnbjzPcEeHGmqsR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dggXnp4rP5XOSrutaP1FDYEHuOVsehh71Yq/Kt3X87I=;
 b=fBagEiYPC7DhlcOHEFpJCZej93K0ix9qot3yXUrOhC7FzKkJ5PlcNb+IAF6Iq+qqfvTesuMovhTkNx6ZJtH974ojgXu837xvEKuPIrjS3v829wmgHhKXkniDLpjnx8hLanjfHt0hesozax0xrSP9kLVVLco19epLHtacFb8wfeYQElhW36YQ6WAsuein5/ZafP3QwaGLHXMpXjV/MFvGzOk2onqKF/eEoSq6njbCFRev3HP5ts5PShZI3gYuVheVsEhqbuHLjhaBOohgQqc7D82LbpUTbfMcpKGQk1+YYZocIEtERRwHVgtaHa9SyWdrLR1eOeVCkhXqFxo/SYTIzQ==
Received: from BN9PR03CA0252.namprd03.prod.outlook.com (2603:10b6:408:ff::17)
 by BY5PR12MB3684.namprd12.prod.outlook.com (2603:10b6:a03:1a2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 14:12:32 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::29) by BN9PR03CA0252.outlook.office365.com
 (2603:10b6:408:ff::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 14:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 14:12:32 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 07:12:31 -0700
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Sep 2021 07:12:28 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v6 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Fri, 17 Sep 2021 19:41:26 +0530
Message-ID: <1631887887-18967-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6162a84-2fc6-4950-0ba3-08d979e530f4
X-MS-TrafficTypeDiagnostic: BY5PR12MB3684:
X-Microsoft-Antispam-PRVS: <BY5PR12MB36840E15A7B230D9F0A30FF3C0DD9@BY5PR12MB3684.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PNFtxv338acHouwdMoU4A3BYKdBpqG/T29rGqO+1pKmpEDspoXXzg1N+GHb9hh7wwY6T3tM8hUbDsr59EiI0WoFRm8Oviozr5z3VS6A9l2u+/kGjXfepujgxpZoSmurPBGym7lbrbh5qYVKJsvW2vJzphS/O4t/Y2CCeyHJuMXFpb4lI94pmXTcQ4d3rtUzuqlXQDvx4XGGUxUsfDsTiKJsmZZ2FISEHb8xgZhmtO5lmbZY/qLQWEpLcr5JoNKSF+MR2e0+biK0NnP0M7MxQnlf6dtPLQx14S7eGN/eamjjs/3/txySB/HIOF0GHoEjO2DnCKvmPeH771JPRa4Q0cvl3GHSoJ901QRkc3diESg4P+7O4MHExKCF03JuGNDWNwvSltF/feNkNvBi8eDCdx/I7GWloJmstVmhsx5lHCvkX14gpV8Rev7dHhEWk6U6uEQ/LDXqOYDrNU8fGcRo8SIbhoBosTuLzjv851e82HrfuhFwI0DXLoAAZpinhncCFA1nR5Im9Adzaj/F4O843jkQoSrtsCgO26n2yzhJGVx8t2y7oTM1FYv/v0ECnuT9diO7V61QBrwt1bG0faC2DYwqgWEvh634fiP+s3iFF/JDXbh0iuYHEhl+KSMb/QvnddErAcovXVGqRondjYv0OKK5gbiexTWsKv/5rSxapMrNbi6BL+kCncDJPrSjojeQJUAONxSKs+NURdChX+52Rw==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(478600001)(82310400003)(4326008)(86362001)(7049001)(47076005)(6862004)(316002)(70206006)(54906003)(36756003)(7696005)(26005)(336012)(4744005)(82740400003)(5660300002)(8936002)(2616005)(8676002)(36860700001)(7636003)(37006003)(356005)(70586007)(426003)(6200100001)(186003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 14:12:32.3688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6162a84-2fc6-4950-0ba3-08d979e530f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3684
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

