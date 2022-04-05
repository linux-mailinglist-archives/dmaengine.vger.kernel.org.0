Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AF04F26E2
	for <lists+dmaengine@lfdr.de>; Tue,  5 Apr 2022 10:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiDEIGG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Apr 2022 04:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbiDEICL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 04:02:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54AE4BBAC
        for <dmaengine@vger.kernel.org>; Tue,  5 Apr 2022 01:00:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nbe6h-0003fK-42; Tue, 05 Apr 2022 10:00:07 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nbe6g-001BHf-Og; Tue, 05 Apr 2022 10:00:05 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nbe6a-00BXZc-QE; Tue, 05 Apr 2022 10:00:00 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 00/20] ASoC: fsl_micfil: Driver updates
Date:   Tue,  5 Apr 2022 09:59:39 +0200
Message-Id: <20220405075959.2744803-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series has a bunch of cleanups for the FSL MICFIL driver. There is
not much chance for regressions in this series as the driver currently
can't work at all. The MICFIL needs multififo support in the i.MX SDMA
engine which is added with this series, see 11/20.

The multififo support is selected in the dma phandle arguments in the
device tree, the transfer type must be '25' aka IMX_DMATYPE_MULTI_SAI.
This is set already to 25 in the upstream i.MX8M[NM] dtsi files, but the
SDMA driver silently ignores unsupported values instead of throwing an
error. This is fixed in this series and multififo support is added.

I think the series should go via the ASoC tree, so I'll need an ack from
the DMA guys for 9/20, 10/20 and 11/20.

Chnages since v2:
- Add forgotten commit log to dmaengine patches
- Add patch to move include/linux/platform_data/dma-imx.h to include/linux/dma/imx-dma.h
- Use prefix dmaengine: for dma patches

Changes since v1:
- Drop unused variable sw_done_sel
- Evaluate sdmac->direction directly instead of storing value in n_fifos
- add missing include linux/bitfield.h

Sascha Hauer (20):
  ASoC: fsl_micfil: Drop unnecessary register read
  ASoC: fsl_micfil: Drop unused register read
  ASoC: fsl_micfil: drop fsl_micfil_set_mclk_rate()
  ASoC: fsl_micfil: do not define SHIFT/MASK for single bits
  ASoC: fsl_micfil: use GENMASK to define register bit fields
  ASoC: fsl_micfil: use clear/set bits
  ASoC: fsl_micfil: drop error messages from failed register accesses
  ASoC: fsl_micfil: drop unused variables
  dmaengine: imx: Move header to include/dma/
  dmaengine: imx-sdma: error out on unsupported transfer types
  dmaengine: imx-sdma: Add multi fifo support
  ASoC: fsl_micfil: add multi fifo support
  ASoC: fsl_micfil: use define for OSR default value
  ASoC: fsl_micfil: Drop get_pdm_clk()
  ASoC: fsl_micfil: simplify clock setting
  ASoC: fsl_micfil: rework quality setting
  ASoC: fsl_micfil: drop unused include
  ASoC: fsl_micfil: drop only once used defines
  ASoC: fsl_micfil: drop support for undocumented property
  ASoC: fsl_micfil: fold fsl_set_clock_params() into its only user

 drivers/dma/imx-dma.c                         |   2 +-
 drivers/dma/imx-sdma.c                        |  76 +++-
 drivers/mmc/host/mxcmmc.c                     |   2 +-
 drivers/spi/spi-fsl-lpspi.c                   |   2 +-
 drivers/spi/spi-imx.c                         |   2 +-
 drivers/tty/serial/imx.c                      |   2 +-
 drivers/video/fbdev/mx3fb.c                   |   2 +-
 .../dma-imx.h => dma/imx-dma.h}               |  26 +-
 sound/soc/fsl/fsl_asrc.c                      |   2 +-
 sound/soc/fsl/fsl_asrc_dma.c                  |   2 +-
 sound/soc/fsl/fsl_easrc.h                     |   2 +-
 sound/soc/fsl/fsl_micfil.c                    | 369 +++++++-----------
 sound/soc/fsl/fsl_micfil.h                    | 269 +++----------
 sound/soc/fsl/imx-pcm.h                       |   2 +-
 sound/soc/fsl/imx-ssi.h                       |   2 +-
 15 files changed, 297 insertions(+), 465 deletions(-)
 rename include/linux/{platform_data/dma-imx.h => dma/imx-dma.h} (67%)

-- 
2.30.2

