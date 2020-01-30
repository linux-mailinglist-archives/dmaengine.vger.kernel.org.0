Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E191014D8F3
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 11:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgA3Kdq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 05:33:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44572 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgA3Kdp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 05:33:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130103344euoutp012fda7244638b32d1fc6166dc9a36f3c4~uo59y134d1790317903euoutp01s
        for <dmaengine@vger.kernel.org>; Thu, 30 Jan 2020 10:33:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130103344euoutp012fda7244638b32d1fc6166dc9a36f3c4~uo59y134d1790317903euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580380424;
        bh=zt738+k6+0Rdq+813IS0Eqr//8ps4a98g4wNjOFXxbc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LeMANiLbLfXKWl8mC/9hndrD80FGCyZIFaEXxchLmsfAHlrd+7ZBaiEngi6wx58fC
         QoJDKqSBDPYWejVsbVQHCa2ltPE9bbdgoqcHfvVpurXiX68CQFGeZmxs6QQI4e+OPf
         k9tRmtuTkhO8LCnZerepysZCygaMmZBWmidpbYXg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130103344eucas1p17160ac2880219abd76036c07f6c9a1ac~uo59c3TS72809628096eucas1p1i;
        Thu, 30 Jan 2020 10:33:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 46.7B.60679.801B23E5; Thu, 30
        Jan 2020 10:33:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130103343eucas1p25027e7cdfb9b56faa0600ea7dc666e2e~uo59Ok2Uk3249332493eucas1p2n;
        Thu, 30 Jan 2020 10:33:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130103343eusmtrp131fa325ce36503e48c3d06577dc6e450~uo59Nzuxo0114601146eusmtrp1V;
        Thu, 30 Jan 2020 10:33:43 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-22-5e32b1086296
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DC.3C.08375.701B23E5; Thu, 30
        Jan 2020 10:33:43 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130103343eusmtip1b61a1361d76f8aebeeabd0444f7442a6~uo580jMAx0354603546eusmtip1G;
        Thu, 30 Jan 2020 10:33:43 +0000 (GMT)
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and
 slaves
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ab83c4e0-87d2-c60e-afa7-4549ffb15397@samsung.com>
Date:   Thu, 30 Jan 2020 11:33:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXds2HuBAnLXmLVaCWKX77iZGvNSnD35-ysY9AnG9TKMw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87ocG43iDF7NYbWYPvUCo8XqqX9Z
        LebOnsRo8ezWXiaLy7vmsFlsffmOyWLnnRPMDuweE8/qeize85LJY9OqTjaPQ4c7GD0+b5IL
        YI3isklJzcksSy3St0vgyjhz9SxTwQXxis3nFjA1MG4R7mLk5JAQMJG4+qKDrYuRi0NIYAWj
        xKLfR6GcL4wSW3fPYIVwPjNKzFpyjw2mpeXWB2aIxHJGieOv/kI5bxkl1m56CVYlLBAise9c
        O2MXIweHiICuxJyfTCA1zAIdTBJLtmwDq2ETMJToetsFZvMK2EncPX+JCcRmEVCV6G6YxQhi
        iwrEStxfPZURokZQ4uTMJywgNqdAoETnyS9gvcwC8hLNW2czQ9jiEreezAdbJiGwjV3i/+Wd
        jBBnu0hse/MIyhaWeHV8CzuELSNxenIPC0RDM6PEw3Nr2SGcHkaJy00zoDqsJe6c+8UG8g6z
        gKbE+l36IKaEgKNE4+1ICJNP4sZbQYgb+CQmbZvODBHmlehoE4KYoSYx6/g6uK0HL1xinsCo
        NAvJZ7OQfDMLyTezENYuYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZiCTv87/mUH
        464/SYcYBTgYlXh4NTYYxQmxJpYVV+YeYpTgYFYS4RV1NYwT4k1JrKxKLcqPLyrNSS0+xCjN
        waIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgVFcPszEqtI+vcFallV55/W53hm6quVJ725r
        KD48dGvmst3FWyTv/lGOi0xZNk+eveKUlGuqeMHh2/1/ufwCr0h8OaoYdvjFxqgoM6d5vB1x
        N7w+FTwVXX/jDH9ap0NJrlKzatCC/pm5F9yeCVtZhXivKN2gd4y7VkA0aj7Hut5aX+8QrssG
        SizFGYmGWsxFxYkALri8bD0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7rsG43iDO7vN7SYPvUCo8XqqX9Z
        LebOnsRo8ezWXiaLy7vmsFlsffmOyWLnnRPMDuweE8/qeize85LJY9OqTjaPQ4c7GD0+b5IL
        YI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQyzhz
        9SxTwQXxis3nFjA1MG4R7mLk5JAQMJFoufWBuYuRi0NIYCmjRF9LJwtEQkbi5LQGVghbWOLP
        tS42iKLXjBIf+n4wgSSEBUIk9p1rZ+xi5OAQEdCVmPOTCaSGWaCDSWLz6o/sIDVCAj1MEv9O
        14HYbAKGEl1vQQZxcvAK2EncPX8JbA6LgKpEd8MsRhBbVCBW4v+Za1A1ghInZz4BO4hTIFCi
        8+QXsDizgJnEvM0PmSFseYnmrbOhbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4
        Nz232FCvODG3uDQvXS85P3cTIzDmth37uXkH46WNwYcYBTgYlXh4NTYYxQmxJpYVV+YeYpTg
        YFYS4RV1NYwT4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgOsgriTc0NTS3sDQ0NzY3NrNQ
        EuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cAYkDlpZ0BG4PySL0fvlSetcTq7z0ItYj1jyvKo
        l3m3NmbkuId7Rb9Xl3PJqbt96wZvwr11VpVRZR9kTtfWr+z6f/iBTUtM1tqv/cf26LrdfePy
        cmKTv7jv+/VSbFZGqjWrov+9yMpiV6kP6GHIjvafvnEGQ+kWzhbzPcKls89Jn4y6uSZq+2Ml
        luKMREMt5qLiRADnFJyezwIAAA==
