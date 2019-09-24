Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6844BD142
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 20:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393935AbfIXSMz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 14:12:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:43946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393874AbfIXSMy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 14:12:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22E57AC93;
        Tue, 24 Sep 2019 18:12:51 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     mbrugger@suse.com, robin.murphy@arm.com, f.fainelli@gmail.com,
        james.quinlan@broadcom.com, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        freedreno@lists.freedesktop.org
Subject: [PATCH 00/11] of: Fix DMA configuration for non-DT masters
Date:   Tue, 24 Sep 2019 20:12:31 +0200
Message-Id: <20190924181244.7159-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,
this series tries to address one of the issues blocking us from
upstreaming Broadcom's STB PCIe controller[1]. Namely, the fact that
devices not represented in DT which sit behind a PCI bus fail to get the
bus' DMA addressing constraints.

This is due to the fact that of_dma_configure() assumes it's receiving a
DT node representing the device being configured, as opposed to the PCIe
bridge node we currently pass. This causes the code to directly jump
into PCI's parent node when checking for 'dma-ranges' and misses
whatever was set there.

To address this I create a new API in OF - inspired from Robin Murphys
original proposal[2] - which accepts a bus DT node as it's input in
order to configure a device's DMA constraints. The changes go deep into
of/address.c's implementation, as a device being having a DT node
assumption was pretty strong.

On top of this work, I also cleaned up of_dma_configure() removing its
redundant arguments and creating an alternative function for the special cases
not applicable to either the above case or the default usage.

IMO the resulting functions are more explicit. They will probably
surface some hacky usages that can be properly fixed as I show with the
DT fixes on the Layerscape platform.

This was also tested on a Raspberry Pi 4 with a custom PCIe driver and
on a Seattle AMD board.

Regards,
Nicolas

[1] https://patchwork.kernel.org/patch/9650345/#20294961
[2] https://patchwork.kernel.org/patch/9650345/

---

Nicolas Saenz Julienne (11):
  of: address: clean-up unused variable in of_dma_get_range()
  of: base: introduce __of_n_*_cells_parent()
  of: address: use parent DT node in bus->count_cells()
  of: address: introduce of_translate_dma_address_parent()
  of: expose __of_get_dma_parent() to OF subsystem
  of: address: use parent OF node in of_dma_get_range()
  dts: arm64: layerscape: add dma-ranges property to qoric-mc node
  dts: arm64: layerscape: add dma-ranges property to pcie nodes
  of: device: remove comment in of_dma_configure()
  of: device: introduce of_dma_configure_parent()
  of: simplify of_dma_config()'s arguments

 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   1 +
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |   5 +
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   1 +
 drivers/base/platform.c                       |   2 +-
 drivers/bcma/main.c                           |   2 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c               |   2 +-
 drivers/dma/qcom/hidma_mgmt.c                 |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c         |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c         |   2 +-
 drivers/gpu/drm/xen/xen_drm_front.c           |   2 +-
 drivers/gpu/host1x/bus.c                      |   4 +-
 drivers/media/platform/qcom/venus/firmware.c  |   2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc.c      |   2 +-
 drivers/of/address.c                          | 136 +++++++++---------
 drivers/of/base.c                             |  69 +++++++--
 drivers/of/device.c                           |  59 +++++++-
 drivers/of/of_private.h                       |   5 +
 drivers/pci/pci-driver.c                      |   3 +-
 drivers/xen/gntdev.c                          |   2 +-
 include/linux/of_address.h                    |   8 +-
 include/linux/of_device.h                     |  23 ++-
 22 files changed, 223 insertions(+), 113 deletions(-)

-- 
2.23.0

