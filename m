Return-Path: <dmaengine+bounces-8972-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E45Dyz+lmmItQIAu9opvQ
	(envelope-from <dmaengine+bounces-8972-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 13:12:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DB315E80E
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 13:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A1BA30071E4
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4833123A;
	Thu, 19 Feb 2026 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAv5HEVG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84B1ADFE4;
	Thu, 19 Feb 2026 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771503144; cv=none; b=Z6tqTJmVv5JPa+Q1Nkyd6YVN5xPw1XwPlvifR/ei1EvcuZ/iP1f77NGM5aK+G/3HVw1GV6zaKMj4Wh6QELt0Z0dU49/wkME7ibk/Ma7i/ZC6t6XFSkqXHbHrJhaFVjzhIikULrYS4QeqhMM0gDiOJNhsd+kBVO97y0qUFNeoDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771503144; c=relaxed/simple;
	bh=Ew3+CpYYK3VkUEVDZxS2seIPiaTX6//ss8KqsuuUkoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNisn5I2/VuV0tP0PHWQT2SI1l/I/C6CvTWVsYu3Bibe+eNj4mrxchyYM/oq+rFMtk3Tiyz7y3sIJA8FTCQvTPpNsgbAmPHofxKSOTu76rPuN6N3UP9rAFoe41Ly6L5QEh+L9PHlZlBH6d3K8RXpGS3iArq12LLqprLg/XSpuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAv5HEVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9829EC4CEF7;
	Thu, 19 Feb 2026 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771503144;
	bh=Ew3+CpYYK3VkUEVDZxS2seIPiaTX6//ss8KqsuuUkoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAv5HEVG2XC6k59dicNXOtbj7O2Yl5Aj/276IKDJ+zHzRXljjxCve/v9j+5u+qG/A
	 ztyiiMjqjCs8p3NqIxNycf2Zv3WuQnzXCLf1WOF0QKeHl+cI0tqC8ecwCY878MYt8X
	 92KywaRjeoMc7QH37OVh/Ob/pJ8Y0qtppKfgKTtithWRZZ1QER2iLXW87lqZrxPXrB
	 j0N6Ho8N2O38dSUTJ3nYwOXjw+FeOzfT1jrzc+XJ35pjuC2H1u3Voz9JvgPnu5x3aW
	 sOEQAc2sosEzap+RGEN3c2ZkV3MrlVi/dKtHXq5o2ISXvcopdo2ucf640o15o0k6U0
	 sGxbkXrB0SlZw==
Date: Thu, 19 Feb 2026 17:42:09 +0530
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
Message-ID: <ana2ugshqjicqscwpdgo6knv53n4zzuwqp376qil27spco5vwh@ck7wmplz52qs>
References: <aUF2gj_0svpygHmD@vaman>
 <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
 <aUpyrIvu_kG7DtQm@vaman>
 <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman>
 <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
 <aVf5WUe9cAXZHxPJ@vaman>
 <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
 <aWBndOfbtweRr0uS@vaman>
 <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8972-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,vger.kernel.org,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5DB315E80E
X-Rspamd-Action: no action

On Fri, Jan 09, 2026 at 03:15:38PM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 9, 2026 at 3:27 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > >
> > > We need an API because we send a locking descriptor, then a regular
> > > descriptor (or descriptors) for the actual transaction(s) and then an
> > > unlocking descriptor. It's a thing the user of the DMA engine needs to
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

Sorry for jumping late. But I disagree with the argument that the client drivers
have to set the LOCK/UNLOCK bit. These bits are specific to BAM DMA IP for
serializing the command descriptors from multiple entities. So DMA clients like
Crypto/NAND have no business in setting this flag. It is the job of the BAM
dmaengine driver to set/unset it at the start and end of the descriptor chain.

> > Reg Dmitry question above, this is dma hw capability, how will client
> > know if it has to lock on older rev of hardware or not...?
> >
> > > Also: only the crypto engine needs it for now, not all the other users
> > > of the BAM engine.
> >
> 
> Trying to set the lock/unlock bits will make
> dmaengine_desc_attach_metadata() fail if HW does not support it.
> 

The BAM dmaengine driver *must* know based on the IP version whether it supports
the LOCK/UNLOCK bits or not, not the client drivers. How can the client drivers
know about the BAM DMA IP capability?

For all these reasons, BAM driver should handle the locking mechanism internaly.
This will allow the client drivers to work without any modifications.

FWIW, NAND driver too is impacted by this missing feature in the BAM driver as
both Modem and Linux tries to driver BAM and currently Linux BAM driver doesn't
set these bits leading to crashes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

