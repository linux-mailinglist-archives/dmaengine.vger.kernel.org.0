Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD77BD387
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjJIGfw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345288AbjJIGfu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:35:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E106CCF;
        Sun,  8 Oct 2023 23:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMUD0FGK/kP3VXHB1wBmHzwhAdjCGXMEIIxg2+6z7K/z1FiLILcbQDWEG052Ccm9uT8j5qYPgBnW/qJQA0TEjxvXw/Z40q9WeP0VLscjSCmxFEfqnW8wsDgk02qr+xrzGJKpERrIejvc5jXfS2bjoeLBBZkSMH1PSbvVGZbj2DF3TTKp3iJVcRSCR1fgERwv6UyWsXDcIf1k6vJOt1oaBr0N42Yhy3fCRQPplzOfPCojFxqBQVR5Exon/s6KiVoj+dIha1RxEOSm4aCcGPNU/e1Vbom2v+fvxweIH7WlmfOqYZ8avB9q/kMsqoR/8x/ITADCw6BzppfNvHa1R0SsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MHyERw9mD0qXEWzPmo5dHnd8aRhMQNNLaOYavfkZvg=;
 b=CfI7eV3ouU0BsGp3kBZ38AgtHXWOtvSCNFDy2PFmShvbhhwCbKUtCXCinpB0RcWbnEpj7qSvE+MulJCBd7aS7meVa0pOtiNj8NKwMrVfD5L0/wm8x2H9mZ5cvvyujg+flg8kMJ8QqoNIbu4G4Eyff8Zk5Tu222ht1VLqStF7E1SH7twt/UpfwmB4ChQ4eMSavt8CBo0/dsCd3W34iOD4xB7liYsnc0/b4sWoEHzN8j6R22dt5rP6e5PpbwjE1uJtZ4Tv4vafewgj+5LDuVEcilzWuDzsq5HvUC/KfjiwN1XtlZniIP19vwAg9eninfMgOrEKTuv5fU0yT2M2NFOALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MHyERw9mD0qXEWzPmo5dHnd8aRhMQNNLaOYavfkZvg=;
 b=OorQF0QepcEvxMPsCpBjNUKbOhaqE3e1x2F6qn2ia6YiDuelaVGgfFVlKcWIF+OhG1BktouUp4VjU68oHI1+H3Xek6hcEgHfi0rjxD9u2dqfivhP8PuiE2+E7mSfNeAeOVVL271JgDXi+o9d3dRCo2Vjh5rBvwj5pmCaz1pEEBNz5WeIaKgogmF4DqMSbwSsocF+AfDQ56sdZeoU4zoW+jNh650zTGonfeGqREcdWnTm+BEtXycPho6UDqHiVNcjpIdtTWoLW7L7ktkCFOUltoDOJMbF63irAfw+ryn5rGPEXbBC4LMlvIX8wfO4jFvDXFFP/XyqUholjYn4UE7WxA==
Received: from MN2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:208:15e::23)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Mon, 9 Oct
 2023 06:35:46 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::c) by MN2PR17CA0010.outlook.office365.com
 (2603:10b6:208:15e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 06:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 06:35:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 8 Oct 2023
 23:35:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 8 Oct 2023 23:35:35 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 8 Oct 2023 23:35:32 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH V1 2/2] dmaengine: tegra210-adma: Support dma-channel-mask property
