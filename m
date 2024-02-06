Return-Path: <dmaengine+bounces-963-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7043484BCC1
	for <lists+dmaengine@lfdr.de>; Tue,  6 Feb 2024 19:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D60D284BB6
	for <lists+dmaengine@lfdr.de>; Tue,  6 Feb 2024 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE54AE56C;
	Tue,  6 Feb 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="fN9o3gxl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF48DF5C;
	Tue,  6 Feb 2024 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243116; cv=none; b=X5iYTCGVKQur5hL1kblyjAE/QfGZIsVZ/G4NfKNbk5Lg6WoeQDyuTNxYFC91KmBznSq20gL5EbZ2NlwDpwfhOwy+c9H16kKiEYJLURvqk9VTQWRcvF7NzW4lFj5q8Dd4GeWuDsUrtpYmlXRW13KLVxO9aDy/7ZZVALqJhrB32Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243116; c=relaxed/simple;
	bh=0xCltA7q5mR+wvdJo77KvomyKBNbq4PakOFRBQWRUlo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hM6qNgmy8Iq9xqRLA5x6dy9dIDvQCbabORjwu6i19UaP8s+eTmkB+63brqtqHd0N0nSG8B0IEHmIGs3WFiMYjb22+cGt7BlF1Pr0OugXpSp1UYdD4ycPTkFveE2n1r0epPyHRXEM6kxvBmgwcACKCPAyJyMADNq7hiS+hu74Y1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=fN9o3gxl; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707243098; x=1707847898; i=wahrenst@gmx.net;
	bh=0xCltA7q5mR+wvdJo77KvomyKBNbq4PakOFRBQWRUlo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=fN9o3gxlcphThgIoTQbySPzUKLbbsi8VcWQ6xHxGScSJggm6ELjI/5HDK+dObCF8
	 3hRPzNwplGHEBrsWjbC3baAqdE89F+fQOVIrYvaeeatnKDZxnY5DYGM7FNk3D54lK
	 duwOCZZ6WmlrCOZEWKUqdKz3R0vzFNhng2a5zzECXfGV5vi5Yn+VEuRQ0A7yEu/NW
	 R3L7gQ49Fka0hGEcrSoMa1f4rC3Ri9+smnzYBx3x2mViZ0Cc1lnJsT8PLs7byp+3Q
	 Z1rcJJ0uvfPsCtfHUUlcU5FdhvxLP7s/B/8ih+4I5u9EMFtUl7vRpQ6J/FXkW9my1
	 vOQpyvgsRvoXrX0cKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1rZtxL28Sn-002XWj; Tue, 06
 Feb 2024 19:11:38 +0100
Message-ID: <956e0b7c-b1b2-4eaa-bb6d-da6f9dc2335d@gmx.net>
Date: Tue, 6 Feb 2024 19:11:37 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] bcm2835-dma: Add proper 40-bit DMA support
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Andrea della Porta <andrea.porta@suse.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, dmaengine@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
 Dom Cobley <popcornmix@gmail.com>, Phil Elwell <phil@raspberrypi.com>
References: <cover.1706948717.git.andrea.porta@suse.com>
 <eeb94204c30c2182f5ffd3ec083c04399ecdee32.1706948717.git.andrea.porta@suse.com>
 <8736c115-e11c-41ca-85eb-7cd19a205068@gmx.net>
 <CAPY8ntCEvsTJwoEBYc7JsTaYfdMURhmytvvVMcLVNBkmdTNcZQ@mail.gmail.com>
 <42e760f9-8304-4237-bb68-54c98eb7fcb9@gmx.net>
