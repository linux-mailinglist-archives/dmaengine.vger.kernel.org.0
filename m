Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B7F376B81
	for <lists+dmaengine@lfdr.de>; Fri,  7 May 2021 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhEGVPj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 May 2021 17:15:39 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41561 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGVPi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 May 2021 17:15:38 -0400
Received: by mail-ot1-f50.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so2774485oth.8;
        Fri, 07 May 2021 14:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7veamalGpZ3JPYDEzgwvaohfG+qmQaU3ikes2gGH9cY=;
        b=so6LJ1RBcGzpR+s3GBJ2bspHXUghZvAg8bmKPaIsOa7VtNbOzkDEcmO/jsRPzWHM7d
         RXL4OfYKw7eEed+8cUyCxuXVGHgXHUgnyhXePc+MOyJSt83qZb/OxAZnXhWaDtwjDaf0
         F1PEywpwxdDK0q1XZ1IA+VjzUtkI4cZbRygdEaU8ZqTgjFWkz77LumaLSa7rRawm5cmX
         zDioXvOsesDO/U9jpUwGzU9I2oWKR/hFo33yKBR8WuirO4hWSFVzFB0OBz8IUWYImdJ/
         iKMPjy3ytRqPCXq07ZG5fDU5HoqG+vcjFXwR8NfOrgZcsa+MyQi0mFzgfM05vWhKA2MY
         PdxQ==
X-Gm-Message-State: AOAM530VTkZ1a1F7jQGCLiz+ERkiHNEIXWA0ZLcPoww3f3+k6+1/UDaQ
        0dnlmFOPpFji2yd976mieJJ73lBHEg==
X-Google-Smtp-Source: ABdhPJws1frb5rRP1SOGObFpTLxgTjiWmAFCGMur/wBJeGgvCd26jhJ/gW4kSV1Zn+ctT9nDKHskEA==
X-Received: by 2002:a9d:7593:: with SMTP id s19mr10190187otk.268.1620422076830;
        Fri, 07 May 2021 14:14:36 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c18sm128622otm.1.2021.05.07.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 14:14:35 -0700 (PDT)
Received: (nullmailer pid 2897610 invoked by uid 1000);
        Fri, 07 May 2021 21:14:34 -0000
Date:   Fri, 7 May 2021 16:14:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: Re: [PATCH v2 00/17]  Enable Qualcomm Crypto Engine on sm8250
Message-ID: <20210507211434.GA2879094@robh.at.kernel.org>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 06, 2021 at 03:07:14AM +0530, Bhupesh Sharma wrote:
> Changes since v1:
> =================
> - v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20210310052503.3618486-1-bhupesh.sharma@linaro.org/ 
> - v1 did not work well as reported earlier by Dmitry, so v2 contains the following
>   changes/fixes:
>   ~ Enable the interconnect path b/w BAM DMA and main memory first
>     before trying to access the BAM DMA registers.
>   ~ Enable the interconnect path b/w qce crytpo and main memory first
>     before trying to access the qce crypto registers.
>   ~ Make sure to document the required and optional properties for both
>     BAM DMA and qce crypto drivers.
>   ~ Add a few debug related print messages in case the qce crypto driver
>     passes or fails to probe.
>   ~ Convert the qce crypto driver probe to a defered one in case the BAM DMA
>     or the interconnect driver(s) (needed on specific Qualcomm parts) are not
>     yet probed.
> 
> Qualcomm crypto engine is also available on sm8250 SoC.
> It supports hardware accelerated algorithms for encryption
> and authentication. It also provides support for aes, des, 3des
> encryption algorithms and sha1, sha256, hmac(sha1), hmac(sha256)
> authentication algorithms.
> 
> Tested the enabled crypto algorithms with cryptsetup test utilities
> on sm8250-mtp and RB5 board (see [1]).
> 
> While at it, also make a minor fix in 'sdm845.dtsi', to make
> sure it confirms with the other .dtsi files which expose
> crypto nodes on qcom SoCs.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bhupesh.linux@gmail.com
>  
> Bhupesh Sharma (14):
>   dt-bindings: qcom-bam: Add 'interconnects' & 'interconnect-names' to
>     optional properties
>   dt-bindings: qcom-bam: Add 'iommus' to required properties
>   dt-bindings: qcom-qce: Add 'iommus' to required properties
>   dt-bindings: qcom-qce: Add 'interconnects' and move 'clocks' to
>     optional properties
>   arm64/dts: qcom: sdm845: Use RPMH_CE_CLK macro directly
>   dt-bindings: crypto : Add new compatible strings for qcom-qce

Please convert these bindings to schemas.


>   arm64/dts: qcom: Use new compatibles for crypto nodes
>   crypto: qce: Add new compatibles for qce crypto driver
>   crypto: qce: Print a failure msg in case probe() fails
>   crypto: qce: Convert the device found dev_dbg() to dev_info()
>   dma: qcom: bam_dma: Create a new header file for BAM DMA driver
>   crypto: qce: Defer probing if BAM dma is not yet initialized
>   crypto: qce: Defer probe in case interconnect is not yet initialized
>   arm64/dts: qcom: sm8250: Add dt entries to support crypto engine.
> 
> Thara Gopinath (3):
>   dma: qcom: bam_dma: Add support to initialize interconnect path
>   crypto: qce: core: Add support to initialize interconnect path
>   crypto: qce: core: Make clocks optional
> 
>  .../devicetree/bindings/crypto/qcom-qce.txt   |  22 +-
>  .../devicetree/bindings/dma/qcom_bam_dma.txt  |   5 +
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |   6 +-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          |  28 ++
>  drivers/crypto/qce/core.c                     | 112 +++++--
>  drivers/crypto/qce/core.h                     |   3 +
>  drivers/dma/qcom/bam_dma.c                    | 306 ++----------------
>  include/soc/qcom/bam_dma.h                    | 290 +++++++++++++++++
>  9 files changed, 457 insertions(+), 317 deletions(-)
>  create mode 100644 include/soc/qcom/bam_dma.h
> 
> -- 
> 2.30.2
> 
