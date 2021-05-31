Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5D39545B
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 06:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhEaEOH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 00:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhEaEOC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 May 2021 00:14:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 348E161019;
        Mon, 31 May 2021 04:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622434343;
        bh=DMoh2Lz7Qj/6icpTGNCPwjtwyCIL31WE+aYLElUFljo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWbaov9MbqiIvH4boXnaJsQ+oaSUkCK2FbeVQTrP6F1wA/4Jy/xzz95pdUL2s2qZs
         SlyQau9FNZSl907E5+OnwjePuAmPGZyDdOd2SnYeRrWSu90ixLDAOfSm3YavTvcKMx
         OnnjrOSxcP4DoYnylJ8loMowB44K23+Tk00CZkc6EfaSzS4ny6Zwx0QmxEn4hy5A4J
         9VoJxnBwk+UyuVSyelrrfurAZ/k+s8i6JLRYVQAlvycMclNbNQlw/5kwL0ite2U4QK
         1y833tWD4AahTuQHMfsqSg0HvRYtziOnII5qg7yhRIy90PpoYcSqxYwTAyoxTl86Xg
         sghkaBZ7z3pdw==
Date:   Mon, 31 May 2021 09:42:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>,
        dmaengine@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
        Green Wan <green.wan@sifive.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 4/4] DMA: XILINX_ZYNQMP_DPDMA depends on HAS_IOMEM
Message-ID: <YLRiIyy9un3i+1x+@vkoul-mobl.Dlink>
References: <20210522021313.16405-1-rdunlap@infradead.org>
 <20210522021313.16405-5-rdunlap@infradead.org>
 <YKmfs68Cq4osBaQ0@pendragon.ideasonboard.com>
 <5cb3b313-cd96-d687-2916-0d4af8e5e675@infradead.org>
 <YKqkmbZHPdbH2XtS@pendragon.ideasonboard.com>
 <93da0e86-dbef-432d-20db-c2eda03f0071@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93da0e86-dbef-432d-20db-c2eda03f0071@infradead.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-05-21, 12:08, Randy Dunlap wrote:
> On 5/23/21 11:53 AM, Laurent Pinchart wrote:
> > Hi Randy,
> > 
> > On Sat, May 22, 2021 at 06:07:01PM -0700, Randy Dunlap wrote:
> >> On 5/22/21 5:20 PM, Laurent Pinchart wrote:
> >>> On Fri, May 21, 2021 at 07:13:13PM -0700, Randy Dunlap wrote:
> >>>> When CONFIG_HAS_IOMEM is not set/enabled, most iomap() family
> >>>> functions [including ioremap(), devm_ioremap(), etc.] are not
> >>>> available.
> >>>> Drivers that use these functions should depend on HAS_IOMEM so that
> >>>> they do not cause build errors.
> >>>>
> >>>> Cures this build error:
> >>>> s390-linux-ld: drivers/dma/xilinx/xilinx_dpdma.o: in function `xilinx_dpdma_probe':
> >>>> xilinx_dpdma.c:(.text+0x336a): undefined reference to `devm_platform_ioremap_resource'
> >>>
> >>> I've previously posted
> >>> https://lore.kernel.org/dmaengine/20210520152420.23986-2-laurent.pinchart@ideasonboard.com/T/#u
> >>> which fixes the same issue (plus an additional one).
> >>
> >> Hi Laurent,
> >>
> >> I didn't add a dependency on OF because OF header files _mostly_
> >> have stubs so that they work when  OF is enabled or disabled.
> >>
> >> I did find a problem in <linux/of_address.h> where it could end up
> >> without having a stub. I will post a patch for that soon.
> >> I'm currently doing lots of randconfig builds on it.
> > 
> > I'm fine with eithe approach, but the patch you've posted to address the
> > of_address.h issue has an issue itself.
> 
> I'm also fine with either patch.
> I'm reworking the of_address.h patch now.

Back from vacation and clearing inbox... I have already applied Laurents
patch for this... 

Thanks

-- 
~Vinod
