Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923248900E
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2019 09:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfHKHD7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Aug 2019 03:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfHKHD7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 11 Aug 2019 03:03:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F6B52085B;
        Sun, 11 Aug 2019 07:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565507038;
        bh=jWMpenqWIxBR2gTyohlRI7kZJbZCU4SFLASh3LRKW2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6UKvdfOuYH1cx0uYTMIjlXc8f7wfD/ydISlh4LZK1neoCXseF7iZZ68TegLBhVEE
         z0Rb9VkmEZ2pr5QFPy2VPH7QlIGzKuBgvxmQTIXF24gqQqszsFCK7oWFsXYqpXj9R0
         /+/RvYlCiQ5xXSP8TNieVuvKFrxQiohrXcOFdzGM=
Date:   Sun, 11 Aug 2019 09:03:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dma: pxa_dma: no need to check return value of
 debugfs_create functions
Message-ID: <20190811070350.GA28202@kroah.com>
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
 <20190612122557.24158-4-gregkh@linuxfoundation.org>
 <87tvaorfc1.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvaorfc1.fsf@belgarion.home>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Aug 10, 2019 at 09:27:26PM +0200, Robert Jarzmik wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> Hi Greg,
> 
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> >
> > Also, because there is no need to save the file dentry, remove the
> > variable that was saving it as it was never even being used once set.
> >
> > Cc: Daniel Mack <daniel@zonque.org>
> > Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> > Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: dmaengine@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/dma/pxa_dma.c | 56 +++++++++----------------------------------
> >  1 file changed, 11 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> > index b429642f3e7a..0f698f49ee26 100644
> > --- a/drivers/dma/pxa_dma.c
> > +++ b/drivers/dma/pxa_dma.c
> > @@ -132,7 +132,6 @@ struct pxad_device {
> >  	spinlock_t			phy_lock;	/* Phy association */
> >  #ifdef CONFIG_DEBUG_FS
> >  	struct dentry			*dbgfs_root;
> > -	struct dentry			*dbgfs_state;
> >  	struct dentry			**dbgfs_chan;
> >  #endif
> >  };
> > @@ -326,31 +325,18 @@ static struct dentry *pxad_dbg_alloc_chan(struct pxad_device *pdev,
> >  					     int ch, struct dentry *chandir)
> >  {
> >  	char chan_name[11];
> > -	struct dentry *chan, *chan_state = NULL, *chan_descr = NULL;
> > -	struct dentry *chan_reqs = NULL;
> > +	struct dentry *chan;
> >  	void *dt;
> >  
> >  	scnprintf(chan_name, sizeof(chan_name), "%d", ch);
> >  	chan = debugfs_create_dir(chan_name, chandir);
> >  	dt = (void *)&pdev->phys[ch];
> >  
> > -	if (chan)
> > -		chan_state = debugfs_create_file("state", 0400, chan, dt,
> > -						 &chan_state_fops);
> > -	if (chan_state)
> > -		chan_descr = debugfs_create_file("descriptors", 0400, chan, dt,
> > -						 &descriptors_fops);
> > -	if (chan_descr)
> > -		chan_reqs = debugfs_create_file("requesters", 0400, chan, dt,
> > -						&requester_chan_fops);
> > -	if (!chan_reqs)
> > -		goto err_state;
> > +	debugfs_create_file("state", 0400, chan, dt, &chan_state_fops);
> > +	debugfs_create_file("descriptors", 0400, chan, dt, &descriptors_fops);
> > +	debugfs_create_file("requesters", 0400, chan, dt, &requester_chan_fops);
> 
> This is not strictly equivalent.
> Imagine that the debugfs_create_dir() fails and returns NULL :

How can that happen?

>  - in the former case, neither "state", "descriptors" nor "requesters" would be
>    created
>  - in the new code, "state", "descriptors" nor "requesters" will be created in
>    the debugfs root directory

I agree, but debugfs_create_dir() does not return a NULL on an error
since many kernel releases.  Neither can debugfs_create_file() so really
this test is not working at all as-is :)

thanks,

greg k-h
