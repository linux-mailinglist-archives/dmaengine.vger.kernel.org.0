Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB17820E559
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 00:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgF2Vf7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jun 2020 17:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbgF2Skp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:45 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D02523D50;
        Mon, 29 Jun 2020 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593436905;
        bh=LXvcRe88NweP1KRH4lrxCsBpxttGet8FB2YNmIkHxnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lk8z7Qeu0qofDn4k3ukyl8Sgf9/l0vRWVNNaxxiLCWKdrrkSPK6sw9oFTo8sGJd1R
         8PFulkOmFfu4BtOELvFb+dYXpcL58MVebjO7CQKYydYCX0IlDe0Gf+7yT9rjRPWn6R
         CZCP4xfFBBzpmAeGfiSw66I6ySQrWvLzT2eJBH/s=
Date:   Mon, 29 Jun 2020 18:51:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Amit Singh Tomar <amittomer25@gmail.com>, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, dan.j.williams@intel.com,
        cristian.ciocaltea@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v4 02/10] dmaengine: Actions: Add support for S700 DMA
 engine
Message-ID: <20200629132141.GM2599@vkoul-mobl>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
 <1591697830-16311-3-git-send-email-amittomer25@gmail.com>
 <20200624061529.GF2324254@vkoul-mobl>
 <75d154d0-2962-99e6-a7c7-bf0928ec8b2a@arm.com>
 <20200629095446.GH2599@vkoul-mobl>
 <36274785-f400-4d69-deed-b7d545718d40@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36274785-f400-4d69-deed-b7d545718d40@arm.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-06-20, 12:19, André Przywara wrote:
> On 29/06/2020 10:54, Vinod Koul wrote:

> >> What newer SoCs? I don't think we should try to guess the future here.
> > 
> > In a patch for adding new SoC, quite ironical I would say!
> 
> S700 is not a new SoC, it's just this driver didn't support it yet. What
> I meant is that I don't even know about the existence of upcoming SoCs
> (Google seems clueless), not to speak of documentation to assess which
> DMA controller they use.
> 
> >> We can always introduce further abstractions later, once we actually
> >> *know* what we are looking at.
> > 
> > Rather if we know we are adding abstractions, why not add in a way that
> > makes it scale better rather than rework again
> 
> I appreciate the effort, but this really tapping around in the dark,
> since we don't know which direction any new DMA controller is taking. I
> might not even be similar.
> 
> >> Besides, I don't understand what you are after. The max frame length is
> >> 1MB in both cases, it's just a matter of where to put FCNT_VAL, either
> >> in FLEN or in CTRLB. And having an extra flag for that in driver data
> >> sounds a bit over the top at the moment.
> > 
> > Maybe, maybe not. I would rather make it support N SoC when adding
> > support for second one rather than keep adding everytime a new SoC is
> > added...
> 
> Well, what do you suggest, specifically? At the moment we have two
> *slightly* different DMA controllers, so we differentiate between the
> two based on the model. Do you want to introduce an extra flag like
> FRAME_CNT_IN_CTRLB? That seems to be a bit over the top here, since we
> don't know if a future DMA controller is still compatible, or introduces
> completely new differences.

Fair enough, okay let us go with compatible for now

-- 
~Vinod
