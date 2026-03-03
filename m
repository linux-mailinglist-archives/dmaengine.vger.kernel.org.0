Return-Path: <dmaengine+bounces-9217-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB5eDQDZpmnHWgAAu9opvQ
	(envelope-from <dmaengine+bounces-9217-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 13:50:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C8D1EFB4E
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 13:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56FC53136425
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D817F34D4E3;
	Tue,  3 Mar 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqJa55LG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445A1B983F;
	Tue,  3 Mar 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541852; cv=none; b=S9Rb74QP0zVoa207xkEPBl2VFfVRNCYd6+NPxTMiul76qO202ELd6ePpnXGg/n8bfhWjO2vob2nvK7VkNLeVMTAjtSY+A9gqe+Xu4kPahDHHsRQLgnENn4vlbSD9aM3SbgCnF95b6Q1Bbv+NwrUsL76VKkLpFytwBxWjw+jJ/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541852; c=relaxed/simple;
	bh=iuHQZypN1F8oLq3wK8SXVV26gJ3eiQfBBD/nb3c0/Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E26fZY1ZQlM8/2ZRxLbx3x5MuZl2nvFRRMnbw5+Vw5oyaRgWEQyKRs3U+aqG3NxLoI1mPQBQwADwh4bUBd33lkx2rc8PfpG2St8f3u7slh1ziWQ3oJLC3R2rMkRvUceQF7Dl8CAGbRkI09CXwY1VO5W1CbwBaReqhAGFrlyW8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqJa55LG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C386C116C6;
	Tue,  3 Mar 2026 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772541852;
	bh=iuHQZypN1F8oLq3wK8SXVV26gJ3eiQfBBD/nb3c0/Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqJa55LG1GFSjzlxVfvDZ4AMc1PqFrnVBbQiMR8Oxv/bSAQSNdsEw1rpByjm7gCE9
	 EbaKQlgWhPqIqpu7gLP/wC5/FS9yTLxuYMJqPPtQjS+o+aZhOwQ7N3fmRXMhX9FVAY
	 /vY2m4307N67zkxQy9NBseMSMa8YtmLvpRSk+zEeFc4uHPThToNohb0dS+qhnBD1uM
	 NVr9K4jEV15ZNfOKm8+emBOouNZ6y/naCeDM3bF+7Hwj3qoXfQsauC9J91ck7zTrwr
	 BrZFS+f1yCpxNwEGJO/479AjfHBjLzGHjERVl6zsEvbBIwHbQ3l9QZ9AcJc3QgkLLc
	 D1A9JImGuZ2ug==
Date: Tue, 3 Mar 2026 18:13:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, brgl@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH RFC v11 00/12] crypto/dmaengine: qce: introduce BAM
 locking and use DMA for register I/O
Message-ID: <scr5qvxa7f7k22pms4c6k5gwiky7lhssrw6qryfngexlek44g2@rayinnnwqgbt>
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
X-Rspamd-Queue-Id: D1C8D1EFB4E
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
	TAGGED_FROM(0.00)[bounces-9217-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,vger.kernel.org,lists.infradead.org,linaro.org,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 04:57:13PM +0100, Bartosz Golaszewski wrote:
> NOTE: Please note that even though this is version 11, I changed the
> prefix to RFC as this is an entirely new approach resulting from
> discussions under v9. I AM AWARE of the existing memory leaks in the
> last patch of this series - I'm sending it because I want to first
> discuss the approach and get a green light from Vinod as well as Mani
> and Bjorn. Especially when it comes to communicating the address for the
> dummy rights from the client to the BAM driver.
> /NOTE
> 
> Currently the QCE crypto driver accesses the crypto engine registers
> directly via CPU. Trust Zone may perform crypto operations simultaneously
> resulting in a race condition. To remedy that, let's introduce support
> for BAM locking/unlocking to the driver. The BAM driver will now wrap
> any existing issued descriptor chains with additional descriptors
> performing the locking when the client starts the transaction
> (dmaengine_issue_pending()). The client wanting to profit from locking
> needs to switch to performing register I/O over DMA and communicate the
> address to which to perform the dummy writes via a call to
> dmaengine_slave_config().
> 

Thanks for moving the LOCK/UNLOCK bits out of client to the BAM driver. It looks
neat now. I understand the limitation that for LOCK/UNLOCK, BAM needs to perform
a dummy write to an address in the client register space. So in this case, you
can also use the previous metadata approach to pass the scratchpad register to
the BAM driver from clients. The BAM driver can use this register to perform
LOCK/UNLOCK.

It may sound like I'm suggesting a part of your previous design, but it fits the
design more cleanly IMO. The BAM performs LOCK/UNLOCK on its own, but it gets
the scratchpad register address from the clients through the metadata once.

It is very unfortunate that the IP doesn't accept '0' address for LOCK/UNLOCK or
some of them cannot append LOCK/UNLOCK to the actual CMD descriptors passed from
the clients. These would've made the code/design even more cleaner.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

