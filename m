Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EAB507BCF
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 23:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353200AbiDSVTw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 17:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiDSVTv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 17:19:51 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DBA637BF6;
        Tue, 19 Apr 2022 14:17:07 -0700 (PDT)
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
        by linux.microsoft.com (Postfix) with ESMTPSA id 163EF20E1A8D;
        Tue, 19 Apr 2022 14:17:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 163EF20E1A8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650403027;
        bh=iznUogW7Ui4gDR1RCeHw3LWMWiszvHx3w2StT5QPOGs=;
        h=From:To:Cc:Subject:Date:From;
        b=iyd0LIVB4sLS97ntxZkk6JG2qYRYJyz3Gjmc5L7O+QZGdxE2WCy9lUWhbferQ6zdk
         MOW17Od2+AjTkSackgwX9AJCnuDBd3YBVlOW5mqphZu9DYCqKa8zhdysL7wuuMcUQZ
         Mk7Z719+FVaw14+dnPCDRKuqao3xBQ3nuIHBV9Tk=
From:   Allen Pais <apais@linux.microsoft.com>
To:     olivier.dautricourt@orolia.com, sr@denx.de, vkoul@kernel.org
Cc:     keescook@chromium.org, linux-hardening@vger.kernel.org,
        ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        andriy.shevchenko@linux.intel.com, leoyang.li@nxp.com,
        zw@zh-kernel.org, wangzhou1@hisilicon.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, afaerber@suse.de, mani@kernel.org,
        logang@deltatee.com, sanju.mehta@amd.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        agross@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, green.wan@sifive.com,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        patrice.chotard@foss.st.com, linus.walleij@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/1] refactor all tasklet users into other APIs
Date:   Tue, 19 Apr 2022 21:16:57 +0000
Message-Id: <20220419211658.11403-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

 Tasklet is an old API that will be eventually deprecated.
During the modernization of the tasklets API, there was a
request to entirely remove the API from the kernel. 
This series converts tasklets to simple work.

 Feedback on the series would be of great help as we are in the
process of dropping the usage of tasklets from the rest of the sub-systems.

 This is part of KSPP effort which is tracked at:
https://github.com/KSPP/linux/issues/94

