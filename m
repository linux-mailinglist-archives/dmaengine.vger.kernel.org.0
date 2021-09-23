Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72DC4159A1
	for <lists+dmaengine@lfdr.de>; Thu, 23 Sep 2021 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbhIWHxo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 03:53:44 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:40961
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239807AbhIWHxk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Sep 2021 03:53:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odNzXcyG5Kk4jBHZWfVeliu1Z7cctYjPud3d3v4/tYFNUuFlR5tmrdlFs6cfqTwC5JOBUJiZvDcXjJGWOfoC8lS1i7LA5z3PwPE1GXwp2vejqm3ga9CEGRfxRSXxxWBC1MXsaFjOh88RcY9nUJZIb+CXgMg4jxYDf+cLd6/xbtZawzyK9IKPXR8OSQ6y4lCoYqfvWIELsYKFHiSKbFAF9oyjxrOxsRa04yW1mfRDQdgY/JpUVhRQ2Sd9eBfqZ4ViUEX9CuZM0lY3GPQwLJnRE6We8wh7Umvauf4Nda3EbekMnmXs7tqrn5AoN7ByzxlZEmHAsFjR8xuxsfE5LEzwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LMk5MyATrD65r36BMMEUKF9z+V7PrTbVXxSgEyhBJWg=;
 b=c/sFeNLXvZLRD0jue0htjmRVEBW///L10WOsA2HM2Zd8xuChEhTd5kuab5Sj/fbRtuVtFABrnkYRn8pzWCNzoamMNbsnY1qNBDlsOsv3dq7qcx9oK5ILCdGD9ZGsO2Xm91/bIh422tpZu6xHA0m2cqiA3bE+eRtbkpEu1sXcehioBFHKwyxGZ5w5HLc5UQLrjSkOhBQkcDemTJjr23AL7jl31NGAJU15LXE0XURtDv+SJUpLEawloeo1vEsXxVnlaaj/SUSpdy55rwPJuZYN/v6OaQKTDATvdZF+iKT/Fh3bMwWH/7uasbYOqRriraBCWS7iUxkrxTOrEdIfJiEjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMk5MyATrD65r36BMMEUKF9z+V7PrTbVXxSgEyhBJWg=;
 b=I05diBfMo48gogAzlRdjmJxl018ZWPJrLLa6WnR+B0Ff3TXy/GnrhVhy0LCjGQ8qpd4O1fDx3UJM+0pvHhazhTUdjolp7fpYFSkOVJtxrlFABtLvgQus0GSE1m7Qub/CVH1C9sTR3YjegbuXm4JmrEO6IyZjmW4g4n+fOnCjW0oD0DZKU7Gw1a/UU8Vji/qM3pS9Qh/LA0+LRearTWfGQ0/duluOFQr13njx6Tfp8VEzyMU4PaRSWT8sexEKzdF0DOw+RwGUPARFQUFKiKVqGuDHhPz7T+rjj17/ZX4AFXG/5ToIcLE3WwjAu6RmFG3keQFF0yNG3w7IIy9w2A/X1g==
Received: from MW4PR03CA0009.namprd03.prod.outlook.com (2603:10b6:303:8f::14)
 by BN6PR12MB1745.namprd12.prod.outlook.com (2603:10b6:404:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 23 Sep
 2021 07:52:08 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::7d) by MW4PR03CA0009.outlook.office365.com
 (2603:10b6:303:8f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Thu, 23 Sep 2021 07:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 07:52:07 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 00:52:05 -0700
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 23 Sep 2021 07:52:02 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v7 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Thu, 23 Sep 2021 13:21:23 +0530
Message-ID: <1632383484-23487-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632383484-23487-1-git-send-email-akhilrajeev@nvidia.com>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
 <1632383484-23487-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56367204-ebb6-4ef8-f12a-08d97e670ae4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1745:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1745E19AD1095FE1BF830744C0A39@BN6PR12MB1745.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CN2llgHvxWgjuYe83fnti44LCZKkXQzkVXQsmpdjgOy1ey/oU0YxxYaJWFHV+AuWCNVCvtRQFgQp+0qD2ht8bgfJEw+TVkfaso//mjRU0Jw+fv/AVfDiMNd0y3bSXfDOAkE99oIA6B0fY5UybBKd8A9l6sEOaM/xUnHc8InVhFxTWm6rsX9OeoCRHE6U1Suw5MuzFaRN6fU90ozYgbRvxze7wIKKp2laUPrq7S2VaNzfmZNt8euGdE9KsCvv+5SPXgPCawOq3f+8wuX815NkbrsllGzVM7gGaNbUzA5s+6KHsF0mt5jiiXXSIsjAPOcLW8jLF6SAybMr9BbFaWYkvtd5QKQ9dKpTDyOoEZUgTsto/nEbFQpgYDQNcDjaPrk3/CNfYOk/Wp5kpnT6X1odnsH9Ikwtx9iqG3fSadl7xrATT1+RM1IcfEWn8dMr7QjyB+E0lROlNPkGvyEpLKQfHJeTgLAwz7lchv2AGF1DnxIrrI/7Vkf3FniF2bhaYFjjxLr9S5GEG1s83v7l5nIeHh5uZMkcg6veARo6rdEMcyYBKYCIjCTWJOqJei0XQ8sFV6q19bdEbB4FDxiFakoDkW4ETvKy9bVADUEnNVP75TMcpsiGLiqdl8qnoZ7QHSBamgwf9yNdIwFlfQgd+b6wdFQPiGXQJYb0vahO+CKtAygD3LUHReVWjtiwCOZ0azdUe+zrafC2Mbd+AVI2ArFRzA==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(426003)(54906003)(508600001)(7049001)(6200100001)(86362001)(4326008)(336012)(356005)(8936002)(37006003)(316002)(7636003)(186003)(6666004)(36860700001)(8676002)(82310400003)(6862004)(26005)(4744005)(2906002)(47076005)(36756003)(7696005)(70206006)(5660300002)(2616005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 07:52:07.8443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56367204-ebb6-4ef8-f12a-08d97e670ae4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1745
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

