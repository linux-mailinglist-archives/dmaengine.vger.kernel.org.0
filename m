Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6521D01D1
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 00:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgELWVK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 18:21:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43631 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgELWVK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 May 2020 18:21:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id a68so3372411otb.10;
        Tue, 12 May 2020 15:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6/cebIylIZ4MTdmg1CnMECP6VHPJ09UR8a7jhXPn6wA=;
        b=b3dDSZ6BjyLtKUrviXVar4vwSuVkOOxOgWHeT9Nx53Tr4HPqnBPuUDJroE41+Rvpke
         PdHWXTgUrMnLj+6UmjRdbGciixB63fnT4n13o5GeOrBOREeplZqDCkesRADRVB/d6vkA
         yflvpnq2UTLK2a57tWYhNuQR+EdWAVJpyUbb3YF7U6s5OX/sltDafLOAqZkC7rrWW56W
         iszhRoGQQcm7uWv34Ha72IS+zN/MUlnrBjhNKDJBT9daeYnd6LrhFE2foddglX75aQpU
         VYemaj5GYj53NzFiIicA11+txCcXdANcpv1RgxGjbuG2WCitmSx6n/sCSDcW7723V0TG
         UzhQ==
X-Gm-Message-State: AGi0PuZoAW1KYZ78rW2byoUMk7xQKBRjuIyo3pOavnBzCgLCn//B6y6V
        +CFSPpDq/mffbqfzLqoW0g==
X-Google-Smtp-Source: APiQypJ4YtarKBuwKIGRTKJ3QsG9NSJ0iv+AofyDMzrpFr/lgnbDWPs3vNIkeq4kpkrJX1xqiyVrtA==
X-Received: by 2002:a05:6830:2305:: with SMTP id u5mr6821054ote.29.1589322068730;
        Tue, 12 May 2020 15:21:08 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v207sm5606283oie.3.2020.05.12.15.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:21:08 -0700 (PDT)
Received: (nullmailer pid 7676 invoked by uid 1000);
        Tue, 12 May 2020 22:21:07 -0000
Date:   Tue, 12 May 2020 17:21:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 05/10] dt-bindings: renesas,rcar-dmac: Document
 r8a7742 support
Message-ID: <20200512222107.GA7623@bogus>
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588542414-14826-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun,  3 May 2020 22:46:49 +0100, Lad Prabhakar wrote:
> Renesas RZ/G SoC also have the R-Car gen2/3 compatible DMA controllers.
> Document RZ/G1H (also known as R8A7742) SoC bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
