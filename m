Return-Path: <dmaengine+bounces-4774-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F8A6EBEB
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 09:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BA718953E5
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7ED1946C3;
	Tue, 25 Mar 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CsUfPwOT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD37481B6;
	Tue, 25 Mar 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892503; cv=none; b=Q0/ggDmTAOefgYsaEnI8mRcL4pQncuuotPo2iN7PQmuX58YCFoPjzESvMxueGwGDpUFxTCMCwQQM1eqygwwVKV1a1Olbp6mTeSoJgx+qInUWv+SYLluo5ymCN8jMpoBXHyXovV9Knnm1CrD9J2iL86Y96qs1kNRlTKt0BC4T8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892503; c=relaxed/simple;
	bh=gdybEFAtjvlOoe9OT9n/vdKYA9kiNqWEyCmU9ONMv4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8QYm4HZX/RwhnKE01ZfW+ZNz+Uv02uJZ2ZtcE7OeXWtWsGS51fVPF1s/lhfIEIZEj3o0uPSlSgIXerowxirCjralw3F/rf5v6Zcl2yvtCEv2FN3+8jdhv5pAukwojFauADYboABh5dFFwr1mPAYSBFmFLkCPoXBZUZpROyqxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CsUfPwOT; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742892476; x=1743497276; i=markus.elfring@web.de;
	bh=gdybEFAtjvlOoe9OT9n/vdKYA9kiNqWEyCmU9ONMv4Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CsUfPwOTvpTRQFrwLHMp11jMytjtJ/MAHcAEfD6eKLnkBozij/L2JpDGet9jCruP
	 Yl0GxU4u8QUogGNe65WbXGe18QEM3Mq4GMHL5X4fGtGN6U025y86YDBCR6X2/UNJc
	 t3gERAkk9GAQy+0jHIFkQ4M5GOn8lc+GaIGkdUisPpIgzHRFf2JWTs+9/DxU/FJ7L
	 mJj4WEjG2vtR5W4YYv6nPRXzmXYGIp2YA38ZgzX7Sn+ZLlDpyglyffV/p8miBahqG
	 m/JZbzBvndGkkp3Ca+gio2BS1tvzDh/2N7Xv6MMnpsygnHS1TCrFjR5Mn1aOblhga
	 W8ZR4SaokJxRozYuQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V26-1twRzC1KeA-000ZK4; Tue, 25
 Mar 2025 09:47:56 +0100
