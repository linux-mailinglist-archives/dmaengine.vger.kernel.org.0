Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06904545453
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jun 2022 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiFISnJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jun 2022 14:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiFISnJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jun 2022 14:43:09 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61D21E7AF8;
        Thu,  9 Jun 2022 11:43:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1654800181; bh=8ZEDC9HewScHp00W0Vw5klKniAEYKDjKhKDVNSK6OOU=;
        h=From:To:Cc:Subject:Date;
        b=px6qoy7FiskG+Z3anl7TxNFwGF7UnJqjxDERfyPLa+fTPdkDH8JfmC+vIye5H6rTA
         +1m+jcZxGTjemXB7pbrLxQJ23S7F86hlk265VE3UEM32dudovgOOKaxzy7uYJQvGtf
         W3x5Pnu3Uwz2RiqajIpkAEy0dIdvAzl1dLZd0mzo=
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH] dmaengine: apple-admac: Fix compile warning
Date:   Thu,  9 Jun 2022 20:43:01 +0200
Message-Id: <20220609184301.8242-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix a warning of bad format specifier:

  drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
  drivers/dma/apple-admac.c:209:26: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'long unsigned int' [-Wformat=]
      209 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---

Follow-up to the recent ADMAC series, feel free to squash:
https://lore.kernel.org/asahi/20220531213615.7822-1-povik+lin@cutebit.org/T/#t

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
2.33.0

