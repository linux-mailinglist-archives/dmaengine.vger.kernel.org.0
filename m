Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047CA79AFAD
	for <lists+dmaengine@lfdr.de>; Tue, 12 Sep 2023 01:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbjIKWmq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Sep 2023 18:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbjIKO3S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Sep 2023 10:29:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6FCF0;
        Mon, 11 Sep 2023 07:29:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFACC433C8;
        Mon, 11 Sep 2023 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442554;
        bh=NG2OMJlLIEzuif2bXihYX6XXVjHUq6yXGHPm68ta060=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJFYyI2b+8/157iL1i7xq4AXBNpYk5riqqQPxEKojs5uYl4FyJM1v/2NcL0z3RSV1
         q0v/8rjz+SGChcDiowsjqR60qXOEDoQPLCv2M1NN6VJce+FIqL+pnXtVrBcosMqelu
         1LpEbJEMtLMqSaIlDr5VEE5m7xD5jWtXUN6q4Isg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Baoquan He <bhe@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 058/737] idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM
Date:   Mon, 11 Sep 2023 15:38:37 +0200
Message-ID: <20230911134652.114314083@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baoquan He <bhe@redhat.com>

[ Upstream commit b1e213a9e31c20206f111ec664afcf31cbfe0dbb ]

On s390 systems (aka mainframes), it has classic channel devices for
networking and permanent storage that are currently even more common
than PCI devices. Hence it could have a fully functional s390 kernel
with CONFIG_PCI=n, then the relevant iomem mapping functions
[including ioremap(), devm_ioremap(), etc.] are not available.

Here let FSL_EDMA and INTEL_IDMA64 depend on HAS_IOMEM so that it
won't be built to cause below compiling error if PCI is unset.

--------
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/idma64.ko] undefined!
--------

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Link: https://lore.kernel.org/r/20230707135852.24292-2-bhe@redhat.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f5f422f9b8507..b6221b4432fd3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -211,6 +211,7 @@ config FSL_DMA
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
 	depends on OF
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -280,6 +281,7 @@ config IMX_SDMA
 
 config INTEL_IDMA64
 	tristate "Intel integrated DMA 64-bit support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.40.1



