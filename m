Return-Path: <dmaengine+bounces-3022-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA12964C90
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 19:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA48F1F210D2
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685A1B6539;
	Thu, 29 Aug 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhGXw6ZI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E381B5327;
	Thu, 29 Aug 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724951011; cv=none; b=KHYkRU9wGZoYgcHxC/I69bq5hUtVQ8P/Ohh89eUkhUbAxfilf48XvSP9/eHZhthv7KYyPEP7xQtOhEKitU5z1TeN9++1QYGeYEsFTi1555Iq4eEsT4ETZZFV0Rd6cV0p5RYGxyQqJgEWhVSVmjZAim2Wpt7Ht+kK5a758RZBU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724951011; c=relaxed/simple;
	bh=fF3MZfjWlsFpCSUK05YMBeA2C4rmrtnhmYrTtq1uU0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW63gZSVoprUKRSAaRWq8wrvyvH1unqnO4Rkiiq1olTpHkM615AEqYVw+fpJ1tRR84EqUeoaHlfpKrWvfMahw+sCm86bPkhiAOJsh/tmz70KJL9hk1+9Ep+mAPacEqFQv1eRk9wf5HYQY2/sTAdh9j2oWKoakIy3GM6Oks8mXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhGXw6ZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1892C4CEC1;
	Thu, 29 Aug 2024 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724951011;
	bh=fF3MZfjWlsFpCSUK05YMBeA2C4rmrtnhmYrTtq1uU0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhGXw6ZIpHaX7JtJXKxC+GfEC1uwdjGFdHd4u3KBEKsgNEMlsfLwY28AzyzstIyy2
	 wuRnpC5FDa2d7QrnJCgninVC5chkrb2PVaVhnfIvb3ITaIJEqj/nH41BFD3ZSz9VM/
	 SoSSYsOc81eMJWqMVcXpC1l24NfFd5ZNrHcib6NsTv+4+4ikTu7YF7mT4InIucpw0u
	 48htY7e+QOgDMhcG62bBjp321l+7fdxiYxcVWLFLbPPFchXxQ2qNUbwdxUQMFbggO5
	 I51KzR4bHsNR2nB0gU3r4wKJouSCitIS7TWi7J8KGrBLKvr2QwjU6oS0u0Dwx8KZ+u
	 T9Wera6VSKTkg==
Date: Thu, 29 Aug 2024 22:33:27 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 2/3] soc/sophgo: add top sysctrl layout file for
 CV18XX/SG200X
Message-ID: <ZtCp346ucJq/V1kP@vaman>
References: <IA1PR20MB495396729244074C36E51E11BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E0D56CE4010C470E4A71BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
 <Zs9kUAeapWeN/4GS@vaman>
 <IA1PR20MB4953572077286AF23A747507BB962@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953572077286AF23A747507BB962@IA1PR20MB4953.namprd20.prod.outlook.com>

On 29-08-24, 09:38, Inochi Amaoto wrote:
> On Wed, Aug 28, 2024 at 11:24:24PM GMT, Vinod Koul wrote:
> > On 27-08-24, 14:49, Inochi Amaoto wrote:
> > > The "top" system controller of CV18XX/SG200X exposes control
> > > register access for various devices. Add soc header file to
> > > describe it.
> > 
> > I dont think I am full onboard this idea, 
> 
> Feel free to share your idea. I just added this file for
> convenience to access the offset of the syscon device. 
> In fact, I am not sure whether it is better to use reg
> offset. Using reg adds some unncessary complexity, but
> can avoid use this offset file. If you prefer this way,
> it is OK for me to change.

I would just add the offsets that I need in local driver header and move
on...

> 
> > but still need someone to ack it
> 
> I am not sure there will be someone to ack it. If this patch
> is kept.
> 
> > > 
> > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > ---
> > >  include/soc/sophgo/cv1800-sysctl.h | 30 ++++++++++++++++++++++++++++++
> > 
> > is soc/sophgo/ right path? why not include/soc/sifive/... (sorry dont
> > know much about this here...)
> > 
> 
> CV1800 is a SoC from Sophgo, it is not from SiFive.

As I said I am not sure, someone who is from this world should ack this
header

-- 
~Vinod

