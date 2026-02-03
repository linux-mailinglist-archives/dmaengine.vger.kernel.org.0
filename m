Return-Path: <dmaengine+bounces-8693-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKv9DL/6gWk7NQMAu9opvQ
	(envelope-from <dmaengine+bounces-8693-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 14:40:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DDCDA016
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 14:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B629300533F
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F20E3A0B08;
	Tue,  3 Feb 2026 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZnnzVMh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3239E6FC
	for <dmaengine@vger.kernel.org>; Tue,  3 Feb 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126008; cv=none; b=qWM+PSfiOoL8g3oE+8Twx7Phn14hvvFPLJVvsKxpCH9OE5D5Csmg7NJ1K6ap3+WuORZgE1B+wS8qD3AsnowvJFg1Ap9H9S8hkAhSsuY5NcvnhtagYJiyl5pJi1h1/M7EFwEt3OfThZhKW9yyEmO0lVpLPcuAy+GkQ083LJJezoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126008; c=relaxed/simple;
	bh=hXVAYbl+/7hTSOo2G7V9Qw5oWOm4Y31oafWAXd4Uuzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8XU0+8mdminzBG1UFUmLY9rG424mph/trnJlKo/a2OJlQ6sBdfCNi31mzsDdRf9qO+PHfpkXB54/m9g4udHmyeSylVlwD4tmfMnv19mbGB5RqVVuEuGpuSgvs/O92zbajKb8gzxSbUCx5srPuQ0ZI+jwhUsEsPBspGwErNgxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZnnzVMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B90C19425
	for <dmaengine@vger.kernel.org>; Tue,  3 Feb 2026 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770126008;
	bh=hXVAYbl+/7hTSOo2G7V9Qw5oWOm4Y31oafWAXd4Uuzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KZnnzVMhOms0A+5wlS8RFKbMyhnmzbRJZ1K3Dq56Xu0TqvtnqUQiSWmMl1MIfSJ7Y
	 nY1aaIGXlDsKtnPxdfzhFdY1E2c9Sd/blHEVdBXZ9lcv5PcizPU0HAxCdV3X94YSZY
	 YJaN8UL3nS8W9M2/pxmr5TKOGP3WQnWotff83//4vRX+E2Q7Bwt6+C0vlzWnjzY/oE
	 RDQULx2dnaVvsGPmrWkkKbVyx1EZUnyUH6K5Wd8rYiZsuHYw5/aRM73Rf1QRjgghxQ
	 vpA88VSH0e1VCvmYvPqwRZWv3O5eKgGcEyea7KHkOEOhUyux4GqaMg71ZjIVE6FEDa
	 v1hhWvQCoSPZw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59deec3d8dcso7379386e87.3
        for <dmaengine@vger.kernel.org>; Tue, 03 Feb 2026 05:40:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaMHf8bFvJDwo0tQR7qIMQCLcTFr0Sbb6ZvTNEQEQYYx7BqECGpVXpELwt2+l1Jw3Ctu8u/fYdS4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhrkXPMH8wjD0QyNLzrpsj2pexa5VTf2RYERI8fW1gmWspkJoI
	rjkwXhB0EGWpFsvXz56BYe3WwfFOLiuIwqQEwRN6IeJEm34BFRkKGYbH9mMaAbr3clkrg9M2toM
	hlZ898npC/+OBsozwrhFnxi6SQPTUECkGf1sudlqp9w==
X-Received: by 2002:a05:6512:3d89:b0:59d:dd44:37ee with SMTP id
 2adb3069b0e04-59e1643c336mr6245152e87.43.1770126007130; Tue, 03 Feb 2026
 05:40:07 -0800 (PST)
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
 <CAMRc=MejA90TRue6F2JjQXHYo0AmFxc-gKkwNX0EKzP5scB14Q@mail.gmail.com> <CAMRc=Me7cZffQjtVtCX-cNtR_eKv6eJydaJMFEBpy3_CzzBZCQ@mail.gmail.com>
In-Reply-To: <CAMRc=Me7cZffQjtVtCX-cNtR_eKv6eJydaJMFEBpy3_CzzBZCQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 3 Feb 2026 14:39:55 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfuGas5fTkd9ShO+3_JMFOuWAE=MXKX4Zr0LWpN95bk2Q@mail.gmail.com>
X-Gm-Features: AZwV_QjULmLMBZMWNN6TVN0AvaUyXiEk_rgIOTNj6n1r9NKE_uAwmpHcq-Axp6Y
Message-ID: <CAMRc=MfuGas5fTkd9ShO+3_JMFOuWAE=MXKX4Zr0LWpN95bk2Q@mail.gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8693-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,kernel.org,vger.kernel.org,linaro.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47DDCDA016
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:33=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Wed, Jan 14, 2026 at 4:37=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.=
org> wrote:
> >
> > >
> > > > But they might eventually right?
> > > >
> > >
> > > Yes, and they will already have the interface to do it - in the form
> > > of descriptor metadata.
> > >
> >
> > Hi! Have I answered all your questions? Can we proceed with this?
> >
> > Bartosz
>
> Ping.
>
> Bart

Before I repost it after v7.0-rc1 - can you please let me know if all
your questions have been answered and if we can proceed with this
approach?

Bartosz

