Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4F746962C
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 14:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbhLFNFA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 08:05:00 -0500
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:63744
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243689AbhLFNEz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Dec 2021 08:04:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqtfasvgmLVVc+7KzjXsUF0a2C3PiFe0iE6qFe3OkD9r1PhYyubCfDcLjoeVo/wBlSp9ugCxXapaCu0GtnQYzE3hOX6WMtuzEyUPlni8koKfzE+qXDIkWQru0xHdAJt6NUO+EZbj8dlV+IPo7Id+ejnfjgW7yrY4B/ta2sUIlnyb/kT1SJSk9RPrG1yNhYUuKz7GMCZWEO73J+auBA6hrANIeXsJKtzDVec/tfiLZFwMj7eG/aLCZ2tQtpYZ57p9P3xXCuhgZ/JTlPIUbwG+6Fl9ZOGHhWFq5c6TUADfH8pwIF/AQNT+iYdvQyCngzItueqP5MkR07hQgp792ClcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCc4HZxmQxbFhMHaLCwO8Bw7VvYoKYE46xxG49EPdYU=;
 b=J1D5ilrN14iYjwmOeIcAIEXTfeHl5z6KXMGR+9FK9yDNzke6S34me3E3KVf9DhFvUmowvb9RNlVGqUb1Igl9t/jmo8QD1XeWwvOqS2k6DjECMi/gIlSDDM7cPIvG2MljGq9LkywWHZ5Jlje5IxhaR9S0kH2v4MMHDnYMZOBiijFZQ5bmuYcjsF0w491fg8lZST2w4l5q1UjEXK32nVc/MPkh3Q1wE+q5D0VeX6VQQRnvf+E7c/vzXAvDsmUa4d7PKQ0qIOI0nc7tiBSUhLVTKOpxILXTMqHb9+C9Hrm7kWGnnkbULk9hlM0efEOPa7r9F4KVCq8TSrxVCi3eF59oOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCc4HZxmQxbFhMHaLCwO8Bw7VvYoKYE46xxG49EPdYU=;
 b=fBwfII7TihL7/YU/pwV08zuIJleNLjA2jT7EahY9XmMqqowjw93YV9R9WPPZYKdmIb0p238EEBRtosSERXDgtWf50lBoB9DBAnesPlQ1XWOvorn/9XOT5C0+293ANtS85kFwqNwHQoDgHDB+1K1WqO70VzIO64QcInwuqu8Am61v6+Ud1UD/BHL96ekkRw4GF5p4UyE2y1vrFJI8uMkHFfyHrOpy8xDT3sDBxrDu2v9pVdkXmMfnDXZzLlAXTr8rgwnEJV59PYnkqTqpzwDzrvPSsKYst7XdxEslGxEl6f6f94LXpiUtBOd4znoA2zifscwuxggmuCdqhowiFXVENQ==
Received: from DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8) by
 BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 13:01:24 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::a8) by DS7PR06CA0024.outlook.office365.com
 (2603:10b6:8:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Mon, 6 Dec 2021 13:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 13:01:23 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 6 Dec
 2021 13:01:22 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 6 Dec 2021 05:01:18 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v14 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Mon, 6 Dec 2021 18:30:38 +0530
Message-ID: <1638795639-3681-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
References: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30964c6e-1b53-4a72-df13-08d9b8b881cf
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB387698FC51424961A7CA71FFC06D9@BY5PR12MB3876.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FBCzCvXvhRViYlie/bbjdIUcqeYnFTqqFXf779Uv4SQ/sRgAGR109FPxP1H8rlVNZ2pGqIjj28X9mYnatqOe+ywknOGGly75oF8YOzmkmKVaB28NqlpZqYoxHziDvqPmU6d9t6ahYqUGcsdjxe3e/bX9TiuLOj0TnsPY9mwvvzAdoHCxnWl58/79tljoYJ+kIV07uqkOYVz7hsrSHv81V3VAyowP98QJiRrk/yxYFL8r/U4ghY2jXVKSpycgqd6f6IlrWIpnfAMjVpGFGWemLcvxxOQVvpDDDToRsEW73cYXANWCA8z+QSIkv48GHMPp98xvydpMXxQksv3bFmbL/cKH/3kXwJ/UCroZ1LxSOxbXph/wyuWvKK9MnSH7Nh6j37n/9sQewHIDkWUBZFqzd/14ns7kFAI3FEdeNXY8D1BzVwIhNnamJ6qVrmKHpO68k1+f9pzrx/nN8WXgjeQrfOAHjSKXngq6RL3yEMp+e4px8eolcgxciUa4BHuK/cFxswvcrsP8bz2u8UU52sKZLO/hzP06DUTL9wnzv2QUrlgNBvXgOvPd5rj0weJNEDfrYbYuCgpq3Z8oteB5WuLhid6N2u9M/bY6005DdfDZYmp7Ep6DfdjcJyxZQWh3JOi2oIeIxQRk6V+so+49gyqhXrsRG+Np8BRaSJynC2ub1HWwpREdV2ep47QvXZnPpoASotpt15S/l5uRd//nNeBWwvNn2M0t3lTmrYAbaNB0kZblcTYfNMOEaEgVscNtFy+uOsed3Vzevso9nLGhpowP+sp4m88LGhYlm6EMksYmpJapjY7e3fqQ9mjbvLG6pKIo5/9bzNvm8VcJE54tLxMSA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(356005)(86362001)(8936002)(47076005)(8676002)(7636003)(110136005)(336012)(4744005)(36756003)(426003)(508600001)(82310400004)(107886003)(40460700001)(6666004)(2616005)(921005)(186003)(70206006)(36860700001)(2906002)(316002)(26005)(4326008)(5660300002)(7696005)(70586007)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 13:01:23.9106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30964c6e-1b53-4a72-df13-08d9b8b881cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3876
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

