Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0091D01DA
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 00:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgELWVb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 18:21:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38919 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgELWVb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 May 2020 18:21:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id b18so19702195oic.6;
        Tue, 12 May 2020 15:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dGN4MC63oAaFLWS1FU9HPXOdf8k7tfsvYs04gH7OMMQ=;
        b=R0UGMBwEtV9pQl+QM2hFRafhttCmBK0hbDGEiimg18yONaj7UviMDG5O6qv4rrejVa
         PjIVrR8NPtFipeA1lThl6NM6U4oIKWqh2X+D+KLtLLSeFZrRgQiUiY1F3yhkQE7utJT8
         bfTl4tBlnZro4r6FDsJmCTPTZjj5u//TroZeScHp3Tczv42Xb94+JuVSGzZ19Mml7rUq
         C+IpYXZ2L7s7gYNMNi+uDAvyt/MtJY01PWtVY1Bisk0e158PhLzeXuqlwhyWuwOV/4qZ
         IGYYDS+NNSUUZPWpfZ8VKWDUe0RYBbl73H26fmFnic184lHO3Gh+6L9jCza0APdjD6/f
         wl1Q==
X-Gm-Message-State: AGi0PuZOEWZa5Bp+QLbquGlo46Bx2D6dZUKRqr153tg6/R4J0Jxw8Heh
        p3i4/9CRzLgCJ3Yv5+l2bQ8of3T+mw==
X-Google-Smtp-Source: APiQypIN3U4l8U4merrU8veBw/lAownfhG1GfhPVs7K82f6EUlEjmDlDpCF8UcvavVqE6+eu4AT2Gw==
X-Received: by 2002:aca:b688:: with SMTP id g130mr25157672oif.36.1589322090504;
        Tue, 12 May 2020 15:21:30 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y10sm3946080ooq.2.2020.05.12.15.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:21:29 -0700 (PDT)
Received: (nullmailer pid 8279 invoked by uid 1000);
        Tue, 12 May 2020 22:21:28 -0000
Date:   Tue, 12 May 2020 17:21:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v2 07/10] dt-bindings: arm: Document
 iW-RainboW-G21M-Qseven-RZG1H system on module
Message-ID: <20200512222128.GA8223@bogus>
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588542414-14826-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun,  3 May 2020 22:46:51 +0100, Lad Prabhakar wrote:
> Document the iW-RainboW-G21M-Qseven-RZG1H device tree bindings,
> listing it as a supported system on module.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/renesas.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
