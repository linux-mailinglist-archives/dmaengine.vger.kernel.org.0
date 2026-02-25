Return-Path: <dmaengine+bounces-9055-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD1zNgzHnmkuXQQAu9opvQ
	(envelope-from <dmaengine+bounces-9055-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 10:55:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36A1955DC
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 10:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AA3C30FBB32
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 09:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509438F249;
	Wed, 25 Feb 2026 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfWecix+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FD338F238;
	Wed, 25 Feb 2026 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013136; cv=none; b=IIglay5jaMRXP1LKywGCClqeAf7V2eIekbrIWnYh5JQyF4qJeYpjxfImLAmbKRzu4A+8Uh2mPizjP30ve3hVO3KJvGNtvmtj6b8MBCXtS3MXHc8aTIOY7irH6zPcAY7I+4CzyqZM8HVYOikFjuZw0Xxu1LLq5Z3MRaaGL8ZvpXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013136; c=relaxed/simple;
	bh=64AR6GQw5wetkmyW2DX8vIhUpyQSLEYiMb7oLsS8C8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8Vgx0uaG9nnZCiM9kRf52zBAf2wGNyagUzMUQSowBHPZro9sJErDnKxduABOdtH2irVe8i3bBE4kHPlv5YIJ6Dyp0QDG2uLhOPwEV+VSULQn+pYt3Qz5uVDGtF86Zm4oulFDN4l4FKjDRtfWgGb2284TBI4hg3GdTjJvEamcP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfWecix+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03215C19422;
	Wed, 25 Feb 2026 09:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772013135;
	bh=64AR6GQw5wetkmyW2DX8vIhUpyQSLEYiMb7oLsS8C8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfWecix+zaTLA6BKRqcRNH9ciC29tn+9RbWqXvuSUijFdaUnA8pAtWUj5RjjvmvNK
	 SCTGgCFHYkh6p03KgRFu9tiV89wFUrgnd/liBhO5G2vsQqXxXNS135GfVBhzM8dDiF
	 yXZiJYM8Jy7T66v6zhNamyB6kPhz0YB1xEdRmn/hdiaCJ7DYhZ3uwTixzza6xJ8xNZ
	 KqAl28FgiDnc7wTViNwrdUwp8YgCcHw10y+C+aEi3K0zILaUQ/rb665wmfRH3VLtci
	 h1Ita/68wEbwIzptjBLB63SkNfgoKz6wSLlZAP8i/dUxlZWiqlHYfVb9TpsdPT2tvs
	 x5FcwTl2PPGiw==
Date: Wed, 25 Feb 2026 15:22:11 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <aZ7GS5W1VNNB2fLi@vaman>
References: <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman>
 <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
 <aVf5WUe9cAXZHxPJ@vaman>
 <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
 <aWBndOfbtweRr0uS@vaman>
 <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
 <ana2ugshqjicqscwpdgo6knv53n4zzuwqp376qil27spco5vwh@ck7wmplz52qs>
 <CAMRc=MevcsQ+sWsERQzod-a9A+F8feoLnbBXSkZrUk4zBPYCSQ@mail.gmail.com>
 <xuiiqsrj63rtg4onuu2vmohwu2b2sd3so5uzakdzuucmwqaufn@7xwecs4apayt>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xuiiqsrj63rtg4onuu2vmohwu2b2sd3so5uzakdzuucmwqaufn@7xwecs4apayt>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9055-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,vger.kernel.org,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D36A1955DC
X-Rspamd-Action: no action

On 19-02-26, 20:10, Manivannan Sadhasivam wrote:
> On Thu, Feb 19, 2026 at 07:30:04AM -0600, Bartosz Golaszewski wrote:
> > On Thu, 19 Feb 2026 13:12:09 +0100, Manivannan Sadhasivam
> > <mani@kernel.org> said:
> > > On Fri, Jan 09, 2026 at 03:15:38PM +0100, Bartosz Golaszewski wrote:
> > >> On Fri, Jan 9, 2026 at 3:27 AM Vinod Koul <vkoul@kernel.org> wrote:
> > >> >
> > >> > >
> > >> > > We need an API because we send a locking descriptor, then a regular
> > >> > > descriptor (or descriptors) for the actual transaction(s) and then an
> > >> > > unlocking descriptor. It's a thing the user of the DMA engine needs to
> > >> > > decide on, not the DMA engine itself.
> > >> >
> > >> > I think downstream sends lock descriptor always. What is the harm in
> > >> > doing that every time if we go down that path?
> > >>
> > >> No, in downstream it too depends on the user setting the right bits.
> > >> Currently the only user of the BAM locking downstream is the NAND
> > >> driver. I don't think the code where the crypto driver uses it is
> > >> public yet.
> > >>
> > >> And yes, there is harm - it slightly impacts performance. For QCE it
> > >> doesn't really matter as any users wanting to offload skcipher or SHA
> > >> are better off using the Arm Crypto Extensions anyway as they are
> > >> faster by an order of magnitude (!). It's also the default upstream,
> > >> where the priorities are set such that the ARM CEs are preferred over
> > >> the QCE. QCE however, is able to coordinate with the TrustZone and
> > >> will be used to support the DRM use-cases.
> > >>
> > >> I prefer to avoid impacting any other users of BAM DMA.
> > >>
> > >
> > > Sorry for jumping late. But I disagree with the argument that the client drivers
> > > have to set the LOCK/UNLOCK bit. These bits are specific to BAM DMA IP for
> > > serializing the command descriptors from multiple entities. So DMA clients like
> > > Crypto/NAND have no business in setting this flag. It is the job of the BAM
> > > dmaengine driver to set/unset it at the start and end of the descriptor chain.
> > >
> > 
> > But what if a given client does not need locking? We don't want to enable it
> > for everyone - as I explained before.
> > 
> 
> That's not going to hurt. AFAIK, enabling locking wouldn't cause any notable
> performance overhead.

I was always skeptical on this one. I had never seen why locking should
be pushed to clients. As Bjorn said it leads to more mess than worth it.
Thanks Mnai

> 
> > >> > Reg Dmitry question above, this is dma hw capability, how will client
> > >> > know if it has to lock on older rev of hardware or not...?
> > >> >
> > >> > > Also: only the crypto engine needs it for now, not all the other users
> > >> > > of the BAM engine.
> > >> >
> > >>
> > >> Trying to set the lock/unlock bits will make
> > >> dmaengine_desc_attach_metadata() fail if HW does not support it.
> > >>
> > >
> > > The BAM dmaengine driver *must* know based on the IP version whether it supports
> > > the LOCK/UNLOCK bits or not, not the client drivers. How can the client drivers
> > > know about the BAM DMA IP capability?

Lock bits are on the BAM DMA IP or client? Can we not add this
capability to BAM driver and lock for IPs that support

> > >
> > 
> > FYI: the current version of this is v10[1].
> > 
> > In it (and in this one too but let's discuss the current one) the BAM driver
> > *does* know *based on IP version* whether is supports locking or not. The client
> > requests a lock but this will fail if the BAM does not support it. The
> > client does
> > not check the BAM IP revision. So yes: it's the BAM driver that's in charge.
> > 
> 
> This design looks flawed. The client *doesn't* know whether it needs locking or
> not. If the BAM supports locking, it should enable it for all descriptors.

Ack

> 
> > > For all these reasons, BAM driver should handle the locking mechanism internaly.
> > > This will allow the client drivers to work without any modifications.
> > >
> > 
> > Ok, I'm open to alternatives but please help me figure out the "hows": How do
> > you tell the BAM driver that the client needs (or does not) locking?
> 
> As said above, BAM doesn't need to know. Locking is the hardware capability of
> the BAM, not clients.
> 
> > How do
> > you handle the case where we need to lock the BAM, send an arbitrary number
> > of descriptors from the client and then unlock it? How can the BAM know *when*
> > to lock/unlock?
> > 
> 
> BAM driver has to perform lock during issue_pending() and unlock while reporting
> the completion using vchan_cookie_complete().

Sounds good to me, thanks Mani

-- 
~Vinod

