Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29433234DA9
	for <lists+dmaengine@lfdr.de>; Sat,  1 Aug 2020 00:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGaWmQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jul 2020 18:42:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44593 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaWmP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jul 2020 18:42:15 -0400
Received: by mail-io1-f66.google.com with SMTP id v6so17940088iow.11;
        Fri, 31 Jul 2020 15:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=soM3XiGlqMF6wRO5kAd80dwyaXMFhHTLobhFQyhs1VA=;
        b=i+RGnrcuC2hsYROT/ugS4m/8mErVz0A1C87rw8b6CdneVCSPYntNncZ3m+o/e/HeJ2
         O1VYa20E0EZ7I6IVJTyAjs7g2RPvE0jv217+cVpy21PBQiKPiXF6L4RAL64BdqaRflHT
         acbGUcs5jEWmhzIbkz1DC+aMfgK4cIEaY94GLzGxW2OOKO0DvNiQZxlYuyn/fDkWP468
         8Dfc8gqYfNgNoXTS40tdqxl7H1p8qUrOl/SBmtkiPk4qe2LJLZVuauu2WBiN8C12px5Z
         cWjmgRqiqWs50ntyqnaHRmOJz2AXUuuIBD3sE/t8DljwOJAh4CRbv3N3u4WBocmkMFlg
         mrNQ==
X-Gm-Message-State: AOAM532dE/KGLgMISlxevweUw7s1bI0VSdZjU+lAu6piw5X18aeqYq5y
        gCkKKFSXDYSKVvFG0t0/cQ==
X-Google-Smtp-Source: ABdhPJzCLkAb9cmGZT9KOsWAc2uFkDU6xbg3zFNhGW9fmSZ0oPYORZm5j3NYhoSrUh/mtFccShqV6w==
X-Received: by 2002:a02:3e13:: with SMTP id s19mr7569352jas.95.1596235334866;
        Fri, 31 Jul 2020 15:42:14 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x12sm5715381ile.14.2020.07.31.15.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:42:14 -0700 (PDT)
Received: (nullmailer pid 941715 invoked by uid 1000);
        Fri, 31 Jul 2020 22:42:13 -0000
Date:   Fri, 31 Jul 2020 16:42:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: dma: dw: Add optional DMA-channels mask
 cell support
Message-ID: <20200731224213.GA941640@bogus>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
 <20200730154545.3965-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730154545.3965-2-Sergey.Semin@baikalelectronics.ru>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 30 Jul 2020 18:45:41 +0300, Serge Semin wrote:
> Each DW DMA controller channel can be synthesized with different
> parameters like maximum burst-length, multi-block support, maximum data
> width, etc. Most of these parameters determine the DW DMAC channels
> performance in its own aspect. On the other hand these parameters can
> be implicitly responsible for the channels performance degradation
> (for instance multi-block support is a very useful feature, but having
> it disabled during the DW DMAC synthesize will provide a more optimized
> core). Since DMA slave devices may have critical dependency on the DMA
> engine performance, let's provide a way for the slave devices to have
> the DMA-channels allocated from a pool of the channels, which according
> to the system engineer fulfill their performance requirements.
> 
> The pool is determined by a mask optionally specified in the fifth
> DMA-cell of the DMA DT-property. If the fifth cell is omitted from the
> phandle arguments or the mask is zero, then the allocation will be
> performed from a set of all channels provided by the DMA controller.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../devicetree/bindings/dma/snps,dma-spear1340.yaml        | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
