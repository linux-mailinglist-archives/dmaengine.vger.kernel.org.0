Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B355096C1
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 07:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384366AbiDUF1J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 01:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384360AbiDUF1F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 01:27:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50D5DFB1
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 22:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C556B82291
        for <dmaengine@vger.kernel.org>; Thu, 21 Apr 2022 05:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18552C385AA;
        Thu, 21 Apr 2022 05:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650518655;
        bh=GEPovwN2jDJX7Eug/l/PAfM2yneCvgYst0A+GEkTq0c=;
        h=From:To:Cc:Subject:Date:From;
        b=FGZ0I4c+owREEmkQKofo0Q+rlAG4TZ42wYfQGcUBS5Imw+kxWLfLatxDHJUNysA5A
         5D025HPKQNVZWfurU0holAs7VpGoGtOeJldKc1N/oR4v8kFev6nVjLPE3V10uCm8kz
         YoMpjB4D7auSfWebnqoq8+crPFjIDKwdHPJ7B0uE+Y/rHUdZqLk2XD8oEyKJXeL2y3
         0vI+Dm5XHBeK7pikATvLCC+lB4LwBcpbH7Tz2BnMIJH2+eVDnQfeLSCJcGNKH9E/h6
         EC2MIPdZc4NJQpGhnp6L+sl8uHgHme6t6Jm9W0RzJqd0rwGiGqOQe6ZjBrl5JFrhhh
         19wWAtncyccew==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Ilya Novikov <i.m.novikov@yadro.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] dmaengine: ptdma: statify pt_tx_status
Date:   Thu, 21 Apr 2022 10:54:07 +0530
Message-Id: <20220421052407.745637-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

LKP bot reports a new warning:
Warning:
drivers/dma/ptdma/ptdma-dmaengine.c:262:1: warning: no previous prototype for 'pt_tx_status' [-Wmissing-prototypes]

pt_tx_status() should be static, so declare as such.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: d965068259d1 ("dmaengine: PTDMA: support polled mode")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/ptdma/ptdma-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index ea07cc42f4d0..cc22d162ce25 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -258,7 +258,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 		pt_cmd_callback(desc, 0);
 }
 
-enum dma_status
+static enum dma_status
 pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		struct dma_tx_state *txstate)
 {
-- 
2.34.1

