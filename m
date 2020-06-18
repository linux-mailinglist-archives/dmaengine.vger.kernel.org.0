Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCB1FED84
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2020 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgFRIWM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Jun 2020 04:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgFRIWJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Jun 2020 04:22:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201CCC06174E;
        Thu, 18 Jun 2020 01:22:07 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so2146636pls.2;
        Thu, 18 Jun 2020 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5va4+zAz3Y84F8I+jfwGK7kVZgA+OWKUCO/DBzqZ2lk=;
        b=cDW1fPwusXFzGuCl5MLlwj3Weok2y/3zDATZakbo/QxGCfddQPnP9+2vX2AwQ7pOCU
         WO7ztjrphuOdlaWUCyCendYSCETu3ckX0m+nG+esOVlkRgTCNW7IyvIZS+ptQGtMAQYY
         BXLd8pI1mh8TBLJ8yWa+ZtEFKB252rKhjqGdLRJK5w19fvKuLyB6J9YmhHO0vYyO2zS4
         DY6PJbKGD6Z9sNQ+Wcva2R90nSOstl+3TkSQx8qHoJKBH0yLeVdbTs91CbeM/lv7p2Sj
         1Q8MkQ3YLnT0fshzg2HkNSmtQh5YJXuaBiNe8Rzi1w7Fm7JCQAkFpGMR9ini0g/Qudel
         1nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5va4+zAz3Y84F8I+jfwGK7kVZgA+OWKUCO/DBzqZ2lk=;
        b=DqRlM1zo4YbQCJc8uA92q2L+QmRJXEfmhxqi18bgebJNRJdr2emXuzvRcK+f8ONu5y
         HI0cqBzpt7VFBOtsC5g/e8rZ+ZjDQcwgQGXxuiOTA38BCYIi+2yfzmuBT4tO9sWrWz7k
         dEQwP9alvivbX1uaIDXiPgnojdAnUSo9rde4/AZVgya5ZVKoGM/LO6kXd6JkPQnGE85l
         okANFXSq8O0G74XjUIJfciQ0oKhDeN6vc46pFaOmgj1ryXQG61O0LnzpiQciiqdvnziB
         bxfT1RDymJkP01pv4HF7ZpgNMScsR2vhMUmaiL1aqq6CgUwxRjydxOteDO6kPJheV8lj
         CT9A==
X-Gm-Message-State: AOAM532wctvWeYA5k/cUQXhfgnIHxKu13/wLp6O4//8YODpyuGG+AWlG
        XgGTF9c59qOeI6ylvPhyfGv3e5imj8vN3AXfUCk=
X-Google-Smtp-Source: ABdhPJxX08N8JTeQWAXqBjqWujBqYCDSdKV6HtPJTrJdC6PtGGZb5xiN1DV0gsb2hPJw/LyrQK9UVr140CiNu7pAebo=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr3196269pjq.228.1592468526692;
 Thu, 18 Jun 2020 01:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200617234028.25808-1-Sergey.Semin@baikalelectronics.ru> <20200617234028.25808-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200617234028.25808-2-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Jun 2020 11:21:53 +0300
Message-ID: <CAHp75Vd+3ZN51geXg+KiQYVpBZN7F+kgt-2Snw7VDiKiYVqX=A@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] dt-bindings: dma: dw: Convert DW DMAC to DT binding
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        dmaengine <dmaengine@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 18, 2020 at 2:43 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
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
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-mips@vger.kernel.org


Rob, here are questions to you.

> +  dma-channels:
> +    description: |
> +      Number of DMA channels supported by the controller. In case if
> +      not specified the driver will try to auto-detect this and
> +      the rest of the optional parameters.
> +    minimum: 1
> +    maximum: 8

...

> +  multi-block:

> +      maxItems: 8

This maximum is defined by above dma-channels property. Is there any
way to put it in the schema?

...

> +  snps,dma-protection-control:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description: |
> +      Bits one-to-one passed to the AHB HPROT[3:1] bus. Each bit setting
> +      indicates the following features: bit 0 - privileged mode,
> +      bit 1 - DMA is bufferable, bit 2 - DMA is cacheable.
> +    default: 0
> +    minimum: 0
> +    maximum: 7

AFAIR this is defined by bit flags, does schema have a mechanism to
define flags-like entries?

-- 
With Best Regards,
Andy Shevchenko
