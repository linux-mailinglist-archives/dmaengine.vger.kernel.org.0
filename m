Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC294570778
	for <lists+dmaengine@lfdr.de>; Mon, 11 Jul 2022 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiGKPrH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Jul 2022 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiGKPrA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Jul 2022 11:47:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CCC78583;
        Mon, 11 Jul 2022 08:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRbgVGD9YkFCttdrUxxNQS8vYoCAb7bZ3YZFwPYa6WvjTvsRfwTi3ru99OaKQfla3X5Ycd8FifiQcP5jL4QsT2xCgdCQ4Efdxlq88RXLn2eXBGOtT/sSZynbfmLeq0rORissOQoLhk332q7/LKBJpPcA53eU5J15Vq7cazyapeSsV/Ch8wl5fkSIjNqJEE/59RY3/C2l2qQv32Bj6vw3Oz1BlLFuhA48DPNPLn2ibB3d+ye9tLbQuqfSa6KRL19MsO3TLwGMBay0TESjDSwCtMHAIJQs2bakBWm/j3VedTKGON//4r9jpAYD3uCL+36fHhFa4Qz8zBCLkD6DtuxZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmzIxOln3gUuMxzXhcQJeWMYdr/XF97SuTdVIbD9i2Q=;
 b=GRjtgu7Qo8Qu1KGjy6K3jSN6PLXoql5kpq63CSVfrSv/9A76ZLBeidKEetEEj9syKp045GeX7BZWxCFyxEHJScAWV4ZCkgC0zj3xTuzj9L69jarwRgiDCdd/6bS+Jxz4urrbeMycz5uBImorI0MkPl4DLRVvB2wASJIzmKKZaIlgKX6dffZbhiE6gDPRBV3dxdLj/P6ZpjMSuo5h1Ge76eN0Oqdt3kEmupv2eU0uhWQeqzRi2t/8vzTWdubh96/BQNSXI3W9mpzjCIOhEvM54wFQa8lfbruV2KfKvWz4CTIYZH1LN+Da/OdTAPLVmoKs9Xg9OSoGoeVOMZ8qBlxuXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmzIxOln3gUuMxzXhcQJeWMYdr/XF97SuTdVIbD9i2Q=;
 b=WgvWs8FIwhs4DNqYId2pAVjLexS3yvAXqFduB77WwqBG/wf+pcPCvQmmv0AtwOOdjvW1fUy59v1jFekf4/H0DcTYPyJqtCW/2ye0zbZ+ygI/+USgjYVnRosZ/7zJSXZHLjC6CeQzwJxr6iNbP1OS9KW7uCJJ4RiGFIimBg6cEA6wbZa7oFmF8w+4IR00JoflDBHnQZ8GkgzsX/28MjBjSLxo+14tCLXg4u75a8nvmS7+BWir0yAwbixVBmq5rKQLzFYHJ4PeHEM6GeehnYwm4R7CiIN0iTiDCKkqWiWgwp0JIS1IbA3jY5A1xGhXHb50L3ZMZZIkmNfz0Ekun9uu3A==
Received: from BN8PR16CA0015.namprd16.prod.outlook.com (2603:10b6:408:4c::28)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 15:46:56 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::f1) by BN8PR16CA0015.outlook.office365.com
 (2603:10b6:408:4c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Mon, 11 Jul 2022 15:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 15:46:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 11 Jul
 2022 15:46:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 11 Jul
 2022 08:46:54 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 11 Jul 2022 08:46:51 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v3 3/3] arm64: tegra: Update compatible for Tegra234 GPCDMA
Date:   Mon, 11 Jul 2022 21:15:36 +0530
Message-ID: <20220711154536.41736-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220711154536.41736-1-akhilrajeev@nvidia.com>
References: <20220711154536.41736-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbcbef47-ef11-40af-d11e-08da6354957c
X-MS-TrafficTypeDiagnostic: SA1PR12MB5659:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYcPTpLfn1ytAIZE0g1WD+CFN+ZcxAB5vSUulspYpsOBGAPIE63RpGGFNXcAzVUttMJ35y7TeqAjaBf+Zijab2yngExxA7RGqN4rbDxpiaiq5orXtefLHkk2mF8ZZcv3GvOCWIMTojishWetUS5OzrMxSxrwhH5an7CNjbHQvyZTmN8sY+SwU+tTmzY0UYy1LS9/UXF6/wKeDnB2ZF0+VR38Gk1bDehGryVTGC6Te13ReguG+Yq4CDRiuitAwrbg5iT67Ily8Frcm5CJKbeQ1HpKMma5FoPL92lR+fEudw3akdSrBCywUHiiugxZVLtOz3hzfacAHJ9ubSDyTapld03dy/khCruwvas+m7Lr7odyJj9VUHUA/KdhJCD2I99rA14gk8mPm8+b0M707fGGMR4ZHDdMMiXDEqyNrYMzvbtQL+OSZsYHGhe5ihsII+JWMabEcN8cU4xP1jfNTUrPwQ50EqkKt/3QcIj+G1FBxJE3RcJVruTSzoTNpLz/VZtmrjiuFjtAF86oiX4u8rYLfL22z13DL6PdT4jmbpLO3EL/gC3DAQC8vrzpvT8V5uOtgqOmXc70vf2B8gwVB1gsey9VQhIZ5Vcp4Vx9we7D0gWt5sJUkEPLojUsloRP1AqeeHyY6kAa43FPI4WpO919dzu63mQetyLJ6TmJE8u5iwHXRwXbMQiNt8qLG5Y7yxerkaXY4ZSmxMzeAGJ3bDSOW319tZKrRtQyjavK2PgJQpxYCYUUwkg/E2GbOrRsBzjN65Aj268yjHrmugwsYatJrfmD0XsApjfzQ9BzzXeAb9wKrZqjPVbCfEyvAgR88TqDsC+nrcMeufwoquc630iSwgTxvr0+R6dxMSo95Px/HaqVNIR+40wzrYqyguPktVJzwbRzzbWKfn8PEOK6k9NwGo+6sKiE4KC7JaMpORa4Hyk=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(40470700004)(36840700001)(46966006)(4326008)(110136005)(4744005)(36756003)(316002)(6666004)(41300700001)(478600001)(426003)(336012)(2616005)(1076003)(47076005)(2906002)(186003)(26005)(107886003)(70206006)(70586007)(8676002)(921005)(40460700003)(7696005)(81166007)(82740400003)(40480700001)(83380400001)(86362001)(8936002)(82310400005)(5660300002)(356005)(36860700001)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 15:46:56.1015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcbef47-ef11-40af-d11e-08da6354957c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use the compatible specific to Tegra234 for GPCDMA to support
additional features.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index cf611eff7f6b..c3d2e48994d1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -22,8 +22,8 @@
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
 		gpcdma: dma-controller@2600000 {
-			compatible = "nvidia,tegra194-gpcdma",
-				      "nvidia,tegra186-gpcdma";
+			compatible = "nvidia,tegra234-gpcdma",
+				     "nvidia,tegra186-gpcdma";
 			reg = <0x2600000 0x210000>;
 			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
 			reset-names = "gpcdma";
-- 
2.17.1

