Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC7176E16
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2020 05:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgCCEc7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Mar 2020 23:32:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgCCEc6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Mar 2020 23:32:58 -0500
Received: from localhost (unknown [122.167.124.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF0920717;
        Tue,  3 Mar 2020 04:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583209978;
        bh=Ug2+vJ+ZcI5ysfWVbj5ud7It2jshGRSywGEXvUwcHKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wy/46AOMQbTq52frASd/nqcg/jx0ihzkgJIQqKCuonIsFSTYLp8hE/DH5X/2DxXjO
         z5ElAcaRPkpV8NBT3RLRmdPfojKSkQSZFIzsA36pzfG0sJJ9SLs9+/W13HIUr+YjSj
         5y+YRZ3wuwi3b/6CtMwW9b4zqQg0c02ZgN6WxyDQ=
Date:   Tue, 3 Mar 2020 10:02:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200303043254.GN4148@vkoul-mobl>
References: <20200213140709.GH2618@vkoul-mobl>
 <736038ef-e8b2-5542-5cda-d8923e3a4826@ti.com>
 <20200213165249.GH29760@pendragon.ideasonboard.com>
 <20200214042349.GS2618@vkoul-mobl>
 <20200214162236.GK4831@pendragon.ideasonboard.com>
 <becf8212-7fe6-9fb6-eb2c-7a03a9b286b1@ti.com>
 <20200219092514.GG2618@vkoul-mobl>
 <20200226163011.GE4770@pendragon.ideasonboard.com>
 <20200302034735.GD4148@vkoul-mobl>
 <20200302073728.GB9177@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302073728.GB9177@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 02-03-20, 09:37, Laurent Pinchart wrote:

> > I would be more comfortable in calling an API to do so :)
> > The flow I am thinking is:
> > 
> > - prep cyclic1 txn
> > - submit cyclic1 txn
> > - call issue_pending() (cyclic one starts)
> > 
> > - prep cyclic2 txn
> > - submit cyclic2 txn
> > - signal_cyclic1_txn aka terminate_cookie()
> > - cyclic1 completes, switch to cyclic2 (dmaengine driver)
> > - get callback for cyclic1 (optional)
> > 
> > To check if hw supports terminate_cookie() or not we can check if the
> > callback support is implemented
> 
> Two questions though:
> 
> - Where is .issue_pending() called for cyclic2 in your above sequence ?
>   Surely it should be called somewhere, as the DMA engine API requires
>   .issue_pending() to be called for a transfer to be executed, otherwise
>   it stays in the submitted but not pending queue.

Sorry missed that one, I would do that after submit cyclic2 txn step and
then signal signal_cyclic1_txn termination

> - With the introduction of a new .terminate_cookie() operation, we need
>   to specify that operation for all transfer types. What's its

Correct

>   envisioned semantics for non-cyclic transfers ? And how do DMA engine
>   drivers report that they support .terminate_cookie() for cyclic
>   transfers but not for other transfer types (the counterpart of
>   reporting, in my proposition, that .issue_pending() isn't supported
>   replace the current cyclic transfer) ?

Typically for dmaengine controller cyclic is *not* a special mode, only
change is that a list provided to controller is circular.

So, the .terminate_cookie() should be a feature for all type of txn's.
If for some reason (dont discount what hw designers can do) a controller
supports this for some specific type(s), then they should return
-ENOTSUPP for cookies that do not support and let the caller know.

-- 
~Vinod
