Return-Path: <dmaengine+bounces-8977-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOLVG2MQl2n7uAIAu9opvQ
	(envelope-from <dmaengine+bounces-8977-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 14:30:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D882815F13F
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 14:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 983F6300CC9D
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A02EB87E;
	Thu, 19 Feb 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBp9QOCA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923341F4CB3
	for <dmaengine@vger.kernel.org>; Thu, 19 Feb 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771507807; cv=none; b=pCu/WI1DGskLlBzAbwoE+Xr7fWy1fUK1sQR9AeI6gPoOYRKBSYbMxH1asgiMzqr3eaIbFuECVTlYHLIrsplm7o7v84MuDUxTOKvQ6GksluYfoXqV9+2aUDgW5q9fGKioqaxoRiGv4oI05Lta8eh4QkJxvUVjdldciJtvr3QYzCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771507807; c=relaxed/simple;
	bh=CFeAzVK4aX+UimM9XjRNhz3UZ0HH3VXJPizLHgu7x4Y=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HML+8iU3GCmYf8rTDDc+WP26pJ7vJv/LXSZWBmpHjJDa4yWTlldAlGhtkRm0A0hLAoQPA9UnGFlp3vjm4DxeYk2z4innglvpDJ19olrjbnbVIhSMI/2xWk8QoJrOChNPiWHAtr2wvVd5mB+/bH6gYjHHbRQyN5BtyGOlY6XXToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBp9QOCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5DDC2BC86
	for <dmaengine@vger.kernel.org>; Thu, 19 Feb 2026 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771507807;
	bh=CFeAzVK4aX+UimM9XjRNhz3UZ0HH3VXJPizLHgu7x4Y=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=cBp9QOCAueMoYsyX4D14rJsVW7dHuumNXCYYOh08Emjr7EpSZESoHg6B6nKo/ffm3
	 H/w9tfo+ISxCbR4P0v+BlcU97WwAjFJgrg1SbeyUJ6XPFoUmjEt9d+xgfrTTq1wE3m
	 Sv/3GbtHpLb8Dgg/rC+aQnUTsDvSKvcp8UxDnQ5hVUunF3cgKTh7c/7XcFssRFjiAe
	 a5QhWUV4cxwOkWq5v/406hjW/vdKRvsa1il9edEygpExx2ePj1pUG79lCykQL5k3QS
	 Ed1cjsfN2oYIbFaKo3IloWo/xGN9G7CfeOfcz2Ls/3AEIDlsOLz2GPXSAQSTn15CyW
	 juHpYnyNLd0vQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3870c7479c0so9162531fa.3
        for <dmaengine@vger.kernel.org>; Thu, 19 Feb 2026 05:30:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXb7FcS2v3P0VoVYqA6VyUz1SlNg5OfyXW8I7P7Z4SieV1jSDTxCKXvjMiXbbULhmRsTxvJQVz6WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrEMhvK7HbggFHeMfoT7hLULTIoir9YOeGwrV+4FqZqQFkmpST
	8pGJlBkrw6r3w5kAg0ww8jGcnpB9IBi5sf0xAUx5cXnEOO2im4ujfUXEJuH4O1vCoIU+PVVGmnc
	ruOHJukURD45qg3O3O65QbFIyTnPKxwLE4u2sNlZXFA==
X-Received: by 2002:a2e:bc23:0:b0:383:2074:ed34 with SMTP id
 38308e7fff4ca-388104fb2a3mr61679151fa.2.1771507805728; Thu, 19 Feb 2026
 05:30:05 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Feb 2026 07:30:04 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Feb 2026 07:30:04 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ana2ugshqjicqscwpdgo6knv53n4zzuwqp376qil27spco5vwh@ck7wmplz52qs>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aUF2gj_0svpygHmD@vaman> <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
 <aUpyrIvu_kG7DtQm@vaman> <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman> <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
 <aVf5WUe9cAXZHxPJ@vaman> <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
 <aWBndOfbtweRr0uS@vaman> <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
 <ana2ugshqjicqscwpdgo6knv53n4zzuwqp376qil27spco5vwh@ck7wmplz52qs>
Date: Thu, 19 Feb 2026 07:30:04 -0600
X-Gmail-Original-Message-ID: <CAMRc=MevcsQ+sWsERQzod-a9A+F8feoLnbBXSkZrUk4zBPYCSQ@mail.gmail.com>
X-Gm-Features: AaiRm53cx-KfiZAxdpSywJ7B0Zb2jcx9rzKgIzLaCRlF3zG9P5JOSW9yiPZ0nm4
Message-ID: <CAMRc=MevcsQ+sWsERQzod-a9A+F8feoLnbBXSkZrUk4zBPYCSQ@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8977-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,vger.kernel.org,linaro.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D882815F13F
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 13:12:09 +0100, Manivannan Sadhasivam
<mani@kernel.org> said:
> On Fri, Jan 09, 2026 at 03:15:38PM +0100, Bartosz Golaszewski wrote:
>> On Fri, Jan 9, 2026 at 3:27=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wro=
te:
>> >
>> > >
>> > > We need an API because we send a locking descriptor, then a regular
>> > > descriptor (or descriptors) for the actual transaction(s) and then a=
n
>> > > unlocking descriptor. It's a thing the user of the DMA engine needs =
to
>> > > decide on, not the DMA engine itself.
>> >
>> > I think downstream sends lock descriptor always. What is the harm in
>> > doing that every time if we go down that path?
>>
>> No, in downstream it too depends on the user setting the right bits.
>> Currently the only user of the BAM locking downstream is the NAND
>> driver. I don't think the code where the crypto driver uses it is
>> public yet.
>>
>> And yes, there is harm - it slightly impacts performance. For QCE it
>> doesn't really matter as any users wanting to offload skcipher or SHA
>> are better off using the Arm Crypto Extensions anyway as they are
>> faster by an order of magnitude (!). It's also the default upstream,
>> where the priorities are set such that the ARM CEs are preferred over
>> the QCE. QCE however, is able to coordinate with the TrustZone and
>> will be used to support the DRM use-cases.
>>
>> I prefer to avoid impacting any other users of BAM DMA.
>>
>
> Sorry for jumping late. But I disagree with the argument that the client =
drivers
> have to set the LOCK/UNLOCK bit. These bits are specific to BAM DMA IP fo=
r
> serializing the command descriptors from multiple entities. So DMA client=
s like
> Crypto/NAND have no business in setting this flag. It is the job of the B=
AM
> dmaengine driver to set/unset it at the start and end of the descriptor c=
hain.
>

But what if a given client does not need locking? We don't want to enable i=
t
for everyone - as I explained before.

>> > Reg Dmitry question above, this is dma hw capability, how will client
>> > know if it has to lock on older rev of hardware or not...?
>> >
>> > > Also: only the crypto engine needs it for now, not all the other use=
rs
>> > > of the BAM engine.
>> >
>>
>> Trying to set the lock/unlock bits will make
>> dmaengine_desc_attach_metadata() fail if HW does not support it.
>>
>
> The BAM dmaengine driver *must* know based on the IP version whether it s=
upports
> the LOCK/UNLOCK bits or not, not the client drivers. How can the client d=
rivers
> know about the BAM DMA IP capability?
>

FYI: the current version of this is v10[1].

In it (and in this one too but let's discuss the current one) the BAM drive=
r
*does* know *based on IP version* whether is supports locking or not. The c=
lient
requests a lock but this will fail if the BAM does not support it. The
client does
not check the BAM IP revision. So yes: it's the BAM driver that's in charge=
.

> For all these reasons, BAM driver should handle the locking mechanism int=
ernaly.
> This will allow the client drivers to work without any modifications.
>

Ok, I'm open to alternatives but please help me figure out the "hows": How =
do
you tell the BAM driver that the client needs (or does not) locking? How do
you handle the case where we need to lock the BAM, send an arbitrary number
of descriptors from the client and then unlock it? How can the BAM know *wh=
en*
to lock/unlock?

> FWIW, NAND driver too is impacted by this missing feature in the BAM driv=
er as
> both Modem and Linux tries to driver BAM and currently Linux BAM driver d=
oesn't
> set these bits leading to crashes.
>

Yes, downstream handles that in a very dirty way (same as downstream QCE).

Bart

[1] https://lore.kernel.org/all/20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7d=
ad4@oss.qualcomm.com/

