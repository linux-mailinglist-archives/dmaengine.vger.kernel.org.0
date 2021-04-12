Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781FD35D049
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 20:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243534AbhDLSZv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 14:25:51 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:44567 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbhDLSZu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Apr 2021 14:25:50 -0400
Received: by mail-oi1-f179.google.com with SMTP id j24so3515124oii.11;
        Mon, 12 Apr 2021 11:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uy5HrUvhq1cZCDSi9Kwt57LFPamGKIDDP47/2Ov/Lfo=;
        b=gDbVmDXQ17vYzn8V6qtBaWALqpmqiR3YvKNb4Lp4F3OxBmO6wlywH15kVmR1AvlDhm
         XR6jRa5EkGGi9URsLzrc/GlmN0YJ8TGgQk7y/QWhUPLMOZW5EYWmcllEZpp1ExSkjBKG
         WMV4lztSwgcRGF9J2QFqLhN3ckv2NND6motE7kNPwrLQkncb30zRFTWP1FIOWM1VH539
         EzUsaHoFIO5rte4vX2r1LTKBPWBST5MdMmj4dbTFNcBp3xL7q+EZpc4SC4eysEIotXOx
         rSVrWOrT7Mme1voKkQUzCDn8G4NIoK2vUbWR0tMOIryU1bjQZ5p8bMEAq1lQTSZQReTR
         c1TQ==
X-Gm-Message-State: AOAM530pD+DQzP27wIdq5KmeVAuSSA8DZbDDDCczj2hsOK/UxsVoC/ru
        Oj4ncur+LrZAqkcREqmm7G48VHm93Q==
X-Google-Smtp-Source: ABdhPJwoG816v9ySSk0Ka+75sfhwPbE2lsPiIQuIiB7eDJs3lzf8TPNAh93WSLSX/J9HEbTdQuBlIg==
X-Received: by 2002:aca:2103:: with SMTP id 3mr378105oiz.80.1618251931383;
        Mon, 12 Apr 2021 11:25:31 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q21sm736940oof.5.2021.04.12.11.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 11:25:30 -0700 (PDT)
Received: (nullmailer pid 4155984 invoked by uid 1000);
        Mon, 12 Apr 2021 18:25:29 -0000
Date:   Mon, 12 Apr 2021 13:25:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org, git@xilinx.com,
        vkoul@kernel.org, michal.simek@xilinx.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [RFC v2 PATCH 2/7] dt-bindings: dmaengine: xilinx_dma: Add
 xlnx,irq-delay property
Message-ID: <20210412182529.GA4155955@robh.at.kernel.org>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1617990965-35337-3-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617990965-35337-3-git-send-email-radhey.shyam.pandey@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 09 Apr 2021 23:26:00 +0530, Radhey Shyam Pandey wrote:
> Add an optional AXI DMA property 'xlnx,irq-delay'. It specifies interrupt
> timeout value and causes the DMA engine to generate an interrupt after the
> delay time period has expired. Timer begins counting at the end of a packet
> and resets with receipt of a new packet or a timeout event occurs.
> 
> This property is useful when AXI DMA is connected to the streaming IP i.e
> axiethernet where inter packet latency is critical while still taking the
> benefit of interrupt coalescing.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes for v2:
> - New patch. Introduce xlnx,irq-delay property for low latency usecases
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
