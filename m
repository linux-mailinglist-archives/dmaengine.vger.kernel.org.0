Return-Path: <dmaengine+bounces-8453-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AugJtvwcWlKZwAAu9opvQ
	(envelope-from <dmaengine+bounces-8453-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 10:41:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC9E64B03
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 10:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB12642AC3D
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90C333C1A3;
	Thu, 22 Jan 2026 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXdskpYi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818BF332EAF
	for <dmaengine@vger.kernel.org>; Thu, 22 Jan 2026 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074449; cv=none; b=EuzUnyZte6DC10QbbRtkJoQZxor4DTe6bDZY4CRPAUkdQ0wkAt/1/GjjMgNCZObd9aN9oThg0jntYH+BHXwzQeNIHq09ibsEBoXYyYt9ztQmBNXrbLq1bWHJ4BtEgyo06JwBx9m8LsOQyBf8mvC/q7ig9ICzSEC6vd9zA4FiYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074449; c=relaxed/simple;
	bh=VI3KnFpkzVPIjMyrifZTTlbyrQk7VRd07T9Jofd0qTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbbvPOiWJdnhKl4AZ9ytY/YmM/VYlGN5iEdQEwW7wmN6oUz85t6o6xATfC3VykeFKoCxrnHAKzQM1s/Nv7clPI/Y5dK4eNtci4d4Bjo4P9Rqkpz3bTxZO9UoYvA5u4rrDE7pvBUqsOh1YervKCSI7zz+Y0ok0FUtLK+c7y2Cqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXdskpYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA46C2BCB3
	for <dmaengine@vger.kernel.org>; Thu, 22 Jan 2026 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769074449;
	bh=VI3KnFpkzVPIjMyrifZTTlbyrQk7VRd07T9Jofd0qTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qXdskpYi5m8LPpFLiygZkA+z0Ni+xBVS7ojMEilhhO70St4Hpz7JtBgTbKkVKCcTr
	 y14usomIV/DTBM9biYFWmtuhHy2HiLJhbdfwWlPE0QheP4g+n74RsTH0O+JJuIk2Cp
	 PO4pi1hcEugw8MNfVGOJP28rZXsBgcqXEf7Hq8jcwlm36X9/qxZPXFhVbXlKGoKiCN
	 +Ew9j0TGnuLecapjZgqn0rFAObhQdrxM5CEPewETzQ8fujZJ830OizDiu4FkgqG4RR
	 C7BEd65kS60ZEaBbzLpTWP7hilTvwMiCbO22E/B3t8Zfu5arfot+M1M/e2bsvUigtZ
	 VGILARU5XDYYw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-383153e06d6so6519491fa.0
        for <dmaengine@vger.kernel.org>; Thu, 22 Jan 2026 01:34:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXT4PS1yhFsv4J7WVmTCKr/6RvrWmowGbb/PIeynqBJAYm/EXmf4QASupoo7qmR7YcxC4/9qUO1M6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrxDQkNYfwQea13yGLBil0F2AcZAnXUejfVMDAbZmEZSIeSWh
	s3h2cP3FE4QA0ELvk1731h7AHEiNXlVSIEF32xa60tYdiG2SxJbi7vG+Imm0+o7HH3aXsLIqxGk
	6k9AYebVnKmGpC39X3yPtxcUMu3J4T1wmat92kN451g==
X-Received: by 2002:a2e:a589:0:b0:37f:d911:5941 with SMTP id
 38308e7fff4ca-385a546f058mr26782401fa.21.1769074447641; Thu, 22 Jan 2026
 01:34:07 -0800 (PST)
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
 <CAMRc=MejA90TRue6F2JjQXHYo0AmFxc-gKkwNX0EKzP5scB14Q@mail.gmail.com>
In-Reply-To: <CAMRc=MejA90TRue6F2JjQXHYo0AmFxc-gKkwNX0EKzP5scB14Q@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 22 Jan 2026 10:33:55 +0100
X-Gmail-Original-Message-ID: <CAMRc=Me7cZffQjtVtCX-cNtR_eKv6eJydaJMFEBpy3_CzzBZCQ@mail.gmail.com>
X-Gm-Features: AZwV_QhTxZsMbBIptV61AxdCydQlt4fhsgrQnsF7LtUbiNRe0UrslhgUjBrTCVQ
Message-ID: <CAMRc=Me7cZffQjtVtCX-cNtR_eKv6eJydaJMFEBpy3_CzzBZCQ@mail.gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,kernel.org,vger.kernel.org,linaro.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8453-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FC9E64B03
X-Rspamd-Action: no action

On Wed, Jan 14, 2026 at 4:37=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> >
> > > But they might eventually right?
> > >
> >
> > Yes, and they will already have the interface to do it - in the form
> > of descriptor metadata.
> >
>
> Hi! Have I answered all your questions? Can we proceed with this?
>
> Bartosz

Ping.

Bart

