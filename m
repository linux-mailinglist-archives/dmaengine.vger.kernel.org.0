Return-Path: <dmaengine+bounces-8245-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C679D1FD3F
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD4DB3002BA4
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2F139E6D6;
	Wed, 14 Jan 2026 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUf5Vz0/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1B39E194
	for <dmaengine@vger.kernel.org>; Wed, 14 Jan 2026 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405067; cv=none; b=i4lvV4mcu3A87qgOLpEauDcmmfhi8ZA88KDZ/XNyjXc+/HLi6dwGiU1GF53ep2gJlVZzZBqp6XsXgxmf/JqXnI7K4Mxv7jWeA/q8C3XBAWjuwbZXUvYTxDCYv3/laWMD5cBh7184CiCeNDaFX6M8lnm4bKxd+UOkZfZltQKWlok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405067; c=relaxed/simple;
	bh=Jdf2xSexkgbS7ZSYx+UBSEVANbQSyennQNDL47prCVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESfylLcjJNY9Y9VfcspyulY3u0Hwh4niDsDyn/3iTeh0YbajmS22ksOw6qd8HGKOPOzsFDR1dONj0dXVFYdb0k4WAHhjlD3hpp6vlsvfIiqKBMF23iXeEbMdBvkwWHKZy4alOPRrD64nyRR7p1Hi5SA63IWaCKFEx8kksH6fiKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUf5Vz0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C2BC4CEF7
	for <dmaengine@vger.kernel.org>; Wed, 14 Jan 2026 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768405066;
	bh=Jdf2xSexkgbS7ZSYx+UBSEVANbQSyennQNDL47prCVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lUf5Vz0/Ofg5fWusBzXuGU/j1Fc99aFLBoFEng8bt2KCxM9Y73KzVFzIYqbiXBV1B
	 D5GjOX4bDbP5iJVjP1Y6d2va1H7rCfYDzQFVGWRC9HAx/lnToVUoua5fL8vsHKRzxg
	 qE1tkZ95fl5dwWSifffcU0+UveCW9M+vBF7buL59IaMMmwo24A0S5QOrwAJEhkkpFG
	 JMJzfNg2qg0Bikbv5vk4p0Y1o6Nx+AnRsjcfzllHJsF/U5ekwG1g39uxjOacCXvOru
	 0R3sYFDqGFz8qzMN75yPo45MLzLYlCpBFYMkMrDr87e5OsvtFHJisd2pOqomZVVAay
	 rCHhiA4aFdA7g==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso1275488e87.1
        for <dmaengine@vger.kernel.org>; Wed, 14 Jan 2026 07:37:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVspk0cD5dkK7Kt3ILJUJJt2Po7Nj8yMc7h7BlwrDhXEjkmAsW7HX1v32g7j65qyIyX7ht6PfUFq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZtYWJNKVmlEyPTdQMwTgcm0rhln7v6zdGRHEivqE5XSrpKnA
	GAfhgPVQcRnRtq3UExicnPNU2dbalSLf2pTn/DqlCWhHhez05TH8Emzu1roe53lzrz5SJh+KL6B
	7Dg4FGWAklw9uSA6Mo67HpZkbP0J5qgQzndrDS9Cr/g==
X-Received: by 2002:a05:6512:138f:b0:59b:67cf:ac0c with SMTP id
 2adb3069b0e04-59ba0ed7cdbmr1016163e87.17.1768405065358; Wed, 14 Jan 2026
 07:37:45 -0800 (PST)
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
 <aWBndOfbtweRr0uS@vaman> <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
In-Reply-To: <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 14 Jan 2026 16:37:33 +0100
X-Gmail-Original-Message-ID: <CAMRc=MejA90TRue6F2JjQXHYo0AmFxc-gKkwNX0EKzP5scB14Q@mail.gmail.com>
X-Gm-Features: AZwV_Qg8bQsca4MwFyM00i6xD1tJYX8VuM1MGFpBUJPmAwH8VbH65HlWxQe3eOk
Message-ID: <CAMRc=MejA90TRue6F2JjQXHYo0AmFxc-gKkwNX0EKzP5scB14Q@mail.gmail.com>
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

On Fri, Jan 9, 2026 at 3:15=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Fri, Jan 9, 2026 at 3:27=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrot=
e:
> >
> > >
> > > We need an API because we send a locking descriptor, then a regular
> > > descriptor (or descriptors) for the actual transaction(s) and then an
> > > unlocking descriptor. It's a thing the user of the DMA engine needs t=
o
> > > decide on, not the DMA engine itself.
> >
> > I think downstream sends lock descriptor always. What is the harm in
> > doing that every time if we go down that path?
>
> No, in downstream it too depends on the user setting the right bits.
> Currently the only user of the BAM locking downstream is the NAND
> driver. I don't think the code where the crypto driver uses it is
> public yet.
>
> And yes, there is harm - it slightly impacts performance. For QCE it
> doesn't really matter as any users wanting to offload skcipher or SHA
> are better off using the Arm Crypto Extensions anyway as they are
> faster by an order of magnitude (!). It's also the default upstream,
> where the priorities are set such that the ARM CEs are preferred over
> the QCE. QCE however, is able to coordinate with the TrustZone and
> will be used to support the DRM use-cases.
>
> I prefer to avoid impacting any other users of BAM DMA.
>
> > Reg Dmitry question above, this is dma hw capability, how will client
> > know if it has to lock on older rev of hardware or not...?
> >
> > > Also: only the crypto engine needs it for now, not all the other user=
s
> > > of the BAM engine.
> >
>
> Trying to set the lock/unlock bits will make
> dmaengine_desc_attach_metadata() fail if HW does not support it.
>
> > But they might eventually right?
> >
>
> Yes, and they will already have the interface to do it - in the form
> of descriptor metadata.
>

Hi! Have I answered all your questions? Can we proceed with this?

Bartosz

