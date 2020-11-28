Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4202C70F9
	for <lists+dmaengine@lfdr.de>; Sat, 28 Nov 2020 22:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390081AbgK1Vum (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 Nov 2020 16:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732624AbgK1TCY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 28 Nov 2020 14:02:24 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63696C094268
        for <dmaengine@vger.kernel.org>; Fri, 27 Nov 2020 23:29:54 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id l11so3737109plt.1
        for <dmaengine@vger.kernel.org>; Fri, 27 Nov 2020 23:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WGKj1IfcrEj7NHZycKjkVZobn+jBjIFjVn+ZsQVanao=;
        b=J5ihOfoFgimbDpqbPMgUF0DzsQ5JHfFZi6ghTBd9NOIQ9ROMWQ1bll6AadCueUdZ2p
         oMpX3NODVKLeTuIGGiCA9VTlJ0l/I7ODvlDnQdmIlaNEWsLuNuXF18bJng8qkL58yyp7
         mkyaBdkHblcxZv3EGzNhsdXVnHcWrFNuCSaJDkZITuZU8+t+x6B7qERTyF/MCiyWLmAV
         IcfTn/u5qN8Of8uY3fGu7jSHVq08LFjRL+P1Ps3xS8k7/ME2dTjOl5+pYCfR9Yt8xgmF
         7uKQ80DfRPw5j0ZLHLUBWNbM8wuNn2SZmsT9iTYXiUERebhxnZ9Y0Pt3BY8Q9Vk3XUu3
         GUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGKj1IfcrEj7NHZycKjkVZobn+jBjIFjVn+ZsQVanao=;
        b=EMMyxHWMxjdTuFTGqexUB8jsX6eDiAUZCvPpvdltUVToRcoXJDrsntl8ZMzg3PyyKa
         tKEV8S1NtGwZLjJeDUD6znuVG9WCoaW3PWqP2Y4/57LMRoo+/fhEzwXIOC8yMJbL5z4+
         /+bEaHMymJ8DyGTlEdY1wHKVkkukqK32UTwe51Kjaz3zyRl41KZLicSI56BTCc/O+TMk
         GkMGXkRixSo0R+pGNRX3PzQQD4z3P7L+xk3tFsSSdBsxAt0mgwDOzGvJbJ1cDIouPsNY
         HiXv2+PlFTPDh/1nEneQbhdFX+alLGol4LScpXhhEitRGnxW9cX+JyLlvDQl03oIIkOs
         1XCg==
X-Gm-Message-State: AOAM532FBEFbKdeOlJh+vX4IR88pEu3wMu6FrdyfWeBslTgeCQjSTHLQ
        j40d68vDdVZPn1C6EKf9LS7K
X-Google-Smtp-Source: ABdhPJzRX52ukzfEsqSGexNjKoFSbiZSGU8BsPO1JkZ5EFIrpK2FYXNVPaw6j6bb1dMs/lYcLdGB1A==
X-Received: by 2002:a17:902:8f82:b029:da:23e0:17d7 with SMTP id z2-20020a1709028f82b02900da23e017d7mr10409200plo.37.1606548593900;
        Fri, 27 Nov 2020 23:29:53 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id p15sm13528590pjg.21.2020.11.27.23.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:29:53 -0800 (PST)
Date:   Sat, 28 Nov 2020 12:59:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/18] dt-bindings: dma: owl: Add compatible string
 for Actions Semi S500 SoC
Message-ID: <20201128072945.GT3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <0e79dffdf105ded2bb336ab38dc39b4986667683.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e79dffdf105ded2bb336ab38dc39b4986667683.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Nov 20, 2020 at 01:55:58AM +0200, Cristian Ciocaltea wrote:
> Add a new compatible string corresponding to the DMA controller found
> in the S500 variant of the Actions Semi Owl SoCs family.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/owl-dma.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/owl-dma.yaml b/Documentation/devicetree/bindings/dma/owl-dma.yaml
> index 256d62af2c64..f085f0e42d2c 100644
> --- a/Documentation/devicetree/bindings/dma/owl-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/owl-dma.yaml
> @@ -8,8 +8,8 @@ title: Actions Semi Owl SoCs DMA controller
>  
>  description: |
>    The OWL DMA is a general-purpose direct memory access controller capable of
> -  supporting 10 and 12 independent DMA channels for S700 and S900 SoCs
> -  respectively.
> +  supporting 10 independent DMA channels for the Actions Semi S700 SoC and 12
> +  independent DMA channels for the S500 and S900 SoC variants.
>  
>  maintainers:
>    - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> @@ -22,6 +22,7 @@ properties:
>      enum:
>        - actions,s900-dma
>        - actions,s700-dma
> +      - actions,s500-dma

I think we should order the entries now...

>  
>    reg:
>      maxItems: 1
> -- 
> 2.29.2
> 
