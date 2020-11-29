Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033FA2C7A7D
	for <lists+dmaengine@lfdr.de>; Sun, 29 Nov 2020 19:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgK2SQN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Nov 2020 13:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2SQM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Nov 2020 13:16:12 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D08BC0613CF;
        Sun, 29 Nov 2020 10:15:32 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id l5so12140462edq.11;
        Sun, 29 Nov 2020 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UROWP8DCGmWhVwQsCC8h2As9ZxZGQSky9i20Gey0Ido=;
        b=j0KFJ4xVFp4NC4WM62GakLO1fZKpiWbDq91qtHs3es1t3S+hxd81W2POHXZ9q7ejaH
         0q1XIHjqPvySc7Y7XrEA4QhTBoyQtopzTL5AeurZEms0/Oj9ld6nVWeaklnRir+C3cj2
         Qh3aRYUtd0KHGimvAjQNt7ITzmEfzqB6hrn5iCPNvbW5uv/28c7Y8ym8eQpBKGlDpkoC
         Ua0gfQ4FzGjk1HaWIAEUCWY03SzpLCdd/it/QA8vzBFsEQJNMXkM6nYS0CAwlLFwWkKn
         kNHlxAToZdbfXNNaJ49cBEFLPaiGgljrWdNWTn1lFxVZDZq/vGoU8BBy7jawENEmCmvs
         NnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UROWP8DCGmWhVwQsCC8h2As9ZxZGQSky9i20Gey0Ido=;
        b=szpP4laApo84zyWOGcdcojG9pQItrQqQu0tIfi9urbOnGNmMqd6wp30G1A0IkS2s9i
         M4ZkvLGobX7QxLll4ItN046oHHhV6uMm8mRrA9OU4CPOXx0xjNw9+9Ub20QX4uCs8gmj
         u9A7qaW0Lbp99+Vv0pgBc98qxA4UF78UoJQ0Cm3gHpG+6pHd3ATIu8v3N6nfhmn5+GPR
         /jLgxl//1fvVk+SjCl4MV463Akc5OWYeHmSqL/20U/hixPIrfrKJTs7240eeUNzE6Ajn
         Y9SOMQ2Yz4ArWTKpUjmWUuSg8vXSacZvAsnuu820gHjtsMLi699otW0E57iEM/FpM8RE
         TVww==
X-Gm-Message-State: AOAM533Si1b7JmQ6rXmPmfaLwnpQbmvEDaSFu4Z2g7+55CzgpYM0ha1o
        3AumNb/lKBTWyFtD3utR9gc=
X-Google-Smtp-Source: ABdhPJz/uzcYLzKhtpNOcOpAVXt/4u4Hf0bEUq9k0+3ONJkOQZta1Kwsu1fRVLNS8II8ISavlTSNRw==
X-Received: by 2002:a50:d884:: with SMTP id p4mr952137edj.120.1606673730918;
        Sun, 29 Nov 2020 10:15:30 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id n14sm8018943edw.38.2020.11.29.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 10:15:30 -0800 (PST)
Date:   Sun, 29 Nov 2020 20:15:27 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/18] dt-bindings: dma: owl: Add compatible string
 for Actions Semi S500 SoC
Message-ID: <20201129181527.GC696261@BV030612LT>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <0e79dffdf105ded2bb336ab38dc39b4986667683.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128072945.GT3077@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128072945.GT3077@thinkpad>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 28, 2020 at 12:59:45PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 20, 2020 at 01:55:58AM +0200, Cristian Ciocaltea wrote:
> > Add a new compatible string corresponding to the DMA controller found
> > in the S500 variant of the Actions Semi Owl SoCs family.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/dma/owl-dma.yaml | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/owl-dma.yaml b/Documentation/devicetree/bindings/dma/owl-dma.yaml
> > index 256d62af2c64..f085f0e42d2c 100644
> > --- a/Documentation/devicetree/bindings/dma/owl-dma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/owl-dma.yaml
> > @@ -8,8 +8,8 @@ title: Actions Semi Owl SoCs DMA controller
> >  
> >  description: |
> >    The OWL DMA is a general-purpose direct memory access controller capable of
> > -  supporting 10 and 12 independent DMA channels for S700 and S900 SoCs
> > -  respectively.
> > +  supporting 10 independent DMA channels for the Actions Semi S700 SoC and 12
> > +  independent DMA channels for the S500 and S900 SoC variants.
> >  
> >  maintainers:
> >    - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > @@ -22,6 +22,7 @@ properties:
> >      enum:
> >        - actions,s900-dma
> >        - actions,s700-dma
> > +      - actions,s500-dma
> 
> I think we should order the entries now...

Right, I will provide the reordered list in the upcoming revision.

> >  
> >    reg:
> >      maxItems: 1
> > -- 
> > 2.29.2
> > 
