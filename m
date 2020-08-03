Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE8623AFD4
	for <lists+dmaengine@lfdr.de>; Mon,  3 Aug 2020 23:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgHCVvv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Aug 2020 17:51:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43107 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgHCVvv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Aug 2020 17:51:51 -0400
Received: by mail-io1-f65.google.com with SMTP id k23so40077726iom.10;
        Mon, 03 Aug 2020 14:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rTTd0JLEQIircW3THThScxa603LDzD4tC7cJBVnxw/8=;
        b=PS9Vc/RaXghQo6qgZra6AA1HZaUeqqdzy5Sh+gGZDDLwLd3xw0hXBc2A9kgZ/p+kD3
         CxamUkzPr2Zak69584gWpoPi9bHPd6T9g72y66RME3WGe88T/Kh56wOcNmPXqT8gWhPv
         5Im1tAD/UlEefCQKXdrge5C73h1hnM0VY3cDkQ+o9vCylwNZaGvbI5PLwz+/m451yFcf
         oNkSvqUHFncWrRWYCmRRpW+tz9Af23KH0RlIlcbNgs+TGoAQiE3GUjAYsuIZCp+g0Qg1
         VoyIwUKcoZ4t7wN5Bs9uFL6sJd1MDBwzDXBwAkL7Thw87/1uHBONB7VHcXfgIptX6hnD
         QJRA==
X-Gm-Message-State: AOAM5300fO1gBZf1ZnUCqVxG8GxXcmb2qCFUISiVFzUjAB0gUBUsN0y5
        cl3PoegjrrHTgpDYSZst3Q==
X-Google-Smtp-Source: ABdhPJwk9JxW57b/cc2Ai3TSARPfqnml762G9Vu/UjF/k0tep6wviRYkAv+/P4mTcChWZ7hQ2RQBRg==
X-Received: by 2002:a6b:dd12:: with SMTP id f18mr1938079ioc.109.1596491510169;
        Mon, 03 Aug 2020 14:51:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v63sm5891342ilk.67.2020.08.03.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:51:49 -0700 (PDT)
Received: (nullmailer pid 3201910 invoked by uid 1000);
        Mon, 03 Aug 2020 21:51:47 -0000
Date:   Mon, 3 Aug 2020 15:51:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Subject: Re: [PATCH v2 1/5] dt-bindings: dma: dw: Add optional DMA-channels
 mask cell support
Message-ID: <20200803215147.GA3201744@bogus>
References: <20200731200826.9292-1-Sergey.Semin@baikalelectronics.ru>
 <20200731200826.9292-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731200826.9292-2-Sergey.Semin@baikalelectronics.ru>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 31 Jul 2020 23:08:22 +0300, Serge Semin wrote:
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
