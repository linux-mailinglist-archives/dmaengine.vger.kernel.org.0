Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2A6211310
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 20:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgGAStN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 14:49:13 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:28636 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgGAStN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 14:49:13 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061IjZ4V028641;
        Wed, 1 Jul 2020 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=01wzLlnS9Alodrwi62enE4ckPXy9EPiT2tEmF2vgiQs=;
 b=G9wUH1mOJ/nE9u6R94xFCCGqZ97dq0RnHUuT7HFfIkc/9yExmFjGUHU/we6enJv7rJgX
 o/Z4vY9nwkPjm0CigHiRvOzE043iugvtrbpwJOKIU/gOAMXY4O8kGipIREH3a8xVNdel
 WA17KXIT5sYNCn217AtyJENPlzP8bp7JuBqJFt3POkeprc/T/UpQRhRZgkKTCPzZ+ZMt
 DifeMJmHwjvBLGhTUpAg7YPaKmPfugNxwaI6AVURcB92XWLV7fcmmBO+lgMsohMKD+e3
 DSEm0R1tvtsNpDSMyZdAxVp3jag5HuySCXHk6FlnuVINOEzX2bTzCaLKT3EH0iuB0slp kA== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 31x0p6f7dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:49:09 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061IjP28146588;
        Wed, 1 Jul 2020 14:49:08 -0400
Received: from mailuogwhop.emc.com (mailuogwhop-nat.lss.emc.com [168.159.213.141] (may be forged))
        by mx0b-00154901.pphosted.com with ESMTP id 32101w0267-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 01 Jul 2020 14:49:08 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd03.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 061In7gI002425;
        Wed, 1 Jul 2020 14:49:07 -0400
Received: from mailsyshubprd08.lss.emc.com ([mailsyshubprd08.lss.emc.com [10.253.24.64]]) by mailuogwprd03.lss.emc.com with ESMTP id 061Imcrf002194 ;
          Wed, 1 Jul 2020 14:48:38 -0400
Received: from arwen6.xiolab.lab.emc.com (arwen6.xiolab.lab.emc.com [10.76.217.138])
        by mailsyshubprd08.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 061ImZxm020271;
        Wed, 1 Jul 2020 14:48:36 -0400
From:   leonid.ravich@dell.com
To:     dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dmaengine: ioat setting ioat timeout as module parameter
Date:   Wed,  1 Jul 2020 21:48:12 +0300
Message-Id: <20200701184816.29138-1-leonid.ravich@dell.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20200701140849.8828-1-leonid.ravich@dell.com>
References: <20200701140849.8828-1-leonid.ravich@dell.com>
X-Sentrion-Hostname: mailuogwprd03.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_10:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=918 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=13 priorityscore=1501 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010130
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=941
 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=13 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007010130
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

DMA transaction time to completion  is a function of
PCI bandwidth,transaction size and a queue depth.
So hard coded value for timeouts might be wrong
for some scenarios.

Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
Changing in v2
  - misspelling of completion
 drivers/dma/ioat/dma.c | 12 ++++++++++++
 drivers/dma/ioat/dma.h |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 8ad0ad861c86..fd782aee02d9 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -26,6 +26,18 @@
 
 #include "../dmaengine.h"
 
+int completion_timeout = 200;
+module_param(completion_timeout, int, 0644);
+MODULE_PARM_DESC(completion_timeout,
+		"set ioat completion timeout [msec] (default 200 [msec])");
+int idle_timeout = 2000;
+module_param(idle_timeout, int, 0644);
+MODULE_PARM_DESC(idle_timeout,
+		"set ioat idel timeout [msec] (default 2000 [msec])");
+
+#define IDLE_TIMEOUT msecs_to_jiffies(idle_timeout)
+#define COMPLETION_TIMEOUT msecs_to_jiffies(completion_timeout)
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

