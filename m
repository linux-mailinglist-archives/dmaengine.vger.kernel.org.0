Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5B415B64E
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 02:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgBMBDZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Feb 2020 20:03:25 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.202]:41127 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729185AbgBMBDZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Feb 2020 20:03:25 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 7A9B935E9F
        for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2020 18:39:29 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 22XRj6YCPRP4z22XRjY8l1; Wed, 12 Feb 2020 18:39:29 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W5rxnkEmmddJcYu6W8YmSeFeCtiHRsFrV/J1RxPSojs=; b=Q3oAKG3kSVV5k7Ll+WJyZb40ih
        CqEn/zx1JFKH21BqqxP22Pr1YedrmUtE9CKqG48oW4x/eBtU/Pma3B5ZBuX4vAKJWChR+/P4aEauB
        ffnfMlPSGE8MUDHieJH4WRaXtD9Nqz6cMmrd4+R4kLZvjcQUlpJv7fW4qNGjlN9aQwuHiW9/sE6Rj
        YGxi26ZL2SZ+V2OYSAyCXFwYF7x39OXg+b6wATsZUNZQTYQ0PZcRsacYjDkx99lQc0/cXFvlLTCEu
        MPYjU3AgMLJzvPfCXkjZBb/wXA+Sv5/CsMHLn2v0Stae4FpxlqkgY+dFWEc8wHlHzqq81Ev/uvjp9
        +sGAux+A==;
Received: from [200.68.141.42] (port=17499 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j22XP-003gqx-DZ; Wed, 12 Feb 2020 18:39:27 -0600
Date:   Wed, 12 Feb 2020 18:39:25 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] dmaengine: ti: omap-dma: Replace zero-length array with
 flexible-array member
Message-ID: <20200213003925.GA6906@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.141.42
X-Source-L: No
X-Exim-ID: 1j22XP-003gqx-DZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.42]:17499
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 54
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/dma/ti/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index a014ab96e673..918301e17552 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -124,7 +124,7 @@ struct omap_desc {
 	uint32_t csdp;		/* CSDP value */
 
 	unsigned sglen;
-	struct omap_sg sg[0];
+	struct omap_sg sg[];
 };
 
 enum {
-- 
2.23.0

