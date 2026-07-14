Return-Path: <dmaengine+bounces-12506-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XvqACkxeVmq54AAAu9opvQ
	(envelope-from <dmaengine+bounces-12506-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 18:05:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 800BC756C80
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 18:05:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ryhf0BkE;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12506-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12506-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 906633029784
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84604A33FD;
	Tue, 14 Jul 2026 16:05:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31E496917;
	Tue, 14 Jul 2026 16:05:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045129; cv=none; b=RNgCVOUNsfLgACYOWwEQVhiCL2MQ7Fj/1HoS4bFzIAYAQjzyt4/kiLGceskixg9rI3FjGFXuqkBG83/PzAkXxdGjoyPuN0xlDj94nKRKOoD/z2I2uNw1NFlKooq7T6wzUx3sFkendaCVLgBorveXAGCRiBEj0QF+JoIGv5UPWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045129; c=relaxed/simple;
	bh=MDoHCNs87EXtL3rx8qeIBw6m0Koa1Rgykf3pDl2NXSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkO+cHhungTfoLQjHtRgmqQEmxH1VyTHMhxlyRi4yOz77DWwVq6oNEYAn1eJz8/+gasjWjZUMPtDtaS6+l4a6ZVyd+hQC6PMS9qZcAgpEYOEXq2HiKBs3mU/qL3Cb9b20IiUU7ohG3U7WQCcqfelQz9EWQZvHgGLY1Zd25/CatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ryhf0BkE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D701F000E9;
	Tue, 14 Jul 2026 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784045128;
	bh=Xtm2njAn76Q+rLnBuvCrV+rDc41S16pGG3DUYxM41+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ryhf0BkEXHDctx++jvuZlEpB0nvbqlRQwWT7yUm9lSAXCXudxcLuHpE6iEpjvXKi8
	 PL/fb3OwrGhwDGXG8qUGXdFdNpcUkXTo3vh7jgpfznX+uv5U0BJjTClhfqZkmo0xcE
	 FYdOSTArIc0Cl4HKZytv5QemzVoQLrF6SAirbG1A=
Date: Tue, 14 Jul 2026 18:05:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>, stable@kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: fl1-edma: Add error handling for
 devm_kasprintf
Message-ID: <2026071416-siberian-untying-2f54@gregkh>
References: <178403257631.822807.3647660559296965382.b4-ty@kernel.org>
 <544a88f9-d523-4add-af0b-93337de4556c@web.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <544a88f9-d523-4add-af0b-93337de4556c@web.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,m:Frank.Li@nxp.com,m:griffin@kroah.com,m:stable@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[web.de];
	TAGGED_FROM(0.00)[bounces-12506-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 800BC756C80

On Tue, Jul 14, 2026 at 05:58:32PM +0200, Markus Elfring wrote:
> > > Add error handling statement to fls_edma3_irq_init() for the
> > > devm_kasprintf call.
> …
> > Applied, thanks!
> > 
> > [1/1] dmaengine: fl1-edma: Add error handling for devm_kasprintf
> >       commit: bf1af4dfdc017dfe989c0dbcf0e608dc95f1d2cb
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?h=next&id=bf1af4dfdc017dfe989c0dbcf0e608dc95f1d2cb
> 
> Would it become helpful to add the following tag?
> 
> 
> Fixes: d175222f5e90b7e1f23713378823c338fabb3258 ("dmaegnine: fsl-edma: add edma error interrupt handler")
> 
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

