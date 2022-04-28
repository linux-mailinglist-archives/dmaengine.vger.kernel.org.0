Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8702B51302D
	for <lists+dmaengine@lfdr.de>; Thu, 28 Apr 2022 11:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiD1Jtv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Apr 2022 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346151AbiD1JWT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Apr 2022 05:22:19 -0400
X-Greylist: delayed 610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Apr 2022 02:19:03 PDT
Received: from router.aksignal.cz (router.aksignal.cz [62.44.4.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95616D1B9
        for <dmaengine@vger.kernel.org>; Thu, 28 Apr 2022 02:19:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 8ED4243F7B;
        Thu, 28 Apr 2022 11:08:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id PanPl9nclkCA; Thu, 28 Apr 2022 11:08:50 +0200 (CEST)
Received: from [172.25.161.48] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 9FC5443F79;
        Thu, 28 Apr 2022 11:08:49 +0200 (CEST)
Message-ID: <611a4f8c-917e-a0ba-c5d9-25651afa2a04@aksignal.cz>
Date:   Thu, 28 Apr 2022 11:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Subject: atmel usart and dma tx
To:     ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
References: <0f560987-151f-b844-e5b4-a3a10c8d46a8@aksignal.cz>
Content-Language: en-US
In-Reply-To: <0f560987-151f-b844-e5b4-a3a10c8d46a8@aksignal.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi everybody,
with kernel 5.17, at91sam9g25 running at 400MHz I discovered drop outs 
while I write data (64 to 128B) to ttyS by one call of write(). At speed 
230400 or 115200 Baud. It is not transmitted at once, there are random 
spaces long 200us to 1ms. It should use DMA so I think it could be 
transmitted at once.
Is there everything OK with DMA or some special setting needed?

dmesg:
[    1.636666] bus: 'platform': __driver_probe_device: matched device 
f801c000.serial with driver at91_usart_mode
[    1.636666] bus: 'platform': really_probe: probing driver 
at91_usart_mode with device f801c000.serial
[    1.636666] pinctrl-at91 ahb:apb:pinctrl@fffff400: usart0-0: 2 0:0
[    1.636666] pinctrl-at91 ahb:apb:pinctrl@fffff400: maps: function 
usart0 group usart0-0 num 3
[    1.636666] pinctrl-at91 ahb:apb:pinctrl@fffff400: usart0_rts-0: 1 0:2
[    1.636666] pinctrl-at91 ahb:apb:pinctrl@fffff400: maps: function 
usart0 group usart0_rts-0 num 2
[    1.636666] pinctrl-at91 ahb:apb:pinctrl@fffff400: found group 
selector 4 for usart0-0
[    1.636666] pinctrl-at91 ahb:apb:pinctrl@fffff400: found group 
selector 5 for usart0_rts-0
[    1.636666] at91_usart_mode f801c000.serial: no init pinctrl state
[    1.636666] pinctrl-at91 ahb:apb:pinctrl@fffff400: enable function 
usart0 group usart0-0
[    1.636666] pinctrl-at91 ahb:apb:pinctrl@fffff400: enable function 
usart0 group usart0_rts-0
[    1.639999] at91_usart_mode f801c000.serial: no sleep pinctrl state
[    1.643333] at91_usart_mode f801c000.serial: no idle pinctrl state
[    1.643333] Registering platform device 'atmel_usart_serial.1.auto'. 
Parent at f801c000.serial
[    1.643333] device: 'atmel_usart_serial.1.auto': device_add
[    1.643333] bus: 'platform': add device atmel_usart_serial.1.auto
[    1.643333] bus: 'platform': __driver_probe_device: matched device 
atmel_usart_serial.1.auto with driver atmel_usart_serial
[    1.643333] bus: 'platform': really_probe: probing driver 
atmel_usart_serial with device atmel_usart_serial.1.auto
[    1.643333] atmel_usart_serial atmel_usart_serial.1.auto: no of_node; 
not parsing pinctrl DT
[    1.643333] atmel_usart_serial atmel_usart_serial.1.auto: no default 
pinctrl state
[    1.643333] atmel_usart_serial atmel_usart_serial.1.auto: GPIO lookup 
for consumer rs485-term
[    1.643333] atmel_usart_serial atmel_usart_serial.1.auto: using 
device tree for GPIO lookup
[    1.646666] atmel_usart_serial atmel_usart_serial.1.auto: using 
lookup tables for GPIO lookup
[    1.646666] atmel_usart_serial atmel_usart_serial.1.auto: No GPIO 
consumer rs485-term found
[    1.649999] atmel_usart_serial.1.auto: ttyS2 at MMIO 0xf801c000 (irq 
= 24, base_baud = 8333333) is a ATMEL_SERIAL
[    1.656666] driver: 'atmel_usart_serial': driver_bound: bound to 
device 'atmel_usart_serial.1.auto'
[    1.656666] bus: 'platform': really_probe: bound device 
atmel_usart_serial.1.auto to driver atmel_usart_serial
[    1.656666] driver: 'at91_usart_mode': driver_bound: bound to device 
'f801c000.serial'
[    1.656666] bus: 'platform': really_probe: bound device 
f801c000.serial to driver at91_usart_mode

[   41.606666] atmel_usart_serial atmel_usart_serial.1.auto: using 
dma0chan6 for rx DMA transfers
[   41.613333] atmel_usart_serial atmel_usart_serial.1.auto: using 
dma0chan7 for tx DMA transfers

With kernel 4.5 spaces are there too, but shorter and less frequent.
Thanks for any help,
Jiri