Message-ID: <7332ccd2-ebe6-4b9d-a2ae-8f33641e7bd4@web.de>
Date: Tue, 25 Mar 2025 09:47:45 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6] dma-engine: sun4i: Simplify error handling in probe()
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>
References: <20250324172026.370253-2-csokas.bence@prolan.hu>
 <92772f63-52c9-4979-9b60-37c8320ca009@web.de>
 <7064597b-caf7-42e2-b083-b3531e874200@prolan.hu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7064597b-caf7-42e2-b083-b3531e874200@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fj09jZvYnU2PRBECVb5E4bk1pNUR2cUYFKE/F1CD28+WT1YEeMm
 A1hpelizqKdWuW+fSGxR02KYM/2LGzi+mgT3qr7OhcpEhUVrNPh5MhO5LkXx8AUNSLgXHqq
 LiNEicK1qnvcbwp2BcQq/yzUpqpsJIUOSNaDC/+GjKIkCm0a79TU3ARq/JBnrB/F49EnCLi
 Hh0enqr+g1IBFc4o197NQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GoLEl/f3Dng=;QQQMs5mLUQQJmFylzHuzn08kGws
 SVxvDdpDtxGhPr06YlcK4GFIPHqVKZk1ZVcTfPPj26o3qxmaH6piRQlSVuI1cFucGSFdvXAkG
 TZea0c4XZMmSO6nk9erVf/b6EFQ88AkIVYECOFNS82Crzi9QLR1GZmqVlMKC0Q4523GHnGr7T
 gVz+pcwnX6ETj8uP3wI9oFmdhNeKVI+G9k6p+2DEL7hvq85pl9nSWrkkhx3PY0v6WKB0HUZM+
 F70lSArmU79nMmx85ubYicRfesvjrLm+ML9uM92tBJ13spHm2aeCmlWjIiJdmWTHRL6s4wVjm
 a7hSEwQBt7HpscjK3rpU+PkbZJlrJy6W8DV1OwxRq9wr5mQJHbtMLQeoSXcTzsEthgkAqBppA
 Af+TzTKeRPR8XryW+fLu2wPkZIK1PxNUbQoMdnfj4TqPIYPp4nBzwyOXNrjt6IOaACb2RtciB
 wfLrXH5IuXLCtYjxRbxgdi4fk2KJCvx7bx77Uszv4kd5ebXeex52Tf84g3aQE6xlMviHOKM4H
 mqQjDpdmSDq+SDEihQt3h/vqgYJIOKMZofpQPjIXI/i7KOOse7cxm50jrqQ2Umpk7hiriIIfz
 uxmYxfQT5Q2LPjqooZlpy1RUP6qq1owLOB2n85P8AHGUygYibgxOpGuEQqVDkljO9bOZogeJI
 ynDRfygn/uu4ZeloRoyu+IIfvaQJpHCcSR4FjCbmANnqNGbK0s663bRRad93r2Q3NDQKQvqAM
 8siK/yk2/RxJkfvyed3hkwJPLZJF9W/gcVxqjaCSsBg8u7CIelQFn5/C3oappdQCETb46nX6e
 D7rBs/sPfGUev/sXddvPsi0rv1OL45rdyv+hxFd7QJIVeiJvwcxS2wpSVEMpOg4bnnzkgTbhY
 vPjwfIcESJ94406BDsIkLnMH2ZpgAaFSIk+nFtSklhgO0Qku75QuGxUyUuOO3sASSwqDchH0t
 /GTUuqPbDgxRFQiKJYQtaooIRRPN6S5DmAWmjwX0LdO4MAlFtTkJF03bQ3WZWMg50+4oBdCYr
 LJTUf9IDkt58H/J9wccd8TUWy8at5ImsA/N1miTkAhNdTyYUe6wIt6auZuQMpr3wo5RFBJAgQ
 mMIhDS1bM73YBxquBkmFRWKVOx+6KLtVoeOPS6lvJ1h+ewinoEB+MHJDobV8uCHNn4dBJH8P9
 L0TqBXr4TJ37iL6f/pz3UYTuG6O0NRJE5m649BHwnG+E9I35jQlw35bsrA1RIoKt68kNzjZ/9
 62RIPQnKYzHRUZ662fS7gFInGYPMwNG7GWtvZKg+cFuHDWoWYCdGjlY9XlOB6QDl/D91q1bjY
 wAwca9rw3/EzDwHWD5PLk13omvrlpaKJkHVjJoSbNKlZmh6BQQd7yeNftIAzNmRP6LzxKuX0S
 RUqDgMEz7flKzAxhQ0wFa8E5huxUVRWTxi336F1WNPK6+cifvWEzJsvkwQPa2lwxxHOI2hJla
 F9KrODZbK+/iVBlhu7vrGgzx6qCdnvYBJanVkKKYJDcYmbmFuQrhvl86QQBI03sy9V42QFw==

>>> Clean up error handling by using devm functions and dev_err_probe().
>> =E2=80=A6
>>
>> Do any contributors care for a different patch granularity?
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/process/submitting-patches.rst?h=3Dv6.14#n81
>
> I still don't understand why you are so adamant on this.

There are developers who tend to prefer an other change granularity.


> It is just a simple refactor patch changing 33 lines,

The transformation goal is fine.


> mostly in one function, with no logic change.

Implementation details are probably worth for another look.


> Does it break something in your system? Please explain yourself so we ca=
n understand your viewpoint better.

I hope that the understanding can grow also for another bit of refinement.


>> Will it be clearer to mention also the function name =E2=80=9Csun4i_dma=
_probe=E2=80=9D
>> in the summary phrases?
>
> I already added it as per your last response, did you not read the messa=
ge?
>
> On 2025. 03. 24. 18:20, Bence Cs=C3=B3k=C3=A1s wrote:
>> Clean up error handling by using devm functions and dev_err_probe(). Th=
is
>> should make it easier to add new code, as we can eliminate the "goto
>> ladder" in sun4i_dma_probe().
Please distinguish better between information from the =E2=80=9Cchangelog=
=E2=80=9D
and items in a message subject.

Regards,
Markus

