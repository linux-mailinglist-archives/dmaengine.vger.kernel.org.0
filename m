Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08F3472377
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 10:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhLMJFL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 04:05:11 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45610 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhLMJFK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 04:05:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56839CE0E10;
        Mon, 13 Dec 2021 09:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B02C00446;
        Mon, 13 Dec 2021 09:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639386307;
        bh=p+M3T+RTwV57SMISSVPa/A0bgNo17ZpkMNetFBukon0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TT/2uFqPptvbZ9EQXca29KzXo3/v8Dcqhd/eq1R8kXPB/BkfNgVqNR6/gohyvC1hQ
         8Gf2ldpV4iX44ZjLsBOKmjlLzV/LyvU/8p+BDnS/RZtcMDt+i63D8Ja11PTHJ/9LDA
         lKbAeL9Nq9GIpcaenVIG3DZN2p26hasdsyCPx+yrVll8aU0ev8ygps/wIAdB/W50Q5
         x8kqZa4uYrVNWmOz+bvHdsmEI6JHZ1b1bF45OSuVHfBLCZvmPIEtjJ/XS198URKqiv
         uf3fJQb9SJvMSm3xSoK3hUVWFOVYsY+AumHpa8MHUOLJqiAv2nkU08YMlBUEQuxbr0
         DsTBNreOmMaMA==
Date:   Mon, 13 Dec 2021 14:35:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-mdma: Use bitfield helpers
Message-ID: <YbcMv4gqLoxIUohi@matsya>
References: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
 <36ceab242a594233dc7dc6f1dddb4ac32d1e846f.1637593297.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36ceab242a594233dc7dc6f1dddb4ac32d1e846f.1637593297.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-11-21, 16:54, Geert Uytterhoeven wrote:
> Use the FIELD_{GET,PREP}() helpers, instead of defining custom macros
> implementing the same operations.

Applied, thanks

-- 
~Vinod
