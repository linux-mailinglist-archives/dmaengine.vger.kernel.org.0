Return-Path: <dmaengine+bounces-9274-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HRJCdCBqWkd9gAAu9opvQ
	(envelope-from <dmaengine+bounces-9274-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 14:14:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C40D6212807
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 14:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BE7A302D5F9
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11F33A0B24;
	Thu,  5 Mar 2026 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9tX/hM7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A239B4AA
	for <dmaengine@vger.kernel.org>; Thu,  5 Mar 2026 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716268; cv=none; b=czfiKSTi4tpdVrvFfeQIrF4zGIkkZSVSuQi910d+vZr9a+2wX8ptk8zYbQblikXRiUAgnr1+M5GC1ziryyvvmvIg17FlxaR3uKUg09uQavU/67MtacUbRoFQjaK7/49CKvcJhAJY0g5AbVUGVS4dVwwvQwd+AcA7ke6x655hNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716268; c=relaxed/simple;
	bh=ISJ9IeJb4bdYq8e9zGFzYpxXmxiQlQWQQQm3BHAO9ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2q1HTncHpbCg21HCg4c8Wit/6wzLSC1eRAjIuozEYON9kkxySQyw/IZL2RwOT4pysvuR22UvaVRoG6Nj9TnD+4JVaVwsUWTYfldRWY2pkhvd5R1N5+GW85rjR8kKC6oKW/U2nav4CnrmhTWWj6ba18cU0eWO/3+j3j+rFPZq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9tX/hM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293EDC19423
	for <dmaengine@vger.kernel.org>; Thu,  5 Mar 2026 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772716268;
	bh=ISJ9IeJb4bdYq8e9zGFzYpxXmxiQlQWQQQm3BHAO9ac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G9tX/hM7Mw5zGuhmFHkyyRDc++MrZfNxmP/ZNpmTsla4iANpe9h6kxmyvipqjVzAz
	 Je4rF+N2HacpqEUtA56nQtcW1Htkr75+BA+vYEBrXZ0N0EhwNnymUo/bk0Yb2nmnJI
	 6At5t1N+ZbugQP602yqM+0ekCuw5r/LjlLyjizp7gjfUKgG9DbIFhqJ5snjfsbc7qL
	 tRdXzb1bCUDZ+74i3CHKIzvC2Qvcl0Pbqfwm7DRHg9NWxMR797L8CIY5ZgcM1SXhW3
	 gdQRt7gvL13nfQWGsJz8VdZ6LjcxwV1aDfNTS9fN+gdaJEhCSsx11FW798ngQVwGtG
	 1h6WZhARdxABQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-389f9895c81so73920661fa.2
        for <dmaengine@vger.kernel.org>; Thu, 05 Mar 2026 05:11:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAJVQgFiQ/sgqqdZLNCUz4cg9kd8NYBct1u9MiAFY6czbMbIQ5kYJ34YN3+tudGIkgER6ogX86CUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxkfNLV93K8+taHEVw1pAu8H/ffCbJgF29IFAS/Gba/kYtwjZY
	ha+KlTd6ID4pMSVJK6cudkdhFQAtm3bI+29KJXKXUZC5bo4JKF9rwwWVgR8vqAy4xOEbC+z8/t1
	FHByG+1WQf4+chbWCNAlx5eS0FjiqN/AzQ7+OpgGmkQ==
X-Received: by 2002:a2e:22c4:0:b0:383:7f85:8eef with SMTP id
 38308e7fff4ca-38a2c7c74e6mr37197791fa.29.1772716266754; Thu, 05 Mar 2026
 05:11:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
 <scr5qvxa7f7k22pms4c6k5gwiky7lhssrw6qryfngexlek44g2@rayinnnwqgbt> <aalwMwN3qMlzrql5@linaro.org>
In-Reply-To: <aalwMwN3qMlzrql5@linaro.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 5 Mar 2026 14:10:55 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfjknN1AYF_NPLzR0YbdWuoET25D9o0zsvx56VN+u59HQ@mail.gmail.com>
X-Gm-Features: AaiRm53riIL1Ev5aiOi4LeHVM1opButAi-QDELWr9rH7US3VnOIMoqa9uDUU7UY
Message-ID: <CAMRc=MfjknN1AYF_NPLzR0YbdWuoET25D9o0zsvx56VN+u59HQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: C40D6212807
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9274-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 1:00=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Tue, Mar 03, 2026 at 06:13:56PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Mar 02, 2026 at 04:57:13PM +0100, Bartosz Golaszewski wrote:
> > > NOTE: Please note that even though this is version 11, I changed the
> > > prefix to RFC as this is an entirely new approach resulting from
> > > discussions under v9. I AM AWARE of the existing memory leaks in the
> > > last patch of this series - I'm sending it because I want to first
> > > discuss the approach and get a green light from Vinod as well as Mani
> > > and Bjorn. Especially when it comes to communicating the address for =
the
> > > dummy rights from the client to the BAM driver.
> > > /NOTE
> > >
> > > Currently the QCE crypto driver accesses the crypto engine registers
> > > directly via CPU. Trust Zone may perform crypto operations simultaneo=
usly
> > > resulting in a race condition. To remedy that, let's introduce suppor=
t
> > > for BAM locking/unlocking to the driver. The BAM driver will now wrap
> > > any existing issued descriptor chains with additional descriptors
> > > performing the locking when the client starts the transaction
> > > (dmaengine_issue_pending()). The client wanting to profit from lockin=
g
> > > needs to switch to performing register I/O over DMA and communicate t=
he
> > > address to which to perform the dummy writes via a call to
> > > dmaengine_slave_config().
> > >
> >
> > Thanks for moving the LOCK/UNLOCK bits out of client to the BAM driver.=
 It looks
> > neat now. I understand the limitation that for LOCK/UNLOCK, BAM needs t=
o perform
> > a dummy write to an address in the client register space. So in this ca=
se, you
> > can also use the previous metadata approach to pass the scratchpad regi=
ster to
> > the BAM driver from clients. The BAM driver can use this register to pe=
rform
> > LOCK/UNLOCK.
> >
> > It may sound like I'm suggesting a part of your previous design, but it=
 fits the
> > design more cleanly IMO. The BAM performs LOCK/UNLOCK on its own, but i=
t gets
> > the scratchpad register address from the clients through the metadata o=
nce.
> >
> > It is very unfortunate that the IP doesn't accept '0' address for LOCK/=
UNLOCK or
> > some of them cannot append LOCK/UNLOCK to the actual CMD descriptors pa=
ssed from
> > the clients. These would've made the code/design even more cleaner.
> >
>
> I was staring at the downstream drivers for QCE (qce50.c?) [1] for a bit
> and my impression is that they manage to get along without dummy writes.
> It's a big mess, but it looks like they always have some commands
> (depending on the crypto operation) that they are sending anyway and
> they just assign the LOCK/UNLOCK flag to the command descriptor of that.
>
> It is similar for the second relevant user of the LOCK/UNLOCK flags, the
> QPIC NAND driver (msm_qpic_nand.c in downstream [2], qcom_nandc.c in
> mainline), it is assigned as part of the register programming sequence
> instead of using a dummy write. In addition, the UNLOCK flag is
> sometimes assigned to a READ command descriptor rather than a WRITE.
>
> @Bartosz: Can we get by without doing any dummy writes?
> If not, would a dummy read perhaps be less intrusive than a dummy write?
>

The HPG says that the LOCK/UNLOCK flag *must* be set on a command
descriptor, not a data descriptor. For a simple encryption we will
typically have a data descriptor and a command descriptor with
register writes. So we need a command descriptor in front of the data
and - while we could technically set the UNLOCK bit on the subsequent
command descriptor - it's unclear from the HPG whether it will unlock
before or after processing the command descriptor with the UNLOCK bit
set. Hence the additional command descriptor at the end.

The HPG also only mentions a write command and says nothing about a
read. In any case: that's the least of the problems as switching to
read doesn't solve the issue of passing the address of the scratchpad
register.

So while some of this *may* just work, I would prefer to stick to what
documentation says *will* work. :)

Bartosz

