Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2D39D973
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 12:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFGKVE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 06:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhFGKVD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Jun 2021 06:21:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 728CB6108C;
        Mon,  7 Jun 2021 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623061153;
        bh=VTXaUpTsvgBICiL2lKaVnHTXuZH2cZNa6FWeUX+IisE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVVTU06jgeAsSo/v/fEAlG1xId7qFWDasaTznd2qQ64Uk30/NJbygYrmH4HWiWaou
         Nx9OEPtvZlVibiqfpvZU8qf2uIp7A/lSu+BaSGZHU0V1ky2KF3nK24EJix6mir/gkm
         M5OuKTah7QnercdV/DgyniAVxs5A+4BkYGy6BI/CtHTsdlcO9n5EnmH7Z87tsoTMHL
         QjpmLdSzV4/7F/ruljRn9IflXQA4J6+rfnM8SZwX2UZv5Uj2wd+PVTRAXd8uo8537i
         chhMxB+tdfdxIMdeh2+gRz7+jrcEIO+A8a6w1d9t7insDVjhZWJJ3HHSJDtS7G9f7Z
         GR8wQQl1SVUcQ==
Date:   Mon, 7 Jun 2021 15:49:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     "yukuai (C)" <yukuai3@huawei.com>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, michal.simek@xilinx.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, yi.zhang@huawei.com
Subject: Re: [PATCH 2/3] dmaengine: usb-dmac: Fix PM reference leak in
 usb_dmac_probe()
Message-ID: <YL3ynd1KiJoe9y6+@vkoul-mobl>
References: <20210517081826.1564698-1-yukuai3@huawei.com>
 <20210517081826.1564698-3-yukuai3@huawei.com>
 <YLRfZfnuxc0+n/LN@vkoul-mobl.Dlink>
 <b6c340de-b0b5-6aad-94c0-03f062575b63@huawei.com>
 <YLSk/i6GmYWGEa9E@vkoul-mobl.Dlink>
 <YLSqD+9nZIWJpn+r@hovoldconsulting.com>
 <YLi4VGwzrat8wJHP@vkoul-mobl>
 <YL3TlDqe4KSr3ICl@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL3TlDqe4KSr3ICl@hovoldconsulting.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-06-21, 10:06, Johan Hovold wrote:
> On Thu, Jun 03, 2021 at 04:39:08PM +0530, Vinod Koul wrote:
> > On 31-05-21, 11:19, Johan Hovold wrote:
> > > On Mon, May 31, 2021 at 02:27:34PM +0530, Vinod Koul wrote:
> > > > On 31-05-21, 14:11, yukuai (C) wrote:
> > > > > On 2021/05/31 12:00, Vinod Koul wrote:
> > > > > > On 17-05-21, 16:18, Yu Kuai wrote:
> > > > > > > pm_runtime_get_sync will increment pm usage counter even it failed.
> > > > > > > Forgetting to putting operation will result in reference leak here.
> > > > > > > Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> > > > > > > counter balanced.
> 
> > > > Yes the rumtime_pm is disabled on failure here and the count would have
> > > > no consequence...
> > > 
> > > You should still balance the PM usage counter as it isn't reset for
> > > example when reloading the driver.
> > 
> > Should I driver trust that on load PM usage counter is balanced and not
> > to be reset..?
> 
> Not sure what you're asking here. But a driver should never leave the PM
> usage counter unbalanced.

Thinking about again, yes we should safely assume the counter is
balanced when driver loads.. so unloading while balancing sounds better
behaviour

Thanks
-- 
~Vinod
