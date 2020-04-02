Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3C19C72A
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2020 18:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbgDBQfy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Apr 2020 12:35:54 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:51974 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732404AbgDBQfx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Apr 2020 12:35:53 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032G90hv006159;
        Thu, 2 Apr 2020 12:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=SL7KjVQq0CThbF5aauFKpDTKsXCfF/tUY2gLB9nW+7k=;
 b=BbcjxCJ4nV+fBMMexmX2EQaRnUKxfyocQhQ5hrRqNlFm0v6YXeKy/4PtBOtjMSiO7i2E
 KLuWOhN8VhSveibVOUKB2ww0mkBmLASIUb1DaEuYaOkYAyiveqfXGVoLJkVUhd6XPG3z
 grgcIGfKtPUtlNLOlH27EodFNH0LiAHvePlIgZMPvU0BhPRVuZ6yytyOVCQplrXs3cMN
 WSOou1I7XlqHKku8Gs8xLbO5i0pzb2B5osmAYfb+z0Js0sCTacXAmVSai8WdnLwbD2ci
 xFbuIwLxSSKk9Xg80eEd7HQnANK0zRHJpcmqJ2ul8/OWW4alJI3Ry894bfrH0ruwjpUK Qg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 3021red436-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 12:35:38 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032GMann134013;
        Thu, 2 Apr 2020 12:35:37 -0400
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com [128.221.224.79] (may be forged))
        by mx0b-00154901.pphosted.com with ESMTP id 305403m12d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Apr 2020 12:35:37 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd53.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 032GZRXZ028637;
        Thu, 2 Apr 2020 12:35:27 -0400
Received: from mailsyshubprd06.lss.emc.com ([mailsyshubprd06.lss.emc.com [10.253.24.24]]) by mailuogwprd53.lss.emc.com with ESMTP id 032GYmZK028310 ;
          Thu, 2 Apr 2020 12:34:49 -0400
Received: from arwen2.xiolab.lab.emc.com. (arwen2.xiolab.lab.emc.com [10.76.211.113])
        by mailsyshubprd06.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 032GYR3g030730;
        Thu, 2 Apr 2020 12:34:45 -0400
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
Subject: [PATCH v2 2/2] dmaengine: ioat: Decreasing  allocation chunk size 2M -> 512K
Date:   Thu,  2 Apr 2020 19:33:43 +0300
Message-Id: <20200402163356.9029-2-leonid.ravich@dell.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20200402163356.9029-1-leonid.ravich@dell.com>
References: <20200402092725.15121-2-leonid.ravich@dell.com>
 <20200402163356.9029-1-leonid.ravich@dell.com>
X-Sentrion-Hostname: mailuogwprd53.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_06:2020-04-02,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=2 clxscore=1015
 suspectscore=13 phishscore=0 mlxscore=2 mlxlogscore=168 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020131
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 suspectscore=13 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=242
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020131
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

current IOAT driver using big (2MB) allocations chunk for its descriptors
therefore each ioat dma engine need 2 such chunks
(64k entres in ring  each entry 64B = 4MB)
requiring 2 * 2M * dmaengine contiguies memory chunk
might fail due to memory fragmention.

so we decreasing chunk size and using more chunks.

Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
 drivers/dma/ioat/dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index 5216c6b..e6b622e 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -83,7 +83,7 @@ struct ioatdma_device {
 
 #define IOAT_MAX_ORDER 16
 #define IOAT_MAX_DESCS (1 << IOAT_MAX_ORDER)
-#define IOAT_CHUNK_SIZE (SZ_2M)
+#define IOAT_CHUNK_SIZE (SZ_512K)
 #define IOAT_DESCS_PER_CHUNK (IOAT_CHUNK_SIZE / IOAT_DESC_SZ)
 
 struct ioat_descs {
-- 
1.9.3

