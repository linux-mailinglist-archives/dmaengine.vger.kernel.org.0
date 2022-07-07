Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D3A56A664
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiGGO6t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiGGO6P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 10:58:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF4157211;
        Thu,  7 Jul 2022 07:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2lWLjhETk+s10eIJCEOWBZx0SKZY2YuhMdoUgp1AkG4gi3aWCjpzK2ZvWVtCbEwsUSeVShX6L8cOv5NBYXkkv9onpKsjtFDZtq2IxIKa5VJLtI2yC8u9Ey7poD8btXo6R/OsEwPyn8KE+9wgHJH9ayes302SkSaNBfDokeL2I51u9jF9z0UC2Ir5qHmlzopX24D+1Pc6QZzgVgI26Zx2phZ3bjMtEezROj2Y5ALWM9VZfBujACU042IEKNjG370Q/+L1x5Pyjyo1WB7Wlu8zlexP5Int6Z79g3YJb7ifQJy31mIv/RcqbexeJ14TlxeWSNLWijFvn4XOh+fLOkDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkRCCnbBVTcnaaYk2jJpsvVHgcNeoCBmI/bF0X5uH94=;
 b=XYMejtbYCGlMLV7nz5Z9S2CdItfras1kZeau1vJ8O+JWG+WJMmEmG9HDiL9Y3oHZY4sEADRVORGJxERXFUhhqXIasEdeCjiTKNa6xh9SV+A4T32HssnGWS/C4xuNXY+e0wBrhkH6kPvPGi1ZXx780nOL/4mOC7KAn61ULhAsSw14ud9va0+/KW3hMSkN9ogH1V61xAwYel/HFWNOQvgtAg3dgULFG4TNvzjVdTz3FQt9Wbz64nTZ0EAm+zZWK3nC8M+iZPa41UakqRDtDJI40dXN41oLZiaUAv4Jqxyi2zlC4WZb9CoeP8K32RByFIarbQTPPgcv4ELkzVCkd2i/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkRCCnbBVTcnaaYk2jJpsvVHgcNeoCBmI/bF0X5uH94=;
 b=OkqjhMEmMOlzoYge2AAycqMhMbhDzNJkoRzzGmOfkbaz4yC+DQ/oXS9ufa1zNwk06H/+99WshZ7McPJFHJJkX+vWs6SnH5oueAS8HTFN+irGsAkqITO68xPiI54kXYdRZCoBPT3XXmaJ3U7Mhmhrzk+vujv+sKDup7szg6TBlSFqz0pcch9UUJ8NeoyD7l05lm/bHcCi8KJeNZwpGhzp6YQed40B/YSM9QCtkQT2u+Ch1IHvlIMlRN3EFTga8L4UMNWJzooh3F5zpJNFM+SGZZMyX1/WxkpQHlODiPr6KmhhB62dEsWAhJKoV/dr89v41iaGxEEbsByv58zRJ+rM7w==
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by MWHPR12MB1613.namprd12.prod.outlook.com (2603:10b6:301:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 14:57:40 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::ea) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 7 Jul 2022 14:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 14:57:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 14:57:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 07:57:38 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 07:57:35 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 0/3] Add compatible for Tegra234 GPCDMA
Date:   Thu, 7 Jul 2022 20:27:26 +0530
Message-ID: <20220707145729.41876-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8c4b805-038a-4a54-9126-08da602909c2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1613:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIYZ8jynY/OVjY0Z2l3N2irIRlfwM668yIYqel05CaOV269z30eEU47NwIzy2ye/vp2PRQrJm2IJLZ3sg9D2QJsxxMcmjqzbf8fBtrupgrhxawmrHSTrziz1bw10Ji1IJSWqS1VNmO4zcphrw4ZvcEJ3EFHHUwA8Bg8Ffaivcsih3wVe55jZrsMjVpemO7MTgiYHe+hhbGlrCwB9u+GG2q9eEBKvMCFvU+0wCbtAGQXQSRaOwoDAbfl5E6bHyuIax3k4K/0Q41mF84gj95cl3ehYZq8EKFWv23cf8G6AQ10to1PVqlpuALH5yyk3V6hud8A71uolNE2QOCDF7iAU5NgcqlYQEdWNQJw+VK9aDxPBKeGFtZr4WjdKNQATBrEBBEhs23xQHJ8gU6n8lHKC+LZLc+FgAgImamU/HATo5ZjQZeVFFEGMQhwOZzx4VNQo1N8RyFqWcQ6CeUs7PWtjaIpVdRHcJj7vOuvzVsfAF5M+4kZGd9s/uUgAj7z7w0x05khF85qwsY7dPAjtwUn4CosFkmNOyce48tWXXAodKm+Kp/cn2lM66ePOwzxJXW9MfAR3IjCjQ4rEeDQvo//tcc20CE3gM3JECQUPUDme78zenVuZ8qb70cbtCHwF0Z14XMBtFNz5UHAak9FbPK5Q/KmUkop4LC84dKKtQGcYfvPSD7aaEcVjUX8tqe8YPFlv1svitrKBuMz1p97IHo4t3JAJDGgzx/qQRp5wdxxRlnMs2mUEzFvsc0u82mnRhrPBp47xasqzfXY1KQSZmo9as0A32HhC5L+CORoX0y7Hr4k6S4WGVTDhKR3boKni/FkiYVLE6XOhJ1V0IQOyrSMUe5FQ3067BV5aXahtB2Wony5UIQdXu3lHzu/AAtt+rQj4sXmR2INpumLeHz1BYnD6YqebzSDeaPjMSRGYB/JCDuM=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(110136005)(4744005)(2616005)(107886003)(1076003)(186003)(6666004)(26005)(478600001)(7696005)(316002)(8676002)(8936002)(356005)(2906002)(36756003)(70206006)(70586007)(82310400005)(4326008)(41300700001)(83380400001)(86362001)(5660300002)(921005)(336012)(47076005)(82740400003)(81166007)(40480700001)(426003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:57:39.8768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c4b805-038a-4a54-9126-08da602909c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1613
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tegra234 supports recovery of a channel hung in pause flush mode.
This could happen when the client bus gets corrupted or if the end
device ceases to send/receive data.

Add a separate compatible for Tegra234 so that this scenario can be
handled in the driver.

v1->v2:
    * split device tree change to a different patch.
    * Update commit message

Akhil R (3):
  dt-bindings: dmaengine: Add compatible for Tegra234
  dmaengine: tegra: Add terminate() for Tegra234
  arm64: tegra: Update compatible for Tegra234 GPCDMA

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  5 ++--
 drivers/dma/tegra186-gpc-dma.c                | 26 +++++++++++++++++--
 3 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.17.1

