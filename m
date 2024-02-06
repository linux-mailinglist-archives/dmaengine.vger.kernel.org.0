Return-Path: <dmaengine+bounces-962-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982A184BCB6
	for <lists+dmaengine@lfdr.de>; Tue,  6 Feb 2024 19:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5526B284F54
	for <lists+dmaengine@lfdr.de>; Tue,  6 Feb 2024 18:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9E12B71;
	Tue,  6 Feb 2024 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ngeSN2ip"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208FEDF56;
	Tue,  6 Feb 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242941; cv=none; b=HuDN+zEcFc2oPvRAwxn8vo5+ZYT+DO61QymJCGHWQMGnoAclYCG1sVp5V/wCi3PuX7CT7AeuRkoe6yF4gytY+0cjY1A/kAu6SPE5Qe4lDNqsLkpEQmibiAp/Q1IQnMe8iNIqvLG54RXq2WwuU9a/dNHctf96WxNOD91ivgyJ0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242941; c=relaxed/simple;
	bh=RZqo/CCOLuo6/mBZDZJlacFlaFZNq+k1w2fQRKVHdgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEA4DHcPgOelw+qHkzjE4UE6e3le29WLsndUqx2wMiJccfMXI4g8Mu9r9+vkXK6QBhOD0Ofgn3yiCmcves5D3J6ouaFE6skBzgn+/g1q8t6ldVd/uA/WG/w75dMRjTdX17qhwIr9xc5D3+SIO7Gjl47XwbTlxgEtM+ASGzEk1Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ngeSN2ip; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707242921; x=1707847721; i=wahrenst@gmx.net;
	bh=RZqo/CCOLuo6/mBZDZJlacFlaFZNq+k1w2fQRKVHdgk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ngeSN2ipgNISfo3ot/k7BPYUYbWJackL55ol67WN3oPCxRHgg67/V5GYi49mZhBq
	 7BQV7UOQgxruT4ui1XmwxPJgGCzERjoEwsWmRp8P5jNuGt/9fE08vVGRfqai7lUuL
	 ibU9SraTHLohKoygGUiNntwezFw2pVqzugyGtudT7vkt6otrB+bvgVWQCuTDVK3xs
	 2/LfhZ93Oelz+MJ0F4E02dJeLKNyAt6DSGxW0S1f563OYd1N+/wgizHVqZJNmzSD8
	 JuOpdv3xd3DNVXySyPB2+O1OQBmYEuOWoyw3cMnt4bwb5fv6a7mFd3luX5kmSJujC
	 8bun/cAI0jJ4muvBCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1qlcPn2Eyc-00x5m8; Tue, 06
 Feb 2024 19:08:41 +0100
Message-ID: <42e760f9-8304-4237-bb68-54c98eb7fcb9@gmx.net>
Date: Tue, 6 Feb 2024 19:08:40 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] bcm2835-dma: Add proper 40-bit DMA support
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
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CAPY8ntCEvsTJwoEBYc7JsTaYfdMURhmytvvVMcLVNBkmdTNcZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:82iQlRV0DZeC1hAWFcigJgICSkiPyPuQqoLMtpl5EGz6/okZ3fE
 I6SidVufMLwq7EC1vruL05BJaE5u0q/VGaSys3AbvrQD8uxR2U+HsJwuTKDo5d3Jp5L3eMs
 HUDAajmfPFfluKH+FrQfUop7UA4q95fLfhJz9IwiXwrmlfh4WuldAkk0RfUs/XNMQIcSjPa
 K6Eu6Kwlz66lDe5rQyf1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rGYYoGkFhs8=;E2CkH0DchG7qHZki2J7Pqf6e/Y9
 O3nyAvJr4ZdrVhtDOWtSV0gngMgbdBULBSXrol6BvL01MoaQe4/QT9yCZm40aSu6voYAuZHIO
 ZqXjplQMVZnxpYbIzb7eL+FJY7vu/f32oMjjCIZRPrlwsdY32Axp8MVdGqWa06gCGB6xsW507
 sqOtxghlNUeAQg59SSY1fnDYY/QfXlwwnobXi9iX4C7ucy+ERlWp+RMZxgjtTA1Oy9NvL7tED
 dtXxZMfHZaMai1TCQ3Nndy2p4GxoryYiXRXeKeW2F+6Rd8i2XsY18iVP3bPjcCXr6nHHfHTd0
 TaKCmnryV8KOdpwH0W3bfmWtHfqbuFLyj4jiPp3VZpDRtWQP1nfh3/RabAxasiyYKqIhdM3T/
 bEaqIjAPBMGzYxnOqsMN36FdboKiQs9BdLAYag0tCRJZcCROQB9VGgEH2WQcX+t9UTK3e888Q
 cmnyjtwKGacbndniuFapznFbuuCq8eKcR57rg2i6AyMoLORYL9CL7KdJgsSRyq/ki4LFptnR/
 BdhCGGaSB9jvcNg6SH2kkaw77h9ilJr88qHQtQ5LHAnL+vBkCLmwoHKYbv4MvdYL3gzt0Y/A+
 +7k0iHQhKzrsayGAPU2UG1YvmpWSSgZeQZ/zPikBWypK6QY70/lmVZDdmSnVf9rO2OfJ+aZpB
 OLCSJWUfFGysEyLGopIqhGKGFuWa1oXXQeIKNyRnb+a2x0Rnmes8J/UljrIb4Gnp3pWMV39I5
 LlYEI0RdK130rVHsUe91Z4I2liPtv5MUTVEfkhIEsBA88plryq3ZRuCfQOBnIO59uM49xbNhm
 xB8k7jy4E6JboWXln/ta28Nm31V+2fM/B0X+WTMNC0zPU=

Hi Dave and Andrea,

Am 06.02.24 um 17:31 schrieb Dave Stevenson:
> Hi Stefan and Andrea
>
> On Mon, 5 Feb 2024 at 18:50, Stefan Wahren <wahrenst@gmx.net> wrote:
>> Hi Andrea,
>>
>> [add Dave]
>>
>> Am 04.02.24 um 07:59 schrieb Andrea della Porta:
>>> From: Phil Elwell <phil@raspberrypi.org>
>>>
>>> BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
>>> to access the full 4GB of memory on a Pi 4.
>>>
>>> Cc: Phil Elwell <phil@raspberrypi.org>
>>> Cc: Maxime Ripard <maxime@cerno.tech>
>>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
>> mainlining isn't that simple by sending just the downstream patches to
>> the mailing list. In many cases there reasons why this hasn't been
>> upstreamed yet.
>>
>> In my opinion just this feature is worth a separate patch series. In
>> 2021 i already send an initial version, which tried to implement it in =
a
>> cleaner & maintainabler way [1]. In the meantime Dave Stevenson from
>> Raspberry Pi wrote that he also wanted to work on this. Maybe you want
>> to work on this together?
> Yes, I'm looking at reworking Stefan's series to work on Pi4 & Pi5 as
> it's needed for HDMI audio (and other things) on those platforms which
> I'm working to upstream.
>
> I was getting weirdness from the sdhci block when I was last looking
> at it, so it was just proving a little trickier than first thought.
> Hopefully I'll get some time on it in the next couple of weeks.
i must confess that my series was just a draft to see that the general
approach would be accepted. Yes, it's possible that there are issues :-(

Maybe i can help you a little bit by taking care of first two patches
(node name fix & YAML conversion)?

Regards
>    Dave
>
>> [1] -
>> https://lore.kernel.org/linux-arm-kernel/13ec386b-2305-27da-9765-8fa3ad=
71146c@i2se.com/T/


