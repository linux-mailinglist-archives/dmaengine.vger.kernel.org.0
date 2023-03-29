Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980D36CF0F2
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 19:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjC2RWc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Mar 2023 13:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2RWb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Mar 2023 13:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04654682
        for <dmaengine@vger.kernel.org>; Wed, 29 Mar 2023 10:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680110500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cXO0bYsmE8RQkiU8p+vffYn85AnFZlCiXkctXOQi2o4=;
        b=NfC/6EsDmJcO6HZQVrgERuNi2Hmk/m9d6N5pCrFL/08/cXsQ5YcQDTYNBqKY9Ld7EItFEO
        nWd7pVLY0PHuYB0gNbcz2kU/1KhwTy/8BNXh3TNUGXNM7dhfz6IH4jv4egAnARuCg5BlLm
        V75Xak2hiYjEyzW8GNlFb1OwKzWg7vE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-2yB2SrAONRCyVg1nQ3lGGg-1; Wed, 29 Mar 2023 13:21:36 -0400
X-MC-Unique: 2yB2SrAONRCyVg1nQ3lGGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EC473815F6F;
        Wed, 29 Mar 2023 17:21:36 +0000 (UTC)
Received: from trippy.localdomain.com (unknown [10.22.10.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1477D14171BB;
        Wed, 29 Mar 2023 17:21:36 +0000 (UTC)
From:   Mark Salter <msalter@redhat.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: tegra: explicitly select DMA_VIRTUAL_CHANNELS
Date:   Wed, 29 Mar 2023 13:21:29 -0400
Message-Id: <20230329172129.88403-1-msalter@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enabling TEGRA186_GPC_DMA will cause this build failure unless some other
DMA driver which uses DMA_VIRTUAL_CHANNELS is enabled:

  ERROR: modpost: "vchan_dma_desc_free_list" [drivers/dma/tegra186-gpc-dma.ko] undefined!
  ERROR: modpost: "vchan_init" [drivers/dma/tegra186-gpc-dma.ko] undefined!
  ERROR: modpost: "vchan_tx_submit" [drivers/dma/tegra186-gpc-dma.ko] undefined!
  ERROR: modpost: "vchan_tx_desc_free" [drivers/dma/tegra186-gpc-dma.ko] undefined!
  ERROR: modpost: "vchan_find_desc" [drivers/dma/tegra186-gpc-dma.ko] undefined!
  make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1

Add an explicit select of DMA_VIRTUAL_CHANNELS to avoid this.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index fb7073fc034f..f5f422f9b850 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -623,6 +623,7 @@ config TEGRA186_GPC_DMA
 	depends on (ARCH_TEGRA || COMPILE_TEST) && ARCH_DMA_ADDR_T_64BIT
 	depends on IOMMU_API
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Support for the NVIDIA Tegra General Purpose Central DMA controller.
 	  The DMA controller has multiple DMA channels which can be configured
-- 
2.39.2

