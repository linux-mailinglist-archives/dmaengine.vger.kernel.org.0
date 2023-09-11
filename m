Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA89379B2CF
	for <lists+dmaengine@lfdr.de>; Tue, 12 Sep 2023 01:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbjIKWmt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Sep 2023 18:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241254AbjIKPFJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Sep 2023 11:05:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28B1B9;
        Mon, 11 Sep 2023 08:05:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57F0C433C8;
        Mon, 11 Sep 2023 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444705;
        bh=Eke6vzY+4rv3Xy5ZQ8sgEBGPJaRRvS9QwFVpXs9ynYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mR1j40N6Mo/GBUimiWdSGuTRNfX86PhlDozup+mk7Y0A2Yn6Mnb6N0jVvXLHuuIOs
         qjBChOPcqdJjyQitFKq3pQTfGhs1KS/xnada9elSfQazJqs5Ro3+WPgcnEkUraGY8D
         9aLQdRb2h9IiM1q0UeNCqkpV6LcFDE/2zP9kOAlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Baoquan He <bhe@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 056/600] idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM
Date:   Mon, 11 Sep 2023 15:41:29 +0200
Message-ID: <20230911134635.279688322@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index b64ae02c26f8c..81de833ccd041 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -210,6 +210,7 @@ config FSL_DMA
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
 	depends on OF
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -279,6 +280,7 @@ config IMX_SDMA
 
 config INTEL_IDMA64
 	tristate "Intel integrated DMA 64-bit support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.40.1



