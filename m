Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D355EB374
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiIZVqd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 17:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIZVqc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 17:46:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2F09AFCA;
        Mon, 26 Sep 2022 14:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B372DB811FC;
        Mon, 26 Sep 2022 21:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF63C433D6;
        Mon, 26 Sep 2022 21:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664228789;
        bh=2+SloBY+jDAlwq01BM/YlVe4LL61s2uwBV+FOoix9Hg=;
        h=Date:From:To:Cc:Subject:From;
        b=IUyQJKZKMNvQMVDa5pwPltIpqA9vuoitPz668khCwUFllBwBepH54hwNV+BS+W1E6
         oWThT0EdHf3ZkFsgGTyrL1V0/eZ15rXQtHVow6MsfzOnPgHAQ0jMmQ4As5u45YL6NJ
         kCpjaTtOeAqcbkKeSSP1rGibGnmkDGF4m9BS5RPZGurEp4fmfyo1z34DrqTUMIf97h
         HKzTHK9oxxhOqwy36kmkJQdscWjdgpdjxit7pU/6Whp5hjZJgmSDwHhkdAn9jlJ/kM
         hYoMNoySNjzdU8CKZYO5smb2IfwBCjJtFa1dPvRIjGVRdJbROWw4c1pJBk5ZdeQLYs
         JizPRgkQg2Ggw==
Date:   Mon, 26 Sep 2022 16:46:24 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] dmaengine: sh: rcar-dmac: Replace zero-length arrays
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <YzIdsJqsR3LH2qEK@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members, instead. So, replace zero-length arrays
declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
helper macro.

This helper allows for flexible-array members in unions.

Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/217
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/dma/sh/rcar-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 13d12d660cc2..641d689d17ff 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -103,8 +103,8 @@ struct rcar_dmac_desc_page {
 	struct list_head node;
 
 	union {
-		struct rcar_dmac_desc descs[0];
-		struct rcar_dmac_xfer_chunk chunks[0];
+		DECLARE_FLEX_ARRAY(struct rcar_dmac_desc, descs);
+		DECLARE_FLEX_ARRAY(struct rcar_dmac_xfer_chunk, chunks);
 	};
 };
 
-- 
2.34.1

