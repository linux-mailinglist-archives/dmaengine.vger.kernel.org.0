Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8091AD05C
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 21:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgDPTbD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 15:31:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46070 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgDPTbD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Apr 2020 15:31:03 -0400
Received: by mail-oi1-f194.google.com with SMTP id k133so16854837oih.12;
        Thu, 16 Apr 2020 12:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=83Bpp8uoGsIBtYSm1pLHa49KTy+QHzu3gut9+0c+dz8=;
        b=TopJOVYfofkMbZWEQnGp6CQHzeW/Qkr2SU3dbBo5plbcWF9kGONV71XePyOyc8j04n
         4WQANmiwCFQN+qFeaUn0GMtU+F8mgGVD16zNdaS6FQfuY+OhdnjdnvQQQ9jLXo6/7tJh
         zLAdREQ9RGhGx3LljD/1G6zVGdeR+E9Dkg6TN/K1SG2RZDcuB5UExfqSUCYQXEzD1tME
         M4qhdlCRN86uXWo79h/3UqwygB1qHCQqn22VExgF4bNv42/lxDqfPqEP/2OIv6Jo6hwX
         JGEDBZuQ4bLSWmp+SX/o1wVmOOans4HTjxj5dsicl/O8KObepvlj6wo+qgx6SR01ZDF5
         phew==
X-Gm-Message-State: AGi0PubgDC5/SyIMJIBRD9zNa0LuS6vGNFj0zmLkbK3oJ2FPqiasA+/z
        HMvC0jtutea40czw6qv6qZ1DRbU=
X-Google-Smtp-Source: APiQypKtFNn7klGmlxS7O33zd15hLes5Ce7gwnHv476q+1Q8X3OSIexFGD7vX+EbNCMQi+0zLh3qvw==
X-Received: by 2002:aca:d705:: with SMTP id o5mr4155329oig.67.1587065461930;
        Thu, 16 Apr 2020 12:31:01 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r205sm7324602oih.47.2020.04.16.12.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 12:31:01 -0700 (PDT)
Received: (nullmailer pid 19733 invoked by uid 1000);
        Thu, 16 Apr 2020 19:31:00 -0000
Date:   Thu, 16 Apr 2020 14:31:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH trivial 1/6] dt-bindings: Fix misspellings of "Analog
 Devices"
Message-ID: <20200416193100.GA19671@bogus>
References: <20200416103058.15269-1-geert+renesas@glider.be>
 <20200416103058.15269-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416103058.15269-2-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 16 Apr 2020 12:30:53 +0200, Geert Uytterhoeven wrote:
> According to https://www.analog.com/, the company name is spelled
> "Analog Devices".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/display/bridge/adi,adv7123.txt        | 4 ++--
>  .../devicetree/bindings/display/bridge/adi,adv7511.txt        | 4 ++--
>  Documentation/devicetree/bindings/dma/adi,axi-dmac.txt        | 2 +-
>  Documentation/devicetree/bindings/iio/dac/ad5755.txt          | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 

Applied, thanks.

Rob
