Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222DA6EEF7D
	for <lists+dmaengine@lfdr.de>; Wed, 26 Apr 2023 09:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbjDZHnD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Apr 2023 03:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbjDZHnA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Apr 2023 03:43:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AACA35A1
        for <dmaengine@vger.kernel.org>; Wed, 26 Apr 2023 00:42:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso8051450b3a.1
        for <dmaengine@vger.kernel.org>; Wed, 26 Apr 2023 00:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1682494972; x=1685086972;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C36X7PBYU803ZQK1FU7eiGRzdw+WQCze/9eRJF/8+00=;
        b=IC6fDc25yro72PytcOu2G5j5Th/XQhlmGVC7qt0vdjRonXlE2ITrOMTDVanbbihTUw
         QiF5Ga3RYOoEUcJKU0w4zcYFbeichVNo4BQm8/h6ReDxlBLuSV2dG4LcoOI/Xcc6tB9A
         K6L54zLAUkOEOpxAg9rKLi6Iul/xc2jxU2KAl7NZUNvhG4/sFPnjBQE7aiNr5tZ8qTve
         43NafeZIVgk9i+kKCHiH6MlfKeeHpMd5u2Mg1z6DSzVM0vhwcdqbwff5N+RwRv+5o/cs
         +/pL2IU4IO2mKZTpwdqiO3M/zMUDqRiZMGcJCHqJC9WSWWQ6F77n541PSrg4yElaoJe6
         +O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682494972; x=1685086972;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C36X7PBYU803ZQK1FU7eiGRzdw+WQCze/9eRJF/8+00=;
        b=XADvgGpRG7jKxjAsw3Mc4A8n+8y6uM7AVmc7MHkEWOW+VaV+fMMktvRMFdsIhj+hxs
         CZxTkxa4sYrjZ09jiso6SHqMWlBr159gQo/ZblEuNmSkqfUUW1VB6ug+3W00nMQ1YU/z
         WBgmIZgciiVWjlm/fiMYxmue8PFI8wy0uNWAMVM981R+oRUTa9WOsB9KoBdaKOxkZnoi
         VBygsV9f3A9F2WHVhdxEL5ow04mqMZn6jdjtRlipSA/ho8qaqRR820R9nSbZ8vDRv3d2
         grYywKAr0/nwnxQwsAUUUYukC98gkTCY2jGcJzniC+NHrK7dw1jMeJOuIOYo9EIXj7s8
         mUZw==
X-Gm-Message-State: AC+VfDwMuNUln4E8q/w6K4DCCrHlqTaxSfYZiMXmMgZDPa4nfPnH2gVK
        D6PfEXYVm9nZrHgC8bZpNJ1iKx0pQONlWrwqRFM=
X-Google-Smtp-Source: ACHHUZ4D2vDCrmJ2H7aGL62FLepGOi1jInGTMSrOY+khvgUtHZ9aO+t5I6MNSceK+7VemRURbUxpBQ==
X-Received: by 2002:a05:6a00:10d4:b0:640:f519:e1cc with SMTP id d20-20020a056a0010d400b00640f519e1ccmr3521646pfu.34.1682494971956;
        Wed, 26 Apr 2023 00:42:51 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 123-20020a621881000000b00627df85cd72sm10384179pfy.199.2023.04.26.00.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 00:42:51 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH] dmaengine: xilinx: enable on RISC-V platform
Date:   Wed, 26 Apr 2023 07:42:48 +0000
Message-Id: <20230426074248.19336-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enable the xilinx dmaengine driver on RISC-V platform. We have verified
the CDMA on RISC-V platform, enable this configuration to allow build on
RISC-V.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index fb7073fc034f..816f619804b9 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -695,7 +695,7 @@ config XGENE_DMA
 
 config XILINX_DMA
 	tristate "Xilinx AXI DMAS Engine"
-	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
+	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64 || RISCV)
 	select DMA_ENGINE
 	help
 	  Enable support for Xilinx AXI VDMA Soft IP.
-- 
2.17.1

