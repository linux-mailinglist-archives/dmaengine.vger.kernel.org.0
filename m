Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9591B4D54
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 21:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgDVT1R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 15:27:17 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:21766 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726516AbgDVT1Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Apr 2020 15:27:16 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MJMBcZ031311;
        Wed, 22 Apr 2020 15:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=QTqlp2cS6bs33QjHn8AuEeCT/X8MXFMkK0NPUhwe/9Y=;
 b=btTVFEmsLEZFpdAP3x4pNMZxP3hurA1hkgt1mGzovuOxXSTTyJvCue/8dzC3u8VKBC5n
 R4+nVX5FFq0G4qnMKLLh70CuT6tAbGAj9TAackSuEggon1tkh1RDTSR3ZjXuBBqR5PnX
 rg05zwPHaoEZSbUngPh0AC3ypurTqKG9DxuHJBXrpfHjUBwVIE2QPqxAlJ95aE+ofAj8
 hBsId33eUj3k70SGBCe9S8moL9qSFMD+G5Hr8IDn8hwJu2rb88xWwfs51UBRVhW1+rsR
 RWTaEaWJahe9elwHZyM+lKzbh2WGLo7AQ2eGXN61OoRjY79G5yY0zqkFzRuaX/R50LT/ TA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 30fx7ng8p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 15:27:08 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MJO8dS026423;
        Wed, 22 Apr 2020 15:27:08 -0400
Received: from mailuogwhop.emc.com (mailuogwhop-nat.lss.emc.com [168.159.213.141] (may be forged))
        by mx0b-00154901.pphosted.com with ESMTP id 30haf25n0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Apr 2020 15:27:07 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd04.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03MJR6lm006851;
        Wed, 22 Apr 2020 15:27:06 -0400
Received: from mailsyshubprd04.lss.emc.com ([mailsyshubprd04.lss.emc.com [10.253.24.26]]) by mailuogwprd04.lss.emc.com with ESMTP id 03MJQX03006694 ;
          Wed, 22 Apr 2020 15:26:34 -0400
Received: from vd-leonidr.xiolab.lab.emc.com (vd-leonidr.xiolab.lab.emc.com [10.76.212.243])
        by mailsyshubprd04.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03MJQKHE016271;
        Wed, 22 Apr 2020 15:26:31 -0400
From:   leonid.ravich@dell.com
To:     dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dmaengine: ioat: adding missed issue_pending to timeout handler
Date:   Wed, 22 Apr 2020 22:25:55 +0300
Message-Id: <1587583557-4113-3-git-send-email-leonid.ravich@dell.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1587583557-4113-1-git-send-email-leonid.ravich@dell.com>
References: <20200416170628.16196-2-leonid.ravich@dell.com>
 <1587583557-4113-1-git-send-email-leonid.ravich@dell.com>
X-Sentrion-Hostname: mailuogwprd04.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_06:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=13 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=698 mlxscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220145
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=13 lowpriorityscore=0 phishscore=0 mlxlogscore=756
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220146
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
Changing in v2
  - add log in case of such scenario 
 drivers/dma/ioat/dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 55a8cf1..a958aaf 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -955,6 +955,14 @@ void ioat_timer_event(struct timer_list *t)
 		goto unlock_out;
 	}
 
+	/* handle missed issue pending case */
+	if (ioat_ring_pending(ioat_chan)) {
+		dev_dbg(to_dev(ioat_chan), "Complition timeout while pending\n")
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

