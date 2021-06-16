Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D853AA2B2
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 19:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFPR6w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 13:58:52 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:42668 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFPR6w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Jun 2021 13:58:52 -0400
Received: by mail-il1-f178.google.com with SMTP id h3so3076641ilc.9;
        Wed, 16 Jun 2021 10:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/py5L9Q9HSWwFy0NUmVJdPgH/ue50u6DETIV0QpNLhU=;
        b=hGZgSbBKR5Je6QJ/6EGvb+PgJ5v6H34ME2beldu6lcTZxbqln8Wz7Dn/mDSY812Jhx
         U4btitBI0bi7LGMGo60VY7IexkSFDDIxsW2Mgpa5VVLQ8r+Pgs/iCvngyR8ESiObJ9Pp
         awu7IOXIzS+POGa3myPwe3ot9xHeMXM/BV+35zlUJYEeA6/3DicXuoaOjZeK0P9Yt7Im
         RZr+0fvT8VJMk/yWSSfNRLOIyqvW1KPNbqPHRde37F+TdKGKFG5Fw43urraBvYvb/5jh
         k+dKIzXCe4bWFLqfuYM3ibr5be+bYsNyZoUteeonBlskYCp7HLm0qOnkkQH4W9M6A8lw
         6cvQ==
X-Gm-Message-State: AOAM530dLQccbPavgolf38IJA6daQxCza3SgsiGxHsGwLuh2c/HiNnaS
        Mc5LWK9pK6c8m1uFkffMUw==
X-Google-Smtp-Source: ABdhPJxLM7mtUE5wO0OfkXJfNJhh1g1eIoDeP8YYOXTqhfbSbWH63TbwS+zYyN8fRZCLPXHGek1YCQ==
X-Received: by 2002:a92:6b06:: with SMTP id g6mr594663ilc.270.1623866205437;
        Wed, 16 Jun 2021 10:56:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i13sm1532726ilr.16.2021.06.16.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 10:56:44 -0700 (PDT)
Received: (nullmailer pid 3616686 invoked by uid 1000);
        Wed, 16 Jun 2021 17:56:43 -0000
Date:   Wed, 16 Jun 2021 11:56:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        linux-sh@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Remove SHDMA Device Tree
 bindings
Message-ID: <20210616175643.GA3616655@robh.at.kernel.org>
References: <cover.1623406640.git.geert+renesas@glider.be>
 <ba56b7199fcf3516f202389d2c8f836c9ec51e7a.1623406640.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba56b7199fcf3516f202389d2c8f836c9ec51e7a.1623406640.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 11 Jun 2021 12:18:39 +0200, Geert Uytterhoeven wrote:
> Remove the Renesas SHDMA Device Tree bindings, as they are unused.
> The DMA multiplexer node and one DMA controller instance were added to
> the R-Mobile APE6 .dtsi file, but DMA support was never fully enabled,
> cfr. commit a19788612f51b787 ("dmaengine: sh: Remove R-Mobile APE6
> support").
> 
> Note that the mux idea was dropped when implementing support for DMA on
> R-Car Gen2, cfr. renesas,rcar-dmac.yaml.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/dma/renesas,shdma.txt | 84 -------------------
>  1 file changed, 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/renesas,shdma.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
