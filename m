Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9846B7F12
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCMRPX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjCMRPE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:15:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D391C7EC;
        Mon, 13 Mar 2023 10:14:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A8C4B811AC;
        Mon, 13 Mar 2023 17:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232E3C433D2;
        Mon, 13 Mar 2023 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727615;
        bh=DLwIKl9KG2vxNMVwvDK4Kx4bbsNB0t/aPQo/qnUebps=;
        h=From:To:Cc:Subject:Date:From;
        b=rivOlj58ovpe8YxC5f1RrU/cHqDxgjafOzVZgArfLiYsBbx6hDkFqlbrIMY9zi4Xn
         n2XdlBpfV38mJzEKcYlRZ53DKJaFEqNoiZhlmIaplc1V1Oxpmha1dOTEV/vcb9BAfW
         P7d0e7kZs73AcRgKgD8cqS0Z+ExttwCTjiFmsM3EvSMzYwvsNsrb9l5SXc3jfKGc55
         r4+0ZbfMSPTbQTEF44PNzBhHDoUN6j6DBPHXaJU8Px1DGrG5MtbP+2SRQ8huc1PEHW
         KBSr25ofqoPA9u4RhuNOeTHM+MCsjNdvLaI+abD1AXhsrU6TKl4kVHfwiL/GtyP8la
         6ZVU3ePG3Jp3w==
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
Subject: [PATCH 0/5] dma: don't set chancnt
Date:   Tue, 14 Mar 2023 01:02:45 +0800
Message-Id: <20230313170250.815-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.39.2
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

I'm patching dw-axi-dmac to add more features, but I found a small
clean up point and some drivers in drivers/dma/ have the same issue,
so this series comes.

The dma framework will calculate the dma channels chancnt, setting it
is wrong.

NOTE: I leav drivers/dma/ioat/ as is, because its logic have a
heavy dependency on chancnt usage, however it's still doable.

Jisheng Zhang (5):
  dmaengine: dw-axi-dmac: Don't set chancnt
  dmaengine: axi-dmac: Don't set chancnt
  dmaengine: plx_dma: Don't set chancnt
  dmaengine: hidma: Don't set chancnt
  dmaengine: sprd: Don't set chancnt

 drivers/dma/dma-axi-dmac.c                     | 1 -
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1 -
 drivers/dma/plx_dma.c                          | 1 -
 drivers/dma/qcom/hidma.c                       | 1 -
 drivers/dma/sprd-dma.c                         | 1 -
 5 files changed, 5 deletions(-)

-- 
2.39.2

