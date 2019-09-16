Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1945EB3BE0
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2019 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbfIPNzH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Sep 2019 09:55:07 -0400
Received: from mx1.emlix.com ([188.40.240.192]:49150 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbfIPNzH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Sep 2019 09:55:07 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id E92B15FAD2;
        Mon, 16 Sep 2019 15:55:04 +0200 (CEST)
Subject: Re: [PATCH 0/4] Fix UART DMA freezes for iMX6
To:     Fabio Estevam <festevam@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Vinod <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
 <CAOMZO5BKiZGF=iR071DaWLp-_7wTVJKLbOn3ihwPeVVSNF6nCg@mail.gmail.com>
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <2613a28d-d363-ee4e-679a-e7442e6fde48@emlix.com>
Date:   Mon, 16 Sep 2019 15:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BKiZGF=iR071DaWLp-_7wTVJKLbOn3ihwPeVVSNF6nCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fabio,

Am 12.09.19 um 20:23 schrieb Fabio Estevam:
> Hi Philipp,
> 
> Thanks for submitting these fixes.
> 
> On Wed, Sep 11, 2019 at 11:50 AM Philipp Puschmann
> <philipp.puschmann@emlix.com> wrote:
>>
>> For some years and since many kernel versions there are reports that
>> RX UART DMA channel stops working at one point. So far the usual workaround was
>> to disable RX DMA. This patches try to fix the underlying problem.
>>
>> When a running sdma script does not find any usable destination buffer to put
>> its data into it just leads to stopping the channel being scheduled again. As
>> solution we we manually retrigger the sdma script for this channel and by this
>> dissolve the freeze.
>>
>> While this seems to work fine so far a further patch in this series increases
>> the number of RX DMA periods for UART to reduce use cases running into such
>> a situation.
>>
>> This patch series was tested with the current kernel and backported to
>> kernel 4.15 with a special use case using a WL1837MOD via UART and provoking
>> the hanging of UART RX DMA within seconds after starting a test application.
>> It resulted in well known
>>   "Bluetooth: hci0: command 0x0408 tx timeout"
>> errors and complete stop of UART data reception. Our Bluetooth traffic consists
>> of many independent small packets, mostly only a few bytes, causing high usage
>> of periods.
>>
>>
>> Philipp Puschmann (4):
>>   dmaengine: imx-sdma: fix buffer ownership
>>   dmaengine: imx-sdma: fix dma freezes
>>   serial: imx: adapt rx buffer and dma periods
>>   dmaengine: imx-sdma: drop redundant variable
> 
> I have some suggestions:
> 
> 1. Please split this in two series: one for dmaengine and other one for serial
> 
> 2. Please add Fixes tag when appropriate, so that the fixes can be
> backported to stable kernels.
> 
> 3. Please Cc Robin and Andy
> 
> Thanks
> 

Thanks for the hints. I will apply them if the contentual feedback is positive.

p.s. Did you forget to add Andy? I don't see a Andy in the to- and cc-list.

