Return-Path: <dmaengine+bounces-10289-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D1MJ9OIAWpJcwEAu9opvQ
	(envelope-from <dmaengine+bounces-10289-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 09:44:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352AF50974B
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 09:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69C5030300FA
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 07:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2E83921E3;
	Mon, 11 May 2026 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjLwr3MP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B855391849
	for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485123; cv=none; b=HyQ9LmQ8Ht+vHuWQs4CmesdVjtJAK5B7kQKsYsYHBtJgY4JaPyaAgq55jeQ+6Opsz688vjZo2ktjUxipZQOjHisgtB3yssgQw37lJuZRmtd+WRdc6moi/gFq0vSyWjI87ynjOc0/2SBCLs9RTFeSHpAHL4nb21slKga8dcWL0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485123; c=relaxed/simple;
	bh=oKWbOxAiXPYVDwgg9WjzqUlR8fPwmHv5+VQjFfr5yI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR5EJ2TOs5a0QsWZuHozT4QWRytLVgTA3ZVGYJxV6DswxYF4MhXS0yQMYM/wGXGl5S+M+Z9q6QNYwoAAp+fPwnjlyfq3cSnHL3GHWIjPJaOura1VGBD8nsUYfQxwfBv/C4mXKOV2Rjo8kpg7AzQHMskRK7yLqJ1aYlbqDxy/DMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjLwr3MP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DD6C2BCFD
	for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 07:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778485122;
	bh=oKWbOxAiXPYVDwgg9WjzqUlR8fPwmHv5+VQjFfr5yI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WjLwr3MPJNAiC9kWB+V/4OLn47GVE1CPqQa1BWWpbxKiybzSl3mJfD+9GYPdDjDQ4
	 1LDjS76dhu64DFS+BSubz3rPJRN93CMzZDp28LXdGR7jsvLmabxE7StGHBptsjHoxb
	 4WEOHj8m7sHMYyg27OKdoeqwxUk58SonMzR/Nd+Kksc/fnQ2aYgmHQkvexbFFKf+0S
	 ygFoHlwEzyS+qdVAGVDi3fPR1VSfgrV2JGKUHZj3YGIJdDiVDpf99D4Ua4p1HReohe
	 reYM+ArzQ5ChM7T0OVUm07/YbXeaMnlQ3QR3V0rDVWGH9hf2TG7RyltL5aTknwFMLS
	 t4VWRJYK+GFnA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-393800f638bso31794681fa.1
        for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 00:38:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/wUIgdbs6nWlRRxUJi8uOGNrcGP7I3idRUlZsiZeWaURVLCQoKrZDyf8QczWzGe/uGZj0NwCpVYAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cBhUp6UsiyJtz+Yr4x3WPQGA4yFt+Mar8CEW4/UvMAlb3vXG
	OABbmwCrfXq5qavrVT7nya2xuDtleJ7zNbHWeKI+Yjg8aqnrP9aStaX88SHf1wSRZb135weORE7
	wAIIddhmBJ44juc0ERJ5stJXGzx8Vfthbk8tWO48VqA==
X-Received: by 2002:a2e:9853:0:b0:38e:4810:4f36 with SMTP id
 38308e7fff4ca-393c40fd736mr63972081fa.9.1778485121444; Mon, 11 May 2026
 00:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com> <ditrkd5jcxlx7onykxh6n3qhyoclfngmpp277y4t4qwc4vswoo@5os4o5lumidn>
In-Reply-To: <ditrkd5jcxlx7onykxh6n3qhyoclfngmpp277y4t4qwc4vswoo@5os4o5lumidn>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 11 May 2026 09:38:29 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mf4q7med1_hpzFevBb8uUi_dat_Q9JD5a2ou+d+ZbgYbA@mail.gmail.com>
X-Gm-Features: AVHnY4J_9uo20Had1fL2AwvuspbaVqC_LSQpt6q0tyhkVlN13cDmk8AlgDDAB5U
Message-ID: <CAMRc=Mf4q7med1_hpzFevBb8uUi_dat_Q9JD5a2ou+d+ZbgYbA@mail.gmail.com>
Subject: Re: [PATCH v16 00/12] crypto/dmaengine: qce: introduce BAM locking
 and use DMA for register I/O
To: Vinod Koul <vkoul@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Md Sadre Alam <mdalam@qti.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Peter Ujfalusi <peter.ujfalusi@gmail.com>, Michal Simek <michal.simek@amd.com>, 
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 352AF50974B
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
	TAGGED_FROM(0.00)[bounces-10289-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,kernel.org,linaro.org,amd.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,linaro.org:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 11:55=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Mon, Apr 27, 2026 at 11:15:33AM +0200, Bartosz Golaszewski wrote:
> > This missed the v7.1 cycle so let's try to get it in for v7.2.
> >
> > Merging strategy: there are build-time dependencies between the crypto
> > and DMA patches so the best approach is for Vinod to create an immutabl=
e
> > branch with the DMA part pulled in by the crypto tree.
> >
> > This iteration continues to build on top of v12 but uses the BAM's NWD
> > bit on data descriptors as suggested by Stephan. To that end, there are
> > some more changes like reversing the order of command and data
> > descriptors queuedy by the QCE driver.
> >
> > Currently the QCE crypto driver accesses the crypto engine registers
> > directly via CPU. Trust Zone may perform crypto operations simultaneous=
ly
> > resulting in a race condition. To remedy that, let's introduce support
> > for BAM locking/unlocking to the driver. The BAM driver will now wrap
> > any existing issued descriptor chains with additional descriptors
> > performing the locking when the client starts the transaction
> > (dmaengine_issue_pending()). The client wanting to profit from locking
> > needs to switch to performing register I/O over DMA and communicate the
> > address to which to perform the dummy writes via a call to
> > dmaengine_desc_attach_metadata().
> >
> > In the specific case of the BAM DMA this translates to sending command
> > descriptors performing dummy writes with the relevant flags set. The BA=
M
> > will then lock all other pipes not related to the current pipe group, a=
nd
> > keep handling the current pipe only until it sees the the unlock bit.
> >
> > In order for the locking to work correctly, we also need to switch to
> > using DMA for all register I/O.
> >
> > On top of this, the series contains some additional tweaks and
> > refactoring.
> >
> > The goal of this is not to improve the performance but to prepare the
> > driver for supporting decryption into secure buffers in the future.
> >
> > Tested with tcrypt.ko, kcapi and cryptsetup.
> >
> > Shout out to Daniel and Udit from Qualcomm for helping me out with some
> > DMA issues we encountered.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
>
> For the whole series,
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>
> Thanks for incorporating all the comments, Bart!
>
> - Mani
>

Vinod: Can you please queue patches 1-5 on an immutable branch for
v7.2 and provide it to Herbert to queue the following crypto patches?

Thanks,
Bartosz

