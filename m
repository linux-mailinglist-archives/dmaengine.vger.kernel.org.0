Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00FD1A7F8D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Apr 2020 16:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389869AbgDNOVj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Apr 2020 10:21:39 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45526 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389867AbgDNOVf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Apr 2020 10:21:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id i22so3500879otp.12;
        Tue, 14 Apr 2020 07:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7qB5XS57n67MYXQJiHnjoHHOlP+v7Plet2PJhhKm2pA=;
        b=jZPc9OVz0u4J+Lh6oJ9Au+tRHl2cAeZnFKF2xyy28eD6ImyLsUAiiwFsd1NbfcPD0d
         +QrWHU600EA566PaS1SKY8TcwlR/Xe4xEiObo1IHRSm7qJCc/ulWMyx18rvps5/ENGWX
         /+Xrp11zIQmhNEVq9DC1nokOnMlhSwPh+OtP46uM2sMiReBS/o99n03aNoEPmykW6IjT
         cg+QJGKxReHnVwDCc5uyVUx1Bishagbw0U42KePffnGEGdnV3fDhWWHYW/GSWRMjkC54
         yKM5mkwljqLSPT0yZeQAI0L2h5e5RwafVCufuNgBnEVBj2gWGEO+5RCT5I2Z+XpzP5i9
         xkHQ==
X-Gm-Message-State: AGi0PuaZUiL6qKok2FgPEWxaDMeqUoNPYaP3hMuaRqnnlCqFdo3SrOlv
        PCXh49oeQ1ywYGroq32k4A==
X-Google-Smtp-Source: APiQypLoB//SQjLQBkpXtSSlfjCiCaFzojDq5PxSqn/uIWY6+9eAJg0r+nHSgJSEib1fkfvlSTLSsA==
X-Received: by 2002:a05:6830:1190:: with SMTP id u16mr19562600otq.83.1586874093641;
        Tue, 14 Apr 2020 07:21:33 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c7sm1257994otp.3.2020.04.14.07.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 07:21:32 -0700 (PDT)
Received: (nullmailer pid 18159 invoked by uid 1000);
        Tue, 14 Apr 2020 14:21:31 -0000
Date:   Tue, 14 Apr 2020 09:21:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: uniphier-xdmac: switch to single reg
 region
Message-ID: <20200414142131.GA18052@bogus>
References: <20200401032150.19767-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401032150.19767-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed,  1 Apr 2020 12:21:50 +0900, Masahiro Yamada wrote:
> The reg in the example "<0x5fc10000 0x1000>, <0x5fc20000 0x800>"
> is wrong. The register region of this controller is much smaller,
> and there is no other hardware register interleaved. There is no
> good reason to split it into two regions.
> 
> Just use a single, contiguous register region.
> 
> While I am here, I made the 'dma-channels' property mandatory because
> otherwise there is no way to determine the number of the channels.
> 
> Please note the original binding was merged recently. Since there
> is no user yet, this change has no actual impact.
> 
> Fixes: b9fb56b6ba8a ("dt-bindings: dmaengine: Add UniPhier external DMA controller bindings")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> We do not need to touch the driver either because the second
> region is not used.
> 
> 
>  .../devicetree/bindings/dma/socionext,uniphier-xdmac.yaml  | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
