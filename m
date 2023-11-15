Return-Path: <dmaengine+bounces-116-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D5A7ED0FA
	for <lists+dmaengine@lfdr.de>; Wed, 15 Nov 2023 20:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F6528172C
	for <lists+dmaengine@lfdr.de>; Wed, 15 Nov 2023 19:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533AD3DB97;
	Wed, 15 Nov 2023 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWvnCgEf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C14C2;
	Wed, 15 Nov 2023 11:58:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so65127e87.0;
        Wed, 15 Nov 2023 11:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700078318; x=1700683118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4vQJLGQNUUgXQ6K4PAgV5kA5EqMnMPvDqFDOwcV/Pc=;
        b=FWvnCgEf9O9pI251+zE/GFQM3lb+WzGLlyvXIb/t+aX7sASvxcqHm0yEIqTe5dbUIa
         O6EAeY+/7q04tEfVjDeeL0vkAuwLEG5oelOuqsPoRYJwzKfeqWHnKiyB/mQFhbRbZzQ8
         wllKRw+nsfVrQoPoJgIFJakfTNCZ/3CEw1E2hA6z/sDDKQYptdkSVLguEad4fg3HDlVf
         WLlOR3T/OGPztOWo1oEgsGK4s5oVOLUlIYvb6CU4u4chxVZvYI3xmJCmEhmreOsRh6ih
         UKqP4VfAEQgPpTwNkiyiG8liLni/cC38G4CDIC9RwIm/fqmhA24a3Um5PQoJ/lmtL8as
         oGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700078318; x=1700683118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4vQJLGQNUUgXQ6K4PAgV5kA5EqMnMPvDqFDOwcV/Pc=;
        b=TJCwmFPMz4Pym/VD9aR+w2LQpArT6D32JVhISoHUi8bQHjgF+wSG1AtwdPu0PgwT88
         8pDtKW98sO2vKST2AaxWol/DTRCWCKw9q+Kxd34nR5hrE2OGgbyVv+fO74Vktus5h7i6
         onrWDX12PB5xn9Ed25NyW8w4rIVb/5vKAavjiMC2cSWQvxbjF485V5+0lMGNtixB4jvO
         9vUTyIaN1J4dyWhJbola7pfRHtPN9FWS6NrR48UCJ8QIPiSeZybC+BtqOYV4q3LlXUW4
         51O6gM5nH4YNxgh8pHUrQcoqXKUDUu+Rh6+TWJG5y2r6zhvE6ss7yTUjM1JT9bZwLd3j
         FdOQ==
X-Gm-Message-State: AOJu0YzieeFDcqk8R+pvapgzs6mb7V+NLDf8r6H0erDo4GnUNQG1RsX1
	gU61/wlBsGsULREhqdOOx7nggEltmnv2wg==
X-Google-Smtp-Source: AGHT+IHSVFq+s+WpxAeIdoZnVIsR4R873DwkOIt/kOZSRoJogDiAbhE2VmgVF330C1fup3lxIY3bZQ==
X-Received: by 2002:ac2:4845:0:b0:507:9b69:6028 with SMTP id 5-20020ac24845000000b005079b696028mr2607651lfy.24.1700078317543;
        Wed, 15 Nov 2023 11:58:37 -0800 (PST)
Received: from [10.0.0.100] (host-213-145-197-219.kaisa-laajakaista.fi. [213.145.197.219])
        by smtp.gmail.com with ESMTPSA id h15-20020a056512220f00b004fe2f085d5csm1723749lfu.299.2023.11.15.11.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 11:58:37 -0800 (PST)
Message-ID: <9d465de4-3930-4856-9d8e-7deb567a628f@gmail.com>
Date: Wed, 15 Nov 2023 21:59:57 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add APIs to request TX/RX DMA channels by ID
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com
References: <20231114083906.3143548-1-s-vadapalli@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20231114083906.3143548-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/11/2023 10:39, Siddharth Vadapalli wrote:
> The existing APIs for requesting TX and RX DMA channels rely on parsing
> a device-tree node to obtain the Channel/Thread IDs from their names.

Yes, since it is a DMA device and it is using the standard DMA mapping.
It is by design that the standard DMAengine and the custom glue layer
(which should have been a temporary solution) uses the same standard DMA
binding to make sure that we are not going to deviate from the standard
and be able to move the glue users to DMAengine (which would need core
changes).

> However, it is possible to know the thread IDs by alternative means such
> as being informed by Firmware on a remote core regarding the allocated
> TX/RX DMA channel IDs. Thus, add APIs to support such use cases.

I see, so the TISCI res manager is going to managed the channels/flows
for some peripherals?

What is the API and parameters to get these channels?

I would really like to follow a standard binding since what will happen
if the firmware will start to provision channels/flows for DMAengine
users? It is not that simple to hack that around.

My initial take is that this can be implemented via the existing DMA
crossbar support. It has been created exactly for this sort of purpose.
I'm sure you need to provide some sort of parameters to TISCI to get the
channel/rflow provisioned for the host requesting, right?
The crossbar implements the binding with the given set of parameters,
does the needed 'black magic' to get the information needed for the
target DMA and crafts the binding for it and get's the channel.

If you take a look at the drivers/dma/ti/dma-crossbar.c, it implements
two types of crossbars.

For DMAengine, it would be relatively simple to write a new one for
tisci, The glue layer might needs a bit more work as it is not relying
on core, but I would not think that it is that much complicated to
extend it to be able to handle a crossbar binding.
The benefit is that none of the clients should not need to know about
the way the channel is looked up, they just request for an RX channel
and depending on the binding they will get it directly from the DMA or
get the translation via the crossbar to be able to fetch the channel.

Can you check if this would be doable?

For reference:
Documentation/devicetree/bindings/dma/dma-router.yaml
Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
drivers/dma/ti/dma-crossbar.c

> Additionally, since the name of the device for the remote RX channel is
> being set purely on the basis of the RX channel ID itself, it can result
> in duplicate names when multiple flows are used on the same channel.
> Avoid name duplication by including the flow in the name.

Make sense.
> Series is based on linux-next tagged next-20231114.
> 
> RFC Series:
> https://lore.kernel.org/r/20231111121555.2656760-1-s-vadapalli@ti.com/
> 
> Changes since RFC Series:
> - Rebased patches 1, 2 and 3 on linux-next tagged next-20231114.
> - Added patch 4 to the series.
> 
> Regards,
> Siddharth.
> 
> Siddharth Vadapalli (4):
>   dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
>   dmaengine: ti: k3-udma-glue: Add function to request TX channel by ID
>   dmaengine: ti: k3-udma-glue: Add function to request RX channel by ID
>   dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
> 
>  drivers/dma/ti/k3-udma-glue.c    | 306 ++++++++++++++++++++++---------
>  include/linux/dma/k3-udma-glue.h |   8 +
>  2 files changed, 228 insertions(+), 86 deletions(-)
> 

-- 
Péter

