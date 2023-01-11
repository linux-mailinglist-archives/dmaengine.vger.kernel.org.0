Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AF7665B32
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jan 2023 13:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjAKMQw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Jan 2023 07:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjAKMQv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Jan 2023 07:16:51 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CE9C23;
        Wed, 11 Jan 2023 04:16:50 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id tz12so36345751ejc.9;
        Wed, 11 Jan 2023 04:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x08Spm0bFRozqdUSVPHwNKzOpA8X+ZTZMfsdSpNIew8=;
        b=gmzED7m26SVu62/36L9vOG7cnDA1WZFYKNMJcZFjMtVD1a3+BT+eo1FqfL2AydigOA
         Khq6LZnEqFVPFw3mJIppspw8UURfTv/eQdSaX+CpW6f7vsK2ZkCaJBv3bx7XWgndFa+I
         1Fubr71+EIuegTp5xHO/M3LoY7+nIy1heZGTAllQGbVxAWytV8Dfi9dNFmZPFdfQ28w/
         7C045XLBZFPTzdwH+q0jPIbSbklXAThKjAe9cP+QDvuXzHWpL/yXyUwUZ7fawV3imWMU
         LuLBdCv7rleGsnILFEHKI79bTovseiCOIX5ZjbdniodVE9Th9FWWPygmvffoOzlsyq9C
         uaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x08Spm0bFRozqdUSVPHwNKzOpA8X+ZTZMfsdSpNIew8=;
        b=z8VkLXxGnla6Q1rCV8dk4UaxOh6d11iaHv03hXwzIr9aVnvt1YftWep3lLXVi0FQXY
         QvNL9EsyiBwKoJ404TRRbgdQa7Lr84F/6RQWD8zpHV2IRPFtVJebhZzPSr02PVArdWR/
         b5Nk2ONoFJN6F+ZWNk9qmKxC7ZIPNiVnNPQRd19jTY0qmnCHLMTa3tHcTEFEH1oOfYu2
         qqne0YoAoIfF9VxfoY3ngG40iUUvSt+/t7H0hy94fosNGkUT7MG/E9u/RgLnIcqpwvWh
         qtdoX4baXV7S1t5EtkF3Ap3SgW5Lv9P+xgs4uP5Hj1Q5MSZkdobod4FXmoE7qEDjCIBr
         kabw==
X-Gm-Message-State: AFqh2kpGXZ7e77vpdwC+yCZu3wvT1feYUeUwRetie0VejqX736T2K1Ww
        rHOzIiNfVQ3HGHlMv/gtfNQ=
X-Google-Smtp-Source: AMrXdXtjR0szQ3pFuXAK6UjOEQnmp0MSIjHr7ekMU60R+xKNEQzmKTjmedz7qHq/iBti5BxXSYVvUw==
X-Received: by 2002:a17:907:a508:b0:7c1:539b:d028 with SMTP id vr8-20020a170907a50800b007c1539bd028mr62112760ejc.48.1673439408769;
        Wed, 11 Jan 2023 04:16:48 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a47e:7f3e:6b25:bafb])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090676c100b007c0d4d3a0c1sm6148208ejn.32.2023.01.11.04.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 04:16:48 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] dmaengine: dw-edma: remove redundant config PCI dependency for some Synopsys DesignWare eDMA driver configs
Date:   Wed, 11 Jan 2023 13:16:37 +0100
Message-Id: <20230111121637.24708-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

While reviewing dependencies in some Kconfig files, I noticed the redundant
dependency "depends on PCI && PCI_MSI". The config PCI_MSI has always,
since its introduction, been dependent on the config PCI. So, it is
sufficient to just depend on PCI_MSI, and know that the dependency on PCI
is implicitly implied.

Reduce the dependencies of configs DW_EDMA and DW_EDMA_PCIE.
No functional change and effective change of Kconfig dependendencies.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/dma/dw-edma/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
index 7ff17b2db6a1..0408e515b2f3 100644
--- a/drivers/dma/dw-edma/Kconfig
+++ b/drivers/dma/dw-edma/Kconfig
@@ -2,7 +2,7 @@
 
 config DW_EDMA
 	tristate "Synopsys DesignWare eDMA controller driver"
-	depends on PCI && PCI_MSI
+	depends on PCI_MSI
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -11,7 +11,7 @@ config DW_EDMA
 
 config DW_EDMA_PCIE
 	tristate "Synopsys DesignWare eDMA PCIe driver"
-	depends on PCI && PCI_MSI
+	depends on PCI_MSI
 	select DW_EDMA
 	help
 	  Provides a glue-logic between the Synopsys DesignWare
-- 
2.17.1

