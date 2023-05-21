Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B5F70ADCA
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjEULsK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjEUK1S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E637C10DE;
        Sun, 21 May 2023 03:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B483611F6;
        Sun, 21 May 2023 10:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC10C433EF;
        Sun, 21 May 2023 10:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664605;
        bh=kfAplaWGiLjpl33bNpDu0hiyLlbkQbmXnbsBObQrxeQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jZt0FhSEgOaO1gw9Cd/PhqENwIHqg922GvuwfmDlsSdUiBEUk1ybTmVYtiRN1gCqy
         wV+yIxBDYebpBXTWKNFHV9Ln1qwmhCsF/xzNPxFLYrZiJkZT0B75Zr2n+eYZ2BH6Or
         St4sh/ZmGzs40jRTsCeNe3YjpoGnaGpErupYHaiSrZAkOuRO1xOjJSeKduhaD1nbns
         dprRdtLN6xMxkxkBUILYdCPNCfeq9BTXBOsx1hYeGuc+pusKTTqlELjLRoYmn/ibi/
         qJS6GBH72FS5qlEqN1ONxQIm/bwXFl9+QkfqK6BaPmxUEZhay78QTBU/q4E6YkAe85
         6w1eOqJw6U/lQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/11] dmaengine: dw-axi_dmac: bug fix clean up and more features
Date:   Sun, 21 May 2023 18:12:05 +0800
Message-Id: <20230521101216.4084-1-jszhang@kernel.org>
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

This series first fix a bug related with runtime pm. Then do three clean
up. After that, we add three new features: per channel irq support,
dma-channel-mask support and polled mode support.

Since v3:
  - rebase on the latest rc1

Since v2
  - fix typo
  - add reason why we need to runtime resume before reading reg in
    commit msg

Hi Vinod,

I still kept patch2 in v2, because I think the irq has been disabled
from the dw-axi-dma side, so the irq won't be fired any more. If you
prefer to keep the devm_free_irq() just ignore patch2.

Thanks a lot.


Jisheng Zhang (11):
  dmaengine: dw-axi-dmac: fix reading register when runtime suspended
  dmaengine: dw-axi-dmac: remove unnecessary devm_free_irq() calling
  dmaengine: dw-axi-dmac: remove unnecessary axi_dma_enable() calling
  dmaengine: dw-axi-dmac: remove redundant axi_dma_disable() calling
  dmaengine: dw-axi-dmac: delay irq getting until request_irq
  dmaengine: dw-axi-dmac: move ch irq handling into common routine
  dmaengine: dw-axi-dmac: support per channel irq
  dmaengine: dw-axi-dmac: support dma-channel-mask
  dmaengine: dw-axi-dmac: try best to get residue when tx is running
  dmaengine: dw-axi-dmac: move dma_chan_tx_status()
  dmaengine: dw-axi-dmac: support polled mode

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 207 ++++++++++++------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   4 +
 2 files changed, 147 insertions(+), 64 deletions(-)

-- 
2.40.0

