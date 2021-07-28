Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A886D3D8C6F
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 13:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhG1LFQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 07:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235781AbhG1LFO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 07:05:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D9D760F46;
        Wed, 28 Jul 2021 11:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627470313;
        bh=mFVcar/DSTt8tbbW79iYEF1zXXU/0XiVA1P3oMx5bXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DAe+8a6JljBbypytw+Fw7gTxuu9D9Go7TAoUdt9kTrBWbeibEGRsSQKRgaEHWQ5hF
         Jj6qFAnlrhwoGkkkrKS1Sg8LBndJ9RPacupMrLflze78vO+6rRfTI9j6pjPK9savEk
         HDKUwmPo9Sss61Vw75mAHMuJvODupeHf4jnUnkxmTOveaD4JA47P4b+CQtZW3lCPCd
         8iaNDzqpJNW78hbH/iO0dPaeSkIW3DfCvZLtTiJF39bijl+42Ktt+ls5EyoocZDt51
         y3rbaIP6xPgFtkBlDqiFKd3SfAJ6l9dFQdnXTIgQYTYffmSTaVGE/6dmQeX+G6he0H
         WDWzkuUArEUbw==
Date:   Wed, 28 Jul 2021 16:35:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Message-ID: <YQE542kiEGcYCCFO@matsya>
References: <20210719092535.4474-1-biju.das.jz@bp.renesas.com>
 <20210719092535.4474-3-biju.das.jz@bp.renesas.com>
 <YP/+r4HzCaAZbUWh@matsya>
 <OS0PR01MB59224844C17A1EE620E2D18786E99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YQD3FLN0YEVk6rnr@matsya>
 <OS0PR01MB59228D6F0AD7A51DAFFB512A86EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59228D6F0AD7A51DAFFB512A86EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On 28-07-21, 07:00, Biju Das wrote:
> > 
> > Sorry I dont like passing numbers like this :(
> > 
> > Can you explain what is meant by each of the above values and looks like
> > some (if not all) can be derived (slave config as well as transaction
> > properties)
> 
> 
> 0x11228 (Tx)
> 0x11220 (Rx)
> 
> BIT 22:- TM :- Transfer Mode 

What are the values, here it seems 0

> Bits 16->19 :- DDS(Destination Data Size) --> 0x0001 (16 bits)
> Bits 12->15 :- SDS(Source Data size)--> 0x0001 (16 bits)

use src_addr_width/dst_addr_width ..?

> Bit  11     :- Reserved
> Bits 8->10 :- Ack mode  --> 0x010 (Bus cycle mode)

What does this mean?

> Bit 7 :-  Reserved
> Bit 6:- LVL -->  Level -->0 (DMA request based on edge of thesignal)
> Bit 5:- HIEN -->  High Enable --> 1 (Detects a DMA request on rising edge of the signal)
> Bit 4:- LOEN --> Low Enable -->0 (Does not DMA request on falling edge of the signal)
> Bit 3:- REQD --> Request Direction ->1 (DMAREQ is Destination)

how and what decides these values

It is now hardcoded in the client driver, can we do that in dma driver
instead? While deriving most of the values?

-- 
~Vinod
