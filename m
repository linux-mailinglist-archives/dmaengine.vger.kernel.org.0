Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15AB5A66E6
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 17:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiH3PHX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Aug 2022 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiH3PHW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Aug 2022 11:07:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD98D844F6;
        Tue, 30 Aug 2022 08:07:20 -0700 (PDT)
X-QQ-mid: bizesmtp79t1661872037tzm07l60
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 Aug 2022 23:07:11 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: fs34Pe/+C2TS8vOMhVuHguwbSVfXtrug6ryQMP84iPpDi2SxhvL26CrFpQBTl
        y7WnHmjSuNdJbcY8P4SMmgWZRyg/2xQVvzeLIP2WMJdZGS0xtF0YzCod6l7nmMAdgiUt7RZ
        vhOd7Hh6mhkU2lAN30vx4cACKEFse9mER4BcnYD7LrOU/BxRpJPz6zuEH/h5TcJXz8Cb4Rk
        hmEePUZurdzFthIKJHahR/0FUVehyxN4XIiKXtcTyGrjBYwqufhEZyNKYDUDhmDAucKm1aY
        rp99Bbva/qAlwX+XDlIqmcwKyOdP4NxmCVJwAzvA2OIa2wi32c/9SE4WhsFn0vLv1fGdcOz
        9J2aJbLh20jS+JWYo4g+3zp2VgrkT/z/koEOef+KCEOSOhsjNNW15gk26XsvQ==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] dmaengine: pl08x: Fix double word
Date:   Tue, 30 Aug 2022 11:07:08 -0400
Message-Id: <20220830150708.24507-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix the double word "many" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/dma/amba-pl08x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 487a01aa207d..eea8bd33b4b7 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2367,7 +2367,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 	INIT_LIST_HEAD(&dmadev->channels);
 
 	/*
-	 * Register as many many memcpy as we have physical channels,
+	 * Register as many memcpy as we have physical channels,
 	 * we won't always be able to use all but the code will have
 	 * to cope with that situation.
 	 */
-- 
2.35.1

