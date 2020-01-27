Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 662F6149E94
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2020 06:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgA0FIf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jan 2020 00:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgA0FIe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jan 2020 00:08:34 -0500
Received: from localhost (unknown [122.181.201.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E87720716;
        Mon, 27 Jan 2020 05:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580101714;
        bh=sh4gpOdiYLotpOkB88cXx9+mmjB24ViBFWqv5LExZ4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wx8aPOpTS+Kb2Sy5Wmlm+U+6x5esBaImXY6fF8DDRxJiOuDQ2Gthx9hRn5n1quRzx
         hnI7vjTugmK/dGJ8BV7fRkGx9TGps7+BxXI0/Ho2D7B7MUdXVpDw1QOr8OUUxTnVgM
         FGMR+Aml/vS6dPUaDOXay9A0w9g3UwsPu1iErjGY=
Date:   Mon, 27 Jan 2020 10:38:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and
 slaves
Message-ID: <20200127050828.GH2841@vkoul-mobl>
References: <20200117153056.31363-1-geert+renesas@glider.be>
 <d2b669e7-a5d4-20ec-5b54-103b71df7407@ti.com>
 <CAMuHMdVzQCWvH-LJ9ME5dRyafudZBHQLaJQzkSCPnughv_q2aA@mail.gmail.com>
 <1cdc4f71-f365-8c9e-4634-408c59e6a3f9@ti.com>
 <CAMuHMdU=-Eo29=DQmq96OegdYAvW7Vw9PpgNWSTfjDWVF5jd-A@mail.gmail.com>
 <f7bbb132-1278-7030-7f40-b89733bcbd83@ti.com>
 <CAMuHMdXDiwTomiKp8Kaw0NvMNpg78-M88F0mNTWBOz5MLE4LtQ@mail.gmail.com>
 <20200122094002.GS2841@vkoul-mobl>
 <20200124061359.GF2841@vkoul-mobl>
 <876eb72f-db74-86b5-5f2c-7fc9a5252421@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876eb72f-db74-86b5-5f2c-7fc9a5252421@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-01-20, 09:31, Peter Ujfalusi wrote:
> Vinod, Geert,
> 
> On 24/01/2020 8.13, Vinod Koul wrote:
> > On 22-01-20, 15:10, Vinod Koul wrote:
> > 
> >> I like the idea of adding this in debugfs and giving more info, I would
> >> actually love to add bytes_transferred and few more info (descriptors
> >> submitted etc) to it...
> >>
> >>>> This way we will have all the information in one place, easy to look up
> >>>> and you don't need to manage symlinks dynamically, just check all
> >>>> channels if they have slave_device/name when they are in_use (in_use w/o
> >>>> slave_device is 'non slave')
> >>>>
> >>>> Some drivers are requesting and releasing the DMA channel per transfer
> >>>> or when they are opened/closed or other variations.
> >>>>
> >>>>> What do other people think?
> >>>
> >>> Vinod: do you have some guidance for your minions? ;-)
> >>
> >>
> >> That said, I am not against merging this patch while we add more
> >> (debugfs)... So do my minions agree or they have better ideas :-)
> > 
> > So no new ideas, I am going to apply this and queue for 5.6, something
> > is better than nothing.
> 
> My only issue with the symlink is that it is created/removed on some
> setups quite frequently as they request/release channel per transfer or
> open/close.
> It might be a small hit in performance, but it is going to be for them.
> 
> > And I am looking forward for debugfs to give better picture, volunteers?
> 
> Well, I still feel that the debugfs can give better view in one place
> and in production it can be disabled to save few bytes per channel and
> code is not complied in.
> 
> If we have the debugfs we can remove some of the sysfs devices files
> probably.

Sure I dont mind if we move to something better :) We went from zero to
something and can do better!

Thanks

-- 
~Vinod
