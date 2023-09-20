Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25697A7D7F
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 14:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjITMKV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 08:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbjITMJi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 08:09:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA67B4;
        Wed, 20 Sep 2023 05:09:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9B9C433C9;
        Wed, 20 Sep 2023 12:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211771;
        bh=JI8tr7pte5E+t628ZHGwjho2Ud1OnMqWMt6YEsvtK+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZCG0wh4lppvMjkbPfZgzpnfEGg2QYwthD+PR0J7AtvOU4xQL6lPVK5n2oT0r4vAc
         dVpdNfzgXvrxcytXPb59Ng75pRx5rwRaaB8tJUwO1vbY+3/bIwKuE5j5gE5tPgzCOO
         mRGFYDY4vOH2pqtbVhePz23dwhHyYU6ecKxpy0lk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Baoquan He <bhe@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/273] idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM
Date:   Wed, 20 Sep 2023 13:27:49 +0200
Message-ID: <20230920112847.325167339@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index e5f31af65aabf..00e1ffa4fcf1c 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -212,6 +212,7 @@ config FSL_DMA
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
 	depends on OF
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -258,6 +259,7 @@ config IMX_SDMA
 
 config INTEL_IDMA64
 	tristate "Intel integrated DMA 64-bit support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.40.1



