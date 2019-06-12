Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75B742B23
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437672AbfFLPjv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 11:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437271AbfFLPjv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 12 Jun 2019 11:39:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D57215EA;
        Wed, 12 Jun 2019 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560353990;
        bh=OkfQa1r9r/eRE11QXleOQyWPtTdH6obHCWv126tLNpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zlvoertnbkBTJMrAQfpkuh2QUBkBmhHgwKxKMhzLzXwM1MFXI3mAFWEQJlG02ywhQ
         CGL8w3YRyJNYeegaLLxeksnCagXvjwVsVqHWh7TqF8ULWUp0lu+RlFIlkzun6WZglX
         X/MI3qM2/MPsz8hyqx1V2TeFrrlpsp/ZLRfpytbo=
Date:   Wed, 12 Jun 2019 17:39:48 +0200
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
Message-ID: <20190612153948.GA21828@kroah.com>
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
 <20190612122557.24158-6-gregkh@linuxfoundation.org>
 <8185a8b8-a0ce-4a86-84a2-b51391356052@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8185a8b8-a0ce-4a86-84a2-b51391356052@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 12, 2019 at 11:24:51AM -0400, Sinan Kaya wrote:
> On 6/12/2019 8:25 AM, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Also, because there is no need to save the file dentry, remove the
> > variables that were saving them as they were never even being used once
> > set.
> > 
> > Cc: Sinan Kaya <okaya@kernel.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: David Brown <david.brown@linaro.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-arm-msm@vger.kernel.org
> > Cc: dmaengine@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Interesting. Wouldn't debugfs_create_file() blow up if dir is NULL
> for some reason?

It will create a file in the root of debugfs.  But how will that happen?
debugfs_create_dir() can not return NULL.

> +		debugfs_create_file("stats", S_IRUGO, dir, chan,
> +				    &hidma_chan_fops);
> 
> Note that code ignores the return value of hidma_debug_init();
> It was just trying to do clean up on debugfs failure by calling
> 
> 	debugfs_remove_recursive(dmadev->debugfs);

Is that a problem?

thanks,

greg k-h
