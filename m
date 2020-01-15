Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1DE13BBBD
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 10:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAOJA5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 04:00:57 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19295 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAOJA5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 04:00:57 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1ed4b30000>; Wed, 15 Jan 2020 01:00:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Jan 2020 01:00:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Jan 2020 01:00:56 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 09:00:53 +0000
Subject: Re: [PATCH v4 01/14] dmaengine: tegra-apb: Fix use-after-free
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-2-digetx@gmail.com>
 <4c1b9e48-5468-0c03-2108-158ee814eea8@nvidia.com>
 <1327bb21-0364-da26-e6ed-ff6c19df03e6@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e39ef31d-4cff-838a-0fc1-73a39a8d6120@nvidia.com>
Date:   Wed, 15 Jan 2020 09:00:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1327bb21-0364-da26-e6ed-ff6c19df03e6@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579078836; bh=paFyw96PHu2E+wS2cU56KHqIL7GZKeucrHRygiWtSb0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kXymcBJli9uYuViTVLVu7cY+j82mJiedus8XGrk1bQVmvcrGZ8DGbQTqW+ZWmt0wa
         JXeaTQYJxfjXPFTzXNgLMuJtKTItJZj5yxCp5pzUDkezwWXUWZimIODQdcpEKBEi9c
         nOp+gkiGZoSCoFwyElBmrWj0sjOyGGKCSv3loTuan7quNIUUQF+aM4ysEprwqsONN1
         10N3MhQ2jyXK87Mdw6bBIPb86QiPu01EloyPU1sGbuKfyXXFvK+JZQLHw7qJfZmKqu
         jTHFnsTQov/8beqHFx7RYVJY575dJj5AjNPGGM6UjMZw3MjM69Knp2q95VVNhPSwA5
         A8q/N8YfsTY5A==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 14/01/2020 20:33, Dmitry Osipenko wrote:
> 14.01.2020 18:09, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 12/01/2020 17:29, Dmitry Osipenko wrote:
>>> I was doing some experiments with I2C and noticed that Tegra APB DMA
>>> driver crashes sometime after I2C DMA transfer termination. The crash
>>> happens because tegra_dma_terminate_all() bails out immediately if pend=
ing
>>> list is empty, thus it doesn't release the half-completed descriptors
>>> which are getting re-used before ISR tasklet kicks-in.
>>
>> Can you elaborate a bit more on how these are getting re-used? What is
>> the sequence of events which results in the panic? I believe that this
>> was also reported in the past [0] and so I don't doubt there is an issue
>> here, but would like to completely understand this.
>>
>> Thanks!
>> Jon
>>
>> [0] https://lore.kernel.org/patchwork/patch/675349/
>>
>=20
> In my case it happens in the touchscreen driver during of the
> touchscreen's interrupt handling (in a threaded IRQ handler) + CPU is
> under load and there is other interrupts activity. So what happens here
> is that the TS driver issues one I2C transfer, which fails with
> (apparently bogus) timeout (because DMA descriptor is completed and
> removed from the pending list, but tasklet not executed yet), and then
> TS immediately issues another I2C transfer that re-uses the
> yet-incompleted descriptor. That's my understanding.

OK, but what is the exact sequence that it allowing it to re-use the
incompleted descriptor?

Thanks
Jon

--=20
nvpublic
