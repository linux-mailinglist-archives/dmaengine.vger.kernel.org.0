Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AA61C9A13
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2020 20:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgEGS4V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 May 2020 14:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgEGS4U (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 7 May 2020 14:56:20 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3DC9216FD;
        Thu,  7 May 2020 18:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877780;
        bh=jm3fKnCO4Xf3QTCG3k8/S+/8DNeXKLAAKD5XoFMMhyY=;
        h=Date:From:To:Cc:Subject:From;
        b=j8F77k+hOMYWNsm4ZYGQsIc2ubNpcV2lJi+sF3xlCpyYvURINI7X9RHHgSWg7/c0j
         k45JS4quwF/uKI6F4RcPAt11oF+N91Qn+NxJt0yJ/nN7nFfTnYIiWChCWiNAjpgmMV
         lhfWkscvzOYaHFDVlhw9do8omT79Q0bRoM6p4Wh0=
Date:   Thu, 7 May 2020 14:00:46 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: at_xdmac: Replace zero-length array with
 flexible-array
Message-ID: <20200507190046.GA15298@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/dma/at_xdmac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index bb0eaf38b594..fd92f048c491 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -212,7 +212,7 @@ struct at_xdmac {
 	struct clk		*clk;
 	u32			save_gim;
 	struct dma_pool		*at_xdmac_desc_pool;
-	struct at_xdmac_chan	chan[0];
+	struct at_xdmac_chan	chan[];
 };
 
 

