Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8514724C5CC
	for <lists+dmaengine@lfdr.de>; Thu, 20 Aug 2020 20:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHTSq7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Aug 2020 14:46:59 -0400
Received: from crapouillou.net ([89.234.176.41]:39054 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgHTSq6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 20 Aug 2020 14:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597949214; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oe+2PzmcXagWqtHK6eruhPSrZ2v5G13GkG9wQ/HZ1cs=;
        b=fYAtf8gwkPTmy7EvKXUOId6/yyPBKKLJcTIWeZXyz17Z/uNiLIfqfi27YdH2m5E5i/3iNw
        pNxIjqBMUz4Mq2KCE20q1qqzJ9eE5Zp7qa3vurFMyTH2YGOdmisubrVsRiR3o4N7xQ0CpZ
        slrqpspbtoTDQWy0l9X7GA2z5ySVo5A=
Date:   Thu, 20 Aug 2020 20:46:43 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] drivers/dma/dma-jz4780: Fix race condition between probe
 and irq handler
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     madhuparnabhowmik10@gmail.com, dan.j.williams@intel.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrianov@ispras.ru,
        ldv-project@linuxtesting.org
Message-Id: <VHLDFQ.HR10VPMY1GHD3@crapouillou.net>
In-Reply-To: <e1961c04-e2aa-fe3a-fb84-bb3b33fae5dc@metafoo.de>
References: <20200816072253.13817-1-madhuparnabhowmik10@gmail.com>
        <ZM2DFQ.KQQJYLJ02WTD3@crapouillou.net>
        <e1961c04-e2aa-fe3a-fb84-bb3b33fae5dc@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



Le jeu. 20 ao=FBt 2020 =E0 20:23, Lars-Peter Clausen <lars@metafoo.de> a=20
=E9crit :
> On 8/20/20 1:59 PM, Paul Cercueil wrote:
>> Hi,
>>=20
>> Le dim. 16 ao=FBt 2020 =E0 12:52, madhuparnabhowmik10@gmail.com a=20
>> =E9crit :
>>> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>>>=20
>>> In probe IRQ is requested before zchan->id is initialized which can=20
>>> be
>>> read in the irq handler. Hence, shift request irq and enable clock=20
>>> after
>>> other initializations complete. Here, enable clock part is not part=20
>>> of
>>> the race, it is just shifted down after request_irq to keep the=20
>>> error
>>> path same as before.
>>>=20
>>> Found by Linux Driver Verification project (linuxtesting.org).
>>>=20
>>> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>>=20
>> I don't think there is a race at all, the interrupt handler won't be=20
>> =7Fcalled before the DMA is registered.
>>=20
> From a purely formal verification perspective there is a bug. The=20
> interrupt could fire if i.e. the hardware is buggy or something. In=20
> general it is a good idea to not request the IRQ until all the=20
> resources that are used in the interrupt handler are properly set up.=20
> Even if you know that in practice the interrupt will never fire this=20
> early.
>=20

Fair enough, I'm fine with that, but the patch should be reworked so=20
that the clk_prepare_enable() call is not moved.

Cheers,
-Paul


