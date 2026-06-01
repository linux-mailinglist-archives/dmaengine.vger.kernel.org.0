Return-Path: <dmaengine+bounces-11110-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOPuLx37HWpSgQkAu9opvQ
	(envelope-from <dmaengine+bounces-11110-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 23:35:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 828E1625919
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 23:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D064304971A
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 21:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D73672BA;
	Mon,  1 Jun 2026 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9dejrFP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80A3438BF;
	Mon,  1 Jun 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349721; cv=none; b=rcAiJ04zaRPwai7CyIAejQgv/RjvFfrMk17M0naOtCawKg85wGqL+kwwLhqBO89D1ypRHYw3MIsCHqSDWMG/+mqsWMWdp2PWPbL1PFQh52Vm2eXb0i+R85NuF33bcTa2HJPgIywfr7qcVUlQpHT9WHLsCVUuYaRpCQi4oInssCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349721; c=relaxed/simple;
	bh=JX3a56ROqRUJYWv7JLOrWtKCiHHjyk6kNHGwYD50qlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPOh9KlxsIPmHB9Hh4mAuL1PvCmhOeHraS4HetMgi4Zt1V/lv3cAtkgGJLpZ57J6Enig3m+ETlH39o6se+s+hdjSWqxWeWzfA0vFKS2glmVuzkah4X94IijBpsIZOY4yboeBpz+ET/Wf12WucmEUkM79OUNsIX6lC6g0/aXeAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9dejrFP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC201F00893;
	Mon,  1 Jun 2026 21:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780349720;
	bh=+xqhpciIcKX86EWtkX3wT2FdsVnifRlQ0F7pq6tZMiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z9dejrFPuPoHWEQu5J2ko0Bd57NtHTtxh7XkdxgglKT0olwbazk0EO95ebcLPiAbq
	 ydau/rHrvi3Il01J5S1F1hIIx4JknI89rn3dcE7g28QdiRtnZB7WcJyGWKNgu9iQWn
	 kZlsNhcV7iakiP896Cmu/5WTL6h06fNWAQLtgZNebkSUDo38jyvCb3Qm7OeCz4JzK9
	 UN244FgYdszXzPwKivqUiFIravi8yfzYlAdw7gu1c5S87c1DaEbseDASdfe1Ea5Rmq
	 Txpcb+gFOqmKDqDblvmG85NdGtpcyzIrlwrdrDVm/7+4ruyE3Bdl0sFPzuwFPKHZU2
	 Ut3CmaLmjvoxw==
Date: Mon, 1 Jun 2026 16:35:19 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: CL Wang <cl634@andestech.com>, vkoul@kernel.org, conor+dt@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	Frank.Li@kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Message-ID: <20260601213519.GA28688-robh@kernel.org>
References: <20260601094846.1097678-2-cl634@andestech.com>
 <20260601095846.3B2431F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601095846.3B2431F00893@smtp.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11110-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[andestech.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 828E1625919
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 09:58:45AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The Device Tree schema uses `additionalProperties: false` alongside an `allOf: [ { $ref: dma-controller.yaml# } ]` inclusion, which violates DT schema guidelines and prevents the use of standard generic DMA properties.
> --
> 
> commit 65ee89a1dfc4e52aa6a4083163369bef3de2c374
> Author: CL Wang <cl634@andestech.com>
> 
> dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine
> 
> This commit documents the devicetree bindings for the Andes ATCDMAC300
> DMA engine. The IP is embedded in AndesCore-based platforms or SoCs
> such as AE350 and Qilai.
> 
> > diff --git a/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> > new file mode 100644
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> [ ... ]
> > +allOf:
> > +  - $ref: dma-controller.yaml#
> > +
> > +properties:
> [ ... ]
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#dma-cells"
> > +
> > +additionalProperties: false
> 
> [Severity: Low]
> Does this cause a regression during schema validation when standard DMA
> properties are used?
> 
> Since this binding references dma-controller.yaml# via an allOf block, using
> additionalProperties: false will reject generic properties like dma-channels
> or dma-requests if they are present in the device tree node. 
> 
> Should this be unevaluatedProperties: false instead to properly allow the
> inherited properties?

No, it is fine as-is.

Rob

