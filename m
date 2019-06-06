Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB91371FB
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfFFKqC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 06:46:02 -0400
Received: from mail-eopbgr700081.outbound.protection.outlook.com ([40.107.70.81]:8896
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbfFFKqC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 6 Jun 2019 06:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zawT9oPFQm/1ouszLB5vHNiaKyqTI2AHZmsvM65kHuA=;
 b=cVg109465DNOcCB9PHPzq10YK1FcH7sKsDaNZkK3vlWjszUVqjlAvYPy/gDC6bhXvajawX2JiO9gCO18+o61TcDUzciDi9bpeTv9BOyaDM2ueEzESJ+kDSR6QxIcUl3BJ/jC+ZJ7TEWGgo8ss4Z2uZaHhtuzblh4HFeWabySepQ=
Received: from BN3PR03CA0084.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::44) by BLUPR03MB552.namprd03.prod.outlook.com
 (2a01:111:e400:883::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.22; Thu, 6 Jun
 2019 10:45:59 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN3PR03CA0084.outlook.office365.com
 (2a01:111:e400:7a4d::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.20 via Frontend
 Transport; Thu, 6 Jun 2019 10:45:59 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Thu, 6 Jun 2019 10:45:58 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x56Ajw7H013755
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Thu, 6 Jun 2019 03:45:58 -0700
Received: from saturn.ad.analog.com (10.48.65.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Jun 2019 06:45:58 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/4] dmaengine: axi-dmac: terminate early DMA transfers after a partial one
Date:   Thu, 6 Jun 2019 13:45:49 +0300
Message-ID: <20190606104550.32336-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606104550.32336-1-alexandru.ardelean@analog.com>
References: <20190606104550.32336-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39850400004)(396003)(2980300002)(189003)(199004)(106002)(44832011)(11346002)(2870700001)(305945005)(36756003)(2906002)(478600001)(486006)(356004)(8936002)(77096007)(6666004)(2616005)(336012)(476003)(26005)(186003)(426003)(246002)(47776003)(70206006)(2351001)(6916009)(7636002)(86362001)(126002)(4326008)(316002)(70586007)(14444005)(107886003)(50226002)(446003)(8676002)(5660300002)(76176011)(50466002)(1076003)(51416003)(48376002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB552;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a97e0d3a-ef84-4142-6c01-08d6ea6c294e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BLUPR03MB552;
X-MS-TrafficTypeDiagnostic: BLUPR03MB552:
X-Microsoft-Antispam-PRVS: <BLUPR03MB552757AA888D881265C69CBF9170@BLUPR03MB552.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 00603B7EEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XDh6+nSs3BoKmKJkvE9b1NvQv3AvShGGm2OyaPHFoiyDCmzb3uTYvVNUVhQ3UeVGN1ZOFXYXaWuFaT1/K/sLkUSWeOgWzAI7eZiJvMu4FDnDEKLVafCoANKGZMtCWybZgoBqa+bN1k2whq+X2DpA0Gnm2cG3DehaTOj1t9JMfhQ9UNnmR+QWJnfYFyrC67U2MA76NKsOWvSe1lw1Y234yQyNV0I84tu8GY2M4TTdw2++livGNPCalicQnTXiUvAvBlYPHeNiCFwS7g97mehGNW3ZgYtw3fKF/5LT5mm0Ux0cuUeLOcGUmXzZ7KtrtWmoRVkBAC1RuvZjABVOVa2P8q/Sb68KlJoBl7gr3ur0v+Z+gk/+a05HscknmfVoCGdbJJD3XM+7znbNJxsyDP0RFJIdX9b2nUZbcmFGl1sf8S4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2019 10:45:58.7634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a97e0d3a-ef84-4142-6c01-08d6ea6c294e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB552
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When a partial transfer is received, the driver should not submit any more
segments to the hardware, as they will be ignored/unused until a new
transfer start operation is done.

This change implements this by adding a new flag on the AXI DMAC
descriptor. This flags is set to true, if there was a partial transfer in
a previously completed segment. When that flag is true, the TLAST flag is
added to the to the submitted segment, signaling the controller to stop
receiving more segments.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index e0702697e2b3..3b418d545c7a 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -97,6 +97,7 @@ struct axi_dmac_sg {
 struct axi_dmac_desc {
 	struct virt_dma_desc vdesc;
 	bool cyclic;
+	bool have_partial_xfer;
 
 	unsigned int num_submitted;
 	unsigned int num_completed;
@@ -221,7 +222,8 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	}
 
 	desc->num_submitted++;
-	if (desc->num_submitted == desc->num_sgs) {
+	if (desc->num_submitted == desc->num_sgs ||
+	    desc->have_partial_xfer) {
 		if (desc->cyclic)
 			desc->num_submitted = 0; /* Start again */
 		else
@@ -295,6 +297,7 @@ static void axi_dmac_dequeue_partial_xfers(struct axi_dmac_chan *chan)
 				if (sg->id == AXI_DMAC_SG_UNUSED)
 					continue;
 				if (sg->id == id) {
+					desc->have_partial_xfer = true;
 					sg->partial_len = len;
 					found_sg = true;
 					break;
-- 
2.20.1

