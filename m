Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5844AEE
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 20:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfFMSn1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 14:43:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34084 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfFMSn1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Jun 2019 14:43:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so65497qkt.1;
        Thu, 13 Jun 2019 11:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NcR/8SWBfRQzzMiD/zvgVxR7YrRjbw8pG/CMmNHs2cg=;
        b=YlY8eWoFM4EWnURqyiKqUeMlq3f041NgKcf1ORHxQ+9C0j0tthys3w5wG1bTeOPxXM
         4llGIoenOXcS1Vj9j6DXuH1ipPkTs3SOvfwkdn29YOjw+Vr7vOHb7KnHffeutTgrgNDc
         KC2Jn0DLZKjL2HWfRNkZNAAk89BlSJLcdv47dpMWxYjXG9LWMuiUnQa3JBVbMDwtBjlE
         IhF+w/a1svB0SJd8DvRZNjfZMTApsboitzA76CsgCk7thw8DGF3HSQZ47R3SeGbCl+/y
         Te51yGrKzE4ztcbtC41b5fqQPf7ibr3tL1Xxq8R7wKEvCOVZX/3kmObOHFtEtoXgTP+j
         vUoQ==
X-Gm-Message-State: APjAAAVGYcBHq4YgypUmvZSwUtF3qUoV2NOI3Z5FpE9LfTBgPb+cWFqS
        TTPmGm6C/AmaS/OfJBLZ4w==
X-Google-Smtp-Source: APXvYqzOykNZ+yOjvFYDrp5id4HZ0PDwD2Ol+Jy2xY+WA4FXykBA2wVI1v/kaQWi3VCgBPbrJGXj/w==
X-Received: by 2002:a37:b044:: with SMTP id z65mr71813835qke.294.1560451406096;
        Thu, 13 Jun 2019 11:43:26 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id x2sm214491qkc.92.2019.06.13.11.43.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:43:25 -0700 (PDT)
Date:   Thu, 13 Jun 2019 12:43:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com
Subject: Re: [PATCH 10/16] dmaengine: ti: New driver for K3 UDMA - split#1:
 defines, structs, io func
Message-ID: <20190613184324.GA26206@bogus>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
 <20190506123456.6777-11-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506123456.6777-11-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 06, 2019 at 03:34:50PM +0300, Peter Ujfalusi wrote:
> Split patch for review containing: defines, structs, io and low level
> functions and interrupt callbacks.

Not a useful comment for upstream.

> 
> DMA driver for
> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)
> 
> The UDMA-P is intended to perform similar (but significantly upgraded) functions
> as the packet-oriented DMA used on previous SoC devices. The UDMA-P module
> supports the transmission and reception of various packet types. The UDMA-P is
> architected to facilitate the segmentation and reassembly of SoC DMA data
> structure compliant packets to/from smaller data blocks that are natively
> compatible with the specific requirements of each connected peripheral. Multiple
> Tx and Rx channels are provided within the DMA which allow multiple segmentation
> or reassembly operations to be ongoing. The DMA controller maintains state
> information for each of the channels which allows packet segmentation and
> reassembly operations to be time division multiplexed between channels in order
> to share the underlying DMA hardware. An external DMA scheduler is used to
> control the ordering and rate at which this multiplexing occurs for Transmit
> operations. The ordering and rate of Receive operations is indirectly controlled
> by the order in which blocks are pushed into the DMA on the Rx PSI-L interface.
> 
> The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
> channels. Channels in the UDMA-P can be configured to be either Packet-Based or
> Third-Party channels on a channel by channel basis.
> 
> The initial driver supports:
> - MEM_TO_MEM (TR mode)
> - DEV_TO_MEM (Packet / TR mode)
> - MEM_TO_DEV (Packet / TR mode)
> - Cyclic (Packet / TR mode)
> - Metadata for descriptors
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c          | 1008 +++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-udma.h          |  129 ++++
>  include/dt-bindings/dma/k3-udma.h |   26 +

This belongs in the binding patch.

>  3 files changed, 1163 insertions(+)
>  create mode 100644 drivers/dma/ti/k3-udma.c
>  create mode 100644 drivers/dma/ti/k3-udma.h
>  create mode 100644 include/dt-bindings/dma/k3-udma.h

> diff --git a/include/dt-bindings/dma/k3-udma.h b/include/dt-bindings/dma/k3-udma.h
> new file mode 100644
> index 000000000000..89ba6a9d4a8f
> --- /dev/null
> +++ b/include/dt-bindings/dma/k3-udma.h
> @@ -0,0 +1,26 @@
> +#ifndef __DT_TI_UDMA_H
> +#define __DT_TI_UDMA_H
> +
> +#define UDMA_TR_MODE		0
> +#define UDMA_PKT_MODE		1
> +
> +#define UDMA_DIR_TX		0
> +#define UDMA_DIR_RX		1
> +
> +#define PSIL_STATIC_TR_NONE	0
> +#define PSIL_STATIC_TR_XY	1
> +#define PSIL_STATIC_TR_MCAN	2
> +
> +#define UDMA_PDMA_TR_XY(id)				\
> +	ti,psil-config##id {				\
> +		linux,udma-mode = <UDMA_TR_MODE>;	\
> +		statictr-type = <PSIL_STATIC_TR_XY>;	\
> +	}

We don't accept this kind of complex macros in dts files. It obfuscates 
reading dts files.

Rob
