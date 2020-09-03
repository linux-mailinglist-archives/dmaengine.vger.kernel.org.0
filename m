Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C374225BD3E
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgICI1W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 04:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgICI1V (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 04:27:21 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96F0208C7;
        Thu,  3 Sep 2020 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599121640;
        bh=AbWFhSZrSoYx6Fp+YWywGEU0EqwcOSISwNIHxOF/xrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CShokF7yy0Q2skhvanCrcL8gLouFzuDy52Ps63kiiLEPBULkR4dAY07e/OXPSjQ7P
         ZSxHU3SPp8vlg1wgh8K38DKz5BwfSbZr+YX3tMCaMdGrGsJJP/bNiEJEIFtJOPfJkm
         +4gDX0yPWjBuP/oVs6/UAKME6cI9pQWKJtTwVoo4=
Date:   Thu, 3 Sep 2020 13:57:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [RESEND PATCH v2] dt-bindings: renesas,rcar-dmac: Document
 r8a7742 support
Message-ID: <20200903082716.GM2639@vkoul-mobl>
References: <20200903073813.4490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903073813.4490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-09-20, 08:38, Lad Prabhakar wrote:
> Renesas RZ/G SoC also have the R-Car gen2/3 compatible DMA controllers.
> Document RZ/G1H (also known as R8A7742) SoC bindings.

Applied, thanks

-- 
~Vinod
