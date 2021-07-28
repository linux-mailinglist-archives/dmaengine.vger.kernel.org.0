Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0A3D87CA
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 08:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhG1GUK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 02:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhG1GUJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 02:20:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF54560E78;
        Wed, 28 Jul 2021 06:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627453208;
        bh=HkZZZEezLxlMdxDZomgJxlhl427+uiRZ9Ct6TVv0C30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/1KrKm+01QsCnfkbvX81hBkzDtmqUwKPwlk1ryz8vToBIwzDojdLrnAI3gPhNJ9F
         pvPCn5ObN7yLurBD9+LTnPDNIamhU6eGh5ga+oprEpgUPT04Gie0cplbtjcPOg5LLF
         sprT6D8+hbPlazIutcQd2aYcMYSw4QBjAyZcOSSEr46RwNW4ZZ/elQ6XIafeLtaVML
         lRGVBOddJORcT0gPzF/vEeQFIhXsxs3iOQoVnpopnsXdsXYGEK4H13neLy6IAifT1J
         fOfYSm1FM73dQSn7+Owpe+Mdd7GWubAJkGqv71cwrw7Oba1xRU7O12hKK+8skKNlMZ
         xRf9YIfglFeaw==
Date:   Wed, 28 Jul 2021 11:50:04 +0530
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
Message-ID: <YQD3FLN0YEVk6rnr@matsya>
References: <20210719092535.4474-1-biju.das.jz@bp.renesas.com>
 <20210719092535.4474-3-biju.das.jz@bp.renesas.com>
 <YP/+r4HzCaAZbUWh@matsya>
 <OS0PR01MB59224844C17A1EE620E2D18786E99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59224844C17A1EE620E2D18786E99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On 27-07-21, 13:45, Biju Das wrote:
> > > +
> > > +	if (config->peripheral_config) {
> > > +		ch_cfg = config->peripheral_config;
> > > +		channel->chcfg = *ch_cfg;
> > > +	}
> > 
> > can you explain what this the ch_cfg here and what does it represent?
> 
> It is a 32 bit value represent channel config value which supplied by each client driver during slave config.
> It contains information like transfer mode,src/destination data size, Ack mode, Level type, DMA request on rising edge or falling
> Edge, request direction etc...
> 
> For eg:- The channel config for SSI tx is (0x11228).
> An example usage can be found here [1]
> 
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20210719134040.7964-8-biju.das.jz@bp.renesas.com/

Sorry I dont like passing numbers like this :(

Can you explain what is meant by each of the above values and looks like
some (if not all) can be derived (slave config as well as transaction
properties)

-- 
~Vinod
