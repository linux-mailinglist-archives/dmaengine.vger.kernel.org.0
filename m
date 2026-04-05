Return-Path: <dmaengine+bounces-9885-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FMGBqrl0mlecAcAu9opvQ
	(envelope-from <dmaengine+bounces-9885-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 00:43:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A56BE3A0050
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 00:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D46483001474
	for <lists+dmaengine@lfdr.de>; Sun,  5 Apr 2026 22:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502D2D8DDB;
	Sun,  5 Apr 2026 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+jRztw6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A829E7081E
	for <dmaengine@vger.kernel.org>; Sun,  5 Apr 2026 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775429030; cv=none; b=pYdscJK3ClXVdT3EcUgzB2AcxS9N2EnMgBTHbCyj5Lt6+/xADnTqhg8daYw9JVVyQYlC5ipodaDeC7htLoilZ+YFgm4O7F1zYeVDOfH84ifE945johD74m4eqdoit5S4kjLUsR3xCNeAw17LqMrkOCWQXzpfm+o+Ix6lBzrLm3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775429030; c=relaxed/simple;
	bh=zzMy5NtaL7AD5tUyCQ9LrBMAHeKvVDbZmilsbp1EV5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnLmfsP8kpNv5Ciivhet9M55KDI9pRGNQLGXQbAN1KC3FC+P1V8byMvLDKxSt66Dy9DUXwY7+I2LXN55Nre7i0QSdnCkE1NEM+OLS1omfQfwAM4UMzGsB97PPKmMpUTAhIqXXaimsWa8y3QNtk9Tk7mqrzm7IT47sLu745Pc1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W+jRztw6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9bff57cb62so552150566b.2
        for <dmaengine@vger.kernel.org>; Sun, 05 Apr 2026 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775429027; x=1776033827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=W+jRztw68nTSFgXqNN9tCP6b8vQP+b5TaoxpkBkgcEayzmntOCIdU17DBQw1qm+lf+
         QPKauq1++dp3kdyCE0F1iELy8WP8QgyAbsMejiAuGReIosjMhJ4XXOMTmqvP6BjQdnXE
         D1h7EJh472X8iloGvDdDlgLvvphVHWwfft/Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775429027; x=1776033827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=FULIc4n4EGFBC7kNZNjNde14UwF9jPeMyYHmuMxtVCbkC3pszYC8gbcFMCK2QTe8PU
         uAq7R5eJyXE1bvHAss+dIh1yzhdDJPB2AZ/oL8HzXY0IkeZCnvmGEFhnO/2RKg+asx/S
         k3i0pTB5LHI9AlFtT7BQET/6EQBk80VtN0GUXKQIPvtlwRQb32aHbRCL3xWuvSwZbmKr
         fRZvNqsDLkT/bsBWs4WQvNs9FIWfVwi4yFSFsR3X9whwdiIQgdKchs8tarZA8tmezH7V
         Gb4aIAJ2EhqDl5QmewNks7vaQizqXsrVkhbIp6sLzQognWM2/8z++41A3Y9gxTqOMXcH
         4MBg==
X-Forwarded-Encrypted: i=1; AJvYcCV9o/T/hSQck4gPqubv6lY5a43zzmAN3/BgTYiEvYOBkNQzAseIKUrJ1L2l0cM3zFeUpTOmoZZiwm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKgUvUgiEMZ4E2XmzClQT0KwuR5pqoxJVnYBnDy72DMGo+qrM
	XYxkq9BIBoSp44TStGhwNqEVYqyr0l//Q3QnyFzIkShMHildDBHYz84tpLoSR9VXkG8YchouOfY
	xBIrLBg==
X-Gm-Gg: AeBDieuBHUT84F/E31IdWi0rVSr273OYJtFizLQ5yVlU/7uNuuKfFhPZynup52qL616
	8JbzB64T1JKKNBR/3H+fOaWEEpkOEmb7FozAdAd4IojJ6ES9uDhHEXoYC/FT/ovtk0pDpjP7b5F
	32oudB3YoRn1zr0FeHqJFJKKaKbX2qjVMD3J5EznQHWikWhvbsYCIFz4Xwg/YVqWTqlKXJzxIOZ
	f9dffuzCFGDj5xjkkyyGrpVlmhthxOA3B/xMiwRNyPxul8yrruEae9HGuyvQlgpTqj5+386cX7C
	knai+sJaEqeK8mdw0MYZ7STr4OSscqYdHxvyA37dRzv1oK1BIf0IfqWxNc4Ko5PSUOajML3s/x7
	n92xhObElbX3nRpW02TIXeETkILByCXi9pgXVd3LY7SuZtocS8kFMcyF1hPxWRw3NrStaSMeoPZ
	wxp8uMDH+XmSB802uHfEqpbDmZaTVpteDJLInxg1VNEGwK5kn8eP6IVXogw9532Q==
X-Received: by 2002:a17:906:9c86:b0:b98:42e5:7e42 with SMTP id a640c23a62f3a-b9c67b8c772mr516014966b.51.1775429026984;
        Sun, 05 Apr 2026 15:43:46 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3d028995sm422910166b.57.2026.04.05.15.43.46
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 15:43:46 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfd96354aso2026939f8f.1
        for <dmaengine@vger.kernel.org>; Sun, 05 Apr 2026 15:43:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU57ML6GA0lyGLkXsdEeD30a8txi1SY8ZI2VvBxSfp+F3eMfWwTz8jzq5qRMmqItXNjZRISlvR27dE=@vger.kernel.org
X-Received: by 2002:a5d:5889:0:b0:43b:47ee:4586 with SMTP id
 ffacd0b85a97d-43d292d34e1mr14051064f8f.29.1775429026066; Sun, 05 Apr 2026
 15:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org> <2026040539-sponge-publisher-2b42@gregkh>
In-Reply-To: <2026040539-sponge-publisher-2b42@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 5 Apr 2026 15:43:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
X-Gm-Features: AQROBzBHjVedWun0AWH98b5RajBbraAAaRvLQSenEhaNEY8p1Czch8mAczvPiQQ
Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Saravana Kannan <saravanak@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, Johan Hovold <johan@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Alexey Kardashevskiy <aik@ozlabs.ru>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Frank.Li@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, alex@ghiti.fr, alexander.stein@ew.tq-group.com, 
	andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch, 
	andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org, broonie@kernel.org, 
	catalin.marinas@arm.com, chleroy@kernel.org, davem@davemloft.net, 
	david@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	driver-core@lists.linux.dev, gbatra@linux.ibm.com, 
	gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev, 
	jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org, 
	kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com, maddy@linux.ibm.com, 
	mani@kernel.org, maz@kernel.org, miko.lenczewski@arm.com, mpe@ellerman.id.au, 
	netdev@vger.kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	oupton@kernel.org, pabeni@redhat.com, palmer@dabbelt.com, 
	peter.ujfalusi@gmail.com, peterz@infradead.org, pjw@kernel.org, 
	robh@kernel.org, sebastian.hesselbarth@gmail.com, tglx@kernel.org, 
	tsbogend@alpha.franken.de, vgupta@kernel.org, vkoul@kernel.org, 
	will@kernel.org, willy@infradead.org, yangyicong@hisilicon.com, 
	yeoreum.yun@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,rowland.harvard.edu,lst.de,google.com,intel.com,ozlabs.ru,arm.com,linux-foundation.org,ziepe.ca,ghiti.fr,ew.tq-group.com,codeconstruct.com.au,lunn.ch,linux.intel.com,eecs.berkeley.edu,davemloft.net,vger.kernel.org,lists.linux.dev,linux.ibm.com,bootlin.com,gmail.com,jms.id.au,8bytes.org,lists.infradead.org,lists.ozlabs.org,kvack.org,armlinux.org.uk,samsung.com,ellerman.id.au,suse.de,redhat.com,dabbelt.com,infradead.org,alpha.franken.de,hisilicon.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9885-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[84];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,chromium.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: A56BE3A0050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Sat, Apr 4, 2026 at 10:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 03, 2026 at 05:04:54PM -0700, Douglas Anderson wrote:
> > NOTE: one potentially "controversial" choice I made in some patches
> > was to always reserve a flag ID even if a flag is only used under
> > certain CONFIG_ settings. This is a change from how things were
> > before. Keeping the numbering consistent and allowing easy
> > compile-testing of both CONFIG settings seemed worth it, especially
> > since it won't take up any extra space until we've added a lot more
> > flags.
>
> Nah, this is fine, I don't see any problems with this as the original
> code kind of was doing the same thing with the "hole" in the structure
> if those options were not enabled.
>
> > I only marked the first patch as a "Fix" since it is the only one
> > fixing observed problems. Other patches could be considered fixes too
> > if folks want.
> >
> > I tested the first patch in the series backported to kernel 6.6 on the
> > Pixel phone that was experiencing the race. I added extra printouts to
> > make sure that the problem was hitting / addressed. The rest of the
> > patches are tested with allmodconfig with arm32, arm64, ppc, and
> > x86. I boot tested on an arm64 Chromebook running mainline.
>
> I'm guessing your tests passed?  :)

Yup, all the tests that I've run have passed. I also threw in an
"allnoconfig" compile test just for good measure.


> Anyway, this looks great, unless there are any objections, other than
> the "needs to be undefined", which a follow-on patch can handle, I'll
> queue them up next week for 7.1-rc1.

Thanks. As per the other thread, I'm happy if you or Danilo want to
apply it, and I'm happy if you want to make minor fixups when
applying.

When I see the patches applied, I'll send a followup patch to address
the "needs to be undefined" comment, unless Danilo makes that change
himself when applying.

-Doug

