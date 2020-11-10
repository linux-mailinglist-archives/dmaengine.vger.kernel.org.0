Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC4E2AD54C
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 12:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgKJLdu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 06:33:50 -0500
Received: from muru.com ([72.249.23.125]:47814 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgKJLdu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 06:33:50 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7DAFC80BA;
        Tue, 10 Nov 2020 11:33:55 +0000 (UTC)
Date:   Tue, 10 Nov 2020 13:33:46 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     linux-omap@vger.kernel.org, Vinod <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Block PM if SDMA is busy to fix
 audio
Message-ID: <20201110113346.GD26857@atomide.com>
References: <20201109154013.11950-1-tony@atomide.com>
 <acf280b4-f34d-cfc6-874c-48843cd54365@ti.com>
 <39089a2c-a883-d9b4-f1d6-493af2190410@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39089a2c-a883-d9b4-f1d6-493af2190410@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [201110 07:59]:
> Hi,
> 
> On 10/11/2020 9.58, Peter Ujfalusi wrote:
> > Hi Tony,
> > 
> > On 09/11/2020 17.40, Tony Lindgren wrote:
> >> We now use cpu_pm for saving and restoring device context for deeper SoC
> >> idle states. But for omap3, we must also block idle if SDMA is busy.
> >>
> >> If we don't block idle when SDMA is busy, we eventually end up saving and
> >> restoring SDMA register state on PER domain idle while SDMA is active and
> >> that causes at least audio playback to fail.
> > 
> > Thanks for the fix!
> > 
> > Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > Vinod: Can you take this for 5.10 as a fix? The off mode got enabled by
> > default in 5.10-rc1 and audio got broken out of box.
> 
> to Vinod with corrected email address..

Sorry about that, I've bounced the original patch too. Vinod let me know if
you want me to resend the patch.

Regards,

Tony
