Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBE334CF57
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhC2LtB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Mar 2021 07:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhC2Lsm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Mar 2021 07:48:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7B6B6195B;
        Mon, 29 Mar 2021 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617018522;
        bh=7bOjh2VBV6ORFq+hCMAwT1T3XPaqoe4QhuhPDGs1AAs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=UWtdSj5jytB4yinCTIl3uubMK3m15sgaJtDCKH4UDmRTzMxypBr8y8V81cmTfFm0M
         srtX9TghLWGx+Ep76clREiLK59I/9LFZrkw/NAqR/q5/Bwjvxm3c5aV4hyPSPoQTJo
         xfqlBmY7r+HQbjNRQKB/IDAmJg0CoWggrzQOzLDE=
Date:   Mon, 29 Mar 2021 13:48:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        dave.jiang@intel.com, dan.j.williams@intel.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] DMA: Mundane typo fixes
Message-ID: <YGG+l1EfRuWp0J3A@kroah.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
 <20210329052910.GB26495@lst.de>
 <YGFrvwX8QngvwPbA@Gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGFrvwX8QngvwPbA@Gentoo>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 29, 2021 at 11:25:11AM +0530, Bhaskar Chowdhury wrote:
> On 07:29 Mon 29 Mar 2021, Christoph Hellwig wrote:
> > I really don't think these typo patchbomb are that useful.  I'm all
> > for fixing typos when working with a subsystem, but I'm not sure these
> > patchbombs help anything.
> > 
> I am sure you are holding the wrong end of the wand and grossly failing to
> understand.

Please stop statements like this, it is not helpful and is doing nothing
but ensure that your patches will not be looked at in the future.

> Anyway, I hope I give a heads up ...find "your way" to fix those damn
> thing...it's glaring....

There is no requirement that anyone accept patches that are sent to
them.  When you complain when receiving comments on them, that
shows you do not wish to work with others.

Sorry, but you are now on my local blacklist for a while, and I
encourage other maintainers to just ignore these patches as well.

thanks,

greg k-h
