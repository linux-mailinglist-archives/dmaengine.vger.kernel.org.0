Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD05F1D01E1
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 00:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbgELWVu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 18:21:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44170 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730208AbgELWVt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 May 2020 18:21:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id j4so11857291otr.11;
        Tue, 12 May 2020 15:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aI2YRGhYgKbm+SOd+W2xRJ/1uor/7vyi1g5Td1LZl/c=;
        b=LZlxV+xE+axqIVKbeqp5nyg9tqDXRPSAtA5iMuOwb65OCMFLUJgrkfxFRM5W4XwehY
         xSiCzN/L6YjMEaP2zwiLjCgFJQGOIZ/rieWjc/JMjukavEY/ZXH8yxk+4fs1e92Fep7v
         MTvGbuXgfvkeYgoCnoN+TwzGHGM3k+I0qIST7VPGOJk99/bA/YfhVVMjtvJOxfr4qjdw
         wbKO4WMh87T5icQSzSX64BoY6iTnsvUgOA8mj8PESBGdJdDoOfUUHqsxGN858plRqcf4
         7VaTqe6U5OIvIV2x0z7q31SWAkLHqyT8gWFP2hOGD/qKKtj9j7RRxZGC+xGI1yGA7X+P
         y7Ag==
X-Gm-Message-State: AGi0PuYAPlfX975ENrwwD5BkGYusfFP1jE5jw1UPqg85qAu0iJGoJUg6
        LBQMCdnyznRXcDJPEODRFA==
X-Google-Smtp-Source: APiQypIbYAt7h1/ABNVeIx8QPnyWkap/X0BFQt/FS3aiaRSTm0AImbkDARk+GurtgZ+SRhH+VQ1yog==
X-Received: by 2002:a05:6830:2386:: with SMTP id l6mr19264727ots.128.1589322108504;
        Tue, 12 May 2020 15:21:48 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v207sm5606637oie.3.2020.05.12.15.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:21:47 -0700 (PDT)
Received: (nullmailer pid 8829 invoked by uid 1000);
        Tue, 12 May 2020 22:21:46 -0000
Date:   Tue, 12 May 2020 17:21:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 08/10] dt-bindings: arm: Document
 iW-RainboW-G21D-Qseven-RZG1H board
Message-ID: <20200512222146.GA8782@bogus>
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588542414-14826-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun,  3 May 2020 22:46:52 +0100, Lad Prabhakar wrote:
> Document the iW-RainboW-G21D-Qseven-RZG1H device tree bindings,
> listing it as a supported board.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/renesas.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
