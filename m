Return-Path: <dmaengine+bounces-4275-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E46A27C6E
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 21:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030313A3191
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 20:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89EA2163AF;
	Tue,  4 Feb 2025 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATqxfuIi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FC14B094;
	Tue,  4 Feb 2025 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699499; cv=none; b=ikzxlCo5P5d2rydWolcUF+zZVUgmvmVqSfEsw+43hsiADjjFiAAjP1y6+O4HLqpgyTef9tTH9Km4poDYLK3IGmLgqZVDFLeo6H3KHkC1WgUshDKOyahH13FsfDY3xiZlesqK0zl0VUDkpR2t8JJXp+YBOgiM0yDw5aEKy1snNY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699499; c=relaxed/simple;
	bh=6y3E8+OpE5ZmqjX7Om9uPkD+ZQQXyu1GMUrqnd3TjQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHa0/pwhn3IvK/N+IniLqc3WgNTcsXkpHQ+K62FGBmNpOU2fEZscyZz7zjSeWhQNQ2LXupQMlOTifcH+xqdvSFe2J9TWiO5eOTnD6OOH0PH7a1mqpIpOA0HHsutsAqfA6KwM2/k9flKcoAbTCoU/LOpaGO8MK7PX1JcpuQGPcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATqxfuIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF3FC4CEE2;
	Tue,  4 Feb 2025 20:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699499;
	bh=6y3E8+OpE5ZmqjX7Om9uPkD+ZQQXyu1GMUrqnd3TjQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ATqxfuIih0h8cjA2h0bfzeW8/14cKwjo0aYg/EDyMiNfuHEuMgbIUArMXwpxbH8tQ
	 Da4cVQL4P8+pftQUNXCfpHfx7R/c8T5y9fXpFVdrQBkPwgdoDHoEsw5o2N/iwNbzt8
	 snOmZS5hwa+n4hlL3owOGHovG/7gC5BR91zkSxLubTB/2goLFqeTbHt28F5FnmdKY4
	 hCflsbEgNgW4l3dpav/XeOnh8UfB9jdhSJ/P2ICbj8kqOcpTDEmCzBb1u2EZeyPCm/
	 PCiZB/g/1ohi/zf1NFeXq1TtDI49Zm/hGspFF4kYcp0temKz7YcZ9Fx3qzuE1DJICk
	 QRfqRdleBGwGQ==
