Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3863210D2A
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 16:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgGAOJ5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 10:09:57 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:12608 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728021AbgGAOJ4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 10:09:56 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E42a9011115;
        Wed, 1 Jul 2020 10:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id; s=smtpout1;
 bh=G36Fg61fCQr+wCCLzQCC2YORVhnFR9rzAH3ZcF+UlyU=;
 b=bysWkfFwsgWt+dfjsnt8t+/3rl/yz6eWRUb1/4EYMrV0YCypJXvGOIVcgbWY7xkK0yBs
 fyDmyr+sJCEC7byRfggaXf10fl3EvBFdJVcrjvA2wxXP+RLD1qrvjz9v3Gxpo96yUe4q
 bkdxvZfFtoxo8opFPd3VmPpkMzu4aF4N2cK24o4sqHTkuLLByLmB4YEHyHQXvodZrgwS
 +2y8AcfYu2lWtVr2BCWUDWdoKufEwrpDCMNwJXRPwRNmN2DCdcIejm9gKvNCoKnP2NLm
 d+InsqBKoZNAB9LacEB9+FaNHLUAbiObhopMTDvd9mCP48W+leKK6Hv5Qy/6aiL637tu bw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 31x1b9nyfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 10:09:52 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E9nQ1049371;
        Wed, 1 Jul 2020 10:09:52 -0400
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com [128.221.224.79] (may be forged))
        by mx0b-00154901.pphosted.com with ESMTP id 320u6191wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 01 Jul 2020 10:09:51 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd53.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 061E9cpt026875;
        Wed, 1 Jul 2020 10:09:38 -0400
Received: from mailapphubprd52.lss.emc.com ([mailapphubprd52.lss.emc.com [10.106.83.171]]) by mailuogwprd53.lss.emc.com with ESMTP id 061E9Iet026588 ;
          Wed, 1 Jul 2020 10:09:19 -0400
Received: from arwen6.xiolab.lab.emc.com (arwen6.xiolab.lab.emc.com [10.76.217.138])
        by mailapphubprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 061E9Fuf002031;
        Wed, 1 Jul 2020 10:09:16 -0400
From:   leonid.ravich@dell.com
To:     dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: ioat setting ioat timeout as module parameter
Date:   Wed,  1 Jul 2020 17:08:45 +0300
Message-Id: <20200701140849.8828-1-leonid.ravich@dell.com>
X-Mailer: git-send-email 2.16.2
X-Sentrion-Hostname: mailuogwprd53.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 cotscore=-2147483648 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=899 suspectscore=13 bulkscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010102
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=13 mlxlogscore=922 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010102
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

DMA transaction time to complition  is a function of
PCI bandwidth,transaction size and a queue depth.
So hard coded value for timeouts might be wrong
for some scenarios.

Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
 drivers/dma/ioat/dma.c | 12 ++++++++++++
 drivers/dma/ioat/dma.h |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 8ad0ad861c86..7621b5be5cf4 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -26,6 +26,18 @@
 
 #include "../dmaengine.h"
 
+int complition_timeout = 200;
+module_param(complition_timeout, int, 0644);
+MODULE_PARM_DESC(complition_timeout,
+		"set ioat complition timeout [msec] (default 200 [msec])");
+int idle_timeout = 2000;
+module_param(idle_timeout, int, 0644);
+MODULE_PARM_DESC(idle_timeout,
+		"set ioat idel timeout [msec] (default 2000 [msec])");
+
+#define IDLE_TIMEOUT msecs_to_jiffies(idle_timeout)
+#define COMPLETION_TIMEOUT msecs_to_jiffies(complition_timeout)
+
 static char *chanerr_str[] = {
 	"DMA Transfer Source Address Error",
 	"DMA Transfer Destination Address Error",
diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index e6b622e1ba92..f7f31fdf14cf 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -104,8 +104,6 @@ struct ioatdma_chan {
 	#define IOAT_RUN 5
 	#define IOAT_CHAN_ACTIVE 6
 	struct timer_list timer;
-	#define COMPLETION_TIMEOUT msecs_to_jiffies(100)
-	#define IDLE_TIMEOUT msecs_to_jiffies(2000)
 	#define RESET_DELAY msecs_to_jiffies(100)
 	struct ioatdma_device *ioat_dma;
 	dma_addr_t completion_dma;
-- 
2.16.2

