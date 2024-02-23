Return-Path: <dmaengine+bounces-1083-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB42E860B2E
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 08:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5581F2307F
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 07:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6F12E6C;
	Fri, 23 Feb 2024 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBn1nWWR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD079455;
	Fri, 23 Feb 2024 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672341; cv=none; b=JHRzUG2DgKR8+jG+bmZRIx4Q0CElQdf5Md5FfLCfNo33kksiwMh8f0hSbQgG08BJWq+S25oEEsgorpE+G9+HmLIHnxeXZIBZUeHNXDtKsLW4KDYREcS1P1AtJg9o3FzMF5fE5gCDQyl+DDOiYdpxRqMo5gy19QQfXPAcMIWyo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672341; c=relaxed/simple;
	bh=NDaLXNF7vdTsWUaH84OUNYIrKQDpJAly1GLNpuCRK3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+XN1C/LWRHCT5AnZW9phHmbjVdH3QoUBWGfo3KaOY1uGzHdHuRamEzLfsajOP4HNMGRHyOb5/wGJlP0jcElYKKuDLnyKJg2MIybRKv3S9zYKJcvafKCLdtGMuWjaurh+sR9VbjXPbtbRt/pl+E/qsA9LkWg2jjsrdLdP1alT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBn1nWWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B397C433F1;
	Fri, 23 Feb 2024 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708672340;
	bh=NDaLXNF7vdTsWUaH84OUNYIrKQDpJAly1GLNpuCRK3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBn1nWWR8nmGFP3FqlK1Gws8CY8oYY8azzqL3ScMJ8QpmPCTi7giTtQGex0CQykij
	 81csyiayRGNgmSxTfM1qCEwNQSRrkXXsbrt11YiWkkSskQTBxznleNOEwl4n2mW2cc
	 s1G7kUxQsMcNwop4mz8Z2bkEckAk8o6Hynbp1CxSgjAJRWZqy1E19OTMBJWiJzMMul
	 1lFdroAZ9m6zUu2i6p7yntn32U/YG4fEm81OA3Fr7cL/t8ei9cGFnQJQUnZVMjC2fT
	 RP1RbSibMZjuCBYyUVuFbcs6LQzH6f07gDjSd+n7wIH8VA2JZirMD1fKi+1m/TFGb6
	 sFMTIFV8nH9JQ==
Date: Fri, 23 Feb 2024 12:42:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Basavaraj Natikar <bnatikar@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: change in AMD ptdma maintainer
Message-ID: <ZdhFUDgGqHUA6VhE@matsya>
References: <20240222083004.1907070-1-Basavaraj.Natikar@amd.com>
 <ZddQHZIo8fLCoqec@matsya>
 <cd2783cc-5616-41b7-a6e9-b20cd71706df@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd2783cc-5616-41b7-a6e9-b20cd71706df@amd.com>

On 22-02-24, 19:19, Basavaraj Natikar wrote:
> 
> On 2/22/2024 7:16 PM, Vinod Koul wrote:
> > On 22-02-24, 14:00, Basavaraj Natikar wrote:
> >> As 'Sanjay R Mehta' stepped down from the role of ptdma maintainer, I
> >> request to be added as the new maintainer of AMD PTDMA.
> > Should you not CC Sanjay?
> 
> Sanjay left AMD below email id is invalid to CC.

Ouch, looks like he doesnt want to help with this, ideally he should
have changed the email id here...

I will pick this, better to have someone responsible than none

> 
> Thanks,
> --
> Basavaraj
> 
> >
> >> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >> ---
> >>  MAINTAINERS | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index e2c6187a3ac8..becd09410b8c 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -1034,7 +1034,7 @@ F:	include/linux/amd-pstate.h
> >>  F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> >>  
> >>  AMD PTDMA DRIVER
> >> -M:	Sanjay R Mehta <sanju.mehta@amd.com>
> >> +M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >>  L:	dmaengine@vger.kernel.org
> >>  S:	Maintained
> >>  F:	drivers/dma/ptdma/
> >> -- 
> >> 2.25.1

-- 
~Vinod

