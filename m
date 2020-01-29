Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312DA14C703
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 08:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgA2Hq0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 02:46:26 -0500
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:8431
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgA2Hq0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 Jan 2020 02:46:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2dMj8D8tXlyXnc1xvt/uVz8qvqtmosOqbecCvu09nvT/opb2vWPJrvZ4kiXobLSI0P2PFyHYnGYwyeaSVlwDaTo6bDlPcP33dFPzBNHLjksMo1EztN2oN8DnbhiNesK8njwdGfNiE8iMK3OeBjMHLd7cXBMsEn6bir2FfXCCA2KFp5kO0YYc6ZDZUpbUx/pvR90wQo20WSNOozoKy/PCjWtF/BmITimtfPNQicqY+pXkKnPKtbZkdOSduozpDcm72CU5o4l7Owp4D4sBu0E+FqZD9v+rIfPYxf0NyO/n3SA246f7nDLUgN4RG3FBp5m0CVWF9fRR+8J+rvZosB2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoZdDF6284bu9kDyItPvd989wjFN46usW72yMhFdkC8=;
 b=Vy98N5kZmpLZcCWLWy3O7AEIxIKZc1fl71ImzVftCt4qCe4Rz5ziuoR+R1kGmSDkLfvJvfzV7+vJfXtzX4xezHOKRmkUI8klDYCuAUjW0kDAkhJEYGa9Kg8tkOtCLeNqMSQlwUCx7nwcDywbZeBCJWyGLfm8iKJUu8jRk7dcnxcMeh3L9utyJwz6xcK6VWgaiBjgOgTs72I5ukd9QUd/NhevD075xOtI0gEm/rul+3f2chdgiU34idafqEogIwEsv1qpzCEaSpHqGnW4f4/rHi4ESuWnSlUrogptuShDTcqI/3h/mUq6xTyHbGb2SO9KqZAw5HMyEP0e+7S+akO+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=xhdpunnaia40.localdomain; dmarc=none action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoZdDF6284bu9kDyItPvd989wjFN46usW72yMhFdkC8=;
 b=CfQzaORVWd8xbHnc1BcxLUNPblBbZoxb3rgANS/OSLh0rGOA7KaxNRWxM2WloHOKZgWAuxDhpPyilU2IA9eoUlmPJy2Xg7cCDzV3VfuhdXpSv881OyaumEboegwmtenTr919wh/v+3ptLRuzXDwUz0596OA/MAD2m4rv/aTDVeQ=
