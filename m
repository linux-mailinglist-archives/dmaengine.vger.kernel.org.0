Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4188D3F84BE
	for <lists+dmaengine@lfdr.de>; Thu, 26 Aug 2021 11:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhHZJse (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Aug 2021 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbhHZJsc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Aug 2021 05:48:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8266C0613C1
        for <dmaengine@vger.kernel.org>; Thu, 26 Aug 2021 02:47:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz5-0003c2-19; Thu, 26 Aug 2021 11:47:43 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz4-0006kq-8D; Thu, 26 Aug 2021 11:47:42 +0200
Received: from mtr by dude03.red.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz4-005Siu-7G; Thu, 26 Aug 2021 11:47:42 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, appana.durga.rao@xilinx.com,
        michal.simek@xilinx.com, m.tretter@pengutronix.de,
        kernel@pengutronix.de
Subject: [PATCH 0/7] dmaengine: zynqmp_dma: fix lockdep warning and cleanup
Date:   Thu, 26 Aug 2021 11:47:35 +0200
Message-Id: <20210826094742.1302009-1-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

I reported a lockdep warning in the ZynqMP DMA driver a few weeks ago [0].
This series fixes the reported warning and performs some cleanup that I found
while looking at the driver more closely.

Patches 1-4 are the cleanups. They affect the log output of the driver, allow
to compile the driver on other platforms when COMPILE_TEST is enabled, and
remove unused included header files from the driver.

Patches 5-7 aim to fix the lockdep warning. Patch 5 and 6 restructure the
locking in the driver to make it more fine-grained instead of holding the lock
for the entire tasklet. Patch 7 finally fixes the warning.

Michael

[0] https://lore.kernel.org/linux-arm-kernel/20210601130108.GA12967@pengutronix.de/

Michael Tretter (7):
  dmaengine: zynqmp_dma: simplify with dev_err_probe
  dmaengine: zynqmp_dma: drop message on probe success
  dmaengine: zynqmp_dma: enable COMPILE_TEST
  dmaengine: zynqmp_dma: cleanup includes
  dmaengine: zynqmp_dma: cleanup after completing all descriptors
  dmaengine: zynqmp_dma: refine dma descriptor locking
  dmaengine: zynqmp_dma: fix lockdep warning in tasklet

 drivers/dma/Kconfig             |  2 +-
 drivers/dma/xilinx/zynqmp_dma.c | 67 +++++++++++++++++----------------
 2 files changed, 35 insertions(+), 34 deletions(-)

-- 
2.30.2

