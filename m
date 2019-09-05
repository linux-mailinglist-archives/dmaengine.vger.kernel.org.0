Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 370E0AA932
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 18:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbfIEQhb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 12:37:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40710 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfIEQhb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Sep 2019 12:37:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i5ulD-0005h3-3d; Thu, 05 Sep 2019 16:37:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: iop-adma: make array 'handler' static const, makes object smaller
Date:   Thu,  5 Sep 2019 17:37:26 +0100
Message-Id: <20190905163726.19690-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array 'handler' on the stack but instead make it
static const. Makes the object code smaller by 80 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  38225	   9084	     64	  47373	   b90d	drivers/dma/iop-adma.o

After:
   text	   data	    bss	    dec	    hex	filename
  38081	   9148	     64	  47293	   b8bd	drivers/dma/iop-adma.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/iop-adma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index a3f942a6a946..4dc5478fc156 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -1359,9 +1359,11 @@ static int iop_adma_probe(struct platform_device *pdev)
 	iop_adma_device_clear_err_status(iop_chan);
 
 	for (i = 0; i < 3; i++) {
-		irq_handler_t handler[] = { iop_adma_eot_handler,
-					iop_adma_eoc_handler,
-					iop_adma_err_handler };
+		static const irq_handler_t handler[] = {
+			iop_adma_eot_handler,
+			iop_adma_eoc_handler,
+			iop_adma_err_handler
+		};
 		int irq = platform_get_irq(pdev, i);
 		if (irq < 0) {
 			ret = -ENXIO;
-- 
2.20.1

