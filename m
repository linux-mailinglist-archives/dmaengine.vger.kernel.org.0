Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02D72928F
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 10:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbjFIIRh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 04:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbjFIIRf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 04:17:35 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF0F35B5;
        Fri,  9 Jun 2023 01:16:59 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686298616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ex6LdIdKwwSp7v20YeX6YqUlcckFZIlUK3H78VaVgeU=;
        b=DpVXxOJwU8/YuZqdB9Omoc6INTySlWfL4wFxYiokbczMotgp3wKr0VQIntQo8iuwJ3cbrr
        +VA9cdS9cRaNEFPLlQdygdtAlBcI/3C2VC4OKNm4/qvcQ7TBtTgeS/KXYBKSEFwj2HkRQ0
        8Z4F4JXlhDxcHXTHcIJAWAETi7MfZsLNwFd/mgKdN0FN8QzMbddaNswIenh4OlsT3vaDbl
        h3NGDiunQ5ExcaZGka2Q9wFYJtOms276Gv1ZNqsyyzFENWQfclhNgvOdnmerRl9eK4fX3L
        NiKb0L88DNvzvsu8fEdtoXZ0IwUqnbZbIV9XFHn0KxLl2K3bG1DwPbvKYPedew==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 193CDC0005;
        Fri,  9 Jun 2023 08:16:55 +0000 (UTC)
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
Subject: [PATCH 0/9] Fix support of dw-edma HDMA NATIVE IP in remote setup
Date:   Fri,  9 Jun 2023 10:16:45 +0200
Message-Id: <20230609081654.330857-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Kory Maincent (9):
  dmaengine: dw-edma: Fix the ch_count hdma callback
  dmaengine: dw-edma: Typos fixes
  dmaengine: dw-edma: Add HDMA remote interrupt configuration
  dmaengine: dw-edma: HDMA: Add memory barrier before starting the DMA
    transfer in remote setup
  dmaengine: dw-edma: HDMA: Fix possible race condition in remote setup
  dmaengine: dw-edma: HDMA: Fix possible race condition in local setup
  dmaengine: dw-edma: eDMA: Add memory barrier before starting the DMA
    transfer in remote setup
  dmaengine: dw-edma: eDMA: Fix possible race condition in remote setup
  dmaengine: dw-edma: eDMA: Fix possible race condition in local setup

 drivers/dma/dw-edma/dw-edma-v0-core.c | 23 ++++++++++++---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 40 +++++++++++++++------------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
 3 files changed, 43 insertions(+), 22 deletions(-)

-- 
2.25.1

