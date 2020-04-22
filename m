Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5471B4ED4
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 23:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgDVVJ6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 17:09:58 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:47448 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726068AbgDVVJ6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Apr 2020 17:09:58 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03ML601n016046;
        Wed, 22 Apr 2020 17:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=ukE2xdSiAt6A5by3rnRFfTznqvxYOdBEy+mduJSX7ZI=;
 b=UuVyAcnQj4UyOCZBPwTiP6/ciFmyrKZaxl7OigD9ZWHGGg4V6UVc+y6MJ/p1FUi5bRFZ
 E4t/MAEBt3cpBOvOM1F9jxzsW5x3JgdKCozaXUsy22kAuBjoOsftEhh3Y9vDwDc1AAcr
 T4QMWI2iSOgN4epq7yNfauz6OAheDevzrYjumGRcqrXRGtXsCZ1J21tLcX7Soq/Y8lhb
 4qkdOjZcfquwUkwf7N3s4dpNshRqGUQ34tdhLvQAx/HAYb+N7846v8xBqHMbP6UxpIj6
 JmNdMe0I+Ec2sLdiXAlspja8CNKpz371JvNs802UL/ynCgrH/RVNYhjP0I54neWNtmcK PQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 30ftmth40j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 17:09:51 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03ML9B2K168394;
        Wed, 22 Apr 2020 17:09:50 -0400
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com [128.221.224.79] (may be forged))
        by mx0a-00154901.pphosted.com with ESMTP id 30j8e83420-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Apr 2020 17:09:50 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd51.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03ML9mNw001814;
        Wed, 22 Apr 2020 17:09:48 -0400
Received: from mailapphubprd02.lss.emc.com ([mailapphubprd02.lss.emc.com [10.253.24.52]]) by mailuogwprd51.lss.emc.com with ESMTP id 03ML9b2Z001763 ;
          Wed, 22 Apr 2020 17:09:38 -0400
Received: from vd-leonidr.xiolab.lab.emc.com (vd-leonidr.xiolab.lab.emc.com [10.76.212.243])
        by mailapphubprd02.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03ML9NiN032414;
        Wed, 22 Apr 2020 17:09:34 -0400
From:   leonid.ravich@dell.com
To:     dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] dmaengine: ioat: adding missed issue_pending to timeout handler
Date:   Thu, 23 Apr 2020 00:09:18 +0300
Message-Id: <1587589761-32690-3-git-send-email-leonid.ravich@dell.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1587589761-32690-1-git-send-email-leonid.ravich@dell.com>
References: <1587583557-4113-3-git-send-email-leonid.ravich@dell.com>
 <1587589761-32690-1-git-send-email-leonid.ravich@dell.com>
X-Sentrion-Hostname: mailuogwprd51.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_08:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=696 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=13 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220161
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=13 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=754
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220161
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

completion timeout might trigger unnesesery DMA engine hw reboot
in case of missed issue_pending() .

Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
Changing in v2:
  - fixing log spelling and level
 drivers/dma/ioat/dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 55a8cf1..8ad0ad8 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -955,6 +955,15 @@ void ioat_timer_event(struct timer_list *t)
 		goto unlock_out;
 	}
 
+	/* handle missed issue pending case */
+	if (ioat_ring_pending(ioat_chan)) {
+		dev_warn(to_dev(ioat_chan),
+			"Completion timeout with pending descriptors\n");
+		spin_lock_bh(&ioat_chan->prep_lock);
+		__ioat_issue_pending(ioat_chan);
+		spin_unlock_bh(&ioat_chan->prep_lock);
+	}
+
 	set_bit(IOAT_COMPLETION_ACK, &ioat_chan->state);
 	mod_timer(&ioat_chan->timer, jiffies + COMPLETION_TIMEOUT);
 unlock_out:
-- 
1.9.3

