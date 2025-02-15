Return-Path: <dmaengine+bounces-4497-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E270FA36D88
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 12:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB47D162D66
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAC61A2388;
	Sat, 15 Feb 2025 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="a8Xp3lXf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30BD70824;
	Sat, 15 Feb 2025 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617267; cv=none; b=qZRYUZBB7FPM7+XxV0QCM25itjwCZgieCeuw7tGfrQYAnZOUWACgELhexOyq4g6a/k3siFvNBuLMVBFcVy10llmh9l1MpGx6HBML7TtxTLnEG190zfGc+dcSgWvLR6AYdPcIuPTxQlAp656gVLgMfhdoGPyCEU69lGaiqzx5tZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617267; c=relaxed/simple;
	bh=taUL8GvzEIHC87/SEVJl/tjSqqcyWj5N2NeN6/rEVG4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tb6YTGr+I23oh8Wc7+U54aELVvLc85y0x1qnreTRPklfH/Nd7zHqA4ar0Uyj+QJSQ9iJFfr2FV17obF5NlHC/NeffgUW7QgrTWnx11zn//3kvlvUZXbYF8pLeg9JDTBm/mGFkKRz6CGvtnkRqwlyZ1O25a4bYzZMR5SjIPBsByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=a8Xp3lXf; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739617237; x=1740222037; i=markus.elfring@web.de;
	bh=lwlOpS/PngUjZo7c6ftmB0Rq3lhMukkPp4s5og7vFrs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a8Xp3lXfz1eCB64IfdUNs2agY4JJhHHboa4RDHsub3kfeQL8BwlziQDS49kW2EM8
	 Ut7iUkec1S0puZ1L11C/Jvbrf6ZX5lyxZrvU5qzSMNntwRHLjVjD5PJ7+wrpioMKU
	 +eIn3JGhQdKCW/R0dV/RONXbXN6c34IaocOBW3yfyTVXzCH2LKXnSmVlYiBUyvocW
	 DY7GAeTx+hiZsOscaNmtLELRIjlWBmIqPsLeQZT86wJ17BwY4qMU4+5OIt5ZKNbCE
	 Kcf6zduj7xSpr3qPuRCZ1q+usLE97dduAwBvJSgH8Y1uFpzuUrgmTMpiusEAkbP+A
	 nhRUquMDOfn2HnGRqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX17-1t2jtg18In-00c4v5; Sat, 15
 Feb 2025 12:00:37 +0100
