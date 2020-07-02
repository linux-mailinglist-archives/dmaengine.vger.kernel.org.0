Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509DF211C33
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 08:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGBGyF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 02:54:05 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:12347
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726987AbgGBGyA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 02:54:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2bkAHlDIfqSQQG6j6ytEadp4vPmewBy1i69jkHWLF81jqEpZYX0+1fAPEMcH+uey+dSiboVqjrJruTXVbDCY6OVyKKZHbj0X4/SefRAx/ht5MFLvQTnp5+RtZMnjDYWGHIMg3/icOEkefEEv9Fclb4Ncm1uYqU+ZvOiXyiwfGciVreZuH1mVMGZCxW+wZd7uhjxo56nOpAtIneQsYgcXDhqFZvEWoZ1oE82ZBkVS9RtmsD3xeAGDWLRYUffwb3mqKAZ2y47gm5Jyo2Tq1YzugTBhe8JBksYd8CBvWsetdMVwcZYzxPWtaXGusULcbZKc6vue1hx+6jV8DebWAyZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y+xW4eUZ3BMp8dGzZfaOkqYoOJccc4HMqibnP9MgK0=;
 b=J5KcsYx0eMir29ZXASdLlRWAhG30omFpsJQ76mU9uyWkVFrw8Ar3UcydbKSidM/guI2qT/wA0A6c0knT4beqRdr77Yi7r7EsgLkVVwoQx/dW282xc1zzTjD6IJTkX5zfpGKysp5smpJdl5NKM4P7/CuxAf9tlKW3IYkmkPNurPZZF5TJ8+5gWSh3pwon7NmoMCSz3I5BPMOgCLYlUZnehx3yHP3DOCGhQinRquXWmYWhVclkvZ6MWuy39hCVSSlbi0q6wIe5vS7lg4qaE4p5rca9vjfW2/pLqMmosU7Y/l9yup8Vfd8HtIlgyj3VwxPZdOR7MxGEdaueASwWc4ks+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y+xW4eUZ3BMp8dGzZfaOkqYoOJccc4HMqibnP9MgK0=;
 b=HIXN+b7jbGhZwSUq7pqeDrEACqkgVrGca4JwpZb65EgYZu2rYARQ6qweKdYYPM5BIOXsFr2cgpwCWlCHshU+VEFbFHpQh1Zd1L1Ee2i+TzYLf7ahJ0sdoxng2hldi1kNZMWVuxAA/3Hf5ZGxBCfuce9VW+VYsMWzlZt/IrPsbok=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 06:53:56 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.024; Thu, 2 Jul 2020
 06:53:56 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 4/9] dmaengine: fsl-edma-common: export fsl_edma_set_tcd_regs
Date:   Thu,  2 Jul 2020 23:08:04 +0800
Message-Id: <1593702489-21648-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
References: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0172.apcprd01.prod.exchangelabs.com (2603:1096:4:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 06:53:51 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f46b3e57-c827-4189-7d47-08d81e54b06f
X-MS-TrafficTypeDiagnostic: VI1PR04MB6943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6943B353B69F566D9D1FD9A3896D0@VI1PR04MB6943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJfELT0t+8eJqu3F2fnwYfJd2WxICOxjpC3ttMopHviWsuy7Bx/j6al8G1if6UTvAb0chNA8l/d7KhG6mmkH72C4Cmh3wLuwpfjDZJ9qftbi1oj92OQf0MP7lbEsZQ/PPKY+V6D9/5ROn6ei1ucDuH82OU7uOzxTbtW0abbFGOXjf0YUBZRMMPSZceYCrhQLe+1nhR94tpG16R7cjU2TMQAU0BF4m67ePhNBqAnU/Z6sGplyPDlzFe/RfkhKTt+OewJXnk+BFc6R4mnAZ0YFL8roYzz+1/eZ9qVlc1twqh8keQpJ2VaeBX2G9Qd50vB7LUW8WI8WN3hLs+aCoMfyLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(83380400001)(66476007)(6666004)(66946007)(66556008)(52116002)(36756003)(8936002)(2616005)(6486002)(956004)(6512007)(186003)(7416002)(4326008)(26005)(2906002)(8676002)(86362001)(16526019)(478600001)(6506007)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bKfffA41kh3PNkoJ6Slz2peXIpd7A/1Epq2PnqAs2VYdQw+PE95Ghsfh7QK5uESA1AVmeVc7UU5j1T8EYupbPaTjhSSMOkKYGqbuuu+Ksa6XcpKJzZ3idQ5tQVfyrdx6cOhkPGHPpWoI2g7UkugrSNLr1UiZ3pxXjMklQlw3Z/i41ZnZ4u2hRvGSmjyMbBdjfy4A13zZmATLtDJVSVgc/61RwDsgMy51ICOYLVIBZimQsTkHBf15VwXVm5sxToYcobpVfzMUh6Cg6RzSkMa9N8XVEqqDHxWlZysaYpc0q5mjQ7L0d/Ld8VONMHNIpkEiW3XqyqYaMkeeVgPF6cqPgSj02E1BVfgQt0Im1hCKiXntJT/Sx8vPnaVqAbwcCpdSNrDzJ37FnbVBPdTEXgg5Yc+5V/f4OXPhykftEVJMq2R4085RcHBcAnKiPpr2PKTMOCcy9eIjnk50X2CzYeaO84nHzGrTqFPs92svqsIolDM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46b3e57-c827-4189-7d47-08d81e54b06f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 06:53:56.1236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7eCt57tVxjMV9BQvfPsirRdPcNmvhQz6Wo0QBgM4n56wQZt5jcuBWS5t/tndY+oDzW5LS8a3nIYcWt/anu8EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Preparing for edma3 since it need to be called in fsl-edma3.c

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 3 ++-
 drivers/dma/fsl-edma-common.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 6ef083c..05d56d8 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -343,7 +343,7 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 }
 EXPORT_SYMBOL_GPL(fsl_edma_tx_status);
 
-static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
+void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 				  struct fsl_edma_hw_tcd *tcd)
 {
 	struct fsl_edma_engine *edma = fsl_chan->edma;
@@ -374,6 +374,7 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 
 	edma_writew(edma, le16_to_cpu(tcd->csr), &regs->tcd[ch].csr);
 }
+EXPORT_SYMBOL_GPL(fsl_edma_set_tcd_regs);
 
 static inline
 void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 87c8d7a..56f29f3 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -249,5 +249,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan);
 void fsl_edma_free_chan_resources(struct dma_chan *chan);
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
 void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
+void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
+				struct fsl_edma_hw_tcd *tcd);
 
 #endif /* _FSL_EDMA_COMMON_H_ */
-- 
2.7.4

