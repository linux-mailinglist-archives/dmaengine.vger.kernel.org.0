Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F02956C001
	for <lists+dmaengine@lfdr.de>; Fri,  8 Jul 2022 20:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbiGHRCB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Jul 2022 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiGHRB7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Jul 2022 13:01:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF671FCF1
        for <dmaengine@vger.kernel.org>; Fri,  8 Jul 2022 10:01:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o4so31359507wrh.3
        for <dmaengine@vger.kernel.org>; Fri, 08 Jul 2022 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVwQplEE6XBoH1jTUMM0VIYMQjTPRctCCxtG0CWCq/Y=;
        b=NSoEn33B+Yyeb5cw9ts/jj0Hqvha85PODQroGY2eWXDzjBNATXO7xTv9L7fZ7qw+Du
         nyGAEFLYbE2on7FIvwKQSSRihPyDnztXzxh6ZQBMKEJ0npeObK/a3SqVJG7rUQKDr9xj
         g28GVQBXXzFozv9D7gLr2xbwihCHsk3KA7vILPrYxPV0FwZyyj+hTIqjpMh/Laax0eTH
         ZCHOtJ6QwFcOLg038cCvWt8E9JycjnSUpymtfG4nl4UfbYNH78uc23HbgJz5/5GPxh8F
         ZaTnIHqGAUwXwx7FmRKVcC7nPrcAqDVrvGMUISHWWLJJ5tMbGLGbINT2o81yZiwK/pW3
         6XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVwQplEE6XBoH1jTUMM0VIYMQjTPRctCCxtG0CWCq/Y=;
        b=OLonvQ7hZTVJ5FBHie0MqytEjGT7d4ii4ZRWhAW9uqk7lEzKAiaR2JnQQJL34cwXXR
         IvQ5IoXxBEcvwdVVFH+hhm0NO98SZitcaX+vHZwKlC3ZbGc7PtxVZbkiwtcbqMxe8zkI
         dJvwAUBaxhpGTGPA1nIdVCZIOUuafRP2jcIDWxekKW6Ddy7dieorcNv1DCEF0xo90UlX
         U0/+xjTS+31pESKTF5pEBf7hviH/zWgS4+/WPiHjz+tbu3x3j0Q5+jyi7m2LS7biZ6Lm
         Qp3l/5J2WWCOgfnUld45x4TRTjc9m9EdXJhAsf4VjZE6JLLrLzDoFJglpyStIRDbYQ2u
         Vggw==
X-Gm-Message-State: AJIora8TBLTRNQYkS3/V28fMGDC5B/8z36s6M/GgcWUu9NgfjGfjue6j
        KhWyVaguP+oeTH5G/8EABm+dD8AmBtC7cDfJ
X-Google-Smtp-Source: AGRyM1u1a7XxCJzwvbZ+dDYitQEkeDNOf2wZZHx2LIbIFvJ4q5ky72fH1xhrd3SW7/TGAQyFw91Ysw==
X-Received: by 2002:a05:6000:104c:b0:21d:87bf:63a2 with SMTP id c12-20020a056000104c00b0021d87bf63a2mr4157307wrx.461.1657299717265;
        Fri, 08 Jul 2022 10:01:57 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id t5-20020adfe105000000b002103bd9c5acsm41336252wrz.105.2022.07.08.10.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:01:57 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     dmaengine@vger.kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 3/3] dmaengine: dw-axi-dmac: ignore interrupt if no descriptor
Date:   Fri,  8 Jul 2022 18:01:53 +0100
Message-Id: <20220708170153.269991-4-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220708170153.269991-1-ben.dooks@sifive.com>
References: <20220708170153.269991-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If the channel has no descriptor and the interrupt is raised then the
kernel will OOPS. Check the result of vchan_next_desc() in the handler
axi_chan_block_xfer_complete() to avoid the error happening.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index d6ef5f49f281..1fedf4376678 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1082,6 +1082,11 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 
 	/* The completed descriptor currently is in the head of vc list */
 	vd = vchan_next_desc(&chan->vc);
+	if (!vd) {
+		dev_err(chan2dev(chan), "BUG: %s, IRQ with no descriptors\n",
+			axi_chan_name(chan));
+		goto out;
+	}
 
 	if (chan->cyclic) {
 		desc = vd_to_axi_desc(vd);
@@ -1111,6 +1116,7 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 		axi_chan_start_first_queued(chan);
 	}
 
+out:
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
-- 
2.35.1

