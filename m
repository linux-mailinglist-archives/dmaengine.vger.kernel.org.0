Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9355219BEC3
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2020 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387719AbgDBJir (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Apr 2020 05:38:47 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:25740 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgDBJiq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Apr 2020 05:38:46 -0400
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 05:38:45 EDT
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0329Ot01026600;
        Thu, 2 Apr 2020 05:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=7Ocow47AB1qZAY92zenrcfT0CCgfnPw2mvZ8Wspme3k=;
 b=WR44TD0oVT2tgVQRLV1iEGn6ZPCHXm5ftpt2b71HrPki5gFcOVsy9FDdyqM9ChlEtQaV
 UjNQ8b1rymLV0iDOJj1GdpR8n7P+YORh9QiuDi9w4V02s7kR/swm+D5DQv5XT6KnT3PO
 gDHNBCmcVHTtFSimvWYPCLT5Q7RtY0815R4U0tS9ISwFMl4SUOWaTAmVSatRGFJgbNr6
 UMcGXVt79//6J2O8azJctbl2Ro8/H6Tz24ioopgB7j+ZxX8TOFa5xYddwvUQvusxyI/f
 Vovy/VjTKTBujgh9w4Kwru77F5xZwX4OoFju3zyjvfCtJEat7smKtyrLLm1ZMN7ODFSC LA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 3021reb5ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 05:28:20 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0329Oc4c093473;
        Thu, 2 Apr 2020 05:28:19 -0400
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com [128.221.224.79] (may be forged))
        by mx0b-00154901.pphosted.com with ESMTP id 3023cjp9wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Apr 2020 05:28:19 -0400
Received: from emc.com (localhost [127.0.0.1])
        by mailuogwprd53.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 0329RmcU027368;
        Thu, 2 Apr 2020 05:28:18 -0400
Received: from mailsyshubprd05.lss.emc.com ([mailsyshubprd05.lss.emc.com [10.253.24.23]]) by mailuogwprd53.lss.emc.com with ESMTP id 0329Rr16027395 ;
          Thu, 2 Apr 2020 05:27:54 -0400
Received: from arwen2.xiolab.lab.emc.com. (arwen2.xiolab.lab.emc.com [10.76.211.113])
        by mailsyshubprd05.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id 0329Re2m010727;
        Thu, 2 Apr 2020 05:27:50 -0400
From:   leonid.ravich@dell.com
To:     dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: ioat: Decreasing  allocation chunk size 2M -> 512K
Date:   Thu,  2 Apr 2020 12:27:18 +0300
Message-Id: <20200402092725.15121-2-leonid.ravich@dell.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20200402092725.15121-1-leonid.ravich@dell.com>
References: <20200402092725.15121-1-leonid.ravich@dell.com>
X-Sentrion-Hostname: mailuogwprd53.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_01:2020-03-31,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=13 mlxlogscore=338 impostorscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020085
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 suspectscore=13 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=411
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020085
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

so we decresging chunk size and using more chunks.

Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
 drivers/dma/ioat/dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index 535aba9..e9757bc 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -83,7 +83,7 @@ struct ioatdma_device {
 
 #define IOAT_MAX_ORDER 16
 #define IOAT_MAX_DESCS (1 << IOAT_MAX_ORDER)
-#define IOAT_CHUNK_SIZE (SZ_2M)
+#define IOAT_CHUNK_SIZE (SZ_512K)
 #define IOAT_DESCS_PER_CHUNK (IOAT_CHUNK_SIZE/IOAT_DESC_SZ)
 
 struct ioat_descs {
-- 
1.9.3

