Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65D954E31A
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377011AbiFPONT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 10:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiFPONS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 10:13:18 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3D6201BC
        for <dmaengine@vger.kernel.org>; Thu, 16 Jun 2022 07:13:16 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:5439:2bcc:4a70:48e8])
        by michel.telenet-ops.be with bizsmtp
        id jqDE270064lJ8fu06qDEa8; Thu, 16 Jun 2022 16:13:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o1qFF-004C4l-FL; Thu, 16 Jun 2022 16:13:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o1qFE-008CHy-VN; Thu, 16 Jun 2022 16:13:12 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] dmaengine: apple-admac: Use {low,upp}er_32_bits() to split 64-bit address
Date:   Thu, 16 Jun 2022 16:13:12 +0200
Message-Id: <20220616141312.1953819-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If CONFIG_PHYS_ADDR_T_64BIT is not set:

    drivers/dma/apple-admac.c: In function ‘admac_cyclic_write_one_desc’:
    drivers/dma/apple-admac.c:213:22: error: right shift count >= width of type [-Werror=shift-count-overflow]
      213 |  writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
          |                      ^~

Fix this by using the {low,upp}er_32_bits() helper macros to obtain the
address parts.

Reported-by: noreply@ellerman.id.au
Fixes: b127315d9a78c011 ("dmaengine: apple-admac: Add Apple ADMAC driver")
Acked-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Add Acked-by,
  - Improve summary.
---
 drivers/dma/apple-admac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index c502f8c3aca79be1..d1f74a3aa999d773 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -209,10 +209,10 @@ static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
 	dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%lx\n",
 		channo, &addr, tx->period_len, FLAG_DESC_NOTIFY);
 
-	writel_relaxed(addr,             ad->base + REG_DESC_WRITE(channo));
-	writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
-	writel_relaxed(tx->period_len,   ad->base + REG_DESC_WRITE(channo));
-	writel_relaxed(FLAG_DESC_NOTIFY, ad->base + REG_DESC_WRITE(channo));
+	writel_relaxed(lower_32_bits(addr), ad->base + REG_DESC_WRITE(channo));
+	writel_relaxed(upper_32_bits(addr), ad->base + REG_DESC_WRITE(channo));
+	writel_relaxed(tx->period_len,      ad->base + REG_DESC_WRITE(channo));
+	writel_relaxed(FLAG_DESC_NOTIFY,    ad->base + REG_DESC_WRITE(channo));
 
 	tx->submitted_pos += tx->period_len;
 	tx->submitted_pos %= 2 * tx->buf_len;
-- 
2.25.1

