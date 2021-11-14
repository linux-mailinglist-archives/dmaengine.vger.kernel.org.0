Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B208744F6FF
	for <lists+dmaengine@lfdr.de>; Sun, 14 Nov 2021 07:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhKNGMD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 14 Nov 2021 01:12:03 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:24254 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229537AbhKNGMC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 14 Nov 2021 01:12:02 -0500
X-QQ-mid: bizesmtp34t1636870141t6olfinn
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 14 Nov 2021 14:09:00 +0800 (CST)
X-QQ-SSF: 01000000002000C0F000B00A0000000
X-QQ-FEAT: lC5HeAtE+yY7ieI7k5ozcsT2mHbmUCx7ecPfiLQCJcdRW/HMeiQe9BFfGAp+t
        j46q9+ju91OdN4ziKKXkkJA5ZA+w2LJcOga3IYFgAymVXZEQPLdU8+mcf1989/ohjhVoHv8
        usK6mPB/qayQ3EJUU6P6ovXmUptfFZimbhW7FqvvHkAvI5yO1ban2qoabkIOxyhFlaEhell
        3ZPOO6FMS2QChk+zAHV/2iqAzCwbkn+VqCH8KhkbvJhA7nOC6DGfFIz8J/r8epgsk+2EPM5
        MtKjOy36xHHiOvaEscnNffjVafnVWMuzqQat4sNNvjtk3Sz8t963WPZROqKoiVBBQtUGaWm
        U3RFoHxYxMwoMDQgF3ytugx2Xplrh3bMX3wayKpDTIZ0sG0DXw=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     vkoul@kernel.org
Cc:     salah.triki@gmail.com, wangborong@cdjrlc.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: ppc4xx: remove unused variable `rval'
Date:   Sun, 14 Nov 2021 14:08:56 +0800
Message-Id: <20211114060856.239314-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The variable used for returning status in
`ppc440spe_adma_dma2rxor_prep_src' function is never changed
and this function just need to return 0. Thus, the `rval' can
be removed and return 0 from `ppc440spe_adma_dma2rxor_prep_src'.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/dma/ppc4xx/adma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index e2b5129c5f84..5e46e347e28b 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -3240,7 +3240,6 @@ static int ppc440spe_adma_dma2rxor_prep_src(
 		struct ppc440spe_rxor *cursor, int index,
 		int src_cnt, u32 addr)
 {
-	int rval = 0;
 	u32 sign;
 	struct ppc440spe_adma_desc_slot *desc = hdesc;
 	int i;
@@ -3348,7 +3347,7 @@ static int ppc440spe_adma_dma2rxor_prep_src(
 		break;
 	}
 
-	return rval;
+	return 0;
 }
 
 /**
-- 
2.33.0

