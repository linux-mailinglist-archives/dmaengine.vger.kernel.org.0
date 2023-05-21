Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D43E70AD78
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 12:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjEUK1z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjEUKZE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E052210C3;
        Sun, 21 May 2023 03:14:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7222161542;
        Sun, 21 May 2023 10:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6455C433D2;
        Sun, 21 May 2023 10:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664043;
        bh=Vu1TAPPciiNN/+NNVmvm2e6pyVPkwqUzX+KPyIlmhCM=;
        h=From:To:Cc:Subject:Date:From;
        b=ZajnV1LcRAkwfLq/SJRiJS+qsd4lpR2KLL8lVNF7DVVheUsJOlHe7P2ShRWtM0Tkd
         69DII5MQ03k9o/X8SjWJD7kfLHjYKxcfuYPcVl56KiPn64ch/vX5Cs2xud/M3ExphV
         sSyuyMf7SQxEidkxPniJVpNz8d3w7Mi0gBzORbN9WIkfW+F6LznOr/6WaoBMXCmPyX
         RqlLJHqzojkHWOnad98ZUuIwQzcOwIH8C7fPRHurcfWl83vJ1sORj07t1O94LRJl7b
         H/goTc0FbDbgnMGh5zgjrk0qNgbIgB6iB03SXh+WkBPUoC3kuZyymqZHNA8SMP3tCp
         7dvGSDzJFa1Xg==
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
Subject: [PATCH v3 0/5] dma: don't set chancnt
Date:   Sun, 21 May 2023 18:02:47 +0800
Message-Id: <20230521100252.3197-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
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

I'm patching dw-axi-dmac to add more features, but I found a small
clean up point and some drivers in drivers/dma/ have the same issue,
so this series comes.

The dma framework will calculate the dma channels chancnt, setting it
is wrong.

NOTE: I leave drivers/dma/ioat/ as is, because its logic have a
heavy dependency on chancnt usage, however it's still doable.

Since v2:
  - rebase on latest rc1
  - collet Acked-by tag

Since v1:
  - collet Acked-by tag
  - fix typo

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
2.40.0

