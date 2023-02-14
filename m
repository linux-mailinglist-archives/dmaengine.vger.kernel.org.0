Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF46960C9
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 11:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjBNKc3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 05:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjBNKc2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 05:32:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96A4233DA;
        Tue, 14 Feb 2023 02:32:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71191B8172F;
        Tue, 14 Feb 2023 10:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2061C433EF;
        Tue, 14 Feb 2023 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676370745;
        bh=QKVpoLD8wVqdCgKWH7wd37asoN5e+iUvQwCs7hR4hXM=;
        h=From:To:Cc:Subject:Date:From;
        b=Sw7D+yEHbygy5LQ1x6KbfnsfhpAWSBJthuVToOYCL+NWxUJrCO/OpuKQCx5shulDf
         TooP8bFpjDX45smjOr9V7/lgh0Mc2aCheLUadTmmHpd8ugoM0/jFMLj5DfJqUo3R6o
         YrUnG7zz59gQo9SK4vIm93miV2Bvu6fi3neva8nNmSp6NODIIPEZIL4gHFcryT2xra
         /5jBS8x20M9MERZHHkaKRMFwWajvPYszSzOyqP7wbGzSHU1odhMERPwWmaDqLMYffo
         NWCDq/4b71vV+9OAiVCrhWZ1nxDYsnblsM2yTKIOYpBv13ASVzJpFbem16fYi2IhMM
         V4fCqfFiiSk+g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: stm32-dma: avoid bitfield overflow assertion
Date:   Tue, 14 Feb 2023 11:32:13 +0100
Message-Id: <20230214103222.1193307-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

stm32_dma_get_burst() returns a negative error code for invalid
input, which gets turned into a large u32 value in stm32_dma_prep_dma_memcpy()
that in turn triggers an assertion because it does not fit into a
two-bit field:

drivers/dma/stm32-dma.c: In function 'stm32_dma_prep_dma_memcpy':
include/linux/compiler_types.h:399:38: error: call to '__compiletime_assert_310' declared with attribute error: FIELD_PREP: value too large for the field
  399 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
include/linux/compiler_types.h:380:4: note: in definition of macro '__compiletime_assert'
  380 |    prefix ## suffix();    \
      |    ^~~~~~
include/linux/compiler_types.h:399:2: note: in expansion of macro '_compiletime_assert'
  399 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:68:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   68 |   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
      |   ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:3: note: in expansion of macro '__BF_FIELD_CHECK'
  114 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
      |   ^~~~~~~~~~~~~~~~
drivers/dma/stm32-dma.c:1273:4: note: in expansion of macro 'FIELD_PREP'
 1273 |    FIELD_PREP(STM32_DMA_SCR_PBURST_MASK, dma_burst) |
      |    ^~~~~~~~~~

I only see this with older gcc versions like gcc-6.5 or gcc-9.5 but not
with gcc-12.2 or higher. My best guess is that this is the result of
changes to __builtin_constant_p(), which seems to treat the 'cold'
codepath after an error message as a constant branch, while in newer
gcc versions the range check is skipped after determining that
dma_burst is never a compile-time constant.

As an easy workaround, assume the error can happen, so try to handle this
by failing stm32_dma_prep_dma_memcpy() before the assertion.

Fixes: 1c32d6c37cc2 ("dmaengine: stm32-dma: use bitfield helpers")
Fixes: a2b6103b7a8a ("dmaengine: stm32-dma: Improve memory burst management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/stm32-dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 37674029cb42..e3cd4b0525e6 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1266,6 +1266,10 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 		best_burst = stm32_dma_get_best_burst(len, STM32_DMA_MAX_BURST,
 						      threshold, max_width);
 		dma_burst = stm32_dma_get_burst(chan, best_burst);
+		if (dma_burst > 3) {
+			kfree(desc);
+			return NULL;
+		}
 
 		stm32_dma_clear_reg(&desc->sg_req[i].chan_reg);
 		desc->sg_req[i].chan_reg.dma_scr =
-- 
2.39.1

