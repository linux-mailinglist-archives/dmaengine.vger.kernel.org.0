Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B2211C30
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 08:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGBGx4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 02:53:56 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:43264
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726953AbgGBGxy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 02:53:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9dYi52Y3n3eVQ8Rg2KeSHKI5LfknvAVfgf8dupb/YqggYHT18ih+O4hsUW45LWHAN2lJiAi1cH7UiqQJAK4FHek2ijdnJVy6m5H9FzvtpSKLOgFUPdalfgVn63ggtblNlP5x6yYvkq0apH0D73R6EerytaQtZUAhSYia2DpuWiKH/9dfZ9BbA9RPbK+fIOU4UF0ObCKcU1sWPtdwcC0X6XNF/k5bfuXs5K3u5A5YwHBD0EWaKIKlQu5puUhs8g9eK5J3co88qpP2O5+Wtj8+hqZcY6YaF4DLtZzkCNuVRQk/xTo3FLzxO6zp7MT+KvX5FfbpUK3GCBFzv0I9VLpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlMSjTLc9bPxAbh3RbYyMXN3owo0JtZ3jcwGfsNozXA=;
 b=aED7sQEYmTy9A0BXRUP7fPV5n6ZssF/ypnpvsM7idmJGFBFq1Sv2WeiZTWmiev7PslIA+Xxp5Mo2Zobrf/Gfsjz/eZ92IbmdXrZB3YPPbjR2vgDrPpg71Ns6JS6JYHgoIuOz0i0EIMhr5oQOV9d3W+1zitJ73ESpAjA935fzWxD344mevg0z9fNdBTKT/bYFhmK5PKIL2fi3TOvHpj9JNSWxbTQopd4GPLo2VWBs05ff3qFwPoUgRkequnYhpT84F8jrIZBK6ur5FiBhjuDvErvK0Wtks8meP/j74tPDw7H2KadCeopH3y+WMEFPJt51mlcI5gQdfLoADwsztgs1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlMSjTLc9bPxAbh3RbYyMXN3owo0JtZ3jcwGfsNozXA=;
 b=Hpdx64UjPban/UyuUlQrFJQq7FSC9vBMb1QexqJiWxbLTlvoIggcGkMRv/k0TFUxhcRvKiV9P6lmuoQee8+K9FU0eh5IHBlowKFqIammI5fXiWxgeqtSBexQSrPPb8zxQoL8ZWauyu7Msy9YrsHJE79jy74onudO/zw1BMsRYT8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 06:53:51 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.024; Thu, 2 Jul 2020
 06:53:51 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 3/9] dmaengine: fsl-edma-common: add fsl_chan into fsl_edma_fill_tcd
