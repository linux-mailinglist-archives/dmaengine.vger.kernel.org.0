Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D600A70ADD5
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjEULsT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjEUKZZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A64810CB;
        Sun, 21 May 2023 03:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C104861551;
        Sun, 21 May 2023 10:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CA9C4339E;
        Sun, 21 May 2023 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664057;
        bh=VWHHZGOph30FRSEIQKdN3FOhxU5GdBKx6unG4ho62NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gwdzc8fcRcHU/eCL7hnccXdMDGUCH9rcOxlu+ymGWE7sMpzJF4GydPHgDhWlbKL+P
         kbx8r3vRZ6OyCzcsSmdoYbz0dl81U4JWUuu8KskJarknuBBLNACXgEybq234srfs+q
         uJ5yGpMK73hqWEzE81SnNQlEph0bM/a5OF+xXY2XI77RQCXYQt1m6nzi1dkfy8GvJ7
         p9JDeOYb+DzeNaRVzWkuczeniwn5iDGXDgf5CdIoC7sqHPk3Sl/fRx1g1+Idymlpf/
         Bfzs/3OH1rSUzRF2c7bsO/oHbMjX3gQ87JlfEv9dioAFnbYdCOx0LdEwm0ZWm6WT/i
         5wyvEliqBS+og==
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
Subject: [PATCH v3 4/5] dmaengine: hidma: Don't set chancnt
Date:   Sun, 21 May 2023 18:02:51 +0800
Message-Id: <20230521100252.3197-5-jszhang@kernel.org>
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
2.40.0

