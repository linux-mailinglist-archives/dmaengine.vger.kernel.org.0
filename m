Return-Path: <dmaengine+bounces-959-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBCD84A2B2
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 19:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515A21C24018
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11E481B3;
	Mon,  5 Feb 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="sFQxMOR4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33E481A7;
	Mon,  5 Feb 2024 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159065; cv=none; b=B+hk5lkv1VCtVW1toVlnwrP8CCg6lF/uKjDhoobz5MtqVdzf6AMwshZ69n+C985Uhlk2wpqaAkjLZzO+iVQgDqh0saB0pCSQDG/kxy9xnfJDmmYnxatW7gc3FXPna7KiRc4FnsMMzy7qMt8SmLSFt1xySWTY2kNaWykyj8tkX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159065; c=relaxed/simple;
	bh=upqk38mFRyStMDt//TKFKUs+Ve4eIcUYsnW4DHzmzkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQIOJx1gY8+aVlLyhdA9M7PHw/fcI1M/NeS3mmhlLDg5ynBFoeRol3XrwS4Tc2165icta4zTQ4TOUKl5BFCa6Fccwt57i5liR4syI1+Rvkh6OnZ5BKh9zJ3yfsY9MPINCapA5RH2EJsbf5ZwmC1su9DPs7ftkmnUpQ/AotNX5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=sFQxMOR4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707159046; x=1707763846; i=wahrenst@gmx.net;
	bh=upqk38mFRyStMDt//TKFKUs+Ve4eIcUYsnW4DHzmzkk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=sFQxMOR4lBl0ynbvvfjdFyUXoUBduM8Ehl7tP/w3+Pvv2H5tWP9HOgbJaNmUYiv4
	 vEqWsjTolDiOQTep2/mVIqE+YC/dhGt6luzH+2bQP87xzc8gDKsQKrzklkdwEq2xq
	 d5GTkmMXD0+izIxTGFLnRyWP6WGevCB8U7wr5Tat9Kye0ixp2XxD9wVspvmKBT9tF
	 dlJ/ledji93moAbdAd7181kKa05zKrc/I5TIMsUDHh6EJqg8ZCLGr7ugQAo4kaxIQ
	 iUZFYiaNMrKRMrZEP6rx1RBYZSKS/PvzLlNlISveAL6pgqYbaq8W/1miz4D1AVshX
	 6Xmc6mrW21IgcrYyUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1r4t2s3OHr-00gnns; Mon, 05
 Feb 2024 19:50:45 +0100
Message-ID: <8736c115-e11c-41ca-85eb-7cd19a205068@gmx.net>
Date: Mon, 5 Feb 2024 19:50:44 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] bcm2835-dma: Add proper 40-bit DMA support
Content-Language: en-US
To: Andrea della Porta <andrea.porta@suse.com>, Vinod Koul
 <vkoul@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, dmaengine@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <maxime@cerno.tech>, Dom Cobley <popcornmix@gmail.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1706948717.git.andrea.porta@suse.com>
 <eeb94204c30c2182f5ffd3ec083c04399ecdee32.1706948717.git.andrea.porta@suse.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <eeb94204c30c2182f5ffd3ec083c04399ecdee32.1706948717.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ii4aBdJ8kdgErTxKfxhBRtdB3pc6lV5wLFe/sAgqQ5AnKXMZvTW
 xMXVLy0c+DxqhOMD/AFraT41Xb+d8vrvLNpFSkzAbphr2r6bfz2o++cW6w/ZOIETZhPGbpK
 HVfc8q04onLVVVQobyvuO5MLTBJgtihAnVU6uGh4HPly9T2BsUgXwEhBT0jXewpkEhGaM28
 6krDfJfsk2uQxgToU+e0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DS/kBFCe9ac=;ckCKwTG7+MtxefQmnJZhkuFh7ss
 O720MPV88X09bbKqI6InGNRGhtgcHyUBJE7TIOss7ANe++XhLLqLvWoQq0PQFdkSHrxGw71bU
 M5PoH/MsQ6c68EP/wSYCVek/0vv+XGuPQcIAhLVSkLF8yeMcJtseJ06OhSMTvYhrWdOQmZj2m
 fUZQmhKPHUetv4/WsV0CUu+A349KmkzcmTb2873yNf2R+wnQwsG6nDDZBrY4WAUk1I5Bz4KaJ
 3cMyU59cK5O55RMeaFY7WheUG6d/ssP3Yisy0Du5CfVxxJe+HrDBboNvqlAP4p/qQYmNiv+Wd
 dSyYs0FkSLNCBFRhiu28i19+c806LwFwxNfLYasWkkbc7aVVofuRdmxSF9uTXWWWK0F7TooP+
 mC5bDPexDDH7W5ReXeNlcqL2QFebDUbCsKXDIP4BclZbxK4a06Z8lHsz+KcuBTYeh5abg4I5m
 DdYbrJxPNUUG2JwCWyAgUn/yqYOyDhe8nEicmS4m7JJtug/VKAu2VqOGPuySGB4w5pvy3Z/sI
 kcEc87Ljgu0E1f32gJ5NMxH4U0/+V0Rkn3YeSoPTKAQ/QFkSchR3ioBx/+n6qvdbSQrqbW3xH
 RsSFYP9SIssvnmFOsvotYufyd0zm1ncVv9ti0Gy8MLx/6jtAzvC+cQVTz9/A8tkxn7jSYzL+b
 o1rrkwDEbF57SZbG7EQaBHwDusI9BNne9Dyio3bsKC/r45YieRBM1SryTn0134LcsWBNw2dvZ
 V2e0j4joJhMIUt/OVbugJV3Yt2vW1Lpfn9iKNquEoyyOh1uOiWkWN4c7kY2iIJIPyY/6b7kbp
 HibJYq8+Tar8sMVbmVMcWgJz3UYHPYTBjDVCtffnl0Cxo=

Hi Andrea,

[add Dave]

Am 04.02.24 um 07:59 schrieb Andrea della Porta:
> From: Phil Elwell <phil@raspberrypi.org>
>
> BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
> to access the full 4GB of memory on a Pi 4.
>
> Cc: Phil Elwell <phil@raspberrypi.org>
> Cc: Maxime Ripard <maxime@cerno.tech>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
mainlining isn't that simple by sending just the downstream patches to
the mailing list. In many cases there reasons why this hasn't been
upstreamed yet.

In my opinion just this feature is worth a separate patch series. In
2021 i already send an initial version, which tried to implement it in a
cleaner & maintainabler way [1]. In the meantime Dave Stevenson from
Raspberry Pi wrote that he also wanted to work on this. Maybe you want
to work on this together?

[1] -
https://lore.kernel.org/linux-arm-kernel/13ec386b-2305-27da-9765-8fa3ad711=
46c@i2se.com/T/

