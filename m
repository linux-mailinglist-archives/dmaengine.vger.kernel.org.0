Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB851BBB1
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 11:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346481AbiEEJTK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 05:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352198AbiEEJSu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 05:18:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAD44D62C;
        Thu,  5 May 2022 02:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmEKEZbjqmO0SJA/aPpp/MY3FH5/VWGKRsgF7Ri0d0wzshRpxUbrdUXl3PFuL/OzgqbqrFDGrluLXjLf7IcJYpUaDQKSSersJFricKeP3HuLdhxeTc33bm+rGh1752gJiIGTDs4ukomZtLc0/N0jWht/+XAna9T/s1B8/aXRVviMj55g2ueOgPZdpXMJFQpiLtTxP4QFORiBxpNbSTYT0FaeNH5E/sA/pUxvD2INd6JDMzfPqEIi3IMDzauEJbi++zZM2JvHe85DJ29SbNVa3sT2sCjdQDYsgIz+221Ar3q7MjQKoVpDVmasrsYvUcAGNVAc94w1xCKkStiKXZWCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyUhURt6egS6nSDd5f+ZlbCTLWYJ2rNUat31l2RIgOU=;
 b=gGDd0pYyT5F5570yZJDqR3l2dxYTNDnQXA9cMHl84u3g4i8pWaNTXiPk5OPMUfImAz5NCDz2KqIbwRhBNKva2QjdyTlr3kzEFxnFdH3qYbBGSQMGEru0gLB5NnqBvmCsyOWzXDtKYUMHL8Oys7LHmfH6O4600nhWwlqFjL8I0CIiAsxlEnYxXzjoPCB3WBkM0nZGx4zbZCxCudaLd0kVISeMrFgW5X7lb3G01ZJu3Q6nb/SGneVuQRz02Jyn+fz4I6KubXTbioA3tEF7bRpIzGbmspCTXPeN60OrciOb2EGDnsu9dEjpgasBxnKJ81fkxr+ssR/EH9i33XGyZTOOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyUhURt6egS6nSDd5f+ZlbCTLWYJ2rNUat31l2RIgOU=;
 b=ugf2aJTrRJmuGr/8TycTMYdkb3oQMP767/PYpmJxGHLZNZQ5Z3Vnc53SJs8LO+HHT6nO6PEN/5oQVl+1//eIH1sb2jOyfvwa1iAct9OrIEiMR4elc86Bq4KnwbbjxH9HxE381xKfriLgLJac10Xw66rUrSnKPocF0ZlLxTbWrtbGKwK5MJJJ9skUrj3AoUKum0E67rH4sLcq0nunkvbly76POf/XM1yJTzik5wCjqlbVB9Fh/JFWSjsBo1ewMdt9SO+iCAOUsdysasjYnRUSCLRqvMq6GNQvNeBvB3wYAhweoe8yWaALi6qTQcfAiNMDNzrH25J5mh2UTDHxglg+gA==
Received: from MW4PR04CA0040.namprd04.prod.outlook.com (2603:10b6:303:6a::15)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 09:15:08 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::5a) by MW4PR04CA0040.outlook.office365.com
 (2603:10b6:303:6a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Thu, 5 May 2022 09:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 09:15:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 5 May 2022 09:15:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 02:15:06 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 5 May 2022 02:15:04 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH] dmaengine: tegra: Use platform_get_irq() to get IRQ resource
Date:   Thu, 5 May 2022 14:44:40 +0530
Message-ID: <20220505091440.12981-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7118e05a-19ab-4a67-88e7-08da2e77bf83
X-MS-TrafficTypeDiagnostic: MW3PR12MB4427:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4427D2AF2CB8DF700D801325C0C29@MW3PR12MB4427.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yd/6TdmtuNVXVdingb0jkxkVOa+svWTq5aKwNr5vEaGxLu3e4ebe6l0MJVuCEr1bsn7VPbGOrxE1dlbS6+sqJOHqkiw3ULR1JRORk3sYgHtT0tYYs2S1WLHpA2qCHJUuBoTUQRvwDqvZyBlWfHtI2rpCoYIm3+6rUHbBL1B+eiqCisW+kt5cu59Sf7xUnc8PhflWvtB26cb54xwRxMuqRO2rxeK89rk8w5pAduESyG14b7DyFoSuKxoG/NOtptR4k1+4dBiWDu5dEbBZAk4elx2MNRtMePn0KxrZsg5nj2ZGUNOmmOkwXROZhLvfnvgBLX7+TrFAZwhMYmAZ0gOgub5n3FrL1/4rzIr6tOEpdtF3+5vCUs6QQOptcfCFU8e27VcUmJ5dAEBUYaCSR4zrip4U+70I+RzA4McWmQxztAWHtw58hwqFbMz6I7HiP123QpVVBrAJB+wlVaYj69ST4WoE9Zf1P/85xo6s37H90jSC+wTFeN2xo4utOAnGWBAsOTa0+7nOnEW6lI0vbX+e53ejOC4m9oQjJGAmnAbYC7Ewp5qKZ1GtjoTmrgNE1XlM4rpDh5KAwPBzyoEnlcxASbRNWF//JaGG4GN2rsTZ1mSLRkq8dgrzZaYGbUk2BnFDJo4AoqSM+sZLQFU/I0MDH2d5AkikH3IBHGIPhl9CMNc1/i5h38hPQXzBZzyp2eoHXlREwZfrZnAM1Iao31kg7JWz/3QBcZEJfaagWS0weVk=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(70586007)(70206006)(2616005)(8676002)(4326008)(110136005)(107886003)(1076003)(2906002)(81166007)(8936002)(426003)(336012)(186003)(47076005)(356005)(40460700003)(83380400001)(316002)(36860700001)(36756003)(86362001)(26005)(6666004)(7696005)(82310400005)(5660300002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 09:15:07.4307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7118e05a-19ab-4a67-88e7-08da2e77bf83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use platform_irq_get() instead platform_get_resource() for IRQ resource
to fix the probe failure. platform_get_resource() fails to fetch the IRQ
resource as it might not be ready at that time.

platform_irq_get() is also the recommended way to get interrupt as it
directly gives the IRQ number and no conversion from resource is
required.

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Reported-by: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 97fe0e9e9b83..3951db527dec 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1328,7 +1328,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	struct iommu_fwspec *iommu_spec;
 	unsigned int stream_id, i;
 	struct tegra_dma *tdma;
-	struct resource	*res;
 	int ret;
 
 	cdata = of_device_get_match_data(&pdev->dev);
@@ -1367,16 +1366,13 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < cdata->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
+		tdc->irq = platform_get_irq(pdev, i);
+		if (tdc->irq < 0)
+			return tdc->irq;
+
 		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET +
 					i * cdata->channel_reg_size;
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (!res) {
-			dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
-			return -EINVAL;
-		}
-		tdc->irq = res->start;
 		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
-
 		tdc->tdma = tdma;
 		tdc->id = i;
 		tdc->slave_id = -1;
-- 
2.17.1

