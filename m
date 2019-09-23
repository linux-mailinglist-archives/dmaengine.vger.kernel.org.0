Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12892BB77B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2019 17:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfIWPGi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Sep 2019 11:06:38 -0400
Received: from mx1.emlix.com ([188.40.240.192]:42384 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfIWPGi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Sep 2019 11:06:38 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 9141A5FD5D;
        Mon, 23 Sep 2019 17:06:34 +0200 (CEST)
Subject: Re: [PATCH v5 0/3] Fix UART DMA freezes for i.MX SOCs
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fugang.duan@nxp.com, jlu@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, vkoul@kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        Robin Gong <yibin.gong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
References: <20190923135808.815-1-philipp.puschmann@emlix.com>
 <CAHCN7xJL_x1ryOoNW+R2hOZ9dMFem9wni8Uo8QOA3wxpzKLbqQ@mail.gmail.com>
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <2443c553-c593-2f23-4cca-c2f03676adc9@emlix.com>
Date:   Mon, 23 Sep 2019 17:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7xJL_x1ryOoNW+R2hOZ9dMFem9wni8Uo8QOA3wxpzKLbqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Adam,

Am 23.09.19 um 16:55 schrieb Adam Ford:
> On Mon, Sep 23, 2019 at 8:58 AM Philipp Puschmann
> <philipp.puschmann@emlix.com> wrote:
>>
>> For some years and since many kernel versions there are reports that
>> RX UART DMA channel stops working at one point. So far the usual
>> workaround was to disable RX DMA. This patches fix the underlying
>> problem.
>>
>> When a running sdma script does not find any usable destination buffer
>> to put its data into it just leads to stopping the channel being
>> scheduled again. As solution we manually retrigger the sdma script for
>> this channel and by this dissolve the freeze.
>>
>> While this seems to work fine so far, it may come to buffer overruns
>> when the channel - even temporary - is stopped. This case has to be
>> addressed by device drivers by increasing the number of DMA periods.
>>
>> This patch series was tested with the current kernel and backported to
>> kernel 4.15 with a special use case using a WL1837MOD via UART and
>> provoking the hanging of UART RX DMA within seconds after starting a
>> test application. It resulted in well known
>>   "Bluetooth: hci0: command 0x0408 tx timeout"
>> errors and complete stop of UART data reception. Our Bluetooth traffic
>> consists of many independent small packets, mostly only a few bytes,
>> causing high usage of periods.
>>
> 
> Using the 4.19.y branch, this seems to working just fine for me with an i.MX6Q
> with WL1837MOD Bluetooth connected to UART2.  I am still seeing some
> timeouts with 5.3, but I'm going to continue to run some tests.

Thanks for testing.
With my local setup i still have very few tx timeouts too. But i think they have a different
cause and especially different consequences. When the problem addressed by this series
appear you get a whole bunch of tx timeouts (and maybe errors from Bluetooth
layer) and monitoring received Bluetooth packets with hciconfig shows a
complete freeze of rx counter. Only resetting the hci_uart driver and the wl1837mon then helps.
With these patches applied the rx data shold still coming in even if a single or
multiple tx timeout error happen. I'm not sure where the error comes from and what the
consequences for the Bluetooth layer are.

Regards,
Philipp
> 
> Tested-by: Adam Ford <aford173@gmail.com> #imx6q w/ 4.19 Kernel
> 
>> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
>> Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
>>
>> ---
>>
>> Changelog v5:
>>  - join with patch version from Jan Luebbe
>>  - adapt comments and patch descriptions
>>  - add Reviewed-by
>>
>> Changelog v4:
>>  - fixed the fixes tags
>>
>> Changelog v3:
>>  - fixes typo in dma_wmb
>>  - add fixes tags
>>
>> Changelog v2:
>>  - adapt title (this patches are not only for i.MX6)
>>  - improve some comments and patch descriptions
>>  - add a dma_wb() around BD_DONE flag
>>  - add Reviewed-by tags
>>  - split off  "serial: imx: adapt rx buffer and dma periods"
>>
>> Philipp Puschmann (3):
>>   dmaengine: imx-sdma: fix buffer ownership
>>   dmaengine: imx-sdma: fix dma freezes
>>   dmaengine: imx-sdma: drop redundant variable
>>
>>  drivers/dma/imx-sdma.c | 37 +++++++++++++++++++++++++++----------
>>  1 file changed, 27 insertions(+), 10 deletions(-)
>>
>> --
>> 2.23.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
