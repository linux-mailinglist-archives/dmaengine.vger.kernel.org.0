Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133A825BB6F
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 09:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgICHM0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 03:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgICHMY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 03:12:24 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CD0F2071B;
        Thu,  3 Sep 2020 07:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599117144;
        bh=rPR2h65NIq58EsscVdBt569FU+eXj+sgSo+2rsPr7Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFCu1WKxCw5FoYN5y1JnlmwiLnwQc+1eNLpBVmxWTe+nJAWAVvjqlGJiLuCDfvy0r
         vM4t4hrvNyJqR//KT5KQlVH54S1lRrLCdtV1n5QRl1Y+M4u9cDRF7q+AyArIzuCP3Y
         uMkofjLWZiFPmRB3lL/Z7CPk7Q69SrsotAiJeBho=
Date:   Thu, 3 Sep 2020 12:42:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 05/10] dt-bindings: renesas,rcar-dmac: Document
 r8a7742 support
Message-ID: <20200903071220.GK2639@vkoul-mobl>
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8v5CtxJQxjSWcvJrPtf9JyYKZeACdc3as_hjM710pk1AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8v5CtxJQxjSWcvJrPtf9JyYKZeACdc3as_hjM710pk1AQ@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-08-20, 12:08, Lad, Prabhakar wrote:
> Hi Vinod,
> 
> On Sun, May 3, 2020 at 10:47 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Renesas RZ/G SoC also have the R-Car gen2/3 compatible DMA controllers.
> > Document RZ/G1H (also known as R8A7742) SoC bindings.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> This patch is not present in linux-next yet, could you please take care of it.

Can you please resend


-- 
~Vinod
