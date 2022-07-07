Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C67556A66D
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiGGO7Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 10:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiGGO6a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 10:58:30 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33855EE09;
        Thu,  7 Jul 2022 07:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtLVqnBGqaeCseCann+SI6YDwhXEZZgO4fQfp/4qcNrm6Q/1c2vKUu+rlR6T8ilNUyJ2oa6mZDLpZHsMgG7teN3gJCJ4fN2Pps1GjBRARvwz8r1fZ3PvQOOeFYcckmYoa/n6V4g/23/pDt9zt2kAxTjV42gnnaktAXu339QCIUis6uLNktnqQpNmtg3OtxWDSF3Pr9JMC0Wn/Xd/Jr07qfSHKkBUv3N72JbkkmA2277MEOVlpg2HdlBtJeqCJH3G5R7u3tXNL6IRH6U7aLlQohYQW26PSLBUMVk2Xf5YL9mcRTW2EREQKizEFKf/7wxc7mpYeUINYCGX/l8CzypvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKaN6pvpVpwweBaOWKIO1cQXLDmdSqz/d1GUIdn3rBg=;
 b=RWR8/fIB5CiFVDgjVca/FS5S4wViNFB1lNdeQA2mjNEqVEscA7AeE3bXh6zKryff1IF4tO/1U6rh3ZzTXc/D1FqrCVQ4zVmxuTl6LeD8dpqM/NqldGH/CzL8vxAWpqnJGr0UjjlpmAd6zHGtdZPU20JnxmOAMqF4es2X0wPesnpKDyCbpDRKM1t6Wkr4AOdIPWerrWu1qdrEk8kaQzAm6y83wNetI3GPBAFvIClpDLlAc6qLqNsPe5W1cKAOQ9bLOeGZGsCyzUHANLxCKNiWvwLfOD4nNQVYTiIa4T9KZEEjtiIwYVBpL1pBnjQMNpFeHQPU+QzkTg/ejvHD3+x9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKaN6pvpVpwweBaOWKIO1cQXLDmdSqz/d1GUIdn3rBg=;
 b=jgh0Jd+xrIpmKZuBT1s3dyCHVQq4niCUtQGMcBKbiae6Djko20F7f/TUSezeGhwM0FK2RmoJtwEcNY1/zOlgxDqNPzhcT1MTFaGEgpTf1jgtfiw1VG7TSEWK0uCZ0SGWmQ0mJoGgKAJQObUwTVqtBtq66noT5iOmThNIkic50yopHXrV+CCdbR8hAjU4AqGM1udEmM/jLUiP00q7WyNd4RKw7x/pfaIepTH43v06oisfjd5vKvLRP6IzTNcY5m+hBeZ2EOBE6hoQKKndNoOtHXlu7fhVKtidQTfolGtbYhT8MlltS2x/8V3VPr8146/xvsUycu/OaBzP/iVz8Diapg==
Received: from BN8PR15CA0058.namprd15.prod.outlook.com (2603:10b6:408:80::35)
 by BN8PR12MB3044.namprd12.prod.outlook.com (2603:10b6:408:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 14:58:10 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::5e) by BN8PR15CA0058.outlook.office365.com
 (2603:10b6:408:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21 via Frontend
 Transport; Thu, 7 Jul 2022 14:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 14:58:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 14:58:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 07:58:08 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 07:58:05 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 3/3] arm64: tegra: Update compatible for Tegra234 GPCDMA
Date:   Thu, 7 Jul 2022 20:27:29 +0530
Message-ID: <20220707145729.41876-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707145729.41876-1-akhilrajeev@nvidia.com>
References: <20220707145729.41876-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f24ca1-f743-4f17-044e-08da60291bf2
X-MS-TrafficTypeDiagnostic: BN8PR12MB3044:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6+OEw6QFAF/XsQ+k5xWWAiEs5EcpTnRdvnhzrzO8fPGoGmByZrQnjsoZ7Ux7IAmxdxhxnB71S0c0xrkmMqOspH+rYpjgZVv5t2X75X5Fe47/ZybJFoexNEjP9GVDS+JaSPpJ9kONFeYWAyVgWAP9YjxpMSuW9kwUtPeuHeYenqyTtJwrMCDWOxQHqdo9t0Uec3nb8iS5uzhkOFPX433v0o9gT/aDhwL/cef3AUqAy8AfP4afIVut+mXRVdL1e/P/LQVKzWxTJLUwLg59E3eOp5vJute1jgu42fVnuI2b8+pJc1xQVPXTHeonicQh5VawJwlP1vfTVD/jL1xHGr9pclx3kMFfVv96Ef6vlTc74LlGWTuvdK8LTSCUNi4b0sG8hFZR3oXXYp7q7MP0nitsfuysaCzGFPBSyNFLEePON/LIp08VAUFrTQ31UvlT5KG12xCUsPN+xK5j4uVeSWvea/s85k6b827vFGxqj/CA3M/FPZpPdCzIYKMtYeheYvOFMJXgRXycXXxAUZg3ukMzuNN6h1C3m52n0kK6lApRDo2Yh8Eq3QEVVrN40pR9x82rbI8cmA7f1VwI61EfcpF5rkGY5x1eOJpkio1Nkqwa23sq+FmMDxY6DW9+vCqSKTfmFWuakq3o5FC0NN+l46BwtZMUm+3iFHOxGtQ+dq0xT6UinYpVWNB4W1IFbsJwMM0NMOnCT3aGGxc7kyB1XtlnJ2YuVnhYUs23ojyPOzaqf1dOfPELNURHPr5uLYRNFKIOMZklKbmOJyofzaFqT2eWQc6ExwNO7vdI5JgLtelo1wpdcZKzr3BHu4LKqkOTSUzS7wZD7u3+1iYz+McsgTtH0WGQjzYNxKT/JncClevoqFu5pms+Bnoihny1DsLjS7D9apfJXIg+NwLD6IYFDp+8sxO+/zS/ENHcZvqqIYexXY=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(40470700004)(36840700001)(36860700001)(26005)(40460700003)(8936002)(7696005)(40480700001)(4744005)(1076003)(107886003)(4326008)(2616005)(8676002)(336012)(426003)(47076005)(316002)(186003)(5660300002)(110136005)(36756003)(478600001)(2906002)(41300700001)(82310400005)(6666004)(70206006)(70586007)(83380400001)(82740400003)(86362001)(921005)(356005)(81166007)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:58:10.3399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f24ca1-f743-4f17-044e-08da60291bf2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3044
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use the compatible specific to Tegra234 for GPCDMA to support
additional features.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index cf611eff7f6b..83d1ad7d3c8c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -22,8 +22,9 @@
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
 		gpcdma: dma-controller@2600000 {
-			compatible = "nvidia,tegra194-gpcdma",
-				      "nvidia,tegra186-gpcdma";
+			compatible = "nvidia,tegra234-gpcdma",
+				     "nvidia,tegra194-gpcdma",
+				     "nvidia,tegra186-gpcdma";
 			reg = <0x2600000 0x210000>;
 			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
 			reset-names = "gpcdma";
-- 
2.17.1

