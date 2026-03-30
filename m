Return-Path: <dmaengine+bounces-9708-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBLmIJ0rymmQ5wUAu9opvQ
	(envelope-from <dmaengine+bounces-9708-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 09:51:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE96356AC7
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 09:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 886C5300D152
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40463A6EE7;
	Mon, 30 Mar 2026 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf+NQfW6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812143A1A4D
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856940; cv=none; b=VLhL89PalZsDdAKy3zTIlOh4i7r1Y7QFclsbxVzM//7+zB6fjkfuByBHigTtmitX32MSxVFVhdvwD4xnSiGGQH6UAIKEpWPhdFUWaUML4ftLffB/rdLlgOHGPy80Qfn+ssRnow9dZ1rjXL6b9nJCO6lM65ck554h0Xw76LENPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856940; c=relaxed/simple;
	bh=lD2Z6zQIgevKi2IqTHqInMxXV0jeIeXVIIwGCfGmDSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKAvJtdLtL1g22IeGJVCEgOGDXBHpfxY1lr1TOqVZJjvsGe1xp3nHGzI7kMN8alehjRXILIxWgbf77bDI31JkoWxNhgYExFHyrwfGZEbUIp6y3dZzbc9lwgO8JXDpqYYDdJ55tECMoCXRAQCksZWN/oTCAq3ApVXrZIKqZvjRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf+NQfW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EF5C2BCF6
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 07:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774856940;
	bh=lD2Z6zQIgevKi2IqTHqInMxXV0jeIeXVIIwGCfGmDSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kf+NQfW6DdHb+ZdGOOxI66nekPvZ1tzokGCWXtUurIGyRdYRJL1CKQkzf5u3ByNwV
	 ANh/jdCwHDpbELE6GzHv0jIG4u0x4pi5ZHEVM9L5lu/A4ijVABN5c2iYxLdGBqSQ4u
	 Qrz5RiC2/+/hdjDDWIiWDjmb6ADBS0V2gFjbCU8Ur4QY9FLtJl5Cyo7dn5UQ3WOSfa
	 9cRNCj3T4O9BsG1Pm6RgTACFucHUzU89MMsde5HgzDACeDjpY3PD0u5dYw2eCL9EFA
	 fmMGrO59NYDrNhHRlxhXgqbxsTsDuwhQiaIyczRh0cQHsHi6PX7e2xN+h4recSULVJ
	 nwJC44BpFaE3Q==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a32d36396so37814171fa.0
        for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 00:49:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZ0ePwjSIqJTuKZD6lZ473oa7ZBXndAR1PbYSwP6vEEPheVACjev+6gbMkKGhbz/OrSe9I+WnwVHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNyb6RTdGJgVfH+8tTME2pFqCy5SiAbKSqIVSE/jnysExMWqU
	0PgIPNYzV3d3uP3BzXW87ZVm7R5e6qYEEMWKVJ+yID1FTrIE8f/NVwkIrzKskcUSk46jkYdQ2Li
	26qjz11DveaOVybrjkhXOhozkhx5LtUY/6zdkulyLWg==
X-Received: by 2002:a2e:8a87:0:b0:38b:f838:dcd0 with SMTP id
 38308e7fff4ca-38c756d2050mr31367251fa.3.1774856938701; Mon, 30 Mar 2026
 00:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
In-Reply-To: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 30 Mar 2026 09:48:47 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mek-OrzG5B6cJnz0ZVRn1paUYVdgf67LAJC_GKCzfU6qg@mail.gmail.com>
X-Gm-Features: AQROBzDctCw49nI4ZpKxOYPIv3NwI9Us8xjc3cHh8fG92eva9b9SctdyfBh_Ryc
Message-ID: <CAMRc=Mek-OrzG5B6cJnz0ZVRn1paUYVdgf67LAJC_GKCzfU6qg@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] crypto/dmaengine: qce: introduce BAM locking
 and use DMA for register I/O
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Md Sadre Alam <mdalam@qti.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9708-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,vger.kernel.org,lists.infradead.org,oss.qualcomm.com];
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
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2FE96356AC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 4:17=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> This iteration is quite similar to v12 but uses the BAM's NWD bit on
> data descriptors as suggested by Stephan. To that end, there are some
> more changes like reversing the order of command and data descriptors
> queuedy by the QCE driver.
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

Hi Vinod et al!

Any chance of this making v7.1? Stephan, Mani: any objections to the
current approach?

Bart

