Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E3F1B4D50
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 21:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgDVT04 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 15:26:56 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:30650 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbgDVT0z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Apr 2020 15:26:55 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MJMDvl011835;
        Wed, 22 Apr 2020 15:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=NCDBMDVDi/HxAMGCKnU86qDjhkCvMKOClGQzbK+YQQc=;
 b=sB5TODDr/Qvo7ITgjrHqL2hu1nVeIbqKwB/nKVpbGG3xPG+/NT+v5spz62XEjbVHjtVQ
 cgMy7u5VVp3UtYY3r0bWfeO0IzMQ19CekfgvuMdhoB5kCOKwceoAbQfaGcwM2HOCZcKA
 W5+/o9/BPGLYpFC2A/klOfwSin8MbMZM0wvFt1k/wYxyKn4XXfWRM6FUo0AzlwY58+YE
 y91ShK426hI3Tudic+utwXcYmc2korKJv1d7s9p2+j4GamvW5N77/SK1haQR5WlqMBRX
 0Ju7b5S2ExW/OY/fLxB2sKnitr9OF56mulO4o0wKAVFATgK39Z5Ycou9rRchd/Vs+5wT Hg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 30fvpwgcms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 15:26:48 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MJN0D6090460;
        Wed, 22 Apr 2020 15:26:48 -0400
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com [128.221.224.79] (may be forged))
        by mx0a-00154901.pphosted.com with ESMTP id 30htj5xu6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Apr 2020 15:26:48 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd51.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03MJQl2w014694;
        Wed, 22 Apr 2020 15:26:47 -0400
Received: from mailsyshubprd04.lss.emc.com ([mailsyshubprd04.lss.emc.com [10.253.24.26]]) by mailuogwprd51.lss.emc.com with ESMTP id 03MJQNFp014541 ;
          Wed, 22 Apr 2020 15:26:24 -0400
Received: from vd-leonidr.xiolab.lab.emc.com (vd-leonidr.xiolab.lab.emc.com [10.76.212.243])
        by mailsyshubprd04.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03MJQKHC016271;
        Wed, 22 Apr 2020 15:26:21 -0400
From:   leonid.ravich@dell.com
To:     dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dmaengine: ioat: removing duplicate code from timeout handler
Date:   Wed, 22 Apr 2020 22:25:53 +0300
Message-Id: <1587583557-4113-1-git-send-email-leonid.ravich@dell.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <20200416170628.16196-2-leonid.ravich@dell.com>
References: <20200416170628.16196-2-leonid.ravich@dell.com>
X-Sentrion-Hostname: mailuogwprd51.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_06:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=531 clxscore=1015
 impostorscore=0 suspectscore=13 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220145
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=13 mlxlogscore=597 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220146
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

