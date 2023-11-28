Return-Path: <dmaengine+bounces-276-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC407FB27A
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 08:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E53B1C20A3F
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 07:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593B12B8B;
	Tue, 28 Nov 2023 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nEeHB+2m"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA61D5A;
	Mon, 27 Nov 2023 23:16:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0hyMx7AZN1uuGoxl8iI40OSfvVyhOCisfmMiliNtPP7O0/BTZjTDccr6018lUwMM4/6ju5goWJ1O37I9XCH7OukkwN8BX8dxcejMULzakOo7rDDbDmJMdq9uAKnejb0Egk9hKG7lBO9x//GkzHEM+nOI6Rkw5dhNzVOceoDeWowuzCxnNi/ye80zHsoHESOvG1nE3KD3YV7CjzA7mfTaOoigMCbHp+rouWZC5K8J06tdN8Apo2oZrt1r5+IYv+KU1PwrCEEEkfhCsUsNsQiXnemXPe1RZ8SOG/PdoguaV0ddE13VfVSde4nAYE+lXyZsu3cpXNjpZexAv/JqI7xmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z+D5Hmvmoy3n9rJS4yiygr2B91KtD2uOMgmZPT0JYs=;
 b=eTfVjYgY593yOy9ewMPgUG8cxyc88nzlYHSrPtLXqBoHOWjDzvRKccWjgx1oWU3sfXhjrRqOnlH/jSoBOxz5Bbx8D0VqIil9Vy6wxNUE1pDsbRDJ1n5bQEHiJbiESFD4++B3BQBVga/LglvBXeVJliXmLo2ivVJHyS5LjEOd2ya+FkCDmT6ViLCEMKtfkiI4L5jjbUCgR5FIUpJEM61momOJKqFX3I68jwQ0HspSQbgz+RPhmKBlHKsxjUsY22IXJhAys+vtr7vnrj6ivcfDaT4cDMjiKUJwXfNWfO2RponINHLMeS56mKI2+Api9tO7tKbhhrXJxLuK5hzDjoxp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z+D5Hmvmoy3n9rJS4yiygr2B91KtD2uOMgmZPT0JYs=;
 b=nEeHB+2mEubYz4hCGtcjyi2OYl7y6XEx+Jpk7SBMALwI3tJq+wshwPEr5BU7wjfJjWnLHxIyEy6ppmenSdZ7ReIYjd06amVcIENb1mgscKW3wnNPtpufw0Ssqo8LJ5fS+cQ5dglPmGZxZuNTMkfbRSZHCI2eY2j4c5nYiOUdzcsbWYSYU8tItLr79Apyu68q8oLl96GFtv8GhjKEKvGnrKDkqJgW1TCciDW02nvtbleaSJutU9y3wo/n/la97Bc5bGEhxGXmPbNOgbcnYGBRVXke9PVesX7wvQ07LGadjOzJNmwZuEFyCv3/c6u9s6qiXi9TiUMRusHrjFg6npz6Bw==
Received: from BL0PR02CA0100.namprd02.prod.outlook.com (2603:10b6:208:51::41)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 07:16:47 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:51:cafe::36) by BL0PR02CA0100.outlook.office365.com
 (2603:10b6:208:51::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Tue, 28 Nov 2023 07:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 07:16:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 23:16:34 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Nov 2023 23:16:33 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 27 Nov 2023 23:16:31 -0800
From: Mohan Kumar <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mohan Kumar
	<mkumard@nvidia.com>
Subject: [RESEND PATCH V2 2/2] dmaengine: tegra210-adma: Support dma-channel-mask property
Date: Tue, 28 Nov 2023 12:46:15 +0530
Message-ID: <20231128071615.31447-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231128071615.31447-1-mkumard@nvidia.com>
References: <20231128071615.31447-1-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: c2cbd8c1-8ff7-48a4-2202-08dbefe1face
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZvHgpsMs5eSIhzHJ5XHkg3E0tq2YisgC0r8KbJ/kxvf4RBfcxQww1/bRoSuUPNl3Ffxi2o5EUyEtjOQH8rFgp0YgoiAq3EJn1mry0ujFrec1U2gtjX3TV/tYid+PwYn4HNFr2GxbRmU915ah+gc9ya63oZ9zv5GGV4Epd/ag3yYsw5aJ91svAfCrpFAJ4GVUKQpzOaVKYf4474g9yc2XIk0lr+bxlu5qxYcim2GTcD/BonR3ZaPLuvS/rrdqNx5HGtvLW805436fmVrwh2US3bUB40FNHGmql7Q6WYVC9a3QU+B0XrE3gNFoJSFh/6itInm6rXLiXWOYlcGpj9bejcAQwnAQwhsbPO3XZd5cQPmduVH0avGZAcovSzNYU5H0kmhnaIOHKMoIG6OnD32DaAvtIYwb0nxGvZpJ1Jyg5pr8pXZ8zU5QXndur3oALfzMRdJcZAsF+JkBLTXb1CtMFmd9phDJj2cjCCdSN1lCeUeoFgapuixEg290hYTLl7YM9qoxwP1glnymrdTh4AROY6XK+Zkj8gM3zKRx44N1eOy8m5I4syp51kcXkkjzlb0SNSCcQaMKSgSHbFxqgP0h8cJ1E0IqZ17SafEeV4UfWipw/WbfryWCAcCI6QHk+5UiECUdy2r1HvlMYOfMqLF8wFRKbv2k/FApwToKvmg7ad6uy2t3foNKlP7aE2BmEdRNLBIHSghIQmtKS1Sm54Ta4BoRy52Q8XRPDTPJk/WT4QLnfQg9x8D5auSM/TOZFDhG
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(5660300002)(41300700001)(40480700001)(8936002)(4326008)(8676002)(2906002)(316002)(54906003)(70586007)(70206006)(110136005)(40460700003)(47076005)(26005)(107886003)(2616005)(1076003)(478600001)(7696005)(36756003)(36860700001)(6666004)(426003)(336012)(356005)(86362001)(7636003)(83380400001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 07:16:45.5519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cbd8c1-8ff7-48a4-2202-08dbefe1face
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316

To support the flexibility to reserve the specific dma channels
add the support of dma-channel-mask property in the tegra210-adma
driver

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 7a0586633bf3..24ad7077c53b 100644
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
 
@@ -957,8 +986,10 @@ static void tegra_adma_remove(struct platform_device *pdev)
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 
-	for (i = 0; i < tdma->nr_channels; ++i)
-		irq_dispose_mapping(tdma->channels[i].irq);
+	for (i = 0; i < tdma->nr_channels; ++i) {
+		if (tdma->channels[i].irq)
+			irq_dispose_mapping(tdma->channels[i].irq);
+	}
 
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.17.1


