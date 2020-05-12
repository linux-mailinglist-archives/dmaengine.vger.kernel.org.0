Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606F91D01CC
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 00:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgELWVB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 18:21:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34578 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbgELWVA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 May 2020 18:21:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id c12so18700569oic.1;
        Tue, 12 May 2020 15:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HI6M3Tm4TpML6+cggVlwk+vv167haIyI4tyVcZNP3KQ=;
        b=dw03NVLyK7S+UHp5uezY5fIRuLA9MCSvO//FaeZNHvNtKdk2WIddiHDajpZ9SwvffW
         mpzQ1QXB0SIaUhiB5TQkLvapQVpxr5v0qu3ERnnxdcJr9n6PYfXhSb8ODO7fhxmWZQvw
         A1Aadp2tq5dytWbpBELEOQkmLz5Q1tH1ZRDr56VkGZln9quwXqZq9tRRsm4kSWhfjzXr
         0XluLU5RLGQkgJOb0f80HyFyNwkeK5FOstvE+Dfh7V4tSUfvJ6bbxsnNMb9c9cD6X+MW
         IaXzGmFiuFuElxuQMnKTJFDI1+y8LSQONLHrp2T3bYyOMvwNripz58q8T5Y7fRfhscPT
         fgVw==
X-Gm-Message-State: AGi0Pub3uPAOh2XOnwXOQ3mdBPLGM0FF04qMkhtBeX8wZPDvu/LspeRm
        WNCIvwa3w/1x1hT/SFTzSe/HGO1P/g==
X-Google-Smtp-Source: APiQypKXsoHwx9I8h2xUXLcsdty5FGPGpdqe1TAqSxdrj7J65UNFT3xz2mpAQiFvE7UuzNy4B6XaoA==
X-Received: by 2002:aca:5843:: with SMTP id m64mr4021981oib.83.1589322058334;
        Tue, 12 May 2020 15:20:58 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s69sm3776453otb.4.2020.05.12.15.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:20:57 -0700 (PDT)
Received: (nullmailer pid 7320 invoked by uid 1000);
        Tue, 12 May 2020 22:20:56 -0000
Date:   Tue, 12 May 2020 17:20:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 03/10] dt-bindings: serial: renesas,scifa: Document
 r8a7742 bindings
Message-ID: <20200512222056.GA7267@bogus>
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588542414-14826-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun,  3 May 2020 22:46:47 +0100, Lad Prabhakar wrote:
> RZ/G1H (R8A7742) SoC also has the R-Car gen2 compatible SCIFA ports,
> so document the SoC specific bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/serial/renesas,scifa.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
