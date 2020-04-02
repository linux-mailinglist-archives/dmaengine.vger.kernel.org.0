Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FAE19C727
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2020 18:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbgDBQfH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Apr 2020 12:35:07 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:39358 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732404AbgDBQfH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Apr 2020 12:35:07 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032GADoT029884;
        Thu, 2 Apr 2020 12:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=nkri6AUC+cBObLD6lQuVbUkVwceemOCxjXIA5O1O0Ek=;
 b=uXNycPUDfhZjPHOL5abDizq7190of0u/afTzfYJZqU7whCFpBgcNjQY/s6jquhCa7n+X
 +GsShpwa7MB6scC/JwerlwhGLcq9cSD5cAwp0XF7Ki8pjpamce9Ul0qUDuwkr9bc4w+j
 rKFIFJ3uHWjMOmpYVXathZzdMFWDs7DauQLldI5MZtsJ8soHUl6fXb/OkwGSqVN5FhzA
 A/Fnic5jeOhvpk+WoLIz822NGT45fevNwQJgSaZIEIUBTOR2QmDRTF6yTUWpGHfVV9PK
 iQLNgkA8V0BAMwNgxi83EPZMhEZ2SoAINbj9+H8q1GD886+Q7ptZ2pVNv/vwELQ1LVw+ cQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 301ynv5f70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 12:34:50 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032GLgh5106141;
        Thu, 2 Apr 2020 12:34:49 -0400
Received: from mailuogwhop.emc.com (mailuogwhop-nat.lss.emc.com [168.159.213.141] (may be forged))
        by mx0a-00154901.pphosted.com with ESMTP id 30217h58fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Apr 2020 12:34:49 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd04.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 032GYnOU008886;
        Thu, 2 Apr 2020 12:34:49 -0400
Received: from mailsyshubprd06.lss.emc.com ([mailsyshubprd06.lss.emc.com [10.253.24.24]]) by mailuogwprd04.lss.emc.com with ESMTP id 032GYVwC008725 ;
          Thu, 2 Apr 2020 12:34:31 -0400
Received: from arwen2.xiolab.lab.emc.com. (arwen2.xiolab.lab.emc.com [10.76.211.113])
        by mailsyshubprd06.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 032GYR3f030730;
        Thu, 2 Apr 2020 12:34:27 -0400
From:   leonid.ravich@dell.com
To:     dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: ioat: fixing chunk sizing macros dependency
Date:   Thu,  2 Apr 2020 19:33:42 +0300
Message-Id: <20200402163356.9029-1-leonid.ravich@dell.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20200402092725.15121-2-leonid.ravich@dell.com>
References: <20200402092725.15121-2-leonid.ravich@dell.com>
X-Sentrion-Hostname: mailuogwprd04.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_06:2020-04-02,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=38 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 mlxlogscore=683 bulkscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=38
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=758 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020131
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

prepare for changing alloc size.

Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
 drivers/dma/ioat/dma.c  | 14 ++++++++------
 drivers/dma/ioat/dma.h  | 10 ++++++----
 drivers/dma/ioat/init.c |  2 +-
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 18c011e..1e0e6c1 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -332,8 +332,8 @@ static dma_cookie_t ioat_tx_submit_unlock(struct dma_async_tx_descriptor *tx)
 	u8 *pos;
 	off_t offs;
 
-	chunk = idx / IOAT_DESCS_PER_2M;
-	idx &= (IOAT_DESCS_PER_2M - 1);
+	chunk = idx / IOAT_DESCS_PER_CHUNK;
+	idx &= (IOAT_DESCS_PER_CHUNK - 1);
 	offs = idx * IOAT_DESC_SZ;
 	pos = (u8 *)ioat_chan->descs[chunk].virt + offs;
 	phys = ioat_chan->descs[chunk].hw + offs;
@@ -370,7 +370,8 @@ struct ioat_ring_ent **
 	if (!ring)
 		return NULL;
 
-	ioat_chan->desc_chunks = chunks = (total_descs * IOAT_DESC_SZ) / SZ_2M;
+	chunks = (total_descs * IOAT_DESC_SZ) / IOAT_CHUNK_SIZE;
+	ioat_chan->desc_chunks = chunks;
 
 	for (i = 0; i < chunks; i++) {
 		struct ioat_descs *descs = &ioat_chan->descs[i];
@@ -382,8 +383,9 @@ struct ioat_ring_ent **
 
 			for (idx = 0; idx < i; idx++) {
 				descs = &ioat_chan->descs[idx];
-				dma_free_coherent(to_dev(ioat_chan), SZ_2M,
-						  descs->virt, descs->hw);
+				dma_free_coherent(to_dev(ioat_chan),
+						IOAT_CHUNK_SIZE,
+						descs->virt, descs->hw);
 				descs->virt = NULL;
 				descs->hw = 0;
 			}
@@ -404,7 +406,7 @@ struct ioat_ring_ent **
 
 			for (idx = 0; idx < ioat_chan->desc_chunks; idx++) {
 				dma_free_coherent(to_dev(ioat_chan),
-						  SZ_2M,
+						  IOAT_CHUNK_SIZE,
 						  ioat_chan->descs[idx].virt,
 						  ioat_chan->descs[idx].hw);
 				ioat_chan->descs[idx].virt = NULL;
diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index b8e8e0b..5216c6b 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -81,6 +81,11 @@ struct ioatdma_device {
 	u32 msixpba;
 };
 
+#define IOAT_MAX_ORDER 16
+#define IOAT_MAX_DESCS (1 << IOAT_MAX_ORDER)
+#define IOAT_CHUNK_SIZE (SZ_2M)
+#define IOAT_DESCS_PER_CHUNK (IOAT_CHUNK_SIZE / IOAT_DESC_SZ)
+
 struct ioat_descs {
 	void *virt;
 	dma_addr_t hw;
@@ -128,7 +133,7 @@ struct ioatdma_chan {
 	u16 produce;
 	struct ioat_ring_ent **ring;
 	spinlock_t prep_lock;
-	struct ioat_descs descs[2];
+	struct ioat_descs descs[IOAT_MAX_DESCS / IOAT_DESCS_PER_CHUNK];
 	int desc_chunks;
 	int intr_coalesce;
 	int prev_intr_coalesce;
@@ -301,9 +306,6 @@ static inline bool is_ioat_bug(unsigned long err)
 	return !!err;
 }
 
-#define IOAT_MAX_ORDER 16
-#define IOAT_MAX_DESCS 65536
-#define IOAT_DESCS_PER_2M 32768
 
 static inline u32 ioat_ring_size(struct ioatdma_chan *ioat_chan)
 {
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 60e9afb..58d1356 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -651,7 +651,7 @@ static void ioat_free_chan_resources(struct dma_chan *c)
 	}
 
 	for (i = 0; i < ioat_chan->desc_chunks; i++) {
-		dma_free_coherent(to_dev(ioat_chan), SZ_2M,
+		dma_free_coherent(to_dev(ioat_chan), IOAT_CHUNK_SIZE,
 				  ioat_chan->descs[i].virt,
 				  ioat_chan->descs[i].hw);
 		ioat_chan->descs[i].virt = NULL;
-- 
1.9.3

