Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC5841504B9
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 11:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBCK7X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 05:59:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54844 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgBCK7X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 05:59:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 013AxGEI120579;
        Mon, 3 Feb 2020 04:59:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580727556;
        bh=cFprP7rRtLx9L/2ElRIu0VGanLcb4fT2ApIe8RsdSB4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=J4jYr3FYeGjT4adX/UUtxsz4F9kAvldlKUuHftUJXKn3hab4Lb+wNTodjyT4vzLof
         Jfe7EniYbbBXi0u+WeEMxi4DN4JoviNCj+bK7A1av6xsQBuhX7mlfEJLi4PnPtjXni
         S6Th1+nc2uFW2Tu4e0YrtU8fOFanSGiB4bO7b5ek=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 013AxGI0100404
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Feb 2020 04:59:16 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 3 Feb
 2020 04:59:15 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 3 Feb 2020 04:59:15 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 013AxEpW108348;
        Mon, 3 Feb 2020 04:59:14 -0600
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com>
Date:   Mon, 3 Feb 2020 12:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

On 03/02/2020 12.37, Andy Shevchenko wrote:
> On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
>> dma_request_slave_channel_reason() no longer have user in mainline, it
>> can be removed.
>>
>> Advise users of dma_request_slave_channel() and
>> dma_request_slave_channel_compat() to move to dma_request_slave_chan()
> 
> How? There are legacy ARM boards you have to care / remove before.
> DMAengine subsystem makes a p*s off decisions

The dma_slave_map support is added few years back for the legacy ARM
boards, because we do care.
daVinci, OMAP1, pxa, s3cx4xx and even m68k/coldfire moved over.

Imho it is confusing to have 4+ APIs to do the same thing, but in a
slightly different way.

> without taking care of
> (I'm talking now about dma release callback, for example) end users.

I have been converting users in the background, but the _compat() is a
bit more problematic as I need to maintainers of those legacy platforms
to craft the map. If they care.

Obviously the APIs are not going to be removed if we have a single user
and if there is clearly a need for something the _compat() was doing and
it can not be done via the dma_slave_map, then rest assured there will
be a clean API to achieve just that.

> They will be scary for no reason.

There is a reason: to clean up the API to make it non confusing for the
users.
New drivers should not use the old API i new code and developers tend to
pick the API they use after a quick 'git grep dma_request_' and see what
the majority is using.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
