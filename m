Return-Path: <dmaengine+bounces-2757-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A493F441
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 13:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AE4283B6B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E68145B19;
	Mon, 29 Jul 2024 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GUBgOF9X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2871422C4;
	Mon, 29 Jul 2024 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253140; cv=none; b=FXjgbiFIKLCvyQz9+yVz5EGFUSpZ9VlKQs5xlHp1/8hPXynEWIqhGPmoJbgsDb3vq318iNa0VA6qMexqII5i4bL3AjVDQwDOjm70j0gzNBAanjUPG6swNMkTZ6nIlPMv8jH2Seix3nzomm85J/u10TsX7ZxwuTLqTw0fYeQ0ZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253140; c=relaxed/simple;
	bh=TD6EXM4kVLwJX3pO87Jj3iLBgEokmITV99XHcrCbz8A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=t6gb8wroyNRMMOHs3Y4GfIetVltGVQ5MkcTxh9W1ZewV0cQgHPifYkKekMPfo1ldRl//3+49TP5rJMTJFXY3jjyuH32MOJ25d+LkrCi3T58cmoPUES+ZxscMfjwbUPrXvN1hkq++Ps2KkI7wvRZ9qwt0760q92He1VdALaMfwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GUBgOF9X; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722253097; x=1722857897; i=markus.elfring@web.de;
	bh=uEAC/L6ulAgRBK7yshpqZXqeMAXPvPPVORtFM67NtzY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GUBgOF9Xli7CwuuHwjs8OKVQ22hlk8G/lgquh2nvsmRyxvIsBkfspwJbPH1/BSII
	 yjfVL9MVrdTNJC/NahRfATjq29p6zPn7zDOku3Jalk1I4RV5wfkrVFm8ZuKr4XLe2
	 Ju52Wk68jaiIzdeKz9wiTcX6qjYXlhF//rqXOq7miLpqqgyV7uVmOTZ8EKS4gm/TP
	 NGJ3BTVQFCD9IG/WWK9lbynCjxvNTf5fJRD0zyiUpv/APMCwsdBQz9vVelGgE1kSZ
	 v/l4tYVtlmqstPbEcsne8MHRfu6DofA3n/CaQgA9ZkdbaO+RnBa1M5L9sN2I6IVi9
	 bUIUZhdV16eB5Xbayg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPKFF-1sv7ae2P4H-00SrVu; Mon, 29
 Jul 2024 13:38:17 +0200
Message-ID: <633f5f40-481f-4063-ab5d-f383e981b0fe@web.de>
Date: Mon, 29 Jul 2024 13:38:06 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Inochi Amaoto <inochiama@outlook.com>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Albert Ou <aou@eecs.berkeley.edu>, Chen Wang <unicorn_wang@outlook.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, Jisheng Zhang <jszhang@kernel.org>,
 Liu Gui <kenneth.liu@sophgo.com>, Yixun Lan <dlan@gentoo.org>
References: <IA1PR20MB4953438ED600110E71F9D092BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
Subject: Re: [PATCH v8 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X
 dmamux
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <IA1PR20MB4953438ED600110E71F9D092BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GuWTcqeMLKlGqfoVB2IgHQverNB8k9DzW7aGPu5et/thqYoUxeV
 KEaLGtlbDU3IoswCwFmckdVvcDKB8i1tshlQCalFohaz8Rc36HME6RrXwaPL/mz3kfZ1izs
 M9ItePqwVvC53KrJEBxcqW/qvTdzotvUs3yFd+vMfeT0DANp/43whYy5MToOvtrhHGOj91q
 P9KxYNHMlp2nwwq0tFDdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:08Yd6C93Dv8=;WU8IyE2VzIfMaK/x1K0zR89Plvb
 G+1CETmKoqcHYDBdnun/+wkAQTGMZu+RQo7BNlFBGkM/tsNY5wLqFr2hX9U6H5yyDWc62r/0q
 x68A8e8PZLrpDfBcZLDe+gLMsokXWetCaYG1JykNU9teOWQoTZML0X+VpunA9G/dvObgSMBMt
 lE8pL+kfqfgL7ysj3GA0RHavuhnf1cU80yMjt8uIPFuFs8iM5MCkhfGtoKVUcu9qTBg64TgfA
 OD/VEOB+cCqmFahz/HJMzYeQs+X99JVNp4pmj3bDgsNiz4YsE0R6UM6GqLfSuZmtr7nVXLH8P
 +NM6+GYrO+FM4qHustw07vxRnwxMXyViEOoKzuCYncHUQpBySnFtSYBmeHzMY0CgIztQCwfoK
 nZ//FZPxkYOG4MUC9/aRJiV3jv7Z6LU6MAzr8x/GIVr68CeRJEfU2gHkj26NFCYESw4E2S9cY
 8TSooqezO0UP2LZb4tfky0EmHS2jUVNP+OBCjaaxHeggWJ8sLTMbCz4yHTVCryT7FiE4C17vm
 tL+fslgrA3QnWBpPojEvUBhw1x9N03MHgb7qcOTHaJp/H9c5brx5ga5XwuLXhqz5pU/BGVG/Y
 aj9knUeus/+/6TlwH0k44WBGjqfp6zyZA8HqqPzLlQa8toPR4NwkkIDySLOuI0x5ss0Crz2mb
 MiIOFqnv6zO6Ghz8Vw1lO4gTVZSu2X7yf5qVyunCrarhYIraYr9PoEujNzKmek4nsbUH0rbeW
 D6RrV2hIZgJmMmpZ2RESXOPBCXzXEudGTtzZLB+gE4djooAb+mk7aRsjvwIothxNM8uPxKetX
 3h3QH2An+MXbZcxVasF2y70g==

=E2=80=A6
> +++ b/drivers/dma/cv1800-dmamux.c
> @@ -0,0 +1,259 @@
=E2=80=A6
> +static void cv1800_dmamux_free(struct device *dev, void *route_data)
> +{
=E2=80=A6
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dmamux->lock, flags);
=E2=80=A6
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(spinlock_irqsave)(&dmamux->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10.2/source/include/linux/spinlock.h#L=
574

Regards,
Markus

