Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7F0F6D77
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 05:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfKKEHw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Nov 2019 23:07:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfKKEHw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 10 Nov 2019 23:07:52 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEB86206BB;
        Mon, 11 Nov 2019 04:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573445271;
        bh=0sFiDQ1Ua0cntLXmApw+pNgbF+rKtXJ5SSDn5ybn9FU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4jJ40N9GFXb0NQusGBdTcO5gkD517TNBKxqR5jaqNit19nmZKb/coqEswEfbdjiR
         GD2wyY6NdpPxOdCulUjESDGAQMJOaF3HcF6MgWEsa/aa+odZGFfcARZJ1Iv0KTKiEN
         TfB+vggW+N199oO82dWSZJftkJU4MLLjk+ePZ9wo=
Date:   Mon, 11 Nov 2019 09:37:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 01/15] bindings: soc: ti: add documentation for k3
 ringacc
Message-ID: <20191111040747.GJ952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101084135.14811-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-11-19, 10:41, Peter Ujfalusi wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
> enable straightforward passing of work between a producer and a consumer.
> There is one RINGACC module per NAVSS on TI AM65x and j721e.
> 
> This patch introduces RINGACC device tree bindings.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/soc/ti/k3-ringacc.txt | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
> new file mode 100644
> index 000000000000..86954cf4fa99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
> @@ -0,0 +1,59 @@
> +* Texas Instruments K3 NavigatorSS Ring Accelerator
> +
> +The Ring Accelerator (RA) is a machine which converts read/write accesses
> +from/to a constant address into corresponding read/write accesses from/to a
> +circular data structure in memory. The RA eliminates the need for each DMA
> +controller which needs to access ring elements from having to know the current
> +state of the ring (base address, current offset). The DMA controller
> +performs a read or write access to a specific address range (which maps to the
> +source interface on the RA) and the RA replaces the address for the transaction
> +with a new address which corresponds to the head or tail element of the ring
> +(head for reads, tail for writes).
> +
> +The Ring Accelerator is a hardware module that is responsible for accelerating
> +management of the packet queues. The K3 SoCs can have more than one RA instances
> +
> +Required properties:
> +- compatible	: Must be "ti,am654-navss-ringacc";
> +- reg		: Should contain register location and length of the following
> +		  named register regions.
> +- reg-names	: should be
> +		  "rt" - The RA Ring Real-time Control/Status Registers
> +		  "fifos" - The RA Queues Registers
> +		  "proxy_gcfg" - The RA Proxy Global Config Registers
> +		  "proxy_target" - The RA Proxy Datapath Registers
> +- ti,num-rings	: Number of rings supported by RA
> +- ti,sci-rm-range-gp-rings : TI-SCI RM subtype for GP ring range
> +- ti,sci	: phandle on TI-SCI compatible System controller node
> +- ti,sci-dev-id	: TI-SCI device id
> +- msi-parent	: phandle for "ti,sci-inta" interrupt controller
> +
> +Optional properties:
> + -- ti,dma-ring-reset-quirk : enable ringacc / udma ring state interoperability
> +		  issue software w/a
> +
> +Example:
> +
> +ringacc: ringacc@3c000000 {
> +	compatible = "ti,am654-navss-ringacc";
> +	reg =	<0x0 0x3c000000 0x0 0x400000>,
> +		<0x0 0x38000000 0x0 0x400000>,
> +		<0x0 0x31120000 0x0 0x100>,
> +		<0x0 0x33000000 0x0 0x40000>;
> +	reg-names = "rt", "fifos",
> +		    "proxy_gcfg", "proxy_target";
> +	ti,num-rings = <818>;
> +	ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
> +	ti,dma-ring-reset-quirk;
> +	ti,sci = <&dmsc>;
> +	ti,sci-dev-id = <187>;

why do we need dev-id for? doesn't phandle the line above help?

-- 
~Vinod
