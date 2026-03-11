Return-Path: <dmaengine+bounces-9386-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMgWDS5RsWlCtAIAu9opvQ
	(envelope-from <dmaengine+bounces-9386-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 12:25:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F5D262DF1
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 12:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75E453049E1B
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 11:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CDC3D891A;
	Wed, 11 Mar 2026 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjEi7UaP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5B3DCDA5
	for <dmaengine@vger.kernel.org>; Wed, 11 Mar 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773228329; cv=none; b=FIe3Dy7q5u+zHv5FUiWAxakG3PRgIqPwN2O20f0cIesFI311Kn+QodKZcTD2poc6Ror9NR/EdMGbPK8AP3cqKlJuzz5foB2UxujeDIreXmTW75nza2Ig2T+56M4EqSYs62zhNwNS81KpKzlXEaFmtDGsr8aBgijg0FQSbMzdqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773228329; c=relaxed/simple;
	bh=Bz8L6lJ5ljmm0f1bzOA7lmmgPpBjGpva/qWmEvAb8MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh7QfNBgflj3wqbEj02QCucNoTqG1w9+Oy40dSjxeabMyhwezYo30p96G9df0gG34wE5A954EuCMSNCCijX21g4ERAMLYCs1TD7c13bhOG3G6r9AYcT5zTP2bHK3eyYY7hRRof6BkaSGZZezZ00hVMHsheLIoeixudSP4C5RNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gjEi7UaP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439f59dfda2so1241802f8f.2
        for <dmaengine@vger.kernel.org>; Wed, 11 Mar 2026 04:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773228324; x=1773833124; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CJze5/pXmPew2sfHMpjfcTTl4xqaN7GKbsQ4t36q17Q=;
        b=gjEi7UaPHAFk6q2s51w18yNUF03XkuvFUOBRtX4PJxLEfSWhntd03DcwQd5ef/DK6w
         mgYzuEuj48AU/x0wUIEjswwwUyV+B7krb5hOMHQiJ8UwyyUPQHEDoTjt0SkHOW6R69L4
         6L9THeytyGz8TFUzCmze6v2IRLNvaQK6qmx72iVPWCOSNhFL2EKpf9clVU+q4M7omaiJ
         nZw52V/+sPJ1Xmws4PP4tBHosuOj65m8Be07hrsUkAKiw+WEOTcOnONlSuSzeTfRl9vJ
         k9/OvMzkMYZQxOt3qvOZFEd6Kac7PJaY77UDEFkGn40X4PZZBV+EaC1uX2DUq2LM5YUt
         4+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773228324; x=1773833124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJze5/pXmPew2sfHMpjfcTTl4xqaN7GKbsQ4t36q17Q=;
        b=YcBpZVQQiACWvMqW7oiuDwP+YNFGS8AX0EiOra1Ql3bwguoSFXrdL4D6ofqnOjC9uI
         NYWV/WQ9+3kjNJhi17fZXgdNeDjNA8NJPvBIJku7fmIkctJYBImWVcZAqbjV1StUwX8l
         k1RLR7JADgHWvIHp/K3ABun0Cmv7V6+wmI8ODgbv68W59BYOtNq2LnUKdabto9brkxvE
         qwfWzDCbrG6LPGCYKxu+w8d6wSs0g5eKq8ypAhc8yvC7W+b9s09UeArqU+qWJwqf4qL7
         WdI6RdZ89lSS5XSbFagTcAg415RchiDmuhJH0INwXV1U0KCMipt58ndrS88dE01/GaN7
         mgJg==
X-Forwarded-Encrypted: i=1; AJvYcCVg7dQ3mc0+ZCEUTJSMR98xLnx1vB+OP307ceY3mk2bLkd5HEH0ATadmND2nARMS9ghg/g0NJYjEvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1D4oRr2ckllmNy3YW0yQFqpdyWYkdlM0k0uWz8J6LUbJE/ZaG
	sJDvyZhvzdBgjrXCUk7jHX6oBk+lNIAyGcVjjThi1iip74noVyyCEKxfpsvKBEJBTfU=
X-Gm-Gg: ATEYQzxnyQEtZiRs1EmBHqQmw1PetXwGWZB/AkSMIMuoDub2cMY7F+ecscrmWWrPW9u
	to1tzbHXY7Bd9enaA+JEle/LqgK5yo4h4n+jlffFm62h7KkW9UaWMso6LAN+mhdqbBVXNY3fbdh
	QaK0yfmUl0gqf+yT8DtrS0HCu3sgmd+eSX0VQZbKuMC/ROGVLeQvpTUnfV/dcCsMoi1cGur8266
	twGybpEQFWeLpdyRXSYvJehmarK45ipaNHf8UOtfil9M0gvbhXn1Ic7QQgMZOJ4224kTPlXGFUY
	qttqRC6eY90uUljowJ/ZeQYwLQoN1+d/kPdwDXfwQddn+0+sHuphFeWeY6tusCkjy2QZwRThtsw
	6OyvtXX+zdVtTJwZ4a1Xram5Us4n0a/urnC2zTtptddHnk9sMTDUF9zy0wpn3SllwBwLL7CK+bA
	TNq6x83XXOGqSalnOIE+eTHI4AdceXOcPyckTbokTWJt3BnA==
X-Received: by 2002:a5d:5d0b:0:b0:439:b79d:b9a5 with SMTP id ffacd0b85a97d-439f8431382mr4099695f8f.37.1773228323834;
        Wed, 11 Mar 2026 04:25:23 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff23:4441:1c2c:7aff:fe45:362e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81f1318sm6682078f8f.21.2026.03.11.04.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:25:23 -0700 (PDT)
Date: Wed, 11 Mar 2026 12:25:07 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v12 05/12] dmaengine: qcom: bam_dma: add support for BAM
 locking
