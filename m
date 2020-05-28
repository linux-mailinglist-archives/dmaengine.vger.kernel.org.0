Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6271E70A4
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 01:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437700AbgE1XqI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 19:46:08 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41882 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437697AbgE1XqE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 19:46:04 -0400
Received: by mail-il1-f193.google.com with SMTP id d1so720194ila.8;
        Thu, 28 May 2020 16:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cIzL006tPJXl6TcjStQ4xNmtimYxPC51Ou9j+METahw=;
        b=CWSgcw3AoqdDPaao/PgbvDNAUccxeGi86dq3/nyDetEHOils8XPbYxbxisO6J46kAj
         3WdCQkc4S0RosrsVGCiDztAh18ip8+NqI+luMhAhcW+YmWQ8U0SN1kR3Up9uf0H61rTo
         FzO7dviH059insnxfdZV4MCjf5t0HjurJSaw9ehj/Tr3I1mP1QwKkTNpyLIwIpldyapq
         v11kC3Mu+ljVesfnAXhclBS8IvXzlur6+E/ycZe9BdXaOJSXNFc+Xnj+i7xCFrniMee5
         vDebaoygJuPkDptYpKwuK5A8t0i/lYT+WqlQOQOb9rVukRelZHfeQByS1K/Lb3zeJfzD
         WBGg==
X-Gm-Message-State: AOAM533uipXdrGzpupT1hailqnr3nNBkTq55pEais5lSAGy/aGqWYBBu
        IvvhbrasLmY2yydIegOBMg==
X-Google-Smtp-Source: ABdhPJwsEvAwKlSvei9EgovqazyWfvjOiBVyad3OgWBA++KzA8tpGxaeYM57w2I5UHwBiPNj22h2fQ==
X-Received: by 2002:a92:1906:: with SMTP id 6mr5075088ilz.144.1590709563459;
        Thu, 28 May 2020 16:46:03 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g4sm3878889ilj.45.2020.05.28.16.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:46:02 -0700 (PDT)
Received: (nullmailer pid 908079 invoked by uid 1000);
        Thu, 28 May 2020 23:46:01 -0000
Date:   Thu, 28 May 2020 17:46:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        dmaengine@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 5/8] dt-bindings: usb: usb-xhci: Document r8a7742 support
Message-ID: <20200528234601.GA907981@bogus>
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590356277-19993-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, 24 May 2020 22:37:54 +0100, Lad Prabhakar wrote:
> Document r8a7742 xhci support. The driver will use the fallback
> compatible string "renesas,rcar-gen2-xhci", therefore no driver
> change is needed.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
