Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2B942CCD8
	for <lists+dmaengine@lfdr.de>; Wed, 13 Oct 2021 23:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhJMVgq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Wed, 13 Oct 2021 17:36:46 -0400
Received: from aposti.net ([89.234.176.197]:38510 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhJMVgp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 Oct 2021 17:36:45 -0400
Date:   Wed, 13 Oct 2021 22:34:30 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/5] dt-bindings: dma: ingenic: Add compatible strings for
 MDMA and BDMA
To:     Rob Herring <robh@kernel.org>
Cc:     list@opendingux.net, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Message-Id: <ILQX0R.H5HOCWNV78AZ1@crapouillou.net>
In-Reply-To: <YWTbbOWhtrTniXWV@robh.at.kernel.org>
References: <20211011143652.51976-1-paul@crapouillou.net>
        <20211011143652.51976-2-paul@crapouillou.net>
        <YWTbbOWhtrTniXWV@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Le lun., oct. 11 2021 at 19:48:44 -0500, Rob Herring <robh@kernel.org> 
a écrit :
> On Mon, 11 Oct 2021 16:36:48 +0200, Paul Cercueil wrote:
>>  The JZ4760 and JZ4760B SoCs have two additional DMA controllers: the
>>  MDMA, which only supports memcpy operations, and the BDMA which is
>>  mostly used for transfer between memories and the BCH controller.
>>  The JZ4770 also features the same BDMA as in the JZ4760B, but does 
>> not
>>  seem to have a MDMA.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../devicetree/bindings/dma/ingenic,dma.yaml  | 26 
>> ++++++++++++-------
>>   1 file changed, 17 insertions(+), 9 deletions(-)
>> 
> 
> With the indentation fixed:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob, I'll V2 then.

Could you have a look at patch 2/5 too? It touches the dt-bindings as 
well.

Cheers,
-Paul


