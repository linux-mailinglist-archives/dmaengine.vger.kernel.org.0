Return-Path: <dmaengine+bounces-2074-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604B48C8EA9
	for <lists+dmaengine@lfdr.de>; Sat, 18 May 2024 01:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE041B20C0D
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 23:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA424140E55;
	Fri, 17 May 2024 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="QooPQVsg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3F1E532;
	Fri, 17 May 2024 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715989280; cv=none; b=kyZ+CLjM70BBvBUk1RSu6sPU3Fd54vtBSH5/AncnoB+89HCMCcuajuBiAAPgqc1nreT3oeND0upqLaYLcbsXK5EcpV2SgcdkqTM7QHdv3D6y7InW4R3BmN+swHDx9xtx7FBYx2MRsShEYuYJLRJs5AU+MHUfNxCUpWFW4ypRgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715989280; c=relaxed/simple;
	bh=Nf1PDMr0ebBF2dbwF9Hg8zjxX9i1A0cdraxAorgWcCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr+vnZd/I/I4bnGeWLVuVt6HpXfl99rVo+Snzjshe2hrgHFVUMC6m72PJa6+sHpq4pEXfg3BJpTTOesrInJdJNM5XKAdn/cT0sNA5ThcuyYoh37OJ4xYUXv79lTIYU4cQ/iN0xa9j5WdxnyvB5pzSHxNKcur1t+0Khm0j+wXvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=QooPQVsg; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Mte/zTfCFvcefoW6SvHsQ/+Lbzl1hVpku1r0UnTKxgo=; b=QooPQVsgJaXV92sW
	L1WqPJurq/xV8xNLeL/mJXMxqEk9K+dfs9lSTIiBQYeLwYXQsHlkSplJqil8LuApOu6A/jQq41s14
	6DC/l4OZ+Qi42ThqDoxWL9NVFtTPuv/K9XQpaEcxvB/MRfamoOXqu9yHyKCDMUdthO/X/2Q7F/KpT
	WuwL/8ez30bll6gVHAH0X1sSzZnWpL0DoYyNpjE54q5VTTpT6ZEv0qON/jCr9VcrMQsHGuuvn1J0/
	0up/MQI/MssZpgeS2lTj/rtzm1yKSiEfYfi0SXheffvRA8aQxDdxDBYTiAa3W/nLf1Hw3awY/xQWG
	EimjFOx8umT/CMtuVQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s87CO-001TxC-37;
	Fri, 17 May 2024 23:41:16 +0000
Date: Fri, 17 May 2024 23:41:16 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Frank.li@nxp.com, vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: qcom: gpi: remove unused struct 'reg_info'
Message-ID: <ZkfrHAxINJTWo6Pk@gallifrey>
References: <20240516152537.262354-1-linux@treblig.org>
 <39b66355-f67e-49e9-a64b-fdd87340f787@linaro.org>
 <Zkc69sMlwawV8Z7l@gallifrey>
 <Zkc9J4vbQdeCmTpO@gallifrey>
 <3fe6e86d-5b4d-4b3c-a5d7-59f01dc6b0bc@linaro.org>
 <Zkfidbh3Sqy6BEDh@gallifrey>
 <f2cfac67-c793-4f47-b390-2b4fff21ff5e@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f2cfac67-c793-4f47-b390-2b4fff21ff5e@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 23:40:57 up 9 days, 10:54,  1 user,  load average: 0.04, 0.03, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Bryan O'Donoghue (bryan.odonoghue@linaro.org) wrote:
> On 18/05/2024 00:04, Dr. David Alan Gilbert wrote:
> > * Bryan O'Donoghue (bryan.odonoghue@linaro.org) wrote:
> > > On 17/05/2024 12:19, Dr. David Alan Gilbert wrote:
> > > > > If you look at the V1 I had
> > > > > ''gpi_desc' seems like it was never used.
> > > > > Remove it.'
> > > > > 
> > > > > but Frank suggested copying the subject line; so I'm not sure
> > > > > whether you want more or less!
> > > > > 
> > > > > I could change this to:
> > > > > 
> > > > > 'gpi_desc' was never used since it's initial
> > > > > commit 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
> > > > Oops, of course I mean 'reg_info' which is what I fixed in v2.
> > > > 
> > > > > Would you be OK with that?
> > > > Dave
> > > > 
> > > > > Dave
> > > 
> > > Hi Dave,
> > > 
> > > I saw your v1 interaction after commenting but, I still think commits that
> > > say "this removes a data structure" should elaborate more.
> > > 
> > > "This structure is no longer used since commit: 12charsubshahere" or "This
> > > structure was never used and should be considered dead code"
> > > 
> > > I generally hope the intention of my commits is clear from the code with the
> > > commit log adding whatever context or elaboration on top.
> > > 
> > > So that's what I'm suggesting here. A bit of commit log sugar on top which
> > > elaborates on and justifies the change.
> > 
> > OK, so how about the version I suggested above:
> > 
> >   'reg_info' was never used since it's initial
> >   commit 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
> >   Remove it.
> > 
> > Is that OK with you?
> > 
> > Dave
> > 
> > > 
> > > ---
> > > bod
> > > 
> 
> LGTM
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Thanks, v3 sent and copied to you with that RB added.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

