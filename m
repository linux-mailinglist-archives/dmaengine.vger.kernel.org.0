Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58300B645F
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2019 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfIRN3d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Sep 2019 09:29:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46320 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfIRN3d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Sep 2019 09:29:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id f21so3156280otl.13;
        Wed, 18 Sep 2019 06:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZTDpZB0FWhOuAxtm2xHOiTF/T4Pop64d8ZGOTckqTQ=;
        b=gnlChRSmR7/ZO6HxDRhLJ8Q2JST2UiBHvjFFpccfNtgNZJI+gG2cIAJvraM/5Rht5B
         isuMSGOou5GqcFY/REM52HL78Je7RlzAyNwE3+qbt/UxaZbqCV9Kje0GS1bnBVQesC33
         7riMSsqt74fWLTVkDgSOaFH53zdwJLPLHZ4CMrgUXDLGqpecptBnThC/xuEJuH3nm9FK
         nkSz0zPyJGgpFYnGCkK8lfVp0goXqX6o4eLvSUikpdCPocYLCkY1P9VpTFHBcOVd54eB
         px0nkzqvZn9+S3ZAu+WM0Tr3+hgxft1Cz/1fVn/jnQOG+3bjt/oBaivRCRhAAr31svBi
         SDPw==
X-Gm-Message-State: APjAAAVPcU1G9o8dDFUVSOZHIqO96dLvAGc4VW87+EiK1brVbYzJ9B6B
        zowiMT9a617fI/61l4BrLQ==
X-Google-Smtp-Source: APXvYqwoXBXNAJkYbclAQeVhMjyqJzab480msbLIYPOESQiLgnhUmsr2Z5ieZuNUI0ieLl+Lutec3w==
X-Received: by 2002:a05:6830:138a:: with SMTP id d10mr2902533otq.316.1568813372427;
        Wed, 18 Sep 2019 06:29:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x6sm1808647ote.69.2019.09.18.06.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 06:29:31 -0700 (PDT)
Date:   Wed, 18 Sep 2019 08:29:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: dma: ti-edma: Document
 dma-channel-mask for EDMA
Message-ID: <20190918132931.GA14832@bogus>
References: <20190910114559.22810-1-peter.ujfalusi@ti.com>
 <20190910114559.22810-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910114559.22810-3-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 10, 2019 at 02:45:58PM +0300, Peter Ujfalusi wrote:
> Similarly to paRAM slots, channels can be used by other cores.
> 
> The common dma-channel-mask property can be used for specifying the
> available channels.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/ti-edma.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> index 4bbc94d829c8..3c7736246354 100644
> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -42,6 +42,9 @@ Optional properties:
>  - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
>  		the driver, they are allocated to be used by for example the
>  		DSP. See example.
> +- dma-channel-mask: Mask of usable channels, see
> +		Documentation/devicetree/bindings/dma/dma-common.yaml
> +

What's the size? 2 cells?

>  
>  ------------------------------------------------------------------------------
>  eDMA3 Transfer Controller
> @@ -91,6 +94,9 @@ edma: edma@49000000 {
>  	ti,edma-memcpy-channels = <20 21>;
>  	/* The following PaRAM slots are reserved: 35-44 and 100-109 */
>  	ti,edma-reserved-slot-ranges = <35 10>, <100 10>;
> +	/* The following channels are reserved: 35-44 */
> +	dma-channel-mask = <0xffffffff>, /* Channel 0-31 */
> +			   <0xffffe007>; /* Channel 32-63 */
>  };
>  
>  edma_tptc0: tptc@49800000 {
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
