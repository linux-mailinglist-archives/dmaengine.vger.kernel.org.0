Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00E1B4328
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 13:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgDVLXG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 07:23:06 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:35348 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbgDVLXF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Apr 2020 07:23:05 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBGatH012772;
        Wed, 22 Apr 2020 07:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id; s=smtpout1;
 bh=s97OSsLXQUhCG7bmdYIO7vydAXKR5mkYhWfuSshshXw=;
 b=VM1ta8AOoJujK5QNirW6Fc8+trcQh48eZRhkZL09Lm7tug9Av7uAO1CwaLaGYeoQ5cO0
 qBVaQYvaHLo0Pj9CpBnvR4i3wO1UTu4IevKJGGHHUUae6HAOGsZpsBp9fqktU/8ScO+M
 MIitYLEuQubCUlJPRh7mHTeQkuzrFsVVrbiNsmexOraRBb2E4nKjyYe87kym00KsRmdz
 +bS2fGOguuzKLwxm1Tc48/QuAepZfXz9bAuA69KM6cOeNYCgCkSwgGMsQhNkL4HC2vhp
 4NfdXNw1p0c9Sf/CKZEv7ynz56rYaS6UmQB/G2Y7IZHAS7fodbCZuQBEGxTqD4HP34VM RQ== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 30fvm3excn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 07:23:00 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBEoSM110724;
        Wed, 22 Apr 2020 07:22:59 -0400
Received: from mailuogwhop.emc.com (mailuogwhop-nat.lss.emc.com [168.159.213.141] (may be forged))
        by mx0b-00154901.pphosted.com with ESMTP id 30jhh8d9bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Apr 2020 07:22:59 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd04.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03MBMwso020033;
        Wed, 22 Apr 2020 07:22:58 -0400
Received: from mailsyshubprd56.lss.emc.com ([mailsyshubprd56.lss.emc.com [10.106.48.138]]) by mailuogwprd04.lss.emc.com with ESMTP id 03MBMOwE019596 ;
          Wed, 22 Apr 2020 07:22:25 -0400
Received: from vd-leonidr.xiolab.lab.emc.com (vd-leonidr.xiolab.lab.emc.com [10.76.212.243])
        by mailsyshubprd56.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03MBMK2a011459;
        Wed, 22 Apr 2020 07:22:21 -0400
From:   leonid.ravich@dell.com
To:     dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dmaengine: ioat: removing duplicate code from timeout handler
Date:   Wed, 22 Apr 2020 14:22:05 +0300
Message-Id: <1587554529-29839-1-git-send-email-leonid.ravich@dell.com>
X-Mailer: git-send-email 1.9.3
X-Sentrion-Hostname: mailuogwprd04.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=606 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=13
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220090
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=672 priorityscore=1501
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=13 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220090
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

moving duplicate code from timeout error handling to common
function.

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

