Return-Path: <dmaengine+bounces-11163-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IfjRIlRoIWrYFwEAu9opvQ
	(envelope-from <dmaengine+bounces-11163-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 13:58:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3844563FA48
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 13:58:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gTa53yJV;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11163-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11163-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8266F31D90D8
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA142B72D;
	Thu,  4 Jun 2026 11:50:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F6402B96
	for <dmaengine@vger.kernel.org>; Thu,  4 Jun 2026 11:50:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573852; cv=none; b=c+hvL/6lgKb2/ySv/f9ETauw/TIeiiEJ5YnCDNCLQjmdS7MjRQjKQ1tfXDj/OfvVGmwvp3vQPf77cVRnwQnGmTFwCRRC+O6ofPK1d+nHuGhLOoqrZRx5gCKwIneGHu8xeh1UadnSYf4WQGnKAX0/hbqQHLkZG0Dz8mEtieX4L0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573852; c=relaxed/simple;
	bh=+AP/U3cPeU0fXOEAiHxHazm6k88v5P4k80O8mHj3UmM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmuQAGYEWOTxBiG+Bhy9rq6cWMM5dtxABeqa/0ot/VGZdCQorBLoQMMEjXCC3XPTDV3yy3KtJXsqyUY2mESVoIxPcxPtZoTpZjbe4e+0sUF7LvPmv6uAgV5stATg+tM8dmRXkRA0tV5m4cx+gmoXEWZG5jlVgzZWxz7K2Lar0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTa53yJV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDF91F008A2
	for <dmaengine@vger.kernel.org>; Thu,  4 Jun 2026 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780573851;
	bh=+AP/U3cPeU0fXOEAiHxHazm6k88v5P4k80O8mHj3UmM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=gTa53yJV3FNKREqub3QPIdJdIBpiqctfla9UV9JKkXPKWxEGfDkIQGwtIbrwOVEqN
	 6WUPv32i6BvWBnugDJsvR0knou13vTeL+0tk6S2on+t5TVox8/U7gzRhhksbVI+CDS
	 DXBwwMvHmfdHMs3AaYmyrqMsscl1JRvo17pC0WJN7BTevi805aE/nsJ8ZlPQFMdpmu
	 szHsdO6T4b5MpCHi7GvCmN6haPkT45wpzJs9dJIjcgyWtCVlm3ZSPES/ITluPyJx6m
	 J4vpo+0RaYOmuw8lJTYIaqn0csIPQUuyzgt8xlbtd+n+faRoZB1D+erw6WnEMC3FTC
	 6D5/6Dz4A+9+w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-396669329fbso16446291fa.0
        for <dmaengine@vger.kernel.org>; Thu, 04 Jun 2026 04:50:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9pkULmorMvkYmiIiNreJad/i5345tgchjJOrsiQEskh4XJRdMSq4Crl4EDDde6P7plSjPN04PSN+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2IU1KVc1iMXZbgIroCgztHL2VIxMSdAxDPa3sr23WgpYnaWV9
	vAkF3SkFfAXbnE9GCaSr0OFXSj69/xGw2elsOK2+mrgE02nY7i0rFCqcf5VLn1UMd/JVXZITQxp
	wKSQ6UPA3345n6YNw9WSv+P7AWyC7ZjnB0sFbIv4xng==
X-Received: by 2002:a05:651c:242:b0:38b:dd55:b71 with SMTP id
 38308e7fff4ca-396bbb2b99dmr9083771fa.20.1780573849639; Thu, 04 Jun 2026
 04:50:49 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 04:50:48 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 04:50:48 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aiFScCW_NEY3CsEf@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
 <ah8G_ajPS1KhgPP_@linaro.org> <aiFScCW_NEY3CsEf@vaman>
Date: Thu, 4 Jun 2026 04:50:48 -0700
X-Gmail-Original-Message-ID: <CAMRc=McYB+S1LmqRJbWKirMGqwJHZCTWj6KnB6Z8qUsYQWBqkw@mail.gmail.com>
X-Gm-Features: AVHnY4ItlnHzBWkZf26uoYFprN5coNBr4vZZe2XdpgFnq6HAZyN9LACZLu6Trcg
Message-ID: <CAMRc=McYB+S1LmqRJbWKirMGqwJHZCTWj6KnB6Z8qUsYQWBqkw@mail.gmail.com>
Subject: Re: [PATCH v19 00/14] crypto/dmaengine: qce: introduce BAM locking
 and use DMA for register I/O
To: Vinod Koul <vkoul@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Md Sadre Alam <mdalam@qti.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Peter Ujfalusi <peter.ujfalusi@gmail.com>, Michal Simek <michal.simek@amd.com>, 
	Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@codeaurora.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, brgl@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11163-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:dmitry.baryshkov@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:stephan.gerhold@linaro.org,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,kernel.org,amd.com,codeaurora.org,linaro.org,vger.kernel.org,lists.infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3844563FA48

On Thu, 4 Jun 2026 12:24:48 +0200, Vinod Koul <vkoul@kernel.org> said:
> On 02-06-26, 18:38, Stephan Gerhold wrote:
>> On Tue, May 26, 2026 at 03:10:48PM +0200, Bartosz Golaszewski wrote:
>> > I feel like I fell into the trap of trying to address pre-existing
>> > issues reported by sashiko and in the process provoking more reports so
>> > let this be the last iteration where I do this. Vinod can we get this
>> > queued for v7.2 now and iron out any previously existing problems in
>> > tree?
>>
>> Thanks a lot for working on fixing all these issues!
>>
>> I agree there is no point addressing all the "pre-existing issues"
>> pointed out by Sashiko, but have you looked through the other comments
>> for new issues pointed out for your patches?
>
> I hope Bart and Qualcomm can fix these driver issues as well
>>
>> Out of curiosity, I was looking a bit at the comments for [PATCH v19
>> 06/14] dmaengine: qcom: bam_dma: add support for BAM locking [1]. There
>> are 8 open comments there (Critical: 1, High: 6 and Medium: 1). From a
>> quick look I would say most of these could be valid. The critical one
>> about the usage of dma_cookie_assign() sounds a bit concerning to me, if
>> it is true we would be basically breaking parts of the dmaengine API for
>> consumers by inserting the lock descriptor in front of everything else.
>
> Yes this seems to be a valid one. Attaching another descriptor for lock
> does not sound right to me, as in this case causes descriptor to be
> marked 'done' prematurely.
>

Yes, I have a fix for this queued.

> Honestly, I am not quite happy with the way lock is being handled here.
> I would hope we can have some better suggestions. Adding a descriptor
> for lock does not look right to me. We are adding odd hardware/firmware
> behaviour on engine apis.
>
> I had earlier suggested to lock always or lock only for hw/sw versions
> supported inside the driver, that might be simplist solution without the
> complexity added here
>

I'm not sure what you mean here. Several iterations ago it was deferred to
consumer drivers. Mani objected and Bjorn and you agreed. I reworked it to move
the locking logic into the DMA driver as requested.

Bart

