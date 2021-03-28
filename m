Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6546134BFE7
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhC1X4K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC1Xz7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:55:59 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEFDC061756;
        Sun, 28 Mar 2021 16:55:59 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i9so10933468qka.2;
        Sun, 28 Mar 2021 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NUiuzRmCI317NNPwOQd3D4rWQdmGZHrpIjp/qwsCZIQ=;
        b=uXWQRahp3gbzRLIyyNL0YRXhVCZtEuZiHzn/PIsuzG8877k5bJgwYQURdeOdvHz4vf
         UtOWDRp8hFHb4tkPHczneiCk1Dp3BAPe8nPUJPWphJIe8eEQsUMHA9EhMcfHmCfBv63h
         Cc6qgUFx9EvyH/PxY7kVGPUt16C7C6GHqSlgWmk/W3Nlz01gtqMgxdPyzK93UMSj/j8K
         RPiLrdcZHQGN/UMvJlD5XTJKRT5dQdkBl2Ur7I1OR5KPUc6a7GsZQevDW3l5YxrmCI0z
         r1yTXrRR5jXQtJQZlSGfd5Ol7iXIub51CMMgWplOjMM8chkK0lsTJMIbROp7cwk4m0P1
         +qgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NUiuzRmCI317NNPwOQd3D4rWQdmGZHrpIjp/qwsCZIQ=;
        b=EE2Fyaio5GzpTkqIT5AfWXA8m0IVikDDTCIVdIti/DaoNlgvAJLi5yKdX7ZZmB/5BX
         ksjHIrfsvkKWf6iP87At4mVjJHaXUtkFFnkoWtMFHCjP1FEBP9u1BGTjtFRww9CKfT/N
         ew09OG26EY3PIYsynzadEJCTXuLv4Yoy9RQbp27ytBixizjcIzenMrSn8mBnLZyG2Ewj
         WyN7+aHEUSNeSSMzXmkMDs1mma5PVvqmW7lUaAMQXQC+HGDxA0NXRx6JM7n9KVz1uUiF
         ARsJ8IMkxT9dwYiKw8ixVZdx28iPmw4W1MNFGwPZnLfyklsnxhUW5Zamt6zSwdNOnp0e
         mc9Q==
X-Gm-Message-State: AOAM532st9vEkCfGVFL/kOBSnHuZlgzPU89aij0iBb5hqR+Fc2KXVs1R
        YebtjHSCPeOtjA4YLOkdlxYtvf4qhzSCFSaU
X-Google-Smtp-Source: ABdhPJyKaE6xu37zVH3z/CjmV3TkU5t17RBcANW7BpVJXHO+pgWwNEwtWueIieluVNk3R4I3c1/mYg==
X-Received: by 2002:a05:620a:cf4:: with SMTP id c20mr22554064qkj.134.1616975757870;
        Sun, 28 Mar 2021 16:55:57 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:55:57 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/30] DMA: Mundane typo fixes
Date:   Mon, 29 Mar 2021 05:22:56 +0530
Message-Id: <cover.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series fixes some trivial and rudimentary spellings in the COMMENT
sections.

Bhaskar Chowdhury (30):
  acpi-dma.c: Fix couple of typos
  altera-msgdma.c: Couple of typos fixed
  amba-pl08x.c: Fixed couple of typos
  bcm-sba-raid.c: Few typos fixed
  bcm2835-dma.c: Fix a typo
  idma64.c: Fix couple of typos
  iop-adma.c: Few typos fixed
  mv_xor.c: Fix a typo
  mv_xor.h: Fixed a typo
  mv_xor_v2.c: Fix a typo
  nbpfaxi.c: Fixed a typo
  of-dma.c: Fixed a typo
  s3c24xx-dma.c: Fix a typo
  Revert "s3c24xx-dma.c: Fix a typo"
  s3c24xx-dma.c: Few typos fixed
  st_fdma.h: Fix couple of typos
  ste_dma40_ll.h: Fix a typo
  tegra20-apb-dma.c: Fixed a typo
  xgene-dma.c: Few spello fixes
  at_hdmac.c: Quite a few spello fixes
  owl-dma.c: Fix a typo
  at_hdmac_regs.h: Couple of typo fixes
  dma-jz4780.c: Fix a typo
  Kconfig: Change Synopsys to Synopsis
  ste_dma40.c: Few spello fixes
  dw-axi-dmac-platform.c: Few typos fixed
  dpaa2-qdma.c: Fix a typo
  usb-dmac.c: Fix a typo
  edma.c: Fix a typo
  xilinx_dma.c: Fix a typo

 drivers/dma/Kconfig                            |  8 ++++----
 drivers/dma/acpi-dma.c                         |  4 ++--
 drivers/dma/altera-msgdma.c                    |  4 ++--
 drivers/dma/amba-pl08x.c                       |  4 ++--
 drivers/dma/at_hdmac.c                         | 14 +++++++-------
 drivers/dma/at_hdmac_regs.h                    |  4 ++--
 drivers/dma/bcm-sba-raid.c                     |  8 ++++----
 drivers/dma/bcm2835-dma.c                      |  2 +-
 drivers/dma/dma-jz4780.c                       |  2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  8 ++++----
 drivers/dma/idma64.c                           |  4 ++--
 drivers/dma/iop-adma.c                         |  6 +++---
 drivers/dma/mv_xor.c                           |  2 +-
 drivers/dma/mv_xor.h                           |  2 +-
 drivers/dma/mv_xor_v2.c                        |  2 +-
 drivers/dma/nbpfaxi.c                          |  2 +-
 drivers/dma/of-dma.c                           |  2 +-
 drivers/dma/owl-dma.c                          |  2 +-
 drivers/dma/s3c24xx-dma.c                      |  6 +++---
 drivers/dma/sh/shdmac.c                        |  2 +-
 drivers/dma/sh/usb-dmac.c                      |  2 +-
 drivers/dma/st_fdma.h                          |  4 ++--
 drivers/dma/ste_dma40.c                        | 10 +++++-----
 drivers/dma/ste_dma40_ll.h                     |  2 +-
 drivers/dma/tegra20-apb-dma.c                  |  2 +-
 drivers/dma/ti/edma.c                          |  2 +-
 drivers/dma/xgene-dma.c                        |  6 +++---
 drivers/dma/xilinx/xilinx_dma.c                |  2 +-
 28 files changed, 59 insertions(+), 59 deletions(-)

--
2.26.3

