Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5FB3B93
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2019 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733234AbfIPNlw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Sep 2019 09:41:52 -0400
Received: from mx1.emlix.com ([188.40.240.192]:49096 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733054AbfIPNlw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Sep 2019 09:41:52 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 186535FAD2;
        Mon, 16 Sep 2019 15:41:50 +0200 (CEST)
Subject: Re: [PATCH 0/4] Fix UART DMA freezes for iMX6
To:     Robin Gong <yibin.gong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
 <VE1PR04MB66383FAB08506993B305AC8D898C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <29d03762-866a-4fdc-eddb-e24f6e631412@emlix.com>
Date:   Mon, 16 Sep 2019 15:41:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB66383FAB08506993B305AC8D898C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am 16.09.19 um 10:02 schrieb Robin Gong:
> On 2019/9/11 Philipp Puschmann <philipp.puschmann@emlix.com> wrote:
>> For some years and since many kernel versions there are reports that RX
>> UART DMA channel stops working at one point. So far the usual workaround
>> was to disable RX DMA. This patches try to fix the underlying problem.
>>
>> When a running sdma script does not find any usable destination buffer to put
>> its data into it just leads to stopping the channel being scheduled again. As
>> solution we we manually retrigger the sdma script for this channel and by this
>> dissolve the freeze.
>>
>> While this seems to work fine so far a further patch in this series increases the
>> number of RX DMA periods for UART to reduce use cases running into such a
>> situation.
>>
>> This patch series was tested with the current kernel and backported to kernel
>> 4.15 with a special use case using a WL1837MOD via UART and provoking the
> Hi Philipp, Could your Bluetooth issue be reproduce on latest linux-next? Or did
> your kernel which can be reproduced include the below patch?
> 
> commit d1a792f3b4072bfac4150bb62aa34917b77fdb6d
> Author: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Date:   Wed Jun 25 13:00:33 2014 +0100
> 

Hi Robin, yes i have reproduced the Bluetooth issue with my test case with kernel 4.15
and the newest 5.3.0-rc8-next-20190915. My test-case includes several custom-boards
communicating via Bluetooth with each other. I see the error within seconds to few minutes.

>     Update imx-sdma cyclic handling to report residue
>> hanging of UART RX DMA within seconds after starting a test application.
>> It resulted in well known
>>   "Bluetooth: hci0: command 0x0408 tx timeout"
>> errors and complete stop of UART data reception. Our Bluetooth traffic
>> consists of many independent small packets, mostly only a few bytes, causing
>> high usage of periods.
>>
>>
>> Philipp Puschmann (4):
>>   dmaengine: imx-sdma: fix buffer ownership
>>   dmaengine: imx-sdma: fix dma freezes
>>   serial: imx: adapt rx buffer and dma periods
>>   dmaengine: imx-sdma: drop redundant variable
>>
>>  drivers/dma/imx-sdma.c   | 32 ++++++++++++++++++++++----------
>>  drivers/tty/serial/imx.c |  5 ++---
>>  2 files changed, 24 insertions(+), 13 deletions(-)
>>
>> --
>> 2.23.0
> 

-- 

Philipp Puschmann, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Goettingen HR B 3160
Geschaeftsführung: Heike Jordan, Dr. Uwe Kracke
Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source
