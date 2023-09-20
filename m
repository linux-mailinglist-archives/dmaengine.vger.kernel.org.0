Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A57A7F4E
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 14:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbjITM0J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 08:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbjITM0I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 08:26:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B11F5;
        Wed, 20 Sep 2023 05:25:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DB3C433C9;
        Wed, 20 Sep 2023 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212758;
        bh=/7DZwf++jm59zEseY94YhE8v0F+HIhd9KM0w4OPzbgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZnIg8CZHSVBNT2gSvw/Rk1NjB3KhzrwSURo8hjG8hwkf4a90+XmTfUWK23+3PqBh
         XVJUI6eYO3dh6F1nO+bDR7WjZZkjmONptXrnDN3l8L8k9rs5pNuW8LWGY5nwrzlJR3
         P/sw17jOFGAxRtzIt9cQ6qywswydtVt8C2mL+WWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Baoquan He <bhe@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 034/367] idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM
Date:   Wed, 20 Sep 2023 13:26:51 +0200
Message-ID: <20230920112859.393542017@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 1322461f1f3c5..66aad9dbd58c5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -208,6 +208,7 @@ config FSL_DMA
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
 	depends on OF
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -268,6 +269,7 @@ config IMX_SDMA
 
 config INTEL_IDMA64
 	tristate "Intel integrated DMA 64-bit support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.40.1



