Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917A9A107A
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2019 06:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfH2Edv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Aug 2019 00:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2Edv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Aug 2019 00:33:51 -0400
Received: from localhost (unknown [122.181.207.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E1B9208C2;
        Thu, 29 Aug 2019 04:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567053231;
        bh=RpGAYOBFD8YDEmq5xeEoDpdw7eUdi3AUaJp+O3+F2M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brXb7V7Pu5dZbHcufnrWFvX3tC1iyevQF2e/CzMsgZMlLVPVy6t6YgUeIWHUvP7O7
         ubQ+v10UWtkNv2ZeAfagfO3nsxqCNXsyYcT5cDZXFLX1rAZAzoNCo7uFCkpJChg+UG
         HDIK1zAEOr9gA2hEIobXwbVyLckI7LQ4fojhVTWg=
Date:   Thu, 29 Aug 2019 10:02:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 00/10] dmaengine: dw: Enable for Intel Elkhart Lake
Message-ID: <20190829043241.GO2672@vkoul-mobl>
References: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
 <20190821041144.GG12733@vkoul-mobl.Dlink>
 <20190828115300.GL2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190828115300.GL2680@smile.fi.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-08-19, 14:53, Andy Shevchenko wrote:
> On Wed, Aug 21, 2019 at 09:41:44AM +0530, Vinod Koul wrote:
> > On 20-08-19, 16:15, Andy Shevchenko wrote:
> > > On Intel Elkhart Lake the DMA controllers can be provided by Intel® PSE
> > > (Programmable Services Engine) and exposed either as PCI or ACPI devices.
> > > 
> > > To support both schemes here is a patch series.
> > > 
> > > First two patches fixes minor issues in DMA ACPI layer, patches 3-5 enables
> > > Intel Elkhart Lake DMA controllers that exposed as ACPI devices, patch 6 is
> > > clean up, patch 7 is fix for possible race on ->remove() stage, patch 8 is
> > > follow up clean up and patches 9-10 is a split for better maintenance.
> > 
> > Applied all, thanks
> 
> Thank you!
> 
> Though I haven't seen yet them in Linux next. Can we give at least the rest of
> the time, till the release, to dangle them in Linux next?

Heh, looks like my script failed to push and I failed to notice. I have
pushed last night and it should be in linux-next today.

-- 
~Vinod
