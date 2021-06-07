Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DBC39D6BC
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 10:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhFGIIo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 04:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhFGIIn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Jun 2021 04:08:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5849D6102A;
        Mon,  7 Jun 2021 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053212;
        bh=xmIDJ297EbDzxkQF9obeTuoyIAjOCtz2+6Ofw+DrFXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sM2u+WyfdldAkzzqhNEq2wVbktPE9gknkrkYPnr8/LdjYaKYBXHFiOr+U8NylodnI
         dKCe3oCN2qVP2hFpiTEofcH0Pq0cCumErxKYvFsJMlgjmNMABEE2OdTPsV2zfG8KZA
         r5hy6REuclAD4YTFgHZlkFFt2VpdPNzwM6wsdtfajESdm8taI/7o37jA+65CEvmp8y
         Y3SfrV4VpNVsJttuF/Fu93gt+mfN10rkDCg+YM1BV5Jho1oqoDXosVqcXuQ8HBmBhR
         6+O4rcp61F7naUFa5GLuo6zPA7M0I7iKcn8mc/jVvLmTPOnFU7sAaFhRo+eFqHvdpZ
         hLfIiy8HB0bGg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lqAHU-0004Ne-KD; Mon, 07 Jun 2021 10:06:45 +0200
Date:   Mon, 7 Jun 2021 10:06:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "yukuai (C)" <yukuai3@huawei.com>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, michal.simek@xilinx.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, yi.zhang@huawei.com
Subject: Re: [PATCH 2/3] dmaengine: usb-dmac: Fix PM reference leak in
 usb_dmac_probe()
Message-ID: <YL3TlDqe4KSr3ICl@hovoldconsulting.com>
References: <20210517081826.1564698-1-yukuai3@huawei.com>
 <20210517081826.1564698-3-yukuai3@huawei.com>
 <YLRfZfnuxc0+n/LN@vkoul-mobl.Dlink>
 <b6c340de-b0b5-6aad-94c0-03f062575b63@huawei.com>
 <YLSk/i6GmYWGEa9E@vkoul-mobl.Dlink>
 <YLSqD+9nZIWJpn+r@hovoldconsulting.com>
 <YLi4VGwzrat8wJHP@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLi4VGwzrat8wJHP@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 03, 2021 at 04:39:08PM +0530, Vinod Koul wrote:
> On 31-05-21, 11:19, Johan Hovold wrote:
> > On Mon, May 31, 2021 at 02:27:34PM +0530, Vinod Koul wrote:
> > > On 31-05-21, 14:11, yukuai (C) wrote:
> > > > On 2021/05/31 12:00, Vinod Koul wrote:
> > > > > On 17-05-21, 16:18, Yu Kuai wrote:
> > > > > > pm_runtime_get_sync will increment pm usage counter even it failed.
> > > > > > Forgetting to putting operation will result in reference leak here.
> > > > > > Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> > > > > > counter balanced.

> > > Yes the rumtime_pm is disabled on failure here and the count would have
> > > no consequence...
> > 
> > You should still balance the PM usage counter as it isn't reset for
> > example when reloading the driver.
> 
> Should I driver trust that on load PM usage counter is balanced and not
> to be reset..?

Not sure what you're asking here. But a driver should never leave the PM
usage counter unbalanced.

> > Using pm_runtime_resume_and_get() is one way of handling this, but
> > alternatively you could also move the error_pm label above the
> > pm_runtime_put() in the error path.
> 
> That would be a better way I think

Johan
