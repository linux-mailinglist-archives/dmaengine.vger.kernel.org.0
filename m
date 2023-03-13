Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B68A6B7F24
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjCMRRC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjCMRQx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:16:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3E277C8E;
        Mon, 13 Mar 2023 10:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12BDCB810D8;
        Mon, 13 Mar 2023 17:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE31DC433EF;
        Mon, 13 Mar 2023 17:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727732;
        bh=AgxnGnjCcuCLrvUebJaSyNbX/LjrIkQcC+AUGh//ULo=;
        h=From:To:Cc:Subject:Date:From;
        b=Rc1X74Z0PSz0l+9fCLydu9UqhFcIazbnDk4YVJ2BFsmNxkIqMEaKNBtigo95WLuW0
         qrLi7CACAwXSyrit0YQ7TefcadFTdBu1hQKaRkYkFHBV9brsOyDn4/7cp20Mk1LY33
         hE+yZNL0cKfzlBDVfPBLuXzga2mg8QGbb6q2VtBNwG/Z1XPfVLMS73mqn0sH42L/qL
         e4/oBDdQNahOyL1d1IrfAoylwTrPm9bq2EWTUeHty0iml60OKDA+R072Z1WP21M0ZT
         sdKsj023JvtU4mlSb8voF+iRpl3Xqowkr5J9E3RCB3uWcmx1OSGpif6TVZHvwq8hlP
         +GB35luE+SsKA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] dmaengine: dw-axi_dmac: bug fix clean up and more features
Date:   Tue, 14 Mar 2023 01:04:39 +0800
Message-Id: <20230313170450.897-1-jszhang@kernel.org>
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

This series first fix a bug related with runtime pm. Then do three clean
up. After that, we add three new features: per channel irq support,
dma-channel-mask support and polled mode support.

Jisheng Zhang (11):
  dmaengine: dw-axi-dmac: fix reading register hen runtime suspended
  dmaengine: dw-axi-dmac: remove unnecessary devm_free_irq() calling
  dmaengine: dw-axi-dmac: remove unnecessary axi_dma_enable() calling
  dmaengine: dw-axi-dmac: remove redudant axi_dma_disable() calling
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
2.39.2

