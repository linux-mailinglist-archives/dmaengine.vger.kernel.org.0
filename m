Return-Path: <dmaengine+bounces-3164-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999C5979916
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2024 23:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55649282A07
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2024 21:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1232C853;
	Sun, 15 Sep 2024 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJfz6NfO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EA17C69;
	Sun, 15 Sep 2024 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726434372; cv=none; b=nSS1JMSRou1uHWkYmzxhgXSvpWUGq14Nw24DRihzVJiEY35Iv5ZSP9xDBh/ubM8Kmy3f7b9suDId0ctuyuCkL/bQYr2ggzHlLViZzb8LPJ5lsDSMy9pDmugSa5jCg0ssoUjHy39IPrb3+MAehX8Gebmhe6dKw/CIoHfYAhSr8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726434372; c=relaxed/simple;
	bh=2O3gdX3u82tGv2/Dix0+XKlk7OiqassCAjQjSXroIPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BA+/OarHCNiin4eNx3Wi1tdSKfhv27zG2l+eT3oC5hseZ/Hggq3567B0QjyBBL6jqHdkFjVm1ICQKq3SYOgt53RRqCY7TvXfN12w1GaInapl0iXAEnYNUsGGFQIimWRhGjPwYZYg0z6EEyzYEjwGirPpUVeSQaoTLiEQ8jndLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJfz6NfO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d446adf6eso375156466b.2;
        Sun, 15 Sep 2024 14:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726434368; x=1727039168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWWwfkH9KQrIY6QEmR0wF7YR/KfyiBzU7EaMIwcIgIc=;
        b=MJfz6NfOjCC/MiQjpNZss3BH1sT+boWkSVq51OG/mehdP/83YPzGdSv6yZ5ohLNpC7
         U6plNmVQVGGKfmjeBhOR0wwjsBU12+ua4RdSLEbVC4Wnb+4kt+OMF8jtiNXDgKLKw7Sc
         c2Qyo7FSEX5PPX+q33gj+yOomGuadNUVvqdhG26auoI7J//0h7TmEEWndJBSM2TznOkg
         ZwP8liGz1VTjyOybycPJORtBqBFADIxFFgYx6Kkyq7/KqKcntc6xud8RFgXcvgyODirI
         9TlMc63g63coETS6Jy5C/ugLS42q91SFoGHjO/mM9odwt2a4h/SZthOiz2mUZ2JSLuXF
         MXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726434368; x=1727039168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWWwfkH9KQrIY6QEmR0wF7YR/KfyiBzU7EaMIwcIgIc=;
        b=HgYQBwGjnOUA8X/Ks0CLsNzzxLv7OR/j5hH1HIH9iVSOVr1evWPCLM0q81bBbcqLCK
         oJvXZ9/EnyVGM8WAqdruh4nNG6j/46jcNWM9tohvAa9DFT2pjML4EYmhhYMbL/2Lw3Mc
         U9XMSYI1iAG+b8xEcCc+dr1VNJa4Gk1mvswHh9bhRebYeW6VBL4Y5KBpJxFaa5RtFfA+
         SOlBF4964da7uGh6cvKqGdzLmVkFJiHFhRx7bNLH1J+HEGLCbOe1mQA8qPe+5ZxkgW9x
         VCoq7VYLT/Z4ozW2/7YDbXkBmTh6uh3AIl0hZqpnGVcqE+qRMVutBswmaDk15zcwdd4J
         eytg==
X-Forwarded-Encrypted: i=1; AJvYcCWNjCnxy0RIvqAB/MbshCmwhKh+btP+KpcVJ+1YhNyOwCaAths9Kigr4mfUXpZafPnL5HO7t4s7HUM=@vger.kernel.org, AJvYcCXNSRvp4sSFGu+uo0itf2NFN9KBXjquNicBWa8ItjnI37jUM7Hkg/8ey9ITUiVIjfMRu2By0GSXUfVhWrjR@vger.kernel.org, AJvYcCXxHeYy8ArtC9ErfE33mlVeK+0MGHesJWRydI67+aNVjzsj7es0HUiAGwpGbfYCvqjGygnm2HwGbJDUjxD5@vger.kernel.org
X-Gm-Message-State: AOJu0YwOe8XiMj31INzq4twyzn8/lHp/EsW1+YBSbynUIerPopnEtJX/
	70GLya0Hdp+AhDbE1cTgMwV6xMcWOCjIGgJwiyLAqbsOTb47x1VmDU82QQ==
