Return-Path: <dmaengine+bounces-11771-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jsJNEJ7sPGr5uQgAu9opvQ
	(envelope-from <dmaengine+bounces-11771-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 10:53:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52FF6C3FCF
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 10:53:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MdLasqpf;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11771-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11771-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DC8C3006151
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB66438550E;
	Thu, 25 Jun 2026 08:53:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEC385D99
	for <dmaengine@vger.kernel.org>; Thu, 25 Jun 2026 08:53:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377626; cv=none; b=iPeQ40Z+055VGIfzfMKk1E7/zYfhMDNTyk34+P7uAQ/CTRVWyqIGvIxPc5GryQzk2/ABtkmBWNx4BoPeo/QjbpK3Qiu0aGEiHYVilk2DHZX+0ORDsjotWaKbCVrQwmSXCWtRmuKEI5eQUlD7i7U7fzk7HoMVFf2WSne9m+t1Nx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377626; c=relaxed/simple;
	bh=aG9UPb6X3t49TQGKWNh8CixzzbYHvf/dhqIW9MNKXCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvkacCifwjcwIxXiGSOtanroQDU2ATg9aHGzynKYC71bSBn0TaIyzzfX07EABdyXPgFdMWPHzpdA97RH4kmmT/cDIXSfnnEQ4gglG9dracqb7FBD6BmNY2WydOP1ahEOIHoE3m3VQ2dpBSq9uet+d7zHlKiqMGGd9q3CCllPfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdLasqpf; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so19615505e9.1
        for <dmaengine@vger.kernel.org>; Thu, 25 Jun 2026 01:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782377624; x=1782982424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rOgQcEJt6Q/UXFy+W00eved1xO9DzXrtsP5AvlpEQN4=;
        b=MdLasqpfkOXRRB466ILiGSAwfihYqJyXKtgfkNP9i/GMOs6Xx374FGCX7/yMAPPHEw
         n9XHR6qu7ob3UARi7qiX1eBctc6QHCbQPSDT+irE79FzKu9grfJbbsN5ojtTMWDI5cjt
         axSLYMqdylwbaanqlIHYUY9dEKJOQcmHR1wTj7bAr/miJE6svZ88O0X7WQCBBNv6oBsx
         P0jskw0Kht/LMv7fNnn5NOj5yPEaP0XZQ7YbcbnkD0XLanOU+mJjRHgz2aWQDiLJpmO1
         RNM1FUOWe3WV554YXZ5Jwvyk65CWptz66eRDHZZCZ/k+SVqvUwwK0IQERfXWD6QgmGYi
         ZUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377624; x=1782982424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOgQcEJt6Q/UXFy+W00eved1xO9DzXrtsP5AvlpEQN4=;
        b=Pj4jbTSD5N4CChvGVgiLKfivynaODs5jrmKkqTajrl1lnU00DuML2ym0X/leUaYwGj
         L7M0bxiytzmMwPg1l1wUPUNZ8tsVMoKkm14FzqhZENphknX4mXzOekzLB3uSIpoEW77e
         N+U9I3kODExLgNhJ6tQVqRp4j3TmZiVveHcT4bQ20J33oAdIFhyE+dg2DaUQoESrnHNb
         hCpMSybG4niShgb0pUQ0qkbPLe3+sZAfsiRR8ejx4hpu0Dz9NaEi7nf8C/Jo/RlgwjQW
         A1ygi+taFLrWOre6CUXc47BYCFlwxD2hliXYwNj60iaFSvqAAjPgq/JeQ99zlYpEN21I
         m/7w==
X-Forwarded-Encrypted: i=1; AFNElJ84w7Mr1f607ncxygv4a2c3bsoOiqDmy6eS5WxMC9pc/jvHeWx9XPTa1GzTss9An13It2HSqO7KLLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5mx467aG7sXLy9WezJS8DU43TgdHufOZIImI9TNGdpf/SS0Q
	2FcVM/WVLis2XO56ZwPkumr43GCTGjTEPHtR42tkoe/Cy9XoZ4CutYKF
X-Gm-Gg: AfdE7clUVUWw7Xz1AdzAos7FEndpyuaW2G4FsJqT7Tyj6C99cKpFGJL8ptV3hY7/o8I
	5R5rHV4gGOX69OeX/8LtHVfVwUSMeg0HVZFb44P5myXSPSPxB2PoVBhuoilhLUhVtwb4WhFTS04
	fPFDOZamiDmAbExvqXCQccICPQCrmv+wSw0nhiWlITy97RA3a3YSERC1OLnGBT6N4JkUlVU7Ui5
	pfRuQrZBiPxOAFdiB97HQCONOfsRdZ+nZV9nZ1WaRkzE0Qx9jQHwiI9WdfvRxhKr1c/eErSFNzX
	1U/j5Xh+T07aEnaH+L5R7kFZulKxpADI1+WE9NMS9S/ANykOPonyjcCTDsy9t73Dj6fbS7O/SFP
	J+wU7LFzAOVR2Ot0fd8jKCmdPhmTJqTvX/e8inOGs41d0X4GO1n3PXT+KKJz+vsX25U9TT2H7zA
	4LXQ==
X-Received: by 2002:a05:600c:c1d7:10b0:492:4667:8c40 with SMTP id 5b1f17b1804b1-492668638c1mr15548305e9.8.1782377623588;
        Thu, 25 Jun 2026 01:53:43 -0700 (PDT)
Received: from nsa ([45.94.208.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49264082426sm58844265e9.9.2026.06.25.01.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:53:43 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:54:46 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com, 
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajzsjhXHzpV2phby@nsa>
References: <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
 <ajlR9QiXiBAH4mWH@nsa>
 <ajmAP2nKzi2dPEVx@SMW015318>
 <ajpYvzlHSPiJRvnX@nsa>
 <ajpfmQ6JID5rHLMF@ashevche-desk.local>
 <ajv4NVSmSR_dn9CJ@nsa>
 <ajwKq0CB8sGdvvcO@SMW015318>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajwKq0CB8sGdvvcO@SMW015318>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11771-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:andriy.shevchenko@intel.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,nsa:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D52FF6C3FCF

On Wed, Jun 24, 2026 at 11:49:47AM -0500, Frank Li wrote:
> On Wed, Jun 24, 2026 at 04:33:53PM +0100, Nuno Sá wrote:
> > On Tue, Jun 23, 2026 at 01:27:37PM +0300, Andy Shevchenko wrote:
> > > On Tue, Jun 23, 2026 at 11:14:51AM +0100, Nuno Sá wrote:
> > > > On Mon, Jun 22, 2026 at 01:34:39PM -0500, Frank Li wrote:
> > > > > On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> > > > > > On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > > > > > > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
> > >
> > > ...
> > >
> > > > > If support 4Byte, it native supportted any N*4Byte.
> > > > >
> > > > > So needn't bit mask to indicate all support bytes.
> > > >
> > > > > > > each transfer, dma_slave_cfg should set specific bus width requirement.
> > > > > > >
> > > > > > > If memory have requirement for 32bytes, typical cache line length for
> > > > > > > hardwaer coherence transfer, it should use dmaengine_alignment.
> > > > > > >
> > > > > > > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> > > > > >
> > > > > > What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> > > > > > there... The code seems to use the dma bus width to match against PCM
> > > > > > formats supported and filter only the ones we can support (per dma cap).
> > > > >
> > > > > if cap is one byte, it should support 8, 16, 24, 32, 64
> > > > > if cap is two byte, it should support 16, 32, 64
> > > > > if cap is 4 byte,  it only support 32 and 64.
> > > >
> > > > Well, Now I see your point but not exactly. Because we do have
> > > >
> > > > DMA_SLAVE_BUSWIDTH_3_BYTES
> > > >
> > > > and it might be used by the pcm_dmaengine code,
> > > >
> > > > There are also some controllers that set it. But it looks like all that
> > > > set it also set 1byte.
> > >
> > > But this might be not true for all HW in the world. In previous reply I made
> > > a comparison with MMIO accesses where not all HW that needs 1-byte read can
> > > cope with that. If there is some proof that this is the case when 1-byte
> > > DMA bus implies 3-bytes (or other odd number), I would like to see it.
> >
> > True. I'm also not too keen in making the above assumption and have no
> > proof that it will work for the controllers we support.
> 
> Okay, I think it is fine by use bitmask. suggest change name to
> src_bus_widths,  addr_wdiths is quite confused.

Ack

> 
> And since not much place use it. suggest change all consumers and cleanup
> original u32 src_addr_widths in followup patches.
> 

Alright! Will include all consumers conversion in followups of the
initial patchset!

Thx!
- Nuno Sá

> 
> 
> >
> > - Nuno Sá
> >
> > >
> > > > So your suggestion might still hold and work but I'm not too convinced
> > > > that having the array complicates things that bad when compared with the
> > > > risk of breaking existing code.
> > >
> > > > > Needn't mask each bit.
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >

