Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4CA2A25
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2019 00:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfH2Wrb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Aug 2019 18:47:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44308 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfH2Wra (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Aug 2019 18:47:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id w4so5046364ote.11;
        Thu, 29 Aug 2019 15:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGSaPx3LdslUNS74sxx3stGfHKDniSUYmPCWv7ZUOGU=;
        b=CmpG0SmsLqyUSBg7Wvh6/wQCTN0dIubo5S4yZEAJ4meR9D+aJbxflrXqXUyUfOk+uc
         VC31yFrQ0b/N8vR9oCOJjJm1KqoHEjmD0gjG6MtNDFcwUDvFkQIC5uvyYNGEUG9IFpxA
         +dt/jrP6Hf5el3PA3V13jIE/FoFFJBGS0etMF/xbMYL/G4MUBq+UhNBiUaJljXvKYIXM
         B2SkC1LJNtrCTo4pkZRGNEQmZjnixSufFk1vFby2ItG7yodq+ec2onEN5zqsNTFLyNNF
         NGSPWfk4wO1z1ByNwjN5It64Biqh2OnmJmYVRO6/UbuTIHuEBcczPts7IUsmco6EYrp1
         nFsA==
X-Gm-Message-State: APjAAAUMS5tSzVp+Z+NtoOCUC3/zuUr70o/iN5HueZ9dHAf3Pd1DUpV7
        I+HeRG2gcK9kZFa/fcL9mw==
X-Google-Smtp-Source: APXvYqxvjUidJEXS3GfJHqsfP2OQKa+fDP+j/F6yDenxAYwRHbUHx3JF0HxP1UjQZHQSup1Fw1dzRQ==
X-Received: by 2002:a05:6830:1f04:: with SMTP id u4mr1227223otg.340.1567118849657;
        Thu, 29 Aug 2019 15:47:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e27sm971378oig.53.2019.08.29.15.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:47:29 -0700 (PDT)
Date:   Thu, 29 Aug 2019 17:47:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: dma: ti-edma: Add option for reserved
 channel ranges
Message-ID: <20190829224728.GA1198@bogus>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
 <20190823125618.8133-5-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823125618.8133-5-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Aug 23, 2019 at 03:56:17PM +0300, Peter Ujfalusi wrote:
> Similarly to paRAM slots, channels can be used by other cores.
> 
> Add optional property to configure the reserved channel ranges.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/ti-edma.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> index 4bbc94d829c8..1198682ada99 100644
> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -42,6 +42,9 @@ Optional properties:
>  - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
>  		the driver, they are allocated to be used by for example the
>  		DSP. See example.
> +- ti,edma-reserved-chan-ranges: channel ranges which should not be used by
> +		the driver, they are allocated to be used by for example the
> +		DSP. See example.

Based on the other thread, I think extending dma-channel-mask to a 
uint32-array makes sense here.

Rob
