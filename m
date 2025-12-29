Return-Path: <dmaengine+bounces-7960-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF568CE7816
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 17:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10DA930161E9
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B69332906;
	Mon, 29 Dec 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OyFICohn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094D332904;
	Mon, 29 Dec 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025857; cv=none; b=qXCG+Ny6z04UCt2ZztFuw+/5pio9y4NVFWTyskXXJJb+JpmuANYdTiO6ZE7oN+7Ocqwh3rxwnQnFBIrGvWQJpHm0iClVrgQ5YEc9JuYLfyKlrcK5nRuhhMbDXWEdeYXRVuyBwuUl3BSNdZrZlSXnYZTR34HMt+WGUm60rxxUa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025857; c=relaxed/simple;
	bh=lPjOStvuxf1+XiaXA0I7rLOFGtZw/GVmVG/wcsc8H1U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Iv6Qglxkudy5qR+d/tNrsOC5Fh9hlednAJp7Jg9lc1HZ6KKBN7SUUEU+uNupwW5ERxls9KBEXpeg1tsrraUJE5vYI8yVSa0SYSaCpiLcg3S0YbJMKay8VOvwi59n5z+uZ5Ulu6V9FEfIACq6JCM2om3t30+bZIpJ5itHDpn6g/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OyFICohn; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767025828; x=1767630628; i=markus.elfring@web.de;
	bh=0L3lwQ/KzpvKBzySz4i1lbma5O5tgyDnZQd0g6+7azg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OyFICohnBiJN9HhOBKB3j1qCOnPPJ9NOnvp9W9LtAA1jU/JdtUTOgd89E+gRlHAQ
	 kLf+MaGk2l4h0YU7tWstahp0jljSt8dMzi5JlLkDyElsmwKph2jW+nhI7j8/LH1P/
	 Z72/HBWgHET3c5KKawUdYh6xuPsqpdDGW0IexRswP+29vTimC0SOY27iudZ8+KqiK
	 kunfU4JjMNkOoBmtXIylW326CEiXRTXktuYuC0mk1Z0R0MMTmpSD2K8U5gF6LtX+j
	 tYHOHoglaM/HSCj2TIiOvMpWBG0w16W/iU9Op5EUmvkGpc1BKcvaR0eSvHELEHiP1
	 EIf5eSVUS1Hxr/XBqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.231]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59nK-1vbM480nkS-009d6c; Mon, 29
 Dec 2025 17:30:28 +0100
Message-ID: <c12a697a-e777-42c5-8354-af8e3fba04d1@web.de>
Date: Mon, 29 Dec 2025 17:30:25 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, dmaengine@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20251222040834.975443-1-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH] dmaengine: fix a reference leak in
 __dma_async_device_channel_register()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251222040834.975443-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ahQCdrwOf1RAIqfKr7+3JJ3X9Vok2ZSKIfmDUaetssZ3l6VYpvy
 e8+q32bz3N86T67jZFPU9DwZUiae4EG6Jqx8YRDTfAHY3id7VbP+WwCsyCCuqpgsVCH1Fcu
 ZW3+OnQ7GSIRkRJhjc/ryiELFyucT7sV+Aex3/inA9P4mQQjmAhsthB2+XPiFgFYIT855FQ
 /NshuARNV1R29dvjw1Tug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UlaLR2UyZFg=;7AUoHTGfTQQ7nZX8+PqJWG0tizl
 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
 wLqIBAIPzVk3c1ZU+s4e1f6WFqRfj

=E2=80=A6
> +++ b/drivers/dma/dmaengine.c
=E2=80=A6
> @@ -1102,6 +1103,7 @@ static int __dma_async_device_channel_register(str=
uct dma_device *device,
>  	else
>  		dev_set_name(&chan->dev->device, "%s", name);
>  	rc =3D device_register(&chan->dev->device);
> +	dev_registered =3D true;
>  	if (rc)
>  		goto err_out_ida;
>  	chan->client_count =3D 0;
=E2=80=A6

I find the additional variable assignment still questionable at this sourc=
e code place.

Regards,
Markus

