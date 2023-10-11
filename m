Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3588A7C5688
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 16:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjJKORW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 10:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjJKORU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 10:17:20 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5513C90;
        Wed, 11 Oct 2023 07:17:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D50FA60003;
        Wed, 11 Oct 2023 14:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697033836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e5QGQHyYORanbuZrCZozt9X9hGMoQ81zeXHxbNIo+JY=;
        b=d3/E4RkAKlTgf1CAFOLdIGxjx3kHWQz1q3TxLFM1D/dD7oi5iBMIZeWX4OzSZK5TwMuNhj
        YI7NEXQ8OjvplUFPAUwjnkY7o3D2Nc9JXkk2K/MPNF/ASHkCFeGGzyk48klgt/kJW0bPaB
        yPMPBt1IIbwovB/xV2C+kxuEi+VUXrlf4yGNce1IP+MMSQtosQD23+VuMVylse7gcj87i+
        O3c2qS8eMXWY6UnUlulVxpwd7rj2aOs8G+ORz96/zDG84+2FyLBnyB6QGfK1jlJdBmaCxG
        8x1OrwezwTm7y/BPtRXewsarso5l+PsIr8sOoZW1O2b4gMAzJ1iJnV8KbkvB0A==
From:   Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH v4 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Date:   Wed, 11 Oct 2023 16:16:56 +0200
Message-Id: <20231011-b4-feature_hdma_mainline-v4-0-43d417b93138@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFiuJmUC/42NWw6CMBREt0LutzWl5SF8uQ9DSFtu5SbSmrYSD
 WHvVlbg55nJnNkgYiCM0BcbBFwpkncZqlMBZlbujoymzCC4kCUvS6YrZlGlV8BxnhY1Lorcgxw
 y3Zi6tReUup4gz58BLb0P9W3IPFNMPnyOp1X+0j+kq2SciQqRm67tTGOv2vuUq7PxCwz7vn8Bn
 BIlb8IAAAA=
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.3
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series fix the support of dw-edma HDMA NATIVE IP.
I can only test it in remote HDMA IP setup with single dma transfer, but
with these fixes it works properly.

Few fixes has also been added for eDMA version. Similarly to HDMA I have
tested only eDMA in remote setup.

Changes in v2:
- Update comments and fix typos.
- Removed patches that tackle hypothetical bug and then were not pertinent.
- Add the similar HDMA race condition in remote setup fix to eDMA IP driver.

Changes in v3:
- Fix comment style.
- Split a patch in two to differ bug fix and simple harmless typo.

Changes in v4:
- Update patch git commit message.
- Link to v3: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (6):
      dmaengine: dw-edma: Fix the ch_count hdma callback
      dmaengine: dw-edma: Fix wrong interrupt bit set
      dmaengine: dw-edma: Typo fix
      dmaengine: dw-edma: Add HDMA remote interrupt configuration
      dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup
      dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup

 drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 39 +++++++++++++++++++++++------------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
 3 files changed, 44 insertions(+), 14 deletions(-)
---
base-commit: 8bf914570650ec5858e18554d70d2838cef01de1
change-id: 20231011-b4-feature_hdma_mainline-b6c57f8e3b5d

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

