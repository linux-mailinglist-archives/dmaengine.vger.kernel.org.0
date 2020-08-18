Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282CF24815B
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHRJGz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRJGy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:06:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60CAC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:06:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 128so9466276pgd.5
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HnNXNfy/bsUO1ZuAs0QgXapzXwvhzuEqbB8PvX1UYUM=;
        b=i1YtLcUKypEJ5i5yINYxCI+hbxZbR1VUre/T3QjlKudOGdCJmEJaJ+4adATfjVqExy
         8Wd2MbWYMxlzhq+u79qFkLz+ApLV4o+8eFhxJJe8vm65ycHf5BPeASHvjnyfZxFIfuxo
         f8B4uoP00fJx/Do/ybmVQumIrUlaCbfue1JImRmcolsW9bUFcPdze1TP98maoT0qTSgp
         AJHjK2X92Zyo4sItz4UxcmCs+EnTE2IESAH5nfkBq06yK+mJ7RhHqlBHchoOdiO+PxqN
         3qeLU2D7R8o41LcyNYm6JxaMRY0lx+BbNpvSIdxZSoxFCpEyT2r5B5Sv0r+p2ye6s2oB
         K74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HnNXNfy/bsUO1ZuAs0QgXapzXwvhzuEqbB8PvX1UYUM=;
        b=iq423aORSceIViV1V/rKk/2WTNWHA99YLl0n8WQsAd4YFETZPxXCRfwgp7TSs8t0Nn
         QI/THLU0tKIJvb6gJEkRemaHL/xpVWI7wrP1BI3NfyWlICD9lYr4eUznCYiGsJDiG0tU
         6+mT3bMm9c4yGb4cxdps4Qmet4MszYEI6EsOZHF86k9PkzKYI6vxmNXKP9zBP6PVC4v/
         XqF4NkmxO34L1vzEltI4XHBUx2w00CvMCrEYfCxCxJOVWl0G0nwVb+BdLf+jqkVPHpg3
         gY/YaYak1geaCE0b1Z+LPZJTLKnsZ2nZeqADAFJipu2FRSb1paw/9WLcWMxl6Fj/GAY8
         0i2w==
X-Gm-Message-State: AOAM531jf8tw58muAD9U3ixGunTnzixh5N78jhumVeyMcS5Uk0/f9JOk
        tOAccezlJNJXPWBhLB4iVHs=
X-Google-Smtp-Source: ABdhPJyOGdmLaL0sHSWHtqfJ6WHBQC7gyyZOXFa4nRdF1MLSgHyyS63aaJktKExHiTd0L3AAlEitYA==
X-Received: by 2002:aa7:9585:: with SMTP id z5mr14114267pfj.11.1597741613352;
        Tue, 18 Aug 2020 02:06:53 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:06:52 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 00/35] dma: convert tasklets to use new tasklet_setup()
Date:   Tue, 18 Aug 2020 14:36:03 +0530
Message-Id: <20200818090638.26362-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
introduced a new tasklet initialization API. This series converts
all the dma drivers to use the new tasklet_setup() API

This is based on 5.9-rc1.

Please pick this series, as I missed updating a couple of fixes and marking
the correct mailing list.

