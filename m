Return-Path: <dmaengine+bounces-8978-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H7SLgshl2kJvAIAu9opvQ
	(envelope-from <dmaengine+bounces-8978-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 15:41:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D13E15FAB5
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 15:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 241B130166EC
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2628E2F83B7;
	Thu, 19 Feb 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6b0P7gX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018DD215F7D;
	Thu, 19 Feb 2026 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512071; cv=none; b=H2vsJGmbAosfx3rvEzcuAFfKN0I9lmzR3Di3WngxKRzJbM7SMHFubhb45ze4/+3aKwx9ynXvFuAWL08LHpEcr9Cnby4ag3X3urtpSw1x9CWDZrllr14eqUhow6JNzEtPdJTXs+gS+XXQrhoVTzhRgg5REBrU4b+OPYyPODj0QYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512071; c=relaxed/simple;
	bh=v80TupS+jBDUDdT887qCusmMrlQL1spKTa6KAoRdNvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oo2yBf/YoAgqKzYKt3ut5goX7/I5pHs7oCGDseJCxvZ/PURSlt7/ZEOfEAF6IrAh93GW+xv6rQ2X7GpfQDvxFlDjrcpFwjbuqy6+qfJ08nz8EwIFa27Smmrr3V2MPQAEKQWFnsea+1Gjpex6EE1+e87F8WPbGfbeKZxaVw5akoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6b0P7gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E465CC4CEF7;
	Thu, 19 Feb 2026 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771512070;
	bh=v80TupS+jBDUDdT887qCusmMrlQL1spKTa6KAoRdNvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6b0P7gXp1y5ReFguJQR22PjhAKpWNd4tLGzdCa0tH3OpAPQ+0qM5QED49sXouJzo
	 ZvmUQd8g0dwY9NRpiC2AgO9QxVeFIB8Pg4joETI7Aa/U//FBEn/kfZblFKKFjCRTuX
	 GLYwsr2O+HLTe0XaHiVlS0OXdnmD9D2IV8BvtsYJo/GKxID6FDjegg/D5Jlr+mHr/w
	 VlNIVcPCHR0jzRhTGgKs+qfoKHV2YMwMYEDx4kivrD0amgN7J4xymS6Y6VUoTe7IDA
	 Ak7DP19uUNGPcIVFuWFcrncuvmAGpwuVjTo1JAkS9fMsChx3eOsbTjflzfsQsDcwZ3
	 d561vUW+ebycw==
Date: Thu, 19 Feb 2026 20:10:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
Message-ID: <xuiiqsrj63rtg4onuu2vmohwu2b2sd3so5uzakdzuucmwqaufn@7xwecs4apayt>
References: <aUpyrIvu_kG7DtQm@vaman>
 <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman>
 <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
 <aVf5WUe9cAXZHxPJ@vaman>
 <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
 <aWBndOfbtweRr0uS@vaman>
 <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
 <ana2ugshqjicqscwpdgo6knv53n4zzuwqp376qil27spco5vwh@ck7wmplz52qs>
 <CAMRc=MevcsQ+sWsERQzod-a9A+F8feoLnbBXSkZrUk4zBPYCSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MevcsQ+sWsERQzod-a9A+F8feoLnbBXSkZrUk4zBPYCSQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-8978-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,vger.kernel.org,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D13E15FAB5
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 07:30:04AM -0600, Bartosz Golaszewski wrote:
> On Thu, 19 Feb 2026 13:12:09 +0100, Manivannan Sadhasivam
> <mani@kernel.org> said:
> > On Fri, Jan 09, 2026 at 03:15:38PM +0100, Bartosz Golaszewski wrote:
> >> On Fri, Jan 9, 2026 at 3:27 AM Vinod Koul <vkoul@kernel.org> wrote:
> >> >
> >> > >
> >> > > We need an API because we send a locking descriptor, then a regular
> >> > > descriptor (or descriptors) for the actual transaction(s) and then an
> >> > > unlocking descriptor. It's a thing the user of the DMA engine needs to
> >> > > decide on, not the DMA engine itself.
> >> >
> >> > I think downstream sends lock descriptor always. What is the harm in
> >> > doing that every time if we go down that path?
> >>
> >> No, in downstream it too depends on the user setting the right bits.
> >> Currently the only user of the BAM locking downstream is the NAND
> >> driver. I don't think the code where the crypto driver uses it is
> >> public yet.
> >>
> >> And yes, there is harm - it slightly impacts performance. For QCE it
> >> doesn't really matter as any users wanting to offload skcipher or SHA
> >> are better off using the Arm Crypto Extensions anyway as they are
> >> faster by an order of magnitude (!). It's also the default upstream,
> >> where the priorities are set such that the ARM CEs are preferred over
> >> the QCE. QCE however, is able to coordinate with the TrustZone and
> >> will be used to support the DRM use-cases.
> >>
> >> I prefer to avoid impacting any other users of BAM DMA.
> >>
> >
> > Sorry for jumping late. But I disagree with the argument that the client drivers
> > have to set the LOCK/UNLOCK bit. These bits are specific to BAM DMA IP for
> > serializing the command descriptors from multiple entities. So DMA clients like
> > Crypto/NAND have no business in setting this flag. It is the job of the BAM
> > dmaengine driver to set/unset it at the start and end of the descriptor chain.
> >
> 
> But what if a given client does not need locking? We don't want to enable it
> for everyone - as I explained before.
> 

That's not going to hurt. AFAIK, enabling locking wouldn't cause any notable
performance overhead.

> >> > Reg Dmitry question above, this is dma hw capability, how will client
> >> > know if it has to lock on older rev of hardware or not...?
> >> >
> >> > > Also: only the crypto engine needs it for now, not all the other users
> >> > > of the BAM engine.
> >> >
> >>
> >> Trying to set the lock/unlock bits will make
> >> dmaengine_desc_attach_metadata() fail if HW does not support it.
> >>
> >
> > The BAM dmaengine driver *must* know based on the IP version whether it supports
> > the LOCK/UNLOCK bits or not, not the client drivers. How can the client drivers
> > know about the BAM DMA IP capability?
> >
> 
> FYI: the current version of this is v10[1].
> 
> In it (and in this one too but let's discuss the current one) the BAM driver
> *does* know *based on IP version* whether is supports locking or not. The client
> requests a lock but this will fail if the BAM does not support it. The
> client does
> not check the BAM IP revision. So yes: it's the BAM driver that's in charge.
> 

This design looks flawed. The client *doesn't* know whether it needs locking or
not. If the BAM supports locking, it should enable it for all descriptors.

> > For all these reasons, BAM driver should handle the locking mechanism internaly.
> > This will allow the client drivers to work without any modifications.
> >
> 
> Ok, I'm open to alternatives but please help me figure out the "hows": How do
> you tell the BAM driver that the client needs (or does not) locking?

As said above, BAM doesn't need to know. Locking is the hardware capability of
the BAM, not clients.

> How do
> you handle the case where we need to lock the BAM, send an arbitrary number
> of descriptors from the client and then unlock it? How can the BAM know *when*
> to lock/unlock?
> 

BAM driver has to perform lock during issue_pending() and unlock while reporting
the completion using vchan_cookie_complete().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

