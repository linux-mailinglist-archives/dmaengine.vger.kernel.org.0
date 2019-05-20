Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3836623274
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2019 13:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfETLcc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 May 2019 07:32:32 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:39200 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbfETLcc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 May 2019 07:32:32 -0400
Received: by mail-pg1-f176.google.com with SMTP id w22so6670673pgi.6
        for <dmaengine@vger.kernel.org>; Mon, 20 May 2019 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2S9MAivwF7zxfimY+INJLOlqiV39ooQLNnYsMx0gRf8=;
        b=URK3N/1kJyHHrmd+w0Bx3YnOfa9G/JKqnZjMFsmCW22W5lxDFJUrmiKylqdW5OiP7c
         ZCxvYv4/7R2tcTo3I6DGZLRXFWNycsWZN/9J88ws7aMlzqo529IQ0Uu8QzwNVDDtmep4
         rRZOvw5qMETo0vhB+ZRq09iNTfSjza+IF4DjBHK7K0myRamsPRFiu8vDdP5kNz5FJDtO
         MDFlProPb/qyG34QmYYrKQcvc+OnM06MqNO0gB2M8ml0xVGeNrRe4UFBdiRB0XtK01Ng
         gP1+SdSm2Xa2e/Ao7G1sHkL56Heorsn+ssZqRfsHmTauEq1vDwgsbUmISsw2EDfUgNs1
         AfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2S9MAivwF7zxfimY+INJLOlqiV39ooQLNnYsMx0gRf8=;
        b=K/UGHNfir6WxZ5Ad2ptNZ3wjeIIsNz8BAY9RLhvN64blMjgDU7Gu3kP9ERYfaiRXGS
         l1rOVL6U5m/pCQ98ZM0azbNIa0TZaYLq7qn2xTdCn3Hz6f3xFDE5eA5sZvcFmEZwbwwY
         3AZHLiYhNRxhfHb7VEGSOjmaXjEME0Ffv3V/Issy0MseuzobQERShoRilDf126mQ47IE
         vuf7ADRMP2Yc4lHbMZb7WuVjihIQpayCPRNhz7rAgJUD7BHlFp5uFFbpJntl8Cp7f/mi
         J8x6XEbJT4hwokOdB6vDAF/Zg+6EJ6+VyDZPeILJhJEYGUThD4EwCXY6vQP3m9+GQ5JO
         X44A==
X-Gm-Message-State: APjAAAXZFzIDs13OpprK5xwwYKQXBi901m4ooaGmTv8MdlOZ1jbgJXE3
        dXAvSfmUsC+lHPqc4Lz3Lqj+LA==
X-Google-Smtp-Source: APXvYqxnQKIpFWVcVI13NBnHjPEFJoPccFai4k2DvNkDwrNTAcUlVFnQw/aT/Mj6kEAvFmc3w3SFDA==
X-Received: by 2002:a62:604:: with SMTP id 4mr80275260pfg.38.1558351951343;
        Mon, 20 May 2019 04:32:31 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z124sm21310020pfz.116.2019.05.20.04.32.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 04:32:30 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        jroedel@suse.de, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/8] Add matching device node validation in DMA engine core
Date:   Mon, 20 May 2019 19:32:13 +0800
Message-Id: <cover.1558351667.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

This patch set adds a device node validation in DMA engine core, that will
help some drivers to remove the duplicate device node validation in each
driver.

Any comments are welcome. Thanks.

Changes from v1:
 - Add test-by tag from Peter.
 - Use dma_request_channel instead of __dma_request_channel() for
 the fuse-tegra20.c driver to keep bisectable.

Baolin Wang (8):
  dmaengine: Add matching device node validation in
    __dma_request_channel()
  soc: tegra: fuse: Use dma_request_channel instead of
    __dma_request_channel()
  dmaengine: imx-sdma: Let the core do the device node validation
  dmaengine: dma-jz4780: Let the core do the device node validation
  dmaengine: mmp_tdma: Let the core do the device node validation
  dmaengine: mxs-dma: Let the core do the device node validation
  dmaengine: sh: rcar-dmac: Let the core do the device node validation
  dmaengine: sh: usb-dmac: Let the core do the device node validation

 drivers/dma/dma-jz4780.c              |    7 ++-----
 drivers/dma/dmaengine.c               |   10 ++++++++--
 drivers/dma/imx-sdma.c                |    9 ++-------
 drivers/dma/mmp_tdma.c                |   10 ++--------
 drivers/dma/mxs-dma.c                 |    8 ++------
 drivers/dma/of-dma.c                  |    4 ++--
 drivers/dma/sh/rcar-dmac.c            |    6 +++---
 drivers/dma/sh/usb-dmac.c             |    6 ++----
 drivers/soc/tegra/fuse/fuse-tegra20.c |    2 +-
 include/linux/dmaengine.h             |   12 ++++++++----
 include/linux/platform_data/dma-imx.h |    1 -
 11 files changed, 32 insertions(+), 43 deletions(-)

-- 
1.7.9.5

