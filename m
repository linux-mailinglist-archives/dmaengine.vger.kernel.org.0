Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2991E9C7C
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2020 06:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgFAEVF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Jun 2020 00:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgFAEVF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Jun 2020 00:21:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A9CC08C5C0
        for <dmaengine@vger.kernel.org>; Sun, 31 May 2020 21:21:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i12so281259pju.3
        for <dmaengine@vger.kernel.org>; Sun, 31 May 2020 21:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0pWooxPmBrlgQ0LNPI090mpeVBdObo+y6HOQ/sjn93M=;
        b=o/HAY6GAL/o9D0bF49hI0zAx9I03e67slE/J69vOt7Z/VccdElcCDANHYaQkS9Lfe7
         Uspqlwni3/80XZIqsoxxkoVb+4P++uwAnUP9N47RVTxp2wscjk51IU8NAzv16HO81fJA
         pHd1UWFHm1kKUyYU6HAoeZfS4bbMf0WtqgbMyb9xlwLigL9grjMhLStMHLEFJYk2z5gP
         qU1JNbhmtFKNC8cR3Ml69qflav4STGcLjNU6BAKzBh1uYQjvz4ubq8iL51E2rY2IINmw
         oUqpJWQJeEkiqZ+6pB3Sp3F/jwJzVVg4wba2SrTI2WvFT6VjJ8iCelmsvX7zEd1FGQz+
         5QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0pWooxPmBrlgQ0LNPI090mpeVBdObo+y6HOQ/sjn93M=;
        b=rSG1117hdjVeVHmMJ1J4ETyz01b4bRFkv+ua2UtlPU7X7YT1fZuuPaBx63+q9sAl6J
         E5AJB5qK3Dvx+rnTM00DSDlSbDN8qmctDnMQwfd7+PNDaExok1rjGlmdoFjUGU6w8fY6
         qJa7XSBBHugs+RD7vktHM2nT8ZJNI2RubDY5KZkxlP6BSeasJ8NlcPOAPq2/zC3KjchC
         /gnctgVdYiQzH2Twl1jNVMg+M2NKGOH9ec2xKER4fXBYInmfJIE1JWgx1A7NNSEt2yLW
         +ZHSZ4bAHAqLJp5/zFI1QtIz00d12kHd3+wHBTXoExXG4f5YqdLNzPY0HYgOwbIljadq
         Gtgg==
X-Gm-Message-State: AOAM5334Mq+YIMKCppfEK1CYRnJg+JnNEAq1kjbBpjV+vjcg/Wx2NHcd
        2vzCy5injfWmbslFPhAdbZC62Q==
X-Google-Smtp-Source: ABdhPJwZZt2+S77vjfH5Yt9RxzONnKBH9FVd8j0bBSGTx4iHzb4Pl1xki3aDzKGPlCl/ZfHZJW6x6g==
X-Received: by 2002:a17:90a:b90:: with SMTP id 16mr21862974pjr.85.1590985264553;
        Sun, 31 May 2020 21:21:04 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id t4sm9749569pfh.5.2020.05.31.21.21.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2020 21:21:03 -0700 (PDT)
Date:   Mon, 1 Jun 2020 09:51:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/11] dt-bindings: dma: dw: Add max burst transaction
 length property
Message-ID: <20200601042102.cki4yww56puu4zt7@vireshk-i7>
References: <20200529144054.4251-1-Sergey.Semin@baikalelectronics.ru>
 <20200529144054.4251-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529144054.4251-3-Sergey.Semin@baikalelectronics.ru>
User-Agent: NeoMutt/20180716-391-311a52
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-05-20, 17:40, Serge Semin wrote:
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
