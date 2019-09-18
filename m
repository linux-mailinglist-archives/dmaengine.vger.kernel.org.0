Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF86B645C
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2019 15:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfIRN2i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Sep 2019 09:28:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42928 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfIRN2h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Sep 2019 09:28:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so6299399otd.9;
        Wed, 18 Sep 2019 06:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NkZYaq2iZjzdrhEFixjMapWH/xPBRxX7c/SIzfnLapw=;
        b=rWCfFGwQ0abnPrj7JMkKhwmsqShZbL8CvMirVPr/8GVRAqt7WNH4nIXYySp1rIzjZi
         Id79UGEsgN82920pcfrP25pWdgJTANNDmF+F2/zYCpvywwkXv+oJEF9ifroc+DvNWFb9
         Dha0Hn6bFaGzbfs6WoZTymsSLzH222mNdLvugFJUUPF7T8/s5+vGWzIh/6OPO6oJVjbA
         JnMsYdniwtqYM/YVJO57Z3byPUQJ7ueMeVeAGWX/IYnFU/h9BOTFGFz1talweOymaFnB
         QQBsoNkBY9G9TiqC2kPVxvJeQatPotu5ejybWMKilhDR9sTvQbgTgzjypHUEcHS8ViUV
         tfXQ==
X-Gm-Message-State: APjAAAXbZDY9+wXatlj1aaHzzv/rM/PSA9UO2vCqsL3MSB4BdqxiRrDj
        VGa1+PCZ114ULFhVq6/dcQ==
X-Google-Smtp-Source: APXvYqzDcQJ+48SBzJT1crszQqE+NUEsQ0YhLMJVqMyGjF5xjZO/NZpG5waXv6rdmBqIgPUXqVwiuQ==
X-Received: by 2002:a9d:7354:: with SMTP id l20mr2964491otk.131.1568813316679;
        Wed, 18 Sep 2019 06:28:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h5sm1820349oth.29.2019.09.18.06.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 06:28:35 -0700 (PDT)
Date:   Wed, 18 Sep 2019 08:28:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: dmaengine: dma-common: Change
 dma-channel-mask to uint32-array
Message-ID: <20190918132835.GA4527@bogus>
References: <20190910114559.22810-1-peter.ujfalusi@ti.com>
 <20190910114559.22810-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910114559.22810-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 10, 2019 at 02:45:57PM +0300, Peter Ujfalusi wrote:
> Make the dma-channel-mask to be usable for controllers with more than 32
> channels.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/dma-common.yaml | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/Documentation/devicetree/bindings/dma/dma-common.yaml
> index ed0a49a6f020..41460946be64 100644
> --- a/Documentation/devicetree/bindings/dma/dma-common.yaml
> +++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
> @@ -25,11 +25,19 @@ properties:
>        Used to provide DMA controller specific information.
>  
>    dma-channel-mask:
> -    $ref: /schemas/types.yaml#definitions/uint32
>      description:
>        Bitmask of available DMA channels in ascending order that are
>        not reserved by firmware and are available to the
>        kernel. i.e. first channel corresponds to LSB.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          minItems = 1

'='? Just making up the syntax?

> +          maxItems = 255 # Should be enough
> +          - description: Mask of channels 0-31
> +          - description: Mask of channels 32-63

You are mixing a schema and list here...

> +          ...

That's end of doc marker in YAML...

> +          - description: Mask of chnanels X-(X+31)

Obviously, this was not validated with 'make dt_binding_check'. What you 
want is:

    allOf:
      - $ref: /schemas/types.yaml#/definitions/uint32-array
      - minItems: 1
        maxItems: 255 # Should be enough

Rob
