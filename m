Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E796A1ACE63
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 19:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgDPRHz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 13:07:55 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:59464 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727795AbgDPRHy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Apr 2020 13:07:54 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGs2AL001932;
        Thu, 16 Apr 2020 13:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=xN0JW61ebO1wBkMu3X1WK/Z+DIOah7AFxvr45+zINrA=;
 b=DHOTO4rDP1K8ejteq3PtNPrFhkY1acK3UUWWpGNYqUGbPAohRJYM6y1gdic1SHQKLCLb
 Sk8GJ4Fymh/74qa+MDfSPSgG6LIct2RgYZW0Y0xR+iatsK86zOy8wr+BSTm/AJg/HYPc
 naTo3xSsAYeMYUSm5GGkaJ1jrSAa+am1kBwbXAiNU2pQGck0BOVBnHE3KRzquZYWw7Ox
 SGF6U2iRWWBEF8Qg8yQS3tbV9fSVdfBZ4xwqGXqoiWyYSvbpJwi8FQt1jBNnVlg8sSm+
 7FLhfemPwRL8Lh2D4D7V+wbMknFCSWpTDqWZvRDiOadiSirAaayoA66eBcpSMnC3ublt aA== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 30dna73bku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 13:07:40 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGuWaH031824;
        Thu, 16 Apr 2020 13:07:39 -0400
Received: from mailuogwhop.emc.com (mailuogwhop-nat.lss.emc.com [168.159.213.141] (may be forged))
        by mx0b-00154901.pphosted.com with ESMTP id 30dn7m4d4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Apr 2020 13:07:39 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd05.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03GH7cpE002340;
        Thu, 16 Apr 2020 13:07:38 -0400
Received: from mailapphubprd03.lss.emc.com ([mailhub.lss.emc.com [10.253.24.70]]) by mailuogwprd05.lss.emc.com with ESMTP id 03GH7C9X002134 ;
          Thu, 16 Apr 2020 13:07:13 -0400
Received: from arwen2.xiolab.lab.emc.com. (arwen2.xiolab.lab.emc.com [10.76.211.113])
        by mailapphubprd03.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 03GH6hRw020685;
        Thu, 16 Apr 2020 13:07:10 -0400
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
Subject: [PATCH v3 2/2] dmaengine: ioat: Decreasing allocation chunk size 2M->512K
Date:   Thu, 16 Apr 2020 20:06:22 +0300
Message-Id: <20200416170628.16196-2-leonid.ravich@dell.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20200416170628.16196-1-leonid.ravich@dell.com>
References: <20200402163356.9029-2-leonid.ravich@dell.com>
 <20200416170628.16196-1-leonid.ravich@dell.com>
X-Sentrion-Hostname: mailuogwprd05.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_07:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 mlxlogscore=588 suspectscore=13 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160120
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=13 mlxlogscore=642 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160120
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

requreing kmalloc of 2M high chance to fail in
fragmented memory.
IOAT ring requires 64k * 64B memory
which will be achived by 512k * 8 allocation
instead of 2M * 2.

Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
Changing in v3:
  - Make the commit message more clearer.


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

