Return-Path: <dmaengine+bounces-8001-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A48CEF03B
	for <lists+dmaengine@lfdr.de>; Fri, 02 Jan 2026 17:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74C803018F4C
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jan 2026 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDD92D46B1;
	Fri,  2 Jan 2026 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuckP2vU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17472D2382;
	Fri,  2 Jan 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767373150; cv=none; b=gOz2vxrYsIW3sevtL7am5uwWB0/hvm/tx46TptQX6b0KEJ5RoZ9CZt9OqybMPWqyDaG3irMKxrwz9lUePlw34yEm0e7GnkJid7/4xsjeeTGkf7MKsFgHjGz35vXRuEQDJnw45P2UBWNImQIyI4gVFUWFvl4/Hf1B4iUyACqbmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767373150; c=relaxed/simple;
	bh=93aTDd4xZDg4fITRXyUcXLnUNcewMkg/U29u/qTvrYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDF3XKRg4RLsDb8ryX67BuqZ3tZ/4LbzBI6hY0rZWNzsThII5QKQTvTulxxIb2K0ZdOemxUl8Pb9Y9Ib7o2ChsfG7rxDGm8FYASWgHfRWKaU3xAwbNoF8Xx5ivtEeplWxCpTv05Hoe0n2nfFfS8piqfLfSo2ndz+L1uMLpYuXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuckP2vU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DBDC116B1;
	Fri,  2 Jan 2026 16:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767373149;
	bh=93aTDd4xZDg4fITRXyUcXLnUNcewMkg/U29u/qTvrYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MuckP2vUP8cLx7Ib/Y4DR2nTgxjUeC60wDuQymfnPAuug2l71KreoB2UK8KpCxNJ4
	 wBG0NYqQZO+d7WHQrCVMo/nfazHfDttpHdoLZv75qg9Ua/o3b3cRLMtPJEGVJhJGuI
	 iLxEVe6cEqnyHxqiM+G15M9yEkrPbI0QRSkJp1bKA7O5Dm3YAvR+xTS/d2cyVcHQbl
	 dTpW1Cq0XXJlDVkLw9VaZE/8jCWuT8+Vwp5NMxcZoGNxJrSFGxA+ShacAd/2PiCsKZ
	 kjglGj/dDvs7hvOq2+KCtP90Dl6G86hlOyfJ7Mmh+MoYr91FJhcxWaoYRb3JNsyKze
	 Rt3XghPTVjzWA==
Date: Fri, 2 Jan 2026 22:29:05 +0530
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
Message-ID: <aVf5WUe9cAXZHxPJ@vaman>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>
 <aUFX14nz8cQj8EIb@vaman>
 <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
 <aUF2gj_0svpygHmD@vaman>
 <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
 <aUpyrIvu_kG7DtQm@vaman>
 <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman>
 <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>

On 02-01-26, 10:26, Bartosz Golaszewski wrote:
> On Thu, Jan 1, 2026 at 1:00 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > > >
> > > > > It will perform register I/O with DMA using the BAM locking mechanism
> > > > > for synchronization. Currently linux doesn't use BAM locking and is
> > > > > using CPU for register I/O so trying to access locked registers will
> > > > > result in external abort. I'm trying to make the QCE driver use DMA
> > > > > for register I/O AND use BAM locking. To that end: we need to pass
> > > > > information about wanting the command descriptor to contain the
> > > > > LOCK/UNLOCK flag (this is what we set here in the hardware descriptor)
> > > > > from the QCE driver to the BAM driver. I initially used a global flag.
> > > > > Dmitry said it's too Qualcomm-specific and to use metadata instead.
> > > > > This is what I did in this version.
> > > >
> > > > Okay, how will client figure out should it set the lock or not? What are
> > > > the conditions where the lock is set or not set by client..?
> > > >
> > >
> > > I'm not sure what you refer to as "client". The user of the BAM engine
> > > - the crypto driver? If so - we convert it to always lock/unlock
> > > assuming the TA *may* use it and it's better to be safe. Other users
> > > are not affected.
> >
> > Client are users of dmaengine. So how does the crypto driver figure out
> > when to lock/unlock. Why not do this always...?
> >
> 
> It *does* do it always. We assume the TA may be doing it so the crypto
> driver is converted to *always* perform register I/O with DMA *and* to
> always lock the BAM for each transaction later in the series. This is
> why Dmitry inquired whether all the HW with upstream support actually
> supports the lock semantics.

Okay then why do we need an API?

Just lock it always and set the bits in the dma driver

-- 
~Vinod

