Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037F97B53EC
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbjJBNR5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbjJBNR4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 09:17:56 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4FBB7;
        Mon,  2 Oct 2023 06:17:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E02331BF207;
        Mon,  2 Oct 2023 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696252671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zTlDx0KTHKTtTlsJBumhY93csPVjcrRp0nLBc3tJdlM=;
        b=fiKynsK1fjCZZ9G2S1+KRE0vhdh76oJ+LiUU0GeS3NKEvPbRTGkr2mv1wHVliey64yBqKY
        K6c+hPmoidqUYbCUOdJsxW7oJuTu94iaWFKEcPuQNBmKkJVN7ADOTy8oIjZcJLeSgMDWF6
        wVKH4UGnfdss7pUlGndLHbHkR3n/eueWUG8AxVG2Xnkj2IDt3zOtAZWiaWwIsIB6XIxaJQ
        GngXEdep1kjRWyBmlGkWF3xnUDDoW21A8h2AhTiaCm5Dg42OXl98RuKfxYmj5S+pwp3UGr
        oG214GDayhaml2TTCewWAp241EkKPNRry7q7gDwY/NxqEJ72iKOCtSKT4w060Q==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH v2 0/5] Fix support of dw-edma HDMA NATIVE IP in remote setup
Date:   Mon,  2 Oct 2023 15:17:44 +0200
Message-Id: <20231002131749.2977952-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

This patch series fix the support of dw-edma HDMA NATIVE IP.
I can only test it in remote HDMA IP setup with single dma transfer, but
with these fixes it works properly.

Few fixes has also been added for eDMA version. Similarly to HDMA I have
tested only eDMA in remote setup.

Kory Maincent (5):
  dmaengine: dw-edma: Fix the ch_count hdma callback
  dmaengine: dw-edma: Typos fixes
  dmaengine: dw-edma: Add HDMA remote interrupt configuration
  dmaengine: dw-edma: HDMA: Add sync read before starting the DMA
    transfer in remote setup
  dmaengine: dw-edma: eDMA: Add sync read before starting the DMA
    transfer in remote setup

 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 43 +++++++++++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
 3 files changed, 53 insertions(+), 14 deletions(-)

-- 
2.25.1

