Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF14720EF
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 07:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhLMGHR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 01:07:17 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53444 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhLMGHR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 01:07:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7062ACE0D07;
        Mon, 13 Dec 2021 06:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65C3C00446;
        Mon, 13 Dec 2021 06:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639375633;
        bh=uDI/N5ve5tFJvyHw4ZHMMMocIwdr/gLZTJp5n1/pV/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0dHcyEgK2lEzgrOvYRuhRRgDkLYqbPXyCz9AhUG0iGeWFBe/SWYerJsofFkeVZPh
         IMsEYfCTHHsYEKDbRUUGwUJcCLX5SEDJhvTCWALe+qof1zcAeAxe37OPmHvfU0z7jp
         vkCATMfq8MFHxgxWA74GsUUw77vhalY/zhf7r6lGWJbXM6FNJYD9TFDwtCTijqFAO9
         Uv28IeEAByaXVw0Wy2499sv2ZSLHH5tqd1H9lhCWtjLbYoOMJW68yitS1YYYN+jSRp
         MYkLyXfuITQYtke8KI6378nkJnFIMTLNlWZOfi2uZEgS5CisqEf2+UQOzWgPd+/AW9
         wC8JQDInaNYXg==
Date:   Mon, 13 Dec 2021 11:37:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: ti: Add missing ti,k3-sci-common.yaml
 reference
Message-ID: <YbbjDSx4AlJuTkTL@matsya>
References: <20211206174226.2298135-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206174226.2298135-1-robh@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-12-21, 11:42, Rob Herring wrote:
> The TI k3-bcdma and k3-pktdma both use 'ti,sci' and 'ti,sci-dev-id'
> properties defined in ti,k3-sci-common.yaml. When 'unevaluatedProperties'
> support is enabled, a the follow warning is generated:
> 
> Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml: dma-controller@485c0100: Unevaluated properties are not allowed ('ti,sci', 'ti,sci-dev-id' were unexpected)
> Documentation/devicetree/bindings/dma/ti/k3-pktdma.example.dt.yaml: dma-controller@485c0000: Unevaluated properties are not allowed ('ti,sci', 'ti,sci-dev-id' were unexpected)
> 
> Add a reference to ti,k3-sci-common.yaml to fix this.

Applied, thanks

-- 
~Vinod
