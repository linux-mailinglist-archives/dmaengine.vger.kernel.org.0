Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B624A1CD504
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 11:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgEKJcq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 05:32:46 -0400
Received: from mail-eopbgr00053.outbound.protection.outlook.com ([40.107.0.53]:42266
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729388AbgEKJco (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 05:32:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRlECSUZaEU/OMXQBsxDn1tVokQqFx9d58w/S83mDYBHK6mra6z/WGcL5DoBlKbe0vbLg0tatBzdmY8lXi1/9Sege6Jim+xjMOuhQQiaJ93xNSLVeBUT5+JcJx7ybkNj7gqBCXsr/Gwiirq/oBQ4Z0CDJSDMofw2wi1z+0+MCFTSi5KS0gO9VYediaNmwH32rLNtXZrSHaiPvAUNsqTT9D/Q7YYaA/S4tSOzGQHbAWdPrDQssC5GE7h4Z+k4alJf3OkfiS5EN1f9VWq3Ry9tDr9hzWCUHUD02RYnpMYuRAhne1ktEGALT4X6vTtMaWNo4j9RU8mQHTpl/eiodbAIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQU5tzf+t2t35X5OIBCsPxLxNbwkyyrYCJLs6DM0iyA=;
 b=aG/g78nJZsRFXbR+JCfMjud9aJnKCNuxpX5wHv/bgmMSctxOTVQKlNo4Tx3LWkaiaQC7vMgYn13DdqvffmOwNZZDDsUREikV13cI0soM5oeWXF6tFXiUqWhL78/XWZR1fGnZvr/4XUyfPYTSO8mNUBKdNdyc3aky8gvk/rFUk09pxKH3bAFzi5VSspyR6EPcHuSgz7GABKl4j9Wnz50oW2fif6nzyDwmVcmbrrfgs53l2JjbPQTVYaCvU/FfG8ARcSfXTqn7pPOgJCGAiPIymkL8vfm9wyBq5l73bhzSz4WgXyO5pdjrySeAyCpBJy8YTvTLuOCxdwLJOm5/LvZUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQU5tzf+t2t35X5OIBCsPxLxNbwkyyrYCJLs6DM0iyA=;
 b=mdZsupbcLHNAyz0sCLdOzRVTbBxOG09ZZv5u3jA4ehzi6bPGFckJpOkigzcT3opzFMKObAR/fKFTvh6LeEF8MlZ5wmVv9t9YlVYU/F0DMBgWkyYQbpGXo4AFxtUUBb/viBqV3nYt87XwJCW+QtN1VMRlnGRvgQmxnqvP5JaXrVA=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6637.eurprd04.prod.outlook.com (2603:10a6:803:126::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Mon, 11 May
 2020 09:32:40 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 09:32:40 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        catalin.marinas@arm.com
Cc:     will.deacon@arm.com, l.stach@pengutronix.de,
        martin.fuzzey@flowbird.group, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 RESEND 04/13] Revert "dmaengine: imx-sdma: refine to load context only once"
Date:   Tue, 12 May 2020 01:32:27 +0800
Message-Id: <1589218356-17475-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0141.apcprd06.prod.outlook.com
 (2603:1096:1:1f::19) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0141.apcprd06.prod.outlook.com (2603:1096:1:1f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 09:32:35 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ebbaca4-111b-4230-6fa5-08d7f58e401e
X-MS-TrafficTypeDiagnostic: VE1PR04MB6637:|VE1PR04MB6637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6637B2037727F69A29DFF55A89A10@VE1PR04MB6637.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCtVB+q6u4vyvhSD9/JqxFnXVwjfPuvSwknaRSu9IPqocWSsiKa1UsGh66daCWQNBKdrk7FcOlZrWwi6nE3K1Sd4+Nn/E2c2NhX0El+MH5ZS9DJzd7XUkZVNVB7CqlFpJmfqYx/JndzD5rl6GKWZAInvSKJtXbj5otp2aPK9zEASv8X2CqqKSR0E8hIgp0IdOVi7as7JSnhUgW22s2HV9+FsRALYsmW57dB8HHC2zOCja8gExkeVYV7R1N8+wEXD+m53KJk/Ov1BpbUJASnOqjs5x71MfM0kw+nfOSJRUa32OCbInPCNCSZfgVtt1Y7OLWIDwO/n9oxDEZueWHL+JzrctV3uxyOTmYm7jf4WGE7900p6ZAD2grYpIL+QWiZvZPqejLqsgVbvRJ4d66H0647qnIzYB9u+O7NjiWqRC1OJewDGqFhphIaWT72Gl5Oo2MeFuTYZQ/l0lDoG+AQ0gJ86/jnMNR9WpBQf9Ur7OVLZQH6/Jl0O2np/3hX7tu6RoBN6HXB+wxJhjhgmuqaO4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(33430700001)(8936002)(26005)(52116002)(6506007)(16526019)(2616005)(186003)(956004)(6666004)(6512007)(7416002)(5660300002)(2906002)(4326008)(6486002)(33440700001)(66476007)(8676002)(66946007)(66556008)(478600001)(86362001)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HOeWLxtEcflJh6z8al5YYq8nNlDSUW2i3jbHJb+/V091fDzLWQBPApUT1LSo7QAbiUlGtSatTB9IdCxy6a0+w4PlVcZnNEXQcUSw+nJaHkSTfOJRtcXlVOMk04TwF0jkie7GKyu55epnHsT0l5LIvT2mCMkZpnjh6s4kYi7mywY4k6LahRcJHtBnZ42NM2qEnhBpPmPqjPywwkxM8OUa/5Vmx6v19KBOxmipT49owX3WOPn9SUV1+L6BbegInh0xrTMRAXkusNNcK3/ZnTjoAWzdQlSzdHUdKn40h+kWhQCcoIWNgcuiaqr5wejTCMJWJXQfY9Hz/n4UHn1esAgNgjBHhRLRUaBeavh1ub0q5AZut/izA10EcMgqiZJsWUnMWNECakpuyY1RYXRBicz4figfKbMU8uw0Vw9B7+perl0q+md8pfTdqYYRR8Jn8tQed11z5AAV0S733xDhcgCuGgjrODHz6u4jMLc96Nh+6uc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebbaca4-111b-4230-6fa5-08d7f58e401e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 09:32:40.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oq5+etXpb5Droi8d6i9SOES/mKWAS/kiyb3R+falVWmI5nm91a4ctzdch9EB8wjMxIo8mvVux5O7nvSeFjD7+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6637
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This reverts commit ad0d92d7ba6aecbe2705907c38ff8d8be4da1e9c, because
in spi-imx case, burst length may be changed dynamically.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3d4aac9..397f11d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -377,7 +377,6 @@ struct sdma_channel {
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
-	bool				context_loaded;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
 };
@@ -984,9 +983,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int ret;
 	unsigned long flags;
 
-	if (sdmac->context_loaded)
-		return 0;
-
 	if (sdmac->direction == DMA_DEV_TO_MEM)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
@@ -1029,8 +1025,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
-	sdmac->context_loaded = true;
-
 	return ret;
 }
 
@@ -1069,7 +1063,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 	vchan_get_all_descriptors(&sdmac->vc, &head);
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 	vchan_dma_desc_free_list(&sdmac->vc, &head);
-	sdmac->context_loaded = false;
 }
 
 static int sdma_terminate_all(struct dma_chan *chan)
-- 
2.7.4

