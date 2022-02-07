Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F954AC327
	for <lists+dmaengine@lfdr.de>; Mon,  7 Feb 2022 16:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348720AbiBGPYq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Feb 2022 10:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357240AbiBGPCz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Feb 2022 10:02:55 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5254C0401C2;
        Mon,  7 Feb 2022 07:02:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdmGDwmb4pthZtOkEi04pr1ttH68+18oUIQsw+VQEz6zYgh0UnfGnFMSnNL2jNpmeAPI7SnOE1Bln8mmvso2jFcwqjhZZ8GtO+WAcnFSbNi4NZG0HBrT3gFfsXazFBZXYMKhPEuyF0uwM7V47mQUv2tUzzhFtwjAEBPi6f7zPgcmJtxHlgM47csLqfvz3slDEwRNfanDaCopeHMaKoATn0Pe5vL6F5MJdvB4OONYqZwdMfooqv4ddWEpC1RKtIQLQX023iMaIisTIzsS2akrGpZjRG1Erc3HZytBZkvefn/0PYabyB3xI7emaNp3B6GUpfzBhVoLfPTm/0yAmuHypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKFa6OiohdYASq+oTTIEjbVRDI9TAxJQnDuk0f/hbZo=;
 b=JZffwI1yAD+J3TzPFYMpVcgHyS3XifAvojzEbztRP9L815lNvdE39HNO2ty9C+vgAODLXqnMtXKHiIOA8zXwxJje60qLkF95+Wp7ZlU3BAXh82VaCyTyXSYY7WezBiLeF42LkGLGbz8QqXZ2pPGJz7NX24nuwNB5svLY2Bl/CzQV5ybppKCf2Kygq/6Fe+GoIYcjtLZQblm/Cgynv2PCpQR94Bnefe2k+GM3MrjrVqY3JIjuAPtzH2aDZwnpvkxXbYsq9Dze6pXTcqKq+3xSH1wWQ/W5mfAbaIjNFkzVfiRXqMItMQlvKY6BY04Wgmbp4GMeaBsw0goi6IamFQ3Rzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKFa6OiohdYASq+oTTIEjbVRDI9TAxJQnDuk0f/hbZo=;
 b=aHyIqMnrs4wDJ87dCuYxsOSvGLFukis0aa5/3rRN0wXls2I4BqYtYW7z3QtzTwtF7+61cdi/zTkmNZotNcP4ky9AIGk3CeFWuK0U1yPni8E9619cjfoEP5QmKFs+roW3opSgQpJGUC+7DD4gbc0notrmPpypE+gH1frcesAx9OoIpf8fjf4CYkMLLhhNToZjLJKGdHvVYKfuWraAgt2TvFw3MI/GOfLyBLMTfJa/YK6MnIlYQKm2ScQ2erYf3BfUVbMMHd+qqWvg9w/ZH8ftCKC8cNP9yRXONRfU6WZ471fD64aoypwiVkaBWx5L/vDR5+k9wFPaSbXHY2nGonZngg==
Received: from MWHPR2201CA0044.namprd22.prod.outlook.com
 (2603:10b6:301:16::18) by BL0PR12MB4755.namprd12.prod.outlook.com
 (2603:10b6:208:82::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 15:02:52 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::19) by MWHPR2201CA0044.outlook.office365.com
 (2603:10b6:301:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18 via Frontend
 Transport; Mon, 7 Feb 2022 15:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 15:02:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 15:02:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 7 Feb 2022
 07:02:50 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 7 Feb 2022 07:02:46 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v19 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Mon, 7 Feb 2022 20:31:33 +0530
Message-ID: <1644246094-29423-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644246094-29423-1-git-send-email-akhilrajeev@nvidia.com>
References: <1644246094-29423-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a257dd56-cf49-41e7-e1e4-08d9ea4ae9a9
X-MS-TrafficTypeDiagnostic: BL0PR12MB4755:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4755584F4F12E2A1D3BDD000C02C9@BL0PR12MB4755.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOr2jFfUuJjBf9labMOQN+Utg59dnRsdAjk1bNbP6od/+OrO+4utG3C/xJXrGU26xq1RKSSLhQQegADRtCwCVnmmqnEMHIYN6JwAm7838DPXIbo0Qjj+1J8Vr93xaQL3N2Bjy4oFMnqRkQcp5fIz7jeabEM1r7pGfSfwqP3poS53CeToo2UnEEh9QqC2IbMj83gpA8SJ0Zy9+swf276g38PsDpbR5HPrYEsKGQ/HroRquw7ZQL+3BcnHYbwpzmTOZOCqAGnb5+d/IPgZQNkT/hqAa3EqC7XCDOnlAPaiQQRK80lTWzmCF0A8IRq5AP2Xre7ja6VoN2Y9DCXx25lkYm79l5ywe37pyT0hL0ZDuyZfB9FLzx4S9mp+qyoYPb3oJ/1yyuPi/SRJKyXug82ztnUcpMX0VgOQ8H47/+BJ8CIqsGpFwM7RIki77A4cjtH9UgWObcA3z43SMFM9IKoJigKTranAV908YbJUz4eFypvYt02vHZsjrEcewgj3qbbao/Jpyrivzoe0Kfp6zG8vkAu3lCZeSCCFdIbuUTxaaDQSs764/Lp1dCNCbuGVLUtIRWbwYJXdKzgIX0EVXS8a57RE7INtvKvPn1akFxQb0Np2DSt7uaOe2qaaT4wdWXOJG9XPZkrpqfBVvCBGB1HzX5nSl08VA13XsttLVbdpgjq8atoYrIoxOoeqyP2uHOXUva/rcAqlKSvaMzAjtjXMeeWgeNvU78MrwWZUVNYHy3k0kDwRgVE6hCGU9yU92SKXhDi+Qfopl1ZX6Nmntt4znA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(26005)(47076005)(6666004)(186003)(316002)(336012)(81166007)(2906002)(2616005)(7696005)(921005)(356005)(110136005)(426003)(107886003)(4744005)(40460700003)(86362001)(82310400004)(5660300002)(508600001)(4326008)(36860700001)(8936002)(8676002)(70206006)(70586007)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 15:02:51.7246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a257dd56-cf49-41e7-e1e4-08d9ea4ae9a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4755
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

