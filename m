Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F03E6B7F32
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjCMRRg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjCMRRZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:17:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831BA56152;
        Mon, 13 Mar 2023 10:16:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F262AB811AE;
        Mon, 13 Mar 2023 17:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12F9C43444;
        Mon, 13 Mar 2023 17:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727738;
        bh=JRKBUa5JXVxlNgvhy7KVhNfMBjTnbpEYzC/sl0OoIDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGryyCWuMURvsTurldq07AiHtbwoa8rCEUpMjBxrDURk+DOUZ/gOXyOokbyWbGKR/
         /8bxGUpay+83Cwlnnf5qr/jAoep+mOzrW0WPiO+OImza88MKXpdPTjdzF8xJW2Gx8T
         eRVxrHiVAnugk/lJBZW2k2kiww3uuNKS3K2FqV9z2bhPUCAqYjcIBgx5djchzLFS1L
         Zpr1mmmtMNbMXBRq1lamM0/CpNOoi5u5J+C2+ZlYVMcs+RuvFB0O3TffZM1esPIp11
         ixDQoCqg5Fud2z76z7BCEnA5EifZxYyN60wXwvGzK3QkUGWckYwF0kwU04iwJ2CEx9
         ojtUUSYcfo+0w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] dmaengine: dw-axi-dmac: remove redudant axi_dma_disable() calling
Date:   Tue, 14 Mar 2023 01:04:43 +0800
Message-Id: <20230313170450.897-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313170450.897-1-jszhang@kernel.org>
References: <20230313170450.897-1-jszhang@kernel.org>
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

axi_dma_suspend() will soon call axi_dma_disable(), remove the redudant
axi_dma_disable() callin.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 891776528619..410222e7224c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1535,7 +1535,6 @@ static int dw_remove(struct platform_device *pdev)
 		axi_chan_disable(&chip->dw->chan[i]);
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 	}
-	axi_dma_disable(chip);
 
 	pm_runtime_disable(chip->dev);
 	axi_dma_suspend(chip);
-- 
2.39.2

