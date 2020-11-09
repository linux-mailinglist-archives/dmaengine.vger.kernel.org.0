Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080FE2AB791
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 12:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKILyV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 06:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgKILyU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 06:54:20 -0500
Received: from localhost (unknown [122.171.147.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C1F206ED;
        Mon,  9 Nov 2020 11:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604922860;
        bh=+iw175/J1tq/P37phiK8nKg7R+loYoDsitcIgM1b1NU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJi+z3HkhjjKIfrIUjHaehZ2GrU6GzR3biMhOBsJrA+VjIf3RdwZbTwRfBmjmjEZ4
         x18gf7JYc/ZG3Pr3PZjB49jNyMt1jeD8g48lcK4G1UEY1XcFp2rqM7gRwCpWslPO3y
         LA98WOI4erzaVgnXAWAUKoYj08NP6aHa7oMy99mg=
Date:   Mon, 9 Nov 2020 17:24:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: move psi-l pairing in
 channel en/dis functions
Message-ID: <20201109115415.GM3171@vkoul-mobl>
References: <20201030203000.4281-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030203000.4281-1-grygorii.strashko@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-10-20, 22:30, Grygorii Strashko wrote:
> The NAVSS UDMA will stuck if target IP module is disabled by PM while PSI-L
> threads are paired UDMA<->IP and no further transfers is possible. This
> could be the case for IPs J721E Main CPSW (cpsw9g).
> 
> Hence, to avoid such situation do PSI-L threads pairing only when UDMA
> channel is going to be enabled as at this time DMA consumer module expected
> to be active already.

Applied, thanks

-- 
~Vinod
