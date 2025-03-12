Return-Path: <dmaengine+bounces-4711-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C973A5DBD2
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 12:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B8517A16F
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC96D23F397;
	Wed, 12 Mar 2025 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fwCA+hTv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346E23E23F;
	Wed, 12 Mar 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779863; cv=none; b=r+yN1G6dxM89BEgxQ0cj45oqnAx2YHxIXTXfeuRNTaVVqcOtUOQI0IeqGFocaVf8X800Ef39ZseLiVFTuOxKb8EZTW7sUKFI8KeHFnO17wMcqS1wQ+yBR+zt4E+c42kclhLlGPg76Fn9YyRqqXaFy33FATktjIFtYmglUiqEL+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779863; c=relaxed/simple;
	bh=MLnKan3lFYDD+jvzhQNITIAxq798Ip34clQk5vThoys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlKvKc2wWvkhJ91awgyOIcelbWcT9voqmlgt/U3zxvEIka2ZeMMc2AewujwsnSaNBIwDZ2uq/MAnN6J9LW0DYGgQoMjN6t40KJzpxrnx1vVO5O6GSXB/hNUr+ZLVf1eUIem3FO9fVu7J2mpPD77MdVZdePXW3wBZfspXel9nZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fwCA+hTv; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741779856; x=1742384656; i=markus.elfring@web.de;
	bh=MLnKan3lFYDD+jvzhQNITIAxq798Ip34clQk5vThoys=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fwCA+hTv+xevWhkTQGzqZY54XO6nMElzeJc1/orgz60gpX4gGPsEy3THUzP2JCL8
	 uATjwFM9g8qat/TJbX+g7G1THZP1MA5MeHU6nSi1X/u8vBXf9npIopEpxmq6LwaIS
	 2CtcslgwC3F97QMnSc3rR1k19fB+56zD8GJum7845m4JJDrEpR0CdTBowzPJhaumm
	 vVWYiSMZ4Njfg77aU6rlvOx7a6hBMIJy6kM/EoTZbFdiPPxOJdLcVJwOo8i5n0epa
	 KaEyAZxe56MFUdzDPbXo9jLGEA0eM5BP/9JMx7wBwS4LBV5BQNej0Ugsw1EAj5523
	 7LqDuVYMMHgNrOHEGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoNZM-1tPpFo1ODw-00fcM3; Wed, 12
 Mar 2025 12:44:16 +0100
