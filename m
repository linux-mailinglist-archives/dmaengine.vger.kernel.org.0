Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282B2224815
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jul 2020 04:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGRCv0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 22:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRCvZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 22:51:25 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2DDC0619D2;
        Fri, 17 Jul 2020 19:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=znSOR8L1efmHagHYjpsDkEAzj1cWC+5PCZ7ny1eb2x4=; b=wvST1GHyTKY74+2AAGY/DWUHx5
        MczVZOPhc2lPPVn8vK5l9QOMasS7ITz5KQA87PXRDOeA+6NIhqMoTZkcIA7QxoMdU2ckD6rylAPSK
        3eoRswbGhPVIGv/32ia9zO+UD1N6qNyd7OkhmLvHPXh30ODpAwKYORoJB71lMRWijekcgnTbs2iuD
        /d5Ijk6QLxHFbAr3ck72tbNN3NXPmsRzS/E819oaPMOujUJCqiKdygvOfcvgEA0GB8WgBAwwUSFGO
        oJoFqgn9dj5xdhbyr0FsQzceD/noDIblGamzONzvg8URscfQIQSTBjjxqF5p9WkQBx8DKhxVR43oo
        OKGbcgNA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwcwc-0006fx-La; Sat, 18 Jul 2020 02:51:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] dmaengine: linux/dmaengine.h: drop duplicated word in a
 comment
To:     LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Message-ID: <06e64046-ebf1-15db-dbaf-73698de3b493@infradead.org>
Date:   Fri, 17 Jul 2020 19:51:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "has" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 include/linux/dmaengine.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/dmaengine.h
+++ linux-next-20200714/include/linux/dmaengine.h
@@ -164,7 +164,7 @@ struct dma_interleaved_template {
  * @DMA_PREP_INTERRUPT - trigger an interrupt (callback) upon completion of
  *  this transaction
  * @DMA_CTRL_ACK - if clear, the descriptor cannot be reused until the client
- *  acknowledges receipt, i.e. has has a chance to establish any dependency
+ *  acknowledges receipt, i.e. has a chance to establish any dependency
  *  chains
  * @DMA_PREP_PQ_DISABLE_P - prevent generation of P while generating Q
  * @DMA_PREP_PQ_DISABLE_Q - prevent generation of Q while generating P

