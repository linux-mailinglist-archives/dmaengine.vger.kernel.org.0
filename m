Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8233C1E63AD
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 16:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391068AbgE1OV4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 10:21:56 -0400
Received: from foss.arm.com ([217.140.110.172]:53386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390958AbgE1OVy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 May 2020 10:21:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81A5FD6E;
        Thu, 28 May 2020 07:21:53 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 682B73F52E;
        Thu, 28 May 2020 07:21:51 -0700 (PDT)
Date:   Thu, 28 May 2020 15:21:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 0/8] R8A7742 add support for HSUSB and USB2.0/3.0
Message-ID: <20200528142139.GA28290@e121166-lin.cambridge.arm.com>
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, May 24, 2020 at 10:37:49PM +0100, Lad Prabhakar wrote:
> Hi All,
> 
> This patch series adds support for HSUSB, USB2.0 and USB3.0 to
> R8A7742 SoC DT.
> 
> This patch series applies on-top of [1].
> 
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=288491

I think Geert will pull this series, so I'd drop it from the PCI
patchwork unless there is a reason I should not, please let me know.

Thanks,
Lorenzo

> Cheers,
> Prabhakar
> 
> Lad Prabhakar (8):
>   dt-bindings: phy: rcar-gen2: Add r8a7742 support
>   dt-bindings: PCI: pci-rcar-gen2: Add device tree support for r8a7742
>   dt-bindings: usb: renesas,usbhs: Add support for r8a7742
>   dt-bindings: dmaengine: renesas,usb-dmac: Add binding for r8a7742
>   dt-bindings: usb: usb-xhci: Document r8a7742 support
>   ARM: dts: r8a7742: Add USB 2.0 host support
>   ARM: dts: r8a7742: Add USB-DMAC and HSUSB device nodes
>   ARM: dts: r8a7742: Add xhci support
> 
>  .../devicetree/bindings/dma/renesas,usb-dmac.yaml  |   1 +
>  .../devicetree/bindings/pci/pci-rcar-gen2.txt      |   3 +-
>  .../devicetree/bindings/phy/rcar-gen2-phy.txt      |   3 +-
>  .../devicetree/bindings/usb/renesas,usbhs.yaml     |   1 +
>  Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
>  arch/arm/boot/dts/r8a7742.dtsi                     | 173 +++++++++++++++++++++
>  6 files changed, 180 insertions(+), 2 deletions(-)
> 
> -- 
> 2.7.4
> 
