Return-Path: <dmaengine+bounces-12114-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9DugLnonTmriEAIAu9opvQ
	(envelope-from <dmaengine+bounces-12114-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 12:33:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 387727245D8
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 12:33:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MBkuwrWC;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12114-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12114-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E22813026ABE
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 10:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0573393DF1;
	Wed,  8 Jul 2026 10:21:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA4138B123;
	Wed,  8 Jul 2026 10:21:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506086; cv=none; b=CRNYPkjLS/LhZwHAbcxDUohS3pCOBJw8ixz5LxreWlAJ2wpS8bFpjSWNNTib8vrE1g7BeqMxMKrBnlW2tujN1zakwA88JHmZNEayPJOL6epNmLcQr8+1vdptRbjlx5oGplGE/9TKWwYKySIyou+WovPuqp5/aIxXNEh00WUHqus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506086; c=relaxed/simple;
	bh=gCcoQRbLE3sC22yjHQgD83mY5XUQM9RM71SgIV7Io2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbTL/GC5v15C46G/dZOhvafZY6Xz6VqPMTbT7qO/R/ymjV/vpZLsjDsSa7d9YXNrYz89g+l5GxM//Q+9h3tOdYeJlDZ6vu80qo8sMvRzbUbYQzrbYa5TXDF7ciyU1/Yrgtxb0zL1Rv5V8TTLSmhn0YVmLurn6fxFTatF2ULBszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBkuwrWC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D871F000E9;
	Wed,  8 Jul 2026 10:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783506084;
	bh=iMLpjqBMiG0QAJnu6K5ue6Z2J4hOxDdx42FnKNEaR8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MBkuwrWCZFsty1/oywDMtDpA8qd84gYEqc/DFTNGxQbi2mAm0VybN8dy17H8JMyH+
	 OFe+bHPTwQMP6fANHKHXIKeQLu3bARuqoUtKfTxI4V6abtP8KWiwB5GAJzBPa0DkPn
	 QF5PrQoiCH+800R0aXSo1KEzHSR1Lp5r5Az7lwWIwQX+Aufg1oaWVVBvmHu7NO7yaK
	 QGUWpbQ2bB67bZ/CPRLNVIoXC+UQbr1jIOnotaeOuZ7L3/qhD/OcIoZXI5kvwUEylJ
	 Bdsw8zoR9abq7So9pJF0pRFbFpdMezLlLw2SSbq7Oh/+ab4eEkiWcIO71KpjBKP47X
	 qd3kZgtuse+OA==
Date: Wed, 8 Jul 2026 11:21:18 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/11] regulator: db8500-prcmu: Remove EPOD regulators
Message-ID: <20260708102118.GG2108533@google.com>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
 <20260702155113.GW2108533@google.com>
 <CAD++jLnEDzkinxjv6Ce7JRCLy1A5BSHLTBp2KpQ5sOvKUygCtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnEDzkinxjv6Ce7JRCLy1A5BSHLTBp2KpQ5sOvKUygCtw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12114-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ulfh@kernel.org,m:broonie@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lee@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.infradead.org,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 387727245D8

On Fri, 03 Jul 2026, Linus Walleij wrote:

> On Thu, Jul 2, 2026 at 5:51 PM Lee Jones <lee@kernel.org> wrote:
> > On Thu, 18 Jun 2026, Linus Walleij wrote:
> >
> > > Remove the obsolete DB8500 PRCMU regulator drivers.
> > >
> > > Drop the regulator build hooks now that EPODs are power domains.
> > >
> > > Keep the MFD cell around because a later patch reuses it for a
> > > small compatibility regulator driver.
> > >
> > > Assisted-by: Codex:gpt-5-5
> > > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > > ---
> > >  drivers/mfd/db8500-prcmu.c             | 239 +---------------
> > >  drivers/regulator/Kconfig              |  12 -
> > >  drivers/regulator/Makefile             |   2 -
> > >  drivers/regulator/db8500-prcmu.c       | 501 ---------------------------------
> > >  drivers/regulator/dbx500-prcmu.c       | 155 ----------
> > >  drivers/regulator/dbx500-prcmu.h       |  55 ----
> > >  include/linux/regulator/db8500-prcmu.h |  38 ---
> > >  7 files changed, 1 insertion(+), 1001 deletions(-)
> >
> > Any deps?
> 
> Not really, was planning to split off the stuff that can go
> directly to MFD and resend it with all the ACKs.

Sounds good.

-- 
Lee Jones

