Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA15515D16
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 08:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfEGGKH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 02:10:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39750 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfEGGKH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 02:10:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so201251plm.6
        for <dmaengine@vger.kernel.org>; Mon, 06 May 2019 23:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=F2rlrgjaiJp1NZ6RM4VM9hD4Rmd/jUUVurwXpw2zOD0=;
        b=Dl5JgfjZLUNAedfPuQQEAtFakRXAUtWL3Qc7a0Ko7nRreVMr5QXRF9ELOhpMzYIXEF
         M+uqiTbjF/ZOFb9Sy+fVQzLBwvmpryBUYQ/+FdjbY6Hn5tU95O3/0by2Hv5r5CaTSk9U
         a9ISQUlkFaTyzuMtX1+uVWLFQZAsUKnaI5jGOPi1EbiB3yaPKy75oW0BPNMZMsdRBw2O
         +xUO/mmPVEm418F9q7Aclbkl5PTgkOdagQsrzNnQdQK3bbq5zfJrduth/X3I7ZpcKkXd
         tCRFsqKB1xW66ic0/V8jaC1kGEWwhP7tYUHaJVsMVtBAwISXMYtJ/YAdq2dTVyVrPtwg
         mafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F2rlrgjaiJp1NZ6RM4VM9hD4Rmd/jUUVurwXpw2zOD0=;
        b=mNZcHZ7cRuNG+3UtbXBHDkp0h+csZMQSQseqAiv9XT7onUIMgbEuFAoOIogf6kNZwy
         AVPxgKu7wPEegi4rsuWYSsq4aMW20+6RDF0pcBVVoQMGjopH6gmRtgkqnglMuISrPzyB
         zi8/BuwY8Q5UtwmW3AmG3Mf4PyaZO2pdTH+KcNgIKuS3EVymJ4yaOY9OqtE00xVTQ+0T
         8Knf7WTSW043/cD5rZVi9gn5ASOodA6fa2pifp+/LZmEmrhFeeukaoSmHr2UbwwC/8nF
         c5BoXKHVPafnE6OwosdSvQwL3L8XXS030Jm9h/AGIbi2yD+a/1oMuILH7gkMWsHeoXpx
         daVQ==
X-Gm-Message-State: APjAAAUHyQNEwAcPLA0sUDPNDU3WKniJUbqvb9l5IQTBdnGZ4ki13bN0
        EDUA/tnGEPxMGjI+9V6wlgBHQQ==
X-Google-Smtp-Source: APXvYqyFxErSKOJGlANeP4eMybnknfCs0uOocek9g5tx0HVX9gFqZV9fJIv0GNvM6WxbwVQ6k420WQ==
X-Received: by 2002:a17:902:9a0c:: with SMTP id v12mr38439694plp.184.1557209406749;
        Mon, 06 May 2019 23:10:06 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:06 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Zubair.Kakakhel@imgtec.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/8] Add matching device node validation in DMA engine core
Date:   Tue,  7 May 2019 14:09:37 +0800
Message-Id: <cover.1557206859.git.baolin.wang@linaro.org>
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

Baolin Wang (8):
  dmaengine: Add matching device node validation in
    __dma_request_channel()
  soc: tegra: fuse: Change to the correct __dma_request_channel()
    prototype
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

