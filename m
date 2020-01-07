Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB55A132E94
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jan 2020 19:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAGSio (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jan 2020 13:38:44 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15962 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgAGSin (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jan 2020 13:38:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e14d0030001>; Tue, 07 Jan 2020 10:37:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 10:38:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 10:38:42 -0800
Received: from [10.26.11.139] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 18:38:40 +0000
Subject: Re: [PATCH v3 09/13] dmaengine: tegra-apb: Remove runtime PM usage
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200106011708.7463-1-digetx@gmail.com>
 <20200106011708.7463-10-digetx@gmail.com>
 <f63a68cf-bb9d-0e79-23f3-233fc97ca6f9@nvidia.com>
 <fd6215ac-a646-4e13-ee22-e815a69cd099@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <01660250-0489-870a-6f0e-d74c5041e8e3@nvidia.com>
Date:   Tue, 7 Jan 2020 18:38:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fd6215ac-a646-4e13-ee22-e815a69cd099@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578422275; bh=1vkKMIjMhiXQH/0LKlvaioSuV7wR0KaWYwmiXi110ng=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JpEHXUhwxDD57ebL8Vk3Fj6LL/ZZeLR8kkPdEbWH3mCnB2Qct+tiBOy5Hc29R4+6A
         UDdkbrs8GpnvjqHdr7QjBUWZJz0ZZhfL3Bo4FTgw2BlxRuoBW1bML6YjtYMyZVTebd
         oVz3uNg5LnikzYQNaV+u30O2HtwKRJw4F7HiUL10gv10Iwbxmk81bfsJprnlN/TZ0c
         2zx+7X02oXd7CGaJ0bg/G0h4vwdwlwKAUFxNTbNWnw1eS0cqrvWtV70MmO4hD2sxP2
         BpMVnSwD9T9Q9dc1g0Yibi+cc0EjJle6gVznV3x0RfZ/USMWyDa1sCd891QqWs+pjM
         GibEYhE7xVfmQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 07/01/2020 17:12, Dmitry Osipenko wrote:
> 07.01.2020 18:13, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 06/01/2020 01:17, Dmitry Osipenko wrote:
>>> There is no benefit from runtime PM usage for the APB DMA driver becaus=
e
>>> it enables clock at the time of channel's allocation and thus clock sta=
ys
>>> enabled all the time in practice, secondly there is benefit from manual=
ly
>>> disabled clock because hardware auto-gates it during idle by itself.
>>
>> This assumes that the channel is allocated during a driver
>> initialisation. That may not always be the case. I believe audio is one
>> case where channels are requested at the start of audio playback.
>=20
> At least serial, I2C, SPI and T20 FUSE are permanently keeping channels
> allocated, thus audio is an exception here. I don't think that it's
> practical to assume that there is a real-world use-case where audio
> driver is the only active DMA client.
>=20
> The benefits of gating the DMA clock are also dim, do you have any
> power-consumption numbers that show that it's really worth to care about
> the clock-gating?

No, but at the same time, I really don't see the point in this. In fact,
I think it is a step backwards. If we wanted to only enable clocks while
DMA channels are active we could. So I request you drop this.

Jon

--=20
nvpublic
