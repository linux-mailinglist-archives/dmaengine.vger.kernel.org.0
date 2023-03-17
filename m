Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00B26BF082
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 19:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCQSPl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 14:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQSPk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 14:15:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E3B126F2;
        Fri, 17 Mar 2023 11:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka5/8UGZKP80iDk8TAkkV78hlMUuhJzgjKG0Cmco/MQgklGmAn3i5jmXA0s1V+Zew26NOvWk+1+uQDVV6I/m8/m5h8vKq1zHMyzayv7qwV/Xzndl/gIo4TZrpTdnY1ZuyCPk9BcS3cF7zLKdiJmCF3K1ruOAHIkbtYYStBCmMUmkDXHjWypWjewjgFAtSTptSBjcIe+G+otcPVhAz6UNdaWjhht3nka7YvAOwKyTx6QhO7YT1Y7mGyabk6p0jslIqBd8xwrtM62exJTSWAoJLsqNDkLZt8KCJ7cfbFbx23pz2YOw1fhLweuu79GpvxuFPt6wH8fYMpEt4l9qktayGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZp6hANYxIvzVVbSrrwn+vFzu5MqQh0W/iWZvw3lN8k=;
 b=PYCsSRFA9bqGw6zb8qoxveR4QWuI8kCtz9cML2aLinE4AXJ/cTkyf9lXBYR37Ij23X8fSKB1pIPBbJrPoP6MxvoOXPVqpqbA8A4RT7mduFPD7OyCsnIQiyMMGZg8jBUY2qOwvrnKPSW9LPjNC0Eo2ADElEGvS4mmt/3S3MPS+I9UMfOy6vK/RIVRhJSmgTB6ZRv4HcZVZnJFqsxAm1fqbsRQs4RpYMCK7RnHSwnTgXOmq9J7BmrZG4GQQGPE/4KG/BA7zVN/+cVqNZb5HDcYw3pP+pPuAh+Dg0n3fjTdXbd37YN1AccPr3TjPESdAmYknm18x8h62d8ikqR9zF3ZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZp6hANYxIvzVVbSrrwn+vFzu5MqQh0W/iWZvw3lN8k=;
 b=cBHuFcxrmalrIaM3IT0dkghaMriMVIB1ihBWhEfy/bB8ll9mpiMmURBC6d4DpIguST1dzv33yISBtNBqd2RDbsbn8WQWZZqzftQ8r4gy1EuC53H+d29SeIRiCZ63eMm1gGLnR5QFlCFv8gP7HVscmuNptAhK/w50CJ30l18tFnc=
Received: from DS7PR05CA0060.namprd05.prod.outlook.com (2603:10b6:8:2f::13) by
 MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.35; Fri, 17 Mar 2023 18:15:35 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::f4) by DS7PR05CA0060.outlook.office365.com
 (2603:10b6:8:2f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10 via Frontend
 Transport; Fri, 17 Mar 2023 18:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.20 via Frontend Transport; Fri, 17 Mar 2023 18:15:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 13:15:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 13:15:34 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Mar 2023 13:15:34 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <dmaengine@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <tumic@gpxsee.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1] dmaengine: xdma: Check zero length scatter list segment
Date:   Fri, 17 Mar 2023 11:14:56 -0700
Message-ID: <1679076896-4876-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 270d23f7-f967-4985-5552-08db27139a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5H6golhZmCxXdwbgB2TCzSZIqEA5DVgY4AQTTAUGZmgFPex+fipClKF6faGydLKYyLGFY008NS5I8y0R+Lqo+Nu+/Z4T0s249Dqvq+5nZSkFj+46B5PMB2rThxmFSg1CMeWMa4Wekm5sZ+YSR2ZbexLiwGrWdCAQFiqjLGkfhQAPU3u1kxOIv/ckl/4LbTGrSedilLXUjWNY2w2IKZQnM7iu1F5t0ff7nbXMUAY+QMLrRQWiX6MJhBT/2R0diej+uAI5d4F6vx9Pe6iruXcxkerDJ8LS/TWZgNd5w+FyjYu2DZ1vKEIHYgMKafh371WGiBxfr5z1MXOs5l7f7tPAJBm8a0ticNTw8oc7r9XlzmpRnrJ1qM+elk9+OrZfIbUmKaQNdIYOde7iAcRkaWAk/lrw7IfEUIHeffZBnEEqVMixhTIn2+GFNtC3dUfaE+w+gxh1yukFceCs3bjjHLRkWkDS+9H4DvpLITESQ3xnb7DfsdB7lnSIdC8xGdG6yVppo1DZNoQGOfSnhvxtf5/Tf/vzxSORnCDC+IFAuU1RYYvLJKmnZe3XYKK+ynMMoDsaAd8ZXHH6qgDNvkzysrh0OYuzwcYtOMNI5ChWcKuf1H7GcSaysrVEoMGZDt8QGLHuuV7XX+QmLMfDI19m/NHVvMNwF9kmkleJmeanufuk/EmIoLsOwySCskwK7mHSE9ljuHodHmfKsw9uzr0b43wwpR9x0fX6G6nld/J7kJeZnw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(4326008)(6916009)(8676002)(2906002)(70206006)(70586007)(44832011)(5660300002)(82740400003)(36756003)(86362001)(356005)(81166007)(36860700001)(8936002)(6666004)(26005)(966005)(41300700001)(54906003)(316002)(40480700001)(478600001)(82310400005)(83380400001)(40460700003)(47076005)(336012)(2616005)(426003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 18:15:35.4009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 270d23f7-f967-4985-5552-08db27139a9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In callback function xdma_prep_device_sg(), it is nice to check if there
is zero length segment and skip it in the input scatter list.

Reported-by: Martin Tuma <tumic@gpxsee.org>
Link: https://lore.kernel.org/dmaengine/f6a0051f-acec-f661-55cb-8b2504bef79e@amd.com/T/#t
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/dma/xilinx/xdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 462109c61653..5134757e88b1 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -465,6 +465,8 @@ xdma_prep_device_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 	for_each_sg(sgl, sg, sg_len, i)
 		desc_num += DIV_ROUND_UP(sg_dma_len(sg), XDMA_DESC_BLEN_MAX);
+	if (!desc_num)
+		return NULL;
 
 	sw_desc = xdma_alloc_desc(xdma_chan, desc_num);
 	if (!sw_desc)
@@ -488,7 +490,7 @@ xdma_prep_device_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		addr = sg_dma_address(sg);
 		rest = sg_dma_len(sg);
 
-		do {
+		while (rest) {
 			len = min_t(u32, rest, XDMA_DESC_BLEN_MAX);
 			/* set hardware descriptor */
 			desc->bytes = cpu_to_le32(len);
@@ -506,7 +508,7 @@ xdma_prep_device_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			dev_addr += len;
 			addr += len;
 			rest -= len;
-		} while (rest);
+		};
 	}
 
 	tx_desc = vchan_tx_prep(&xdma_chan->vchan, &sw_desc->vdesc, flags);
-- 
2.27.0

