Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A921A7692D6
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 12:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGaKOu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjGaKOt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 06:14:49 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F77E3
        for <dmaengine@vger.kernel.org>; Mon, 31 Jul 2023 03:14:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3236C1BF20A;
        Mon, 31 Jul 2023 10:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690798485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ic/8DZO80Y3E+OpwxtVjsvtwSLF7qq6JBLJbcdmNlFA=;
        b=nWkkrLxf3VfxW+QqEV5qK4sBtO6NWApCaXMz4tQWzfatEA/wHes9ZFG3oZrIWo7o324j7F
        QHRFVlJoTCN84avenhYEqGzZtZSwuwvQHoiEA5hnIXQZ1AGXeMY3J+EiXlhoSVwkMP+noS
        FNg+EquRTScuGSCIGl7Q2MSvrMm4pnMAlzF11pYuudi5nnO3nrohzvI9djjVevLUMhuM3M
        WO2+fxBLo2MAzUiLudSo+a64UqFhBLVc9Hyrv7JCLhiCXfFmZ45KQKsnaBy3ZlGQH+x2fO
        U9ozg3g1Owlq62qg9BtuAyrkU8lpBsfmLBaWHGFj5aH1iayYY/qvOkICEFl5Lw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/4] dmaengine: xdma: Cyclic transfers support
Date:   Mon, 31 Jul 2023 12:14:38 +0200
Message-Id: <20230731101442.792514-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

Following the introduction of scatter-gather support of Xilinx's XDMA IP
in the Linux kernel, here is a small series adding cyclic transfers.

The first patch is a real bug fix which triggered in my case, the second
just fixes a typo, the third one is a preparation patch to ease the
review of the fourth one which actually adds cyclic transfers support.

Thanks,
Miquèl

Miquel Raynal (4):
  dmaengine: xilinx: xdma: Fix interrupt vector setting
  dmaengine: xilinx: xdma: Fix typo
  dmaengine: xilinx: xdma: Prepare the introduction of cyclic transfers
  dmaengine: xilinx: xdma: Support cyclic transfers

 drivers/dma/xilinx/xdma-regs.h |   2 +
 drivers/dma/xilinx/xdma.c      | 190 +++++++++++++++++++++++++++++++--
 2 files changed, 183 insertions(+), 9 deletions(-)

-- 
2.34.1

