Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04924A7467
	for <lists+dmaengine@lfdr.de>; Wed,  2 Feb 2022 16:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiBBPPq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Feb 2022 10:15:46 -0500
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:21799
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229758AbiBBPPq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 2 Feb 2022 10:15:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR+IdV3g3kbSmEtRGhtoyZycA28QvnPLjM2aICjb8dyPe9tBZMki0jwJZyYXJfTfSmIrkIB+8UpH8O9PpSY+C3MppT2Mf0VSnxD8gWvl5at8eixqsLj2kyb47hreQfMBxVjnCW5SsuL6vIRjFtk7rYQJZ0nrEAPt2x22HtzxGLSH8GFhmONuxI1fMSb8s+MS/TpTBTg0L3fP3RCQGo04XfNq8HXJ2YFIzT38hm/89PR2ObviJfBInjM5WIPKpbeBqSx2uZS5XW3z9yh5LenBHm22nZXQaLJbeH+rKGTQTmKePt2vPmSMAvrIg0xTV1xoofxfPKPtSoDj2Ei3yv8pHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFEn0UUnaUvIrAwe2SsbLn28fGMHteelCuGN/CViotY=;
 b=go/rKBifldCbcyJRIbiuVtgr+Ik80jLE696iPcjmi53Mcphui+8iPsbo5Qe+awRAuoHNNwjayaylu5cJwZAF3QYiWWXT1wFpCxpcLBkham8nnXaBB+982p263nzMR+F5eLlV2TnzUeIORsSWBTfz7xPn1qI6cqr5SUjMDDaStIY1jSzCnZ8fOhyyeCEYA2ih5F0/YqvVcPE1kPsF1GBJWn9S6+AlAq7cTR3Z4MuYWO9oqfVvQv4WHewHJpFWDXJJgyhGWkk8pDrMz0Y/54mscGaFt8oaZVy/ImE8fX+/Jc7T2WIzlQa6zSALyJxPcO3P7daCaBk5TLNE7feFuvZyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFEn0UUnaUvIrAwe2SsbLn28fGMHteelCuGN/CViotY=;
 b=n+90alCJcS8qj/x4xLQ6yqIDeJoSJpK+N8yjjEbkTcueDVsU9ilvIe/I6Ji5xZcUPBQCPGAkrIbFhycNSdJJ5TXUeArYnRfUJnok/QqmqT9YDdldGCN/HsUi1b//iK9u+2IUTtHapfDg9yn54ETCIbmt0GSB/Ssf9Xqucgb8/Vk=
Received: from CO1PR15CA0067.namprd15.prod.outlook.com (2603:10b6:101:20::11)
 by DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 15:15:43 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::73) by CO1PR15CA0067.outlook.office365.com
 (2603:10b6:101:20::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 2 Feb 2022 15:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 15:15:42 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Feb
 2022 09:15:38 -0600
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 1/2] dmaengine: ptdma: fix concurrency issue with multiple dma transfer
Date:   Wed, 2 Feb 2022 09:14:39 -0600
Message-ID: <1643814880-3882-2-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643814880-3882-1-git-send-email-Sanju.Mehta@amd.com>
References: <1643814880-3882-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8681760-4db6-4865-259a-08d9e65ee125
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02196BF0B624D803E3C8EE12E5279@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dn2k1CPKx3tevrp3kTDVsJVkXtSjmY00/+ONpE/Wv9oe1Z27FW7mg7/0sph+2LCvMyZfDlI8Nb/Wpeha81TbSWuGuMHm5mPw4rfm0zsaqkciIYTBSc5aeBLZjwACjALG2y7rpsYIdxsoboyHnYtFtyr2m86/fZyNcFziB1BbSxMNmI8WVAkJEzkr1/zm+feUsWQeDyrQZ6K+nXixgI6+kz2Eeyvww9WUs1cjPNZVifNX/H9CBhc0Ty3VNJsf3EqHBQXPiw7ijOhNE1XMaHiJAj8F11e1GeyaWfmO53L+Xy2Yfnposs2H/6ia0rBSTDr++63lkjnZsJb+KGa4YJO9P/lTBS9skzpIi6x3p+yhgy1n4VeGb/8cV0grSwoEvNsHLDvQ48tu2rFF8bgFjBWDKAozCKBWGaGtYt4dMIY7Xa7CHRk2uzAswxEJkJNPFZ/MlN72ThKDNgkA8Vj9l3OwP4LRY7DJGOa3S5U4xYuh6zDmy2IfRvlZNA2YnrrXumxrPNmEsM601qM2YmCE9MCEF8SAsVBXCMFZ7H1fkz6mq4TViX/y9nhn5gIgeiZNIflIuaL6mgFsXR6asuonv/srBnnIaqKP1EyunFqeCNUZe91PK2HZkXYzWVdcGqoOw3eZr2LGRPeTe+dsHN1Bg7Ml+3jXBO7ytG30WpCYp1WHDKGcBZcCzWtirappozAti8DfQjC4+R9lu2ItN8s+vtiCfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(82310400004)(81166007)(356005)(40460700003)(36860700001)(8936002)(8676002)(70586007)(70206006)(4326008)(54906003)(316002)(6916009)(5660300002)(26005)(16526019)(36756003)(2616005)(426003)(47076005)(83380400001)(336012)(508600001)(7696005)(2906002)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 15:15:42.6383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8681760-4db6-4865-259a-08d9e65ee125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

The command should be submitted only if the engine is idle,
for this, the next available descriptor is checked and set the flag
to false in case the descriptor is non-empty.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/dma/ptdma/ptdma-dmaengine.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index c9e52f6..e38dca4 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -233,9 +233,14 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
 	struct pt_dma_desc *desc;
 	unsigned long flags;
+	bool engine_is_idle = true;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
+	desc = pt_next_dma_desc(chan);
+	if (desc)
+		engine_is_idle = false;
+
 	vchan_issue_pending(&chan->vc);
 
 	desc = pt_next_dma_desc(chan);
@@ -243,7 +248,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	/* If there was nothing active, start processing */
-	if (desc)
+	if (engine_is_idle)
 		pt_cmd_callback(desc, 0);
 }
 
-- 
2.7.4

