Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D93C0CD5
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2019 22:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfI0Us4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Sep 2019 16:48:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46036 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfI0Us4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Sep 2019 16:48:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so3386014oti.12;
        Fri, 27 Sep 2019 13:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHbuAWRgyfdd0/7I5EKejphIr7Awr7Ufl06cGZr9UWM=;
        b=Yb14P2FVCzrEpsFJiIKszbjwMIp+FUs8TF+SomX6vu1HZ9mTIwr9RNEg2oLNtOkSRW
         GYudXChlGNB0VlyoM15UkEHDVmTiHB/8dwVBrccCOmtVPqkA0KtSGJkjixkLtAEjZVh3
         rt+HvzUZoQEHm0Ed15jNLXWwZStGoCsEwy39qfoLGEtYRmEOcVkYeJbUHcrNoWKuni34
         VE63EnxIIRtOtikgUKgZGee2SGQsMG1LTNsA9EFWPZezVhJ7aF0NyVbLJZizUfV+OuFu
         WLQZsnIVbOjQNDWk5/HBdwT588YYygPk21TEwYiN+8w6asdaT1vzTUBtJDrUY8XTZBsm
         LrEA==
X-Gm-Message-State: APjAAAVNcAiLJn3ZvC84zsg8fP7Se76wLqRURRnQ0y6zDaaWhDTMrYRO
        9szaHpGMZU+ap6MX0Ff7SA==
X-Google-Smtp-Source: APXvYqzPZhS/oOuHCnSCXzdNvjnEYVT4GzMZW0oHF4dRC74KXAwNQ6LWjjs9BHI9deVVAemO9XYlbA==
X-Received: by 2002:a9d:744e:: with SMTP id p14mr4942965otk.323.1569617335327;
        Fri, 27 Sep 2019 13:48:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o2sm1317553ota.3.2019.09.27.13.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 13:48:54 -0700 (PDT)
Date:   Fri, 27 Sep 2019 15:48:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: dma: ti-edma: Document
 dma-channel-mask for EDMA
Message-ID: <20190927204854.GA20463@bogus>
References: <20190926111954.9184-1-peter.ujfalusi@ti.com>
 <20190926111954.9184-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926111954.9184-3-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 26, 2019 at 02:19:53PM +0300, Peter Ujfalusi wrote:
> Similarly to paRAM slots, channels can be used by other cores.
> 
> The common dma-channel-mask property can be used for specifying the
> available channels.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/ti-edma.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> index 4bbc94d829c8..014187088020 100644
> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -42,6 +42,11 @@ Optional properties:
>  - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
>  		the driver, they are allocated to be used by for example the
>  		DSP. See example.
> +- dma-channel-mask: Mask of usable channels.
> +		Single uint32 for EDMA with 32 channels, array of two uint32 for
> +		EDMA with 64 channels. See example and
> +		Documentation/devicetree/bindings/dma/dma-common.yaml
> +
>  
>  ------------------------------------------------------------------------------
>  eDMA3 Transfer Controller
> @@ -91,6 +96,9 @@ edma: edma@49000000 {
>  	ti,edma-memcpy-channels = <20 21>;
>  	/* The following PaRAM slots are reserved: 35-44 and 100-109 */
>  	ti,edma-reserved-slot-ranges = <35 10>, <100 10>;
> +	/* The following channels are reserved: 35-44 */
> +	dma-channel-mask = <0xffffffff>, /* Channel 0-31 */
> +			   <0xffffe007>; /* Channel 32-63 */

Doesn't matter yet, but you have a mismatch here with the schema. While 
the <> around each int or not doesn't matter for the dtb, it does for 
the schema.

dma-channel-mask = <0xffffffff>, <0xffffe007>;
minItems: 1
maxItems: 255

dma-channel-mask = <0xffffffff 0xffffe007>;
items:
  minItems: 1
  maxItems: 255

I think the latter case is slightly more logical here as you have 1 
thing (a mask). If had N of something (like interrupts), then the former 
makes sense. 

Rob
