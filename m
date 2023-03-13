Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB36B7F60
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCMRYK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCMRXw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:23:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ED63ABE;
        Mon, 13 Mar 2023 10:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E53261414;
        Mon, 13 Mar 2023 17:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BCCC4339B;
        Mon, 13 Mar 2023 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727629;
        bh=sheGLWSRVeZHY8o45gICU781ZznV4t/ae6HtpWxBx6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qf/UOe9YjBj6REsfrKde/wD39EkAWcypvQ3WAqT+0+FFqQ6Ffgx0TPeqPLDgy5NLe
         Vd0wn75BEOm3xW7xNHHJPZ/ZWX89ofjbTLlxFia0uvDGFDhl6DBdazT4iTCrwxJomQ
         Wew47qEoGgxKmOtPj4JGSHmIjz6GAMU5PG+E6LV4BqbZwCw2iR4Z0jtVL2XRCoVx37
         je9F07HOoMrM8tI9Zvkc4sQOluGXL6M7MFWWb2JrMDbNxPEY8CmKwP0LbRv2JI8SGb
         jnN7zAE6TN0h1scWNriCZuy7jEz8ZB8ei+E4uDzu3K3gWhBE5NQ/Ra89Eg/gnpBjZn
         T1JWesBbzPsEQ==
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
Subject: [PATCH 4/5] dmaengine: hidma: Don't set chancnt
Date:   Tue, 14 Mar 2023 01:02:49 +0800
Message-Id: <20230313170250.815-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313170250.815-1-jszhang@kernel.org>
References: <20230313170250.815-1-jszhang@kernel.org>
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
outself is wrong.

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

