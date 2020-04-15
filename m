Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7191AADAE
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407022AbgDOQRv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 12:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406838AbgDOQRu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 12:17:50 -0400
Received: from localhost (unknown [106.201.106.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD3120656;
        Wed, 15 Apr 2020 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586967470;
        bh=zP3lZ8cIaF1xN3mOhhjx+SXGY2uwLZfMaLq+cugMpB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUWW7cntAUTAnTbxd/cZ2tr4jipCWJRHbreDzAm/RrO6G0pC0G0fkjNsc7VZv3zEQ
         orfWsfIwk65UF8ptT7MIcEnP662Df60Na1D5U4Iame0Cg/inAMto6HOojbRnZmaGoT
         smTtPa5RDe4yS9gEKhO5dkvLL8IRFkxpRAo+K4Cs=
Date:   Wed, 15 Apr 2020 21:47:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     dmaengine@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: uniphier-xdmac: switch to single reg
 region
Message-ID: <20200415161739.GA72691@vkoul-mobl>
References: <20200401032150.19767-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401032150.19767-1-yamada.masahiro@socionext.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-04-20, 12:21, Masahiro Yamada wrote:
> The reg in the example "<0x5fc10000 0x1000>, <0x5fc20000 0x800>"
> is wrong. The register region of this controller is much smaller,
> and there is no other hardware register interleaved. There is no
> good reason to split it into two regions.
> 
> Just use a single, contiguous register region.
> 
> While I am here, I made the 'dma-channels' property mandatory because
> otherwise there is no way to determine the number of the channels.
> 
> Please note the original binding was merged recently. Since there
> is no user yet, this change has no actual impact.

Applied, thanks

-- 
~Vinod
