Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE61397FB
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jan 2020 18:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgAMRqH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jan 2020 12:46:07 -0500
Received: from muru.com ([72.249.23.125]:50738 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgAMRqH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Jan 2020 12:46:07 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 245D98047;
        Mon, 13 Jan 2020 17:46:48 +0000 (UTC)
Date:   Mon, 13 Jan 2020 09:46:03 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] dmaengine: ti: omap-dma: don't allow a null
 od->plat pointer to be dereferenced
Message-ID: <20200113174603.GK5885@atomide.com>
References: <20200109131953.157154-1-colin.king@canonical.com>
 <20200110074605.GD2818@vkoul-mobl>
 <f2116091-3023-ee5d-f3f7-07ec02425da0@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2116091-3023-ee5d-f3f7-07ec02425da0@canonical.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Colin Ian King <colin.king@canonical.com> [200110 09:22]:
> On 10/01/2020 07:46, Vinod Koul wrote:
> > On 09-01-20, 13:19, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> Currently when the call to dev_get_platdata returns null the driver issues
> >> a warning and then later dereferences the null pointer.  Avoid this issue
> >> by returning -ENODEV errror rather when the platform data is null and
> > 
> > s/errror/error :) never thought would correct Colin on spelling :)
> 
> Doh, I need to add that to the checkpatch dictionary ;-)
> 
> If this can be fixed up before it's applied then this would be
> appreciated rather than me sending a V3.

I've fixed i up and pushed out into omap-for-v5.6/sdma.

Thanks,

Tony
