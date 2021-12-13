Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEA34720E7
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 07:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhLMGE6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 01:04:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52352 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhLMGE6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 01:04:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 80EFECE0D07;
        Mon, 13 Dec 2021 06:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B052EC00446;
        Mon, 13 Dec 2021 06:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639375494;
        bh=mO2Am3NA7/Lh5otbQkMxGHOHLA4azyRI8FOw664jYZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJIvC0NjG1dQN83f4cQT9l9nYU2GNjxXklRZaIltoSdXRKwnVAkf2xEaWIvj079ef
         KvYiONmN453WM5QYgG/e5EPipFQ8DFByGR5h2O3xLkCTsZ5CuiqGsDwcgW8fHHmsfa
         0zEnGAJNb5Au5ctJNYO3EhdaeZ7odrvoQDnwX7PLKfq/OAc+ofm4NzE7h+vezRaWDN
         +J/Cne2C3X5gF8c3rgkV8HFOar/QFnENt0sQZKGOk/7lA7gCaV92ROTyB6nm/RQx3b
         2e2hVBZ6QOLNWvVyvbuHzaszZqZePu1TCZnVwKZWElLM3/pSFnieyVOM8FT5jloaHa
         e645+vLxbfJnQ==
Date:   Mon, 13 Dec 2021 11:34:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: pl08x: Fix unevaluatedProperties
 warnings
Message-ID: <YbbigoCeQn0qM7jJ@matsya>
References: <20211206174231.2298349-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206174231.2298349-1-robh@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-12-21, 11:42, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the example has
> warnings on primecell properties and 'resets':
> 
> Documentation/devicetree/bindings/dma/arm-pl08x.example.dt.yaml: dma-controller@67000000: Unevaluated properties are not allowed ('arm,primecell-periphid', 'resets' were unexpected)
> 
> Add the missing reference to primecell.yaml and definition for 'resets'.

Applied, thanks

-- 
~Vinod
