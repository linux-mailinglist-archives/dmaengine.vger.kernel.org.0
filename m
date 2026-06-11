Return-Path: <dmaengine+bounces-11437-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HLIpHHVGKmpAlgMAu9opvQ
	(envelope-from <dmaengine+bounces-11437-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:24:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D52D966E84E
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:24:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kjcr8NEa;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11437-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11437-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F64A30463B6
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11192EA731;
	Thu, 11 Jun 2026 05:16:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F5282F36;
	Thu, 11 Jun 2026 05:16:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155018; cv=none; b=s8+zDoVwEeZqJU4WEFofEKvdOad9yj2xKIR3hLj3fQfnNny5RyaXRWbPk/u/uxxdFLGviD7xA7zzCBaGY8+nze967qBlnegt8MLb/ScldLUBJNHCFWUtUFI2TvyH7EuHR3OSbYpvQZAdtQz+Hccc2TTycPjDbiUg3CIB51hFUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155018; c=relaxed/simple;
	bh=UxU8NW1oxglHhvrpRbd3iv5XCWknDkPJGquhC55/Lk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaYt35wRNcWrNW6Owo+hTWWbzz1J0lSsgi1rN1dVxRVYfHNsXscgZBtazuEdXVDhsCueGfdTuJG/9sp3mCUbE9t28HoHQ9IJ8D/HyUgnDIaAjI2wia556gNiqzEpvtQulMLfcMMdiwmF9TEsY8Q6/hD4CR5CY7MqktquuE1rYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjcr8NEa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7DE1F00893;
	Thu, 11 Jun 2026 05:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781155016;
	bh=/nLRK4QUMz1r3MO+y0IocMo3n6pFJgB1ZjfRsbA+0cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kjcr8NEa0cSPi+PCTHlPQDG3xORmWbo/EoQT5aqWdp9jb0IIV9ppl5jLw/DKCZgCa
	 bAiRaQwjR39mSfsmq3QixrX111ZIFce0d9ZL4ZRuWfdkLNAfwcGc6o1RP3rDZB3rPN
	 B3u0Wa+Cd7+ylkMMBdrdRriFG9kWPswvW4Qh5GDGtwaz6mXyMuiGNKQk8GJUiI3zpr
	 pmfJuRu1cgh0I1Mx0Sbq9cn32kNI1DOT1KwNGUTWZ7W0EsjcV9UcTe8dKRrL6tCEuQ
	 dHzeqp9A/Vk6qXXR1a8dove9JfrQVq8pHYCnmZPJUJTgBcUvMlDct+segYJRJoqO7I
	 GJy8FIER1H0NQ==
Date: Thu, 11 Jun 2026 10:46:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org,
	Frank Li <Frank.Li@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] dma: mv_xor: use devm for dma pool and irq
Message-ID: <aipExHHd1Lrh0xQb@vaman>
References: <20260610065737.118211-1-rosenp@gmail.com>
 <20260610065737.118211-4-rosenp@gmail.com>
 <ail38Mx0r6cW_Wej@SMW015318>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ail38Mx0r6cW_Wej@SMW015318>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11437-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vaman:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D52D966E84E

On 10-06-26, 09:42, Frank Li wrote:
> On Tue, Jun 09, 2026 at 11:57:37PM -0700, Rosen Penev wrote:
> > Replace dma_alloc_wc with dmam_alloc_attrs and request_irq
> > with devm_request_irq. This eliminates the need for
> > manual cleanup of the dma pool and irq in both the channel
> > remove function and the channel add error labels, removing
> > the err_free_irq and err_free_dma labels entirely.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> 
> I already said many times, tag should dmaengine, not dma, all functional
> need (), please respect reviewer's time.

And the worst is that some patches frpm Rosen have dmaengine, some dma.
That make me wonder how much thought has been given to these changes and
might be just an exercise to push AI generated code into wild and see
what sticks

-- 
~Vinod

