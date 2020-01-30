Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB46B14E2CF
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 19:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgA3S6n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 13:58:43 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4738 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgA3S6n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 13:58:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3327540000>; Thu, 30 Jan 2020 10:58:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 10:58:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Jan 2020 10:58:42 -0800
Received: from [10.26.11.91] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 18:58:39 +0000
Subject: Re: [PATCH v6 12/16] dmaengine: tegra-apb: Clean up suspend-resume
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-13-digetx@gmail.com>
 <e787bee2-4b52-1643-b3a5-8c4e70f6fdca@nvidia.com>
 <394014f3-011a-d6b6-b5f2-f8c86834ec70@gmail.com>
 <ffd9dbd0-be74-7bb4-9ca9-a97ee8023fc2@gmail.com>
 <3d8f599d-a46f-a7e5-8816-e0c44e2aceff@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <08b6a1f7-3c4d-ce6a-0d00-450f7bd4eeb3@nvidia.com>
Date:   Thu, 30 Jan 2020 18:58:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3d8f599d-a46f-a7e5-8816-e0c44e2aceff@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580410708; bh=uuoNO3MXCVy5v51r78aV++s6e2wrHYCAZeI4MlBHlZU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=d5XnP8rbMyzgDwPK1HuueIvdvgFMwQkyaoyx4vv+ApUC9rbyZs1jNDNFcV8hbXQll
         zli8m0ljzOQmd3FFVwbMZGB6fEYPRjG87K4pgQ1rxHNYX7F5vuZQ+vWcQ8l7qAWeFa
         7L5vs8WtB17ZT5TtsFkqA0eR5sHCQxcuryPB0OIIDjKKr2SOYr2YSuJo1WQRWU7wnF
         E25HgsnI3ztx4QLHPQatWe79tfDugVuJixyZH1cp/Tb2gxAa360sxjtpx46fQ0DCGp
         diQRsyWbP9eUkOUleVu9qIS4O3wSolNAQSMrqfE68cxPtYn0MhOwpuNGoQENAc+lMG
         Dnt1I6UuLR6/g==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 30/01/2020 18:26, Dmitry Osipenko wrote:
> 30.01.2020 21:06, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> 30.01.2020 19:08, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> 30.01.2020 17:09, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>
>>>> On 30/01/2020 04:38, Dmitry Osipenko wrote:
>>>>> It is enough to check whether hardware is busy on suspend and to rese=
t
>>>>> it across of suspend-resume because channel's configuration is fully
>>>>> re-programmed on each DMA transaction anyways and because save-restor=
e
>>>>> of an active channel won't end up well without pausing transfer prior=
 to
>>>>> saving of the state (note that all channels shall be idling at the ti=
me of
>>>>> suspend, so save-restore is not needed at all).
>>>>
>>>> I guess if we ever wanted to support SNDRV_PCM_INFO_PAUSE for audio an=
d
>>>> support the pause callback, then saving and restoring the channels cou=
ld
>>>> be needed. Right now I believe that it will just terminate_all transfe=
rs
>>>> for audio on entering suspend. Any value in keeping this?
>>>
>>> Indeed, looks like [1] pauses DMA during suspend if SNDRV_PCM_INFO_PAUS=
E
>>> is supported.
>>>
>>> [1]
>>> https://elixir.bootlin.com/linux/v5.5/source/sound/core/pcm_dmaengine.c=
#L199
>>>
>>> So we'll need to save-restore context only if DMA is in a paused state
>>> during suspend, I'll adjust this patch to do that and will see if
>>> enabling SNDRV_PCM_INFO_PAUSE works.
>>
>> I started to look at it and found that the .device_pause() hook isn't
>> implemented by the driver. So, it's fine to remove the context's
>> save-restore for now.
>>
>> Jon, what about to keep this patch as-is? Later on I'll take a look at
>> implementing the proper pausing functionality and try to cleanup code a
>> bit further (remove the free list usage, etc).
>=20
> Ah, only T114+ supports the per-channel pausing. So, I won't care about
> implementing the device_pause(), let's leave it to somebody else :)

That's fine. We have lived with out it for this long.

Jon

--=20
nvpublic
