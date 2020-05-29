Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE531E89F5
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 23:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgE2VYU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 17:24:20 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40789 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgE2VYU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 May 2020 17:24:20 -0400
Received: by mail-il1-f195.google.com with SMTP id t8so3376693ilm.7;
        Fri, 29 May 2020 14:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uowho2igbLeYdvcPX3pvLRT9zcMohs3wO1m6OZGWISE=;
        b=ay2ADklElmDDyXLi5yyOTViBj6iRx8/zrpc2D5rhziKm75c7+aIfclTiT2LVzJVbKt
         BfUB2H4CEDK0Xqt1Bx184YmLotCyOfF03p+jB2QPEwrHvtSH1PlxZmofSbBQP8XoOFrm
         qRPq+w1J8ppBqx3p1tg4enaBAUcAof0rbzgLmZwg58/02YFjiYnwMddMv+ZHaSNpWKlx
         lfRXkZSORAYeMdwuinzSIN6Rk4UpXIdsDuqRz7ovp8R8bXKhpAh5KIKKzIELgT0RChEt
         tk3mB09X48eaj4ykyBbCKpAW7PRhvCa9BeUlcyrIVHFsuKGsmlvvduUIMswO/Gd3Kl1J
         N7JA==
X-Gm-Message-State: AOAM530tSpBWNyPkpiNPIcnFxjBV5pXzQZDa+jhfVLxVK4cLIqqwE1PB
        PVXgKJ/71zwlNQP9WaJdug==
X-Google-Smtp-Source: ABdhPJz/qLHW9IoKyI+iX/bqpRWeziSYW8gFNNZGjEIqFx7OXO5F0hX1+RCCulHWqGa35KT8U1Cm4g==
X-Received: by 2002:a92:5fda:: with SMTP id i87mr7186744ill.292.1590787459003;
        Fri, 29 May 2020 14:24:19 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i10sm5312514ilp.28.2020.05.29.14.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:24:18 -0700 (PDT)
Received: (nullmailer pid 2994336 invoked by uid 1000);
        Fri, 29 May 2020 21:24:13 -0000
Date:   Fri, 29 May 2020 15:24:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     linux-mips@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        dmaengine@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v5 02/11] dt-bindings: dma: dw: Add max burst transaction
 length property
Message-ID: <20200529212413.GA2994283@bogus>
References: <20200529144054.4251-1-Sergey.Semin@baikalelectronics.ru>
 <20200529144054.4251-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529144054.4251-3-Sergey.Semin@baikalelectronics.ru>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 29 May 2020 17:40:45 +0300, Serge Semin wrote:
> This array property is used to indicate the maximum burst transaction
> length supported by each DMA channel.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-mips@vger.kernel.org
> 
> ---
> 
> Changelog v2:
> - Rearrange SoBs.
> - Move $ref to the root level of the properties. So do with the
>   constraints.
> - Set default max-burst-len to 256 TR-WIDTH words.
> 
> Changelog v3:
> - Add more details into the property description about what limitations
>   snps,max-burst-len defines.
> ---
>  .../bindings/dma/snps,dma-spear1340.yaml          | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
