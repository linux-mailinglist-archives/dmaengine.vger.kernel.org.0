Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ED2285257
	for <lists+dmaengine@lfdr.de>; Tue,  6 Oct 2020 21:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgJFTYD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Oct 2020 15:24:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43212 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgJFTYD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Oct 2020 15:24:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id n61so13360254ota.10;
        Tue, 06 Oct 2020 12:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e5c17+l70lnKi26mqSACtmJRwz5/sBAePFA0C8/p9hU=;
        b=alG0xEdX+KWa6X+VAHdITKqzdWBpPQ+VJ63RtTA2zBAeZkNk9X0o1Fvzh1sCfz68cy
         2P90H0MEBPA4+rRoGk048EYIkuEQkrOoTrDfDmV6JsTd8CF9SS91JZlstwfDE65Ly5L7
         z18435t/Qlv+FfNpdip7DmdaXuTbbZuWtmv2Qv1PjBAwHkjz2p23AS1s2uGVmzWwb0Wu
         0peLoYbVC8QZPRUsZAZ3NA0Wyxc3MqZalyzzOhEZw0P91NIeJHFZoglZvMALse8WkK8J
         SoeGRGA17SDTxmIaH3tlz5Ze+0zuL7EeeZ91okR6er4WeNahlEsn6wBMZPCy7Q05LVF+
         qsyA==
X-Gm-Message-State: AOAM531hoEte5U57XwbiY+jVUV8/RVczx9mm2y0xzaim6rMu127lyJwy
        exk6LTuwz6bOnwd92LdKyA==
X-Google-Smtp-Source: ABdhPJyrGr2h285NvWtfE5XgO+Lp2KkjAs6EAyCYJrD1o/BAOstQwbfLIYZ2uORxXTP8lYQ9tc1uyA==
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr3763871oti.333.1602012241192;
        Tue, 06 Oct 2020 12:24:01 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a82sm1601126oii.44.2020.10.06.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:24:00 -0700 (PDT)
Received: (nullmailer pid 2678887 invoked by uid 1000);
        Tue, 06 Oct 2020 19:23:59 -0000
Date:   Tue, 6 Oct 2020 14:23:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, nm@ti.com, ssantosh@kernel.org, vigneshr@ti.com,
        dan.j.williams@intel.com, t-kristo@ti.com, lokeshvutla@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/18] dt-bindings: dma: ti: Add document for K3 BCDMA
Message-ID: <20201006192359.GA2667071@bogus>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-10-peter.ujfalusi@ti.com>
 <9b0cea1e-c9c3-b38f-2bf1-1501133c16ae@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b0cea1e-c9c3-b38f-2bf1-1501133c16ae@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Oct 01, 2020 at 09:49:43AM +0300, Peter Ujfalusi wrote:
> Hi Rob,
> 
> On 30/09/2020 12.14, Peter Ujfalusi wrote:
> > New binding document for
> > Texas Instruments K3 Block Copy DMA (BCDMA).
> > 
> > BCDMA is introduced as part of AM64.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> >  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 183 ++++++++++++++++++
> >  1 file changed, 183 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> > new file mode 100644
> > index 000000000000..c84fb641738f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> > @@ -0,0 +1,183 @@
> 
> ...
> 
> > +  compatible:
> > +    enum:
> > +      - ti,am64-dmss-bcdma
> 
> Would it be OK if I use ti,am64x-dmss-bcdma or should I stick with
> am64-dmss-bcdma.

'ti,am654.*' was used pretty consistently, is this family different?

> The TRM refers to the family as AM64x, but having the 'x' in the
> compatible did not sounded right.

We generally don't want wildcards, but if the last digit is just pinout 
or fusing differences, then it's fine IMO.

Bottomline, just be consistent across all the compatible strings for 
this SoC.

Rob

