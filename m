Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A421E708E
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 01:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437620AbgE1Xng (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 19:43:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33590 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437602AbgE1Xne (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 19:43:34 -0400
Received: by mail-io1-f67.google.com with SMTP id k18so469611ion.0;
        Thu, 28 May 2020 16:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGD9bP/XhNcWAuTjvC8rBKyodQeAICoRC8aJHnKNN8k=;
        b=VGNvavSysivJrhOZjmHxRRIUB3pNh2J319XhX4Um33w1ta83bIrwEtiSfxRIVGxqJd
         wGxIWi2kKTVq5ChROwqzvtJE9u0IbbvB1l/DJjCIk8ngPNg8tZ0gSe7HI1tu/aacYHPQ
         CYJT12VkYhlj6PvGkaUBFFgXM4d8vEOoZfHLhGKIpXLc5yZnq9FlAvXV7BDf1bPyps5P
         ui95zfs+R6JxKtvA7mhsHaDhYLweFofrXtMnBMU7WWUv+POp1spYLoTcB4Gx+tBgwdBN
         qsbwtU4FkbqArH8sDuIj++NzGDNQqXGhpYfUahZQGfLbYgSIzR/69ULwd5e9vsLNSpUh
         P5Ww==
X-Gm-Message-State: AOAM530HcvOyCbNq90sa9RNyZH/fhwnxr80xtN4DtQ6YKCDub7v6cGnq
        lQsPYaFEFTWvpeNWyQlAXg==
X-Google-Smtp-Source: ABdhPJyRQoKeskWeskj49FkRbgOJomXtWNoydTDoZvGyOhrNm+P0rPlxavozyoqOqQ5UyrjscfPgBg==
X-Received: by 2002:a6b:249:: with SMTP id 70mr4430351ioc.146.1590709413680;
        Thu, 28 May 2020 16:43:33 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l16sm3906222ils.64.2020.05.28.16.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:43:33 -0700 (PDT)
Received: (nullmailer pid 901286 invoked by uid 1000);
        Thu, 28 May 2020 23:43:32 -0000
Date:   Thu, 28 May 2020 17:43:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/8] dt-bindings: PCI: pci-rcar-gen2: Add device tree
 support for r8a7742
Message-ID: <20200528234331.GA901177@bogus>
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590356277-19993-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, 24 May 2020 22:37:51 +0100, Lad Prabhakar wrote:
> Add internal PCI bridge support for r8a7742 SoC. The Renesas RZ/G1H
> (R8A7742) internal PCI bridge is identical to the R-Car Gen2 family.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!
