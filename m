Return-Path: <dmaengine+bounces-9382-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHSIIh5FsWlCtAIAu9opvQ
	(envelope-from <dmaengine+bounces-9382-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 11:34:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F7426244D
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 11:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1FDC3077F1F
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8885A3CEB9F;
	Wed, 11 Mar 2026 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svl1za/v"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A483CA4A9
	for <dmaengine@vger.kernel.org>; Wed, 11 Mar 2026 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225161; cv=none; b=fCGDpo2NgzNuXU4WX10t2aRtxz/h79rA3AsCn12paTWJ5cDTHtDvUjEXG5Xby2hi8qcIrUFBrv8Deh312nDvPjPnFAlhKxFIsEAV2ESLAJO6n7bPjnUcH6F2p1YcVFDj2q946JKXDo8unCKSDJHw2IG8FRYQpwQOz+cPRrrFzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225161; c=relaxed/simple;
	bh=RSDSTK7sEaAY8nIinSnQhpMyoUW6LnkFogAohb6WbUY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsF9/kX7bdDBVwK6pD0T0YUGqUzPafD63ACQMCUDP85v2VJ7W90ndluNJPQevF+sAeknUbqEkIPCNOSIcz9Q5uOfvziYdbbwDqdwLE9MYlBOqrpSwqmjWOdldB1aNTsQZHfApsvEtZ34Xcc4kxevUaWoOElUWQ6XvYmXIg6uxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svl1za/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F3EC4CEF7
	for <dmaengine@vger.kernel.org>; Wed, 11 Mar 2026 10:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773225161;
	bh=RSDSTK7sEaAY8nIinSnQhpMyoUW6LnkFogAohb6WbUY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=svl1za/vttGiJkEjbioKb3KXiQ//LSe5/R5KHO8HDCqwXHmXa5S1bUBWInJRchJtE
	 toqz+x46XqtQBPPAKJZsmmBfwtFTkyjvdBDg7U35+slG/MAfya08BzK0Cjkv1eV9sN
	 scWq5Xg5pWdVGgYj7UfDjEbN7Bzki6PWUpQhUwIRt4cBi8c5ONSsmUl/lE3pdAjJNT
	 QCJrBfHJjB2+Fmg0P1jz89lU1ORKeV/9aZOUztobSRxVdEWosp0wEM9W/sD5rryvB4
	 MIBGTutUMv3ARaQbl3/22HVx90lhdCihEt+B3IeIjTwYsUlHR6mWouIjMPEcWJviZ8
	 ixpZCbJFDqK7g==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a32d36396so8037691fa.0
        for <dmaengine@vger.kernel.org>; Wed, 11 Mar 2026 03:32:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJIzjG9EQy39coVSTvYBI5zr3kE7Kn1giZMk4FEsEzgQF95ezSgqnJ91xw452DgBiOPZwZNbNoYIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPxPsgBVFYuhamRds36ZK0A495nM1w+LKY9J6tpp/FzvA9YgHp
	4P7VYrm/GeCV8yZGjdelVLZezb4j9zmiLXQ9rCUCTykl9OS3t+5TsebJMvEKB/S9OvT9WnqWdso
	UyT0Z8hrEevZquvYoyFfoe7rGsAFJyRrZ0L+R5v5xSQ==
X-Received: by 2002:a05:651c:19a9:b0:387:14c6:53e3 with SMTP id
 38308e7fff4ca-38a67ea3ad5mr7169861fa.0.1773225159634; Wed, 11 Mar 2026
 03:32:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Mar 2026 03:32:38 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Mar 2026 03:32:38 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <abE9RQfGN6Ycns1B@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com>
 <20260310-qcom-qce-cmd-descr-v12-5-398f37f26ef0@oss.qualcomm.com> <abE9RQfGN6Ycns1B@linaro.org>
Date: Wed, 11 Mar 2026 03:32:38 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeSfFyVYSJHzHvuynRR3TWRz04tyiOy1JvqyHP0aQKPOA@mail.gmail.com>
X-Gm-Features: AaiRm508xMUuB-wSkC9iLovtxoWoaeYCiA8Dr5gqw5VbtTTRXMZ5IKSgQiGjyZY
Message-ID: <CAMRc=MeSfFyVYSJHzHvuynRR3TWRz04tyiOy1JvqyHP0aQKPOA@mail.gmail.com>
Subject: Re: [PATCH v12 05/12] dmaengine: qcom: bam_dma: add support for BAM locking
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, brgl@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C1F7426244D
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
	TAGGED_FROM(0.00)[bounces-9382-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,vger.kernel.org,lists.infradead.org,linaro.org,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codelinaro.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,linaro.org:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 11:00=E2=80=AFAM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> I'm not entirely sure if this actually guarantees waiting with the
> unlock until the transaction is "done", for two reasons:
>
>  1. &bchan->vc.desc_issued looks like a "TODO" list for descriptors we
>     haven't fully managed to squeeze into the BAM FIFO yet. It doesn't
>     tell you which descriptors have been consumed and finished
>     processing inside the FIFO.
>
>     Consider e.g. the following case: The client has issued a number of
>     descriptors, they all fit into the FIFO. The first descriptor has a
>     callback assigned, so we ask the BAM to send us an interrupt when it
>     has been consumed. We get the interrupt for the first descriptor and
>     process_channel_irqs() marks it as completed, the rest of the
>     descriptors are still pending. &bchan->vc.desc_issued is empty, so
>     you queue the unlock command before the rest of the descriptors have
>     finished.
>

Thanks for looking into it. Good catch, I think you're right.

>  2. From reading the BAM chapter in the APQ8016E TRM I get the
>     impression that by default an interrupt for a descriptor just tells
>     you that the descriptor was consumed by the BAM (and forwarded to
>     the peripheral). If you want to guarantee that the transaction is
>     actually done on the peripheral side before allowing writes into
>     config registers, you would need to set the NWD (Notify When Done)
>     bit (aka DMA_PREP_FENCE) on the last descriptor before the unlock
>     command.
>
>     NWD seems to stall descriptor processing until the peripheral
>     signals completion, so this might allow you to immediately queue the
>     unlock command like in v11. The downside is that you would need to
>     make assumptions about the set of commands submitted by the client
>     again... The downstream driver seems to set NWD on the data
>     descriptor immediately before the UNLOCK command [1].
>

If what we have in the queue is:

  [DATA] [DATA] [DATA] [CMD]

And we want to extend it with LOCK/UNLOCK like so:

  [LOCK] [DATA] [DATA] [DATA] [CMD] [UNLOCK]

Should the NWD go with the last DATA descriptor or the last descriptor peri=
od
whether data or command?

It's, again, not very clear from reading tha part.

Bart

>     The chapter in the APQ8016E TRM kind of contradicts itself
>     sometimes, but there is this sentence for example: "On the data
>     descriptor preceding command descriptor, NWD bit must be asserted in
>     order to assure that all the data has been transferred and the
>     peripheral is ready to be re-configured."
>
> Thanks,
> Stephan
>
> [1]: https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/se=
curemsm-kernel/-/blob/fa55a96773d3fbfcd96beb2965efcaaae5697816/crypto-qti/q=
ce50.c#L5361-5362

