Return-Path: <dmaengine+bounces-8133-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1002DD06D9B
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 03:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF9C4301767A
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 02:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8D13093C8;
	Fri,  9 Jan 2026 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWo19iZR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A727465C;
	Fri,  9 Jan 2026 02:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767925623; cv=none; b=K3tK6R1k2WZGmf+VbxO43/wjV7i1hQbfly44r6wxYUYiaJqumeIh1TL84hcwqKUMQOaMzjol2kyl2c2CXJA0qBXJN+a31t6D1OYufjib/os7DeUy1iFz9+7tFTuMaif28Us70wF388OXmRxD0rUyB/Q7kthT9iY1U2Otu0lzWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767925623; c=relaxed/simple;
	bh=/KCBLBLcf8r3a6KZVBsohReOTxRXrhQzCRY4NGlW7B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZddQZL/q043WgXdDa8YqqzD05EwPpigogflcm0pel09ehKGIPb15fpAieatXyA/VOIiZIE7kgjQktFC6Seu+/Zv7fntexMufCd5p2xcAeHwBiKSRoK4sOSH087nthfRyay7jZLJxi4103BN4ibANOksgdnjekjBjY+HW46UNbRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWo19iZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFA3C116C6;
	Fri,  9 Jan 2026 02:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767925623;
	bh=/KCBLBLcf8r3a6KZVBsohReOTxRXrhQzCRY4NGlW7B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWo19iZR88K61uonWjHoiG/CqWm+XACaOk5i/YW6xUWS3iDgl+Wfj/NbhlcZBOs1p
	 RO2bOuVi3/L8/HueszuU/KPHcEH6BqVRZh9oj+Fn0uLKkl5akavXkDOy/EBhOHVt1G
	 sqbsxwk/aTJUayCQC8eHwUPT4RkFvn1ldmgOZxC8VH2WBRlqqspcXNEU3lBvyUNbL2
	 gI2xOkbrGGwrUyBi/TR0fknoE7yYezRGOEXbOsBskSwcR43ZvuDZXbUMjy3nZK3gpU
	 gnYbiFjA5al3cMVS4MXRC8gCepG5zFT7GxjX47aLYewVVdrLyEWYiOIv38+EZR6NDi
	 3EExJHzxcmKbw==
Date: Fri, 9 Jan 2026 07:57:00 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
Message-ID: <aWBndOfbtweRr0uS@vaman>
References: <aUFX14nz8cQj8EIb@vaman>
 <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
 <aUF2gj_0svpygHmD@vaman>
 <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
 <aUpyrIvu_kG7DtQm@vaman>
 <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman>
 <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
 <aVf5WUe9cAXZHxPJ@vaman>
 <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>

On 02-01-26, 18:14, Bartosz Golaszewski wrote:
> On Fri, Jan 2, 2026 at 5:59 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 02-01-26, 10:26, Bartosz Golaszewski wrote:
> > > On Thu, Jan 1, 2026 at 1:00 PM Vinod Koul <vkoul@kernel.org> wrote:
> > > >
> > > > > >
> > > > > > > It will perform register I/O with DMA using the BAM locking mechanism
> > > > > > > for synchronization. Currently linux doesn't use BAM locking and is
> > > > > > > using CPU for register I/O so trying to access locked registers will
> > > > > > > result in external abort. I'm trying to make the QCE driver use DMA
> > > > > > > for register I/O AND use BAM locking. To that end: we need to pass
> > > > > > > information about wanting the command descriptor to contain the
> > > > > > > LOCK/UNLOCK flag (this is what we set here in the hardware descriptor)
> > > > > > > from the QCE driver to the BAM driver. I initially used a global flag.
> > > > > > > Dmitry said it's too Qualcomm-specific and to use metadata instead.
> > > > > > > This is what I did in this version.
> > > > > >
> > > > > > Okay, how will client figure out should it set the lock or not? What are
> > > > > > the conditions where the lock is set or not set by client..?
> > > > > >
> > > > >
> > > > > I'm not sure what you refer to as "client". The user of the BAM engine
> > > > > - the crypto driver? If so - we convert it to always lock/unlock
> > > > > assuming the TA *may* use it and it's better to be safe. Other users
> > > > > are not affected.
> > > >
> > > > Client are users of dmaengine. So how does the crypto driver figure out
> > > > when to lock/unlock. Why not do this always...?
> > > >
> > >
> > > It *does* do it always. We assume the TA may be doing it so the crypto
> > > driver is converted to *always* perform register I/O with DMA *and* to
> > > always lock the BAM for each transaction later in the series. This is
> > > why Dmitry inquired whether all the HW with upstream support actually
> > > supports the lock semantics.
> >
> > Okay then why do we need an API?
> >
> > Just lock it always and set the bits in the dma driver
> >
> 
> We need an API because we send a locking descriptor, then a regular
> descriptor (or descriptors) for the actual transaction(s) and then an
> unlocking descriptor. It's a thing the user of the DMA engine needs to
> decide on, not the DMA engine itself.

I think downstream sends lock descriptor always. What is the harm in
doing that every time if we go down that path?
Reg Dmitry question above, this is dma hw capability, how will client
know if it has to lock on older rev of hardware or not...?

> Also: only the crypto engine needs it for now, not all the other users
> of the BAM engine.

But they might eventually right?

-- 
~Vinod

