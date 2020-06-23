Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B83205265
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2020 14:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbgFWMZ1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Jun 2020 08:25:27 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8027 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbgFWMZ0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Jun 2020 08:25:26 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef1f4880001>; Tue, 23 Jun 2020 05:24:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 23 Jun 2020 05:25:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 23 Jun 2020 05:25:26 -0700
Received: from [10.26.75.236] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 12:25:22 +0000
Subject: Re: [PATCH] [v4] dmaengine: tegra210-adma: Fix runtime PM imbalance
 on error
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Kangjie Lu <kjlu@umn.edu>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200621054710.9915-1-dinghao.liu@zju.edu.cn>
 <44d7771e-5600-19c2-888a-dd226cbc4b50@nvidia.com>
 <CAMuHMdVu=Tm4UTN1GAc3_uy00UhYYJ7ZPyq1qPCXQ+iP3hksfg@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a1357f1f-63d9-93e9-ea7d-e594ba9fc219@nvidia.com>
Date:   Tue, 23 Jun 2020 13:25:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVu=Tm4UTN1GAc3_uy00UhYYJ7ZPyq1qPCXQ+iP3hksfg@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592915080; bh=/mxJgXkpwkrXVLzjqF5kjYdPo9eAp3xBgryscNpKjzY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aHCKS8W1gQCRe/AiErUzoJZrnE0vCWXqCiwH4pFs66T0K2DzlrPKMR5pIWRC+Nf7C
         +hVYiGlYPUipQ8Rvy7CnyPGW2RtyCaLbiKZUCbrQGaEuxUDthj0xBZCRo97Aq0YpiD
         QZV0zj6V8/TfDTfk2FZp0I2mpeSVg5fsFYTOYeocVkhzvUArcMPuBmd87Y7dzmJzpS
         tP9QWwSHEg1gfd7D/S/av6Z/7+k/O/54nvTUyebvv76/3R+XEosfOLJzZnNAUh4DqZ
         0JFvG1Bq77fr74oJAY6eV5DPUQsQhuL6ocIsLwU2xFhX3h6eJ+Np2FN2GiJVBtkAiZ
         IZ6+6wHXOJpDA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On 23/06/2020 13:08, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> More stirring in the cesspool ;-)

Ha! Indeed.

> On Tue, Jun 23, 2020 at 12:13 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>> On 21/06/2020 06:47, Dinghao Liu wrote:
>>> pm_runtime_get_sync() increments the runtime PM usage counter even
>>> when it returns an error code. Thus a pairing decrement is needed on
>>> the error handling path to keep the counter balanced.
>>
>> So you have not mentioned here why you are using _noidle and not _put.
>> Furthermore, in this patch [0] you are not using _noidle to fix the same
>> problem in another driver. We should fix this in a consistent manner
>> across all drivers, otherwise it leads to more confusion.
>>
>> Finally, Rafael mentions we should just use _put [0] and so I think we
>> should follow his recommendation.
>>
>> Jon
>>
>> [0] https://lkml.org/lkml/2020/5/21/601
> 
> "_noidle() is the simplest one and it is sufficient."
> https://lore.kernel.org/linux-i2c/CAJZ5v0i87NGcy9+kxubScdPDyByr8ypQWcGgBFn+V-wDd69BHQ@mail.gmail.com/

Good to know. This detail should be spelled out in the changelog so that
it is clear why we are using _noidle and not _put. I did take a look and
it did seem to handle the usage_count OK, but I was concerned if there
could be something else in the _put path that may get missed.

Anyway, I am fine with the change, but with an updated changelog on why
_noidle is being used.

> You never know what additional things the other put* variants
> will start doing in the future...

Hopefully not, as that would be a breakage of the API itself. From what
Rafael said that all _put calls should work and if at some point in the
future they don't, then that seems like a regression.

Jon

-- 
nvpublic
