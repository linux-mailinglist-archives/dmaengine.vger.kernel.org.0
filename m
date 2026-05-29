Return-Path: <dmaengine+bounces-11033-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGRONT3DGWqyywgAu9opvQ
	(envelope-from <dmaengine+bounces-11033-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 18:47:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 504BE605EB5
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 18:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCEEA314D321
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 16:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4171E3E1D19;
	Fri, 29 May 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5Ct7LDg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C73DA7F5;
	Fri, 29 May 2026 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071855; cv=none; b=MEq85pqk3fFu9G7zQ5T82BiaCydWcWj8BXIBts5rn9h12JGnfgVfkpZ3UspsRWC3wkzCDvWjxfmbbVBcx/MsILcUOwQCDhSpYgtKsuGANVc6BEJMbqGJhjNJzAM7bkjRMhkZeR8LfwbVyqbvuDp6iQ6OZ5Mvpsxg0jYcEgGWuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071855; c=relaxed/simple;
	bh=D01qAPQ4SbktM0P9uDPR0w5fWEctLWmEB+QgEpp/7GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2Sin93VsI0MZ1MBxWipjA1vbBcdayBfFMIOpOgNcT9QqC9arapr+BPwzRqknRLEVC8iqEIK6zeoJ/U6J+JzyISHqV1YK7l2eVDW4CG8JhXFBnvM5Jaseg+3nXt8vQkD7ugyWW4dqllP0HTZK9il+jIesJXA9J5bHM2vKuIAaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5Ct7LDg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA2B1F00893;
	Fri, 29 May 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780071853;
	bh=QvUGZhhWdI+4JN0vML4xtpmVBnKMBa3Y2aF9he498+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U5Ct7LDg3r/25r1GdbbJlkmPHtzKRndw/gD9Jkl5aY99pDkbzK4nU5LVrs0Ir8g3F
	 ZN6+dLjKvM3YSAzLBvooLfwRaAW8bX+wtV0uEmuLgXPf5LaRt/o6Wrk2lebv0tOoox
	 w2lNrSfxRkO0P7rIe1z3iZpfi2uFYQhHQZ38nppKvN59sMap+rtAqa0/VYsOqeYOxs
	 0q/ObsxbpdTYUCUSavkXxGOEUWcg5ZKLVah5dUAm9Lu9SMY3dthOlMGxAyM/V10Yhh
	 9qC+zEbHObxVZQR1WjvejjcGlnHvcRRZzErMC1kGDeXtriV/ONyme2JqHncB4n31y1
	 1n6SisMLbKIFA==
Date: Fri, 29 May 2026 09:22:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	brgl@kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v19 00/14] crypto/dmaengine: qce: introduce BAM locking
 and use DMA for register I/O
Message-ID: <20260529162251.GB2706@sol>
References: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11033-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org,vger.kernel.org,lists.infradead.org,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 504BE605EB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 03:10:48PM +0200, Bartosz Golaszewski wrote:
> I feel like I fell into the trap of trying to address pre-existing
> issues reported by sashiko and in the process provoking more reports so
> let this be the last iteration where I do this. Vinod can we get this
> queued for v7.2 now and iron out any previously existing problems in
> tree?
> 
> Merging strategy: there are build-time dependencies between the crypto
> and DMA patches so the best approach is for Vinod to create an immutable
> branch with the DMA part pulled in by the crypto tree.
> 
> This iteration continues to build on top of v12 but uses the BAM's NWD
> bit on data descriptors as suggested by Stephan. To that end, there are
> some more changes like reversing the order of command and data
> descriptors queuedy by the QCE driver.
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
> dmaengine_desc_attach_metadata().
> 
> In the specific case of the BAM DMA this translates to sending command
> descriptors performing dummy writes with the relevant flags set. The BAM
> will then lock all other pipes not related to the current pipe group, and
> keep handling the current pipe only until it sees the the unlock bit.
> 
> In order for the locking to work correctly, we also need to switch to
> using DMA for all register I/O.
> 
> On top of this, the series contains some additional tweaks and
> refactoring.
> 
> The goal of this is not to improve the performance but to prepare the
> driver for supporting decryption into secure buffers in the future.
> 
> Tested with tcrypt.ko, kcapi and cryptsetup.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

None of these fixes are Cc'ed to stable, so stable kernels will remain
vulnerable to these race conditions.

Shouldn't this be preceded by a patch, Cc'ed to stable, that marks the
driver as BROKEN?  As discussed in the other thread
(https://lore.kernel.org/linux-crypto/20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com/T/#u),
none of the current functionality of this driver is actually useful in
Linux.  It's just been causing problems.

- Eric

