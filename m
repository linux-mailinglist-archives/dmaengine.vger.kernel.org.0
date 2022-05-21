Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA05E52FB2E
	for <lists+dmaengine@lfdr.de>; Sat, 21 May 2022 13:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354956AbiEULNR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 May 2022 07:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354719AbiEULMj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 May 2022 07:12:39 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A273054B;
        Sat, 21 May 2022 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xWadsLJC4l7Q7/MBaFIQaJdl6vNOYxEGLL1gzjFKb6E=;
  b=rbkfxHx2gIoHDam6N2zZnDd0wX+1jXkG/Bqc20W3hORHj5mHYIaDec/c
   r0xPPcBClinK+FeWx0846x21DbClqoPHCvng9V5W5maX/WcDSsCjDqhm3
   xRi5l3QqKk/+MuRbUhz+w897k7hRjga0X0eAKYtt4pIcIHU/lA37apNrq
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727943"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:00 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     kernel-janitors@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: s3c24xx: fix typo in comment
Date:   Sat, 21 May 2022 13:10:56 +0200
Message-Id: <20220521111145.81697-46-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/dma/s3c24xx-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 8e14c72d03f0..f6ed7e889781 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -202,7 +202,7 @@ struct s3c24xx_dma_phy {
  * struct s3c24xx_dma_chan - this structure wraps a DMA ENGINE channel
  * @id: the id of the channel
  * @name: name of the channel
- * @vc: wrappped virtual channel
+ * @vc: wrapped virtual channel
  * @phy: the physical channel utilized by this channel, if there is one
  * @runtime_addr: address for RX/TX according to the runtime config
  * @at: active transaction on this channel

