Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF1F21ECBE
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGNJ1k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 05:27:40 -0400
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:27207
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbgGNJ1i (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 05:27:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW9RcZN8oxJa0n3VUW73X3DrJU9hkRs2utKujtRuwYUxqH8KI89J5Fqp1x04Oocd8Li6SRS8D4LJZAsRKPMA9i4rrR9vJj6tD5KImwvnXGfcMOcBvng0rWzk9VlYSNMBb8/IIqmDO/jz1YZAsJbBFJk/C6WajXGw030bTtClJcAZgR4o04IapPHpiCKxhnC4hm0EzXZrWN/2mCiq9nUnCmX7CCRLwT8Ot0mwcFB+41oo/s2n/Odp9BOWM7qn7xwgxPSFqaDvs85z5XTtA8+U+oNu5+AmmhlUDuofyPglZtrGmdFrGf+HPNwjtkEirFIXgF1gxfK7S4PZEqpqQ9ukQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y+xW4eUZ3BMp8dGzZfaOkqYoOJccc4HMqibnP9MgK0=;
 b=ezBC1lAx/KradxnqDyFBY/Pv87T3vu2RXN7H9GeN51yfSDR9pCYFati+L6hg8mOqPA5WczoBEp57ONFoS5bxjEXUG2DWqbnJvGuF4PyNHDredhK6W1ueu/KNT2R9+rmSFj8y7WB2X+xW3fiYecgddeDa33OlXDDFVcPLI/DJj0CGOTEe6xbnFL3oidAoTUTzMhxiIC/GC3hCjPq43k7bFfm2yXg+20Gaic8Pmnho6K7y34JUu1hmswOn+nxlGu5XuOO2WCF77rNniQp3Pct9QjjKDDrHxIb4+0tamBa11wvtX8Am6ZR3i7WQscSZN1jlKjgZwrMnemf3xTFJKSqeqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y+xW4eUZ3BMp8dGzZfaOkqYoOJccc4HMqibnP9MgK0=;
 b=JfXEF3E3jCaf9jG9kzbOaouf3B9Srjxt5R20dtDhwvBIzUVIe+VJB2K4RkcV1NFoXMZwGsInJ3w8uEa/v4u+K0MPb693XoRiTP7gD2nULvykYm7Xjwlmikyb4BvzxgU5AqKWtD9KvMvNHgHP1gtcTel/JrsiEKwv3G+GJ6JjOcY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6270.eurprd04.prod.outlook.com (2603:10a6:803:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 09:27:35 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 09:27:35 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/9] dmaengine: fsl-edma-common: export fsl_edma_set_tcd_regs
Date:   Wed, 15 Jul 2020 01:41:43 +0800
Message-Id: <1594748508-22179-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
References: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0092.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::18) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0092.apcprd01.prod.exchangelabs.com (2603:1096:3:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 09:27:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25f59668-d2b6-43e0-82d1-08d827d8247c
X-MS-TrafficTypeDiagnostic: VI1PR04MB6270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6270BC66954A2449E0A8712389610@VI1PR04MB6270.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRAQY49qC85Asng1RiNNrEt4RDdskgi9HS99+OF570efjDF6fDjS8ydUVqm96yLsD7P/rdVPHFV3Tp9rNu+wWt+q4RxySkNA2AUdAJNhU0YvRJwxTx4qi7tZcMDW5FzLkF0GsgtIj6GW7028BBe/LvHdwlX1t52OciIy9WnCFZaJSq8TZxDImKibUKXmWLCwaA57SP+uPqspn1IhEOFap4MN3oROeVXRiCd7rEl3FMe0uzOt5j4lE4GMGZaWSh3i1zECtUctwvY7NQn2WTdek8F5600b3/AMdHfAu93MIQ56wY70+EdmcnTVNa+RgsjWRChlzIWOFt25KJDhqIC6jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(66946007)(6486002)(6512007)(66476007)(66556008)(8936002)(4326008)(86362001)(2906002)(6506007)(83380400001)(498600001)(36756003)(16526019)(956004)(2616005)(186003)(6666004)(26005)(5660300002)(8676002)(52116002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wrj+G8KyKWQsr4Q0Q12PgW58ucuv1TMaQl9Sm/aveveoJBT1VsckXEI0XRvJFrCSBrrHCZ/XEI7t92af11t8EIkiJM++dPeSCo5J2X59AbyFoPyLzzofIhyGUtjUkiyDQ+v2nGdxsu6IIgPk17S8aDnaWSHI4GekHCZiwv6LQYMB72QWawSrsnWFjTiNd8f5w/jEH+ysBjRgTq96PA+cOOgdahUrLx75nfmHQhI2yTV4ptbH0V86UySwDsVhz4t+zj5xFI/CoAuSz1QcE1mdH/EZSs8VQ4Vk7OGG44jFxrw9HPtUBwgkDvGprchElpLY7DwEKmak8XkTq03I96ctgB52B7KlZhVz1Sk8Fsd65I9OGya7onjUvtdE8lq8KnkYEHqgxfXj4CbAnKYQiDxIZHpCPHMg7xxupzJPYGgJY7JMVEpJBrtMYPjF1jp8hFqAUhojuURSHjvSOEoz0iTY0iWac89go/ByNujkuXPVN6Q=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f59668-d2b6-43e0-82d1-08d827d8247c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 09:27:35.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VmoAEwxoLclS73kEK9NVXMsFL7OpszC8CNJ8L1kephXylv9EeEoM/W3mvitjwBNY/EGpBjcrLNVGYFlnlffFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
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

