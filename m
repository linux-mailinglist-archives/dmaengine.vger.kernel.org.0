Return-Path: <dmaengine+bounces-10011-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePIxNvE13mkRpQkAu9opvQ
	(envelope-from <dmaengine+bounces-10011-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Apr 2026 14:41:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A23FA11A
	for <lists+dmaengine@lfdr.de>; Tue, 14 Apr 2026 14:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B296A300FEFC
	for <lists+dmaengine@lfdr.de>; Tue, 14 Apr 2026 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E3F3E6388;
	Tue, 14 Apr 2026 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQ9Vvq38"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30C3E5ECE;
	Tue, 14 Apr 2026 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170475; cv=none; b=OZWWgtAkLvkVPbMQN5qz6jp/na24AcTVDHpJkAKYi74VP1LRkFBpkrDC4v8OaGb/gXIPJ0lSFQ+opLcPu2HVHW/ceBjVAqI6Iq5my0ZcILKY3s302XuUcjbvIXw2cg753cBkoLBjsAhYNLdOndauKv21mpIiw2IpXaU/2B6C18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170475; c=relaxed/simple;
	bh=G8U+4WpNt4in0UMMQOdtgMiZYV2gUKxHt4bziHo0gnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V31UxOjtQzYow6Z0Up4ajw0KoMS921uV0GxCL3lgMMqBAf2TpJN+MUi+uIzeWn8abV+tpo6L6BKprZ1UmKOqyJ3cpp9xSElKts2SgQhZRkG+XMeXJbG/IU9Os2a8K/BS48cddjQDrDsOo5TUkp/S8wxLatPDybz8LbtYn4LSLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQ9Vvq38; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776170474; x=1807706474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=G8U+4WpNt4in0UMMQOdtgMiZYV2gUKxHt4bziHo0gnw=;
  b=BQ9Vvq38Yb+j00XpFbLYr7k96Uuw2fV9mMTGtbGEmMLpFyhqOYOsQB7a
   vQkOo+EHIqmHao0oc6q43DVNgIqFRi8JOcIoEtxoz2zbyPz2BgunmcqLl
   kfxCcxIehFH/1jPDmMVRaDMXjy3VbAyZEL4PzxPGHPfNkKlekvr4V2zTR
   w6Yuk1sgMzVAARTDMIhAxqgS466Vp8r/vu4/DkEjZqdvUBoZ4Fb7I6K/4
   eNtXaAKBIoFcF4xrgCDxLWea8LSD6kRW/TxnSIRzXKXa4VkDZTtahGseY
   RAI4I6FPr6Jm/rNFs1zeVulikUIPzWbAkzP+PbJn1rKSJ107tcDV9oM/8
   A==;
X-CSE-ConnectionGUID: NU5QM2OgR8am53KoFHwcZw==
X-CSE-MsgGUID: cLaMj8XNTPKCfYF66yUgRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77002554"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77002554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:41:13 -0700
X-CSE-ConnectionGUID: Akqxntp1TEC0Sj8nmTzS0g==
X-CSE-MsgGUID: MhslQKxFTZebrRUR0gjwBw==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:41:11 -0700
Date: Tue, 14 Apr 2026 15:41:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
Message-ID: <ad415SF1zIrCof8W@ashevche-desk.local>
References: <20260328191646.312298-1-rosenp@gmail.com>
 <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
 <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com>
 <CAHp75Vdvn9n_qgBsXTBw8mRxdJcrmCi01JfAGz7oTkKQ1uXBmw@mail.gmail.com>
 <CAKxU2N-QT6KAKzAYDUp_d9ug=1VxHMvegEQDbxS4GumH+8QBWg@mail.gmail.com>
 <CAHp75Vf_Q4OqYgEOBhoFxpKpAkw5_+GJxQCTbA6LnbR0xhOnMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf_Q4OqYgEOBhoFxpKpAkw5_+GJxQCTbA6LnbR0xhOnMA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-10011-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,gnu.org:url,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C50A23FA11A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 04:32:13PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 1, 2026 at 12:31 AM Rosen Penev <rosenp@gmail.com> wrote:
> > On Mon, Mar 30, 2026 at 9:29 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Mar 30, 2026 at 11:41 PM Rosen Penev <rosenp@gmail.com> wrote:
> > > > On Mon, Mar 30, 2026 at 1:46 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Sat, Mar 28, 2026 at 9:17 PM Rosen Penev <rosenp@gmail.com> wrote:

...

> > > > > > -       hsu = devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
> > > > > > +       /* Calculate nr_channels from the IO space length */
> > > > > > +       nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
> > > > > > +       hsu = devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_channels), GFP_KERNEL);
> > > > > >         if (!hsu)
> > > > > >                 return -ENOMEM;
> > > > > >
> > > > > > -       chip->hsu = hsu;
> > > > > > -
> > > > > > -       /* Calculate nr_channels from the IO space length */
> > > > > > -       hsu->nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
> > > > > > +       hsu->nr_channels = nr_channels;
> > > > > >
> > > > > > -       hsu->chan = devm_kcalloc(chip->dev, hsu->nr_channels,
> > > > > > -                                sizeof(*hsu->chan), GFP_KERNEL);
> > > > > > -       if (!hsu->chan)
> > > > > > -               return -ENOMEM;
> > > > > > +       chip->hsu = hsu;
> > > > >
> > > > > Don't know these _flex() APIs enough, but can we leave the chip->hsu =
> > > > > hsu; in the same place as it's now?
> > > > __counted_by requires the first assignment after allocation to be the
> > > > counting variable. The _flex macros do this automatically for GCC15
> > > > and above.
> > >
> > > Why? The hsu member has nothing to do with VLA, where is this
> > > requirement coming from? My understanding is that the check should
> > > imply the minimum sizeof of the data structure and the compiler should
> > > know that way before doing any allocations.
> > Not sure I follow. This patch changes hsu's chan member to a FAM.
> > Where is VLA coming from?
> 
> VLA: variable-length array
> FAM: flexible array member
> The second one is VLA member + size member.
> 
> What your patch is doing is changing a pointer to VLA member.
> 
> > The current code is devm_kzalloc(x, struct_size()). When it gets
> > introduced, I'm sure there will be a treewide conversion to
> > devm_kzalloc_flex, which would automatically set the counting variable
> > for >=GCC15.
> >
> > It's best practice to assign right after since kzalloc_flex does it anyways.
> 
> Still, I'm not convinced we should blindly follow this rule. The
> length needs to be known before accessing the VLA, but it's okay to
> access other members. Leaving hsu member assignment where it's now is
> fine, no need to move it around.
> 
> > > My understanding seems in align with what Gustavo blogged:
> > > https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attribute-in-c-and-linux
> > >
> > > The same is written in the GCC patch description
> > > https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html

If you agree with my reasoning, please send a v4, I will give you a tag.

Otherwise I really would like to understand the justification why the
assignment going first is the best practice and how it may help the developer.

-- 
With Best Regards,
Andy Shevchenko



