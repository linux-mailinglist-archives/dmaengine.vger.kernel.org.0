Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7A24C1D21
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 21:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbiBWU1h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 15:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbiBWU1g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 15:27:36 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF6643386
        for <dmaengine@vger.kernel.org>; Wed, 23 Feb 2022 12:27:07 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id MyDwnoius41cbMyDwni3p8; Wed, 23 Feb 2022 21:27:05 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 23 Feb 2022 21:27:05 +0100
X-ME-IP: 90.126.236.122
Message-ID: <ddf6010e-417d-8da7-8e11-1b4a55f92fff@wanadoo.fr>
Date:   Wed, 23 Feb 2022 21:26:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/16] Remove usage of the deprecated "pci-dma-compat.h"
 API
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     arnd@arndb.de, akpm@linux-foundation.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, davem@davemloft.net, airlied@linux.ie,
        vkoul@kernel.org, hao.wu@intel.com, trix@redhat.com,
        mdf@kernel.org, yilun.xu@intel.com, awalls@md.metrocast.net,
        mchehab@kernel.org, sathya.prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, mporter@kernel.crashing.org,
        alex.bou9@gmail.com, bhelgaas@google.com,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-media@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <YhXmQwvjMFPQFPUr@infradead.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YhXmQwvjMFPQFPUr@infradead.org>
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

Le 23/02/2022 à 08:46, Christoph Hellwig a écrit :
> Hi Christophe,
> 
> do you know what the state is in current linux-next?
> 
> I think we'll just want to queue up anything left at this point in the
> dma-mapping or PCI tree and get it done.
> 

Hi,

Patch 01, 04, 05, 06, 08, 09 have not reached -next yet.
They all still apply cleanly.

04 has been picked it up for inclusion in the media subsystem for 5.18.
The other ones all have 1 or more Reviewed-by:/Acked-by: tags.

Patch 16 must be resubmitted to add "#include <linux/dma-mapping.h>" in 
order not to break builds.


All the other patches have landed in -next.

CJ