Date: Tue, 4 Feb 2025 20:04:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
 <michal.simek@xilinx.com>, <git@xilinx.com>, Anand Ashok Dumbre
 <anand.ashok.dumbre@xilinx.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, "Conor Dooley"
 <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Harini Katakam
 <harini.katakam@amd.com>, Jakub Kicinski <kuba@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>,
 Mark Brown <broonie@kernel.org>, Michael Tretter
 <m.tretter@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>,
 Mubin Sayyed <mubin.sayyed@amd.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Niklas Cassel <cassel@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Stephen Boyd <sboyd@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "open list:DMA GENERIC OFFLOAD
 ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:COMMON CLK
 FRAMEWORK" <linux-clk@vger.kernel.org>, "open list:LIBATA SUBSYSTEM (Serial
 and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, "open list:XILINX
 AMS DRIVER" <linux-iio@vger.kernel.org>, "open list:SPI SUBSYSTEM"
 <linux-spi@vger.kernel.org>, "open list:USB SUBSYSTEM"
 <linux-usb@vger.kernel.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: xilinx: Deprecate header with firmware
 constants
Message-ID: <20250204200446.32bfb3f8@jic23-huawei>
In-Reply-To: <2a6f0229522327939e6893565e540b75f854a37b.1738600745.git.michal.simek@amd.com>
References: <cover.1738600745.git.michal.simek@amd.com>
	<2a6f0229522327939e6893565e540b75f854a37b.1738600745.git.michal.simek@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 17:39:11 +0100
Michal Simek <michal.simek@amd.com> wrote:

> Firmware contants do not fit the purpose of bindings because they are not
> independent IDs for abstractions. They are more or less just contants which
> better to wire via header with DT which is using it.
> That's why add deprecated message to dt binding header and also update
> existing dt bindings not to use macros from the header  and replace them by
> it's value. Actually value is not relevant because it is only example.
> 
> The similar changes have been done by commit 9d9292576810 ("dt-bindings:
> pinctrl: samsung: deprecate header with register constants").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
For IIO
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> 
>  Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml  | 4 +---
>  .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml           | 3 +--
>  .../devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml       | 3 +--
>  Documentation/devicetree/bindings/net/cdns,macb.yaml       | 7 +++----
>  Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 3 +--
>  Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml     | 3 +--
>  include/dt-bindings/clock/xlnx-zynqmp-clk.h                | 7 +++++++
>  7 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> index 9952e0ef7767..6ad78429dc74 100644
> --- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> +++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> @@ -163,11 +163,9 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/power/xlnx-zynqmp-power.h>
>      #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
> -    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>      #include <dt-bindings/phy/phy.h>
>  
>      sata: ahci@fd0c0000 {
> @@ -175,7 +173,7 @@ examples:
>          reg = <0xfd0c0000 0x200>;
>          interrupt-parent = <&gic>;
>          interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
> -        clocks = <&zynqmp_clk SATA_REF>;
> +        clocks = <&zynqmp_clk 22>;
>          ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
>          ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
>          ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> index ac3198953b8e..b5399c65a731 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> @@ -75,7 +75,6 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>  
>      fpd_dma_chan1: dma-controller@fd500000 {
>        compatible = "xlnx,zynqmp-dma-1.0";
> @@ -84,7 +83,7 @@ examples:
>        interrupts = <0 117 0x4>;
>        #dma-cells = <1>;
>        clock-names = "clk_main", "clk_apb";
> -      clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +      clocks = <&zynqmp_clk 19>, <&zynqmp_clk 31>;
>        xlnx,bus-width = <128>;
>        dma-coherent;
>      };
> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> index 8cbad7e792b6..a403392fb263 100644
> --- a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> @@ -193,7 +193,6 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>  
>      bus {
>          #address-cells = <2>;
> @@ -204,7 +203,7 @@ examples:
>              interrupt-parent = <&gic>;
>              interrupts = <0 56 4>;
>              reg = <0x0 0xffa50000 0x0 0x800>;
> -            clocks = <&zynqmp_clk AMS_REF>;
> +            clocks = <&zynqmp_clk 70>;
>              #address-cells = <1>;
>              #size-cells = <1>;
>              #io-channel-cells = <1>;
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> index 3c30dd23cd4e..8d69846b2e09 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -197,7 +197,6 @@ examples:
>      };
>  
>    - |
> -    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>      #include <dt-bindings/power/xlnx-zynqmp-power.h>
>      #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>      #include <dt-bindings/phy/phy.h>
> @@ -210,9 +209,9 @@ examples:
>                      interrupt-parent = <&gic>;
>                      interrupts = <0 59 4>, <0 59 4>;
>                      reg = <0x0 0xff0c0000 0x0 0x1000>;
> -                    clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
> -                             <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
> -                             <&zynqmp_clk GEM_TSU>;
> +                    clocks = <&zynqmp_clk 31>, <&zynqmp_clk 105>,
> +                             <&zynqmp_clk 51>, <&zynqmp_clk 50>,
> +                             <&zynqmp_clk 44>;
>                      clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>                      #address-cells = <1>;
>                      #size-cells = <0>;
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> index 04d4d3b4916d..02cf1314367b 100644
> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> @@ -65,14 +65,13 @@ allOf:
>  
>  examples:
>    - |
> -    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>      soc {
>        #address-cells = <2>;
>        #size-cells = <2>;
>  
>        qspi: spi@ff0f0000 {
>          compatible = "xlnx,zynqmp-qspi-1.0";
> -        clocks = <&zynqmp_clk QSPI_REF>, <&zynqmp_clk LPD_LSBUS>;
> +        clocks = <&zynqmp_clk 53>, <&zynqmp_clk 82>;
>          clock-names = "ref_clk", "pclk";
>          interrupts = <0 15 4>;
>          interrupt-parent = <&gic>;
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> index 00f87a558c7d..b5843f4d17d8 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> @@ -101,7 +101,6 @@ examples:
>      #include <dt-bindings/dma/xlnx-zynqmp-dpdma.h>
>      #include <dt-bindings/power/xlnx-zynqmp-power.h>
>      #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
> -    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>      #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>      #include <dt-bindings/phy/phy.h>
>      axi {
> @@ -113,7 +112,7 @@ examples:
>              #size-cells = <0x2>;
>              compatible = "xlnx,zynqmp-dwc3";
>              reg = <0x0 0xff9d0000 0x0 0x100>;
> -            clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
> +            clocks = <&zynqmp_clk 32>, <&zynqmp_clk 34>;
>              clock-names = "bus_clk", "ref_clk";
>              power-domains = <&zynqmp_firmware PD_USB_0>;
>              resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
> diff --git a/include/dt-bindings/clock/xlnx-zynqmp-clk.h b/include/dt-bindings/clock/xlnx-zynqmp-clk.h
> index cdc4c0b9a374..f0f7ddd3dcbd 100644
> --- a/include/dt-bindings/clock/xlnx-zynqmp-clk.h
> +++ b/include/dt-bindings/clock/xlnx-zynqmp-clk.h
> @@ -9,6 +9,13 @@
>  #ifndef _DT_BINDINGS_CLK_ZYNQMP_H
>  #define _DT_BINDINGS_CLK_ZYNQMP_H
>  
> +/*
> + * These bindings are deprecated, because they do not match the actual
> + * concept of bindings but rather contain pure firmware values.
> + * Instead include the header in the DTS source directory.
> + */
> +#warning "These bindings are deprecated. Instead use the header in the DTS source directory."
> +
>  #define IOPLL			0
>  #define RPLL			1
>  #define APLL			2


