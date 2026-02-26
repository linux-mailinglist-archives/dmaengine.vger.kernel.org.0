Return-Path: <dmaengine+bounces-9125-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMq7CQDxn2lwfAQAu9opvQ
	(envelope-from <dmaengine+bounces-9125-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 08:06:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCC21A19F4
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 08:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35D5E3018C0E
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 07:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9399A38E100;
	Thu, 26 Feb 2026 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVOUerUr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700FE2DEA74;
	Thu, 26 Feb 2026 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089554; cv=none; b=E63OTjZR0WQVVmAiu++p/egwprugRi82t/AnVj4Kf9JjhLhvSnYz/5XTj6YNgKQCi6REuK0RS6QgmMOXqU3XH5iS9lO63YwL7tBBheKn15p8cjD0vYX8Bc86WzEi0F4Wez92E1wlVme7TKyNfXDBqO62kuiRqO1Ev4jqRuegYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089554; c=relaxed/simple;
	bh=r8kkku+RUrykKo8TzZsoSH0+1fI5bqsKXvST33G+y+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME+fH82b5cgMnW7ms2W2oPe2e7aNNOMHh7dLENGeTtfpeUrTm1KIKfofY1cH7+J8PM9nMvgd0QMk+oS9GMU/uOBWrVOsdhm5NVnosQyKoWLDM6k+i/kYQM2/dykHTUvxAkvWViNC0R2l9yTj6+kyZO7SgDrrVxzcL+MiDBc/SG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVOUerUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61791C19425;
	Thu, 26 Feb 2026 07:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772089554;
	bh=r8kkku+RUrykKo8TzZsoSH0+1fI5bqsKXvST33G+y+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVOUerUrp1sd8OJYr/FayxxGSv+keS2OvEIftB8YxZm/B44KcMB+dWGzHdh+iJtgO
	 Edo8ini3/qBAM2bn5TmdJj1j1rKeleWMYfuWf9rV6KV+pb0cmS/SmKMS6eW/uit2lo
	 HqJI9P4wGKuDz+rWyZxJUIMD3I6LQ9Dy0rw2afNEhI5apJgSZerdALhTDfs2N+bl/C
	 UwLL1W9rU91dKI3UICn0T4lNP4Etpj+B/RJ7YFjHXr+iwSmFk3j4+mroZ/61Hpc2uu
	 hPfPqiMDaJxOAqPFA3jdRN/Njbu7Q8AemmGO4mMTjtWKanxil+gsr5tJHfWYOSs4Cw
	 gURkzrb31HbDQ==
Date: Thu, 26 Feb 2026 12:35:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@kernel.org>
Subject: Re: (subset) [PATCH v3 0/3] riscv: sophgo: allow DMA multiplexer set
 channel number for DMA controller
Message-ID: <aZ_wziVgEPGOSAd3@vaman>
References: <20260120013706.436742-1-inochiama@gmail.com>
 <177201865381.93331.6104381063514168222.b4-ty@kernel.org>
 <aZ9z0gV8ZrfpL2JG@inochi.infowork>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ9z0gV8ZrfpL2JG@inochi.infowork>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9125-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[synopsys.com,kernel.org,outlook.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,whut.edu.cn,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFCC21A19F4
X-Rspamd-Action: no action

On 26-02-26, 06:13, Inochi Amaoto wrote:
> On Wed, Feb 25, 2026 at 04:54:13PM +0530, Vinod Koul wrote:
> > 
> > On Tue, 20 Jan 2026 09:37:02 +0800, Inochi Amaoto wrote:
> > > As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
> > > the SoC provides a dma multiplexer to reuse the DMA channel. However,
> > > the dma multiplexer also controlls the DMA interrupt multiplexer, which
> > > means that the dma multiplexer needs to know the channel number.
> > > 
> > > Change the DMA phandle args parsing logic so it can use handshake
> > > number as channel number if necessary.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible
> >       commit: 5eda5f42d2fee87127b568206a9fcc07a2f6eab6
> > [2/3] dmaengine: dw-axi-dmac: Add support for CV1800B DMA
> >       commit: 02a380ea7ed2d737a42693d7957ec8c33a92d9fd
> > 
> > Best regards,
> > -- 
> > ~Vinod
> > 
> > 
> 
> Hi, Vinod
> 
> I guess you applied the version 4, but replied to the version 3?

Nope, I had already picked 3. so reply went on that.

-- 
~Vinod

