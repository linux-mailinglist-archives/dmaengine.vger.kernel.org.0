Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7742F5BDCAC
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 07:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiITFxU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Sep 2022 01:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiITFwj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Sep 2022 01:52:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F525C371;
        Mon, 19 Sep 2022 22:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpXX6KhKqNHnv8qX3kaaNZm+BOjl7/if+3G1/gWtxoyYlcqKm4TAls9bwl9ysxbmpl55RCYOIFdHRW6CmOnutKJ/klHyWgVev1crIfM3PZn6v3wBvPxOjzLclbp9ut+MZebgqNiiLbEE5AsU6qlLA2M24F8QlX49vwNGAyc6KcjOZboURF5bBiC5GwzRHoZyQMH6OUjn6RRe6M+d21zjmooxU3hYg0t0agqJeL9ttW9W02G52/JkECPcuKv2exIbjyFvclfZGD22X5PRnfalQsV6AsHAdQHTiYBxRlwqkIXmgdXWu8eVLX/OEtNQk7A1nRVkAe31jA248E72weA1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2on7t20UqBPdj91RrUyO1ZFtWUiY5NWAr5k45JDPsI=;
 b=NbWdGHDpY72QBrCwkSfOYw2yftRWmyJi4HJ9uQzdUYXmLK7y3TLAohlfgdeiBYOF98iHq8wpzCvbgJedVVdYFLCLXJXsT2VmE/x6weknpV/ct32y1rvI6O3cMs6oKsZ7H1EVKIogQzae+ei769/LCzvwnQzX1ZYTZFb+Hdp/4nsYVooH9HT+fuA7hS5zDHlOp2Yo1As5wuqE5toReD2MYSDMCOBdmMCBV4nnXDLP1NFw6AJb9kSTUuOhXHPz0djGnwqociZHZEww2v4zRR2GWiz0oxh6CmIvPyRnY0cEWFxSnx4dwFpRCsfK2O9tZpDaTKFPSdN4uvsg/DLQY8c8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2on7t20UqBPdj91RrUyO1ZFtWUiY5NWAr5k45JDPsI=;
 b=ysl7uIyUfrLIKpmCBc07o94T9oyVZCbpiYiH0ZfYZhI/nveqYIz05BOcz9Hs9TNfybSPiIZbN4byCrYntjRAmJ7jfYmxPG32P7sqp04/iE6J5UO445LFMU4+MkyjFXY8NDa0j9zE952Lld+9j5ECprJ4wK7QNjTAB8Rt8Pg0w6g=
Received: from MW4PR04CA0354.namprd04.prod.outlook.com (2603:10b6:303:8a::29)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.19; Tue, 20 Sep 2022 05:52:26 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::56) by MW4PR04CA0354.outlook.office365.com
 (2603:10b6:303:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 05:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:52:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:52:23 -0500
Received: from xhdswatia40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:52:18 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <adrianml@alumnos.upm.es>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@xilinx.com>, <git@amd.com>
Subject: [RFC V3 PATCH 6/8] dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical usecase
Date:   Tue, 20 Sep 2022 11:21:17 +0530
Message-ID: <20220920055119.12634-7-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
References: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ccae9e-a837-40ff-1798-08da9acc4b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHVstLJQyF/YVH5VTLlmaY+jOdtPIm2gt3eeWU+daXY2qxGMYdlRS0mMydvmEywcyQma3QgbwAc/HFQrvb7cRZ2WKE3YdEdpyQF3PmsPCYDX0Lowd//DJXJNK/O71GG1a/ABS3PhGWjL5QcnscFi33lwZS+tiTBw1KdiZroJK8a1vewmg1HZDHg3GnbMEhHe4GUopyl/eE55+ZRSntZHlBW16GHVKoDZNwXiyQ9aC+3F10yOjIt8qelnP8XRy8OX6LdRbgXXozR90LOBAPNDN1nQI46c5RLQILVpK1tnXBrW9zZOQXx5/Ps90HGChCYVCC8qV4iy+r4p73ZSqibKgRmH1+DNbzToQIEzmHI0gEv3Rucb9TOvcrz6x61v4PFY8n1uCv/qz0j+TRV4c79HjsASMSveNscoWWmWywBJWLz7+ECmVcKDPeGKkeC1Gs3oBFJ5OJ/WIpOUbdYpHfjgFc1ioAT2KeQQ2aVyCLA4snZAJ2JZalzJWGQvEzcR4WM2bdDfiH5D/AVhiHE0c+ZYKgCGCoYYi8BwhTceDsx5e5lAeHa2Iz/BGp9MgFrgF/EQPiiceVvZ+W7tHrxQpvY4nylsrwEEJFuLHqiDCPfGPsZk1+GXQLtVICFo59UNkHvWZI5UDjgtG/iPw8Vfl5MYtIklrDxj97q0xahBixyOFn4f4JMTBln6mivdstOLYqyy8scORRbcK5cXrCUb0Foa3uEpIDCPxTkgRH1F5WWxrnNXaCdvcrStRt29dxQzi/EvG+AwB4XpdMz/5aNYkM079iKzpMaa21wTTwGhyldyKbbiOpqur5Z+N11nkmOK345I
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(8676002)(40480700001)(336012)(82740400003)(426003)(2616005)(1076003)(186003)(83380400001)(356005)(81166007)(86362001)(47076005)(36860700001)(5660300002)(8936002)(41300700001)(4744005)(70586007)(4326008)(70206006)(2906002)(82310400005)(26005)(103116003)(54906003)(110136005)(40460700003)(478600001)(36756003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:52:25.7220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ccae9e-a837-40ff-1798-08da9acc4b9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Schedule tasklet with high priority to ensure that callback processing
is prioritized. It improves throughput for netdev dma clients.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
Changes in V2 and V3:
- None
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 1488cc6a299a..8126a56980f2 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1848,7 +1848,7 @@ static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
 		spin_unlock(&chan->lock);
 	}
 
-	tasklet_schedule(&chan->tasklet);
+	tasklet_hi_schedule(&chan->tasklet);
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1

