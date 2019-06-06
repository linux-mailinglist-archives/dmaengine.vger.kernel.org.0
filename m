Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD60371FA
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfFFKqA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 06:46:00 -0400
Received: from mail-eopbgr770078.outbound.protection.outlook.com ([40.107.77.78]:6870
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfFFKp7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 6 Jun 2019 06:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vELktsUt8Uw9NdeLG962mWqPWJ1+nXFdSGI9Q2LR+s=;
 b=puwaV2LEvjF8pkJ5mLgTJoV3F1qpcafYySfeMut3bUHOVYL+OjU9qLSoez/LOjmy5RMX1HN8UyV5ar1rSi6QxmhxjZfYgN2SByL1wETZKzLfWTykGKFh4czNEigWITiiVEB7ljeswyl6H9xjJXHi4HFmmXaW0cyhHg6Ys/bMzGI=
Received: from CY4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:903:33::21)
 by SN2PR03MB2270.namprd03.prod.outlook.com (2603:10b6:804:f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Thu, 6 Jun
 2019 10:45:57 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by CY4PR03CA0011.outlook.office365.com
 (2603:10b6:903:33::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.13 via Frontend
 Transport; Thu, 6 Jun 2019 10:45:57 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Thu, 6 Jun 2019 10:45:56 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x56AjuCm013749
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Thu, 6 Jun 2019 03:45:56 -0700
Received: from saturn.ad.analog.com (10.48.65.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Jun 2019 06:45:56 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/4] dmaengine: virt-dma: store result on dma descriptor
Date:   Thu, 6 Jun 2019 13:45:47 +0300
Message-ID: <20190606104550.32336-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(106002)(8936002)(316002)(8676002)(36756003)(77096007)(26005)(1076003)(246002)(50466002)(50226002)(126002)(14444005)(356004)(6666004)(48376002)(47776003)(6916009)(7696005)(51416003)(2906002)(336012)(7636002)(5660300002)(2870700001)(4326008)(426003)(186003)(486006)(2351001)(2616005)(476003)(44832011)(70586007)(70206006)(305945005)(478600001)(86362001)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2270;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffa8fe2b-3b61-477f-f181-08d6ea6c283b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:SN2PR03MB2270;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2270:
X-Microsoft-Antispam-PRVS: <SN2PR03MB22701A5D94345A5BDDA965CDF9170@SN2PR03MB2270.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 00603B7EEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: soyju2eB+O6zh8S8lWonEMhlWqA5YEYo15Nqp8QggkSJO3IPwMplCzCswidlrZ0uKzKSpPDZJQKS/CH7Q/sEdfTpkdnCAVDL9jZAlaCoxmMUkHJDINcoDPLQvLDrckI98Y7ULWc/Jyp8AZvPbFdYmFzEPd5ZeGWsNWI4GgyjlT95yNAgv/kBXOLwwaMocqvgDmdiHeNK2xn6T0ExpyxDasH8/elV51hYAgCWY2Wj3OfGV85pqPIDiYHWEhunoahjKSwcIS2DZadvlI4t7Kqz7lw934RuPjrq9sjxDEq+jkmAfLA07dgf/6+0LkxlHlADbf8z/tTMWGmEvkTTIZhF6/Mf1Da9VXGMWL/ZPIExKuan1hk2uc9ANMM8vffAWy1bvr2usgdMEBNtyKSnkj0r64S4nC5JvmkAfub393oyt1A=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2019 10:45:56.9026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa8fe2b-3b61-477f-f181-08d6ea6c283b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2270
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This allows each virtual channel to store information about each transfer
that completed, i.e. which transfer succeeded (or which failed) and if
there was any residue data on each (completed) transfer.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/virt-dma.c | 4 ++--
 drivers/dma/virt-dma.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index 88ad8ed2a8d6..bf560a20c8a8 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -101,7 +101,7 @@ static void vchan_complete(unsigned long arg)
 	}
 	spin_unlock_irq(&vc->lock);
 
-	dmaengine_desc_callback_invoke(&cb, NULL);
+	dmaengine_desc_callback_invoke(&cb, &vd->tx_result);
 
 	list_for_each_entry_safe(vd, _vd, &head, node) {
 		dmaengine_desc_get_callback(&vd->tx, &cb);
@@ -109,7 +109,7 @@ static void vchan_complete(unsigned long arg)
 		list_del(&vd->node);
 		vchan_vdesc_fini(vd);
 
-		dmaengine_desc_callback_invoke(&cb, NULL);
+		dmaengine_desc_callback_invoke(&cb, &vd->tx_result);
 	}
 }
 
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index b09b75ab0751..eb767c583b7e 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -17,6 +17,7 @@
 
 struct virt_dma_desc {
 	struct dma_async_tx_descriptor tx;
+	struct dmaengine_result tx_result;
 	/* protected by vc.lock */
 	struct list_head node;
 };
@@ -65,6 +66,9 @@ static inline struct dma_async_tx_descriptor *vchan_tx_prep(struct virt_dma_chan
 	vd->tx.tx_submit = vchan_tx_submit;
 	vd->tx.desc_free = vchan_tx_desc_free;
 
+	vd->tx_result.result = DMA_TRANS_NOERROR;
+	vd->tx_result.residue = 0;
+
 	spin_lock_irqsave(&vc->lock, flags);
 	list_add_tail(&vd->node, &vc->desc_allocated);
 	spin_unlock_irqrestore(&vc->lock, flags);
-- 
2.20.1

