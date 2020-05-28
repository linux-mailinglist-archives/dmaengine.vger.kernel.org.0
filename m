Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075A81E708B
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 01:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437508AbgE1XnU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 19:43:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46898 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437503AbgE1XnS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 19:43:18 -0400
Received: by mail-io1-f68.google.com with SMTP id j8so379189iog.13;
        Thu, 28 May 2020 16:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X4P5cAAR887DNWxh4WskIGj1izCGidkfB+Pfk93nqy0=;
        b=LLf1vQCnaHazVEFjqJce2Qq3pb+qXXKoUuwSnZecs6MzgCzlth/4TplghjGVaJ0cNi
         M1gWWaxp5wvbh7CAOkKramwJMrvHXR9agKDT/WEPq21mW8sCDJz5xr6VWppzIcs9JWW2
         NOLYhsMeo9C76VX/G9UdfZX4+DG8LYrU3Y2+ZOo/871uDzGLHe4mYHYYwR9kimf9ZENC
         Cl4NhlYNSwOL4Ayl6E9ArreZWTIlC2sDUcGm0Xx/76V3Ivz9CDcwJwzrdtMWtHpQmiJD
         /rkSYBdSuJpXV3Lw41LTw8Whhk6QCFY1txlEIxqgjffYktsECMUPTfwmrGDEcGnZ2K/6
         duCw==
X-Gm-Message-State: AOAM530YTDyeXuyYa4EJMxExWICfuDIMmnJMgCeBV29BNK+gveiuTqO/
        Zdh4rziOneEnXF3pkBomMg==
X-Google-Smtp-Source: ABdhPJyt0fkpS/3WLGVpB36ef/4na3oV+ZxN0Jj7Ovu7tYSb4cvCrjCF5L+csGkz2rNHbGxigRO8Ig==
X-Received: by 2002:a02:cc36:: with SMTP id o22mr4942045jap.58.1590709397782;
        Thu, 28 May 2020 16:43:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o12sm3093192iob.6.2020.05.28.16.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:43:17 -0700 (PDT)
Received: (nullmailer pid 900471 invoked by uid 1000);
        Thu, 28 May 2020 23:43:15 -0000
Date:   Thu, 28 May 2020 17:43:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/8] dt-bindings: phy: rcar-gen2: Add r8a7742 support
Message-ID: <20200528234315.GA900312@bogus>
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590356277-19993-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, 24 May 2020 22:37:50 +0100, Lad Prabhakar wrote:
> Add USB PHY support for r8a7742 SoC. Renesas RZ/G1H (R8A7742)
> USB PHY is identical to the R-Car Gen2 family.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!