Date:   Thu,  2 Jul 2020 23:08:03 +0800
Message-Id: <1593702489-21648-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
References: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0172.apcprd01.prod.exchangelabs.com (2603:1096:4:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 06:53:46 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf1067fd-40be-4ac3-d72e-08d81e54ad86
X-MS-TrafficTypeDiagnostic: VI1PR04MB6943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB694370917D93727220B1FB4F896D0@VI1PR04MB6943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 195VErfdgA9OiYJ5+G7YE/o8sahrp6Jww8+rYyDJQC1TzxBXvkNld2Qs3hNKnmhcMrHIX38GK/lDmqAKZGrMKCAfzxs9tUzqNx34dW3M/HAkvjOun6CRoCUhp7IVrY3MOim/mvkYvSYd/Y5XCqctOg4SDuY51EojDwUo1CGGxnxQ26VxDVtBeNfNaBnPJoFLpBGL3X+5vnq3JZY1HS67TEtMLAxAeXXloIRtLkDm+9Ysy807HOAiDkJR/84pxAC2yuFlcRgivFpOnYsY7TbtsDaaTPtxIQLVMOcp2XBxQ6ePJkHgpHdD6KF2KBaYFQzprlChSErgg01qyd/ojKTm8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(83380400001)(66476007)(6666004)(66946007)(66556008)(52116002)(36756003)(8936002)(2616005)(6486002)(956004)(6512007)(186003)(7416002)(4326008)(26005)(2906002)(8676002)(86362001)(16526019)(478600001)(6506007)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UnOjNhF6gqP27lbfNKEQ4kz7meF54Ojzq9sS/Vpny4f1n9QyOOWsNLy7RJc+fu+8qzju0RIHGUzHpt5XwAVTdrpdYYH7d8XunD1i16ZLKnZCdBcPbWbI4pDlElW6zo/3dugIiqbXOJ1+sN826NoblNJA/840J5cBO5bTlK0PX0SMTMS1M4idnA/a/qyAR6FUpJdKkbOrhVZnIDG+lB53bwSF3B1jxUZiwXaSs1u60b42ywjRwReBrGWYbQ/YWwyUwLfc+OIwNgjyEjn3/NpIqwB4I+/RnDEMHKKOI95h1cCEtGuWCPFHx40iuFd4C472aDP3USn3iY8UD+TgbTspgcIqjpQYAfcdGxLwkdDssOyMIzSyrV1QWcjT9TW+7Yi03oRGst7kTnW76BVGugEV50T4vR89EbewknBOIfZwBq0pJxNaFtG1nVt0lq5ghKCOIvfuyXTFcj8JavCbbkV5ej3q2jdDl7/CWOrx3p9jXXo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1067fd-40be-4ac3-d72e-08d81e54ad86
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 06:53:51.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guxq8xHxOE4pKWhzlG3R07Pzd23A90D0tgRmS1ERZoWMZBqkxhyZialomvychMv6133AWIOftpxJ2CEF+T7O4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For preparing for next edma3 merged so that any member of 'struct fsl_chan'
could be used in fsl_edma_fill_tcd.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index d19e8a8..6ef083c 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -376,7 +376,8 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 }
 
 static inline
-void fsl_edma_fill_tcd(struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
+void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
+		       struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
 		       u16 attr, u16 soff, u32 nbytes, u32 slast, u16 citer,
 		       u16 biter, u16 doff, u32 dlast_sga, bool major_int,
 		       bool disable_req, bool enable_sg)
@@ -504,9 +505,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 			doff = fsl_chan->cfg.src_addr_width;
 		}
 
-		fsl_edma_fill_tcd(fsl_desc->tcd[i].vtcd, src_addr, dst_addr,
-				  fsl_chan->attr, soff, nbytes, 0, iter,
-				  iter, doff, last_sg, true, false, true);
+		fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
+				  dst_addr, fsl_chan->attr, soff, nbytes, 0,
+				  iter, iter, doff, last_sg, true, false, true);
 		dma_buf_next += period_len;
 	}
 
@@ -569,16 +570,16 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		iter = sg_dma_len(sg) / nbytes;
 		if (i < sg_len - 1) {
 			last_sg = fsl_desc->tcd[(i + 1)].ptcd;
-			fsl_edma_fill_tcd(fsl_desc->tcd[i].vtcd, src_addr,
-					  dst_addr, fsl_chan->attr, soff,
-					  nbytes, 0, iter, iter, doff, last_sg,
-					  false, false, true);
+			fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd,
+					  src_addr, dst_addr, fsl_chan->attr,
+					  soff, nbytes, 0, iter, iter, doff,
+					  last_sg, false, false, true);
 		} else {
 			last_sg = 0;
-			fsl_edma_fill_tcd(fsl_desc->tcd[i].vtcd, src_addr,
-					  dst_addr, fsl_chan->attr, soff,
-					  nbytes, 0, iter, iter, doff, last_sg,
-					  true, true, false);
+			fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd,
+					  src_addr, dst_addr, fsl_chan->attr,
+					  soff, nbytes, 0, iter, iter, doff,
+					  last_sg, true, true, false);
 		}
 	}
 
-- 
2.7.4

