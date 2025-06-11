Return-Path: <dmaengine+bounces-5370-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C5AD597C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 17:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5623A5AD7
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB8F18BC1D;
	Wed, 11 Jun 2025 15:02:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26710185920;
	Wed, 11 Jun 2025 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654157; cv=none; b=oTE6WxMZbo9F9rP7nxOu3RTIDYBd849nGTRZ/w0nl33AJ7MBt8QRy4smqK+RlNWMAkqIjxRYX7UD7OLhEiZSZvC1jubQ/P8k4BA8KU6e8vDZSem1YhZPMJuPugfkwHPbEXNVyRYsFraHrbNNyUuk1dabzyWF1XoLGiTIWNnhUto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654157; c=relaxed/simple;
	bh=R51eJwT5fuIM/kOLvJJLfDor4mLaTCANFivMFtewIu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvUCrb+OPxlrmzR1vT4tiEFallIevjm2kEUsELeax9HmN6BTcnyMYA2fntG4iTMOuAPf1sbbTNTUYAVgQiPihyglVwcFvYR0zQD3j05dXM4jwvJTZTjDPu5p0eVr7QS/998bgMS1Tu5JqK95XoDRuhqoi4SGcPd7YQpci8Q7l4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id BBBDC340D21;
	Wed, 11 Jun 2025 15:02:34 +0000 (UTC)
Date: Wed, 11 Jun 2025 15:02:27 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	drew@pdp7.com, emil.renner.berthing@canonical.com,
	inochiama@gmail.com, geert+renesas@glider.be, tglx@linutronix.de,
	hal.feng@starfivetech.com, joel@jms.id.au, duje.mihanovic@skole.hr,
	elder@riscstar.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 6/8] riscv: dts: spacemit: Enable PDMA0 controller on
 Banana Pi F3
Message-ID: <20250611150227-GYA127466@gentoo>
References: <20250611125723.181711-1-guodong@riscstar.com>
 <20250611125723.181711-7-guodong@riscstar.com>
 <20250611135757-GYC125008@gentoo>
 <CAH1PCMbt3wLbeomQ+kgR6yZZ18TZ=_LF-kCcnLqad55FSHBhDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH1PCMbt3wLbeomQ+kgR6yZZ18TZ=_LF-kCcnLqad55FSHBhDA@mail.gmail.com>

Hi Guodong,

On 22:32 Wed 11 Jun     , Guodong Xu wrote:
> On Wed, Jun 11, 2025 at 9:58 PM Yixun Lan <dlan@gentoo.org> wrote:
> >
> > Hi Guodong,
> >
> > On 20:57 Wed 11 Jun     , Guodong Xu wrote:
> > > Enable the Peripheral DMA controller (PDMA0) on the SpacemiT K1-based
> > > Banana Pi F3 board by setting its status to "okay". This board-specific
> > > configuration activates the PDMA controller defined in the SoC's base
> > > device tree.
> > >
> >   Although this series is actively developed under Bananapi-f3 board
> > but it should work fine with jupiter board, so I'd suggest to enable
> > it too, thanks
> >
> 
> I'd be glad to include the Jupiter board as well. Since I don't have Jupiter
> hardware for testing, could someone with access verify it works before I
> add it to the series?
> 
Do you have any suggestion how to test? like if any test cases there?

I would assume it work fine on jupiter since it's a SoC level feature?
instead of board specific..

-- 
Yixun Lan (dlan)

