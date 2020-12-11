Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A0F2D76FA
	for <lists+dmaengine@lfdr.de>; Fri, 11 Dec 2020 14:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394383AbgLKNxM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Dec 2020 08:53:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391679AbgLKNwr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Dec 2020 08:52:47 -0500
Date:   Fri, 11 Dec 2020 19:22:02 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607694727;
        bh=CkyUtDlHQfAS3/S1JQPZJrxCGgufSUyHtxYvRH4l56A=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9UDuR0hL70mgHMe9pJ19CwgXoJkzHt/QfYhkJCCIZgBde5x1WWejER3nh9S0cLjP
         sgNKb8ywzPpbE2/bUUmq1+PJYrGCDb2sVBx4pchpQ3VEf9oOTqO40bNi3BTewBlNUu
         stJqWiAe9hZ6wMXlQbNwJbVUiirvHnsZ1bESBevMhKSPXvezX2HRLCV/flZRM2+X3P
         wMNtJqcsAFcn+hMvTPON3bm/GbTLTl7VPd1TR+tK2PiCNg6lE5qKs/2lv80wrbGDUW
         IIBqjRz6ve0Smg1SQ9ffZfxF7a9+QLRUQOj0dfO6e8x1iVpXYAgrydY9OsBP+WymFs
         j+9fBFVbq3C5w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: mtk-apdma: add bindings for
 MT8516 SOC
Message-ID: <20201211135202.GV8403@vkoul-mobl>
References: <20201209114736.70625-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209114736.70625-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-12-20, 12:47, Fabien Parent wrote:
> Add bindings to APDMA for MT8516 SoC. MT8516 is compatible with MT6577.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks

-- 
~Vinod
