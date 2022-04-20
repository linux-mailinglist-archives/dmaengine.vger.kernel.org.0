Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D56508926
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378958AbiDTNZq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 09:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378959AbiDTNZm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 09:25:42 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D9642A2F;
        Wed, 20 Apr 2022 06:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA2tqvu6fywnfWIDVUDA8RMGmkZzhOGUzwZgQ80k56Ixyx8F+hDirNRyIe7AawlRIgwwqRlO9SaB94TL4k0EqdaFdBh38Stzn39SG/Omshp9yF0rztMtuNE8McxA2tnJLdvhFv7LnvTmoKMJQFs/W2h7mBUKMstSf1ocWu38g9lLxbap7+yZt5LKERaL45EKpUF1TiB3t06SebMNstnZkyodPMkbbdMxrGCQ3vuZBPswajXOYKjFknFr8Z+AnRddaeVHAH/SKXBZHC2NpoU9k8n3/GmDixFmb1KVBtwhRO0U8Sv5XCTyvMmZqSbRnCMrPtTfn+xkmu49CuGqogYOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYw16jA9KoLAs9mW3GRc9IepREi7Gktcny3vloUBrPs=;
 b=ksTbK1/eJqWH+zyvTAGCxtW8kp/xYu90sx16CixX6a1uSCTvESCT5GfjJp2Nx5kxvaVZwX39dnPIDoStPI8/Bo+6h11hj9Kxls3B/JFUqs0ey/hzc0Hjz6l+Thr68+qgmTTonFLkIvbsjAlMzUMVHgYHe7OwCLa/pCS0UIxaufDYc2TjwG9GcW6DAMqgQzGzJ1vcyOTSbrkIlMZ4B08NhaBORukfMCSday4/ta2jiZZ303SXoHtOhrZzTbNtDXigeuX6d09r45CDjaF2eBrwDYSH0kJBTP1jeivVFWOMM1y1eOS4VkMs/49CFGwLgU6HanLAoQjDCoaAgJgLrcwjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYw16jA9KoLAs9mW3GRc9IepREi7Gktcny3vloUBrPs=;
 b=Mj+d8nOlH/h+j5GLU/6tVr+aQBhK4s4vzdznWCTUXToTeZ2eX+bmORpbquond3bifu5HtAUqDXTcNuHzCRcP0rbyYv+Zn0muoIoIgjN5lBcPQ+o56HantUt2mDt/6BDXQdWfuo0Epe7lxBmBgdeJlWyqY0Y5A9wBYByqDuV/3JZlJGNEChyjQDA54dr3GiDDY9+YqCRNxEn2jWRMBKv3D/lxdd7947zYszJGolvy/CDeOPxgfNecuKbYhHZ4t9wkxe4uRIyHD3GkXyW8RUPXCGsLpUw3stjgxa2GJL7u6OD8eVckaLMhrAdjPznl2DEyOVoo9kyj+beRfKJaDuA1Vg==
Received: from DM5PR07CA0051.namprd07.prod.outlook.com (2603:10b6:4:ad::16) by
 MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 13:22:55 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::4e) by DM5PR07CA0051.outlook.office365.com
 (2603:10b6:4:ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 20 Apr 2022 13:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 13:22:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 20 Apr 2022 13:22:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Apr 2022 06:22:53 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 20 Apr 2022 06:22:49 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <nathan@kernel.org>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH] dmaengine: tegra: Fix uninitialized variable usage
Date:   Wed, 20 Apr 2022 18:52:39 +0530
Message-ID: <20220420132239.27775-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbab01ec-103b-4ef5-d8ed-08da22d0e142
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB42233FFEE9478525C8E094B1C0F59@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rv9wcuzf4r6pSJTHDVyjTx0FqgiiLLTUGCgMry1jLee0K0XfkwAcqa+V+KkkidPzdcG+BAb7zTJpwca19whwVV8FuJ6v8UKpY3hnhnHUl3sMEHCMU/mq3UqJhLlzN9AJKATrCej+jp7nBFxqCmfat0ohEDIBvsSy4KxFE8McCMBnLNuDenU/MpgOwoKFG1DeUkOt/jwnUwnUuVRz/2I/EJHV7PAGBybFfVRMiCY8R7XLONq4E1YF9KHw2p9nULGnA5b8qDzihKUjzL6a3DAXikAZu5gCrQJUMK4HsEFKRdEwEhxAaG29Zyswip+Wyla+kfmK9LoRr7wn6atbSvxh7s6uPYH7JO9dRwVYhUDqVvbJa9kh8tWDtjkKhllAQzYSQgHUGBYOjSb5cbKhM6XT2ssmzTFWpmX0OJmhoZPnVJt3GhzNkcEwtZNN3vz/Ld7A0Js6orKdR9jw2s3d2SQJ8z2k+KU+QUPoPjOvloI5ZPh2Mh1ceubK6h/ItIIDYNyGmzFOXMMc0QTgJqpbj1K0DZtDGJ6cNjU40S/UfwSbv/G2xxD0Q+5SNZ2RNWY7KITh70SH6adyRuoNa+vueyQtK8UaO2RFEtIxIZDntegWpGWgK1QjcloGQ5Rea+TfxwmofHumNF/+52frIw3y114OxQbUXV7i5l8j702yorWSP9e/R0huVMqnTfBBKAtjc7O0sRIsFnG35ZTqGzuNEs0C2eXZCaABL9w7JAh0dyNPlTYeKz7CR3c5miuUYrLXs+bgOAS8FmYNbvy82LSadl4Uhw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(356005)(5660300002)(2906002)(36860700001)(426003)(83380400001)(921005)(7696005)(82310400005)(1076003)(26005)(6666004)(186003)(336012)(36756003)(40460700003)(86362001)(107886003)(316002)(47076005)(81166007)(70206006)(70586007)(7416002)(8676002)(4326008)(110136005)(2616005)(8936002)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 13:22:55.3049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbab01ec-103b-4ef5-d8ed-08da22d0e142
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Initialize slave_bw and remove unused switch case in
get_transfer_param()

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index f12327732041..6b8d34165176 100644
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
@@ -985,8 +981,8 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
+	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
 	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
-	enum dma_slave_buswidth slave_bw;
 	struct tegra_dma_sg_req *sg_req;
 	struct tegra_dma_desc *dma_desc;
 	struct scatterlist *sg;
@@ -1103,12 +1099,12 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
 			  size_t period_len, enum dma_transfer_direction direction,
 			  unsigned long flags)
 {
+	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0, burst_size;
+	unsigned int max_dma_count, len, period_count, i;
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	struct tegra_dma_desc *dma_desc;
 	struct tegra_dma_sg_req *sg_req;
-	enum dma_slave_buswidth slave_bw;
-	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0, burst_size;
-	unsigned int max_dma_count, len, period_count, i;
 	dma_addr_t mem = buf_addr;
 	int ret;
 
-- 
2.17.1

