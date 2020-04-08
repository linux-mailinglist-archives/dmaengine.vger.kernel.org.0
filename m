Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88681A2A10
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2020 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgDHUGP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Apr 2020 16:06:15 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:43435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgDHUGP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Apr 2020 16:06:15 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MirfI-1iqWa42OcG-00errp; Wed, 08 Apr 2020 22:06:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Vinod Koul <vkoul@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: hisilicon: fix PCI_MSI dependency
Date:   Wed,  8 Apr 2020 22:05:20 +0200
Message-Id: <20200408200559.4124238-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0AbTa57IfhQyvCnJShbn24hgYs9aVvJsSjsPKYW7LbrrrrylMnG
 +2anFV3e/XbnI0Q3UvpIaCE00ONFRUjEcBpkHJg3CqBkGxI1YNV4gn+Urvmuq3UInHWzfBx
 h6KmoDfXbRTrlMDQpCypp0sRYySmscF120IovP7BxTRcphdJJGTBwC3xjWsj4W5RyBYFxpF
 jDbtXr94P1n4NSL77NfwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJWbEVuwKdU=:v4UWQTC+x8Voy10XS6hQ+3
 H19rpa23HuiEOGju33h4iR/LCefkWYi1ZzDYMbOLb0oHk95lbS+ZOIjGGF04Dx7FsHPehqXiR
 y2T+Eb8ldrcAD+msZOCegPfzt9H+Y40CKOGiFOuEpXuMVZm2+4auBOj7MBXLfmDl4OGhHiuXd
 KpTwQ8n/lhpzPgOvcLJ2HoNZO+7JRNfqJ3H9Ibeb0GSX/PFSB7n4jndeIvv0sTWZf6MUxamdd
 lEuGVf8zGwW78Mx4jtmIt1ttZ359K/EW+Xq6EHkfRZa29hppU5KQJE9BlwWldK906kfNda2o3
 ytKpRZBRA96oPHHzAL5gqSMRXgrH5qFtEfceJnYfySM4oddMgQIMLj31MhMhJRk30BOrE0ntd
 ZLv4jRCPHXGUpEatxdjixjc98SWljuOC/3ZFvRNRncWJX04Nq/GEv3TdT/rx8HYHO/pLxaC3I
 JxCqj28aEv01y8uCUzWQRC4v0XcNI/TGG7d/a39g2QkCfGvcO8fnrCvbUGVbkfCbLozjITCB2
 nNGN228OKo6WAkUf0aDwZMGTlAHsTjtTKffVwoPhwaOpjVlyyGf65ZsGO+2wVX7OSoHyLb8dq
 NDwoJacw0X2+jJJ7lS1WoUNSUjdhAqMY3FiCcv0ErHdDl4n5hg9n5m8uITzHulhAn3rygYn+Y
 wOeSgf2vc9Hncmbxrl7IwXdRjNHipIOayhMynnPSjw3nNtR6vpCxSIQJkylZQE5aUBYj9/Rl4
 eAfJ2dMXedCCf/Oond28iYzjxnqa/ePipgfdKwaA1RrU2ZHKhb0dBrPAlz3DDIFFBlszlmPYC
 ku93/gljwUsda4fyuLT8d1GFkAerfEHSeQd6kVwg0xjj/DqzKY=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dependency is phrased incorrectly, so on arm64, it is possible
to build with CONFIG_PCI disabled, resulting a build failure:

drivers/dma/hisi_dma.c: In function 'hisi_dma_free_irq_vectors':
drivers/dma/hisi_dma.c:138:2: error: implicit declaration of function 'pci_free_irq_vectors'; did you mean 'pci_alloc_irq_vectors'? [-Werror=implicit-function-declaration]
  138 |  pci_free_irq_vectors(data);
      |  ^~~~~~~~~~~~~~~~~~~~
      |  pci_alloc_irq_vectors
drivers/dma/hisi_dma.c: At top level:
drivers/dma/hisi_dma.c:605:1: warning: data definition has no type or storage class
  605 | module_pci_driver(hisi_dma_pci_driver);
      | ^~~~~~~~~~~~~~~~~
drivers/dma/hisi_dma.c:605:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
drivers/dma/hisi_dma.c:605:1: warning: parameter names (without types) in function declaration
drivers/dma/hisi_dma.c:599:26: error: 'hisi_dma_pci_driver' defined but not used [-Werror=unused-variable]
  599 | static struct pci_driver hisi_dma_pci_driver = {

Change it so we always depend on PCI_MSI, even on ARM64

Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 98ae15c82a30..c19e25b140c5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -241,7 +241,8 @@ config FSL_RAID
 
 config HISI_DMA
 	tristate "HiSilicon DMA Engine support"
-	depends on ARM64 || (COMPILE_TEST && PCI_MSI)
+	depends on ARM64 || COMPILE_TEST
+	depends on PCI_MSI
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.26.0

