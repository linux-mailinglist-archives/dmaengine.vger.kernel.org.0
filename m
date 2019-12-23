Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6CD129291
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 08:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfLWHy4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 02:54:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWHyz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Dec 2019 02:54:55 -0500
Received: from localhost (unknown [223.226.34.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ECD0206B7;
        Mon, 23 Dec 2019 07:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577087695;
        bh=2yh3uiTddvCjS7EKZmDMOjEsrl7nNSl2DDHRdpfkucM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUOyLSLHEKQDCiquoEAkVHUJzNOQ1BRWseTRI2muai1LY0mcdWKIlB4yiEEVFT1y0
         lxyEIc6wq+zY8iiNawNo1RTevyvujkMuWRVRugxr+OSL6g2/v+jiI81N8HtYzoKXWv
         IYbhaEvFmuMwhd+p5UDGX9XTOmPPnpqmCeUdP/Sk=
Date:   Mon, 23 Dec 2019 13:24:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: virt-dma: Fix access after free in
 vcna_complete()
Message-ID: <20191223075451.GE2536@vkoul-mobl>
References: <20191220131100.21804-1-peter.ujfalusi@ti.com>
 <0303ceda023121d9048d2508e28c0306b1871561.camel@analog.com>
 <486093bc-b1bf-1727-0402-f07606fffd1e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486093bc-b1bf-1727-0402-f07606fffd1e@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-12-19, 16:50, Peter Ujfalusi wrote:
> 
> 
> On 20/12/2019 16.01, Ardelean, Alexandru wrote:
> > On Fri, 2019-12-20 at 15:11 +0200, Peter Ujfalusi wrote:
> >> [External]
> >>
> >> vchan_vdesc_fini() is freeing up 'vd' so the access to vd->tx_result is
> >> via already freed up memory.
> >>
> >> Move the vchan_vdesc_fini() after invoking the callback to avoid this.
> >>
> > 
> > Apologies for seeing this too late: typo in title vcna_complete() ->
> > vchan_complete()
> 
> Yep, I also noticed after sending it, I hope Vinod is kind enough and
> fix it up when applying ;)

In case it wasnt clear, yeah trivial changes while applying are no
hassle :)

-- 
~Vinod
