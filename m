Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3803D7BA5AE
	for <lists+dmaengine@lfdr.de>; Thu,  5 Oct 2023 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbjJEQTI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Oct 2023 12:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241921AbjJEQQp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Oct 2023 12:16:45 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D57270F;
        Thu,  5 Oct 2023 09:02:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C80341BF205;
        Thu,  5 Oct 2023 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696521758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z6JqOM2eFV5mUBkrVcLPsXsg66/mo6aYEktxPOQcjmw=;
        b=BEtXOqTTjTqvxrq8Lto8Q+YrGtJktXXzjEMkMHpnNvLm9pQP2K424MU4YyYSPrWZ0TV6nR
        1WIso5QhK/YNkXW1RmBZaQK93XkRmSwrxRd8gJZInP+khv2C6uSlpVJsY99OaSyOsoximv
        LYX6ga8i6Da6sFNTctTJAmfw0xSemqkz4EJGJyT4RDfAt8awJDBOfqSwv8dGPrEROgmO2J
        r86Sxt2Q1q6veaCzm0Ow6Np4dUl02q82GPdS5wmN8I0WDk/2ehOEQfZW9AT8Z5tHKkFiC9
        90idILFhqy5vMwfXCUDHg15mlAtDVQ7gG3Xs94LX7G91wCIAvVwGi/3tFo4p4Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>, Michal Simek <monstr@monstr.eu>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 0/3] dmaengine: xdma: Cyclic transfers support
Date:   Thu,  5 Oct 2023 18:02:34 +0200
Message-Id: <20231005160237.2804238-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes in v3:
* Fixed the kdoc: missing 'cyclic' description in xdma_free_desc().

Changes in v2:
* Rebased on top of v6.6-rc1
* Removed the if (!state) superfluous check.
* Address a kernel test robot report (uninitialized variable in error case)
* Simplify the convoluted logic when filling the hardware descriptors

Miquel Raynal (3):
  ASoC: soc-generic-dmaengine-pcm: Fix function name in comment
  dmaengine: xilinx: xdma: Prepare the introduction of cyclic transfers
  dmaengine: xilinx: xdma: Support cyclic transfers

 drivers/dma/xilinx/xdma-regs.h        |   2 +
 drivers/dma/xilinx/xdma.c             | 179 ++++++++++++++++++++++++--
 sound/soc/soc-generic-dmaengine-pcm.c |   4 +-
 3 files changed, 175 insertions(+), 10 deletions(-)

-- 
2.34.1

