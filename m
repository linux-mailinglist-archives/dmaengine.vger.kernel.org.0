Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5056B15B640
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 01:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgBMA6T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Feb 2020 19:58:19 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.202]:23864 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729132AbgBMA6T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Feb 2020 19:58:19 -0500
X-Greylist: delayed 1359 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 19:58:18 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 27CA026620
        for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2020 18:35:39 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 22Tijc0kpEfyq22Tjjlf1B; Wed, 12 Feb 2020 18:35:39 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fj1EsM7KBtbLu9zEu9J4LZPmGuqoK3e/mqA04voGYHM=; b=rdqPEorIYVAWijtrjXYLTv7gxJ
        bUbshf+azRdrdo4/l5HJo9EST8kvqO+WPoCpoTxXEp6YdOib1G7B7Pf404o9JEr9Jn/r7RkmdeBb4
        VV/ED7hO1B4eVQ1djz9gDGy+17mPhlNq9VXJaw6V3TDlmbbFziNWJa0UO2G/IPOxZBlqmDI7b9Wj2
        jG1r42X5XQOnBnFYACDMVJJ2klKSIyEECne1QOw3ARe3DNSKLTJr6eGd7nup0v3WtXQBaxaIa9RLi
        Aum6exNjXQiTfdnxRAmHnCaQa8+F/4T/4CTPl398yaQmDhicm9mGbzSYoBYnP+qi9GhBetsC8klC5
        N2pmV64w==;
Received: from [200.68.141.42] (port=21619 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j22Th-003f1y-39; Wed, 12 Feb 2020 18:35:37 -0600
Date:   Wed, 12 Feb 2020 18:35:35 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] dmaengine: uniphier-mdmac: replace zero-length array with
 flexible-array member
Message-ID: <20200213003535.GA3269@embeddedor.com>
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
X-Exim-ID: 1j22Th-003f1y-39
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.42]:21619
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 45
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
 drivers/dma/uniphier-mdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/uniphier-mdmac.c b/drivers/dma/uniphier-mdmac.c
index 21b8f1131d55..618839df0748 100644
--- a/drivers/dma/uniphier-mdmac.c
+++ b/drivers/dma/uniphier-mdmac.c
@@ -68,7 +68,7 @@ struct uniphier_mdmac_device {
 	struct dma_device ddev;
 	struct clk *clk;
 	void __iomem *reg_base;
-	struct uniphier_mdmac_chan channels[0];
+	struct uniphier_mdmac_chan channels[];
 };
 
 static struct uniphier_mdmac_chan *
-- 
2.23.0

