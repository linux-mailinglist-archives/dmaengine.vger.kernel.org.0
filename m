Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E41478FF
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 08:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgAXHat (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jan 2020 02:30:49 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53954 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgAXHat (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Jan 2020 02:30:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00O7UgH4116840;
        Fri, 24 Jan 2020 01:30:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579851042;
        bh=fwxS2W+1ZFB+/kTUBBZJRc5qB3L808Q64mTzFJjeHn8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XJGwy4YIdXgSZk88O/d8FgdrO9f8V34sMnIWgUjqUYAl0K8aJBreAXyTR3TSBXm+S
         gJ88SFhdSEj+aFTqP1QRtyL6zJZO21RqQ4lK/CgsVVzKU6UbxJE4gUtQWGkXKiOY5d
         tkKMuPCkzdsMqZNJJFNsJKCnIr9/AOWXFg5IqHv8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00O7UgZv124740;
        Fri, 24 Jan 2020 01:30:42 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 24
 Jan 2020 01:30:41 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 24 Jan 2020 01:30:41 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00O7Ud4h086929;
        Fri, 24 Jan 2020 01:30:39 -0600
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and
 slaves
To:     Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200117153056.31363-1-geert+renesas@glider.be>
 <d2b669e7-a5d4-20ec-5b54-103b71df7407@ti.com>
 <CAMuHMdVzQCWvH-LJ9ME5dRyafudZBHQLaJQzkSCPnughv_q2aA@mail.gmail.com>
 <1cdc4f71-f365-8c9e-4634-408c59e6a3f9@ti.com>
 <CAMuHMdU=-Eo29=DQmq96OegdYAvW7Vw9PpgNWSTfjDWVF5jd-A@mail.gmail.com>
 <f7bbb132-1278-7030-7f40-b89733bcbd83@ti.com>
 <CAMuHMdXDiwTomiKp8Kaw0NvMNpg78-M88F0mNTWBOz5MLE4LtQ@mail.gmail.com>
 <20200122094002.GS2841@vkoul-mobl> <20200124061359.GF2841@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <876eb72f-db74-86b5-5f2c-7fc9a5252421@ti.com>
Date:   Fri, 24 Jan 2020 09:31:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200124061359.GF2841@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod, Geert,

On 24/01/2020 8.13, Vinod Koul wrote:
> On 22-01-20, 15:10, Vinod Koul wrote:
> 
>> I like the idea of adding this in debugfs and giving more info, I would
>> actually love to add bytes_transferred and few more info (descriptors
>> submitted etc) to it...
>>
>>>> This way we will have all the information in one place, easy to look up
>>>> and you don't need to manage symlinks dynamically, just check all
>>>> channels if they have slave_device/name when they are in_use (in_use w/o
>>>> slave_device is 'non slave')
>>>>
>>>> Some drivers are requesting and releasing the DMA channel per transfer
>>>> or when they are opened/closed or other variations.
>>>>
>>>>> What do other people think?
>>>
>>> Vinod: do you have some guidance for your minions? ;-)
>>
>>
>> That said, I am not against merging this patch while we add more
>> (debugfs)... So do my minions agree or they have better ideas :-)
> 
> So no new ideas, I am going to apply this and queue for 5.6, something
> is better than nothing.

My only issue with the symlink is that it is created/removed on some
setups quite frequently as they request/release channel per transfer or
open/close.
It might be a small hit in performance, but it is going to be for them.

> And I am looking forward for debugfs to give better picture, volunteers?

Well, I still feel that the debugfs can give better view in one place
and in production it can be disabled to save few bytes per channel and
code is not complied in.

If we have the debugfs we can remove some of the sysfs devices files
probably.

gpiolib have a nice implementation for us to lift and adapt.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
