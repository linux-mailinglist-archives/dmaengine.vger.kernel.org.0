Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31EC7FEAC
	for <lists+dmaengine@lfdr.de>; Tue, 30 Apr 2019 19:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfD3RTG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Apr 2019 13:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3RTG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Apr 2019 13:19:06 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EEF320651;
        Tue, 30 Apr 2019 17:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556644746;
        bh=Ak9XM+VjWlZMz6Xy1SwbxWJmWxB8F4HluG3X0ePJnYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZxZx9D2Lv1r5COFomGHS9i012OKoXiF2uZkaqgsaPoW3iM7g+piKuSSJJkJGuDgoz
         fUZMRrKxDlAO8HmtU/OQqfSuagdNNvLW1ehGjCwxxgRgXfm2QVvKL1iL1D/agM7WgI
         2lwJbWsP5bS4YljgCgmccCO9z7rgh5qzTqXTgoEc=
Date:   Tue, 30 Apr 2019 22:48:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-dma: fix residue calculation in
 stm32-dma
Message-ID: <20190430171856.GW3845@vkoul-mobl.Dlink>
References: <1553689316-6231-1-git-send-email-arnaud.pouliquen@st.com>
 <20190426121751.GC28103@vkoul-mobl>
 <6894b54e-651f-1caf-d363-79d1ef0eee14@st.com>
 <20190429051310.GC3845@vkoul-mobl.Dlink>
 <26fa7710-76cb-e202-a367-c2e2408b6808@st.com>
 <20190430082255.GP3845@vkoul-mobl.Dlink>
 <f7f28d56-a3e4-38a3-8580-b241fe0dcb49@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f28d56-a3e4-38a3-8580-b241fe0dcb49@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-04-19, 16:58, Arnaud Pouliquen wrote:

> >> Hope that will help to clarify.
> > 
> > Yes that helps, maybe we should add these bits in code and changelog..
> > :)I will update the comments and commit message in a V2 in this way
> > 
> > And how does this impact non cyclic case where N descriptors maybe
> > issued. The driver seems to support non cyclic too...
> 
> Correct it supports SG as well, but double buffer mode is not used in
> such case. Hw is programmed under IT for every descriptors : no
> automatic register reloaded as in cyclic mode. We won't end up in the
> situation depicted below.

Okay sounds good then. Can you add a bit more of this in the code (this
was very helpful) not as a fix but documentation so that people (or you
down the line) will remember why this was done like this

Thanks

-- 
~Vinod
