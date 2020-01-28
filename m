Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD4D14BB9A
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 15:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgA1OCo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 09:02:44 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3868 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgA1OCo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 09:02:44 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e303ed00000>; Tue, 28 Jan 2020 06:01:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 28 Jan 2020 06:02:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 28 Jan 2020 06:02:42 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan
 2020 14:02:40 +0000
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
 <e39ef31d-4cff-838a-0fc1-73a39a8d6120@nvidia.com>
 <b0c85ca7-d8ac-5f9d-2c57-79543c1f9b5d@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5bbe9e3e-a64f-53be-e7f6-63e36cbae77d@nvidia.com>
Date:   Tue, 28 Jan 2020 14:02:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b0c85ca7-d8ac-5f9d-2c57-79543c1f9b5d@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580220113; bh=e88101xURco7N8b2552wZD76BEtwzmum1j/J+iogzf4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hCgUzPZfdk3rkBcA/XYgsDFdtwoXICKJxbQxxi54uG8pMCemvx2Ob2aCJEdVw/PB+
         SrevcGflaEXa2tvwIMHkXyPldcUBK1AwLgXyUK6rKxTZUlbW3p5jzh+Ri7taJWWKXC
         pPBqH+j+Y48XLUmGpAYZ39haiWtp+4zx6qSxFug0ZhB6hSt5uWiOM5y4g7Zf/isndj
         aFcoFXVMN3tJIg62ddjIAs/g/kAKCCJsS9y9YwLGqZDnBci5bNU7PsRrPIYyP/K1Um
         KidfDp+/0CZ3Y98FUr5KBmtAr8LzUqU9o1YIaKsYKDgSKtUoNfcllmf1DlQvRVQpgd
         sjuA6afJcYSRg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 16/01/2020 20:10, Dmitry Osipenko wrote:
> 15.01.2020 12:00, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 14/01/2020 20:33, Dmitry Osipenko wrote:
>>> 14.01.2020 18:09, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>
>>>> On 12/01/2020 17:29, Dmitry Osipenko wrote:
>>>>> I was doing some experiments with I2C and noticed that Tegra APB DMA
>>>>> driver crashes sometime after I2C DMA transfer termination. The crash
>>>>> happens because tegra_dma_terminate_all() bails out immediately if pe=
nding
>>>>> list is empty, thus it doesn't release the half-completed descriptors
>>>>> which are getting re-used before ISR tasklet kicks-in.
>>>>
>>>> Can you elaborate a bit more on how these are getting re-used? What is
>>>> the sequence of events which results in the panic? I believe that this
>>>> was also reported in the past [0] and so I don't doubt there is an iss=
ue
>>>> here, but would like to completely understand this.
>>>>
>>>> Thanks!
>>>> Jon
>>>>
>>>> [0] https://lore.kernel.org/patchwork/patch/675349/
>>>>
>>>
>>> In my case it happens in the touchscreen driver during of the
>>> touchscreen's interrupt handling (in a threaded IRQ handler) + CPU is
>>> under load and there is other interrupts activity. So what happens here
>>> is that the TS driver issues one I2C transfer, which fails with
>>> (apparently bogus) timeout (because DMA descriptor is completed and
>>> removed from the pending list, but tasklet not executed yet), and then
>>> TS immediately issues another I2C transfer that re-uses the
>>> yet-incompleted descriptor. That's my understanding.
>>
>> OK, but what is the exact sequence that it allowing it to re-use the
>> incompleted descriptor?
>=20
>    TDMA driver                      DMA Client
>=20
> 1.
>                                     dmaengine_prep()
>=20
> 2.
>    tegra_dma_desc_get()
>    dma_desc =3D kzalloc()
>    ...
>    tegra_dma_prep_slave_sg()
>    INIT_LIST_HEAD(&dma_desc->tx_list);
>    INIT_LIST_HEAD(&dma_desc->cb_node);
>    list_add_tail(sgreq->node,
>                  dma_desc->tx_list)
>=20
> 3.
>                                     dma_async_issue_pending()
>=20
> 4.
>    tegra_dma_tx_submit()
>    list_splice_tail_init(dma_desc->tx_list,
>                          tdc->pending_sg_req)
>=20
> 5.
>    tegra_dma_isr()
>    ...
>    handle_once_dma_done()
>    ...
>    sgreq =3D list_first_entry(tdc->pending_sg_req)
>    list_del(sgreq->node);
>    ...
>    list_add_tail(dma_desc->cb_node,
>                  tdc->cb_desc);
>    list_add_tail(dma_desc->node,
>                  tdc->free_dma_desc);

Isn't this the problem here, that we have placed this on the free list
before we are actually done?

It seems to me that there could still be a potential race condition
between the ISR and the tasklet running.

Jon

--=20
nvpublic
