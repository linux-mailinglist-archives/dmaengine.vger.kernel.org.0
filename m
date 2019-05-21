Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3983724721
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 06:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEUEzu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 00:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfEUEzu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 00:55:50 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C368621019;
        Tue, 21 May 2019 04:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558414549;
        bh=WBJrD9GaZl+jSOXfgGg0LbfrV5nlbencvl5nJfs2+us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEI7Qwbe6xpupT9LEYUiSFePR/A/OFpT7HMo0owwh0xRc+OhLbZwKqnXDqRjXpB+C
         DTo10uNmzPg8GL9XUEK3of4HUSUJJJ2rVbuu5cQ2XjY5O/Qif/yPFJfbLPbtTolH2I
         oVGJ73M7h4PJPg2zVBJm+FFND1HsBQ2Eq9/YuC/M=
Date:   Tue, 21 May 2019 10:25:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Handle DMA_PREP_INTERRUPT flag
 properly
Message-ID: <20190521045545.GP15118@vkoul-mobl>
References: <20190505181235.14798-1-digetx@gmail.com>
 <287d7e67-1572-b4f2-d4bb-b1f02f534d47@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <287d7e67-1572-b4f2-d4bb-b1f02f534d47@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-05-19, 10:24, Jon Hunter wrote:
> 
> On 05/05/2019 19:12, Dmitry Osipenko wrote:
> > The DMA_PREP_INTERRUPT flag means that descriptor's callback should be
> > invoked upon transfer completion and that's it. For some reason driver
> > completely disables the hardware interrupt handling, leaving channel in
> > unusable state if transfer is issued with the flag being unset. Note
> > that there are no occurrences in the relevant drivers that do not set
> > the flag, hence this patch doesn't fix any actual bug and merely fixes
> > potential problem.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> >From having a look at this, I am guessing that we have never really
> tested the case where DMA_PREP_INTERRUPT flag is not set because as you
> mentioned it does not look like this will work at all!

That is a fair argument
> 
> Is there are use-case you are looking at where you don't set the
> DMA_PREP_INTERRUPT flag?
> 
> If not I am wondering if we should even bother supporting this and warn
> if it is not set. AFAICT it does not appear to be mandatory, but maybe
> Vinod can comment more on this.

This is supposed to be used in the cases where you submit a bunch of
descriptors and selectively dont want an interrupt in few cases...

Is this such a case?

Thanks
~Vinod