Message-ID: <9ef781b0-8a63-42b7-91a2-fa8a8ea3c0b4@web.de>
Date: Wed, 12 Mar 2025 12:44:05 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] dma-engine: sun4i: Use devm functions in probe()
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>
References: <20250311180254.149484-1-csokas.bence@prolan.hu>
 <885ceb3e-d6c6-4e7b-a3b6-585d2d110ccf@web.de>
 <81f87d39-d3f8-4b6a-91cb-b0177d34171b@prolan.hu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <81f87d39-d3f8-4b6a-91cb-b0177d34171b@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:80YpDH0o3hUHkweOLLEIn/ZK5SDX0jpLC2Q+zbRQrqjKibA/0ho
 NbKKWd8SOUb18XeqaK4CFWgRzmMNdV+5QRagLrkle67BCLcpV2u8fwvo6RcLmDZmJiXKZ/Q
 727i6hAL6RhEmYRmjeNpRINEwCdFOBlhf+KsJzcgS5TFt6ohZfpEIoMt1YxkFS2kCZce+9h
 J+GzvoTvhZoM7eyZdcPUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AV80ruHJYxs=;dZeG8Z3LKpqUsPmFKaUNL3FOj3i
 JTXsrn9BP9hHyIulU9qz8iv24czCZwqjFT5FJ2IbPMIaxFD1njxdP1gyClAOqkvA/eyaaQxtg
 HHv4ERWXjJG61uWD5mG0SiNv9y6fwrtmBbaROCl+f52TkQDdwHLumuNp7IRBqcfVEWVrJPy9Z
 2OQNrmyHsMnQCniE9Yi+vHd4Sx/+4ZFWkQFvCsrLk7iSczyVNKRYqGruKCZ8DJYqhfaWBBO1d
 OFCKC40T5lfPxWBdYZdw94/0N/MOAxxc8N/0xRVyASE0RRXCayhk0qGWN5GE7QC+Be3tVoyQo
 FiDt27/FgkM0jooz8FK/r9Qxd/fj5aemv58iRvJ+F5TNdggpBQ30k7TShiP5N3dPBogufQ5ii
 FHdWIuf35zk8KOLGuXMUIDo2sZTgCRfjmOL7rytrCqJSdUeq8kBjQWn+X9r1sqS9eqsVj000A
 hH02//eHL6Ohw14cwo368Tmt9EQkPhxDHz/tYMIBOF/6hkJfOOSQXvlKIDG4eVBxU/NNTLZl0
 OPBmFWuF4cbk0Bwjw6C85/gJRGStHJ2d02NB9bj7dmlfOB0Nm+kk2Fuuty/sB5emCm9mY7Kg2
 lgPetwHF7Kt/5zKZmqRtQUf0yI2MsaO/F7VWvFEE4+aojjjIp29K5ChJxVyykgLlRK9EjhSFn
 0MaH/Q/JxrWXK3R7eeY6J8SkAb4eaTWCXMSP7Y8xjISitwnGdmQnIt7epJP6zW8VCZm9ON1bS
 fddlbe6Vct6TL1F2jIpATEGtRsQ3o+vKMlezDY+Qrt+lVomocTB5YQ2c+3/t40wIPUniRpNJt
 w10O9p7e6j3dXZlBI7YM9kM8pk4oKGjPEEu9KTeQS+RkDB17TW9jQ/Fi1zw+LZedr6qknA5Wj
 edKjYr/l0uVuyZQp2W1ICDnzTPWX+mvZpgnSLdXfD/WGqwV/E0/a8/EG2DiZO6JE+gKhkRM7u
 hJ5QvazDMa+f+zFhMmDA4bbqSwvNX21ItGxElC9XevECHHwJxKiSQkHPKlSz1Bt+15UNHSnVN
 bUqya6rF4/K46GqAvrS7Tk3lNpzGXHupHQYXbVxHXFRQF/UY4S6HtX7o0OOh3h9t/u5l5o/Jk
 8cpbyFnO+ls+tUEuCY+3KBsYbI5YvRWI3ToY8aDFPsHz9cw7c90qbXkUNVroMqwCx2VNFONDP
 NWMGr0SMtoGKNlO8MC/T/EBgMuPgPmpGeeM6ev9JvRinbWADLkw9wfpY8+a318gv7yPzSMfGH
 bfWNLxyyXdFkh9IXuEA1El9iHIuCGX3nm/4GeFZNcDJcxVJp0Ee8GF4nykQWnhTuLo9rjuY9z
 V/LuSbrQgbEHy2k/d7yJHFZ+s8yk78YbmpnOdAoqU0wnH4I37Wlhrp7+f3d/hMI6Vu2h+/D3J
 aubt/z3jPkabRZR0xPONPeBH3gJjRHqat1V5HsUe9QX/rkxMEDVFzKiHr/d50ybpUDUiOvaEe
 yhKJ7nw==

>> How good does such a change combination fit to the patch requirement
>> according to separation of concerns?
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc6#n81
>
> It is a general refactor patch, it shouldn't change any functionality. I=
 could split it to one part introducing `devm_clk_get_enabled()` and the o=
ther `dmaenginem_async_device_register()`, but I don't feel that to be nec=
essary, nor does it bring any advantages I believe.
Can it matter a bit more to separate changes for the application of devm f=
unctions
and the adjustment of corresponding exception handling with dev_err_probe(=
) calls?

Regards,
Markus

