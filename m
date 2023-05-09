Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F816FBF00
	for <lists+dmaengine@lfdr.de>; Tue,  9 May 2023 08:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjEIGHa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 May 2023 02:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEIGHa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 May 2023 02:07:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0DA83E5;
        Mon,  8 May 2023 23:07:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348Nx6Dl023318;
        Tue, 9 May 2023 06:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=zc6EEEn1oYKcQyCcTdpQ0tg3EWfoYrDwYkY4xNPZ6lM=;
 b=uYMHKPuPi4RQ2yt5I21hqMmUjFVKl9YPGb0fF73b3dM4Dovira4htF0CpJ93rsHC+rPr
 EAl09QGEsbPppm4bSbE6JKov3cFhGf59Dek/DGIvSmvM/CUa0m7EUsuwqSeodT+g5Zyp
 bmYkHsfKj/z6vx9Gnc2q4oD/UJ51rDLR8nq8pH1rDgCMUIOTpLdF3QL78cLhrDlWmgXv
 zIcjbfO6p+pNspkPICrCBWM50H9bDl9UogDgYwX5hdI2dt1ZN/DPOoWph1YdpM1LDZMR
 XCiezHPh6HwINo4Q5wbRHcwhxRattI4SKs6j9w3MWpZRptG5EICujE3hIH0Urp3hkcpq Fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7770wbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 06:07:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3495YbvY001626;
        Tue, 9 May 2023 06:07:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf82v67hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 06:07:22 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34967Mp6003662;
        Tue, 9 May 2023 06:07:22 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qf82v67h9-1;
        Tue, 09 May 2023 06:07:22 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, kernel-janitors@vger.kernel.org,
        dan.carpenter@linaro.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Fix passing freed memory in idxd_cdev_open()
Date:   Mon,  8 May 2023 23:07:16 -0700
Message-Id: <20230509060716.2830630-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090046
X-Proofpoint-GUID: gOlNjW3nC6OWyAlF8Vfp01P1ROCOomG5
X-Proofpoint-ORIG-GUID: gOlNjW3nC6OWyAlF8Vfp01P1ROCOomG5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Smatch warns:
	drivers/dma/idxd/cdev.c:327:
		idxd_cdev_open() warn: 'sva' was already freed.

When idxd_wq_set_pasid() fails, the current code unbinds sva and then
goes to 'failed_set_pasid' where iommu_sva_unbind_device is called
again causing the above warning.
[ device_user_pasid_enabled(idxd) is still true when calling
failed_set_pasid ]

Fix this by removing additional unbind when idxd_wq_set_pasid() fails

Fixes: b022f59725f0 ("dmaengine: idxd: add idxd_copy_cr() to copy user completion record during page fault handling")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is purely based on static analysis. Only compile tested.
---
 drivers/dma/idxd/cdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ecbf67c2ad2b..d32deb9b4e3d 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -277,7 +277,6 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 		if (wq_dedicated(wq)) {
 			rc = idxd_wq_set_pasid(wq, pasid);
 			if (rc < 0) {
-				iommu_sva_unbind_device(sva);
 				dev_err(dev, "wq set pasid failed: %d\n", rc);
 				goto failed_set_pasid;
 			}
-- 
2.38.1

