Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA1D34C032
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhC1X6U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhC1X56 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:57:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC91C061756;
        Sun, 28 Mar 2021 16:57:57 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id i19so8219834qtv.7;
        Sun, 28 Mar 2021 16:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rk0U560xdi7ATXezYweBgD2EUyZ4bnHBlHOPTcEoREY=;
        b=ZLnI2Hw3GmiFb+BW4FldFixdVOm0/gTAYYcPGeNweT29zSncqaCxQl2ULX/m3x6yjk
         FlPvPCq6g1oh13jD6EQyG1JSSdz9G8bm3HGZ2akxZG2GJMQ9BC7QedLKEm34PtSwYA9Q
         9GLpxWPlLC/j45fuB1CB2u0k+GONoOh9eOlRvew+eCtM4IXd3/dem3muwmJ2LGUvv9pZ
         rKataNLRCg25wm/swBsArGMvPBDO2BXQknOCELLoUmLYNgIAwbOCOSxAGx2PbdugPEc1
         E84l/Bt6cNoKU6NHkm/vCejz/HyOc3AwND0Z16aeHxg7CDZpOR9OV5YCqN3yJaJzc09z
         OoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rk0U560xdi7ATXezYweBgD2EUyZ4bnHBlHOPTcEoREY=;
        b=FhwKoDrx1R0gEA3GNYPZ9H0WG6hU8ukCnyN9MU5Z03/G/+GAcG2jvSElVCX7zsGFty
         zoriabAIIDP5/GiMuQ9CbonPZ6DvmNoAxVJoSIb7pD5pITX7Z0Dqd/ziW1uTJTG6sfoO
         c06aIOd4MXzDvuWLJJYfQeJfulp++mCQt6925ImwhxQxaauU1iuzZ3gauYVQWKINp/jz
         65ZGAZM6VRaX7Q24gKUcpPRq+StY0zrRrcKpQg9ey5OWQFPplYcpz+tXnVl48hKvxwtz
         5ZqPUEVkRi3Vu7OGclwxPo5uTqG7GpmKXgKks1uS6mCobjZsrdJlm0KzS27ps/EVIeOc
         IDjQ==
X-Gm-Message-State: AOAM532Cbj1J7PddJjrbaRVlkpCD4upaM8l+d/PErTP/tiN0RzGueIvH
        JUnUGWpLJ7iG/SEPTxlZhhu+xhLmNJCsK+or
X-Google-Smtp-Source: ABdhPJzfb/lAvD1VavVqudcTSNWwFXh9v8R3VckD2GeZAMNUEqCjOYPLz+1Z1e0dwqaRcAS+cSxIlw==
X-Received: by 2002:ac8:7e95:: with SMTP id w21mr19593417qtj.244.1616975876781;
        Sun, 28 Mar 2021 16:57:56 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:57:56 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/30] Kconfig: Change Synopsys to Synopsis
Date:   Mon, 29 Mar 2021 05:23:20 +0530
Message-Id: <1262e9e62498f961e5172205e66a9ef7c6f0f69d.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/Synopsys/Synopsis/  .....two different places.

..and for some unknown reason it introduce a empty line deleted and added
back.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0c2827fd8c19..30e8cc26f43b 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -170,15 +170,15 @@ config DMA_SUN6I
 	  Support for the DMA engine first found in Allwinner A31 SoCs.

 config DW_AXI_DMAC
-	tristate "Synopsys DesignWare AXI DMA support"
+	tristate "Synopsis DesignWare AXI DMA support"
 	depends on OF || COMPILE_TEST
 	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-	  Enable support for Synopsys DesignWare AXI DMA controller.
+	  Enable support for Synopsis DesignWare AXI DMA controller.
 	  NOTE: This driver wasn't tested on 64 bit platform because
-	  of lack 64 bit platform with Synopsys DW AXI DMAC.
+	  of lack 64 bit platform with Synopsis DW AXI DMAC.

 config EP93XX_DMA
 	bool "Cirrus Logic EP93xx DMA support"
@@ -394,7 +394,7 @@ config MOXART_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
 	  Enable support for the MOXA ART SoC DMA controller.
-
+
 	  Say Y here if you enabled MMP ADMA, otherwise say N.

 config MPC512X_DMA
--
2.26.3

