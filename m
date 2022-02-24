Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB154C346D
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 19:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiBXSQh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 13:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiBXSQg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 13:16:36 -0500
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577F6253179
        for <dmaengine@vger.kernel.org>; Thu, 24 Feb 2022 10:16:02 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id NIeQnn7MbrdkGNIeQnJ9oN; Thu, 24 Feb 2022 19:16:00 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 24 Feb 2022 19:16:00 +0100
X-ME-IP: 90.126.236.122
Message-ID: <b3e6a19b-caa0-f58a-1039-02b60b17ed21@wanadoo.fr>
Date:   Thu, 24 Feb 2022 19:15:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/16] Remove usage of the deprecated "pci-dma-compat.h"
 API
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        David Miller <davem@davemloft.net>,
        David Airlie <airlied@linux.ie>, Vinod Koul <vkoul@kernel.org>,
        hao.wu@intel.com, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        awalls@md.metrocast.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alex Bounine <alex.bou9@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        dmaengine@vger.kernel.org, linux-fpga@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <YhXmQwvjMFPQFPUr@infradead.org>
 <ddf6010e-417d-8da7-8e11-1b4a55f92fff@wanadoo.fr>
 <YhckzJp5/x9zW4uQ@infradead.org>
 <CAK8P3a23Pjm1Btc=mXX=vU4hkNiPqz3+o4=j0FuYKHB7KuMtPg@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAK8P3a23Pjm1Btc=mXX=vU4hkNiPqz3+o4=j0FuYKHB7KuMtPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Le 24/02/2022 à 08:07, Arnd Bergmann a écrit :
> On Thu, Feb 24, 2022 at 7:25 AM Christoph Hellwig <hch@infradead.org> wrote:
>> On Wed, Feb 23, 2022 at 09:26:56PM +0100, Christophe JAILLET wrote:
>>> Patch 01, 04, 05, 06, 08, 09 have not reached -next yet.
>>> They all still apply cleanly.
>>>
>>> 04 has been picked it up for inclusion in the media subsystem for 5.18.
>>> The other ones all have 1 or more Reviewed-by:/Acked-by: tags.
>>>
>>> Patch 16 must be resubmitted to add "#include <linux/dma-mapping.h>" in
>>> order not to break builds.
>> So how about this:  I'll pick up 1, 5,6,8 and 9 for the dma-mapping
>> tree.  After -rc1 when presumably all other patches have reached
>> mainline your resubmit one with the added include and we finish this
>> off?
> Sounds good to me as well.
>
>         Arnd

This is fine for me.
When all patches have reached -next, I'll re-submit the fixed 16th patch.


Thanks for your assistance for ending this long story :)

CJ