Message-ID: <98327a4d-7684-4908-9d67-5dfcaa229ae1@web.de>
Date: Sat, 15 Feb 2025 12:00:34 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shuai Xue <xueshuai@linux.alibaba.com>, dmaengine@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Nikhil Rao <nikhil.rao@intel.com>
References: <20250215054431.55747-2-xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 1/7] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250215054431.55747-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y4YNU/Ldfti/nNnkoM/15BDbsFCs0cpuJFILpvgO2iZi9lC3w96
 J0B14dMNa6nIy6pyg5xbGHX5uzvIuNkmkwwVLQBioR01OXg/SHUklYw0aAItAKe846kyIzs
 9UXGflXNqmqoq5UjTpbn2hHzZB3cFeC4Fr1XJt7+lYcmFtp8EerUiMcjFu4wGNh1hvWpo1Y
 i4VUNKl2bhyi1ZCuEef8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mw6Mo6hEnY4=;BlRHP++aeom6XB14pE33vK0tv78
 YdcyjUy8EMcHdetlEn1Nnnmu22p4CsHHWltG8XdLvZrTCSACwpEiEzYlRrsV1DUmhpCvLQmOz
 vP782XXYs/ncg/e2wBCuhwjzLC8XYr/96e3KUUvFJ7YWU1NAJKjUXTrdjydKBQCS5b44T1Dce
 7KwblP/D1ukvXM/CRanj5Kyllu/Yrek6LcWHrOc8aFFFN7QvVbFDNXOiLQLpU5VuI7vV9E+ae
 7HC6cWvxOOq8yp37XS7LW71QGjuwLESh2tS+Ml9UOtWCVnRQXWazdxrM+SWYCQhM12PsYQ+T1
 YY1rugZyWED9t02UsG/f6DCcie0UQlxNsykKPW55GPtv0Zj9UYDda6jwRQ01OnNs0scY3+4hl
 MtMm/lasmUpVrUBf9m7sEpmbRWKaz4XnpIgJpkRKUxi7mTWvl7+4GmuxjQQy8tElv0eofQPBL
 xUaoIgKyS5fCw8L6Lv0bqhVw02w5DDATY5ol23l8ZE6wnhHt0yErm3aHUA8b6i9778bEOXjiu
 pQ5b3BMVrgskfUgJKrYkbWgNfyggwiU3SZcwqMM1bIRUPBowTFkq/1LHLNDIMgxJQeqE1zdRN
 xuigqgevx1FrjyQ6NaQIIw7ofl70atYJJP732N3h6ldmldYWPs2wZ1v9y4ScfsSQzxra7uyPy
 VRY6w/7EkWZY3+mhFh3v/0/n1hW9TV+IXAxfCUXXl7VTltsB201JUGUasNn9Q9iV/xf2UU3b2
 pcDjvPXLmSdvLp3iHyDcjXG2Q9OMSflWS7yPNHhC/ARKp2xMt01BlDxQnpGWRDqlNpiaUiz5Y
 zoKow4EoPUjcHjjH7VrU7232+r3QHdUMOl+ZL4vm6ZNgewVIr9FZO9vB4PKYxmKSyWZu5shXW
 nSuR4EJIAZv8zhQDcS9iNCyHwUmtEjWch/T50HDhhGTj0C3fow0/y467hN3FP/LGJsCwLdDwc
 Pm/FCmbUkDHrEUVVUg8HmYLapiBUzwiiSmhVsAdFtIqia/IMC5Y3ELvwXUn8PcIlmCgXr664Z
 LreME/I0aFITjOhHhBEYKRFUfpzlWxi4yvVznK4OlSk1cs0opTxfHwGrbqa2qANy7fAC6HLim
 RJ1pIKGci+LdNy6pZNJjkvkoAVVnkJQdqvGXK/5Xnf9/W31Jhg0Sxlf7gaGTDfrR5IKNjBLe0
 dQKcXtoTeAUvkMD7Xf5tQLgPLJgz4rXKSB5sbTFVHXYqE+ET9AXVYlmpBulcOOMSkHKtAPJPZ
 jvPR8ilY+6vzkVW738eTHTnMC8k3I3p9HIuuHOLMGSH6y4GTygplsKS6fGJovOWYHiICeoz+Y
 m8dmMnKIqTHwtNgVtxAFOROSXjK4lxDAf9SKdtrNXafJZMwCEQL9llX5A1Q7XOLD3oGbRhJMh
 MlpKvlVVQkOdrI/vFP7eGGertta6N22X8a24UMkv7QredWOPtro9znaUFW+SJRxKL2Sic2yS3
 xrmAelA==

> Memory allocated for wqs is not freed if an error occurs during
> idxd_setup_wqs(). To fix it, free the allocated memory in the reverse
> order of allocation before exiting the function in case of an error.
>
> Fixes: a8563a33a5e2 ("dmanegine: idxd: reformat opcap output to match bi=
tmap_parse() input")
=E2=80=A6

Will a =E2=80=9Cstable tag=E2=80=9D become relevant also for this patch se=
ries?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv6.14-rc2#n3


> +++ b/drivers/dma/idxd/init.c
> @@ -169,8 +169,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
=E2=80=A6
> @@ -204,6 +205,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		wq->wqcfg =3D kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(=
dev));
>  		if (!wq->wqcfg) {
>  			put_device(conf_dev);
> +			kfree(wq);
>  			rc =3D -ENOMEM;
>  			goto err;
>  		}
=E2=80=A6

I got the impression that more common exception handling code could be mov=
ed
to additional jump targets at the end of such function implementations.
Will further adjustment opportunities be taken into account for
the affected resource management?

Regards,
Markus

