Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D749C6E3062
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDOKGX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDOKGT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C8902E;
        Sat, 15 Apr 2023 03:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA7161173;
        Sat, 15 Apr 2023 10:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB405C4339B;
        Sat, 15 Apr 2023 10:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681553176;
        bh=W7rOi6WjpD3uscFWmYE+SDo4q4MTdBEvs6oaRgrvjKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIJ8wwGlfYP1mRVObuTcpFYQWY8ID3xUbYwVRlP/D+LFiN9Mi89wZN+Lmf1Spa0cj
         tWZu3aJ1594zgqOyZiEvgF5KjVsmpyZL/9xIKPlTUH74Y/XHgfxLfuANNTBuFkJ3Cr
         EmxRcBNfnVFEuQPZgaM8oh3gFvQoaYeSZgRCcZji8c+zfKxYoeSAzugUDujNct+laP
         WH4PdqtdV8zLIZJUuNEglG39d1KKeWEXgQ2K49BI3lhmcRU8FYdF1WY4ELogzAeMoc
         WuqjPU4vHnAj/NDe3nLQmi0LL8yDSR3cLIlmXiwi4puaVBrAmtqcSqvp+VHjyDuS5Z
         7tktgBBGEsatQ==
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
Subject: [PATCH v2 1/5] dmaengine: dw-axi-dmac: Don't set chancnt
Date:   Sat, 15 Apr 2023 17:55:13 +0800
Message-Id: <20230415095517.2763-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415095517.2763-1-jszhang@kernel.org>
References: <20230415095517.2763-1-jszhang@kernel.org>
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

The dma framework will calculate the dma channels chancnt, setting it
ourself is wrong.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 4169e1d7d5ca..7f3a60e28e38 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1445,7 +1445,6 @@ static int dw_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_CYCLIC, dw->dma.cap_mask);
 
 	/* DMA capabilities */
-	dw->dma.chancnt = hdata->nr_channels;
 	dw->dma.max_burst = hdata->axi_rw_burst_len;
 	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
-- 
2.39.2

