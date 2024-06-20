Return-Path: <dmaengine+bounces-2449-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609E9910D26
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 18:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC650B28CD1
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C701B47D3;
	Thu, 20 Jun 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="U4wfLMhE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B21B3727;
	Thu, 20 Jun 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901233; cv=none; b=GtPdR0l2TlPMMrs2SZ1ZuHX3yW0XCkiFYuVbNX8zvz7w8VAO7Lx0j/ClYT9iWIwEJRBZly7m3vX8We/hYPn1MF+20xkK6RCQchij0EUZPWXVcJKPB7mSDUFO5QCuNe+Fo2IsItZjWzPvnfOqg2wW7nfxSwuDW25WQaULPGm9EcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901233; c=relaxed/simple;
	bh=uGqy7zfNB+grtryFih/VB1IHVnD5ET/9Jx8TxfjQS3U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WPzCcJwf48l2NQiNC0hNSLeNvlm9V4MtTm9rcBwAYd+wz71eyugKBrpHO/OE9ogBjyKIULRVfkpHqscapBIHaQAD0MLfttGnzmOa7QpJtMLU8vrtXVR6KVPsFWrLC/CTSXScSH70WTzp7IrawUwrEavWTYAudf8ZzgJ2RYtXL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=U4wfLMhE; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718901173; x=1719505973; i=markus.elfring@web.de;
	bh=dykB42Sd3Re8NZvckvEK5UPju/y5TnSdBQ5mULG1s+g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U4wfLMhEqGf/E6owLCEXzYfF2p1eof2l1Z1G0B174YWML31y+GstGgGuYseaK8W5
	 20FjbUI51rhZFM/28AFVsOiUflRpo83Rn3OgQoxAOTnb3g4rCdnjKgRkkrFoptmA2
	 XahFJvFmysdUjmll65ysQyG0wA30G5LkHfCpFpDcMXEPuYRheckabK3Bnbj29/XRy
	 s8cEOUpflyJg4v6av1dhi9v6MJ+5oKPRKDumtHuZKYPBEtbAjnDrXKOTAQp/CRc8U
	 afrD8aAjsd9o5gqOIC8jqOkZDW5djEwDw3eSxD2ahX7c5mULcFLtBxoeqorJy9eRM
	 t4QWjn5FdXYQDSTIHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAtsZ-1sE27I0wDR-0008e4; Thu, 20
 Jun 2024 18:32:53 +0200
Message-ID: <ca3efef9-9720-46be-a59d-a9a4c5873ea2@web.de>
Date: Thu, 20 Jun 2024 18:32:48 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lkp@intel.com, Paul Cercueil <paul@crapouillou.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Sumit Semwal <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Julia Lawall <julia.lawall@inria.fr>, Lee Jones <lee@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20240620122726.41232-4-paul@crapouillou.net>
Subject: Re: [PATCH v12 3/7] iio: core: Add new DMABUF interface
 infrastructure
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240620122726.41232-4-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jeIzi8pMUjRRHbkEI2McLlbFKS2rmTp2/YbWVN/pPMg1625Dmrm
 OG7fNtWabJLFJVITv55DtECwqQZJrxQqDrkpXx1tYmjLmWo4ibjIqLpK0G+tPWF+YQKJOXl
 X/CPLEcXcpigj9lmdLnvVZNThD1kaIAPXqRFU2Mb7gXvFj8W0tg2Gte24rlJ9rwFjO2p3Zk
 42RBmPZVkFpHq88jk31og==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+eTpu5gHISo=;FvPn9BFx0q8Vg3ZhRq6hxBpzKLZ
 U2PEJ659y+nj6QPHJYsDL+YEaJTPpXHTxgx6wRviFNOe4p3/yROsBK76+gOunzodRdYeS4BqN
 oqOr6J/RHfTPEXsFWBtO6kASEmubf1Q41aTy8TiKAUINr1QroIcBFlzv/5ZilBf1bC70Xq5rk
 PMPyOq3IPqtZymss7xyFlSsMHwNImQGNG7dxgDakPJ+qL5eyXplYP4YuPxOVuuAct/LjZ9Gau
 DZiIvmiYP7esUvAlxG+TEcIRU/PtAjKKQhug9NCEd5TKnVm69K4Qb2HhnEeXKpkRj2P6U72KT
 0QaXQFFOo3nzYNw79cseCq+B01LfPyQdgOL+KnMH7zqbNRj4l8yvKgmaoAPCuZcSrdH36XWVU
 lBWsQTVodUo8YwquewptgmXQzdsXxHPk7DtPS7ZCb1V6K97ErqY4YLuLZUhN/iUxYoeQfVGiP
 FrVafcM/vpkCyDDwWhZbe6+JMh3E34KA1VhP+GVSozJFNemH8EpBfAg/2fWwaPhNYGcdrDpSv
 SA9mzcvxhJAmKx8wYLLpobtdCTY9jqrut8pJK708A93fxLx0xs4hd70TkjFBvSSiXPBYIWHn/
 1YkHWswiiSMk0yoIsTfqJLMShiF4KbmgnsC6pRmm/BC9IzyM/D5Z7acm/ZZv9elLpcEaq8ot8
 qcadgr7f040EA2OAa5Fg1S7qcIiBuMJf3+BTtU32X/J7fvZuSrfUpdzQP18EP0rFvVsZoWgnd
 vBqsqXpRfJ4XaA+vWxJqcfF/6rvwut9TAVZ5+LVezjZ2rnOhPwpLeyfoZbHPMKVgxtfRZy9Cm
 JumtidR4NTrYbH8Eyja37pmb4PkQs/jVIkjk5wy+K3LytLQTq2LT+/Scao1DN2M88q

=E2=80=A6
> v11:
=E2=80=A6
>     - Use guard(mutex)
>
> v12:
>     - Revert to mutex_lock/mutex_unlock in iio_buffer_attach_dmabuf(),
>       as it uses cleanup GOTOs
=E2=80=A6

I would find it nice if better design options could gain acceptance.
Will the chances grow to adjust scopes another bit for involved variables
in such function implementations?

A) Enclosing a source code part with extra curly brackets?

B) scoped_guard()?
   https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup=
.h#L137

C) Moving a locked source code part into a separate function implementatio=
n?


Regards,
Markus