Date:   Mon, 9 Oct 2023 12:05:09 +0530
Message-ID: <20231009063509.2269-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231009063509.2269-1-mkumard@nvidia.com>
References: <20231009063509.2269-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c013c93-ac6e-4b46-144e-08dbc891f86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UA7xqUmvHXPa1buTfHJrI75lt0rPJegnqzJP3Q0a6ra/DT7ClpImK+swuh5C8mfBxYXjnAxDWGPgy8EazAN3CAJCOBP2BCL7dx6Clj/AjPD1SOp3b4i4TEohVQ1BFlD0e4JzJki0ShQByPeg1+f6clyAtzJOfPMm+xP5wYEf3I3qsAECDgFJy5/rPhyUAmoZVvwmxDVeacQWpEenx6pPxblYxnAdUOftf4yYNWY7owAIRox6RMRWujhAAcPiZRRPRknOiB3Cn+LHinzqd0b0e5RDbkAcQ3nE/iFdb+iQUo5Gs7wQgEtRlpzJKug7hrdPLwVMlmBYGws2ueE1PLEruD8HBG1pQIWlsr+3Mywqx8cPKNhlkzYIHvSLANbG3hSP8Q87M7SgYKg63guXP2VP7jrmLNb2//MyoI63WWkaC1YHQYphZhCyZYA+up+MvzZsc4OoenNj9ZrajZt7ekHoDrzpZv+28LTO29NDCltpoP6mBe6mDGOO0fZ1qiAkuuy5wwyx/g8IIac5yhHZUdcl7EG8MO0om0TkfI+ixmkqVSSMfbT9qzcTK+IX2CfzQCK2ztgDCZBRpIQVALYO11UHSgPmxNUhmAWkf3w6pl4TQGRJ6XXtu2EaZszAyLSHb41G1ubSEa1xSf13B+MU4GopDI2FTnxTYm26FLbQ5qaczYJ3v8L+4x3LV4dF3j336sska7kTj1l9yu7t7b/cEl6Nr81NVO+A0yTH68iFjmvZ+PGVjPSAO7JpaT8hWx4xm7uu
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(26005)(478600001)(7696005)(6666004)(426003)(41300700001)(36756003)(316002)(110136005)(107886003)(2616005)(83380400001)(54906003)(5660300002)(70206006)(70586007)(40480700001)(47076005)(8676002)(8936002)(4326008)(86362001)(7636003)(356005)(2906002)(82740400003)(36860700001)(1076003)(336012)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:35:46.4737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c013c93-ac6e-4b46-144e-08dbc891f86d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To support the flexibility to reserve the specific dma channels
add the support of dma-channel-mask property in the tegra210-adma
driver

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index e557bada1510..f09930a5c09b 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -153,6 +153,7 @@ struct tegra_adma {
 	void __iomem			*base_addr;
 	struct clk			*ahub_clk;
 	unsigned int			nr_channels;
+	unsigned long			*dma_chan_mask;
 	unsigned long			rx_requests_reserved;
 	unsigned long			tx_requests_reserved;
 
@@ -741,6 +742,10 @@ static int __maybe_unused tegra_adma_runtime_suspend(struct device *dev)
 
 	for (i = 0; i < tdma->nr_channels; i++) {
 		tdc = &tdma->channels[i];
+		/* skip for reserved channels */
+		if (!tdc->tdma)
+			continue;
+
 		ch_reg = &tdc->ch_regs;
 		ch_reg->cmd = tdma_ch_read(tdc, ADMA_CH_CMD);
 		/* skip if channel is not active */
@@ -779,6 +784,9 @@ static int __maybe_unused tegra_adma_runtime_resume(struct device *dev)
 
 	for (i = 0; i < tdma->nr_channels; i++) {
 		tdc = &tdma->channels[i];
+		/* skip for reserved channels */
+		if (!tdc->tdma)
+			continue;
 		ch_reg = &tdc->ch_regs;
 		/* skip if channel was not active earlier */
 		if (!ch_reg->cmd)
@@ -867,10 +875,31 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		return PTR_ERR(tdma->ahub_clk);
 	}
 
+	tdma->dma_chan_mask = devm_kzalloc(&pdev->dev,
+					   BITS_TO_LONGS(tdma->nr_channels) * sizeof(unsigned long),
+					   GFP_KERNEL);
+	if (!tdma->dma_chan_mask)
+		return -ENOMEM;
+
+	/* Enable all channels by default */
+	bitmap_fill(tdma->dma_chan_mask, tdma->nr_channels);
+
+	ret = of_property_read_u32_array(pdev->dev.of_node, "dma-channel-mask",
+					 (u32 *)tdma->dma_chan_mask,
+					 BITS_TO_U32(tdma->nr_channels));
+	if (ret < 0 && (ret != -EINVAL)) {
+		dev_err(&pdev->dev, "dma-channel-mask is not complete.\n");
+		return ret;
+	}
+
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < tdma->nr_channels; i++) {
 		struct tegra_adma_chan *tdc = &tdma->channels[i];
 
+		/* skip for reserved channels */
+		if (!test_bit(i, tdma->dma_chan_mask))
+			continue;
+
 		tdc->chan_addr = tdma->base_addr + cdata->ch_base_offset
 				 + (cdata->ch_reg_size * i);
 
@@ -957,8 +986,10 @@ static int tegra_adma_remove(struct platform_device *pdev)
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 
-	for (i = 0; i < tdma->nr_channels; ++i)
-		irq_dispose_mapping(tdma->channels[i].irq);
+	for (i = 0; i < tdma->nr_channels; ++i) {
+		if (tdma->channels[i].irq)
+			irq_dispose_mapping(tdma->channels[i].irq);
+	}
 
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.17.1

