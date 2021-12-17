Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270D647884D
	for <lists+dmaengine@lfdr.de>; Fri, 17 Dec 2021 10:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhLQJ66 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Dec 2021 04:58:58 -0500
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:55520
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231983AbhLQJ66 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Dec 2021 04:58:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5JHKqQFPgxQKOdVAi2tWdqKLtK0Ia216XkBohaMdlcZeqKm5YZRu+7Y9oEfHxNlK1WtkgbCaNxB7KIpNVw/9DIelv1XywUWLZP7BjDXCNZUAOY9z8C0t0QDfbZyz18j+dt1MnP3Hbm5Av2c6AcoZkGR9jHtQp8rd3K+Iyn+PaE4P6zpAcpQPAM31Ougu/llFMyGgGCWA/Frzko8VJ7VQ4Y5oBw5AqKlKplQgy0S6OueXJMUvvpmUwxJ+pmSpFLZak94vC2Ok3B5+rITGHysC33CIIpmrFzQjyhdjgQ9p3PaoXq1mr4O1CIm5WqaCIVp6NUfakvOsQPk/okXdzpFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3Kyl6QH3KgJIIQZ5kzA+/5EaRPv33f3bLVIGMxhEic=;
 b=T9jUO0jwka6KbSHnjOC1wRsgJD5vGwUNsKviEfKVMU0rions/OrsLGWmhrNiJi9RLJ5ukrljiqmNYANcd2UWL2md5gbcEIN4gjBDbiRhoycGMg+Bq288oHvpuEpiKR62lKDwx1yaFQyAB7+VyB3YeNFczfSqY7jhyLxP8OpVWY6E5ohbJYs+48Tz/xbIqqGuwRELNSLPZHQrT+50To8I+DBJ/IFqMkfWg9p3VWscbVxFEBRVuZrjhf5sphl46AKRm0RWlcvZFapSSOG9JINepebHTcv5oExP2d49ibsJdsf404G3IHBvBLeKeV2qS7Bk2nfN6jRvoAJ+dPQnwkfzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3Kyl6QH3KgJIIQZ5kzA+/5EaRPv33f3bLVIGMxhEic=;
 b=C230Peh2oiRQN39EixDDEFN1kQ3jlJbOJZX8vR1sSPdlAqTiPQL0ayrC9Ho++s8TX8qBo400pOl9IY56AkAfSyDmzB5wpkSx4ihyGy5uvNyIj7ur5JZ0P1cYwcrtT2HhMZDfkm3WlpnePXc24Un0JNiuFLSPoFLovyMRn1FKc9E=
Received: from DM5PR05CA0012.namprd05.prod.outlook.com (2603:10b6:3:d4::22) by
 MN2PR12MB4784.namprd12.prod.outlook.com (2603:10b6:208:39::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.18; Fri, 17 Dec 2021 09:58:54 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::79) by DM5PR05CA0012.outlook.office365.com
 (2603:10b6:3:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.10 via Frontend
 Transport; Fri, 17 Dec 2021 09:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 09:58:54 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 03:58:50 -0600
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH] dmaengine: ptdma: fix concurrency issue with multiple dma transfer
Date:   Fri, 17 Dec 2021 03:58:38 -0600
Message-ID: <1639735118-9798-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696ce793-fe2d-4e6c-8b82-08d9c143d5ac
X-MS-TrafficTypeDiagnostic: MN2PR12MB4784:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB478454109150774880BF3010E5789@MN2PR12MB4784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iq1Hea1q1JU3UhkXtzO+KsJl/o/CmQF69vJL61P+mXN1gI32uHH2OZPN6rBKoxo08cbPgzXnrsb58/q4SK23PKGPK/fxmOH2DUKEGXp3D7+PgayBtkBBuA/vn21lsTC0EuzMwRbhzdpTVJ7aikZMVg3G58496Z9raAkLAi9qn3PauvbXwB2qGcTYrcRJrA2sFq+yEwQOVE8aKHIIZB5ldUcRGoyaY1orcW15nsnaAMZyHIpqFvVkkR6VFaIwrLXe0j/ceLDlZemlVBk9prbXD7DkjuFTVD1poTKDUBcQHa5NqPWmdm+0PIX0zwIRitnJKj1qVQYo5xI3/+jSLdVeJiH/I5GAMK9jNTGDmGDqJhNZuNXfI1+DVwCqReFebgqbFWC4LO3f9DB0sMmbcXR00xuVeO50CwZfLhxCDV1vqW25gPQ6qIRTlLMyLDA+3X52SpOCg0+q8W0JHCcH53zcs+XeqkP15stHGpzTP6gNgNeS+I3bSxyE/Tt3hOc0CyVwpRkD1KZzRcLLo33Lmcr4gyOyynLefskn67rzKYyLiXfcmKVRYKJS0UnzY5dYCnIcCPcndwAgmRqpsQi+JLbbzSEx51ptYmunIW1K01OaO2R6ALSbwvV3W5eyuFxLPAFmVaK5fVYTD+/5EH2skL0jPe9L/Eh83zFbzczk1fHOgstSrxC3sGIOzBBCgfa6Eew+YcSpyLAF8/eTkXXspnSNtBq2Ypq0DLNq4bW/6syGtM1PoFnMvrLJCYyTkeql1UVaKC6H4/zzszE8VDQY814zh8hZ9SujnMAziDjgwGBv8aM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(26005)(36756003)(4326008)(2616005)(316002)(83380400001)(70586007)(5660300002)(81166007)(426003)(356005)(8676002)(336012)(8936002)(54906003)(16526019)(86362001)(70206006)(6916009)(508600001)(186003)(47076005)(82310400004)(36860700001)(2906002)(6666004)(40460700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 09:58:54.0679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696ce793-fe2d-4e6c-8b82-08d9c143d5ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4784
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

The command should be submitted only if the engine is idle,
for this, the next available descriptor is checked and set the flag
to false in case the descriptor is non-empty.

Also need to segregate the cases when DMA is complete or not.
In case if DMA is already complete there is no need to handle it
again and gracefully exit from the function.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/dma/ptdma/ptdma-dmaengine.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index c9e52f6..91b93e8 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -100,12 +100,17 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
 		spin_lock_irqsave(&chan->vc.lock, flags);
 
 		if (desc) {
-			if (desc->status != DMA_ERROR)
-				desc->status = DMA_COMPLETE;
-
-			dma_cookie_complete(tx_desc);
-			dma_descriptor_unmap(tx_desc);
-			list_del(&desc->vd.node);
+			if (desc->status != DMA_COMPLETE) {
+				if (desc->status != DMA_ERROR)
+					desc->status = DMA_COMPLETE;
+
+				dma_cookie_complete(tx_desc);
+				dma_descriptor_unmap(tx_desc);
+				list_del(&desc->vd.node);
+			} else {
+				/* Don't handle it twice */
+				tx_desc = NULL;
+			}
 		}
 
 		desc = pt_next_dma_desc(chan);
@@ -233,9 +238,14 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
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
@@ -243,7 +253,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	/* If there was nothing active, start processing */
-	if (desc)
+	if (engine_is_idle)
 		pt_cmd_callback(desc, 0);
 }
 
-- 
2.7.4

