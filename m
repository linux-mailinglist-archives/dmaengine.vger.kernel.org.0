Return-Path: <dmaengine+bounces-1144-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB086A78B
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 05:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E94B24E6D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 04:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF2C20B00;
	Wed, 28 Feb 2024 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZLEtMYzk"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98420332;
	Wed, 28 Feb 2024 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094118; cv=fail; b=Boo7Ofwf2bzlwnKUx7mhY2ahibvg8sijAmw/ers4qUT4Sl38xYgwYr3n1SfjOYaVGgCU+dhHGYfd4eSJ8r/AdpbEj7W4UsCRMloB1RzKaJSH+h58AZ16UHHatTQffuVp4jOlmRTcIVpsUiG5krFMcYK1G4tQcIbWRx4KG4pkKPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094118; c=relaxed/simple;
	bh=G/jrqey6cRBtmE5iCSXQcsrP5JByLhkU4PNRSGqFJTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N836xaqZ2UNyLv9l2r+lzZdQRnZeIr9WiY90IxhAgFXS9RKaWXL5c1Z9EM3nto6OKLEriUfYEJnvrfaCnBjPHPklFQqx+S6tY3Yfu/wm/QwJ5rVrtBypKZ9ltgOdcmZhDlzKadEoO1futtnPfU9PwebUFG6SHnwWEmoEq0aku8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZLEtMYzk; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKDgaJiMeK+7SWAPqynQCN4V4DvZ98ZcyV8WjZROQoLxuOCLaNQV8skH0lY32BcTtA1aW03mAdPK5YCgbOH7YGvVHnHbJbx/jWRbX3ChOAE/gRvoI+euYYp/BXgCTXXrX8JM8JFxvMcdAaQMTSYcGnzGh3aunctKE4r7TwBnBGs27r4ps2FMq7aMS2jbMFvh+8HyzjVtuSWJzaoTbjYOtAV55tjIfuEBgLuDrcnuqSduccL2xfLNIjW7e5Hn8nlDEeAIxU7Ak26ResCYizoE4mi7X/UfhDwZMcbdsEOL/ZAVkX+VVW0aUAW70euvti1t2+uz2VmTtmLgcVKvwNBf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQwwLh5xxB97fneffqQkscT5qMTpYVBhu/06VbZKMBY=;
 b=auq9DAw9M15cLMGphIUhtl8s+ElaVpdDyKVwEVzDLo7ynOndc7gEi71qQEyD0PLVLPbyx6Xv9XYjfqkN3PIVNEci6qtu6G8KGvmPhncDiPSaqDEXIGV+66AmFYNKiLXxijDUQg6dA/sTT6DzWMD1YbGjyRBvG11DlVPXo7v2OksYjiCCeTpkei70AfEA2CbYAr4xZLIhiFPki43jR6fhfmRne/yyTjQe3lQWVjxLIXmvNQXrQcofUG6qfht8u5R0GeueCMuJIDPCdqZFJADyl4h8fHPDpRNlLO7xqnFFy2cifm/D0TwfnArHZOGZoBf3+YDv3kq32+WTbnmARwiLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQwwLh5xxB97fneffqQkscT5qMTpYVBhu/06VbZKMBY=;
 b=ZLEtMYzk2Zc151HR4x2OkFy3LqLj68gG/UFSpBcuv6TQJoNDX7hQzvAOmvGCGzilZh+tw1Ri0/s2QKKvVMzMPmSTl5SYq3LRqb7vLYIjLsDaArY2bjS67EeaAdNxVrQteuN4rn9SgUZoE6QGTAKwgMMIt+ezCotayQul/HVxSEg=
