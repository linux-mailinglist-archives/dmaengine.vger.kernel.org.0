Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40BF60661
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfGENOA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 09:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbfGENN7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jul 2019 09:13:59 -0400
Received: from localhost (unknown [49.207.59.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7589B21850;
        Fri,  5 Jul 2019 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562332439;
        bh=4Ax4YHT9pSOfjjpXXhaL2jL94bL31h816GZtxYru400=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btwexLJg3kxAdxu2/nhXrlxBb1eB9ovzxeZoIukphlXXmuThG6+a7UmKKXTXXZKV5
         Rj/5A+nuFNluNKXQEx67FC7VlUTYscurOjjF05FdRi40H++FOcDj66rXJvMhbuFlKZ
         A6jGbKGgBlCxBwWRds42zRK38fBBWe8MEmqynafI=
Date:   Fri, 5 Jul 2019 18:40:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix use-after-free on probe error
 path
Message-ID: <20190705131049.GF2911@vkoul-mobl>
References: <CAGngYiVsUZwCUEsqRk-YtZPGYxsqzHzD7U5GeeHyAa2Yw9Z6WA@mail.gmail.com>
 <20190624140731.24080-1-TheSven73@gmail.com>
 <20190705124646.GD2911@vkoul-mobl>
 <CAGngYiW2+sBv1WqB8+csb=mZm2owziJ5wWcWLNPy7=m72ppypw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiW2+sBv1WqB8+csb=mZm2owziJ5wWcWLNPy7=m72ppypw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-07-19, 09:08, Sven Van Asbroeck wrote:
> Hi Vinod,
> 
> On Fri, Jul 5, 2019 at 8:50 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > there is an else here too!
> >
> 
> You are of course right, I was looking at the wrong if.

NO issues :)
> 
> Apologies for the confusion, I did try to look at what you
> changed, but your git repo listed in MAINTAINERS appears
> unresponsive for me?

To quote David you need to move to 21st century (like me). IPv4 switch
for infradead is down so...

meanwhile this would work too:
git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git

-- 
~Vinod
