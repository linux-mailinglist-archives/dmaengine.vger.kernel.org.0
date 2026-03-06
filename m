Return-Path: <dmaengine+bounces-9291-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAvSNZy1qml9VgEAu9opvQ
	(envelope-from <dmaengine+bounces-9291-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 12:08:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C121F718
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 12:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A74D304FA42
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 11:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C633366DC0;
	Fri,  6 Mar 2026 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enhnqn0c"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598523502AC
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795288; cv=none; b=RmcpJRsXwSGQIyCPGe1mNmlQ1nOXQ4gwvwl50IvaXb+U//qxIlFfU6Dh9QIPAt0t5L/dzfsWUWjWo2MG5ZvvRxKzDw+LrQSbm825EVdhZ8M85AdzUfBetM2fcuJBFU9Ea0zpS56USOtQTCJSgwW2uZiGDNd0ZCK1yGXGYt/eljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795288; c=relaxed/simple;
	bh=zvGkoOu6sc3DwKuM9+tCXqq+dXf2cC7y58uKtjKrGkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsSf7WH/OjjjrzG+kmPYsyaCkkyA0Z9P+P4BXs4rIxp+CNPmBAe6ynNix96wK24TvlOvrcDxB5SbmcTYed2vKdRVXv4HnGg+0tdjxxt/S8rQrlHWKSFW97mBMTfEjNueQYWoSoiVjDVeMdvouSVIHpyAiSu2bmmDRYGi/3RhqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enhnqn0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A55DC2BCAF
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772795288;
	bh=zvGkoOu6sc3DwKuM9+tCXqq+dXf2cC7y58uKtjKrGkA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=enhnqn0cQZOEfPg4lbr5H0FcIOxP/gaxG/zy4LHsHbA4Y//gAslwnbfUUjaIeSPwd
	 /XqGAc1zKK9l/RwY+YKBm0jm2/l5eZ8bBH84Vl9gXweq54jTLN7PSUoS5wkA+sj52M
	 OgrSO3Yc8VMOPu3u81jUj+NfsgMOtFEoNikq6bspa78MHsrfxKrY2l7pWKZc8O6DsX
	 /kH3ojHcyPUAyuaR6CUWEXqo+2wa9wyMT8+h8PiUpnnAtMeoRI5n355eulvZupV3aQ
	 OICqI7Ot9BXmBXN1FpeBIotaIPwdFoAwwGcAHoQHXlmbuZJgb7wZoYFsWqk3W4OCfo
	 QmkMfSQbe73LA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a1322af04fso2009538e87.2
        for <dmaengine@vger.kernel.org>; Fri, 06 Mar 2026 03:08:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8uRwW6BC1qDfz668hRXEMKgW9zMrSzlLxcX37pm6G8YwPfEVvzEeraV16oC4GwBo5Y1fdIrn5I9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw74cn8Nm0wW7nE/+kqMybpjowMCt4kz/8ISni9G+XJscaO63ki
	OrW7Qw/ZOsvJTJ509jc39rZN4Lcn7fneHd48uOPQ/OaZXOdj6eoEIsM415LMD1ghDKxJSwve5yR
	0/Otx0vMqDjFgpPFCcW7cFpwsWClUc9q328hHMyRA/A==
X-Received: by 2002:a05:6512:3719:b0:5a1:3b28:42fd with SMTP id
 2adb3069b0e04-5a13cd58785mr456080e87.47.1772795286638; Fri, 06 Mar 2026
 03:08:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
 <scr5qvxa7f7k22pms4c6k5gwiky7lhssrw6qryfngexlek44g2@rayinnnwqgbt>
 <aalwMwN3qMlzrql5@linaro.org> <CAMRc=MfjknN1AYF_NPLzR0YbdWuoET25D9o0zsvx56VN+u59HQ@mail.gmail.com>
 <aamIf8JethKzLW93@linaro.org> <CAMRc=Mf=NjCqf0eqmM800Q3MEUC48V_DZ3ts6+4=qMCtrbvzzQ@mail.gmail.com>
 <aamsL4uh58Fv5een@linaro.org>
In-Reply-To: <aamsL4uh58Fv5een@linaro.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 6 Mar 2026 12:07:54 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfMJzVrRBo0kbgDbznRexFn2bc6GBkNh75k3L4Kw25VJg@mail.gmail.com>
X-Gm-Features: AaiRm50SYPFbrtvBCgqbAD5XV2pariKnEghQc2LIPzo-Ehg13xkHUxUA3b9Bzso
Message-ID: <CAMRc=MfMJzVrRBo0kbgDbznRexFn2bc6GBkNh75k3L4Kw25VJg@mail.gmail.com>
Subject: Re: [PATCH RFC v11 00/12] crypto/dmaengine: qce: introduce BAM
 locking and use DMA for register I/O
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Md Sadre Alam <mdalam@qti.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Peter Ujfalusi <peter.ujfalusi@gmail.com>, Michal Simek <michal.simek@amd.com>, 
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 655C121F718
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9291-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 5:16=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> >
> > You'd think so but the HPG actually does use the word "dummy" to
> > describe the write operation with lock/unlock bits set. Though it does
> > not recommend any particular register to do it.
> >
>
> I guess the documentation I'm looking at (8.7.3.4 BAM operation in the
> public APQ8016E TRM) might be an excerpt from some older version of the
> BAM HPG. Is also has a note about "dummy" command descriptors:
>
>   "NOTE: Pipe locking and unlocking should appear only in
>    command-descriptor. In case a lock is required on a data descriptor
>    this can be implemented by a dummy command descriptor with
>    lock/unlock bit asserted preceding/following the data descriptor."
>
> This one doesn't make any difference between READ and WRITE command
> descriptors (and both are documented in the chapter).
>
> Personally, I would prefer using a read over a write if possible. Unless
> you can confirm that the register used for the dummy write is actually
> read-only *and* write-ignore, writing to the register is essentially
> undefined behavior. It will probably do the right thing on most
> platforms, but there could also be one out there where writing to the
> register triggers an error or potentially even silently ends up writing
> into another register. Register logic can be fun in practice, commit
> e9a48ea4d90b ("irqchip/qcom-pdc: Workaround hardware register bug on
> X1E80100") [1] is a good example of that. :')
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3De9a48ea4d90be251e0d057d41665745caccb0351

I agree in general but I also learned from the QCE team at Qualcomm
that apparently there were some issues with register reads over DMA,
which makes writes preferable. While the VERSION register is
officially read-only, I've been told writing to it is safe. So it's a
choice between doing a READ that may not work on some platforms and
doing a WRITE that may theoretically not work on some platforms.

I'll send v12 which will be a proper series with using register
metadata and correctly freeing resources and we can rediscuss. Doing
one or the other is actually a minor details of the whole thing after
all.

Bart

