Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0078270ADD9
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjEULsV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjEUKZZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05AB10C9;
        Sun, 21 May 2023 03:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6520361528;
        Sun, 21 May 2023 10:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FBBC433EF;
        Sun, 21 May 2023 10:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664053;
        bh=SgpWj/R+8haw9UTysuAqZBmQnttr3cu4CFi/nHEGkNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Src54wdI36aeOynbc3nFprzf1ixqJOCjyA6KIfieOBDUuIl669VLVg0iwTwdfMjsU
         6+mi4eyBQsT8j5VAK68AbOYGn1J+hKNVDz+5nrfStN3Fv8SqeAbg3IA33zdrXm3I6o
         s/flsp9Vt/c3vEEshAQwbinbWjAfrR80eFC16KB4lOQFHOM1KeOl4E5rRU4ZHIyB07
         WyfCOT3PIZzxD/9KyTeSSAy2ma3qkdgdQfZh0EDgW4w0zCA4OOQsQ7loW4l6FYB4qE
         NfIiR52lT3eS9GAiW3KON4SDq0eHAXtmLCq7hmf6XZMniBR1sXjWouaFDK1OMuHlvM
         ut8UgulwKj9/w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 3/5] dmaengine: plx_dma: Don't set chancnt
Date:   Sun, 21 May 2023 18:02:50 +0800
Message-Id: <20230521100252.3197-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230521100252.3197-1-jszhang@kernel.org>
References: <20230521100252.3197-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dma framework will calculate the dma channels chancnt, setting it
ourself is wrong.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/plx_dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 12725fa1655f..34b6416c3287 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -517,7 +517,6 @@ static int plx_dma_create(struct pci_dev *pdev)
 	plxdev->bar = pcim_iomap_table(pdev)[0];
 
 	dma = &plxdev->dma_dev;
-	dma->chancnt = 1;
 	INIT_LIST_HEAD(&dma->channels);
 	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
 	dma->copy_align = DMAENGINE_ALIGN_1_BYTE;
-- 
2.40.0

