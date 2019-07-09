Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE65637FB
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jul 2019 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfGIOek (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jul 2019 10:34:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36154 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIOek (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Jul 2019 10:34:40 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so28035685iom.3;
        Tue, 09 Jul 2019 07:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gggSfCIWVD31KwI1CzAVycXiGWubHTVDoE7YrVCRLTk=;
        b=dHKpx2IC+KtLxGnp77sFBgR/jCiU2CLiyyk3PuacZYOYnPn7ynj8LxgP9NS1HLZ5J7
         NRGnK/ic/FsMF1t/KH1hSgNmFsP8jef/eKXln1H9Wld3tF/bBsHvv1Klav3khZTciLm+
         9jKcGRC4/6hQw0rpF1aKevBJ9E3dQ2ivdxoxk6tEthvT47vQ/qxpJRRGjrkPB8UbDIj0
         3qChIxEK2qXbeRiGGIARAd0Oe+hI0pNl7SG/LotZoZEzgE4d380yVm/pMxpyT1/dLhr4
         e9l0susw9s+QsKjL4/gFSybY4F22jFbXvlEA2+odiut2LHunb7UZacjCGflkInpCUeU5
         Cjuw==
X-Gm-Message-State: APjAAAXhKi/i4UcFKIw5yItd2CM++wojdtE8t/viLd6+pOhYuv4fnI0T
        E5WwJpykNDsbcUjZWChvgg==
X-Google-Smtp-Source: APXvYqwzXMCREkTll4XgPjorWnosiQcrwVmt20Vj/gmN00DNLmOATC5Nt0q6j+cwaUBMJww7Wj3HSg==
X-Received: by 2002:a02:b713:: with SMTP id g19mr5777342jam.77.1562682879080;
        Tue, 09 Jul 2019 07:34:39 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id h19sm14973584iol.65.2019.07.09.07.34.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:34:38 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:34:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     jassisinghbrar@gmail.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        mark.rutland@arm.com, orito.takao@socionext.com,
        masami.hiramatsu@linaro.org, kasai.kazuhiro@socionext.com,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: milbeaut-m10v-hdmac: Add Socionext
 Milbeaut HDMAC bindings
Message-ID: <20190709143437.GA30850@bogus>
References: <20190613005109.1867-1-jassisinghbrar@gmail.com>
 <20190613005237.1996-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613005237.1996-1-jassisinghbrar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 12, 2019 at 07:52:37PM -0500, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Document the devicetree bindings for Socionext Milbeaut HDMAC
> controller. Controller has upto 8 floating channels, that need
> a predefined slave-id to work from a set of slaves.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  .../bindings/dma/milbeaut-m10v-hdmac.txt           | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> new file mode 100644
> index 000000000000..a104fcb9e73d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> @@ -0,0 +1,51 @@
> +* Milbeaut AHB DMA Controller
> +
> +Milbeaut AHB DMA controller has transfer capability bellow.
> + - memory to memory transfer
> + - device to memory transfer
> + - memory to device transfer
> +
> +Required property:
> +- compatible:       Should be  "socionext,milbeaut-m10v-hdmac"
> +- reg:              Should contain DMA registers location and length.
> +- interrupts:       Should contain all of the per-channel DMA interrupts.

How many?

> +- #dma-cells:       Should be 1. Specify the ID of the slave.
> +- clocks:           Phandle to the clock used by the HDMAC module.
> +
> +
> +Example:
> +
> +	hdmac1: hdmac@1e110000 {

dma-controller@...

> +		compatible = "socionext,milbeaut-m10v-hdmac";
> +		reg = <0x1e110000 0x10000>;
> +		interrupts = <0 132 4>,
> +			     <0 133 4>,
> +			     <0 134 4>,
> +			     <0 135 4>,
> +			     <0 136 4>,
> +			     <0 137 4>,
> +			     <0 138 4>,
> +			     <0 139 4>;
> +		#dma-cells = <1>;
> +		clocks = <&dummy_clk>;
> +	};
> +
> +* DMA client
> +
> +Clients have to specify the DMA requests with phandles in a list.

Nothing specific to this binding here and the client side is already 
documented, so drop this section.

> +
> +Required properties:
> +- dmas:             List of one or more DMA request specifiers. One DMA request specifier
> +                    consists of a phandle to the DMA controller followed by the integer
> +                    specifying the request line.
> +- dma-names:        List of string identifiers for the DMA requests. For the correct
> +                    names, have a look at the specific client driver.
> +
> +Example:
> +
> +	sni_spi1: spi@1e800100 {
> +		...
> +		dmas = <&hdmac1 22>, <&hdmac1 21>;
> +		dma-names = "tx", "rx";
> +		...
> +	};
> -- 
> 2.17.1
> 
