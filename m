Return-Path: <dmaengine+bounces-11756-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H/b4F2CZOmoGBQgAu9opvQ
	(envelope-from <dmaengine+bounces-11756-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 16:34:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB12B6B7F06
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 16:34:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GhNJRBh8;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11756-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11756-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C47943020D55
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD037FF4D;
	Tue, 23 Jun 2026 14:32:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50C327C09
	for <dmaengine@vger.kernel.org>; Tue, 23 Jun 2026 14:32:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225175; cv=none; b=dDbGaM+t45eVjIK+jwTS32mTnbQDSWU3bLMxZrKAErZaCpo+k62TBYLETd3NJayN8cafb8Bm9kP3sgJGkKhGoCSFfEm3k6+VZFP3CL3IZiRpG+zcZSsYcD3RMNHPjJz+VH4Ua6B5mwLxpesgLq2pJ+LnEWNBVVAo7ofEpd2G/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225175; c=relaxed/simple;
	bh=7ux0Lhtez84UEZLgPd0cB2gsvx8mSzbdmS4PsNfNucg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQU1MT9tVdbCO7yoMNw3kCu9sI9hIxgBgkb1YbVT75dNWQnYQqj65aEYNKyd28K8sZDdQIl2JhxAST5a7PnBSS5huFQl2V0mz4KgMKcmoRLAMyfzsVidyusWXr31V4B5604Ol9uC+yWzy5yTnOoqFGBXPAk6xDkNBsMzHwtp85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhNJRBh8; arc=none smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-697edb1bf6eso14557a12.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Jun 2026 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782225172; x=1782829972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHS7wdFy0blB17IMPzCciGeqlqmt5gtvVsIa9T7SO2I=;
        b=GhNJRBh8dKvw87U9wM6rTXmGlir9g+m0LHVuv9HrdiGR4CZ62kbWZ4JGWWNvwHuZ67
         EzzjqiCRhvJiN1KpDyZsEO3hjR6VGDicDRSO71e5nuyVlrANijTIkfBTSIQ//5rvxJdf
         eoSmct9Dr2TRMlG7vYqKATK+hN2ZwaFIy7dC7uKPzixJV0WqMNB6UZLYPEHCJCpMv87D
         /fTZlgbR/FFazagdeM9mXKL9OdOxCrkFBpPGk0ZwCn4VIaJI7G+HfSclitemRS/ky1Rt
         oh111FNPGT6USb90vuHEzKiY7JCuHoxGJbsRexg9kQ2sXuw7eQw9EeTwcCTozTrPUaig
         jwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225172; x=1782829972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHS7wdFy0blB17IMPzCciGeqlqmt5gtvVsIa9T7SO2I=;
        b=f8eQu92B+BaRKDNK2T1WaUqF96BLjq/O/1YmPqR5B8SWtN+CQ2nWxciD1KzO4afm5w
         D5mG70m4dyuKRRcHPYCRWkMOczxQWFbZ+Eq3Rg+yevCTJB1zojxXr1kYQJfoy5UbkAQ2
         ce6s74y0FrFzALS6DCceXfxtBtUY03Gdq7LHHvsSUpYPPc9TTSNi2mvHISc34M/5qgfI
         s0l31bEeod/K2zUZbD0j6fDBm5/aJ+CmauRl2A2wNnB/WRlvEQvvRHJb9jAmWBFkxJVu
         QAxpCL2mPL2wNdf0esrbxEZ00aSg3GKQU9K6/WCrSPRoBYIzlkDdHJXBC8iM7EH7Rr1U
         UE1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+4g5LpRBNZncxDrmHmLPIi6hx7hi9tW1Bh2mbDro3ta9n6dYcHWRvkuFwSOx2trpjBYFKSA9YXnWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfxjbhbHRY+1+3w0hIfnPX7Maw4bQKTd8QjfloGnhfWmof9ocO
	y3B2zmvHFqmyixHnLJD0YnCRamB9oO5WABzogpTVRnOeuDVvwQ6UGh/n
X-Gm-Gg: AfdE7cknP5V7BfFT1LozEK6QGAlGOj8aUK1Sjy13VcpJVFUQJ48oWpJWUFK3jHWziyK
	LMEQxsCAqF1HDUmE8kmlUrbp3d93vviVJJp2SxaGKAp8tXh7ZH7CXyLpSiC+K8kHzYD8uWFZgvS
	ngvjLgYN3E1TzrzqW/DD9OCV9u8xbxYz6CVWFiOKnRJQH31kmkhrK+qdYYQDLnWiGJZLx8702KN
	cagjZDB0YjajNUricb7PvkOVuDLC4gUaZTtRNJm0YU833rPcelAXu018GQ0cr2TxBBaYaleaW8z
	hHu0k+lHL+YwHcZl04op8r930I/tOm7jTuhgcWida8M19ZvnPnBgkj+amp3/gF/aWgJ5xF4Fc0C
	dQCf62T7BZ+k3Xu39RIKMaUdOywRSc5NG3FEBs3CXWaelptHdhdly9hkMX3IxJw6g8OOMxSoyDq
	Pw3I+lBJJLPtCDdUmjaaMMDombWo3zsD1FOsvX3N1wx5RjjQbpkr2wUd4sxvhuWpTyFe6kcZh01
	mKj/0ms
X-Received: by 2002:a05:6402:3221:b0:697:8f1e:e919 with SMTP id 4fb4d7f45d1cf-697dbaf6041mr1867063a12.1.1782225171581;
        Tue, 23 Jun 2026 07:32:51 -0700 (PDT)
Received: from localhost (dhcp-91-156.inf.ed.ac.uk. [129.215.91.156])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b86de31sm4669848a12.12.2026.06.23.07.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:32:50 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:32:50 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: shivankg@amd.com, Stephen.Bates@amd.com,
	PradeepVineshReddy.Kodamati@amd.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: SDXI on AMD EPYC (in relation to =?utf-8?B?TmF0aGFu4oCZ?=
 =?utf-8?Q?s?= SDXI dmaengine patchset)
Message-ID: <20260623143250.xk3gzylxhcozgz7i@wrangler>
References: <20260623103204.qvmd5luse4vmhwl3@wrangler>
 <875x39ies3.fsf@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x39ies3.fsf@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nathan.lynch@amd.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kmanaouildev@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-11756-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmanaouildev@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wrangler:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB12B6B7F06

On Tue, Jun 23, 2026 at 08:10:04AM -0500, Nathan Lynch wrote:
> Karim Manaouil <kmanaouil.dev@gmail.com> writes:
> >
> > I have a dual-socket AMD EPYC 9004 in the lab (I pasted /proc/cpuinfo at
> > the end) and I wanted to see if I can get the SDXI series from Nathan [2]
> > to work on them, as this will open the door for me to experiment more on
> > AMD hardware.
> >
> > I don't know if these CPUs are equipped with these accelerators or not.
> > lspci is showing these devices (four on each NUMA node):
> >
> > # lspci | grep SDXI
> > 06:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > 21:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > 41:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > 64:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > 81:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > a3:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > c1:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > e1:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> >
> > All of them have these PCI specs
> >
> > vendor=0x1022
> > device=0x14dc
> > class=0x088000
> > subsystem_vendor=0x1458
> > subsystem_device=0x1000
> > BARs= 	BAR0/1 512 KiB prefetchable
> > 	BAR2/3 512 KiB prefetchable
> >
> > Class 0x088000 is:
> > base class    0x08  System peripheral
> > subclass      0x80  Other system peripheral
> >
> > However, the PCI device class does not actually match the class from
> > Nathan's patchset [2]:
> >
> > +#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
> >
> > +static const struct pci_device_id sdxi_id_table[] = {
> > +	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
> > +	{ }
> > +};
> >
> > So these functions appear to be exposed as generic system peripherals
> > (base class 0x08, subclass 0x80) rather than as SDXI processing
> > accelerators (base class 0x12, subclass 0x01).
> >
> > Do you know whether these AMD 1022:14dc on this platform are actually
> > SDXI accelerators?
> 
> Afraid I don't have any information about these devices. The driver
> isn't intended to support them.

Thank you for the reply, Nathan!

Is it public information which family of AMD CPUs have these
accelerators? Could you potentially share the device's PCI ID?

-- 
~karim

