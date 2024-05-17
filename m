Return-Path: <dmaengine+bounces-2071-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FBE8C8E63
	for <lists+dmaengine@lfdr.de>; Sat, 18 May 2024 01:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6911F22CA2
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 23:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F8229CE3;
	Fri, 17 May 2024 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GBxEMGYU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B74BA29;
	Fri, 17 May 2024 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715987067; cv=none; b=paVxggWPHRNsucJiNW+ffp1whkhlX2Z9FiIRyFE7P+qmzC3Gt+QL6kAyOc3pMFLzhGNqOehT233STHEWxiwJZJnIJyt47Kr1FDRQ26G5H/9taC51renB/QMB1kwf//LZDQLuq1X5DQk9dxQj+YoijYvdtAbjk8RHSE8eCPziGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715987067; c=relaxed/simple;
	bh=Jjl+6qHSjrekqgQIZZlevTofzQZYMq1ACQzJopY/mk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLJC9Ws0/HsB2tOb8PFxzkn0KUfLHZ8eTPrfEoJtlZryhvDBIqWDEN0mdr5qGTubGwt2q/EFhWmlBJV9a08QiIGtk2zS7mlJZ74pXTnHOt11MzSj0xatMMrx506vHBJK7Gao4gxYnnZkK0BKnJ3cHCI4ObK7mWtx7teHV/tWlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GBxEMGYU; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=WiRSirHLXEeLj+iZNrKZihamTCj24KKNNfaUSFLoN9s=; b=GBxEMGYUUSQv//Wq
	6AviypKqlUShmUC9Ly9xOu8Eu9FmhGda3Z++ZTSvmLb1VNZ66SsNo8vy0ARJz6kKhzgJwHW5UIEy1
	R63aPdcdWh1dmR/iDyC2u10NcjWwWIenp1OPV34EgzrCaVZFGISC3zMYpD3Ul2N4GD+QMA28ZUCWE
	AlyntaLewFVZxMnQdpG8x8iL+wKWd0TuBnERQdMUyyZwOSdF8qU6uou4F9INL93EjpOlZA8y77RfH
	pmFuWjlC2BFpUzd55xitKQ4Jc+QA68hLl9qWXSBUXDekaBdlmgVHPZSkSd/al0hEj2hsth61+ApGe
	o1mnRs+gcO13HXMmdw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s86cf-001TeT-1h;
	Fri, 17 May 2024 23:04:21 +0000
Date: Fri, 17 May 2024 23:04:21 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Frank.li@nxp.com, vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: qcom: gpi: remove unused struct 'reg_info'
Message-ID: <Zkfidbh3Sqy6BEDh@gallifrey>
References: <20240516152537.262354-1-linux@treblig.org>
 <39b66355-f67e-49e9-a64b-fdd87340f787@linaro.org>
 <Zkc69sMlwawV8Z7l@gallifrey>
 <Zkc9J4vbQdeCmTpO@gallifrey>
 <3fe6e86d-5b4d-4b3c-a5d7-59f01dc6b0bc@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3fe6e86d-5b4d-4b3c-a5d7-59f01dc6b0bc@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 23:03:14 up 9 days, 10:17,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Bryan O'Donoghue (bryan.odonoghue@linaro.org) wrote:
> On 17/05/2024 12:19, Dr. David Alan Gilbert wrote:
> > > If you look at the V1 I had
> > > ''gpi_desc' seems like it was never used.
> > > Remove it.'
> > > 
> > > but Frank suggested copying the subject line; so I'm not sure
> > > whether you want more or less!
> > > 
> > > I could change this to:
> > > 
> > > 'gpi_desc' was never used since it's initial
> > > commit 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
> > Oops, of course I mean 'reg_info' which is what I fixed in v2.
> > 
> > > Would you be OK with that?
> > Dave
> > 
> > > Dave
> 
> Hi Dave,
> 
> I saw your v1 interaction after commenting but, I still think commits that
> say "this removes a data structure" should elaborate more.
> 
> "This structure is no longer used since commit: 12charsubshahere" or "This
> structure was never used and should be considered dead code"
> 
> I generally hope the intention of my commits is clear from the code with the
> commit log adding whatever context or elaboration on top.
> 
> So that's what I'm suggesting here. A bit of commit log sugar on top which
> elaborates on and justifies the change.

OK, so how about the version I suggested above:

 'reg_info' was never used since it's initial
 commit 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
 Remove it.

Is that OK with you?

Dave

> 
> ---
> bod
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

