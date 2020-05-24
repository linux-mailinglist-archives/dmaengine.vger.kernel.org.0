Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058B41E033B
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2020 23:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbgEXViL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 May 2020 17:38:11 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:26877 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387879AbgEXViL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 May 2020 17:38:11 -0400
X-IronPort-AV: E=Sophos;i="5.73,430,1583161200"; 
   d="scan'208";a="47678059"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 May 2020 06:38:09 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 05AB740E3D4A;
        Mon, 25 May 2020 06:38:05 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/8] R8A7742 add support for HSUSB and USB2.0/3.0
Date:   Sun, 24 May 2020 22:37:49 +0100
Message-Id: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

This patch series adds support for HSUSB, USB2.0 and USB3.0 to
R8A7742 SoC DT.

This patch series applies on-top of [1].

[1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=288491

Cheers,
Prabhakar

Lad Prabhakar (8):
  dt-bindings: phy: rcar-gen2: Add r8a7742 support
  dt-bindings: PCI: pci-rcar-gen2: Add device tree support for r8a7742
  dt-bindings: usb: renesas,usbhs: Add support for r8a7742
  dt-bindings: dmaengine: renesas,usb-dmac: Add binding for r8a7742
  dt-bindings: usb: usb-xhci: Document r8a7742 support
  ARM: dts: r8a7742: Add USB 2.0 host support
  ARM: dts: r8a7742: Add USB-DMAC and HSUSB device nodes
  ARM: dts: r8a7742: Add xhci support

 .../devicetree/bindings/dma/renesas,usb-dmac.yaml  |   1 +
 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |   3 +-
 .../devicetree/bindings/phy/rcar-gen2-phy.txt      |   3 +-
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |   1 +
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
 arch/arm/boot/dts/r8a7742.dtsi                     | 173 +++++++++++++++++++++
 6 files changed, 180 insertions(+), 2 deletions(-)

-- 
2.7.4