Received: from BL1PR13CA0340.namprd13.prod.outlook.com (2603:10b6:208:2c6::15)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 04:21:53 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::1a) by BL1PR13CA0340.outlook.office365.com
 (2603:10b6:208:2c6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 04:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 04:21:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 22:21:50 -0600
Received: from xsjssw-mmedia3.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Tue, 27 Feb 2024 22:21:50 -0600
From: Vishal Sagar <vishal.sagar@amd.com>
To: <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>
CC: <michal.simek@amd.com>, <dmaengine@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<varunkumar.allagadapa@amd.com>
Subject: [PATCH v2 1/2] dmaengine: xilinx: dpdma: Fix race condition in vsync IRQ
Date: Tue, 27 Feb 2024 20:21:23 -0800
Message-ID: <20240228042124.3074044-2-vishal.sagar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240228042124.3074044-1-vishal.sagar@amd.com>
References: <20240228042124.3074044-1-vishal.sagar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: vishal.sagar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a48606-6ccd-469e-2ccd-08dc3814cac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k65+/84qg7/R0PuTyeK8qkX4HITMPfCo3oQZfgTJC5l6WK2XoA4VPXms56KFWkIbHBM8eCYlncvrfBtz7F9ZkhKNLQQIEgaxFYlJCluv4mndW9wlzkXER3mzjFQcahZacbavY8B1N0S6YEXYPozlLl9eWO+FhPW/1TQl7rAdIiIHARlrd7oxZaYi3bbWeNCz267/h9i0fOFMnDgCsVTEGlfqRc45I4FSfVl1L0TDDMSUJgvbkA9rRx/pEzU0BZVgL1ksL9XPWJc2JCtL+GzBO3h2FnIbXHE+5G8CYqLtRU/frouB1NtPPoKy1sMdVuuyiJnGT/a6SJo+ZJ4capDTuRAWJU78QwH+gdQgMPvWTlvicoFo9oLwPBRI5A/aEsqFKkcyITga4icuMsMxG7yFACl8E+pPuA6UavgmzJHc0cqfamQgp/5OnAnhywKZ73Akeo0kniPfghEDVgTbe4GRkZkUJc+8IFxFVkWwB0VK7xW3F2bN21rhejWgaPQ8xIgCLGUz7qjySKBTHKbSMReISpHusQOyNKi6t1Ms9wgAg2JJ8bwreL+nGcB7i5K03Zh11NvXYDBDX8d2hUtsiaLE042hLDUIujEyHpMxpnFIdyoUGykbc1+2GjmatESkPEuTYbdFuoNKT44YBQyF4JscoAkYuTslfWLE97cOAOD85IrgeegKCsMFU8+x51fUebH2oFQrOgz7e0ZtAp3yKpbMhPElBxRh8G/m5YVgU1Jdh2uescDLKV1cruwiPG01xhkL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 04:21:53.1916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a48606-6ccd-469e-2ccd-08dc3814cac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643

From: Neel Gandhi <neel.gandhi@xilinx.com>

The vchan_next_desc() function, called from
xilinx_dpdma_chan_queue_transfer(), must be called with
virt_dma_chan.lock held. This isn't correctly handled in all code paths,
resulting in a race condition between the .device_issue_pending()
handler and the IRQ handler which causes DMA to randomly stop. Fix it by
taking the lock around xilinx_dpdma_chan_queue_transfer() calls that are
missing it.

Signed-off-by: Neel Gandhi <neel.gandhi@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Vishal Sagar <vishal.sagar@amd.com>

Link: https://lore.kernel.org/all/20220122121407.11467-1-neel.gandhi@xilinx.com
---
 drivers/dma/xilinx/xilinx_dpdma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index b82815e64d24..28d9af8f00f0 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1097,12 +1097,14 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
 	 * Complete the active descriptor, if any, promote the pending
 	 * descriptor to active, and queue the next transfer, if any.
 	 */
+	spin_lock(&chan->vchan.lock);
 	if (chan->desc.active)
 		vchan_cookie_complete(&chan->desc.active->vdesc);
 	chan->desc.active = pending;
 	chan->desc.pending = NULL;
 
 	xilinx_dpdma_chan_queue_transfer(chan);
+	spin_unlock(&chan->vchan.lock);
 
 out:
 	spin_unlock_irqrestore(&chan->lock, flags);
@@ -1264,10 +1266,12 @@ static void xilinx_dpdma_issue_pending(struct dma_chan *dchan)
 	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chan->vchan.lock, flags);
+	spin_lock_irqsave(&chan->lock, flags);
+	spin_lock(&chan->vchan.lock);
 	if (vchan_issue_pending(&chan->vchan))
 		xilinx_dpdma_chan_queue_transfer(chan);
-	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+	spin_unlock(&chan->vchan.lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
 static int xilinx_dpdma_config(struct dma_chan *dchan,
@@ -1495,7 +1499,9 @@ static void xilinx_dpdma_chan_err_task(struct tasklet_struct *t)
 		    XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id);
 
 	spin_lock_irqsave(&chan->lock, flags);
+	spin_lock(&chan->vchan.lock);
 	xilinx_dpdma_chan_queue_transfer(chan);
+	spin_unlock(&chan->vchan.lock);
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
-- 
2.25.1


