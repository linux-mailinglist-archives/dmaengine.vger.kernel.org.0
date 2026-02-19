Return-Path: <dmaengine+bounces-8976-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VBezEo0Pl2kiuQIAu9opvQ
	(envelope-from <dmaengine+bounces-8976-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 14:26:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBD615F0A3
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 14:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E2B23006089
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222F833A039;
	Thu, 19 Feb 2026 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+CGzuZm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FFF30BF72;
	Thu, 19 Feb 2026 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771507590; cv=none; b=IYCEdHHcs9laLTzMZY8dRnk/vnUvKIVcIGw1oX4UevKGE4q+E9KGqplARYyQhGPqI0LbTqijhbt3zrFXEiCHnDGRLNqR0mxraEpzYhWecFn0lS0bMNXcEi/mrsTlgU8PrkQJUMXv4HmuiJlsC5q6nrL/20es5ko/5ZoV9AyGqdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771507590; c=relaxed/simple;
	bh=0E6w62v3rpN+tm5LDZUfdbYvALDslKvhZRYY6apfWIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiRoqlGHbPAogdjrtomf25qT9qM9d4NWKQf66nUNXELoggNUUc4GRnpdXkLsY99Ud5GeR8h8lRp3+K7Xf0xM9Gr6qSEgxDRM6GMGS66cS0U9setuBoClxOlkyyw/9EGcpBiM4i79DoqlKk/6BQyD+AzwRhZt+WmhbBCd4YCg3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+CGzuZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFDFC4CEF7;
	Thu, 19 Feb 2026 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771507589;
	bh=0E6w62v3rpN+tm5LDZUfdbYvALDslKvhZRYY6apfWIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+CGzuZmT1I+fwuzQ12nCaQ/awcw1JNhSP53gqx2x+tYgYbgz5R9c0DiM6bWwgycl
	 UxqJsI4/Uq2iN2pMmLQbcLQBrtUkwWElqzcvKq6RLbRZGB5+VlYOjIR76hgpd8L+dn
	 5dN7oDANZKbiSrXxkX4KEZXRcPCmgIpT1Bae4ZOBBx5KuLKsu+eH8Q2MwTrJUoQLZb
	 H5gD1ikb49N3+aJWh2f3bQGca7TtJJwA8/tBAD3krZoI5lfxjV09lhpS05pTSCGIbW
	 oGePebtPbpNwl9XV5M4ZsmwrRxmbxPq+1I8AoYOhm5eXkeEncLSCwTK7MMJ1bjREsp
	 6aF9gH8Hr+35w==
Date: Thu, 19 Feb 2026 07:26:26 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Udit Tiwari <quic_utiwari@quicinc.com>, Daniel Perez-Zoghbi <dperezzo@quicinc.com>, 
	Md Sadre Alam <mdalam@qti.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
Message-ID: <sqaimyrvtf4mzasg7e326c254cfd3jkviqei55whc2rp62lseo@wdlyf25br5cz>
References: <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
 <aUpyrIvu_kG7DtQm@vaman>
 <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman>
 <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
 <aVf5WUe9cAXZHxPJ@vaman>
 <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
 <aWBndOfbtweRr0uS@vaman>
 <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
 <ana2ugshqjicqscwpdgo6knv53n4zzuwqp376qil27spco5vwh@ck7wmplz52qs>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ana2ugshqjicqscwpdgo6knv53n4zzuwqp376qil27spco5vwh@ck7wmplz52qs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8976-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,vger.kernel.org,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEBD615F0A3
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 05:42:09PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jan 09, 2026 at 03:15:38PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Jan 9, 2026 at 3:27 AM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > >
> > > > We need an API because we send a locking descriptor, then a regular
> > > > descriptor (or descriptors) for the actual transaction(s) and then an
> > > > unlocking descriptor. It's a thing the user of the DMA engine needs to
> > > > decide on, not the DMA engine itself.
> > >
> > > I think downstream sends lock descriptor always. What is the harm in
> > > doing that every time if we go down that path?
> > 
> > No, in downstream it too depends on the user setting the right bits.
> > Currently the only user of the BAM locking downstream is the NAND
> > driver. I don't think the code where the crypto driver uses it is
> > public yet.
> > 
> > And yes, there is harm - it slightly impacts performance. For QCE it
> > doesn't really matter as any users wanting to offload skcipher or SHA
> > are better off using the Arm Crypto Extensions anyway as they are
> > faster by an order of magnitude (!). It's also the default upstream,
> > where the priorities are set such that the ARM CEs are preferred over
> > the QCE. QCE however, is able to coordinate with the TrustZone and
> > will be used to support the DRM use-cases.
> > 
> > I prefer to avoid impacting any other users of BAM DMA.
> > 
> 
> Sorry for jumping late. But I disagree with the argument that the client drivers
> have to set the LOCK/UNLOCK bit. These bits are specific to BAM DMA IP for
> serializing the command descriptors from multiple entities. So DMA clients like
> Crypto/NAND have no business in setting this flag. It is the job of the BAM
> dmaengine driver to set/unset it at the start and end of the descriptor chain.
> 

Thanks for pointing this out, Mani.

I agree, pushing this responsibility to the clients breaks the
abstraction between the components and leads to nasty debugging
scenarios.

The question worth answering is if there are any legitimate cases for
holding the lock beyond what can reasonably be expressed as a descriptor
chain.

Regards,
Bjorn

> > > Reg Dmitry question above, this is dma hw capability, how will client
> > > know if it has to lock on older rev of hardware or not...?
> > >
> > > > Also: only the crypto engine needs it for now, not all the other users
> > > > of the BAM engine.
> > >
> > 
> > Trying to set the lock/unlock bits will make
> > dmaengine_desc_attach_metadata() fail if HW does not support it.
> > 
> 
> The BAM dmaengine driver *must* know based on the IP version whether it supports
> the LOCK/UNLOCK bits or not, not the client drivers. How can the client drivers
> know about the BAM DMA IP capability?
> 
> For all these reasons, BAM driver should handle the locking mechanism internaly.
> This will allow the client drivers to work without any modifications.
> 
> FWIW, NAND driver too is impacted by this missing feature in the BAM driver as
> both Modem and Linux tries to driver BAM and currently Linux BAM driver doesn't
> set these bits leading to crashes.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 

