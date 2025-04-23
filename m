Return-Path: <dmaengine+bounces-4989-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654A6A988D8
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3253AE5D2
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02E4202F79;
	Wed, 23 Apr 2025 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jvq0XRxN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D85FC08;
	Wed, 23 Apr 2025 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408903; cv=none; b=TrJMCdp5avxCdKGQYDIl3ykJ9+a07/5Gw330hV5ZWqOI64tdPd8RZwvR0RDpn0I4lpfW3QNVERpO8OIdyIlq34vNnB5FAnsQ6EVc39cE2SuDCewEV2490G0mfktYl7V2mtW4ullRhS/7e6Xl67Qe37Z6dftpe6VDjIOVjcpHg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408903; c=relaxed/simple;
	bh=VUjQSnbpe34n4H4pjsG/e0RneYGeJ6IEAMI0EPffIbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgAw1k2CNof9wRiMb5gqdNYS6MPKrqxwNAGNWpfmWgcqVGkSrhj5NYojlqexD0GjUZZWPxGjtydewrconXCwNVtnYADPWqMjRIDF0SkbqK5V7XAj1ISsEWI3wmqUCUa8DFt3E/qEcv8rGq1bkoD6/VzihiqljgK9KgOuiLemw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jvq0XRxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CF1C4CEE2;
	Wed, 23 Apr 2025 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745408903;
	bh=VUjQSnbpe34n4H4pjsG/e0RneYGeJ6IEAMI0EPffIbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jvq0XRxNhZoppgh9qzCZg1srPngC2jUPOMRakVSq2EoT7uduMeaby5L0NsSFTWXjh
	 T5EOWw0+GZGGdk/8ODO1S8mnRehBulTYEveU1NMgbv5I3gU1oJ29AaQRQak4c0laDa
	 C+iU/HwHxE7hHF8Ag3QYOOMzjiqnFhwuvJgVdnj874lxUj50fFXPH0jn4eFBJrm3HH
	 Cx/aYWyGZ3apZJ77pkOLCLJGWwG/duC31tlj5MxyC76I6+MW7KTGntLz0WuwEqJwJ/
	 H5VSo3Ay1JB0kIoE6DhWucSDtaalvlCpA3M1lR2gcyJYbOPJ98xko8GevrUPc258yt
	 1VwgdxFTHNiZQ==
Date: Wed, 23 Apr 2025 17:18:19 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Robin Murphy <robin.murphy@arm.com>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ARM_DMA350 should depend on ARM/ARM64
Message-ID: <aAjTg8dgvxqLQOwQ@vaman>
References: <50dbaf4ce962fa7ed0208150ca987e3083da39ec.1745345400.git.geert+renesas@glider.be>
 <b1f19b31-3535-4bb5-bcef-6f17ad2a0ee6@arm.com>
 <CAMuHMdVJKA8zYETKJTRAwg6=+EuTq4YqbFO32K4+py9YNsD1Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVJKA8zYETKJTRAwg6=+EuTq4YqbFO32K4+py9YNsD1Gw@mail.gmail.com>

On 23-04-25, 13:11, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Wed, 23 Apr 2025 at 12:59, Robin Murphy <robin.murphy@arm.com> wrote:
> > On 2025-04-22 7:11 pm, Geert Uytterhoeven wrote:
> > > The Arm DMA-350 controller is only present on Arm-based SoCs.
> >
> > Do you know that for sure? I certainly don't. This is a licensable,
> > self-contained DMA controller IP with no relationship whatsoever to any
> > particular CPU ISA - our other system IP products have turned up in the
> > wild paired with non-Arm CPUs, so I don't see any reason that DMA-350
> > wouldn't either.
> 
> The dependency can always be relaxed later, when the need arises.
> Note that currently there are no users at all...

True, but do we have any warnings generated as a result, if there are no
dependency should we still limit a driver to an arch?

-- 
~Vinod

