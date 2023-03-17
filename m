Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5D6BF395
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 22:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCQVJm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCQVJl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 17:09:41 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6678CC66F;
        Fri, 17 Mar 2023 14:09:40 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id b5so2905996iow.0;
        Fri, 17 Mar 2023 14:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679087379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJjkdUcY9AWxCDvg4UhtGFEbpOz8FP6Z6hjJ4WNipBE=;
        b=4yVxfh7rZvAtGJliGbFiidCmz+jB3r7cz85XTu28O2Fzg8mF+Z97DOT8CJ59zA/zx0
         OM350GMGgEtVlbtnMz3IQcJOuOGSf+yGsAc+9wcDunda5M+MiakOdPQWVsHFnta15mYN
         +yRZLiXpfBqz1Hibz4qEuA3o9HrcPTpT0XN4lc0Bl4NfOcJQ+QeXsGka/k4e+B1+P6DW
         nEmSUf61ld54U3O1xH22bbkplVCV3C9OfYI70GEA43hF4UAebPkrVoHir52zHEWCY8iy
         SD/1bzEsH1PpaqNCItpZq4mFwYOPeXxz+HFblZhQBuhswdkNbdCh5wdMd+FQxzIjyj7c
         o6HQ==
X-Gm-Message-State: AO0yUKW9/Xq+5tO5fzCedQNFjdOFe371o11UoQRHa8/15U5dcxPfzm40
        fzKE6VFB7ACyBb4O5jrw2Q==
X-Google-Smtp-Source: AK7set/ZUv+aH87BKtKr6DwPjobM7Ae5IZJ5lDL9yd5h2e+8QMtJhjH+new0tYZcxWxEgjV2zx9+BA==
X-Received: by 2002:a5e:8c1a:0:b0:74e:3b0f:4498 with SMTP id n26-20020a5e8c1a000000b0074e3b0f4498mr30945ioj.7.1679087379656;
        Fri, 17 Mar 2023 14:09:39 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id x11-20020a056638248b00b0040637924a30sm598205jat.31.2023.03.17.14.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:09:39 -0700 (PDT)
Received: (nullmailer pid 2809946 invoked by uid 1000);
        Fri, 17 Mar 2023 21:09:38 -0000
Date:   Fri, 17 Mar 2023 16:09:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: dma: snps,dw-axi-dmac: constrain the
 items of resets for JH7110 dma
Message-ID: <167908737748.2809883.11210849394769213152.robh@kernel.org>
References: <20230314083537.22571-1-walker.chen@starfivetech.com>
 <20230314083537.22571-2-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314083537.22571-2-walker.chen@starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Tue, 14 Mar 2023 16:35:35 +0800, Walker Chen wrote:
> The DMA controller needs two reset items to work properly on JH7110 SoC,
> so there is need to constrain the items' value to 2, other platforms
> have 1 reset item at most.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