X-Google-Smtp-Source: AGHT+IFE2Rl0nxQvNooP+jVbxK5faYIYNQgNbKbhRlY6ISS2ZnDUIxqV7PmVljXQNtSlznRqcHom+w==
X-Received: by 2002:a17:907:6d26:b0:a77:c95e:9b1c with SMTP id a640c23a62f3a-a9047d1aa36mr901961466b.27.1726434367404;
        Sun, 15 Sep 2024 14:06:07 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:f90b:5a64:5ccc:e327? (2a02-a466-68ed-1-f90b-5a64-5ccc-e327.fixed6.kpn.net. [2a02:a466:68ed:1:f90b:5a64:5ccc:e327])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f43e9sm232858866b.72.2024.09.15.14.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 14:06:07 -0700 (PDT)
Message-ID: <a574695b-2c4a-466e-8d72-154d16328643@gmail.com>
Date: Sun, 15 Sep 2024 23:06:05 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 1/6] dmaengine: dw: Add peripheral bus width
 verification
To: Serge Semin <fancer.lancer@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ferry Toth <ftoth@exalondelft.nl>, Viresh Kumar <vireshk@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <20240802075100.6475-2-fancer.lancer@gmail.com>
 <ZuXgI-VcHpMgbZ91@black.fi.intel.com>
 <wghwkx6xbkwxff5wbi2erdl2z3fmjdl54qqb3rfty7oiabvk7h@3vpzlkjataor>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <wghwkx6xbkwxff5wbi2erdl2z3fmjdl54qqb3rfty7oiabvk7h@3vpzlkjataor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Op 14-09-2024 om 21:22 schreef Serge Semin:
> On Sat, Sep 14, 2024 at 10:12:35PM +0300, Andy Shevchenko wrote:
>> On Fri, Aug 02, 2024 at 10:50:46AM +0300, Serge Semin wrote:
>>> Currently the src_addr_width and dst_addr_width fields of the
>>> dma_slave_config structure are mapped to the CTLx.SRC_TR_WIDTH and
>>> CTLx.DST_TR_WIDTH fields of the peripheral bus side in order to have the
>>> properly aligned data passed to the target device. It's done just by
>>> converting the passed peripheral bus width to the encoded value using the
>>> __ffs() function. This implementation has several problematic sides:
>>>
>>> 1. __ffs() is undefined if no bit exist in the passed value. Thus if the
>>> specified addr-width is DMA_SLAVE_BUSWIDTH_UNDEFINED, __ffs() may return
>>> unexpected value depending on the platform-specific implementation.
>>>
>>> 2. DW AHB DMA-engine permits having the power-of-2 transfer width limited
>>> by the DMAH_Mk_HDATA_WIDTH IP-core synthesize parameter. Specifying
>>> bus-width out of that constraints scope will definitely cause unexpected
>>> result since the destination reg will be only partly touched than the
>>> client driver implied.
>>>
>>> Let's fix all of that by adding the peripheral bus width verification
>>> method and calling it in dwc_config() which is supposed to be executed
>>> before preparing any transfer. The new method will make sure that the
>>> passed source or destination address width is valid and if undefined then
>>> the driver will just fallback to the 1-byte width transfer.
>> This patch broke Intel Merrifield iDMA32 + SPI PXA2xx configuration to
>> me. Since it's first in the series and most likely the rest is
>> dependent and we are almost at the release date I propose to roll back
>> and start again after v6.12-rc1 will be out. Vinod, can we revert the
>> entire series, please?
Indeed all six need to be reverted due to dependency.
>> I guess it's not the best option, since the patch has already been
>> backported to the stable kernels anyway. Rolling back it from all of
>> them seems tiresome. Let's at least try to fix the just discovered
>> problem?
>>
>> Could you please provide more details about what exactly happening?

I can reproduce (after working around another issue with the following 
tip from Andy: The DMA module is loaded _after_ the SPI, and for some 
reason the DMA engine APIs haven't returned deferred probe and hence the 
SPI considered the absence of DMA even if we have ACPI description 
non-fatal. So, you may try to manually unload SPI and load again and it 
should start showing DMA).

On 6.11.0-rc6 I get:
root@edison:~# ./spidev_test -D /dev/spidev5.1 -l
spi mode: 0x20
bits per word: 8
max speed: 500000 Hz (500 kHz)
can't send spi message: Device or resource busy
Aborted (core dumped)

And on 6.11.0-rc7 with the 6 patches reverted:

root@edison:~# ./spidev_test -D /dev/spidev5.1 -l -v
spi mode: 0x20
bits per word: 8
max speed: 500000 Hz (500 kHz)
TX | FF FF FF FF FF FF 40 00 00 00 00 95 FF FF FF FF FF FF FF FF FF FF 
FF FF FF FF FF FF FF FF F0 0D  |......@.........................|
RX | FF FF FF FF FF FF 40 00 00 00 00 95 FF FF FF FF FF FF FF FF FF FF 
FF FF FF FF FF FF FF FF F0 0D  |......@.........................|
>> -Serge(y)
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko
>>
>>