In-Reply-To: <42e760f9-8304-4237-bb68-54c98eb7fcb9@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nllgblqBmJF4zoJgDkTdDxoz/jEocWqLZhyH92vrzLMmpjtK34m
 IiNTqRD0hh4FUybvEsZgpu90X1qWq7P3L3Wgl/qkDh0AHIDyWB33PjNd0iTLQQZfEHI8g0N
 hMpuKJWkIIwg47fpy7TnEM6bmdREJBiU2lB9Muj4CPE7LSJ2ekHxCjwFEZZTma1pJbsCSfb
 XSym7HdR+wBzWj66qYIyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ipCYQAYl42Y=;9awlrRFIDrjhwjZwhMLwIKp+pyF
 93QqdbxqN3frwaNwGiCFMMl8hJZNZzkZsHfbje7RPtTixAct0rBLX9BRQ9leHZ4SxcqYUPcHA
 2FVVa8pdxKxCis1W8N2NWd8MqRFknRfR+fuPbmnmxvsn28wbKnfifXx/zpt4wXBNiMuzx4VTb
 GScP362CD14hQ98tqS8hslR6xLOmslGNm69iiajVysJdTxNXOdEjdUHSdktrOFdP1/IBI5JEF
 b5+x1WFmJJ0kg1bmQhxiqD2+RrospR6nFoWZweAWF6175Sxvp1g/0Vfnbhop0NsOnvm/VGvgS
 q+ju+UpTC1kj34Jdnu5COx4p16DblCUrNfe3BvVPYduedQKofLWXcS9VAo9GwTkypIxCFsZun
 QZXyQhenfaf14hSXpAVsW/LwqcBpa1/2nhkTlIGwFj9QH8mRPq0OBF5vaALqca22gpl2LxCN1
 CdAeZZW2ePmqQQzDvXJV1oZTLcDW+2U3pckkTfSBHJc50T6c5hURFM/MtLprPjwnHeQ3fC2CA
 HMUtslcK/k8KJq7co7DU1o5FNTpvEpKhdibFKWxomEunETqy9uBYhTD0w0FcB8+L6Uezac74S
 zUKZfaMmagT/12Vkg5wweTEyURGeNiQnjuRgIqjSA21f5POTeqOo5tQCnMVJed20heuz7W6rG
 DLUHs6DnIt6cLDRyXzFX0Ig2L9Td8jlPxEfojWzDciYYsr9yX5OeMEnXkNnJI4ePc8S1f8lnU
 vj+1S6aBl66M0mmjpu10BDT4TZhVCnR+59zeXAtJcsrNbhcoNzGXjF57XcMU5CRWyzUX6rpiw
 wVPlF9qj1g6fTwZ19bQH5lGFN3PRkGRtTQYZykgYbdBWo=

Am 06.02.24 um 19:08 schrieb Stefan Wahren:
> Hi Dave and Andrea,
>
> Am 06.02.24 um 17:31 schrieb Dave Stevenson:
>> Hi Stefan and Andrea
>>
>> On Mon, 5 Feb 2024 at 18:50, Stefan Wahren <wahrenst@gmx.net> wrote:
>>> Hi Andrea,
>>>
>>> [add Dave]
>>>
>>> Am 04.02.24 um 07:59 schrieb Andrea della Porta:
>>>> From: Phil Elwell <phil@raspberrypi.org>
>>>>
>>>> BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
>>>> to access the full 4GB of memory on a Pi 4.
>>>>
>>>> Cc: Phil Elwell <phil@raspberrypi.org>
>>>> Cc: Maxime Ripard <maxime@cerno.tech>
>>>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
>>> mainlining isn't that simple by sending just the downstream patches to
>>> the mailing list. In many cases there reasons why this hasn't been
>>> upstreamed yet.
>>>
>>> In my opinion just this feature is worth a separate patch series. In
>>> 2021 i already send an initial version, which tried to implement it
>>> in a
>>> cleaner & maintainabler way [1]. In the meantime Dave Stevenson from
>>> Raspberry Pi wrote that he also wanted to work on this. Maybe you want
>>> to work on this together?
>> Yes, I'm looking at reworking Stefan's series to work on Pi4 & Pi5 as
>> it's needed for HDMI audio (and other things) on those platforms which
>> I'm working to upstream.
>>
>> I was getting weirdness from the sdhci block when I was last looking
>> at it, so it was just proving a little trickier than first thought.
>> Hopefully I'll get some time on it in the next couple of weeks.
> i must confess that my series was just a draft to see that the general
> approach would be accepted. Yes, it's possible that there are issues :-(
>
> Maybe i can help you a little bit by taking care of first two patches
> (node name fix & YAML conversion)?
Forget about this, it's already done
>
> Regards
>> =C2=A0=C2=A0 Dave
>>
>>> [1] -
>>> https://lore.kernel.org/linux-arm-kernel/13ec386b-2305-27da-9765-8fa3a=
d71146c@i2se.com/T/
>>>
>


