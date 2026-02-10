Return-Path: <dmaengine+bounces-8867-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPImGpz7imlBPAAAu9opvQ
	(envelope-from <dmaengine+bounces-8867-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 10:34:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A53118EF0
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 10:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D71D30659D6
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A642341678;
	Tue, 10 Feb 2026 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjY/Wlq8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3334165B;
	Tue, 10 Feb 2026 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715970; cv=none; b=EXiVLS91W2bSensxfWILP3xJc9q74lLOVIH06y4n1O5GrL32f1BD3/dTaPiG3jFMRLBnqGBdken2NeLNFmYb1UF2M7mHEAidxI4cUgOiFWs+zNtHfhB4tJICdCRPEU+NUoj83gI7H/zwFsXrtPktm3s/InW3fbCGhDWAOWAHpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715970; c=relaxed/simple;
	bh=6xBQuqA0jkhD207BFVvKUlzi3FyiPhoWLKfqZAaZhGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4IFuty2rEmcQcfWPgIbZwY8EMIuUKuMlceA9hUfJjCqkKefWi7yp/wFhAgTMClZ3Errw13ls5UxV2Pppq+CAG+bOriwYsaOAIilEY238rQ4leeRpKyG4K6keb0W2uSC0u7RxADycTAeoliCtZPFxri+VujXSCqxSxi1rIq36r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjY/Wlq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D8DC19423;
	Tue, 10 Feb 2026 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770715970;
	bh=6xBQuqA0jkhD207BFVvKUlzi3FyiPhoWLKfqZAaZhGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjY/Wlq8Sqg6/tIXq43kG1MXOa17Zz3eQ1efz/aoGklcvzh6AjQgkfPuQW+TtxtiC
	 8MiRzZN23dS1lg30hf8tLJqSeQQFZcBfGpb+TQVFgtNDzDJOJGPvrVUYj4OP/wdq1/
	 U00B1nYIDiyK8L7NQ9N6D01S+gDnOolKnAKe10Z9ZOA5NdANhtpjw4uf131vMmdBtA
	 KkgBgScvlt/+LtNatdF3mV1rNObuy6w41Oro2ZOHzBaVwU1zACSVU2Qa1uzCSKixz2
	 OwdcsK39zKOhIftptGBD83KATU+Xq9x5cGLwYPlR54UKbw/3Pg84Zr1hFJ1xCw1Ii8
	 nxVC/aONlCDXQ==
Date: Tue, 10 Feb 2026 15:02:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, Frank Li <Frank.li@nxp.com>,
	Pat Somaru <patso@likewhatevs.io>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: plx_dma: Convert from tasklet to BH workqueue
Message-ID: <aYr7PuzZGpgQTOlW@vaman>
References: <20260206090058.1127675-1-patso@likewhatevs.io>
 <829601a5-f39e-43a1-bec5-80195a8833da@deltatee.com>
 <aYdtNHiE2wGp55cZ@slm.duckdns.org>
 <aYr7F3ZPnOCs6sRI@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYr7F3ZPnOCs6sRI@vaman>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8867-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,likewhatevs.io:email,deltatee.com:email]
X-Rspamd-Queue-Id: B8A53118EF0
X-Rspamd-Action: no action

On 10-02-26, 15:02, Vinod Koul wrote:
> On 07-02-26, 06:49, Tejun Heo wrote:
> > On Fri, Feb 06, 2026 at 11:43:59AM -0700, Logan Gunthorpe wrote:
> > > > Signed-off-by: Pat Somaru <patso@likewhatevs.io>
> > > 
> > > Looks good to me, thanks!
> > > 
> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > 
> > How do you want to route the patch? I can take it through the wq tree if
> > that's preferable.
> 
> Sorry can you please not pick this.
> 
> This is a wrong approach as wq are not the correct approach for
> dmaengines. Allen has recently posted an alternate [1] and we would do
> the subsystem conversion for these.

[1]: 20260108080332.2341725-1-allen.lkml@gmail.com

-- 
~Vinod

