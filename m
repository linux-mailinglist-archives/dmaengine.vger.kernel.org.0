Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5B2129209
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 07:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfLWGxs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 01:53:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWGxs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Dec 2019 01:53:48 -0500
Received: from localhost (unknown [223.226.34.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 074DA20663;
        Mon, 23 Dec 2019 06:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577084027;
        bh=E9GtJEv5/Wg7wYSZvBrnuOFI6hszhwu0cq6AppC+9qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+LXOHERLq+MKBHwX9oReM+7sdw6pEx/s6vS7PyfqPzKYep06rK5pIlC4m4Gducuq
         mfX/7Cw8wMCBSF3tMP0UEiWULBiZ9nz6f8dnC78zuo278yvLszzyY+2EtyXWQLq6Jg
         n5kwc14VXmG8ht7j0M596/8/bNi+j4Ai7rEbaEIw=
Date:   Mon, 23 Dec 2019 12:23:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v7 08/12] dt-bindings: dma: ti: Add document for K3 UDMA
Message-ID: <20191223065340.GU2536@vkoul-mobl>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-9-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191209094332.4047-9-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-12-19, 11:43, Peter Ujfalusi wrote:
> New binding document for
> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).
> 
> UDMA-P is introduced as part of the K3 architecture and can be found in
> AM654 and j721e.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/dma/ti/k3-udma.yaml   | 185 ++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> new file mode 100644
> index 000000000000..77aef4a4abce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> @@ -0,0 +1,185 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/ti/k3-udma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 NAVSS Unified DMA Device Tree Bindings
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@ti.com>
> +
> +description: |
> +  The UDMA-P is intended to perform similar (but significantly upgraded)
> +  functions as the packet-oriented DMA used on previous SoC devices. The UDMA-P
> +  module supports the transmission and reception of various packet types.
> +  The UDMA-P is architected to facilitate the segmentation and reassembly of

How about:

The UDMA-P architecture facilitates the segmentation...

> +  SoC DMA data structure compliant packets to/from smaller data blocks that are
> +  natively compatible with the specific requirements of each connected
> +  peripheral.
> +  Multiple Tx and Rx channels are provided within the DMA which allow multiple
> +  segmentation or reassembly operations to be ongoing. The DMA controller
> +  maintains state information for each of the channels which allows packet
> +  segmentation and reassembly operations to be time division multiplexed between
> +  channels in order to share the underlying DMA hardware. An external DMA
> +  scheduler is used to control the ordering and rate at which this multiplexing
> +  occurs for Transmit operations. The ordering and rate of Receive operations
> +  is indirectly controlled by the order in which blocks are pushed into the DMA
> +  on the Rx PSI-L interface.
> +
> +  The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
> +  channels. Channels in the UDMA-P can be configured to be either Packet-Based
> +  or Third-Party channels on a channel by channel basis.
> +
> +  All transfers within NAVSS is done between PSI-L source and destination
> +  threads.
> +  The peripherals serviced by UDMA can be PSI-L native (sa2ul, cpsw, etc) or
> +  legacy, non PSI-L native peripherals. In the later case a special, small PDMA
> +  is tasked to act as a bridge between the PSI-L fabric and the legacy
> +  peripheral.
> +
> +  PDMAs can be configured via UDMAP peer registers to match with the
> +  configuration of the legacy peripheral.
> +
> +allOf:
> +  - $ref: "../dma-controller.yaml#"
> +
> +properties:
> +  "#dma-cells":
> +    const: 1
> +    description: |
> +      The cell is the PSI-L  thread ID of the remote (to UDMAP) end.
> +      Valid ranges for thread ID depends on the data movement direction:
> +      for source thread IDs (rx): 0 - 0x7fff
> +      for destination thread IDs (tx): 0x8000 - 0xffff
> +
> +      PLease refer to the device documentation for the PSI-L thread map and also

s/PLease/Please

-- 
~Vinod
