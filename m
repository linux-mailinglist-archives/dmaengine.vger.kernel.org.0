Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051326BCAEB
	for <lists+dmaengine@lfdr.de>; Thu, 16 Mar 2023 10:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCPJda (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 05:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCPJd3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 05:33:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C5367E4;
        Thu, 16 Mar 2023 02:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9d6mCglONiYnj5gi6QkPMF9RFgDmZfSNnsadMOhnY7zw/U4P+ypuGmN579rptPANeV/+uLQK3UhzPNNxA77UgrFSEKhTKJRjT8ihLc2dpwuldcvjtHbNd9MlI660OHh9Il6Di1QCSk2PqKS6/qnXaRwuJpa4nRI0Od4GLyM65dBnflEzCOW+QM8dyXgx6wRRBiKBJ8q10QvhMQf+bDH9SvlNuQi98SgYmeREvbNylvute/RqA/MUjrJiwWpX95Xy2/3PWlBwd0laPX6u28sCjXf185QevSSQTn9IWhUw5w5uTzE72CoMrayaYs+w9+ViepFVShoQ+eNoRlR97ELGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEzLnOdLHxAfbHCdX9qskEDs1Q3F7pkJ47Uteu7FGZk=;
 b=nPtpe+RL3/TB0aGGOIKcdc5qSz1jcDSkztx50QA/Pm5czXrXAxWJwanqAl0WZ1p6vy3zyguaR/ovCDEv50wFTUUIZ4AhoHLzvpUmFsR2+j3u68AmTiPmS636IxkU/qHVJmsjAloksFVEk/g3mtxE3Xb+afoxV/l4NLtlMT6ZFM8IdmWDFW2oO3aHKqsCwGvjzjjTfU2tyyV+e/JgmpJ0Cv51zSmDBc9BfmZF+nWODNnB32uOvfE3fYiYUJh/wd9j9IWYRS5muUOkStUtxLP6No8TqheIRSZ+Cye/v8hRB8v5CZoKzOUjOsNQnIdmIprudPld5tywefUGuJu2FrhlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEzLnOdLHxAfbHCdX9qskEDs1Q3F7pkJ47Uteu7FGZk=;
 b=xUEVhlqd67uFMqgUd6DbJHoHUaBBQaX29YLbtiE8/mhw0BUPBEmZPDxmVXqz3yhvfm6W/7NhQ/0JMpGwVPvE0VFatZAmB6qt4cpMyRknVzVhYwQ3RxmrOXjNcQT2hYEwci+UCfRXVnXJpmC3tOmcrFq9ji9VoTjSZb2z8AbabEs=
Received: from MW4PR04CA0169.namprd04.prod.outlook.com (2603:10b6:303:85::24)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 09:33:23 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::a7) by MW4PR04CA0169.outlook.office365.com
 (2603:10b6:303:85::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Thu, 16 Mar 2023 09:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Thu, 16 Mar 2023 09:33:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Mar
 2023 04:33:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Mar
 2023 02:33:22 -0700
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 16 Mar 2023 04:33:19 -0500
From:   Harini Katakam <harini.katakam@amd.com>
To:     <vkoul@kernel.org>, <romain.perier@gmail.com>,
        <allen.lkml@gmail.com>, <yukuai3@huawei.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@amd.com>, <harini.katakam@amd.com>,
        <radhey.shyam.pandey@amd.com>
Subject: [PATCH] dmaengine: zynqmp_dma: Sync DMA and coherent masks
Date:   Thu, 16 Mar 2023 15:03:18 +0530
Message-ID: <20230316093318.6722-1-harini.katakam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 17502291-9e6c-4bed-a7b5-08db26017cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1jxUmnvfDsksQKKRt6FkzKoigmld32JDIFQY6XGZaLLwZD9m+Nnd294lLbPZzSgC9fiZzctaX7dWsvJ+bdwvuiGrnBv0RLZzQMZ4WeKA9qUq5Hyv5WRmPSAiinkGjyEDh6667AlU7WbmJ8CCC43jRCxtnXhtBfbN0pkKXkgU0u84mdeeKl0zt9MMd9i0LkVU7cI8ND9J1wotAqZ2cglVOg0G4SR7fhnWEo8ckhhXrUx+kDm9LuVFoa9EFNwSSXnL7yi+OsRZugGyRCmlxLmC5l/BXk7a9WUiw407CNbmqP8EmwFv+XumDVI1ZowhrvVXPAAUKNaS0ZzXwAcdbciMkfSXFRI4Ii8/QsIX6RJ2SWFNtyP6WzSP6CwumN82i9tFFtWAKsEe18+lMPjeUqqbvtFt5LBqWmKduZPubwWKiUzmTSlF1EeqhTX7LSUUrNB/bmQFpmfOJ7RZeUGDh5alXHTIsYR23FOgC+LAoAfToVpFruFQ62hG9GzsisFg2h0+fdVa340QoJHUyivn19g2yeTqFE3EOvjpTqzP3fZn3mqLXuyrse8Wq5IwlWLAOv6QGDKyAQzxgVtkyhhXhjlJYF6wwLU2NVV+WN242RhaLGKPTDSNA86SUooSiQoY4xYnBVXVN94qnq1OvBgfWj7cipFFvTNcVPRL2bfTSgoYTLfcFxMz0hbRcX7NGBZI3IwcsU+GHI8BDn+1xh2wsVm2PcfNMuxc9zgJbMzv0ulIEU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(4744005)(41300700001)(8936002)(5660300002)(2906002)(44832011)(81166007)(82740400003)(36756003)(36860700001)(356005)(82310400005)(86362001)(478600001)(8676002)(70206006)(70586007)(110136005)(316002)(40460700003)(2616005)(40480700001)(1076003)(4326008)(426003)(47076005)(83380400001)(54906003)(26005)(186003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 09:33:23.1842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17502291-9e6c-4bed-a7b5-08db26017cc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Align ZDMA DMA as well as coherent memory masks to 44 bit. This is
required when using >32 bit memory regions.

Signed-off-by: Harini Katakam <harini.katakam@amd.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 3f4ee3954384..34d7d20ffc09 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1051,7 +1051,11 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	zdev->dev = &pdev->dev;
 	INIT_LIST_HEAD(&zdev->common.channels);
 
-	dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+	if (ret) {
+		dev_err(&pdev->dev, "DMA not available for address range\n");
+		return ret;
+	}
 	dma_cap_set(DMA_MEMCPY, zdev->common.cap_mask);
 
 	p = &zdev->common;
-- 
2.17.1

