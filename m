Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0F3472FA8
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbhLMOnh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 13 Dec 2021 09:43:37 -0500
Received: from aposti.net ([89.234.176.197]:52318 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239684AbhLMOng (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Dec 2021 09:43:36 -0500
Date:   Mon, 13 Dec 2021 14:43:26 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 0/6] dmaengine: jz4780: Driver updates v2
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, list@opendingux.net,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <E8624R.KQNTUQINN6QO3@crapouillou.net>
In-Reply-To: <YbbmqI6MHSwZTfIc@matsya>
References: <20211206174259.68133-1-paul@crapouillou.net>
        <YbbmqI6MHSwZTfIc@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



Le lun., déc. 13 2021 at 11:52:32 +0530, Vinod Koul <vkoul@kernel.org> 
a écrit :
> On 06-12-21, 17:42, Paul Cercueil wrote:
>>  Hi Vinod,
>> 
>>  A small set of updates to the dma-jz4780 driver.
>> 
>>  It adds support for the MDMA/BDMA engines in the JZ4760(B) and 
>> JZ4770
>>  SoCs, which are just regular cores with less channels.
>> 
>>  It also adds support for bidirectional channels, so that devices 
>> that
>>  only do half-duplex transfers can request a single DMA channel for 
>> both
>>  directions.
> 
> Applied, thanks

Thanks!
-Paul


