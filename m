Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899EC1B4ED5
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 23:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDVVJ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 17:09:59 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:45132 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726337AbgDVVJ6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Apr 2020 17:09:58 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03ML6elP016686;
        Wed, 22 Apr 2020 17:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=NCDBMDVDi/HxAMGCKnU86qDjhkCvMKOClGQzbK+YQQc=;
 b=dX7S2yme9oJhHCypxbeOHVVh737M496PT55ykw4+vC2SOxRg5j6k79CMFWQGnvQ1FoHp
 VGc8Jnhtd4NDB3C6OwS05mdHbBj79tHPJfU3hLmOVSqm20/RhJn/1PNX5mvknRTZcoC4
 iVvbVsD4r0lWWP9L6pDMO5Nve7PtqyWjvjSQbUMrOmnVV2t++mswNQZzhwQ8VgO7HHuM
 p+86pYfYkVp7C4pNfMjQW7LbfeEirKd2NY3MjtruvnZovy/E7qVBidvTxHWDtvgQ/paD
 8aym4ZVf42qaESJnf9I87kbHgFyw6USRgktdCOH9gDrmnmhiwCt4GwukRQNa2nZjFW2B hA== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 30fvm3gx7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 17:09:46 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03ML5qvg061984;
        Wed, 22 Apr 2020 17:09:46 -0400
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com [128.221.224.79] (may be forged))
        by mx0b-00154901.pphosted.com with ESMTP id 30jdh87cyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Apr 2020 17:09:45 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd54.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03ML9iix004942;
        Wed, 22 Apr 2020 17:09:44 -0400
Received: from mailapphubprd02.lss.emc.com ([mailapphubprd02.lss.emc.com [10.253.24.52]]) by mailuogwprd54.lss.emc.com with ESMTP id 03ML9RPl004887 ;
          Wed, 22 Apr 2020 17:09:28 -0400
Received: from vd-leonidr.xiolab.lab.emc.com (vd-leonidr.xiolab.lab.emc.com [10.76.212.243])
        by mailapphubprd02.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03ML9NiL032414;
        Wed, 22 Apr 2020 17:09:24 -0400
From:   leonid.ravich@dell.com
To:     dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Allison Randal <allison@lohutok.net>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dmaengine: ioat: removing duplicate code from timeout handler
Date:   Thu, 23 Apr 2020 00:09:16 +0300
Message-Id: <1587589761-32690-1-git-send-email-leonid.ravich@dell.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1587583557-4113-3-git-send-email-leonid.ravich@dell.com>
References: <1587583557-4113-3-git-send-email-leonid.ravich@dell.com>
X-Sentrion-Hostname: mailuogwprd54.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_08:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxlogscore=531
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=13
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004220161
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=597 priorityscore=1501
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=13 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220161
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

moving duplicate code from timeout error handling to common
function.

Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
 drivers/dma/ioat/dma.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 1e0e6c1..da59b28 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -869,6 +869,23 @@ static void check_active(struct ioatdma_chan *ioat_chan)
 		mod_timer(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
 }
 
+static void ioat_reboot_chan(struct ioatdma_chan *ioat_chan)
+{
+	spin_lock_bh(&ioat_chan->prep_lock);
+	set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
+	spin_unlock_bh(&ioat_chan->prep_lock);
+
+	ioat_abort_descs(ioat_chan);
+	dev_warn(to_dev(ioat_chan), "Reset channel...\n");
+	ioat_reset_hw(ioat_chan);
+	dev_warn(to_dev(ioat_chan), "Restart channel...\n");
+	ioat_restart_channel(ioat_chan);
+
+	spin_lock_bh(&ioat_chan->prep_lock);
+	clear_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
+	spin_unlock_bh(&ioat_chan->prep_lock);
+}
+
 void ioat_timer_event(struct timer_list *t)
 {
 	struct ioatdma_chan *ioat_chan = from_timer(ioat_chan, t, timer);
@@ -891,19 +908,7 @@ void ioat_timer_event(struct timer_list *t)
 
 		if (test_bit(IOAT_RUN, &ioat_chan->state)) {
 			spin_lock_bh(&ioat_chan->cleanup_lock);
-			spin_lock_bh(&ioat_chan->prep_lock);
-			set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
-			spin_unlock_bh(&ioat_chan->prep_lock);
-
-			ioat_abort_descs(ioat_chan);
-			dev_warn(to_dev(ioat_chan), "Reset channel...\n");
-			ioat_reset_hw(ioat_chan);
-			dev_warn(to_dev(ioat_chan), "Restart channel...\n");
-			ioat_restart_channel(ioat_chan);
-
-			spin_lock_bh(&ioat_chan->prep_lock);
-			clear_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
-			spin_unlock_bh(&ioat_chan->prep_lock);
+			ioat_reboot_chan(ioat_chan);
 			spin_unlock_bh(&ioat_chan->cleanup_lock);
 		}
 
@@ -939,19 +944,7 @@ void ioat_timer_event(struct timer_list *t)
 		dev_dbg(to_dev(ioat_chan), "Active descriptors: %d\n",
 			ioat_ring_active(ioat_chan));
 
-		spin_lock_bh(&ioat_chan->prep_lock);
-		set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
-		spin_unlock_bh(&ioat_chan->prep_lock);
-
-		ioat_abort_descs(ioat_chan);
-		dev_warn(to_dev(ioat_chan), "Resetting channel...\n");
-		ioat_reset_hw(ioat_chan);
-		dev_warn(to_dev(ioat_chan), "Restarting channel...\n");
-		ioat_restart_channel(ioat_chan);
-
-		spin_lock_bh(&ioat_chan->prep_lock);
-		clear_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
-		spin_unlock_bh(&ioat_chan->prep_lock);
+		ioat_reboot_chan(ioat_chan);
 		spin_unlock_bh(&ioat_chan->cleanup_lock);
 		return;
 	} else
-- 
1.9.3

