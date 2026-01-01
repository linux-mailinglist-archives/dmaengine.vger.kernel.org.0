Return-Path: <dmaengine+bounces-7990-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDC6CECFE4
	for <lists+dmaengine@lfdr.de>; Thu, 01 Jan 2026 13:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 954413004D3F
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jan 2026 12:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B372367DC;
	Thu,  1 Jan 2026 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3/UTAVS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEDE481B1;
	Thu,  1 Jan 2026 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767268835; cv=none; b=JCVXupQcQydnqZn7xq59baBKf+wHLfOceBIAsED2yilFg6MRkYKj6Fvv1Ni3v4ikaWW53HtNORGdIiiO++HhI2YsDxcUfXjuek39wcwtH9GD7TTJlqZgrAKLVlO496iQcQThruc+1fjcX9a2xeAZp4VBIb8iWB623fUJmLrRnVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767268835; c=relaxed/simple;
	bh=QzKh6f7nUY47srlYNQnBRLEB0H4I9ghlJ3SDVOEKV78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNTeld/szhNUnEdtB8dKMp2d0LB/Mug/Mbix7im8cUwU2JPkCY59NGjP88Q9EYX2V1E2xVAC/c+5YxZQoZrbQj9XnzfGI4UJg7zfHYg654mJDxEq7OqX+3S4ZP2zzYhcjsW6O5zl2P3zcWdFFQBHU1JuBzqzedgbIe5FwEyiyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3/UTAVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A523DC4CEF7;
	Thu,  1 Jan 2026 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767268834;
	bh=QzKh6f7nUY47srlYNQnBRLEB0H4I9ghlJ3SDVOEKV78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3/UTAVS0ACod3pYkZFw5A8GpoGh3CQJhNkjPw58DvLwUY+JSSwebwX1+kD2Jpqvg
	 Ba/FzZsgqiHUyrecxLgYBQOxYMxur8RJZvrkBmS38cUMRnfWEX75zavxJvrLd35pZ8
	 3kOMRcqennrMYCcNLamZTDzgS1LiTW7kQkI7LoqDBM80xfJvbA2RTZgpOExuOmeczx
	 K3g1oUZn7DqlKdqAP4jbNR9xoPvR3p/z1RbEmNRi/oFSDJZqNLh0C1RGbxL3Eoxf7W
	 gVSfiKLP+3REy4xROxQuFxSnLzlBfrFaS86oaN5BNBssWgtcX8yaV7+TmNTV3eDExU
	 46xxKJR518rng==
Date: Thu, 1 Jan 2026 17:30:30 +0530
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
Message-ID: <aVZh3hb32r1oVcwG@vaman>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>
 <aUFX14nz8cQj8EIb@vaman>
 <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
 <aUF2gj_0svpygHmD@vaman>
 <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
 <aUpyrIvu_kG7DtQm@vaman>
 <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>

On 23-12-25, 13:35, Bartosz Golaszewski wrote:
> On Tue, Dec 23, 2025 at 11:45 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 17-12-25, 15:31, Bartosz Golaszewski wrote:
> > > On Tue, Dec 16, 2025 at 4:11 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > > >
> > > > I am trying to understand what the flag refers to and why do you need
> > > > this.. What is the problem that lock tries to solve
> > > >
> > >
> > > In the DRM use-case the TA will use the QCE simultaneously with linux.
> >
> > TA..?
> 
> Trusted Application, the one to which we offload the decryption of the
> stream. That's not really relevant though.
> 
> >
> > > It will perform register I/O with DMA using the BAM locking mechanism
> > > for synchronization. Currently linux doesn't use BAM locking and is
> > > using CPU for register I/O so trying to access locked registers will
> > > result in external abort. I'm trying to make the QCE driver use DMA
> > > for register I/O AND use BAM locking. To that end: we need to pass
> > > information about wanting the command descriptor to contain the
> > > LOCK/UNLOCK flag (this is what we set here in the hardware descriptor)
> > > from the QCE driver to the BAM driver. I initially used a global flag.
> > > Dmitry said it's too Qualcomm-specific and to use metadata instead.
> > > This is what I did in this version.
> >
> > Okay, how will client figure out should it set the lock or not? What are
> > the conditions where the lock is set or not set by client..?
> >
> 
> I'm not sure what you refer to as "client". The user of the BAM engine
> - the crypto driver? If so - we convert it to always lock/unlock
> assuming the TA *may* use it and it's better to be safe. Other users
> are not affected.

Client are users of dmaengine. So how does the crypto driver figure out
when to lock/unlock. Why not do this always...?

-- 
~Vinod

