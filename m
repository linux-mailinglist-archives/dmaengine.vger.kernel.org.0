Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC40545B1E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jun 2022 06:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiFJEb2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jun 2022 00:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiFJEb0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jun 2022 00:31:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C15B4AE34
        for <dmaengine@vger.kernel.org>; Thu,  9 Jun 2022 21:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC2261DD6
        for <dmaengine@vger.kernel.org>; Fri, 10 Jun 2022 04:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2402C34114;
        Fri, 10 Jun 2022 04:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654835484;
        bh=wmiZ1Ha7XV5IHqE9qH49++1HOR84D51Msi+lnzAMyB8=;
        h=From:To:Cc:Subject:Date:From;
        b=Nn3zFP0jpm24uw2z18BC82B8mg8kRv5uTxTTbzYsDzwK5zyXFmvts/9yYwmOREn1G
         RDjpslZ1S/yhfdQjwQNdw1YmNuTROg8ju0wwZvsDBoSy2vSAyLQdW8aRPrFKfXzh1v
         Ojej7eMNR9gZvnkqUc0lEYTTucXqm4mKXxepIqw3LxaDxk1epNB1ogqbixRr/+NTtX
         EKlhdkVJajMG84KBNHiZbWozcC7XR6zviHisHCryZSgqDNY/gt1SDR+zIe7YlL5KB6
         oSFXVeKbWM1CQYt+tpulPLCjUsMPeGK3H9RmFTjISgVq2qX/XURGJRZ0U7Qhdw0wj0
         pw9/3ReLp7IXQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] dmaengine: apple-admac: Fix print format
Date:   Fri, 10 Jun 2022 10:01:17 +0530
Message-Id: <20220610043117.39337-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We get a warning (treated as error now)
drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
drivers/dma/apple-admac.c:209:26: error: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'long unsigned int' [-Werror=format=]
  209 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",

Use %lx for priniting the flag

Fixes: b127315d9a78 ("dmaengine: apple-admac: Add Apple ADMAC driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/apple-admac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index 2425069c186d..c502f8c3aca7 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -206,7 +206,7 @@ static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
 	/* If happens means we have buggy code */
 	WARN_ON_ONCE(addr + tx->period_len > tx->buf_end);
 
-	dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",
+	dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%lx\n",
 		channo, &addr, tx->period_len, FLAG_DESC_NOTIFY);
 
 	writel_relaxed(addr,             ad->base + REG_DESC_WRITE(channo));
-- 
2.34.3