This series replaces tasklets in drivers/dma/* with simple
workqueue. 

Allen Pais (1):
  drivers/dma/*: replace tasklets with workqueue

 drivers/dma/altera-msgdma.c                   | 15 ++++----
 drivers/dma/at_hdmac.c                        | 16 ++++-----
 drivers/dma/at_hdmac_regs.h                   |  6 ++--
 drivers/dma/at_xdmac.c                        | 14 ++++----
 drivers/dma/bcm2835-dma.c                     |  2 +-
 drivers/dma/dma-axi-dmac.c                    |  2 +-
 drivers/dma/dma-jz4780.c                      |  2 +-
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |  2 +-
 drivers/dma/dw-edma/dw-edma-core.c            |  4 +--
 drivers/dma/dw/core.c                         | 13 +++----
 drivers/dma/dw/regs.h                         |  2 +-
 drivers/dma/ep93xx_dma.c                      | 15 ++++----
 drivers/dma/fsl-edma-common.c                 |  2 +-
 drivers/dma/fsl-qdma.c                        |  2 +-
 drivers/dma/fsl_raid.c                        | 12 ++++---
 drivers/dma/fsl_raid.h                        |  2 +-
 drivers/dma/fsldma.c                          | 15 ++++----
 drivers/dma/fsldma.h                          |  2 +-
 drivers/dma/hisi_dma.c                        |  2 +-
 drivers/dma/hsu/hsu.c                         |  2 +-
 drivers/dma/idma64.c                          |  4 +--
 drivers/dma/img-mdc-dma.c                     |  2 +-
 drivers/dma/imx-dma.c                         | 27 +++++++-------
 drivers/dma/imx-sdma.c                        |  6 ++--
 drivers/dma/ioat/dma.c                        | 19 +++++-----
 drivers/dma/ioat/dma.h                        |  4 +--
 drivers/dma/ioat/init.c                       |  2 +-
 drivers/dma/iop-adma.c                        | 12 +++----
 drivers/dma/ipu/ipu_idmac.c                   | 22 ++++--------
 drivers/dma/ipu/ipu_intern.h                  |  2 +-
 drivers/dma/k3dma.c                           | 19 +++++-----
 drivers/dma/mediatek/mtk-cqdma.c              | 35 ++++++++++---------
 drivers/dma/mediatek/mtk-hsdma.c              |  4 +--
 drivers/dma/mediatek/mtk-uart-apdma.c         |  4 +--
 drivers/dma/mmp_pdma.c                        | 13 +++----
 drivers/dma/mmp_tdma.c                        | 11 +++---
 drivers/dma/mpc512x_dma.c                     | 17 ++++-----
 drivers/dma/mv_xor.c                          | 13 +++----
 drivers/dma/mv_xor.h                          |  4 +--
 drivers/dma/mv_xor_v2.c                       | 23 ++++++------
 drivers/dma/mxs-dma.c                         | 13 +++----
 drivers/dma/nbpfaxi.c                         | 15 ++++----
 drivers/dma/owl-dma.c                         |  2 +-
 drivers/dma/pch_dma.c                         | 17 ++++-----
 drivers/dma/pl330.c                           | 32 +++++++++--------
 drivers/dma/plx_dma.c                         | 13 +++----
 drivers/dma/ppc4xx/adma.c                     | 17 ++++-----
 drivers/dma/ppc4xx/adma.h                     |  4 +--
 drivers/dma/ptdma/ptdma-dev.c                 |  2 +-
 drivers/dma/ptdma/ptdma.h                     |  4 +--
 drivers/dma/pxa_dma.c                         |  2 +-
 drivers/dma/qcom/bam_dma.c                    | 35 ++++++++++---------
 drivers/dma/qcom/gpi.c                        | 18 +++++-----
 drivers/dma/qcom/hidma.c                      | 11 +++---
 drivers/dma/qcom/hidma.h                      |  6 ++--
 drivers/dma/qcom/hidma_ll.c                   | 11 +++---
 drivers/dma/qcom/qcom_adm.c                   |  2 +-
 drivers/dma/s3c24xx-dma.c                     |  2 +-
 drivers/dma/sa11x0-dma.c                      | 27 +++++++-------
 drivers/dma/sf-pdma/sf-pdma.c                 | 24 +++++++------
 drivers/dma/sf-pdma/sf-pdma.h                 |  4 +--
 drivers/dma/sprd-dma.c                        |  2 +-
 drivers/dma/st_fdma.c                         |  2 +-
 drivers/dma/ste_dma40.c                       | 17 ++++-----
 drivers/dma/sun6i-dma.c                       | 33 ++++++++---------
 drivers/dma/tegra20-apb-dma.c                 | 19 +++++-----
 drivers/dma/tegra210-adma.c                   |  2 +-
 drivers/dma/ti/edma.c                         |  2 +-
 drivers/dma/ti/k3-udma.c                      | 11 +++---
 drivers/dma/ti/omap-dma.c                     |  2 +-
 drivers/dma/timb_dma.c                        | 23 ++++++------
 drivers/dma/txx9dmac.c                        | 30 ++++++++--------
 drivers/dma/txx9dmac.h                        |  4 +--
 drivers/dma/virt-dma.c                        |  9 ++---
 drivers/dma/virt-dma.h                        |  8 ++---
 drivers/dma/xgene-dma.c                       | 21 +++++------
 drivers/dma/xilinx/xilinx_dma.c               | 23 ++++++------
 drivers/dma/xilinx/xilinx_dpdma.c             | 19 +++++-----
 drivers/dma/xilinx/zynqmp_dma.c               | 21 +++++------
 include/linux/platform_data/dma-iop32x.h      |  4 +--
 80 files changed, 459 insertions(+), 429 deletions(-)

-- 
2.17.1

