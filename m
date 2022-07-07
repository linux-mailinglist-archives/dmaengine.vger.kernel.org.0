Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA328569D61
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 10:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiGGIYp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiGGIYS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 04:24:18 -0400
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 01:24:05 PDT
Received: from router.aksignal.cz (router.aksignal.cz [62.44.4.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E6E4D169
        for <dmaengine@vger.kernel.org>; Thu,  7 Jul 2022 01:24:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 665AB4773C;
        Thu,  7 Jul 2022 10:15:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id MvI5j14HT0nq; Thu,  7 Jul 2022 10:15:49 +0200 (CEST)
Received: from [172.28.0.3] (unknown [193.150.13.224])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id D13464773B;
        Thu,  7 Jul 2022 10:15:48 +0200 (CEST)
Message-ID: <204e262a-61b6-34de-1c2b-07f9ed832f24@aksignal.cz>
Date:   Thu, 7 Jul 2022 10:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Subject: [bug] atmel_serial RS485 TX to RX switching
To:     ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
References: <0f560987-151f-b844-e5b4-a3a10c8d46a8@aksignal.cz>
Content-Language: cs
In-Reply-To: <0f560987-151f-b844-e5b4-a3a10c8d46a8@aksignal.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ping...

Hi everybody,
I found maybe a "bug":
kernel 5.17 on at91sam9g25 running at 400MHz usart configured in devtree to "linux,rs485-enabled-at-boot-time" is RX disabled during TX. This would be OK, but when TX is done, enabling RX takes too long (sometimes up to 500us or even more), this results in not capturing data answered from remote. RTS signal switching direction works as expected just after last stop bit.
