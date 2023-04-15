Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D43D6E3060
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjDOKGQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjDOKGP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:06:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639C36EB4;
        Sat, 15 Apr 2023 03:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF2660B8D;
        Sat, 15 Apr 2023 10:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753E4C433EF;
        Sat, 15 Apr 2023 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681553173;
        bh=5ZDvmp4AmKVtWmkiXBMt//3ziXaWBzX6cVS1LHEShbU=;
        h=From:To:Cc:Subject:Date:From;
        b=COd7ijUIiSXQJ28LUX+gvrw14X1y84xoZmDm/W1Gu5Ccm5OwP9xSQkU0071o8ojJy
         G1og91LxVzENlwUP+ej5TUtouS97rCMMfv6lESKxmj6LKn/JbZgdPg+eBuBOEv+RCd
         XlrqTOwATmlkdwqiIeAvf0UnhxvTbQBDRabqnzbZ5l20rFpltKykYS5wZs3Q2URIz9
         af0XN8tjyHxSRSRRU7cJ5hbgYFW3EXjBH6NTqlmL21/7gdvTdIeh9NoxsNhL46eSd0
         ew6ilq18KtDlMy5WSLLI7d9ONyL6ja3PH8Ll1EFC7j/g6P30xwJQWZJ4poLdaAItZb
         c3hjwvjE3GG2A==
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
Subject: [PATCH v2 0/5] dma: don't set chancnt
Date:   Sat, 15 Apr 2023 17:55:12 +0800
Message-Id: <20230415095517.2763-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

NOTE: I leave drivers/dma/ioat/ as is, because its logic have a
heavy dependency on chancnt usage, however it's still doable.

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
2.39.2

