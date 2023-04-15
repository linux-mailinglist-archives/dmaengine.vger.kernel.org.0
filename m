Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352666E306B
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDOKGv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjDOKGr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:06:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D5FA5E7;
        Sat, 15 Apr 2023 03:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 663A160B8D;
        Sat, 15 Apr 2023 10:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB230C433A0;
        Sat, 15 Apr 2023 10:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681553186;
        bh=VFo8FgxOsge+PUUwYU5GtQjYV19pyPbFfRwwhMQ8hcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mf7d8SGx7lp6TgaHpLQ0r7CcypJYZbtSBmAXTL3jgsRPSDHeVn5dk+nkqMOuvfX/D
         rpiwNkQ9as9hblItcJZWy6w9TRwxMaWShea8qiLPGvqPQ46PcOAA0pZ0yac892+Hp0
         SJ/bTaxnjd3VOEb7m6Ou1KFuUOQrat5BUc7/tSJrw0L3boV1nzNUIyUfuWKXDYvtB4
         o7qkPlQKkf/09FP/K5eCkKTqeuDXtAjGPOrSyZzAYItEcpWRGeKTZ+/VgF4mZVBKGc
         LqZ/NnT5JbVQBNCANjWbdDsHKRTXcPzsmJ1I2/gC943MXT3zK5sT7tmJ2jYY0RQf/Z
         75cnKVSi5gKWw==
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
Subject: [PATCH v2 4/5] dmaengine: hidma: Don't set chancnt
Date:   Sat, 15 Apr 2023 17:55:16 +0800
Message-Id: <20230415095517.2763-5-jszhang@kernel.org>
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
 drivers/dma/qcom/hidma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 04d1c33afc12..344525c3a32f 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -214,7 +214,6 @@ static int hidma_chan_init(struct hidma_dev *dmadev, u32 dma_sig)
 
 	spin_lock_init(&mchan->lock);
 	list_add_tail(&mchan->chan.device_node, &ddev->channels);
-	dmadev->ddev.chancnt++;
 	return 0;
 }
 
-- 
2.39.2

