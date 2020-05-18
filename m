Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833E71D85F5
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2020 20:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgERRuo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 May 2020 13:50:44 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44791 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbgERRun (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 May 2020 13:50:43 -0400
Received: by mail-il1-f194.google.com with SMTP id j3so10689081ilk.11;
        Mon, 18 May 2020 10:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QSIx+38T4cvinbqxvrbe5wtA55RL5fnICs68EFHUoBw=;
        b=PpYGIftnD00BLXtFyZxwyWkHns0QrUgASLj5gphWhzV8Sa3FgPAPr9Pt3y495AZxnq
         qVgdjFMPwjVV6aZWkgDEUAkzn0yzVbCl0Bwm1LTBAFroUUfsowJr5XvRdE7OA2qv8yyV
         Xt4/Hk6xPj3kXLNm5b33GG2J+VoDOb6HV/1Qnhna4xJTEkdKTwi3N6e1IwSZ3ieDQMZO
         0t51RA71lScQQKedDPJUcNq2qYE3GRgQDxATWX2iHqL8s/JxwTdekVvaHcxsW30ywhrU
         iow2825axxU5a5GhjxZwuf2RNXw4CikvUtlzgKs5AlWeBWN3SmHgXzS51615uWinhzKw
         3cZg==
X-Gm-Message-State: AOAM532TkwRyvA2uKWHT7MZjdhHnIxtDXZTQgK9SdYg/LJ5hz8oH5ydp
        ZuYKMbTcAk+yAboXpniZQg==
X-Google-Smtp-Source: ABdhPJxZwdHeQqDHyTuNUAv4DR4jH+jc65DamVkkq40xebpBOXF0/bqcjx71aAeYZUSrQFJEnm5dhg==
X-Received: by 2002:a05:6e02:544:: with SMTP id i4mr17900970ils.266.1589824242573;
        Mon, 18 May 2020 10:50:42 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 4sm3609176ioy.43.2020.05.18.10.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 10:50:41 -0700 (PDT)
Received: (nullmailer pid 15694 invoked by uid 1000);
        Mon, 18 May 2020 17:50:40 -0000
Date:   Mon, 18 May 2020 11:50:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: dma: dw: Convert DW DMAC to DT
 binding
Message-ID: <20200518175040.GA14697@bogus>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508105304.14065-2-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 08, 2020 at 01:52:59PM +0300, Serge Semin wrote:
> Modern device tree bindings are supposed to be created as YAML-files
> in accordance with dt-schema. This commit replaces the Synopsis
> Designware DMA controller legacy bare text bindings with YAML file.
> The only required prorties are "compatible", "reg", "#dma-cells" and
> "interrupts", which will be used by the driver to correctly find the
> controller memory region and handle its events. The rest of the properties
> are optional, since in case if either "dma-channels" or "dma-masters" isn't
> specified, the driver will attempt to auto-detect the IP core
> configuration.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-mips@vger.kernel.org
> 
> ---
> 
> Changelog v2:
> - Rearrange SoBs.
> - Move $ref to the root level of the properties. So do do with the
>   constraints.
> - Discard default settings defined out of the property enum constraint.
> - Replace "additionalProperties: false" with "unevaluatedProperties: false"
>   property.
> - Remove a label definition from the binding example.
> ---
>  .../bindings/dma/snps,dma-spear1340.yaml      | 161 ++++++++++++++++++
>  .../devicetree/bindings/dma/snps-dma.txt      |  69 --------
>  2 files changed, 161 insertions(+), 69 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/snps-dma.txt

Reviewed-by: Rob Herring <robh@kernel.org>
