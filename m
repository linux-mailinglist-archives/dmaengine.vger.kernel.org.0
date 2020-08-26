Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF3253168
	for <lists+dmaengine@lfdr.de>; Wed, 26 Aug 2020 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHZOft (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Aug 2020 10:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgHZOfm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 26 Aug 2020 10:35:42 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD18A214F1;
        Wed, 26 Aug 2020 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598452541;
        bh=5o+Weq2TI4lpoW9aAd1oqeAnn8E4uK9m6ij1jx6/Jso=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XB9DLQ8Znxu1bqvlC1oq23FDxPprGSx+e/i56odL7DPq4b6eHm0qmNoy1CcePIjJG
         KezPc1OvHfS0Z7iCq3BtlBHz9tAwN4ZjFw6dlf3YFS4FB8SuAclBY5zd14H/c2snSk
         hrl5jxNOVqkgna5cgY9XLAyzsAii0rvBI58OJOyg=
Received: by mail-oi1-f172.google.com with SMTP id z22so1709992oid.1;
        Wed, 26 Aug 2020 07:35:41 -0700 (PDT)
X-Gm-Message-State: AOAM530YaQ4FtK44uhoCK+tdoUZJ/CH5MH2lCjphMjtOXqE0oBTLrCbF
        4u76pZcaq2EEbBxsEbkGBIAJBqPZCHp8sQsQkQ==
X-Google-Smtp-Source: ABdhPJznMyrXHCgvGOzyNLJmvN6N6XMX+bu9hHdgp3ZYk8rqYBdiOPxYXKrvW0Oz4r/BHJoVj5hanNU41lF2nUGIbiU=
X-Received: by 2002:aca:d5c4:: with SMTP id m187mr2683714oig.106.1598452540969;
 Wed, 26 Aug 2020 07:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200824084712.2526079-1-vkoul@kernel.org> <20200824084712.2526079-2-vkoul@kernel.org>
 <20200824174009.GA2948650@bogus> <20200825145131.GS2639@vkoul-mobl> <20200826063246.GW2639@vkoul-mobl>
In-Reply-To: <20200826063246.GW2639@vkoul-mobl>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Aug 2020 08:35:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKwwirYhrQxCkoUCVnZa_7yNsBDaqgc5TWbLLpeGv17Zw@mail.gmail.com>
Message-ID: <CAL_JsqKwwirYhrQxCkoUCVnZa_7yNsBDaqgc5TWbLLpeGv17Zw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Document qcom,gpi dma binding
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 26, 2020 at 12:32 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 25-08-20, 20:21, Vinod Koul wrote:
> > Hey Rob,
> >
> > On 24-08-20, 11:40, Rob Herring wrote:
> > > On Mon, 24 Aug 2020 14:17:10 +0530, Vinod Koul wrote:
> > > > Add devicetree binding documentation for GPI DMA controller
> > > > implemented on Qualcomm SoCs
> > > >
> > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/dma/qcom-gpi.yaml     | 87 +++++++++++++++=
++++
> > > >  1 file changed, 87 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/dma/qcom-gpi.=
yaml
> > > >
> > >
> > >
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/=
dma/qcom-gpi.yaml: properties:qcom,ev-factor: {'description': 'Event ring t=
ransfer size compare to channel transfer ring. Event ring length =3D ev-fac=
tor * transfer ring size', 'maxItems': 1} is not valid under any of the giv=
en schemas (Possible causes of the failure):
> > >     /builds/robherring/linux-dt-review/Documentation/devicetree/bindi=
ngs/dma/qcom-gpi.yaml: properties:qcom,ev-factor: 'not' is a required prope=
rty
> >
> > Okay updating dt-schema I do see this, now the question is what is this
> > and what does it mean ;-) I am not sure I comprehend the error message.
> > I see this for all the new properties I added as required for this
> > device node
>
> Okay I think I have figured it out, I need to provide ref to
> /schemas/types.yaml#definitions/uint32 for this to work, which does
> makes sense to me.
>
>   qcom,max-num-gpii:
>     $ref: /schemas/types.yaml#definitions/uint32
>     maxItems: 1

uint32 is always 1 item, so drop. Is there a max value you can define?
Otherwise, up to 2^32 - 1 is valid.

>     description:
>       Number of GPII instances
>
> Looks good to schema tool
>
> --
> ~Vinod
