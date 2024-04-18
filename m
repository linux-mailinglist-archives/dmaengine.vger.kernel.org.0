Return-Path: <dmaengine+bounces-1894-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372A28AA0C7
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 19:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E411C2145F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A71116F8F3;
	Thu, 18 Apr 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz11xcHY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126151649D1;
	Thu, 18 Apr 2024 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460106; cv=none; b=bwMdVeTCFkrURnTAMyhARcDTAUeIbR4qE7P1xP5HbSrMpmfiWVvgVxqCOHQLegk53FUMS0/NzX9g9uQWqih5Nbek4vp4RW9i1/vHRbKPu/4M5bmW+zrun6H1bxorKfN+1PDMQHLsMIOU4XH5YJcMvLaKHiYx3YojfqG0MA+bSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460106; c=relaxed/simple;
	bh=C5vAcsAGNtZ+hO945sBELUO2UK1K4xQnnyEnkFZJ+qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3GIgpzPa5KInYgdn9lGhAG2Yr2mc6cktuwD3TscZuRVtdlDRj9fwfLbw4xYcY6oQYMQ+Zf4SwEUYJxDVlfpfJmFwK7cwRDOQJyeoSa4qg62OYuHVSfgkyIcxF7GAen+7zndQUFNmDMUztmIaFp/yVrq8wrMyhoeWEm/NGPe5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz11xcHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D78C113CC;
	Thu, 18 Apr 2024 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713460105;
	bh=C5vAcsAGNtZ+hO945sBELUO2UK1K4xQnnyEnkFZJ+qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bz11xcHYvH+GyJZ+vzvq+kO1dE8St09ccv01fai5Zq8gQymCwG/2Zh5QzdcwAqXPB
	 tUuHC1tEEvNHPAtteFDi6zzPDY092spDxa55Qmrgutmzn2PHCuUQQURerlAwdS7cS7
	 +PohBuDwVYx9hHX3brKCUmj21b0nz+oUPcRq/WGal73wnCtryHXgHZMoTTuGMup6+i
	 79SLHgOn3NbRjRXcA5nMlmfJM09/4mEe747UTOcf6JiHdxsUUUpmgTipFVLsMo/u2s
	 DLBz4UDI5PYhpE2RoDcDZKH5E+PGFMUYnXD5BkzZUZybyHdFsB5d0jnd0v84HhMcXP
	 LEaue6XAlRnSw==
Date: Thu, 18 Apr 2024 22:38:21 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nishad Saraf <nishads@amd.com>, nishad.saraf@amd.com,
	sonal.santan@amd.com, max.zhen@amd.com
Subject: Re: [PATCH V10 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Message-ID: <ZiFTheOik-2jsfXP@matsya>
References: <1709675352-19564-1-git-send-email-lizhi.hou@amd.com>
 <1709675352-19564-2-git-send-email-lizhi.hou@amd.com>
 <ZhKd7CHXHB7FadY0@matsya>
 <aa6a63c0-7cce-1f49-4ae5-3e5d93f98fe5@amd.com>
 <ZiAA3C4wXaAHcJ1E@matsya>
 <14402251-5731-1e52-e787-734d3eb3c801@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14402251-5731-1e52-e787-734d3eb3c801@amd.com>

On 17-04-24, 10:53, Lizhi Hou wrote:
> 
> On 4/17/24 10:03, Vinod Koul wrote:
> > On 08-04-24, 11:06, Lizhi Hou wrote:
> > 
> > > > > +static void *qdma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
> > > > > +				   size_t *payload_len, size_t *max_len)
> > > > > +{
> > > > > +	struct qdma_mm_vdesc *vdesc;
> > > > > +
> > > > > +	vdesc = container_of(tx, typeof(*vdesc), vdesc.tx);
> > > > > +	if (payload_len)
> > > > > +		*payload_len = sizeof(vdesc->dev_addr);
> > > > > +	if (max_len)
> > > > > +		*max_len = sizeof(vdesc->dev_addr);
> > > > > +
> > > > > +	return &vdesc->dev_addr;
> > > > Can you describe what metadata is being used here for?
> > > The metadata is the device address the dma request will transfer
> > > 
> > > data to / from.  Please see the example usage here:
> > > 
> > > https://github.com/houlz0507/XRT-1/blob/qdma_v1_usage/src/runtime_src/core/pcie/driver/linux/xocl/subdev/qdma.c#L311
> > > 
> > > Before dmaengine_submit(), it specifies the device address.
> > Hmmm, why is the vaddr passed like this, why not use slave_config for
> > this
> > 
> This is because the hardware is capable to process multiple vdesc at one
> kick off.
> 
> For example, there are two pending vdesc: vd1 and vd2. If there is enough
> free
> 
> space in hardware queue, the vd1 and vd2 can be put in queue, and do one
> kick off
> 
> to transfer both vd1 and vd2.
> 
> The destination device address of vd1 and vd2 could be any valid device
> address.
> 
> desc_metadata_ptr seems helpful for the per vdesc destination device
> address.
> 
> 
> If using slave_config, it needs to call dmaengine_slave_config() and

That would be the right thing to do...

- set parameters and call dmaengine_slave_config()
- prep transfer for vd1 dmaengine_prep_slave_sg()
- set parameters and call dmaengine_slave_config()
- prep transfer for vd2 dmaengine_prep_slave_sg()
- submit vd1
- submit vd2
- issue_pending
        - you see you can issue both as you have space, so do that

This should be done always to maximize the dmaengine thoroughput

> 
> dmaengine_prep_slave_sg() with a lock protection. Is this what you would
> recommend?
> 
> 
> Thanks,
> 
> Lizhi

-- 
~Vinod

