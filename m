Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F83514E9E0
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2020 10:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgAaJCe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jan 2020 04:02:34 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3532 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgAaJCd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jan 2020 04:02:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e33ed140000>; Fri, 31 Jan 2020 01:02:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 31 Jan 2020 01:02:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 31 Jan 2020 01:02:33 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jan
 2020 09:02:30 +0000
Subject: Re: [PATCH v6 11/16] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-12-digetx@gmail.com>
 <2442aee7-2c2a-bacc-7be9-8eed17498928@nvidia.com>
 <0c766352-700a-68bf-cf7b-9b1686ba9ca9@gmail.com>
 <e72d00ee-abee-9ae2-4654-da77420b440e@nvidia.com>
 <cedbf558-b15b-81ca-7833-c94aedce5c5c@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <315241b5-f5a2-aaa0-7327-24055ff306c7@nvidia.com>
Date:   Fri, 31 Jan 2020 09:02:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cedbf558-b15b-81ca-7833-c94aedce5c5c@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580461332; bh=Nk8oL5vCVqBnXjso+RrvQFAoO6KnCVKaJeZz6xzsl/8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qwbWlB+gnELGMmzJ3pe37/TS2E+2LuhUkCNcL2NaqwxRWPmyf0QOxcCDraC4TSeph
         2OwXztiZS6lHCux/v7HxJml83AnYTVuRtM8iwSs20T8IttrgRmOadQ3yolR8JrncQW
         Nl6bEub3LzAAdS5zTBgW+F+YF1Nf4HUHZ4ai4JXCaREK6gvA0nqZGp0itxIKNuPkn/
         Fv89ucRjsykm+QCN/WyuUtv6i6jnq82zNI9qER0NvVauq/ycUrterl4c5/OckFzbwB
         Bl33XCYMzOHkkjeseXmMqimSW0RATB3T40SVn4o7QrriUpQlIlOTiI0khQaMwBmFNz
         ceIBhl8RhUEbQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 30/01/2020 20:04, Dmitry Osipenko wrote:

...

>>> The tegra_dma_stop() should put RPM anyways, which is missed in yours
>>> sample. Please see handle_continuous_head_request().
>>
>> Yes and that is deliberate. The cyclic transfers the transfers *should*
>> not stop until terminate_all is called. The tegra_dma_stop in
>> handle_continuous_head_request() is an error condition and so I am not
>> sure it is actually necessary to call pm_runtime_put() here.
> 
> But then tegra_dma_stop() shouldn't unset the "busy" mark.

True.

>>> I'm also finding the explicit get/put a bit easier to follow in the
>>> code, don't you think so?
>>
>> I can see that, but I was thinking that in the case of cyclic transfers,
>> it should only really be necessary to call the get/put at the beginning
>> and end. So in my mind there should only be two exit points which are
>> the ISR handler for SG and terminate_all for SG and cyclic.
> 
> Alright, I'll update this patch.

Hmmm ... I am wondering if we should not mess with that and leave how
you have it.

-- 
nvpublic
