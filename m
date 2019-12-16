Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2C91202FA
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2019 11:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfLPKxm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 05:53:42 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35563 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLPKxm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Dec 2019 05:53:42 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1igo0L-0001dW-9O; Mon, 16 Dec 2019 11:53:33 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1igo0I-0005t2-A3; Mon, 16 Dec 2019 11:53:30 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Green Wan <green.wan@sifive.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 0/9] dmaengine: virt-dma related fixes
Date:   Mon, 16 Dec 2019 11:53:19 +0100
Message-Id: <20191216105328.15198-1-s.hauer@pengutronix.de>
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

Several drivers call vchan_dma_desc_free_list() or vchan_vdesc_fini() under
&vc->lock. This is not allowed and the first two patches fix this up. If you
are a DMA driver maintainer, the first two patches are the reason you are on
Cc.

The remaining patches are the original purpose of this series:
The i.MX SDMA driver leaks memory when a currently running descriptor is
aborted. Calling vchan_terminate_vdesc() on it to fix this revealed that
the virt-dma support calls the desc_free with the spin_lock held. This
doesn't work for the SDMA driver because it calls dma_free_coherent in
its desc_free hook. This series aims to fix that up.

Changes since v2:
- change drivers to not call vchan_dma_desc_free_list() under spin_lock
- remove debug message from vchan_dma_desc_free_list()

Changes since v1:
- rebase on v5.5-rc1
- Swap patches 1 and 2 for bisectablity
- Rename desc_aborted to desc_terminated
- Free up terminated descriptors immediately instead of letting them accumulate

Sascha Hauer (9):
  dmaengine: bcm2835: do not call vchan_vdesc_fini() with lock held
  dmaengine: virt-dma: Add missing locking
  dmaengine: virt-dma: remove debug message
  dmaengine: virt-dma: Do not call desc_free() under a spin_lock
  dmaengine: virt-dma: Add missing locking around list operations
  dmaengine: virt-dma: use vchan_vdesc_fini() to free descriptors
  dmaengine: imx-sdma: rename function
  dmaengine: imx-sdma: find desc first in sdma_tx_status
  dmaengine: imx-sdma: Fix memory leak

 drivers/dma/bcm2835-dma.c                     |  5 +--
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |  8 +---
 drivers/dma/imx-sdma.c                        | 37 +++++++++++--------
 drivers/dma/mediatek/mtk-uart-apdma.c         |  3 +-
 drivers/dma/owl-dma.c                         |  3 +-
 drivers/dma/s3c24xx-dma.c                     | 22 +++++------
 drivers/dma/sf-pdma/sf-pdma.c                 |  4 +-
 drivers/dma/sun4i-dma.c                       |  3 +-
 drivers/dma/virt-dma.c                        | 10 ++---
 drivers/dma/virt-dma.h                        | 27 ++++++++------
 10 files changed, 63 insertions(+), 59 deletions(-)

-- 
2.24.0

