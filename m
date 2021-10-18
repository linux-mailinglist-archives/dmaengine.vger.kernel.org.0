Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD74327F5
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 21:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhJRTxQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 15:53:16 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33534 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbhJRTxO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Oct 2021 15:53:14 -0400
Received: by mail-oi1-f181.google.com with SMTP id q129so1420019oib.0;
        Mon, 18 Oct 2021 12:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lf3qtAxK2ioLkCYFQ61b4Q438IlhGZsYG/jj2QqM7UU=;
        b=Zgk298lt7ejA3N1TYrRrIQPGeGTXJnbToYhRVFjex1cFjvu7AYmfoXnCHXZ/E2gCZ1
         lIyoLaTmU0s2KXuGlyWFLOuhkf731WeQApRy85wPhVpt1hFI9QelJFgtzAWwY1HbbINc
         Q9WQ/8m3jWcqoS4b+q7jtt2I9EKFmba5pEHKAHQMyhg/tU5nqFhhGslRvUG6zTlBQk7i
         iZVquoHAKenHTUiPvmlC+AUf6rZB8aDhExtpbsP338GIjl/Ear6pB+SoZCgcryPv5j3R
         rpNZ2xvNTk6qwcyBN8VO40ncvaGaFG4reoXw93GfLh8moJzyUzYZ6Ama8nsOczGMwdjn
         yyMg==
X-Gm-Message-State: AOAM5337pOeowPq+HIAWIgrL043Q874nMotVoonAUaQ7YKiHa808e0s2
        /APSKWx/sZOOUKE3Nl3uwPOEzVkiiw==
X-Google-Smtp-Source: ABdhPJwy38f+G119ZJbY4wMzLDCMvMfqXcc7P7WcoSVKfwmQEz684171NnJwHyQXIn1sft4nIxhP7w==
X-Received: by 2002:aca:1e04:: with SMTP id m4mr714654oic.67.1634586661558;
        Mon, 18 Oct 2021 12:51:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb39sm3360644oib.28.2021.10.18.12.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:51:01 -0700 (PDT)
Received: (nullmailer pid 2839571 invoked by uid 1000);
        Mon, 18 Oct 2021 19:51:00 -0000
Date:   Mon, 18 Oct 2021 14:51:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: dmaengine: bam_dma: Add "powered
 remotely" mode
Message-ID: <YW3QJJoprJgre/sg@robh.at.kernel.org>
References: <20211018102421.19848-1-stephan@gerhold.net>
 <20211018102421.19848-2-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018102421.19848-2-stephan@gerhold.net>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 18 Oct 2021 12:24:20 +0200, Stephan Gerhold wrote:
> In some configurations, the BAM DMA controller is set up by a remote
> processor and the local processor can simply start making use of it
> without setting up the BAM. This is already supported using the
> "qcom,controlled-remotely" property.
> 
> However, for some reason another possible configuration is that the
> remote processor is responsible for powering up the BAM, but we are
> still responsible for initializing it (e.g. resetting it etc). Add
> a "qcom,powered-remotely" property to describe that configuration.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Changes in v3: None, split from BAM-DMUX patch set
> Changes since RFC:
>   - Rename qcom,remote-power-collapse -> qcom,powered-remotely
>     for consistency with "qcom,controlled-remotely"
> 
> Also note that there is an ongoing effort to convert these bindings
> to DT schema but sadly there were not any updates for a while. :/
> https://lore.kernel.org/linux-arm-msm/20210519143700.27392-2-bhupesh.sharma@linaro.org/
> ---
>  Documentation/devicetree/bindings/dma/qcom_bam_dma.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
