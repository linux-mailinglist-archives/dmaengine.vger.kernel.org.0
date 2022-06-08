Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A645437C6
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jun 2022 17:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbiFHPmH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jun 2022 11:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244527AbiFHPmG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jun 2022 11:42:06 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99E41DD4F1
        for <dmaengine@vger.kernel.org>; Wed,  8 Jun 2022 08:42:04 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:243a:e14b:d107:1f56])
        by xavier.telenet-ops.be with bizsmtp
        id gfi3270041qF9lr01fi377; Wed, 08 Jun 2022 17:42:03 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nyxoo-003E1W-QK; Wed, 08 Jun 2022 17:42:02 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nyxoo-008kPP-BB; Wed, 08 Jun 2022 17:42:02 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: dmatest: Remove spaces before tabs
Date:   Wed,  8 Jun 2022 17:42:01 +0200
Message-Id: <d863916120d043e3f9dd2f2670238c34f68f7d5f.1654702886.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Scripts/checkpath.pl says "please, no space before tabs".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/dmatest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 0a2168a4ccb0cf17..8ad8e7011d0be913 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -579,10 +579,10 @@ static int dmatest_func(void *data)
 	unsigned int		total_tests = 0;
 	dma_cookie_t		cookie;
 	enum dma_status		status;
-	enum dma_ctrl_flags 	flags;
+	enum dma_ctrl_flags	flags;
 	u8			*pq_coefs = NULL;
 	int			ret;
-	unsigned int 		buf_size;
+	unsigned int		buf_size;
 	struct dmatest_data	*src;
 	struct dmatest_data	*dst;
 	int			i;
-- 
2.25.1

