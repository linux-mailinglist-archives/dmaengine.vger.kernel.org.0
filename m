Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C1E1B432A
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 13:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgDVLXO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 07:23:14 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:40226 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726904AbgDVLXO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Apr 2020 07:23:14 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBMBGZ018085;
        Wed, 22 Apr 2020 07:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=vk6WIRJbGY1Rn41lMJfqEpm0LjdRgFhX8K8ILvUyRG4=;
 b=ZcRHjcUy1ZQR7pU+RgMKHF+yIxEks/tFdUf6+UtixrxO8RFEyp/LUNJLQ9aRT/OaE9Bw
 uCyP2mbcwcY9hcq2hmISeyrS1iGyQLVdp6ygMD8404IL0GTLxgNHxuwgravesLpnv1C1
 hYWlhChqQBjIITovTAel2eq7Ak37AVgzIoIkv4i9dy8tOSUAx1QphT9J+XGYqdqPxcEX
 kd9mULOXc4Kiie4Sbdz/I4cx4l7ZB3v36QivMzj3SD9KMKqZc/MeUMPEXXHH7XoPaaG7
 GvjHPXJC24z5nT3dIB6H+5A40/04MgvoNWcTrSmrPriSi5qttKDs4pnTr89bqgYkok9h VA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 30fvpwenyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 07:23:05 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBF6WC025053;
        Wed, 22 Apr 2020 07:23:05 -0400
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com [128.221.224.79] (may be forged))
        by mx0a-00154901.pphosted.com with ESMTP id 30jfxm4u1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Apr 2020 07:23:05 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd54.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03MBN4e7021409;
        Wed, 22 Apr 2020 07:23:04 -0400
Received: from mailsyshubprd56.lss.emc.com ([mailsyshubprd56.lss.emc.com [10.106.48.138]]) by mailuogwprd54.lss.emc.com with ESMTP id 03MBMcwh021212 ;
          Wed, 22 Apr 2020 07:22:39 -0400
Received: from vd-leonidr.xiolab.lab.emc.com (vd-leonidr.xiolab.lab.emc.com [10.76.212.243])
        by mailsyshubprd56.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03MBMK2c011459;
        Wed, 22 Apr 2020 07:22:36 -0400
From:   leonid.ravich@dell.com
To:     dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dmaengine: ioat: adding missed issue_pending to timeout handler
Date:   Wed, 22 Apr 2020 14:22:07 +0300
Message-Id: <1587554529-29839-3-git-send-email-leonid.ravich@dell.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1587554529-29839-1-git-send-email-leonid.ravich@dell.com>
References: <1587554529-29839-1-git-send-email-leonid.ravich@dell.com>
X-Sentrion-Hostname: mailuogwprd54.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=13
 lowpriorityscore=0 phishscore=0 mlxlogscore=756 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220090
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=13 mlxlogscore=814 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220091
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

completion timeout might trigger unnesesery DMA engine hw reboot
in case of missed issue_pending() .

Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
 drivers/dma/ioat/dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 55a8cf1..2ab07a3 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -955,6 +955,13 @@ void ioat_timer_event(struct timer_list *t)
 		goto unlock_out;
 	}
 
+	/* handle missed issue pending case */
+	if (ioat_ring_pending(ioat_chan)) {
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

