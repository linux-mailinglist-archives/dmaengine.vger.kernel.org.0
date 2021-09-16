Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBC040D9B9
	for <lists+dmaengine@lfdr.de>; Thu, 16 Sep 2021 14:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbhIPMUr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Sep 2021 08:20:47 -0400
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com ([40.107.243.87]:46304
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239477AbhIPMUp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Sep 2021 08:20:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G96JPsDhdEKWjoyTaS7XUPFHOTMnBuAnuT84WWW7KBx0RABp9PUT5K3jX7H+wGOhsaqMS2D8rwL/pg5YUFkF8z7hUmG2CTzLV++DO5ausv8ILghupfXR7XSVdJJVmJ6cnGY+Tt16Lj5zVGXyGoaVP5s629E1YTuJiKYQP3zIVSGoOmyjmCnLMrkpr1Y8O9sqlk1qKMK2TstfbtyDBcrxqn4G160NoagUQ+XCw7V/K6FMlPBa4AQp02DS5g0oU7pYuforZFDwyynmQmkZMZLIX/mJFsenqLzo3EFU6cyaAtUnQtklXdPYASoI/B8jsL5ld+VrysIMDEP+qbD9lU68Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dggXnp4rP5XOSrutaP1FDYEHuOVsehh71Yq/Kt3X87I=;
 b=YE/F03DliHwyFwJ3ePJ5Md8bJEVRxa2mWFF5OY417Kq0PQI7TVZcIxgKrhpyD6IM6S/dAq2wEkPbRTQ7/OObJky6GPVcCcH7X7tlKuxAxL6BCdBigdlQZZtJjhKhDF3vM9kOYutUmvILP0y+6O8yXQKNtKs8tkk6PojW0QIylyIlp3Z93Us1wYAEDTj2LGL5/3ZxNG8rRgLu53khJ+LBlNJ1oQfLyBk5u1j/t4qSnz0txmij8B65uXbBY3r8fVimismn1DTcUwBd7eNOWXM9ZU3sq6msl2fDTqmsX6THdDQN6Yli3wxqQcb3h2va/e/5qMaUftialBY5yOtYr0Oaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dggXnp4rP5XOSrutaP1FDYEHuOVsehh71Yq/Kt3X87I=;
 b=plZx4jqWhG82ge3acjk4gP5J34C+0Pykh5y3v1TmvcQP3N77L8WCce0cb+EKI2XqVMpFwnxTfhgSUW98kABOJl06OGlKpMekDDDZ7ZikXdB9mnj92xDGWHTptXTCtqkOZ1tXX8+DVubxyFEwNt1s70ifCHXudVwxW0diQcHArA9Fgs3QtjRlZ2vZoZHOgANhzX4YlTWd/1/4rUC44YF05QgjyzL4SspnH1+CiZIMqPXWyHZRcACrt0RzCLoIvNtOQ9ayuPtBkw/GmWmzS0cPEl2xi7rorx2KGkyyhGqxnch+Opx9cMiIxZXeKfVmXBWorOTQRtnzFv5NW14GHB79Vw==
Received: from MW2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:907:1::40)
 by BYAPR12MB3304.namprd12.prod.outlook.com (2603:10b6:a03:139::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Thu, 16 Sep
 2021 12:19:24 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::22) by MW2PR16CA0063.outlook.office365.com
 (2603:10b6:907:1::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 12:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 12:19:23 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 12:19:22 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 16 Sep 2021 12:19:19 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v5 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Thu, 16 Sep 2021 17:48:50 +0530
Message-ID: <1631794731-15226-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631794731-15226-1-git-send-email-akhilrajeev@nvidia.com>
References: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
 <1631794731-15226-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93f027a5-d991-41d2-272e-08d9790c3827
X-MS-TrafficTypeDiagnostic: BYAPR12MB3304:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33049362C9C7536FDA9E8CC6C0DC9@BYAPR12MB3304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: caneWfujFgR4SrfUPD+dQ3XnKoW0mGpb9evACe7uwhbXgLoBaz5v0Ee2hQS8IhAxPj3fPgfZJB29tbJD1Tmu/h+cnNNJtWJXOISvqAur4NYDs/gfVI3a4jHyQAOReqTpQUBq06oQ19PPr7D7hcO61R0ZL9VGycr4OlwicyG32/bNlftoPcTanFn8L2qwKWbSwzy8WdJTJN5dAtQ9MjWm2YHW9Gq6beYbW3LkyeoZtrpAsgFUXYAqZV4ybVq5e45IgEOm1CZdfIjNHlrgYxrC249CWBVW9ADK1EgBhRVk0+KK3yJu7/XTfBMeHRWS+xGMU3qDp/Wu6CVPRKFNQBdwcbLkm8yVMg4Z2lBgCeQlosAMkY2GR7PrwSjl8c6NKu3O6KEYcoh+oMNW/eJnEzEf2j6rB2fr9SSksVF0KC1XMRTd1iMxYIEr0h8rXJcACF1CwHMM8oP+OQdYi+xtQ+3a2WPKAGzkCBJUeI2az18k4xoWP56Kp2S5R6oWcv1QFnPZDXjCJ6ls37/K/I0GXqtm6FY41Hi/LSc8ORaXRT3KoysdnRr6fWKs0Xs/hObnJae+8kDDzQM+XbFGB8Mdcy66IGsRSpv/EJTyELz1oDBOqn2RWyUt4OhfHoPQiNB7xVJjd9w5iW1KZ6DNLhBlBpDvQEfmiO2fa0+QKmr3UUpLPXAxIuEmbex3I99SJGd+ACrGmPaxy3mE15FhWySO1szRTg==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(36840700001)(46966006)(6862004)(2616005)(2906002)(36860700001)(5660300002)(54906003)(36906005)(37006003)(316002)(82740400003)(26005)(4744005)(4326008)(7636003)(47076005)(356005)(36756003)(82310400003)(8936002)(336012)(478600001)(7696005)(6200100001)(86362001)(70206006)(8676002)(70586007)(6666004)(186003)(7049001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 12:19:23.7554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f027a5-d991-41d2-272e-08d9790c3827
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3304
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

