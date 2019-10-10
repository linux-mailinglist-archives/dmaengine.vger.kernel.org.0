Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89793D24ED
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2019 11:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbfJJIvu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Oct 2019 04:51:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36703 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390154AbfJJIvt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Oct 2019 04:51:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id m18so5846731wmc.1;
        Thu, 10 Oct 2019 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iBVy5EpS5miZLPYXy54PXc4Tp3ZcCov2ByS5T+jtyzQ=;
        b=oPeNcuB6ERNhMIaqdBhqvoaicqED33w2ZnRTPI1p35C5PjIp7M9osj7CbCyJN8zPD3
         nG6qo00p+0C3GDV4s/9yBSa8mfu9zBhTYIglKOccIfc+j10IBM9F9DXFq4SIfkTQNXaE
         fE375uuX1MA0BcAHwBvL1otT/gRBtypTz3WyZ+7i2csJ0nBVgikl3eux1lElB7TYwEjv
         vnJOQVyLrrrEOe4XhskyXBXjBDp+ToI+0IwbqS5sW8lsPH33Lut4ZKWtJHjV9CC7Q/95
         L1DRvuYRO+1wfp6e/A2OpRyn91sFEAEHtTOOWNqYCTTPsrEmiXvoY2x1H1/G9O06cNzR
         y76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iBVy5EpS5miZLPYXy54PXc4Tp3ZcCov2ByS5T+jtyzQ=;
        b=mjkF3uiUAAscIAlyznVnb9dgYJ4+5C+CzPqqTc/UhtyLZRDmwQ3CgYIeKqkKs4u0Kr
         Dm/GYOVRtWtzjqVoe4Jye8XC+ONzgTwwFcEhe37gWL/cHtlgDox/XQFQLbb1+GGWMpa/
         fmxHZVqpE0FLB0H+gazJkENW9ZkBpnQQv4dukYW4mZncbv/C56STTSwo5NeFrt03PooW
         fPZE1+fiwEKlt8Gbe7nk6Qz1BST8fOkZlbwCqah/qHQWxv4cyv1X12A5cXKm/hcceeEd
         fGTYJAtdce2wREJ1qYWWQDLdSTybQYYhk1meZE+fnA9riuj56LHkMIm/GTyeZSfxeqmI
         RH0w==
X-Gm-Message-State: APjAAAVEhW8PI03QOa0a1PhXA6jUmDY9hfT9aCPnG6BCcDfZ+Rk/W8e4
        ipJXd63/hpD4yJTWSQ+wSdG1Xc58
X-Google-Smtp-Source: APXvYqyLknqLcUuYq9q/QesWPksjxjSFkRwD5oI5ldv1gDrTXvnqviOQWl53byaUzLuLESgiSA0EPw==
X-Received: by 2002:a05:600c:2190:: with SMTP id e16mr6254868wme.136.1570697507740;
        Thu, 10 Oct 2019 01:51:47 -0700 (PDT)
Received: from AlexGordeev-DPT-VI0092 ([213.86.25.46])
        by smtp.gmail.com with ESMTPSA id g13sm4032958wrm.42.2019.10.10.01.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Oct 2019 01:51:47 -0700 (PDT)
Date:   Thu, 10 Oct 2019 10:51:45 +0200
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Michael Chen <micchen@altera.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface
 for PCIe
Message-ID: <20191010085144.GA14197@AlexGordeev-DPT-VI0092>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
 <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
 <20191009121441.GM25098@kadam>
 <20191009145811.GA3823@AlexGordeev-DPT-VI0092>
 <20191009185323.GG13286@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009185323.GG13286@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 09, 2019 at 09:53:23PM +0300, Dan Carpenter wrote:
> > > > +	u32 *rd_flags = hw->dma_desc_table_rd.cpu_addr->flags;
> > > > +	u32 *wr_flags = hw->dma_desc_table_wr.cpu_addr->flags;
> > > > +	struct avalon_dma_desc *desc;
> > > > +	struct virt_dma_desc *vdesc;
> > > > +	bool rd_done;
> > > > +	bool wr_done;
> > > > +
> > > > +	spin_lock(lock);
> > > > +
> > > > +	rd_done = (hw->h2d_last_id < 0);
> > > > +	wr_done = (hw->d2h_last_id < 0);
> > > > +
> > > > +	if (rd_done && wr_done) {
> > > > +		spin_unlock(lock);
> > > > +		return IRQ_NONE;
> > > > +	}
> > > > +
> > > > +	do {
> > > > +		if (!rd_done && rd_flags[hw->h2d_last_id])
> > > > +			rd_done = true;
> > > > +
> > > > +		if (!wr_done && wr_flags[hw->d2h_last_id])
> > > > +			wr_done = true;
> > > > +	} while (!rd_done || !wr_done);
> > > 
> > > This loop is very strange.  It feels like the last_id indexes needs
> > > to atomic or protected from racing somehow so we don't do an out of
> > > bounds read.

[...]

> You're missing my point.  When we set
> hw->d2h_last_id = 1;
[1]
> ...
> hw->d2h_last_id = 2;
[2]

> There is a tiny moment where ->d2h_last_id is transitioning from 1 to 2
> where its value is unknown.  We're in a busy loop here so we have a
> decent chance of hitting that 1/1000,000th of a second.  If we happen to
> hit it at exactly the right time then we're reading from a random
> address and it will cause an oops.
> 
> We have to use atomic_t types or something to handle race conditions.

Err.. I am still missing the point :( In your example I do see a chance
for a reader to read out 1 at point in time [2] - because of SMP race.
But what could it be other than 1 or 2?

Anyways, all code paths dealing with h2d_last_id and d2h_last_id indexes
are protected with a spinlock.

> regards,
> dan carpenter
> 
