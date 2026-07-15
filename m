Return-Path: <dmaengine+bounces-12542-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I9C6FykqV2rwGQEAu9opvQ
	(envelope-from <dmaengine+bounces-12542-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 08:35:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D5475B197
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 08:35:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=YLwXDSeC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12542-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12542-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74A84301BCF5
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 06:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4FB17A586;
	Wed, 15 Jul 2026 06:35:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC226CE2C;
	Wed, 15 Jul 2026 06:35:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097316; cv=none; b=Y3J0e1qWY1quiVPNxgbzHcKKhTxwOMbbOjRELGBY4OSa8cNbppT8WHMTMrm12DltZdBsVaKJ1V9Ve2le28SanK06rbp8MF8KSNdNxhWrbkdorS5oHZ+fsmH/8DtZe2hyQLdB72Elxj2c2JHXzvNvtLoDmJodn8x59Uaw/mFb6wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097316; c=relaxed/simple;
	bh=JrDLFABBv9PO/h72NDq31FifzSDsU8zmGjnQHshu6VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNSDDUKP2X/IG95KT3Hy7h+dKAa5vee9TtB+oWgbsW/ubiN07mJ2xXyCwC/CqzQ48EM6kjKYOrIPzWYsKb4OsnMgZ+RwXd8PxGWLijFW1w4jxDrvrg06IFrmHggkEpchfjNcyTIe/nLvD14qR1XOMIP1OpMpTb+fwF9Jh/sVmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YLwXDSeC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA811F000E9;
	Wed, 15 Jul 2026 06:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784097315;
	bh=ThZYGJbxb1HGBlj61BgHrOJFIan3k407XGoiPZaLxFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YLwXDSeCUxBPUHdMJFEWfqjgCHwXzqXi6lpfM2QfRAOTJXCU1N/ja5il5AyQIhX2A
	 eagv6IsI0nJDB16xr1uSzy4tzTEgHBB4KZ4Fus3j5FqwEAzf9qwIRBSWC2pXtfAzMQ
	 aQhfRE83kQlQSKMpw72kkPxdTcOF7b/5jabhPbSw=
Date: Wed, 15 Jul 2026 08:35:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>, stable@kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: fl1-edma: Add error handling for
 devm_kasprintf
Message-ID: <2026071505-kosher-showroom-1e1e@gregkh>
References: <178403257631.822807.3647660559296965382.b4-ty@kernel.org>
 <1ef78e50-0578-44cd-84ff-87a0f497c48f@web.de>
 <alch-r9QvhyiblOC@vaman>
 <ac9b775f-7a3e-4bf3-9f31-058039a7dd93@web.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac9b775f-7a3e-4bf3-9f31-058039a7dd93@web.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,m:Frank.Li@nxp.com,m:griffin@kroah.com,m:stable@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[web.de];
	TAGGED_FROM(0.00)[bounces-12542-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72D5475B197

On Wed, Jul 15, 2026 at 08:11:09AM +0200, Markus Elfring wrote:
> >>>> Add error handling statement to fls_edma3_irq_init() for the
> >>>> devm_kasprintf call.
> >> …
> >>> Applied, thanks!
> >>>
> >>> [1/1] dmaengine: fl1-edma: Add error handling for devm_kasprintf
> >>>       commit: bf1af4dfdc017dfe989c0dbcf0e608dc95f1d2cb
> >>
> >> Frank Li requested a corrected patch subject.
> > 
> > Which was done while applying
> > bf1af4dfdc01 dmaengine: fsl-edma: Add error handling for devm_kasprintf
> I find it unfortunate that an improvable text was mentioned in the notification.
> 
> Did different development opinions remain if all involved function names
> should usually be marked with parentheses?
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

