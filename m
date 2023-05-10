Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BBF6FD670
	for <lists+dmaengine@lfdr.de>; Wed, 10 May 2023 08:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjEJGE3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 May 2023 02:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJGE1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 May 2023 02:04:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E7040F7
        for <dmaengine@vger.kernel.org>; Tue,  9 May 2023 23:04:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aafa41116fso47189255ad.1
        for <dmaengine@vger.kernel.org>; Tue, 09 May 2023 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1683698666; x=1686290666;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu0Ww4Btm3ZJWmUm54OXSmR11HegrPdHhOCTMAKgm2g=;
        b=h8djJvjR8ebEG6ImUF1nkveTqSFqxQK3NuyugJ0rvCgfuk3n7bOjbRYxjtXbDIo41c
         9hkL5I3sSZAH4LWpU5Hz4rzaimszZBnNgQOeLWbHtCSvV7WE23HlCEltuB97H+lsxDhi
         T0Nr9HX8Syru1uaPiRtTS46v2moIsJGkvq2fkvbS9avnh5cZYPI/gMly6X4IibbUV9Ex
         V/dQFKHhfVsUE9F4bjL0+Da5GeBHVH47z3e2nCnG8iqSQwDFB78EZK5iy9Znzu0czH/C
         bkc9CPb8uKkFm5Hp+RwIdrNE6RB3gLGj+3o9CVYLr6Psz0nv+LzShMjkAsT7kk0uGH+m
         OjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683698666; x=1686290666;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gu0Ww4Btm3ZJWmUm54OXSmR11HegrPdHhOCTMAKgm2g=;
        b=cacmZ+65VaNm7uW2/3TCmICeX63hwDmMQramm/0Jo+OCpxBRFytAUwJpuJ2uHt4AIp
         +Y9SmlrRKOshQgu9X3CHAFDiDI6Q0KRipIBnohWMlLMAHm3Mo76SbD1Q20AvuGTmY0BS
         59Msc8yw81+2itk6uAUUnFLFQWHg7EvvrtrtndMrM4yyL9EzAmLrO87Ib7n5GiNU3rBc
         hXDLoPyInXXa9TRLOPDtZs5FtRu5VHXCOMb1xXqBwWcRzRjb4Vky36rV6AnDw1TJt5tm
         Fdi6jsmOU42ep2nl3VtZ2I87tH8dMK73IVbuI+ULKjJjPTqp7AzgBOgIVphkz3JYYQRT
         njeg==
X-Gm-Message-State: AC+VfDx/bm+InUd5+nVblGS8Exd97nwyiV24Iy+bBlCuFFNyi3KXHumv
        +CTX7+IO8ZOLQ7SqEmYylDheUg==
X-Google-Smtp-Source: ACHHUZ58wm9Z0W6YIYZ1v9zc9DcTUNNZ2qDA21or5nSqrykEbxFIclL0qerbXr6/V4brO+GwwybdGA==
X-Received: by 2002:a17:902:c40a:b0:1ab:28ec:bf10 with SMTP id k10-20020a170902c40a00b001ab28ecbf10mr23310293plk.51.1683698666262;
        Tue, 09 May 2023 23:04:26 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b001ab0a30c895sm2751424plb.202.2023.05.09.23.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 23:04:25 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     vkoul@kernel.org, palmer@dabbelt.com, radhey.shyam.pandey@amd.com,
        dmaengine@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2] dmaengine: xilinx: dma: remove arch dependency
Date:   Wed, 10 May 2023 06:04:21 +0000
Message-Id: <20230510060421.30982-1-zong.li@sifive.com>
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

'e8b6c54f6d57 ("net: xilinx: temac: Relax Kconfig dependencies")'
'd7eaf962a90b ("net: axienet: In kconfig remove arch dependency for axi_emac")'

Signed-off-by: Zong Li <zong.li@sifive.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Suggested-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---

 Changes in v2:
 - Remove ARCH dependency list instead of adding new ARCH

 drivers/dma/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f5f422f9b850..daf20600a167 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -696,7 +696,6 @@ config XGENE_DMA
 
 config XILINX_DMA
 	tristate "Xilinx AXI DMAS Engine"
-	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
 	select DMA_ENGINE
 	help
 	  Enable support for Xilinx AXI VDMA Soft IP.
-- 
2.17.1

