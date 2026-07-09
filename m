Return-Path: <dmaengine+bounces-12172-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QKQDICeWT2r9kAIAu9opvQ
	(envelope-from <dmaengine+bounces-12172-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 14:37:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1337310FE
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 14:37:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SO0DVmru;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12172-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12172-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94E503011C5B
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 12:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D3B4229C9;
	Thu,  9 Jul 2026 12:32:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF62422546
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 12:32:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600333; cv=none; b=hqJhrVA6+YBnYOQ4m4H9FLUW7HUqRRq2buz9/4gTRa/Ssx5T+x97bo7Z4nHnYLSi69UztwkrifxkRCMqs50cZTyI5L/xHsMRKPz3rhZahI8BWJK92kTJ0eM2k+Pj2/falIPx50R83QGnFCmI3u6OrtjxYz6B8sXtVKu2mhdinlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600333; c=relaxed/simple;
	bh=oD7sVcKI0EP5wbCBcbErCM6cSOoSEbzddvyLGpoAsBI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sv8zlUVWmZrg6rI5oeDAP4JyZgBr1AphdHDRuGsL4U4xMOm60wWm2Zuu2pUjPYEjLi2voQpOuo1FTh3ckDAG8HZo0H+Q/E3NplQCTe3bKmFrqWVnvca20C4S+YxgIPRzXyj2mQ6Zokr8ULZDiCv2yk0jV0WVWFpKxzD34GySFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO0DVmru; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604F61F00ADE
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783600331;
	bh=4aR9R9rWW9lEHBtHD1X7oe8tDfOcExVaxQWxI0iwWpw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=SO0DVmruKzGhRCEDUhvR08+VaUPO+EXfcFiEUq4/kCU65mP7IoJMaFZlkS29qL85z
	 jJqVr+be51s9PC+n6LxjenfQicQBWU32x3EIrjs7o/hMtZB2cOSXQFXBPVWyZA37s+
	 oKn8SU8hXX0zXwTCgFwdn7WykFJ0ofTRsbWH7aBSz65+B1qiEIpHw5b8/h2JIoeVpm
	 EORHEOYRb6ulLk49aBGhA5mNE6BpjbffZ6cO/hT199i4VW+7qhIazzFa1Qeeg5rVGs
	 0Tlrpw2m9NyIusahdzqvKHIIMwUyY5lxR3fLthjVU6h87fT5qGJS4DpYLy8E+bmBQg
	 4R7ZRsOUP/47Q==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c610a7ab9so13336841fa.1
        for <dmaengine@vger.kernel.org>; Thu, 09 Jul 2026 05:32:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqnqWh+LUfFypsCyNSmfjBZgSLc8HsTKWqKn5bG7bh0msPl/kDCXK9ISgdikNCL9+iDhbO9FasQxJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe7+7DhDTFno3gBX0lgwLovUDnumpsQv3xNUQMLAUl7tPM+DUy
	fBgqKTzCJjDYVZoI2Wx8Gh6lzLA8DLzyFqOjuerHcHiqbV8oSeoSEk939uLlmIuXc5hzfMic313
	zxR4Ag+8ECZUyfFMt+Pw3oKIatnL0ZZRXg9vdGh/njg==
X-Received: by 2002:a05:651c:a09:b0:39a:d7f7:9823 with SMTP id
 38308e7fff4ca-39c798813b4mr15252851fa.17.1783600329964; Thu, 09 Jul 2026
 05:32:09 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 05:32:08 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 05:32:08 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ak4_vsdef9MJd1Yv@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
 <20260629-qcom-qce-cmd-descr-v20-6-56f67da84c05@oss.qualcomm.com> <ak4_vsdef9MJd1Yv@linaro.org>
Date: Thu, 9 Jul 2026 05:32:08 -0700
X-Gmail-Original-Message-ID: <CAMRc=Me93OOyk5gzqD2kSEbR=SNXbOC7azsqc14BLVirnkEmjg@mail.gmail.com>
X-Gm-Features: AVVi8Cee9x38eRLPwnHC8PzzhrHOdP202SPN2_gv8BvqViABwY4y57pWiMje_Lg
Message-ID: <CAMRc=Me93OOyk5gzqD2kSEbR=SNXbOC7azsqc14BLVirnkEmjg@mail.gmail.com>
Subject: Re: [PATCH v20 06/14] dmaengine: qcom: bam_dma: add support for BAM locking
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Udit Tiwari <quic_utiwari@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>, 
	Andy Gross <agross@codeaurora.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12172-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephan.gerhold@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,codeaurora.org,linaro.org,vger.kernel.org,lists.infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linaro.org:email,mail.gmail.com:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF1337310FE

On Wed, 8 Jul 2026 14:17:51 +0200, Stephan Gerhold
<stephan.gerhold@linaro.org> said:
> On Mon, Jun 29, 2026 at 12:01:08PM +0200, Bartosz Golaszewski wrote:
>>
>> @@ -1064,9 +1220,23 @@ static void bam_start_dma(struct bam_chan *bchan)
>>
>>  	lockdep_assert_held(&bchan->vc.lock);
>>
>> +	vd = vchan_next_desc(&bchan->vc);
>>  	if (!vd)
>>  		return;
>>
>> +	/*
>> +	 * Wrap the issued work with a LOCK/UNLOCK pair exactly once, at the
>> +	 * start of a fresh sequence and only when there is real work to lock
>> +	 * around. On a re-entry after a full FIFO, we see the BAM is locked
>> +	 * and must not add another pair we simply continue loading the
>> +	 * remainder of the same locked sequence.
>> +	 */
>> +	if (!bchan->bam_locked) {
>> +		ret = bam_setup_pipe_lock(bchan);
>> +		if (ret == 0 && bchan->bam_locked)
>> +			vd = vchan_next_desc(&bchan->vc);
>> +	}
>
> I *suspect* though that Sashiko is right about the new race condition
> here if new descriptors are queued while the hardware is busy processing
> a locked sequence.
>
> https://sashiko.dev/#/patchset/20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05%40oss.qualcomm.com?part=6
>
> Any idea how to fix this?
>

We could move the bam_clocked clearing from the IRQ handler into
bam_start_dma(), right after the UNLOCK descriptor is committed to the FIFO.
Basically track the state at queue-time, not at interrupt time. Once we commit
the UNLOCK, the locked range of descriptors is "sealed". If there's more work,
we'd call bam_setup_pipe_lock() again with a new "sealed" range surrounded
by LOCK/UNLOCK.

Bart

