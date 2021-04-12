Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D6835D047
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 20:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhDLSZk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 14:25:40 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:46655 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbhDLSZj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Apr 2021 14:25:39 -0400
Received: by mail-ot1-f51.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso11788642otb.13;
        Mon, 12 Apr 2021 11:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zseWFQkoXXkzKjg8xcBHtR6LkiFggFTQklCUBroXcLI=;
        b=FswsQ0d35AtgK3WkAXtjJ/pIfBtD6cXym3zes3HX+1jvF3ISACeI7ZXWtQ/eIhQ1lT
         Kta1vKsRkC7L8VMO22A/bv1uBMOpEhATQLNhjSZhxwMWRSRc/VOho8fmYUuZSipGU0WA
         Q+j77ydjtPtw4NmG6Ie9FoDPRmGMS69rojgyiPf0zPSPyBxyNsKpuw1BwgfLwgkkqlyy
         kCwo0h3BmA/uAs/yVdyBctzIGzXWFkZvGSECOc3YTVbigp5Kk99o0gRX4gVfJeBYH2H5
         D02vdn637MP8rU3HnOB/zaJFdsANkNXpVA+54U+8LI8yet8mLtrSS5+Jjr7uz8glhTd0
         rNiQ==
X-Gm-Message-State: AOAM532PQ4ze7eUJi6WuBUDQ5bL042DLcwp91ez2sVcqqWmWWpmI6HBX
        BVY8t7I2OIp9Ru6HHCpHSg==
X-Google-Smtp-Source: ABdhPJxNel44VxJd5EsV+IYcnZbhJx/ZZy30K68IWDO2OMG7fCpWBM4pEmRAkvWK74SjRuZ9eigDrQ==
X-Received: by 2002:a9d:d0d:: with SMTP id 13mr23985859oti.134.1618251919968;
        Mon, 12 Apr 2021 11:25:19 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q23sm120605otc.7.2021.04.12.11.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 11:25:19 -0700 (PDT)
Received: (nullmailer pid 4155605 invoked by uid 1000);
        Mon, 12 Apr 2021 18:25:18 -0000
Date:   Mon, 12 Apr 2021 13:25:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     vkoul@kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC v2 PATCH 1/7] dt-bindings: dmaengine: xilinx_dma: Add
 xlnx,axistream-connected property
Message-ID: <20210412182518.GA4155576@robh.at.kernel.org>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1617990965-35337-2-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617990965-35337-2-git-send-email-radhey.shyam.pandey@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 09 Apr 2021 23:25:59 +0530, Radhey Shyam Pandey wrote:
> Add an optional DMA property 'xlnx,axistream-connected'. This can be
> specified to indicate that DMA is connected to a streaming IP in the
> hardware design and dma driver needs to do some additional handling
> i.e pass metadata and perform streaming IP specific configuration.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes for v2:
> - Rename xlnx,axieth-connected to xlnx,axistream-connected to
>   make it generic.
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
