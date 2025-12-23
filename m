Return-Path: <dmaengine+bounces-7872-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC87CD8F75
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01FEF30CD40F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9761832FA05;
	Tue, 23 Dec 2025 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFOKKs8D"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF42D192B;
	Tue, 23 Dec 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766486706; cv=none; b=byfuNkQJc2HzXGHbvZe/aNtyaS3Xno+kJTEpkvCHjJB+Y8JoKv4axJOWr66lG6zRWUCk7K1qH+p4syrWXiAU4Ud3+zaChsBYDwugx0i2ufTo8Q81XB+3s+8tO2pzSVFr52P9ECXPd/+TRtVtVtViJV9AdJ+NXwlHkSW7k60FqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766486706; c=relaxed/simple;
	bh=Dw+s2veHz9tzYkC8xHi9bZLR2VrPnu0KbZZR01qPO/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOau56RHfEgvUbw1IWvm2TAJjB53UrfM0u/GAI+8en/nQFGOYIWblVN+r28Mcm99qEc5UukByvqTyN1pFopW3jtGg05ALJPfOiFE8tdmS1CCrs1Rg5TPlWWuxq5YnLcov6pl0lDDl3yAcRcex9EcuJ7XHZWVzPZdFDdrNQb3B7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFOKKs8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3342FC116B1;
	Tue, 23 Dec 2025 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766486703;
	bh=Dw+s2veHz9tzYkC8xHi9bZLR2VrPnu0KbZZR01qPO/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFOKKs8DUYP7F22SMp3CMv/7dpkEynkYNNRNcEKllIdVMfeNb5JTz+w2A3JmhABio
	 9DqulUP6bhwWmTqI0xzcqZdrTbM9uqQE05oDWepPjJTtMDK+F7Uy9v7sfa2U1C0gJN
	 fJ1tzezd7rxiIeInAmD018zUSlV4/+1oHF5Up9U9LFzCeW2SG67R8RjX6NwdyrhEFQ
	 o9zzli1cDH1Ao631dAmkNfvzGzcQ8MWOg5/RnhMOakbrcqeR+OyNfnYKq2ClCdVQgn
	 Qur7p9iBOBXc/r64WOGKHb2VUhbcutC1pL1wq8LTfj4LvYZuc50/Et2DbLAvOjIxOA
	 FOeEoQO4Fy0FQ==
Date: Tue, 23 Dec 2025 16:15:00 +0530
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
Message-ID: <aUpyrIvu_kG7DtQm@vaman>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>
 <aUFX14nz8cQj8EIb@vaman>
 <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
 <aUF2gj_0svpygHmD@vaman>
 <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>

On 17-12-25, 15:31, Bartosz Golaszewski wrote:
> On Tue, Dec 16, 2025 at 4:11 PM Vinod Koul <vkoul@kernel.org> wrote:

> >
> > I am trying to understand what the flag refers to and why do you need
> > this.. What is the problem that lock tries to solve
> >
> 
> In the DRM use-case the TA will use the QCE simultaneously with linux.

TA..?

> It will perform register I/O with DMA using the BAM locking mechanism
> for synchronization. Currently linux doesn't use BAM locking and is
> using CPU for register I/O so trying to access locked registers will
> result in external abort. I'm trying to make the QCE driver use DMA
> for register I/O AND use BAM locking. To that end: we need to pass
> information about wanting the command descriptor to contain the
> LOCK/UNLOCK flag (this is what we set here in the hardware descriptor)
> from the QCE driver to the BAM driver. I initially used a global flag.
> Dmitry said it's too Qualcomm-specific and to use metadata instead.
> This is what I did in this version.

Okay, how will client figure out should it set the lock or not? What are
the conditions where the lock is set or not set by client..?

-- 
~Vinod

