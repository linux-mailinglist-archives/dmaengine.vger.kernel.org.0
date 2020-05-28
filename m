Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957341E6B26
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 21:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406634AbgE1Tgs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 15:36:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45740 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406319AbgE1Tgq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 15:36:46 -0400
Received: by mail-io1-f66.google.com with SMTP id y5so8596721iob.12;
        Thu, 28 May 2020 12:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=anLARnrJJYeYAOB5KTKHSKOnzH0boPrtofWMELzWPU8=;
        b=eszk8+Dr5DGsMPVkuuDZkT9s0FqOEuL1kSXDU6CHHdpAyv3w59G8WWWangxo2itI7P
         gdqo/85HaK7KV1rX91Tm/xqSvCXUQIWJLGSWEOPsbfb9Jek0r5nY6Pd9cMomYu3b5QdG
         TCkRoRjcXt5EzyBPYCfdagT+RCcARPRm1LhSEftBII4FSKFbwPF1ioV1QxX5kqHUsOh/
         6BBQuE6OH7gMfQqJg965LiGH+xTj+M3aSWJKtro02rXNBHZf0eAYqhkqV3i3D2ikH2c2
         espqQS17WeqLU0FNHkkk/Jy/i9yrNWyWmE9TOqorkJXyWlEU60T+zlJrqqdTW1NcJUUO
         G6xA==
X-Gm-Message-State: AOAM5331Wh+sRBbU3q3jArtjh/jDaaPjv5624qImiZdzwnCBUfJrKtjx
        rbXVztGWDclvMpWfPr9eorkUj2k=
X-Google-Smtp-Source: ABdhPJxAbgV9QaVK5dOC48fScjQWHA5Gld2FnTR86BVEq9Vbv9X4kGVbNWcHJZhyKd7pm6KmH4S+0Q==
X-Received: by 2002:a5d:88d3:: with SMTP id i19mr3781474iol.194.1590694605038;
        Thu, 28 May 2020 12:36:45 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v2sm1938613iol.36.2020.05.28.12.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:36:44 -0700 (PDT)
Received: (nullmailer pid 553763 invoked by uid 1000);
        Thu, 28 May 2020 19:36:42 -0000
Date:   Thu, 28 May 2020 13:36:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 03/10] dt-bindings: serial: renesas,scifa: Document
 r8a7742 bindings
Message-ID: <20200528193642.GA552811@bogus>
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200512222056.GA7267@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512222056.GA7267@bogus>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 12, 2020 at 05:20:56PM -0500, Rob Herring wrote:
> On Sun,  3 May 2020 22:46:47 +0100, Lad Prabhakar wrote:
> > RZ/G1H (R8A7742) SoC also has the R-Car gen2 compatible SCIFA ports,
> > so document the SoC specific bindings.
> > 
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  Documentation/devicetree/bindings/serial/renesas,scifa.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Geert asked me to apply this one, so I have now.

Rob
