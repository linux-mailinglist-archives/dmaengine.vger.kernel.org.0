Return-Path: <dmaengine+bounces-8147-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DE7D0A97E
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 15:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4ADD3054358
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D4935E53E;
	Fri,  9 Jan 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOo7l5zc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C2735E53B
	for <dmaengine@vger.kernel.org>; Fri,  9 Jan 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968152; cv=none; b=MSxB1g+RM3blRZ12G9W+0WUibMcmj69vW554Mq/T+kWyg9CsR98k6CcPLHfl+dAlQUmOroHZLqhObh06sS+GEW4WJ0b2ftPSof3M9F92PL6eNUzyPyf6bOl4eRLnJxX/27m2tFCqWW5dpbvrYFnz7I8L1FqyHm42pEd8EG3ALgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968152; c=relaxed/simple;
	bh=LEkB5xtHjXVuFngpe1PCgKH2zts37TIIn2uF2x0GoHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erV7298nC3BT/AxL4J2/HDnE2WLR1G1obX1ITPECrkQhIXYl3kH2j49KZ6XPcMhUIwHuzkag7kbt78vYh/QheuK2J11o3CuPbMzN2+yWDAs7D86zq/bjnIsxZSPbU8CqOUrV3jZlMWwEYvLB9NEhDJHoRTJMx6E99qGhZmaHK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOo7l5zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C5DC4AF09
	for <dmaengine@vger.kernel.org>; Fri,  9 Jan 2026 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767968151;
	bh=LEkB5xtHjXVuFngpe1PCgKH2zts37TIIn2uF2x0GoHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cOo7l5zcVTtSK8d8ZoTvhHMZ+7r8uJ5wqzr4r0b762f/oSwo5sTMbf3PEl1eTQZdB
	 IvWvKGMgeq3/30kAiV/uEgD4pn8dx//EsSEigWkZsN4Fmut4XXWA2hOEJqN375YqTS
	 SOGIZLBmj+Sjb4ECAWRxEu/pZW8kcdt53t01cCBSJwDyzryPI5px0vXYIzBvA9GEqP
	 0Tv5X4AWL0Sxb09I6GvH1Vuvb2gWzh5DsK8pXApt1MJuXj9v9rxmFSGr4P1YFg5ML8
	 pfai91JtK3wie4Vuz5MrUEnrzxNfyq1Q8Lh6zPWFc7Iljdw0qAadgaBxgTltPCrfKL
	 3AmWZgO0PQgXA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-383251c34e6so2937651fa.2
        for <dmaengine@vger.kernel.org>; Fri, 09 Jan 2026 06:15:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmgXPCSkPDsom/KfmByEH9x//WefGe2bUPqCFrPcyWBxq2sxCUpbPp++DQeuNrajGVPo8X9yiYYa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1M43cFyL96XfQrAU0zAYhMC/MXp2pB7K1RAO02OdjvzS06Dd
	7jS/zDetCHhS9Yl5eXbUMDMipT8cOXToPdlzbUy/CqsmgRoVD8mqn4p3tWFAKVDUYXwsb7RzmCh
	4g7m0Nb7xyWUWf9VmdhNH/k1Zz97YBhoUm2mYRTi/yw==
X-Google-Smtp-Source: AGHT+IEjHf4XcU+bJuvypnOrwB1YOTeQllVX+zgkrui63UfDLj395Ntw/Lg3Gd2DnCc1/V002jcYulQEX3HszG3lhfY=
X-Received: by 2002:a05:651c:507:b0:383:24fe:4eaf with SMTP id
 38308e7fff4ca-38324fe5240mr4126731fa.30.1767968150320; Fri, 09 Jan 2026
 06:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aUFX14nz8cQj8EIb@vaman> <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
 <aUF2gj_0svpygHmD@vaman> <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
 <aUpyrIvu_kG7DtQm@vaman> <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman> <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
 <aVf5WUe9cAXZHxPJ@vaman> <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
 <aWBndOfbtweRr0uS@vaman>
In-Reply-To: <aWBndOfbtweRr0uS@vaman>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 9 Jan 2026 15:15:38 +0100
X-Gmail-Original-Message-ID: <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
X-Gm-Features: AQt7F2rb9IR691hbgnp1FtGr7o2dONlDtlFsUGEVpYxhopq1kqU8-3RQfgdAT9Y
Message-ID: <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
To: Vinod Koul <vkoul@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Udit Tiwari <quic_utiwari@quicinc.com>, Daniel Perez-Zoghbi <dperezzo@quicinc.com>, 
	Md Sadre Alam <mdalam@qti.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 3:27=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote:
>
> >
> > We need an API because we send a locking descriptor, then a regular
> > descriptor (or descriptors) for the actual transaction(s) and then an
> > unlocking descriptor. It's a thing the user of the DMA engine needs to
> > decide on, not the DMA engine itself.
>
> I think downstream sends lock descriptor always. What is the harm in
> doing that every time if we go down that path?

No, in downstream it too depends on the user setting the right bits.
Currently the only user of the BAM locking downstream is the NAND
driver. I don't think the code where the crypto driver uses it is
public yet.

And yes, there is harm - it slightly impacts performance. For QCE it
doesn't really matter as any users wanting to offload skcipher or SHA
are better off using the Arm Crypto Extensions anyway as they are
faster by an order of magnitude (!). It's also the default upstream,
where the priorities are set such that the ARM CEs are preferred over
the QCE. QCE however, is able to coordinate with the TrustZone and
will be used to support the DRM use-cases.

I prefer to avoid impacting any other users of BAM DMA.

> Reg Dmitry question above, this is dma hw capability, how will client
> know if it has to lock on older rev of hardware or not...?
>
> > Also: only the crypto engine needs it for now, not all the other users
> > of the BAM engine.
>

Trying to set the lock/unlock bits will make
dmaengine_desc_attach_metadata() fail if HW does not support it.

> But they might eventually right?
>

Yes, and they will already have the interface to do it - in the form
of descriptor metadata.

Thanks,
Bartosz

