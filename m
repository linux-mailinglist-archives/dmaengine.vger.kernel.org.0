Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FA57AB5BC
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 18:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjIVQVM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 12:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjIVQVL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 12:21:11 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183C5196;
        Fri, 22 Sep 2023 09:21:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D3292E0008;
        Fri, 22 Sep 2023 16:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695399660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LtnaaBXMrUjwOdzTGJujLzHqdroJGlyz68hcNRVGofM=;
        b=DXn/2Ns1mMtSpdmx95H0OoN/ZghQfcUYhIGE6D5r8veA5yyintE3PQ4+BpNoe2AMdq79e0
        mwn9irrYABdPqdVv1/isscoSzixv6UbJ0MFg9rXl+0yBDhR7+ztDuIjEsKLfFC2FpPoz2U
        WwhE1noZ7mg4qdxmsiar37zqeZv38UBD27aKsFQtP8dTqGKT4yOOHTSBbIhIXvlhWo9rHN
        HJ/p7/PQeYmetD2N4iEPjrG5LwzZKrGTgbTasj1XY07z1/+zzUiZzsGB58CWaoayYvicZ0
        ZSPA2zlnac2gQCFLYQzz3sfH6HHJphcHGO3NxeGKPb7wjOzYPLQNERpWvDx+lg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/2] dmaengine: xdma: Cyclic transfers support
Date:   Fri, 22 Sep 2023 18:20:54 +0200
Message-Id: <20230922162056.594933-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

Following the introduction of scatter-gather support of Xilinx's XDMA IP
in the Linux kernel, here is a small series adding cyclic transfers.

The first patch is a preparation patch to ease the review of the second
one which actually adds cyclic transfers support.

Thanks,
Miquèl

Changes in v2:
* Rebased on top of v6.6-rc1
* Removed the if (!state) superfluous check.
* Address a kernel test robot report (unitialized variable in error case)
* Simplify the convoluted logic when filling the hardware descriptors

Miquel Raynal (2):
  dmaengine: xilinx: xdma: Prepare the introduction of cyclic transfers
  dmaengine: xilinx: xdma: Support cyclic transfers

 drivers/dma/xilinx/xdma-regs.h |   2 +
 drivers/dma/xilinx/xdma.c      | 178 +++++++++++++++++++++++++++++++--
 2 files changed, 172 insertions(+), 8 deletions(-)

-- 
2.34.1

