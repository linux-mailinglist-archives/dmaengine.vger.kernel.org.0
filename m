Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A0E42C97
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 18:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502212AbfFLQrN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 12:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502210AbfFLQrM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 12 Jun 2019 12:47:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1377208C2;
        Wed, 12 Jun 2019 16:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560358032;
        bh=kfR8kNGOlTLzBEPDr9tom15y+byntqVAq6C+crySxUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBAJ9MxxtREFIMi+AFW1jouZWiS7hRdNIJgHmr7g+MAL3t5bzE5nb4Hez4x8nOeKM
         lwDFpewKxDJ8oNAXN5b8DfsqhjcvvzX2vymp6hgid31KOw93OkAMExDDWkj+aMG8Jw
         QsFWDLFObaERIw/mf24nSS/Obzokel2lt1mxtnLc=
Date:   Wed, 12 Jun 2019 18:47:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] dma: qcom: hidma: no need to check return value of
 debugfs_create functions
Message-ID: <20190612164709.GA31124@kroah.com>
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
 <20190612122557.24158-6-gregkh@linuxfoundation.org>
 <8185a8b8-a0ce-4a86-84a2-b51391356052@kernel.org>
 <20190612153948.GA21828@kroah.com>
 <78da53a1-1363-fad8-16fa-4dfc6555f4e4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78da53a1-1363-fad8-16fa-4dfc6555f4e4@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 12, 2019 at 12:17:31PM -0400, Sinan Kaya wrote:
> On 6/12/2019 11:39 AM, Greg Kroah-Hartman wrote:
> >> Interesting. Wouldn't debugfs_create_file() blow up if dir is NULL
> >> for some reason?
> > It will create a file in the root of debugfs.  But how will that happen?
> > debugfs_create_dir() can not return NULL.
> 
> I see.
> 
> > 
> >> +		debugfs_create_file("stats", S_IRUGO, dir, chan,
> >> +				    &hidma_chan_fops);
> >>
> >> Note that code ignores the return value of hidma_debug_init();
> >> It was just trying to do clean up on debugfs failure by calling
> >>
> >> 	debugfs_remove_recursive(dmadev->debugfs);
> > Is that a problem?
> 
> I just wanted to double check. You probably want to remove the return
> value on debugfs_create_file() to prevent others from doing the same
> thing.

That is my long-term goal, I have a ways to go still :)

> Acked-by: Sinan Kaya <okaya@kernel.org>

Great, thanks for the review.

greg k-h
