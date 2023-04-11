Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7B6DD051
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 05:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjDKDjw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Apr 2023 23:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDKDjv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Apr 2023 23:39:51 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD5081BE8;
        Mon, 10 Apr 2023 20:39:47 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id CB160E0EA0;
        Tue, 11 Apr 2023 06:39:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:message-id
        :mime-version:reply-to:subject:subject:to:to; s=post; bh=zZAF0YP
        BJJVREHJhe0odNvYpu6+XVnVCA/2Yzt0O8vg=; b=o1Oa5rjPTfyHs6BTc8Vca5/
        rn14pl4vjmRiZfRgne56meDy51WvjpZ4M7Da4BN8aP0UpaXHdt4gNS8Ukykfm9WC
        qnInxZMbeGmIfbCC/4Fas/R+/HBXtMDrFNfJZexIiC9ZUXYnynpiaG5zXRKQrZZx
        DBh8bReyAwGEzQG2PRbs=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id AE9EFE0E6A;
        Tue, 11 Apr 2023 06:39:44 +0300 (MSK)
Received: from localhost (10.8.30.38) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Apr 2023 06:39:44 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 00/10] PCI: dwc: Relatively simple fixes and cleanups
Date:   Tue, 11 Apr 2023 06:39:18 +0300
Message-ID: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.38]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It turns out the recent DW PCIe-related patchset was merged in with
several relatively trivial issues left unsettled (noted by Bjorn and
Manivannan). All of these lefovers have been fixed in this patchset.
Namely the series starts with two bug-fixes. The first one concerns the
improper link-mode initialization in case if the CDM-check is enabled. The
second unfortunate mistake I made in the IP-core version type helper. In
particular instead of testing the IP-core version type the macro function
referred to the just IP-core version which obviously wasn't what I
intended.

Afterwards two @Mani-noted fixes follow. Firstly the dma-ranges related warning
message is fixed to start with "DMA-ranges" word instead of "Dma-ranges".
Secondly the Baikal-T1 PCIe Host driver is converted to perform the
asynchronous probe type which saved us of about 15% of bootup time if no any
PCIe peripheral device attached to the port.

Then the patchset contains the Baikal-T1 PCIe driver fix. The
corresponding patch removes the false error message printed during the
controller probe procedure. I accidentally added the unconditional
dev_err_probe() method invocation. It was obviously wrong.

Then two trivial cleanups are introduced. The first one concerns the
duplicated fast-link-mode flag unsetting. The second one implies
dropping a redundant empty line from the dw_pcie_link_set_max_speed()
function.

The series continues with a patch inspired by the last @Bjorn note
regarding the generic resources request interface. As @Bjorn correctly
said it would be nice to have the new interface used wider in the DW PCIe
subsystem. Aside with the Baikal-T1 PCIe Host driver the Toshiba Visconti
PCIe driver can be easily converted to using the generic clock names.
That's what is done in the noted patch.

The patchset is closed with a series of MAINTAINERS-list related patches.
Firstly after getting the DW PCIe RP/EP DT-schemas refactored I forgot to
update the MAINTAINER-list with the new files added in the framework of
that procedure. All the snps,dw-pcie* schemas shall be maintained by the
DW PCIe core driver maintainers. Secondly seeing how long it took for my
patchsets to review and not having any comments from the original driver
maintainers I'd suggest to add myself as the reviewer to the DW PCIe and
eDMA drivers. Thus hopefully the new updates review process will be
performed with much less latencies. For the same reason I would also like
to suggest to add @Manivannan as the DW PCIe/eDMA drivers maintainer if
he isn't against that idea. What do you think about the last suggestion?

Link: https://lore.kernel.org/linux-pci/20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Rebase onto the kernel 6.3-rc2.

Link: https://lore.kernel.org/linux-pci/20230313200816.30105-1-Sergey.Semin@baikalelectronics.ru/
Changelog v3:
- Drop the patch:
  [PATCH v2 01/11] PCI: dwc: Fix port link CSR improper init if CDM check enabled
  and rebase onto the already submitted by @Yoshihiro fix:
  commit cdce67099117 ("PCI: dwc: Fix PORT_LINK_CONTROL update when CDM check enabled")
- Just resend.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: linux-pci@vger.kernel.org
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (10):
  PCI: dwc: Fix erroneous version type test helper
  PCI: dwc: Fix inbound iATU entries out-of-bounds warning message
  PCI: bt1: Enable async probe type
  PCI: bt1: Fix printing false error message
  PCI: dwc: Drop duplicated fast-link-mode flag unsetting
  PCI: dwc: Drop empty line from dw_pcie_link_set_max_speed()
  PCI: visconti: Convert to using generic resources getter
  MAINTAINERS: Add all generic DW PCIe RP/EP DT-schemas
  MAINTAINERS: Add myself as the DW PCIe core reviewer
  MAINTAINERS: Add myself as the DW eDMA driver reviewer

 MAINTAINERS                                   |  5 ++-
 drivers/pci/controller/dwc/pcie-bt1.c         |  5 ++-
 .../pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c  |  2 -
 drivers/pci/controller/dwc/pcie-designware.h  |  7 +++-
 drivers/pci/controller/dwc/pcie-visconti.c    | 37 +++++++++----------
 6 files changed, 30 insertions(+), 28 deletions(-)

-- 
2.40.0


