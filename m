Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E069701F2
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 16:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfGVOMA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 10:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbfGVOL7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jul 2019 10:11:59 -0400
Received: from localhost (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CBE21911;
        Mon, 22 Jul 2019 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563804718;
        bh=IbeXHeJbySyvfqVcju7hicw04qkG80Ca8h5G2wqBpSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFPdOql2C0fn/K/Av7RktKgvsNh+u3oyc0tTSvghX6cRwwjyYGEPcS6/ID3f8avSR
         huwCSxYz/Kcov+l/2gIqKfMe92LuBI9WrcvxYCeIIs2Rk966wiASpenKtSH/PoV8sn
         VLwBmU7f8CeJpO3noMdaXZQU9BxafbGNxowHFBXY=
Date:   Mon, 22 Jul 2019 19:40:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/2] [RESEND] dmaengine: omap-dma: make
 omap_dma_filter_fn private
Message-ID: <20190722141045.GS12733@vkoul-mobl.Dlink>
References: <20190722081705.2084961-1-arnd@arndb.de>
 <CAK8P3a39YBEueSGo-DpVOH3nE88T7DyarcoT29XZ13onCRP1Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a39YBEueSGo-DpVOH3nE88T7DyarcoT29XZ13onCRP1Aw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-07-19, 10:31, Arnd Bergmann wrote:
> On Mon, Jul 22, 2019 at 10:17 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > +++ /dev/null
> > @@ -1,21 +0,0 @@
> > -/*
> > - * OMAP DMA Engine support
> > - *
> 
> 
> I noticed this causes a trivial merge conflict (the file change but still
> needs to get removed), let me know if you need me to resend the patch.

thats okay, it was trivial to fix, updated now

-- 
~Vinod
