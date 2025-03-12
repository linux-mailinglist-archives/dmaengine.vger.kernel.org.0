Return-Path: <dmaengine+bounces-4716-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD0A5DCAA
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 13:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1930F16B7E1
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 12:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919141E4A9;
	Wed, 12 Mar 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="qQ49a4EU"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA43C1E489;
	Wed, 12 Mar 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782652; cv=none; b=Lughch4k5VaRbEDACMDBzcDQivUOSuDi0RWy906fmPovuHdfbNd4hCzxhUTilEASTNfYG9GScMUfHM9e+pV4BuoNyZ9oGVcLCuPghDVeDPWmraKzVrH1pWM9z5QKn1l3ZjJdCmnfWJPAgliUNcNXWbBmpca2qGdDnlvL/X968o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782652; c=relaxed/simple;
	bh=laYQCx88mjcDu1ZnBLvTOB+6I7d/yFECJ8I8PLU/mrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V08j/Mph9TvcRJjv3BnlezDwHbaq961YAXC85McinfqdBIsIc7sbmry1FQWC5C4ROg6J/9HUAe+kso9NTg0983egH/lNDJP5cs+eApDC/iQnUDKDYyUTjzsqt2WPwLoS5uT5QhnuTV1azYJ8bRemzIh6dGllKe16txN+khNwC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=qQ49a4EU; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4F763A0433;
	Wed, 12 Mar 2025 13:30:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=cmklfvLlFZxYw5WHt0NS
	MePxUydM1gh/qon5awTqfRY=; b=qQ49a4EU6xjyrrZrVO8B+hvj25GZPeSjA0jb
	7nWqtx/yE+/PuOh6axYscnpPtJZnCUmT1XiXz34qdphteXIo2TKJ5KsVsaQbrXlk
	tUylJKdzUJ6EfDz4qFK6yVM1aVGbxPGaUdWI/bQOuiBI7c3nXLNeTFPrfx5bv68J
	vSJsJYx3lZujSrSva+A6xE/tym5fl0MQR/34G1oev+OcThulayAyqB90QYnXB8rS
	EsMyweSxMqzxmwvlG/62+oJXrrRx/23oPcywfMzqCIHPrTizUL5I1hKt9qJxNQ7G
	0hp4aELeQ8tdiUjwGqvTbbbqJykqBqzZzxeWmyZZ3TReORAfhJ7HnlLmirxrBbDa
	bzfwMJAPkNNpRba8Z2ahlXTtuP/nQbOtBnaJj4Lm561VyLg1pj6n4nQyecsminBK
	9JZ1iaOdx6ikfJeW+2aC9/eykxPtKm0CahpIScO09ixdrP6D2WUUHpAFdQ8AnqJT
	FIxcYKKDwenm5asoKkx7K75nJxFX8DHeGnIoMFn3kV01Le7YYX2H3POwTWR8TbRo
	Izrs5IjAB8SonwI2Nwdi3x4a1yt6XQNPRgXRZE6UQljKWhLFhfwTskZe+LdKCar4
	bBitkR5bthaRvlro6f2XsFW/g08V6CvdOTl7UVQOg4knyzU6/miZUM2x/aMmdqTZ
	nOE9+MU=
Message-ID: <505c2e3b-f1bb-4e3a-96f2-eef0d0d682e6@prolan.hu>
Date: Wed, 12 Mar 2025 13:30:45 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] dma-engine: sun4i: Use devm functions in probe()
To: Markus Elfring <Markus.Elfring@web.de>, <dmaengine@vger.kernel.org>,
	<linux-sunxi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>
References: <20250311180254.149484-1-csokas.bence@prolan.hu>
 <885ceb3e-d6c6-4e7b-a3b6-585d2d110ccf@web.de>
 <81f87d39-d3f8-4b6a-91cb-b0177d34171b@prolan.hu>
 <9ef781b0-8a63-42b7-91a2-fa8a8ea3c0b4@web.de>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <9ef781b0-8a63-42b7-91a2-fa8a8ea3c0b4@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852627360

Hi,

On 2025. 03. 12. 12:44, Markus Elfring wrote:
>>> How good does such a change combination fit to the patch requirement
>>> according to separation of concerns?
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14-rc6#n81
>>
>> It is a general refactor patch, it shouldn't change any functionality. I could split it to one part introducing `devm_clk_get_enabled()` and the other `dmaenginem_async_device_register()`, but I don't feel that to be necessary, nor does it bring any advantages I believe.
> Can it matter a bit more to separate changes for the application of devm functions
> and the adjustment of corresponding exception handling with dev_err_probe() calls?

The change in error handling is just the result of switching to devm 
functions, because it is no longer needed to separately dev_err(), store 
the error code to `ret` and goto a cleanup phase (as the whole point of 
using devm functions is to have auto-cleanup), you can just return with 
the error code (which dev_err_probe() returns for us) right away. The 
devm functions are used precisely _because_ they allow us to simplify 
this error handling.

> Regards,
> Markus

Bence


