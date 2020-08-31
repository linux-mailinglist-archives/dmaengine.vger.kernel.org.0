Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571D125775A
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHaKgD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHaKgB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:36:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE7C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m8so355469pfh.3
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=214J+Nz917AG5zKh44VndkRcf3rmy/ebFa5aGexOdH4=;
        b=MvpL3VM1NydGExvvVsJf3BLvMsR5A8L2eP9y6uwriUhEbNWE9sxWbfow1oRBkS0Tne
         d3V2jn+ngwOHoaNXY55NrUOBLs3o3Eq/YqONlGWyhrVrsIIph4DW7C3KolFUuRqegU5G
         sU8LH5m/H9dRlY9VivEQM9PXsYc/3GJ8Dh7jkxJJ4QnWAb2Z8G/TRkqpog5/HkAiqLcY
         Xpf12RpmZkvIpV2yhlC0C62qDsVcnWT7pkohxbxXu7SzEKvgwzFCA20W/1wqfFBTm+2h
         xFLstToaT3R3Vz9BlbaDAWNx96FySRc/Ujo3tymwNT/62AHYCRqNB3Jygo7ZR/u2GFPM
         EZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=214J+Nz917AG5zKh44VndkRcf3rmy/ebFa5aGexOdH4=;
        b=SQHOU2yiD+y1N95cAfsh4xc67WAHhi28RI4NXIUq1z3dZckQouyix3LsNv+WEqIJ2u
         N7lGPgoDfQ2bPWpgyca9bJ4DDLD1LeY1NdKzN6Gvnd4RG14bIAsfgfaYIaKMs6F+tK9f
         YRg/yYo4rLB61xhlJLS65nPn5zep/jjQNE8B7aDBE1d/+YdGNh4oZsgaaGO6zL43oJFS
         oKDFg7/tqIE1NK+W/iyw3f5HZu/3Ihz9+j9h6zn680pE95BPwWVKhhpsdCgtUTjQ4uWn
         PGH+WQzpj4yqTnbLUTsIcIw19yRyZ7X8OQdFBb7VCAD41iN5sB/gbBAscF4cTC1WT8iF
         7VAA==
X-Gm-Message-State: AOAM532h6P3vpYqQO7hoahQAAgkAeaUtB72a8ZzhgY47cCAWXZbdpfFY
        XSN5sc6XNXfD9/DxlJKSlMU=
X-Google-Smtp-Source: ABdhPJxIcIQ18xKOLRgzGfKXoSSww1d4rC/81S3S+2Giz8uqZT0dQ1bzxrbFx5dLuWiuIBOP+Ts/5g==
X-Received: by 2002:a63:5542:: with SMTP id f2mr748180pgm.196.1598870158933;
        Mon, 31 Aug 2020 03:35:58 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:35:58 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH v3 00/35] dmaengine: convert tasklets to use new
Date:   Mon, 31 Aug 2020 16:05:07 +0530
Message-Id: <20200831103542.305571-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
introduced a new tasklet initialization API. This series converts
all the dma drivers to use the new tasklet_setup() API

This series is based on v5.9-rc3

v3:
 Updated subject line. 

v2: 
 Fixed a build warning.

Allen Pais (35):
  dmaengine: altera-msgdma: convert tasklets to use new tasklet_setup()
    API
  dmaengine: at_hdmac: convert tasklets to use new tasklet_setup() API
  dmaengine: at_xdmac: convert tasklets to use new tasklet_setup() API
  dmaengine: coh901318: convert tasklets to use new tasklet_setup() API
  dmaengine: dw: convert tasklets to use new tasklet_setup() API
  dmaengine: ep93xx: convert tasklets to use new tasklet_setup() API
  dmaengine: fsl: convert tasklets to use new tasklet_setup() API
  dmaengine: imx-dma: convert tasklets to use new tasklet_setup() API
  dmaengine: ioat: convert tasklets to use new tasklet_setup() API
  dmaengine: iop_adma: convert tasklets to use new tasklet_setup() API
  dmaengine: ipu: convert tasklets to use new tasklet_setup() API
  dmaengine: k3dma: convert tasklets to use new tasklet_setup() API
  dmaengine: mediatek: convert tasklets to use new tasklet_setup() API
  dmaengine: mmp: convert tasklets to use new tasklet_setup() API
  dmaengine: mpc512x: convert tasklets to use new tasklet_setup() API
  dmaengine: mv_xor: convert tasklets to use new tasklet_setup() API
  dmaengine: mxs-dma: convert tasklets to use new tasklet_setup() API
  dmaengine: nbpfaxi: convert tasklets to use new tasklet_setup() API
  dmaengine: pch_dma: convert tasklets to use new tasklet_setup() API
  dmaengine: pl330: convert tasklets to use new tasklet_setup() API
  dmaengine: ppc4xx: convert tasklets to use new tasklet_setup() API
  dmaengine: qcom: convert tasklets to use new tasklet_setup() API
  dmaengine: sa11x0: convert tasklets to use new tasklet_setup() API
  dmaengine: sirf-dma: convert tasklets to use new tasklet_setup() API
  dmaengine: ste_dma40: convert tasklets to use new tasklet_setup() API
  dmaengine: sun6i: convert tasklets to use new tasklet_setup() API
  dmaengine: tegra20: convert tasklets to use new tasklet_setup() API
  dmaengine: timb_dma: convert tasklets to use new tasklet_setup() API
  dmaengine: txx9dmac: convert tasklets to use new tasklet_setup() API
  dmaengine: virt-dma: convert tasklets to use new tasklet_setup() API
  dmaengine: xgene: convert tasklets to use new tasklet_setup() API
  dmaengine: xilinx: convert tasklets to use new tasklet_setup() API
  dmaengine: plx_dma: convert tasklets to use new tasklet_setup() API
  dmaengine: sf-pdma: convert tasklets to use new tasklet_setup() API
  dmaengine: k3-udma: convert tasklets to use new tasklet_setup() API

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
2.25.1