Allen Pais (35):
  dma: altera-msgdma: convert tasklets to use new tasklet_setup() API
  dma: at_hdmac: convert tasklets to use new tasklet_setup() API
  dma: at_xdmac: convert tasklets to use new tasklet_setup() API
  dma: coh901318: convert tasklets to use new tasklet_setup() API
  dma: dw: convert tasklets to use new tasklet_setup() API
  dma: ep93xx: convert tasklets to use new tasklet_setup() API
  dma: fsl: convert tasklets to use new tasklet_setup() API
  dma: imx-dma: convert tasklets to use new tasklet_setup() API
  dma: ioat: convert tasklets to use new tasklet_setup() API
  dma: iop_adma: convert tasklets to use new tasklet_setup() API
  dma: ipu: convert tasklets to use new tasklet_setup() API
  dma: k3dma: convert tasklets to use new tasklet_setup() API
  dma: mediatek: convert tasklets to use new tasklet_setup() API
  dma: mmp: convert tasklets to use new tasklet_setup() API
  dma: mpc512x: convert tasklets to use new tasklet_setup() API
  dma: mv_xor: convert tasklets to use new tasklet_setup() API
  dma: mxs-dma: convert tasklets to use new tasklet_setup() API
  dma: nbpfaxi: convert tasklets to use new tasklet_setup() API
  dma: pch_dma: convert tasklets to use new tasklet_setup() API
  dma: pl330: convert tasklets to use new tasklet_setup() API
  dma: ppc4xx: convert tasklets to use new tasklet_setup() API
  dma: qcom: convert tasklets to use new tasklet_setup() API
  dma: sa11x0: convert tasklets to use new tasklet_setup() API
  dma: sirf-dma: convert tasklets to use new tasklet_setup() API
  dma: ste_dma40: convert tasklets to use new tasklet_setup() API
  dma: sun6i: convert tasklets to use new tasklet_setup() API
  dma: tegra20: convert tasklets to use new tasklet_setup() API
  dma: timb_dma: convert tasklets to use new tasklet_setup() API
  dma: txx9dmac: convert tasklets to use new tasklet_setup() API
  dma: virt-dma: convert tasklets to use new tasklet_setup() API
  dma: xgene: convert tasklets to use new tasklet_setup() API
  dma: xilinx: convert tasklets to use new tasklet_setup() API
  dma: plx_dma: convert tasklets to use new tasklet_setup() API
  dma: sf-pdma: convert tasklets to use new tasklet_setup() API
  dma: k3-udma: convert tasklets to use new tasklet_setup() API

 drivers/dma/altera-msgdma.c      |  6 +++---
 drivers/dma/at_hdmac.c           |  7 +++----
 drivers/dma/at_xdmac.c           |  7 +++----
 drivers/dma/coh901318.c          |  7 +++----
 drivers/dma/dw/core.c            |  6 +++---
 drivers/dma/ep93xx_dma.c         |  7 +++----
 drivers/dma/fsl_raid.c           |  6 +++---
 drivers/dma/fsldma.c             |  6 +++---
 drivers/dma/imx-dma.c            |  7 +++----
 drivers/dma/ioat/dma.c           |  6 +++---
 drivers/dma/ioat/dma.h           |  2 +-
 drivers/dma/ioat/init.c          |  4 +---
 drivers/dma/iop-adma.c           |  8 ++++----
 drivers/dma/ipu/ipu_idmac.c      |  6 +++---
 drivers/dma/k3dma.c              |  6 +++---
 drivers/dma/mediatek/mtk-cqdma.c |  7 +++----
 drivers/dma/mmp_pdma.c           |  6 +++---
 drivers/dma/mmp_tdma.c           |  6 +++---
 drivers/dma/mpc512x_dma.c        |  6 +++---
 drivers/dma/mv_xor.c             |  7 +++----
 drivers/dma/mv_xor_v2.c          |  8 ++++----
 drivers/dma/mxs-dma.c            |  7 +++----
 drivers/dma/nbpfaxi.c            |  6 +++---
 drivers/dma/pch_dma.c            |  7 +++----
 drivers/dma/pl330.c              | 12 ++++++------
 drivers/dma/plx_dma.c            |  7 +++----
 drivers/dma/ppc4xx/adma.c        |  7 +++----
 drivers/dma/qcom/bam_dma.c       |  6 +++---
 drivers/dma/qcom/hidma.c         |  6 +++---
 drivers/dma/qcom/hidma_ll.c      |  6 +++---
 drivers/dma/sa11x0-dma.c         |  6 +++---
 drivers/dma/sf-pdma/sf-pdma.c    | 14 ++++++--------
 drivers/dma/sirf-dma.c           |  6 +++---
 drivers/dma/ste_dma40.c          |  7 +++----
 drivers/dma/sun6i-dma.c          |  6 +++---
 drivers/dma/tegra20-apb-dma.c    |  7 +++----
 drivers/dma/ti/k3-udma.c         |  7 +++----
 drivers/dma/timb_dma.c           |  6 +++---
 drivers/dma/txx9dmac.c           | 14 ++++++--------
 drivers/dma/virt-dma.c           |  6 +++---
 drivers/dma/xgene-dma.c          |  7 +++----
 drivers/dma/xilinx/xilinx_dma.c  |  7 +++----
 drivers/dma/xilinx/zynqmp_dma.c  |  6 +++---
 43 files changed, 136 insertions(+), 158 deletions(-)

-- 
2.17.1

