Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2882717B06
	for <lists+dmaengine@lfdr.de>; Wed, 31 May 2023 11:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjEaJCL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 May 2023 05:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjEaJBu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 May 2023 05:01:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9422E18B
        for <dmaengine@vger.kernel.org>; Wed, 31 May 2023 02:01:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-256e1d87a46so581288a91.0
        for <dmaengine@vger.kernel.org>; Wed, 31 May 2023 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1685523706; x=1688115706;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pBr07dQUqaCydPGFnh0XsYk9RZIo6EgjJ9yRkDs7qc=;
        b=k0gEFFMxjc0/bm1dulNEnmj/gkEBAq8qksZiEYn01tWue+ugt1l4JjhJuzhedhYr1E
         fNJ6I6CBh9cv2fsrC2awNfpYQmmCbVaFyJSFe4xkYmOHV5l+7HlyY5h1hP3bhQd5NYAp
         ZGxA14czbcWrfLQnSmquR5F8mBuPcX+zySQpGYrvZMw84LdrGIgfsg1D7gIbr13tsWQn
         OwXGhaen/kvc/TfHQSUGyr8WJjZgBC8b2NzhgFhaRiPZ7559B6XvcT84WPFo0rjJYrpZ
         /8fjcDoFnit+Bs2B3j4RYSyCAnayiUY3+d/Hy4viuN8AMTjZZA7qj1CztoU4/ZRbP2G3
         eukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523706; x=1688115706;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pBr07dQUqaCydPGFnh0XsYk9RZIo6EgjJ9yRkDs7qc=;
        b=Is9jc101Ivyw2379QxTUgWIvxsJFPi8pgRJGVWljyXGPh4bl55vw9npnrG+rEK91XH
         31FGoJjD8PgtqJ1lbCf1C+tXUqNJureE7LFDFd8Y8TUSQ4tdubjbBz2RPgBbASCLezkF
         SORsAbo7iIuOsGDHTQiqgK8mdQFzotMX/fYlLBWMOyz4yh6As6dBYdOtb1rTySB8qdrP
         DBiEuDgRTVT8+sLxQxa0aOpNw8CoVAdx7Vq4LrXCgh17ruG4f1Vvk1lj1Y0H1ABVCCe8
         7cfL06E9ZX8REXzeTXAfrJ1CVLywPZexI7bUw0FXcXWQjGBOUNWycR2rpKDhJ5FnX874
         JyJA==
X-Gm-Message-State: AC+VfDzICv2o5bDbejzFvtPfwGqEQjJG6yHdQ/vtYHuarJWEuMC+in1T
        Tir6E9qKnst76ZtxEU5Q3Au9pg==
X-Google-Smtp-Source: ACHHUZ69o+/M5P3Zycl8uoG0BG2EoJtoFIF/MhAduF9LQVBw+R78RiKf70usd3kanYK/k+I5v4ecgg==
X-Received: by 2002:a17:90a:9f97:b0:256:5174:f58b with SMTP id o23-20020a17090a9f9700b002565174f58bmr4353082pjp.46.1685523705852;
        Wed, 31 May 2023 02:01:45 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a4e8100b00255d3bd5ce5sm744398pjh.45.2023.05.31.02.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:01:45 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     vkoul@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        radhey.shyam.pandey@amd.com, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3] dmaengine: xilinx: dma: remove arch dependency
Date:   Wed, 31 May 2023 09:01:41 +0000
Message-Id: <20230531090141.23546-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As following patches, xilinx dma is also now architecture agnostic,
and it can be compiled for several architectures. We have verified the
CDMA on RISC-V platform, let's remove the ARCH dependency list instead
of adding new ARCH.

To avoid breaking the s390 build, add a dependency on HAS_IOMEM.

'e8b6c54f6d57 ("net: xilinx: temac: Relax Kconfig dependencies")'
'd7eaf962a90b ("net: axienet: In kconfig remove arch dependency for axi_emac")'

Signed-off-by: Zong Li <zong.li@sifive.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Suggested-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---

 Changes in v3:
 - Add a dependency on HAS_IOMEM to avoid breaking the s390 build

 Changes in v2:
 - Remove ARCH dependency list instead of adding new ARCH

 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f5f422f9b850..fd5a94e67163 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -696,7 +696,7 @@ config XGENE_DMA
 
 config XILINX_DMA
 	tristate "Xilinx AXI DMAS Engine"
-	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	help
 	  Enable support for Xilinx AXI VDMA Soft IP.
-- 
2.17.1

