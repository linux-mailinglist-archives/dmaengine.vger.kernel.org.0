Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B621B4ED2
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 23:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDVVJ5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 17:09:57 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:44198 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgDVVJ5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Apr 2020 17:09:57 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03ML6ih6016716;
        Wed, 22 Apr 2020 17:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=Vwgi5V1MgHj6+1pQhGZX34Vv1m9mwYTiRUxt0kq77KM=;
 b=RsnQK3YAmSbEwNXLwPw/yoGC7tKPEcUvop2iFSWq/oXzbOdavDEzgHp6O6fuZn6LH3Oc
 04pBRYmpeF9rVHKfVrF41aTpu2ktLqJzppADSAz+Yh7Ov4ZLnblO0HPpDwLP81cnE3Y3
 UQsinmBHwEmg9s+dBmmmg98m4M1B0Ib/XDOluL/CC3HXUxKLEt+F/Dj6y33jzwHWMJ9v
 fWTgxuUEWToQlJKI6rtfGTXNnTQmKq86LIVSsJOYsG5w7r8i3oj0RwFBER2MX+8Eg5uD
 z/o3Gnu5r2j8iged4MnVdzVZ2VP5LO1Fr+E9X5QT82LzHVMHQ0s1wiU5dgil6OnCiAaf xg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 30fvm3gx7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 17:09:51 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03ML9W6t015147;
        Wed, 22 Apr 2020 17:09:50 -0400
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com [128.221.224.79] (may be forged))
        by mx0b-00154901.pphosted.com with ESMTP id 30jredcwum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Apr 2020 17:09:50 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03ML9n3t006013;
        Wed, 22 Apr 2020 17:09:49 -0400
Received: from mailapphubprd02.lss.emc.com ([mailapphubprd02.lss.emc.com [10.253.24.52]]) by mailuogwprd52.lss.emc.com with ESMTP id 03ML9W9s005957 ;
          Wed, 22 Apr 2020 17:09:33 -0400
Received: from vd-leonidr.xiolab.lab.emc.com (vd-leonidr.xiolab.lab.emc.com [10.76.212.243])
        by mailapphubprd02.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03ML9NiM032414;
        Wed, 22 Apr 2020 17:09:29 -0400
From:   leonid.ravich@dell.com
To:     dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dmaengine: ioat: remove unnesesery double complition timer modification.
Date:   Thu, 23 Apr 2020 00:09:17 +0300
Message-Id: <1587589761-32690-2-git-send-email-leonid.ravich@dell.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1587589761-32690-1-git-send-email-leonid.ravich@dell.com>
References: <1587583557-4113-3-git-send-email-leonid.ravich@dell.com>
 <1587589761-32690-1-git-send-email-leonid.ravich@dell.com>
X-Sentrion-Hostname: mailuogwprd52.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_08:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=13 bulkscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=394 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220161
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=479 priorityscore=1501
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=13 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220161
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

removing unnecessary mod_timer from timeout handler
incase of ioat_cleanup_preamble() is true  for cleaner code

Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
 drivers/dma/ioat/dma.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index da59b28..55a8cf1 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -922,17 +922,23 @@ void ioat_timer_event(struct timer_list *t)
 		spin_lock_bh(&ioat_chan->prep_lock);
 		check_active(ioat_chan);
 		spin_unlock_bh(&ioat_chan->prep_lock);
-		spin_unlock_bh(&ioat_chan->cleanup_lock);
-		return;
+		goto unlock_out;
+	}
+
+	/* handle the missed cleanup case */
+	if (ioat_cleanup_preamble(ioat_chan, &phys_complete)) {
+		/* timer restarted in ioat_cleanup_preamble
+		 * and IOAT_COMPLETION_ACK cleared
+		 */
+		__cleanup(ioat_chan, phys_complete);
+		goto unlock_out;
 	}
 
 	/* if we haven't made progress and we have already
 	 * acknowledged a pending completion once, then be more
 	 * forceful with a restart
 	 */
-	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
-		__cleanup(ioat_chan, phys_complete);
-	else if (test_bit(IOAT_COMPLETION_ACK, &ioat_chan->state)) {
+	if (test_bit(IOAT_COMPLETION_ACK, &ioat_chan->state)) {
 		u32 chanerr;
 
 		chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
@@ -945,12 +951,13 @@ void ioat_timer_event(struct timer_list *t)
 			ioat_ring_active(ioat_chan));
 
 		ioat_reboot_chan(ioat_chan);
-		spin_unlock_bh(&ioat_chan->cleanup_lock);
-		return;
-	} else
-		set_bit(IOAT_COMPLETION_ACK, &ioat_chan->state);
 
+		goto unlock_out;
+	}
+
+	set_bit(IOAT_COMPLETION_ACK, &ioat_chan->state);
 	mod_timer(&ioat_chan->timer, jiffies + COMPLETION_TIMEOUT);
+unlock_out:
 	spin_unlock_bh(&ioat_chan->cleanup_lock);
 }
 
-- 
1.9.3