X-CMS-MailID: 20200130103343eucas1p25027e7cdfb9b56faa0600ea7dc666e2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200129174723eucas1p1fe4f76325f463fc9e3645ce18740d2eb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200129174723eucas1p1fe4f76325f463fc9e3645ce18740d2eb
References: <CGME20200129174723eucas1p1fe4f76325f463fc9e3645ce18740d2eb@eucas1p1.samsung.com>
        <20200117153056.31363-1-geert+renesas@glider.be>
        <fde812a2-aea6-c16e-5ed7-ab5195b1259f@samsung.com>
        <CAMuHMdXds2HuBAnLXmLVaCWKX77iZGvNSnD35-ysY9AnG9TKMw@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On 30.01.2020 09:30, Geert Uytterhoeven wrote:
> On Wed, Jan 29, 2020 at 6:47 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 17.01.2020 16:30, Geert Uytterhoeven wrote:
>>> Currently it is not easy to find out which DMA channels are in use, and
>>> which slave devices are using which channels.
>>>
>>> Fix this by creating two symlinks between the DMA channel and the actual
>>> slave device when a channel is requested:
>>>     1. A "slave" symlink from DMA channel to slave device,
>>>     2. A "dma:<name>" symlink slave device to DMA channel.
>>> When the channel is released, the symlinks are removed again.
>>> The latter requires keeping track of the slave device and the channel
>>> name in the dma_chan structure.
>>>
>>> Note that this is limited to channel request functions for requesting an
>>> exclusive slave channel that take a device pointer (dma_request_chan()
>>> and dma_request_slave_channel*()).
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Tested-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
>> This patch breaks booting on almost all Exynos based boards:
>>
>> https://lore.kernel.org/linux-samsung-soc/20200129161113.GE3928@sirena.org.uk/T/#u
> Sorry for the breakage.

No problem, that's why we have linux-next.

>> I've already sent a fix:
>>
>> https://protect2.fireeye.com/url?k=797fc496-24ab78fe-797e4fd9-0cc47a3356b2-edd084a6ee90e98a&u=https://lkml.org/lkml/2020/1/29/498
> Thanks a lot!
>
>> BTW, this patch reminds me some of my earlier work:
>>
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1329778.html
>>
>> I had similar need to keep a client's struct device pointer for every
>> requested channel, but it turned out to be much more complicated than
>> I've initially thought. I've abandoned that, due to lack of time, but
>> maybe some of that discussion and concerns are still valid (I hope that
>> links to earlier versions are still working)...
> Oh right, Runtime PM for DMA channels.
>
> As several DMA calls can be made from atomic context, probably the API
> should be split in a non-atomic and an atomic part, cfr. the difference
> between clk_prepare() and clk_enable().  Still, DMA slave drivers would need
> to be modified, to call the "prepare" to make use of this...

Well, I'm not a big fan for introducing this 2-levels of operation 
(prepare/enable). In most typical designs dmaengines have to operate 
from the atomic context anyway. I've made a workaround for that using 
device links. Usually dmaengine runtime PM can simply follow the runtime 
PM state of its client (master?) device. The main problem that time was 
to reliably find the device which requested the given channel. If you 
have some spare time, please read the thread and the discussions in the 
previous versions. This might be a bit related to the devices you create 
the symlinks.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