Message-ID: <abFRE1qHgP-SYWZL@linaro.org>
References: <20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com>
 <20260310-qcom-qce-cmd-descr-v12-5-398f37f26ef0@oss.qualcomm.com>
 <abE9RQfGN6Ycns1B@linaro.org>
 <CAMRc=MeSfFyVYSJHzHvuynRR3TWRz04tyiOy1JvqyHP0aQKPOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeSfFyVYSJHzHvuynRR3TWRz04tyiOy1JvqyHP0aQKPOA@mail.gmail.com>
X-Rspamd-Queue-Id: 81F5D262DF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,vger.kernel.org,lists.infradead.org,linaro.org,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-9386-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephan.gerhold@linaro.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,linaro.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 03:32:38AM -0700, Bartosz Golaszewski wrote:
> On Wed, Mar 11, 2026 at 11:00 AM Stephan Gerhold
> <stephan.gerhold@linaro.org> wrote:
> >
> > I'm not entirely sure if this actually guarantees waiting with the
> > unlock until the transaction is "done", for two reasons:
> >
> >  1. &bchan->vc.desc_issued looks like a "TODO" list for descriptors we
> >     haven't fully managed to squeeze into the BAM FIFO yet. It doesn't
> >     tell you which descriptors have been consumed and finished
> >     processing inside the FIFO.
> >
> >     Consider e.g. the following case: The client has issued a number of
> >     descriptors, they all fit into the FIFO. The first descriptor has a
> >     callback assigned, so we ask the BAM to send us an interrupt when it
> >     has been consumed. We get the interrupt for the first descriptor and
> >     process_channel_irqs() marks it as completed, the rest of the
> >     descriptors are still pending. &bchan->vc.desc_issued is empty, so
> >     you queue the unlock command before the rest of the descriptors have
> >     finished.
> >
> 
> Thanks for looking into it. Good catch, I think you're right.
> 
> >  2. From reading the BAM chapter in the APQ8016E TRM I get the
> >     impression that by default an interrupt for a descriptor just tells
> >     you that the descriptor was consumed by the BAM (and forwarded to
> >     the peripheral). If you want to guarantee that the transaction is
> >     actually done on the peripheral side before allowing writes into
> >     config registers, you would need to set the NWD (Notify When Done)
> >     bit (aka DMA_PREP_FENCE) on the last descriptor before the unlock
> >     command.
> >
> >     NWD seems to stall descriptor processing until the peripheral
> >     signals completion, so this might allow you to immediately queue the
> >     unlock command like in v11. The downside is that you would need to
> >     make assumptions about the set of commands submitted by the client
> >     again... The downstream driver seems to set NWD on the data
> >     descriptor immediately before the UNLOCK command [1].
> >
> 
> If what we have in the queue is:
> 
>   [DATA] [DATA] [DATA] [CMD]
> 
> And we want to extend it with LOCK/UNLOCK like so:
> 
>   [LOCK] [DATA] [DATA] [DATA] [CMD] [UNLOCK]
> 
> Should the NWD go with the last DATA descriptor or the last descriptor period
> whether data or command?
> 
> It's, again, not very clear from reading tha part.
> 

I'm not sure, my impression is that the exact behavior of NWD is quite
specific to the actual peripheral (i.e. QCE, QPIC NAND, etc). In the
downstream drivers:

 - QCE seems to add NWD to the last data descriptor before the UNLOCK
   (as I wrote, it seems to queue command descriptors before data).

 - QPIC NAND has a dedicated "cmd" pipe that doesn't get any data
   descriptors, it specifies NWD always for the EXEC_CMD register write,
   which isn't even the last descriptor. This is also done in mainline
   already (see NAND_BAM_NWD in qcom_write_reg_dma() [1]).

It is possible that NWD works only when attached to certain descriptors
(when there is an actual operation running that gets completed by a
certain descriptor), so we might not be able to simply add NWD to the
last descriptor. :/

I suppose you could argue that "make sure engine does not get
re-configured while busy" is a requirement of QCE and not BAM, so
perhaps it would be easiest and safest if you just add DMA_PREP_FENCE to
the right descriptor inside the QCE driver. qcom_nandc has that already.

Thanks,
Stephan

[1]: https://elixir.bootlin.com/linux/v7.0-rc3/source/drivers/mtd/nand/qpic_common.c#L484

