Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F06711888A
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 13:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfLJMeJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 07:34:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44469 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfLJMeJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Dec 2019 07:34:09 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ieeiF-0003au-36; Tue, 10 Dec 2019 13:33:59 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ieeiE-0002D4-4G; Tue, 10 Dec 2019 13:33:58 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 0/6] virt-dma and i.MX SDMA fixes
Date:   Tue, 10 Dec 2019 13:33:46 +0100
Message-Id: <20191210123352.7555-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The i.MX SDMA driver leaks memory when a currently running descriptor is
aborted. Calling vchan_terminate_vdesc() on it to fix this revealed that
the virt-dma support calls the desc_free with the spin_lock held. This
doesn't work for the SDMA driver because it calls dma_free_coherent in
its desc_free hook. This series aims to fix that up.

Changes since v1:
- rebase on v5.5-rc1
- Swap patches 1 and 2 for bisectablity
- Rename desc_aborted to desc_terminated
- Free up terminated descriptors immediately instead of letting them accumulate

*** BLURB HERE ***
Sascha Hauer (6):
  dmaengine: virt-dma: Do not call desc_free() under a spin_lock
  dmaengine: virt-dma: Add missing locking around list operations
  dmaengine: imx-sdma: rename function
  dmaengine: imx-sdma: find desc first in sdma_tx_status
  dmaengine: imx-sdma: Fix memory leak
  ARM: imx_v6_v7_defconfig: Enable NFS_V4_1 and NFS_V4_2 support

 arch/arm/configs/imx_v6_v7_defconfig |  2 ++
 drivers/dma/imx-sdma.c               | 37 +++++++++++++++++-----------
 drivers/dma/virt-dma.c               |  1 +
 drivers/dma/virt-dma.h               | 27 +++++++++++---------
 4 files changed, 41 insertions(+), 26 deletions(-)

-- 
2.24.0

