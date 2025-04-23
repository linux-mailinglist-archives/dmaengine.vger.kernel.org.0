Return-Path: <dmaengine+bounces-4993-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E01A9897E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 14:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4246517A2E1
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947791F152D;
	Wed, 23 Apr 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzB+jlA3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBC1E86E;
	Wed, 23 Apr 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410626; cv=none; b=mq2W0iGaLsoz6YxF375mDqIGufQ62hrF+g4447V00OvvPz+n3iQFO/l1MpFl9KoM1EiCjVEV4gh9CeHIZO1Wrd0UZld0apYoAYfTb7ZQMBuDugsl557Ww9AXc8aAVqDaoXUmEjgk4XItSV8Jj+2d9XeWG6Qis7kka1rObVaGDI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410626; c=relaxed/simple;
	bh=s6sHA2mYPiaTg1SBSDd0rm5YqfRkSrgtUKA0vRyKMRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnktyvKvpW42JjQ8l6qeeOEQQX0LM5bTBQFtbtY48WOPGISH3XUPtpxlRItGrzTd6EprHvLstWiZcopGNd7xbN2likxYiOgS5bCe2euqMNJJ2otaG+vL0QOnJtlbKIhlZreOWsatjSEtArGqzYPOGQ7kAuCuE/1v/DK0Sq++MoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzB+jlA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C995C4CEEC;
	Wed, 23 Apr 2025 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410624;
	bh=s6sHA2mYPiaTg1SBSDd0rm5YqfRkSrgtUKA0vRyKMRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzB+jlA3mrMH9LuaG5V+4T5n5YnQaMTgGdJSpCiIKLO8ug7B48W22vYV6EIaG3ek8
	 JLHTKfDq6A9uN4hAmJ1MPs6VOyODGxKGUt7Jtxjp/gq0vn0ipixo0OQqcoHieGAfDG
	 8Sa7ixVZLU8ZKoxd6iq0JJTHPg5Ce7Q8CDmq0F98T9xPPlcGfdz0Ysj7Ri0yEniGaY
	 BVD2FNR5AzyOyw8fhiBscwIz1gqYJeG/kocGjz0XoY2KUBuuzlVl0l60sZAFwR/U+V
	 y6YpZlqueU54lyP15YD/aoMI2Km3y4g07jRL7J5513Rti3PKSjEvypD1iONOzQy1g5
	 zs1pIMmpPe2dA==
Date: Wed, 23 Apr 2025 17:47:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Robin Murphy <robin.murphy@arm.com>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ARM_DMA350 should depend on ARM/ARM64
Message-ID: <aAjaPV/2DSyPAGRB@vaman>
References: <50dbaf4ce962fa7ed0208150ca987e3083da39ec.1745345400.git.geert+renesas@glider.be>
 <b1f19b31-3535-4bb5-bcef-6f17ad2a0ee6@arm.com>
 <CAMuHMdVJKA8zYETKJTRAwg6=+EuTq4YqbFO32K4+py9YNsD1Gw@mail.gmail.com>
 <aAjTg8dgvxqLQOwQ@vaman>
 <CAMuHMdXQKG0qptWMi169MVBL1S3hPo1TsaOSxWspoHAwRd+fug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXQKG0qptWMi169MVBL1S3hPo1TsaOSxWspoHAwRd+fug@mail.gmail.com>

On 23-04-25, 14:13, Geert Uytterhoeven wrote:
> Hi Vinod,
> 
> On Wed, 23 Apr 2025 at 13:48, Vinod Koul <vkoul@kernel.org> wrote:
> > On 23-04-25, 13:11, Geert Uytterhoeven wrote:
> > > On Wed, 23 Apr 2025 at 12:59, Robin Murphy <robin.murphy@arm.com> wrote:
> > > > On 2025-04-22 7:11 pm, Geert Uytterhoeven wrote:
> > > > > The Arm DMA-350 controller is only present on Arm-based SoCs.
> > > >
> > > > Do you know that for sure? I certainly don't. This is a licensable,
> > > > self-contained DMA controller IP with no relationship whatsoever to any
> > > > particular CPU ISA - our other system IP products have turned up in the
> > > > wild paired with non-Arm CPUs, so I don't see any reason that DMA-350
> > > > wouldn't either.
> > >
> > > The dependency can always be relaxed later, when the need arises.
> > > Note that currently there are no users at all...
> >
> > True, but do we have any warnings generated as a result, if there are no
> > dependency should we still limit a driver to an arch?
> 
> I am not aware of any warnings (I built it on MIPS yesterday ;-).
> It is just one more question that pops up during "make oldconfig",
> and Linus may notice and complain, too...

True, give there are no users, lets pick this and drop if we get a non
arm user

-- 
~Vinod

