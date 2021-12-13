Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A64472360
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 10:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhLMJAG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 04:00:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58916 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhLMJAF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 04:00:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11D11B80DCF;
        Mon, 13 Dec 2021 09:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1284AC341C5;
        Mon, 13 Dec 2021 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639386002;
        bh=9++Y8nJdu20L/simihE/HqS4ABBR4aerAapeSMPYOGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzUo0SkJ0KSEzCje9uGr2oHpke1HoWUtJys+wrdWu190F+gE4CZk67IqNfkizAqzK
         yH2JXvj3FBjtLFtGF4RlTyzsmghX1noHWamoscvu0DSH6bte7e9/t4Ugg68lS1EcXG
         BAoxBJds+B/uoxzW31Yus/eB5R867pQyQ5iKqMbmqhGDMaVeir+lil6eAICrccycOx
         WQYaHyX+KEvhSwxC9SSB4xsmjvyCFGMX/98xfyVwNnYnFiszCaJk+3pZPpMJpmRr0i
         x373HnMR8C3qbaC5FTfFcnm9IFXvn6R7ZZeJ+CKYvLPzGIM9ag+Ol6b5tcVQSrSvbI
         byPMHYFDCEriw==
Date:   Mon, 13 Dec 2021 14:29:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     Ludovic.Desroches@microchip.com, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 08/13] dmaengine: at_xdmac: Move the free desc to the
 tail of the desc list
Message-ID: <YbcLjrMF0YrCVgjc@matsya>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
 <20211125090028.786832-9-tudor.ambarus@microchip.com>
 <Ybb/PV5M1Gi59s7I@matsya>
 <8523ca32-d36f-6e0b-0115-5e07553396f1@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8523ca32-d36f-6e0b-0115-5e07553396f1@microchip.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-12-21, 08:51, Tudor.Ambarus@microchip.com wrote:
> Hi, Vinod,
> 
> On 12/13/21 10:07 AM, Vinod Koul wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 25-11-21, 11:00, Tudor Ambarus wrote:
> >> So that we don't use the same desc over and over again.
> > 
> > Please use full para in the changelog and not a continuation of the
> > patch title!
> 
> Ok, will add a better commit description. Here and in other patches where
> your comment applies.

Great!

> > 
> > and why is wrong with using same desc over and over? Any benefits of not
> > doing so?
> 
> Not wrong, but if we move the free desc to the tail of the list, then the
> sequence of descriptors is more track-able in case of debug. You would
> know which descriptor should come next and you could easier catch
> concurrency over descriptors for example. I saw virt-dma uses
> list_splice_tail_init() as well, I found it a good idea, so I thought to
> follow the core driver.

Okay, I would be good to add this motivation in the change log. I am
sure after few you would also wonder why you did this change :)

-- 
~Vinod
