Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D462FDE25
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 01:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbhAUA0I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jan 2021 19:26:08 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41115 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbhATVlz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Jan 2021 16:41:55 -0500
Received: by mail-ot1-f54.google.com with SMTP id x13so24835259oto.8;
        Wed, 20 Jan 2021 13:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MrKL8gjoyGmvlmBXgA4XpfrQe0f/VW0VhPRoaZ25DFs=;
        b=G9UgoAOKTEt/1BZarRN440SId5G3/Xn6/urmXTEV6VsOypXE+1trbgpodJ8R0wzliK
         /VvrNT5NC+88s1NmBakdrmILBBUy7LswERZrFr09vv3kWjvsUJ5ITj/eCKu+DXoKzoKU
         pvaQ9TAn9CkHx+2iGKRcGFQNYUBheWiFCwelQwLeYBgdmK2IGmyouZyr3i+MT7AJp9su
         DN95ljrF5O69BZXLzmQOlvi5UH5FcreGe+AeTM5ytmce3GPx9nlgxGrq7kWKbjYA4lcq
         b4e6NksuhzFwEH3PXcxX0dLqUZrYrCHayZZIcWraGzGBq2efKCMTJ4ygRp5rmCV44Rg0
         7/bQ==
X-Gm-Message-State: AOAM533XyvCxs3pRY6CqvRxCNau7paxXo8MMj6QD1DjCHLYqwvw3AGGd
        XbwNPJwfzk1SMHNvXr3b4A==
X-Google-Smtp-Source: ABdhPJxMxzyuOzJcSq/3iLfcts26sCNq1EF0KgkwK09bECdXRa6oOCkyn4CG17+TMJr6SicRrQhv/A==
X-Received: by 2002:a05:6830:90a:: with SMTP id v10mr8424357ott.364.1611178869954;
        Wed, 20 Jan 2021 13:41:09 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q127sm653865oia.18.2021.01.20.13.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:41:07 -0800 (PST)
Received: (nullmailer pid 884108 invoked by uid 1000);
        Wed, 20 Jan 2021 21:41:06 -0000
Date:   Wed, 20 Jan 2021 15:41:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, chuanhua.lei@intel.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: intel-ldma: Fix $ref specifier
Message-ID: <20210120214106.GA884032@robh.at.kernel.org>
References: <20210120180939.1580984-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120180939.1580984-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 20 Jan 2021 10:09:39 -0800, Bjorn Andersson wrote:
> The $ref for "intel,dma-poll-cnt" is missing an '/', causing
> dt_binding_check to fail. Fix this.
> 
> Fixes: afd4df85602d ("dt-bindings: dma: Add bindings for Intel LGM SoC")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/intel,ldma.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
