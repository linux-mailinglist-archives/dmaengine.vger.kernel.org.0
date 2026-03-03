Return-Path: <dmaengine+bounces-9218-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNXbIKfapmnHWgAAu9opvQ
	(envelope-from <dmaengine+bounces-9218-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 13:57:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9371EFC77
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 13:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E783027DBB
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF135F185;
	Tue,  3 Mar 2026 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh/xtQ2P"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DB35F16C
	for <dmaengine@vger.kernel.org>; Tue,  3 Mar 2026 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542627; cv=none; b=FGoiHNjTyLpq9/bKpratDR3C5teZ76eT0PjKur0uqb571TxCfBKMsW57CSHdEbJmi3klQhwXsnCJWct995zS5ce9ZUiCP6OqKvOgv0i8WOpFGlN27iXrB6My0zQse4rY2rnKSq7NKyeGkumgoXCHmBmDRopqeEq/E29cSSr2YmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542627; c=relaxed/simple;
	bh=2y5Udud1w9el92nDGw3MAoHFspsRDspk+6XQIuYd3+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nuvp/CTyGXTM2jTanAhLDQraPmzdARuooaB8C7aLOK1iptewlmcHR/IG/k49ddBr/bUvLG57WFLYCdmkqw6PeCq747uhd4Lk5/iL8cCYIx5kIv74wF1t15qrglO8SIri7oEYcKn7oEdmT4zPkZeHuvca9fuJS5ug52X8rAXHoLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh/xtQ2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8AEC2BCC6
	for <dmaengine@vger.kernel.org>; Tue,  3 Mar 2026 12:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772542627;
	bh=2y5Udud1w9el92nDGw3MAoHFspsRDspk+6XQIuYd3+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rh/xtQ2PfEdy9h+mFHmJQtMu9in4NIZz77vdXqFOxi2qJBdz4H/HKFOKLN4w+Bv3X
	 8mKx18Yob5aY1B3ewea3IYfRB+7cnC8rF99DsHn/8jkHZ9CUGY0in/KLfY79ubuMHZ
	 u6VKtGeCOKdSaPv0+BciddobJ1+cRxIng4YPDr2lBP7DLTQGITYLh45qQx1926uUYx
	 A4uCp/BQFfNepLtvcSv1TeIhfEG18Tqe3iV+z719ruEjW4ggTEkiiMG6txqxzAc4h4
	 lQ4joinhMpnlbuYyrZVY1P5SVn/n3xSkqSRZGoLiIX/D1bgXHx65GuF3qQF/FrdnNS
	 Uv68zIfofJ1BQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-386b553c70eso89810241fa.0
        for <dmaengine@vger.kernel.org>; Tue, 03 Mar 2026 04:57:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoq9vRD7cySpq5S5vIHjrMrG2MpKajq7p3vaGJkaApurvaRUJrE24e+j+HqPn+R8DBla5QyG7X9+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+g6UwZ4mSBaGFaTdmcUo/jxlY0P97/3yPxCwtUAQGVvGyHOVT
	Ih1NEV/EsK5tvqq9MStRM0XVpxLFUM7+AFDE3Zy438aCgtcakeeRmRSXg0vemWyldZS4QI3B5kr
	3iSJlPRONEk8UQYuv+mQWI+B3fLS+PVNXkyb69a7Ifg==
X-Received: by 2002:a2e:be9b:0:b0:389:fcc6:4923 with SMTP id
 38308e7fff4ca-389ff36c676mr123347411fa.36.1772542625858; Tue, 03 Mar 2026
 04:57:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com> <scr5qvxa7f7k22pms4c6k5gwiky7lhssrw6qryfngexlek44g2@rayinnnwqgbt>
In-Reply-To: <scr5qvxa7f7k22pms4c6k5gwiky7lhssrw6qryfngexlek44g2@rayinnnwqgbt>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 3 Mar 2026 13:56:53 +0100
X-Gmail-Original-Message-ID: <CAMRc=McCXg+YjSL2_tBW2G-oBwQn3UyLGu1HxZtrognoag_CHQ@mail.gmail.com>
X-Gm-Features: AaiRm52NOJdgTLTN2sMabKBu44N91ubF3l3v3ULSOW8VIGjX28hNaR8okhr4RNg
Message-ID: <CAMRc=McCXg+YjSL2_tBW2G-oBwQn3UyLGu1HxZtrognoag_CHQ@mail.gmail.com>
Subject: Re: [PATCH RFC v11 00/12] crypto/dmaengine: qce: introduce BAM
 locking and use DMA for register I/O
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EF9371EFC77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,kernel.org,amd.com,vger.kernel.org,lists.infradead.org,linaro.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9218-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 1:44=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Mon, Mar 02, 2026 at 04:57:13PM +0100, Bartosz Golaszewski wrote:
> > NOTE: Please note that even though this is version 11, I changed the
> > prefix to RFC as this is an entirely new approach resulting from
> > discussions under v9. I AM AWARE of the existing memory leaks in the
> > last patch of this series - I'm sending it because I want to first
> > discuss the approach and get a green light from Vinod as well as Mani
> > and Bjorn. Especially when it comes to communicating the address for th=
e
> > dummy rights from the client to the BAM driver.
> > /NOTE
> >
> > Currently the QCE crypto driver accesses the crypto engine registers
> > directly via CPU. Trust Zone may perform crypto operations simultaneous=
ly
> > resulting in a race condition. To remedy that, let's introduce support
> > for BAM locking/unlocking to the driver. The BAM driver will now wrap
> > any existing issued descriptor chains with additional descriptors
> > performing the locking when the client starts the transaction
> > (dmaengine_issue_pending()). The client wanting to profit from locking
> > needs to switch to performing register I/O over DMA and communicate the
> > address to which to perform the dummy writes via a call to
> > dmaengine_slave_config().
> >
>
> Thanks for moving the LOCK/UNLOCK bits out of client to the BAM driver. I=
t looks
> neat now. I understand the limitation that for LOCK/UNLOCK, BAM needs to =
perform
> a dummy write to an address in the client register space. So in this case=
, you
> can also use the previous metadata approach to pass the scratchpad regist=
er to
> the BAM driver from clients. The BAM driver can use this register to perf=
orm
> LOCK/UNLOCK.
>

I thought about reusing descriptor metadata but this is attached to
every descriptor created with dmaengine_prep_slave_sg() (as opposed to
doing it once with dmaengine_slave_config()). We would also still need
a custom struct in the existing BAM DMA header.

I'm fine with that. Vinod: could you please say if that's sound for
you and if so - I'll rework it and also fix the memory leaks by
reworking the cleanup path.

> It may sound like I'm suggesting a part of your previous design, but it f=
its the
> design more cleanly IMO. The BAM performs LOCK/UNLOCK on its own, but it =
gets
> the scratchpad register address from the clients through the metadata onc=
e.
>

If that gets it upstream, then it's fine with me.

> It is very unfortunate that the IP doesn't accept '0' address for LOCK/UN=
LOCK or
> some of them cannot append LOCK/UNLOCK to the actual CMD descriptors pass=
ed from
> the clients. These would've made the code/design even more cleaner.
>

For sure but I double-checked this. :(

Bart

