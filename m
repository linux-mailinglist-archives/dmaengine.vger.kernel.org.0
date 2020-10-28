Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD1129DE7A
	for <lists+dmaengine@lfdr.de>; Thu, 29 Oct 2020 01:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgJ1WSF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 18:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731691AbgJ1WRl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:41 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5336223B0;
        Wed, 28 Oct 2020 06:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603865102;
        bh=N+NQkdWPKn2ZUTudXOvRWBS+Bm1QxJ7KxNnTg2lH5w0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdBCODyFXQJPKZZCNVCFGMmwM+oAYK6nWAuoP3a0QN/qGX2xImUaCFJYl0icPzGTC
         SXFKMDPGQGpMC9txs/LOurxUqaH6dM3GRg8N8p9H8B7L6ISdBFrzJJV/FtmVS9lpF/
         4maXtsgQGkD8oSp2zImvIdnOtUjXCJpdUhtS2xJE=
Date:   Wed, 28 Oct 2020 11:34:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Sherry Sun <sherry.sun@nxp.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Nikhil Rao <nikhil.rao@intel.com>
Subject: Re: [PATCH char-misc-next 1/1] misc: mic: remove the MIC drivers
Message-ID: <20201028060458.GK3550@vkoul-mobl>
References: <8c1443136563de34699d2c084df478181c205db4.1603854416.git.sudeep.dutt@intel.com>
 <20201028055429.GA244117@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028055429.GA244117@kroah.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-10-20, 06:54, Greg Kroah-Hartman wrote:
> On Tue, Oct 27, 2020 at 08:14:15PM -0700, Sudeep Dutt wrote:
> > This patch removes the MIC drivers from the kernel tree
> > since the corresponding devices have been discontinued.
> 
> Does "discontinued" mean "never shipped a device so no one has access to
> this hardware anymore", or does it mean "we stopped shipping devices and
> there are customers with this?"
> 
> > Removing the dma and char-misc changes in one patch and
> > merging via the char-misc tree is best to avoid any
> > potential build breakage.
> > 
> > Cc: Nikhil Rao <nikhil.rao@intel.com>
> > Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > Signed-off-by: Sudeep Dutt <sudeep.dutt@intel.com>
> 
> I like deleting code, can this go into 5.10-final?

I would like that, if unused lets get it cleaned now rather than later
:-)

Said that, for all dmaengine bits:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
