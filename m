Return-Path: <dmaengine+bounces-9276-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH/XLwyLqWl3/AAAu9opvQ
	(envelope-from <dmaengine+bounces-9276-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 14:54:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62799212D37
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 14:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F08A301DBAF
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C53A5E88;
	Thu,  5 Mar 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGFpjcPg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CBF39F17C
	for <dmaengine@vger.kernel.org>; Thu,  5 Mar 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718856; cv=none; b=kICCkjNOAw2rnum3Jvt2eOz/j60Ey51VZ2MtYOM2p51dfEtNuuRG6OaCME8p9I9upb7RTZm0UoWd8DFL9ileULQHi8pLQWK/0nVqI1pd3/JFIYCJQh4LdcuHKwtwghkLr2OgkeXcFdKvVPIZKUzwd2aGNyGKYdds6JZOZZG7YcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718856; c=relaxed/simple;
	bh=XNEc9+ahz7dlU1ZGYsJX4Kf6Gy+aD7tZ2f4Pr2djs3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+DyZqZUFqBDxqG0wuYGokGLwc4YQ61jlnOfc7hxabHteKT896h3BIutyNGU7cRpX33pQFY7J1btKzAgwFt6DiqRh2/TZTr4p9KvDHcE71mvzpHe2oJsTLH8zJ0QzHdUMm/OSmzWM3tG2fiHjob85q77oGnPI1JhcUFb48xWC7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGFpjcPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AF1C2BCB0
	for <dmaengine@vger.kernel.org>; Thu,  5 Mar 2026 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772718856;
	bh=XNEc9+ahz7dlU1ZGYsJX4Kf6Gy+aD7tZ2f4Pr2djs3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uGFpjcPgCjDb6i1AShmMLpPt6HWe3ALg4vViqxTDZZrjsDTq3YJu1tDQvfBiryHIy
	 p4lhfNuqgQtHzlNpsbtP/azRtkOhBLCkYsUMT5e55sWpNanAXlk3uS3HO2KzQIX7xh
	 qE5wrxCRmJHRdYGFcvv21409rcvpizvUKIXibqikLMOUEqQ5BRAmZHD5SSt+vz2Ooa
	 OyIY2Cn0MIz0XQuVWJMNXUIWFu7038q5WnHIXnrgFNfT5oalP8lBGTJ11fRjl+ak3D
	 iIPieV2sGQIhOfrYpC9Afm/0QO3zSRWCeyLIAUeGUVB8IsNgahy2ztjHExRmCvdoKs
	 n95fmtmS2i6OQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a3225d59fso16699761fa.0
        for <dmaengine@vger.kernel.org>; Thu, 05 Mar 2026 05:54:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqtU2DBO9AxqtxWaYT3jBHOKwL/ce3QH95Ub92ZyYkQQ4v+ko/MmCYu/rPtmnc3iypwrEaMInsP1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDXj5tVDAg87dmF80Lq2UTDaSvGmsmPhteLOjb+Gr4jj4YWlnz
	EoZmLymNbnjkFbQfWf88HNyHwRBxd0jmKKzddniGqO+8BP2RPOxlYnPma9dP0JaVcWYnQ9a0/uY
	k1CMCLLDYWIPbNQa5P3doQldqGLoryfHwoy00WMoo6g==
X-Received: by 2002:a05:651c:3244:b0:38a:23cf:873 with SMTP id
 38308e7fff4ca-38a2c7a62c1mr39072801fa.29.1772718854668; Thu, 05 Mar 2026
 05:54:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
 <scr5qvxa7f7k22pms4c6k5gwiky7lhssrw6qryfngexlek44g2@rayinnnwqgbt>
 <aalwMwN3qMlzrql5@linaro.org> <CAMRc=MfjknN1AYF_NPLzR0YbdWuoET25D9o0zsvx56VN+u59HQ@mail.gmail.com>
 <aamIf8JethKzLW93@linaro.org>
In-Reply-To: <aamIf8JethKzLW93@linaro.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 5 Mar 2026 14:54:02 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mf=NjCqf0eqmM800Q3MEUC48V_DZ3ts6+4=qMCtrbvzzQ@mail.gmail.com>
X-Gm-Features: AaiRm51IYcUCfeLohT9D6zKyfOjMI-00Tvkk-qYeZ800US0I_YGYl-ZxLXXpeCw
Message-ID: <CAMRc=Mf=NjCqf0eqmM800Q3MEUC48V_DZ3ts6+4=qMCtrbvzzQ@mail.gmail.com>
Subject: Re: [PATCH RFC v11 00/12] crypto/dmaengine: qce: introduce BAM
 locking and use DMA for register I/O
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 62799212D37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9276-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 2:43=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Thu, Mar 05, 2026 at 02:10:55PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Mar 5, 2026 at 1:00=E2=80=AFPM Stephan Gerhold
> > <stephan.gerhold@linaro.org> wrote:
> > >
> > > On Tue, Mar 03, 2026 at 06:13:56PM +0530, Manivannan Sadhasivam wrote=
:
> > > > On Mon, Mar 02, 2026 at 04:57:13PM +0100, Bartosz Golaszewski wrote=
:
> > > > > NOTE: Please note that even though this is version 11, I changed =
the
> > > > > prefix to RFC as this is an entirely new approach resulting from
> > > > > discussions under v9. I AM AWARE of the existing memory leaks in =
the
> > > > > last patch of this series - I'm sending it because I want to firs=
t
> > > > > discuss the approach and get a green light from Vinod as well as =
Mani
> > > > > and Bjorn. Especially when it comes to communicating the address =
for the
> > > > > dummy rights from the client to the BAM driver.
> > > > > /NOTE
> > > > >
> > > > > Currently the QCE crypto driver accesses the crypto engine regist=
ers
> > > > > directly via CPU. Trust Zone may perform crypto operations simult=
aneously
> > > > > resulting in a race condition. To remedy that, let's introduce su=
pport
> > > > > for BAM locking/unlocking to the driver. The BAM driver will now =
wrap
> > > > > any existing issued descriptor chains with additional descriptors
> > > > > performing the locking when the client starts the transaction
> > > > > (dmaengine_issue_pending()). The client wanting to profit from lo=
cking
> > > > > needs to switch to performing register I/O over DMA and communica=
te the
> > > > > address to which to perform the dummy writes via a call to
> > > > > dmaengine_slave_config().
> > > > >
> > > >
> > > > Thanks for moving the LOCK/UNLOCK bits out of client to the BAM dri=
ver. It looks
> > > > neat now. I understand the limitation that for LOCK/UNLOCK, BAM nee=
ds to perform
> > > > a dummy write to an address in the client register space. So in thi=
s case, you
> > > > can also use the previous metadata approach to pass the scratchpad =
register to
> > > > the BAM driver from clients. The BAM driver can use this register t=
o perform
> > > > LOCK/UNLOCK.
> > > >
> > > > It may sound like I'm suggesting a part of your previous design, bu=
t it fits the
> > > > design more cleanly IMO. The BAM performs LOCK/UNLOCK on its own, b=
ut it gets
> > > > the scratchpad register address from the clients through the metada=
ta once.
> > > >
> > > > It is very unfortunate that the IP doesn't accept '0' address for L=
OCK/UNLOCK or
> > > > some of them cannot append LOCK/UNLOCK to the actual CMD descriptor=
s passed from
> > > > the clients. These would've made the code/design even more cleaner.
> > > >
> > >
> > > I was staring at the downstream drivers for QCE (qce50.c?) [1] for a =
bit
> > > and my impression is that they manage to get along without dummy writ=
es.
> > > It's a big mess, but it looks like they always have some commands
> > > (depending on the crypto operation) that they are sending anyway and
> > > they just assign the LOCK/UNLOCK flag to the command descriptor of th=
at.
> > >
> > > It is similar for the second relevant user of the LOCK/UNLOCK flags, =
the
> > > QPIC NAND driver (msm_qpic_nand.c in downstream [2], qcom_nandc.c in
> > > mainline), it is assigned as part of the register programming sequenc=
e
> > > instead of using a dummy write. In addition, the UNLOCK flag is
> > > sometimes assigned to a READ command descriptor rather than a WRITE.
> > >
> > > @Bartosz: Can we get by without doing any dummy writes?
> > > If not, would a dummy read perhaps be less intrusive than a dummy wri=
te?
> > >
> >
> > The HPG says that the LOCK/UNLOCK flag *must* be set on a command
> > descriptor, not a data descriptor. For a simple encryption we will
> > typically have a data descriptor and a command descriptor with
> > register writes. So we need a command descriptor in front of the data
> > and - while we could technically set the UNLOCK bit on the subsequent
> > command descriptor - it's unclear from the HPG whether it will unlock
> > before or after processing the command descriptor with the UNLOCK bit
> > set. Hence the additional command descriptor at the end.
> >
>
> I won't pretend that I actually understand what the downstream QCE
> driver is doing, but e.g. qce_ablk_cipher_req() in the qce50.c I linked
> looks like they just put the command descriptor with all the register
> writes first and then the data second (followed by another command
> descriptor for cleanup/unlocking). Is it actually required to put the
> data first?
>

Well, now you're getting into the philosophical issue of imposing
requirements on the client which seemed to be the main point of
contention in earlier versions. If you start requiring the client to
put the DMA operations in a certain order (and it's not based on any
HW requirement but rather on how the DMA driver is implemented) then
how is it better than having the client just drive the locking
altogether like pre v11? We won't get away without at least some
requirements - like the client doing register I/O over DMA or
providing the scratchpad address - but I think just wrapping the
existing queue with additional descriptors in a way transparent to
consumers is better in this case. And as I said: the HPG doesn't
explicitly say that it unlocks the pipe *after* the descriptor with
the unlock bit is processed. Doesn't even hint at what real the
ordering is.

> > The HPG also only mentions a write command and says nothing about a
> > read. In any case: that's the least of the problems as switching to
> > read doesn't solve the issue of passing the address of the scratchpad
> > register.
>
> True.
>
> >
> > So while some of this *may* just work, I would prefer to stick to what
> > documentation says *will* work. :)
> >
>
> Well, the question is if there is always a dummy register that can be
> safely written (without causing any side effects). This will be always
> just based on experiments, since the concept of a dummy write doesn't
> seem to exist downstream (and I assume the documentation doesn't suggest
> a specific register to use either).
>

You'd think so but the HPG actually does use the word "dummy" to
describe the write operation with lock/unlock bits set. Though it does
not recommend any particular register to do it.

> NAND_VERSION (0xf08) might work for qcom_nandc.c (which might be the
> only other relevant user of the BAM locking functionality...).
>

Yeah, I do the same for QCE, write to the version register.

Bart

