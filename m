Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B17274D5D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 01:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgIVXcQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Sep 2020 19:32:16 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43252 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVXcQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Sep 2020 19:32:16 -0400
Received: by mail-il1-f193.google.com with SMTP id a19so19028513ilq.10;
        Tue, 22 Sep 2020 16:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gyrc98ZgV4x+9B5E4O+c+sLjhPjwOSAXbPDmcGuQo/U=;
        b=eDgHEkZFaqkeQ90qVli/+A0Mq6KVgdt8loUiXQNXB8ZB7LM7MbNpirkqVbpXfi9mh+
         pps47KdazM/zpIJ9QCfjHcjUcyQY2xmlTiSiFtTmQzBJZlvUZNBwdZoKJPgx/4h/IxTj
         nms/BYU+LX/P08JKE5p0aQHrm6oNp9mWgltLAwpnN/RiJq6gGBsSSXcpx0NGpxTQTdvD
         NTQk3irN8FUCIduTZF+9PRt38MUQKx4U6R3pUTpPbQBbivgGCXQhKQAOsoCxCnfhn+D/
         WyuRjHtZg3tZ+VuPwEPlsfVMCWtBkAtS66vkddQoAfTm9EQsgRQGvoPjf+AaIAnc58/+
         GLEQ==
X-Gm-Message-State: AOAM533lJsMpd4JCgWbPzSAPyzZsIP+my3EKY1d6cAZraskN+4kUgc49
        2W4wqJ1WHxIAAPwAoUL9pA==
X-Google-Smtp-Source: ABdhPJwY5X76W8rcHZ93k4PfVIA6o/kBwLSeB++S/ieSCyHvQk6KhuUFTSvcoBoQQhVf1Nd+1p6sxA==
X-Received: by 2002:a05:6e02:c8b:: with SMTP id b11mr6037370ile.149.1600817535247;
        Tue, 22 Sep 2020 16:32:15 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b24sm9954806ill.68.2020.09.22.16.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 16:32:14 -0700 (PDT)
Received: (nullmailer pid 3474429 invoked by uid 1000);
        Tue, 22 Sep 2020 23:32:13 -0000
Date:   Tue, 22 Sep 2020 17:32:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     tudor.ambarus@microchip.com, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH 3/7] dt-bindings: dmaengine: at_xdmac: add compatible
 with microchip,sama7g5
Message-ID: <20200922233213.GA3474374@bogus>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
 <20200914140956.221432-4-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914140956.221432-4-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 14 Sep 2020 17:09:52 +0300, Eugen Hristev wrote:
> Add compatible to sama7g5 SoC.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
