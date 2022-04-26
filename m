Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815E350FAE2
	for <lists+dmaengine@lfdr.de>; Tue, 26 Apr 2022 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349252AbiDZKgx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Apr 2022 06:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349093AbiDZKgp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Apr 2022 06:36:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4862E192A5;
        Tue, 26 Apr 2022 03:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSO6eVPQtfc4jTMyill3zraPxdp1wi8iXalQgc/LBPhXKHVP8fnImfgd+Ukryo7i3I64VObZRwOi2ddfJPgsqU66pd7JUpV2c/dd+y/wtYAleWROA9nOgMLOx5zTktXt2kOPDcZBGXK5uuh8zvxwKWCYzNcGcwUz5ZdPKExWNS5oHCjaC6+/O9koqTakE7p8LI3Lu0wCAUyYD0+52ZBAICAzltoWaet53h4EPnIQktQT6ZAVM+mmt5KrUbVcqiCO3cEIxLbXHY2V3r7sh3qdjShPw49z0lI37B3C/CT2Cn+KmV+IwAV6bWNn/2Re1y6CLyUoiUaY2wP2G71XH7Uo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=284CNhf9dO+V94BgmGmgU9geH+kQMWBExW+L0FWyaIw=;
 b=KXeE11/g+ldrKvFOsgednzarqO/FVKS2d4RfjD6A15MtVfPtY/A4e3sZUiLAzwWrVkd6tyBpuCOxw0IDdzgMUJc4yWMbnq0BOf5kgQtPws2stHM4ZKVtlaPvXiyLWV1RMFGP/jGoRK/qYr6BeWNB42p+t0PlTbDt0fHLkw3cXMCENH4qejmktn+oz5U+UXHQ8EXpwknO7grri2cfC7eVXX6Q4qJT2hs8wKx9MHlQx5/Pw3p8ZpQKfZ0mAcF7WgOJFfcwk8HW9Y0yNBDdCScp/O6gnT3eeSwm1W4u/xfYZR+Shv1OezAIOhPIqOo/q5vTsWgc07h+IaJcpywqX5pksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=284CNhf9dO+V94BgmGmgU9geH+kQMWBExW+L0FWyaIw=;
 b=otApJaycZ6MnWqDb7uhZf+UKpkEU41y+oyCJMj8roIwTtKHlvaBVs0XS+76jqh4Uwd173N8lfFejQyHMvUMDllT4QfTKOxZgxByqTFATZlxr5SH1ssasM8D6/44S55ysNV9HBrIOWwSoFr1wNuKEDqWFU9AtRNga8y9mE9ZoqUxa8AWZgrEqHAhSoy7bFbnHV5eqwBlJWVi8uK7yScps3SAui+79QfhG58SbuaCcJp6Lg+LWdc3IXny80yiF6dRfWaYzepwHypaESVMv8+6uL7wSQZMFsIkdlAZycvddNCIcpTlANBZOUXlOwDtwTW/IHa3xSVIJj6TjkoKbw9khCg==
Received: from MW4PR03CA0221.namprd03.prod.outlook.com (2603:10b6:303:b9::16)
 by SJ0PR12MB5455.namprd12.prod.outlook.com (2603:10b6:a03:3ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 10:19:43 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::6) by MW4PR03CA0221.outlook.office365.com
 (2603:10b6:303:b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 10:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 10:19:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 26 Apr
 2022 10:19:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 03:19:41 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 26 Apr 2022 03:19:37 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <nathan@kernel.org>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 2/2] dmaengine: tegra: Remove unused switch case
Date:   Tue, 26 Apr 2022 15:49:13 +0530
Message-ID: <20220426101913.43335-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426101913.43335-1-akhilrajeev@nvidia.com>
References: <20220426101913.43335-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d0695ac-dcaa-46db-8476-08da276e47b8
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5455:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5455DA285637301242117B98C0FB9@SJ0PR12MB5455.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOkpRVGfsflBaiIVGI/tZflJbK48GRy28a1m9is8JbZCMerOnx5i7bcfyQyI8tMTXmLA6tFK5KG5zqcuGgJalUYlg0jD7A54FsRaX/nb7se6KOzmTO5qEaY3nXn1U8Y7u2CP815Bk9TySo8fWb7fXeXEnke/0/aXmSCMd3uk/ivvkgFzkrknOz2p630PEfrGrZ0nz9Db9+j9bYuGcJwcAjVyVbRDK9r58+RGkqEPifMij//xuZ2XzscTX8KWMgKXvZXQJcFO9y9RCen7r2sTX61GP276sQR347vk22wRVDk5BlwD7FHlagsIjaT5f/fG9KA//sgiYEE5kEhqycKhnpBMk9ZboIuEP0YuRqhWgN4x16EN8BqktTFgNw8M5sJhf5gbRYwhY9tFEVoKnfAQxcFYiATP+uTaVInojQazvvnbVYwJTR37544RQg1XWMh9x9HGywi9Z88i2JWHl8hGFtkyOfu+xysL+Ru09UvvaeuPsrgLbUe/j3oyJKyx3LFjFWdTBIHDhmwDJ2mdNnN4/9QBnqAtf/sA3PvKwjqEXTSatBmrLTbLVSj5buJiP/taKdiS6/wkzPmJ+aU1g3sMamlYQQICCUh6PUePgBxKSs498ZjO8BVT9dVqxmyvedv3M5NwJsqlHd97X4ILLdDiAyIXQNkNqJt3hAddHwkGo6knkGvlML9QUL5HeCyyUJuTexSocMZrNOrtoMzfLyxg4Nczrz9SNoQ/049ZzTwEcoRGuFuaX7JOK2qZz8aSdDk4wHbOKgezs2Cqv/D9kp4lBQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(7416002)(426003)(5660300002)(8936002)(36756003)(83380400001)(26005)(8676002)(4326008)(336012)(2906002)(36860700001)(186003)(4744005)(1076003)(107886003)(47076005)(508600001)(86362001)(2616005)(316002)(70586007)(70206006)(81166007)(40460700003)(921005)(82310400005)(6666004)(356005)(110136005)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 10:19:42.8257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0695ac-dcaa-46db-8476-08da276e47b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5455
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove unused switch case in get_transfer_param() function.
The function is not called for MEM_TO_MEM transfers.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index a0dbafa07ec9..6b8d34165176 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -830,10 +830,6 @@ static int get_transfer_param(struct tegra_dma_channel *tdc,
 		*slave_bw = tdc->dma_sconfig.src_addr_width;
 		*csr = TEGRA_GPCDMA_CSR_DMA_IO2MEM_FC;
 		return 0;
-	case DMA_MEM_TO_MEM:
-		*burst_size = tdc->dma_sconfig.src_addr_width;
-		*csr = TEGRA_GPCDMA_CSR_DMA_MEM2MEM;
-		return 0;
 	default:
 		dev_err(tdc2dev(tdc), "DMA direction is not supported\n");
 	}
-- 
2.17.1