Received: from BYAPR02CA0005.namprd02.prod.outlook.com (2603:10b6:a02:ee::18)
 by BL0PR02MB6499.namprd02.prod.outlook.com (2603:10b6:208:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22; Wed, 29 Jan
 2020 07:45:43 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BYAPR02CA0005.outlook.office365.com
 (2603:10b6:a02:ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Wed, 29 Jan 2020 07:45:43 +0000
Authentication-Results: spf=none (sender IP is 149.199.60.83)
 smtp.mailfrom=xhdpunnaia40.localdomain; vger.kernel.org; dkim=none (message
 not signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: None (protection.outlook.com: xhdpunnaia40.localdomain does not
 designate permitted sender hosts)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2665.18
 via Frontend Transport; Wed, 29 Jan 2020 07:45:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1iwi2e-0003A3-26; Tue, 28 Jan 2020 23:45:40 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1iwi2Y-0006jI-8Y; Tue, 28 Jan 2020 23:45:34 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00T7jXTW016420;
        Tue, 28 Jan 2020 23:45:33 -0800
Received: from [10.140.184.180] (helo=xhdpunnaia40.localdomain)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1iwi2W-0006jE-Tu; Tue, 28 Jan 2020 23:45:33 -0800
Received: by xhdpunnaia40.localdomain (Postfix, from userid 13245)
        id 2293AFF8A7; Wed, 29 Jan 2020 13:15:31 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 -next] dmaengine: xilinx_dma: Reset DMA channel in dma_terminate_all
Date:   Wed, 29 Jan 2020 13:15:09 +0530
Message-Id: <1580283909-32678-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--1.115-7.0-31-1
X-imss-scan-details: No--1.115-7.0-31-1;No--1.115-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(428003)(249900001)(189003)(199004)(316002)(5660300002)(42186006)(107886003)(4326008)(8936002)(8676002)(81166006)(450100002)(6266002)(81156014)(82310400001)(2906002)(498600001)(36756003)(42882007)(356004)(70206006)(336012)(70586007)(2616005)(26005)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB6499;H:xsj-pvapsmtpgw01;FPR:;SPF:None;LANG:en;PTR:unknown-60-83.xilinx.com;MX:0;A:0;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ef309a5-d31b-40cc-1e78-08d7a48f3e68
X-MS-TrafficTypeDiagnostic: BL0PR02MB6499:
X-Microsoft-Antispam-PRVS: <BL0PR02MB6499A3218A9CD4D9297B2E01D5050@BL0PR02MB6499.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-Forefront-PRVS: 02973C87BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHc4MeN+D0IX9ppYXsp/UvFRUix7ZIFuIIAh1oXLYYNSdMJwLckvbdWhJgN+/Wyy4bQ3E6d5Mph3TGbRvrUs5eyNjFiI/TpRZDc+Q6Wbw0Fx3Ta3gfYFTdgqs+zF5zCOLE/MZainR/2gScsPe0DEF+7wnVGKuKBMeMNzkYu95czDX40dy3by/uZuQG2hZ0yu6nEy7d60LvYmGSDGcLHYMsj454wG5An1QeFGga3OMm0463rvZp7GoFVF8J6TxAeEkwu14LeYCxetXv+VQQl3GxeCzxipR9aU/KsM1LYSxh4jKCDjwtt0CJKJP7iIBrDHKXqe4fFprIXYu8Wqz8XjsJbBfZP/TvL1m+iqLGmBet960BDywEk426kempckDs/wFQ4/91oJb9mLgnlfxQVq3BUANR8vQPFWPKVUYmiqzeBRVkotWhx0G+TveBpeQ5oT
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 07:45:43.0083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef309a5-d31b-40cc-1e78-08d7a48f3e68
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6499
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Reset DMA channel after stop to ensure that pending transfers and FIFOs
in the datapath are flushed or completed. It also cleanup the terminate
path and removes stop for the cyclic mode as after the reset stop is not
required. This fixes intermittent data verification failure when xilinx
dma test the client is stressed and loaded/unloaded multiple times.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
Modified commit description to add failure description and explain why
stop is removed for cyclic mode.
---
 drivers/dma/xilinx/xilinx_dma.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a9c5d5cc9f2b..6f1539cad1ee 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2404,16 +2404,17 @@ static int xilinx_dma_terminate_all(struct dma_chan *dchan)
 	u32 reg;
 	int err;
 
-	if (chan->cyclic)
-		xilinx_dma_chan_reset(chan);
-
-	err = chan->stop_transfer(chan);
-	if (err) {
-		dev_err(chan->dev, "Cannot stop channel %p: %x\n",
-			chan, dma_ctrl_read(chan, XILINX_DMA_REG_DMASR));
-		chan->err = true;
+	if (!chan->cyclic) {
+		err = chan->stop_transfer(chan);
+		if (err) {
+			dev_err(chan->dev, "Cannot stop channel %p: %x\n",
+				chan, dma_ctrl_read(chan,
+				XILINX_DMA_REG_DMASR));
+			chan->err = true;
+		}
 	}
 
+	xilinx_dma_chan_reset(chan);
 	/* Remove and free all of the descriptors in the lists */
 	xilinx_dma_free_descriptors(chan);
 	chan->idle = true;
-- 
2.22.0

