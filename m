Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FFF2B7C00
	for <lists+dmaengine@lfdr.de>; Wed, 18 Nov 2020 12:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgKRLAH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Wed, 18 Nov 2020 06:00:07 -0500
Received: from aposti.net ([89.234.176.197]:60144 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbgKRLAH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Nov 2020 06:00:07 -0500
Date:   Wed, 18 Nov 2020 10:59:48 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH RESEND 0/2] Add dmaengine bindings for the JZ4775 and
 =?UTF-8?Q?the=0D=0A?= X2000 SoCs.
To:     Vinod Koul <vkoul@kernel.org>
Cc:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        Zubair.Kakakhel@imgtec.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Message-Id: <OVNZJQ.EY4RQEDXL92Y1@crapouillou.net>
In-Reply-To: <20201118105511.GM50232@vkoul-mobl>
References: <20201107122016.89859-1-zhouyanjie@wanyeetech.com>
        <BQOKJQ.FNG5W5HD7VTG1@crapouillou.net> <20201118105511.GM50232@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



Le mer. 18 nov. 2020 à 16:25, Vinod Koul <vkoul@kernel.org> a écrit :
> On 10-11-20, 08:54, Paul Cercueil wrote:
>>  Hi Zhou,
>> 
>>  Le sam. 7 nov. 2020 à 20:20, 周琰杰 (Zhou Yanjie)
>>  <zhouyanjie@wanyeetech.com> a écrit :
>>  > Add the dmaengine bindings for the JZ4775 SoC and the X2000 SoC 
>> from
>>  > Ingenic.
>>  >
>>  > 周琰杰 (Zhou Yanjie) (2):
>>  >   dt-bindings: dmaengine: Add JZ4775 bindings.
>>  >   dt-bindings: dmaengine: Add X2000 bindings.
>>  >
>>  >  include/dt-bindings/dma/jz4775-dma.h | 44 
>> +++++++++++++++++++++++++++++
>>  >  include/dt-bindings/dma/x2000-dma.h  | 54
>>  > ++++++++++++++++++++++++++++++++++++
>> 
>>  If that's up to me, these macros aren't really needed, and you can 
>> put the
>>  values directly in the dma cells. This is done already in 
>> jz4740.dtsi,
>>  jz4725b.dtsi and jz4770.dtsi.
> 
> But that is not really nice, it is good to define these rather than 
> put
> numbers, the include/dt-bindings exists for this sole reason!

The macros in include/dt-bindings exist for when the C code also needs 
them (e.g. IRQ_TYPE_EDGE_RISING), and not when they are only used in 
devicetree.

Things like IRQ numbers are never defined in include/dt-bindings, 
because they don't have to be...

-Paul


