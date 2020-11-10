Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B63C2AD6F0
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 13:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgKJM5H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 07:57:07 -0500
Received: from muru.com ([72.249.23.125]:47868 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730186AbgKJM5H (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 07:57:07 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B4A8980BA;
        Tue, 10 Nov 2020 12:57:12 +0000 (UTC)
Date:   Tue, 10 Nov 2020 14:57:03 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Block PM if SDMA is busy to fix
 audio
Message-ID: <20201110125703.GG26857@atomide.com>
References: <20201109154013.11950-1-tony@atomide.com>
 <acf280b4-f34d-cfc6-874c-48843cd54365@ti.com>
 <39089a2c-a883-d9b4-f1d6-493af2190410@ti.com>
 <20201110113346.GD26857@atomide.com>
 <20201110124116.GS3171@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110124116.GS3171@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Vinod Koul <vkoul@kernel.org> [201110 12:41]:
> On 10-11-20, 13:33, Tony Lindgren wrote:
> > Sorry about that, I've bounced the original patch too. Vinod let me know if
> > you want me to resend the patch.
> 
> That is okay, we have b4 now, so not much of a hassle to grab, review
> and apply, will do that shortly

OK thanks!

> And here is my rant to use get_maintainers.pl which should have pointed
> you to the correct address ;-)

Right :)

Tony
