Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6722345F89
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 14:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhCWNU1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Mar 2021 09:20:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49148 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhCWNUU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Mar 2021 09:20:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NDKEts133624;
        Tue, 23 Mar 2021 13:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=GRh5VjC7KX+AhodzilCiXRQmjLUkaOmy1TDSen1Tafk=;
 b=uKStWlWeIL0+YwBp3mvkjS1P0aod81QEVZfq5qeGD3NLNzvIlm66xxiyiv2C5muG0SXS
 u08ROZMQN9BN6TfDvLVrG8yowPPnjMMyzHHG9xfDuAjOZflxm8dOi3ekLnIvpnqNvLcG
 831A01FaFSfqqpswgR4mhY6V3Pf7u1aEp11InSXD35tvi3l+RateZN03+WA+GdPXHFXa
 5yPNjOjKJEv7nHWzupCtOdsIemAu2BablxYpSRDr4OXNKlNqLWaKABkDWqDQmYuTfUEx
 XlSxhb+uM3rU0wk/ZSIJXW8eArViz3xOaSfjxxBi5idt6OxRNbMv2/I3j2iFadzAZGNF Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37d6jbf223-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 13:20:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NDKAaa054364;
        Tue, 23 Mar 2021 13:20:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37dttrx2p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 13:20:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12NDK5m0001588;
        Tue, 23 Mar 2021 13:20:06 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Mar 2021 06:20:05 -0700
Date:   Tue, 23 Mar 2021 16:19:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: plx_dma: add a missing put_device() on error path
Message-ID: <YFnq/0IQzixtAbC1@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230098
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230098
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a missing put_device(&pdev->dev) if the call to
dma_async_device_register(dma); fails.

Fixes: 905ca51e63be ("dmaengine: plx-dma: Introduce PLX DMA engine PCI driver skeleton")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/dma/plx_dma.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index f387c5bbc170..166934544161 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -507,10 +507,8 @@ static int plx_dma_create(struct pci_dev *pdev)
 
 	rc = request_irq(pci_irq_vector(pdev, 0), plx_dma_isr, 0,
 			 KBUILD_MODNAME, plxdev);
-	if (rc) {
-		kfree(plxdev);
-		return rc;
-	}
+	if (rc)
+		goto free_plx;
 
 	spin_lock_init(&plxdev->ring_lock);
 	tasklet_setup(&plxdev->desc_task, plx_dma_desc_task);
@@ -540,14 +538,20 @@ static int plx_dma_create(struct pci_dev *pdev)
 	rc = dma_async_device_register(dma);
 	if (rc) {
 		pci_err(pdev, "Failed to register dma device: %d\n", rc);
-		free_irq(pci_irq_vector(pdev, 0),  plxdev);
-		kfree(plxdev);
-		return rc;
+		goto put_device;
 	}
 
 	pci_set_drvdata(pdev, plxdev);
 
 	return 0;
+
+put_device:
+	put_device(&pdev->dev);
+	free_irq(pci_irq_vector(pdev, 0),  plxdev);
+free_plx:
+	kfree(plxdev);
+
+	return rc;
 }
 
 static int plx_dma_probe(struct pci_dev *pdev,
-- 
2.30.2

