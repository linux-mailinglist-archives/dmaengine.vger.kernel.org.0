Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB8750FAE6
	for <lists+dmaengine@lfdr.de>; Tue, 26 Apr 2022 12:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348804AbiDZKg4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Apr 2022 06:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349099AbiDZKgp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Apr 2022 06:36:45 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2072.outbound.protection.outlook.com [40.107.95.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2F8167FB;
        Tue, 26 Apr 2022 03:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBgo6rhiXP09V85TIRIxTO9E7ySmTFprHQ5x6CeC8o+9RVPZSmIWbMjOcOgzXd/bxIbCr8c+knycU+R67AqrRV2jJLPPGZ7LEKA/2iYexjMfNdoNoFR7mpF+DSID6r4TTBiLIi5YGtUQD8xf6m8Asj5UAJG9OJb9TzYGZ7Ga+i6tyy+cc+oaZot93Oo3jUXF9YW2bu+lWl8GqCNJq4zxkRcTPt+ruTKeNzfVK1PRcNa42A8fQBwXSshOos7hG0fqAElrUFIX8qqTO/Nsz5rtDa9LOT8enHy/K7jLb42Dni9FYzcfhriOyctv6CP9aHWRHe2opEmyJmFq6bi3iv4yZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkvakEUr4aJmQ0SiGUuq++H44bnTQP5wqbXieiiJN/k=;
 b=CSk8nOjx/3Yjm9c0IbDF2YstoOhVrm5irUiEC/dSdFvAKgBxREdGP5Y6SdDq31pCooqBSmWHMy7f6Fzw3ocXSnPd04MWUVW5mUQ5IvD8FI/r2Pmo9il4kg3HVdZ0iRi6r1a+dRKHfvf0waabokd0LffUl7YggJyIBlBQ4UoTiVNhAdeBRluNac/fgL0+w+GZANlcejcS7FpjsqFwAwfY334n/RkPalZ1+ciLKAye5DcdvlqKkhumyjfqYGiRYYcfGlL85IgEhd3C1ck9QHQSc8eO9hSn/QaBUBkwh3ioIb3l7WJS1LVEPVt4XdaL5KAozx8J/9lTEtDgb3OEmh0vyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkvakEUr4aJmQ0SiGUuq++H44bnTQP5wqbXieiiJN/k=;
 b=C/8UpvVlSQ7D7mKu95jxhJXBHlRPADuBiFTDXvSjcVG4F1xumnUyf9evR2i1n3CzbtAfw5hIOzPRk6stKa1sqeJ2TcX000eKXnb2d/RbAbkzt0oAMeN926nWU27il1gwb3bp/IVurIMe8uWDCSFhlRwAyy1UT+ed1erxmLPHCGyO3FScxcHpcrqcy9VspqWPykHuIu8pLlhE/JWLRrcZ4RJ2GbXkhoneJqYfwPrMC51DXvn7I7Ozcw7bH3jD4A3MmMDlHzbbB4AjGTo1KQp+SoNEVIkQxl3nxgvbdE2pjXV+zh2SZZhJpO8iCPaIS1v+yH3t0jqFivyGljX3k0PFYA==
Received: from MW4PR03CA0225.namprd03.prod.outlook.com (2603:10b6:303:b9::20)
 by CY4PR1201MB0039.namprd12.prod.outlook.com (2603:10b6:910:1e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 10:19:37 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::c6) by MW4PR03CA0225.outlook.office365.com
 (2603:10b6:303:b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 10:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 10:19:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 26 Apr
 2022 10:19:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 03:19:34 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 26 Apr 2022 03:19:30 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <nathan@kernel.org>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 1/2] dmaengine: tegra: Fix uninitialized variable usage
Date:   Tue, 26 Apr 2022 15:49:12 +0530
Message-ID: <20220426101913.43335-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426101913.43335-1-akhilrajeev@nvidia.com>
References: <20220426101913.43335-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2340066b-426d-48eb-32af-08da276e444b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0039:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0039167033ABA498B2274C9DC0FB9@CY4PR1201MB0039.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9pYOEv0qxaBFvFLfCGkHXHfEENbSvv6pAtqMrFDntqHdrrPqeW84swixCM7dtnnJlrhtHDJrVE9NAMUMa8iTEf+cQNxQew7a+f9pEIAY4QXhWB15r4kVWfDbzxGgPfqOzaHxsUWOIxFZqP3Mhcy5o6hLz5ppn9RKxnhUD48NQo35kPXaPSD7sF1X/5RiB5rCqEoXU9suhwBW3zFDQ99v+nwR0Oz+rF/L0JFiChYiH05GkVv2UD+gka5DJ4sjJHt7T9Ir3smELZuZDTp4H8YNNhUA22VhT4vtNix3OQziq6EMBMGks4i/wXl8xPoe48YBWWtQF9WagH4F0vo+lXrwjIruTUEsLvv9OEq8FNeXiGuUkru3SdYYI/qcIutTz+wZFdpofU3XUKoe/Ep8qF9e97WX7MsZY4Focw2DMiMIxtylsc0M0Ha2JznLRDJuRRKI9WIa3vObRzX2a/V7M/UpgmIDlgSd6Dc4d1HChkO2Sq0HhFvNtv23VAVYgfCULSS2+hFPbovOnuCZQw2ougyujJ7YrN2rZsH0nxQOtAO/byhS7oVx0z9uLrd6WGNMfstl62MQOnN2ONOwIjfJONBo9ccMUrj3KDh8TCFijMWD53LKyp4nJ74dgYggTVC7nPT9M2yLMTmBc2Q95yPmbBpNKoClmNLbqh/67DmyIxTkalLJRHk/LlDBJNvgtsGqpo6r18a8iHHFLouvmD2iB8wrbCQasi+nIUkqffHR1/ElfmHLKhhMUB88RbldD/VqpR1iDyWpUTH8WZwc/x7Kyb2kA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(426003)(336012)(186003)(2616005)(1076003)(47076005)(5660300002)(82310400005)(36860700001)(6666004)(7696005)(36756003)(26005)(83380400001)(107886003)(316002)(8676002)(70206006)(356005)(921005)(7416002)(4326008)(8936002)(2906002)(508600001)(110136005)(40460700003)(86362001)(81166007)(70586007)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 10:19:37.0917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2340066b-426d-48eb-32af-08da276e444b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0039
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Initialize slave_bw in dma_prep*() functions as the parameter is not
set for DMA_MEM_TO_MEM case in get_transfer_param(). Though the case
may never occur, initializing it avoids warning from certain static
checkers

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index f12327732041..a0dbafa07ec9 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -985,8 +985,8 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
+	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
 	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
-	enum dma_slave_buswidth slave_bw;
 	struct tegra_dma_sg_req *sg_req;
 	struct tegra_dma_desc *dma_desc;
 	struct scatterlist *sg;
@@ -1103,12 +1103,12 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
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

