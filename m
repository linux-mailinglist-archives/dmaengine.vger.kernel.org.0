Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD66B74F71
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2019 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfGYN3X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 09:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbfGYN3W (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Jul 2019 09:29:22 -0400
Received: from localhost (unknown [106.200.241.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C2712190F;
        Thu, 25 Jul 2019 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564061361;
        bh=jl8uMjgsLb0dxJ6gayUlxRXBHnr28czfXaxtk3fYBIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/v9siQZKZQYp+JHwgRMPxxJz9BRFGxp87Koei1lbF8P2wLiOQmvpJ1yYn2HhiI3M
         oaw5G9ciDLtOC1zOgo3l4b+Kr3GFPcH9b71R3llwsng4qW8B0to7FlO9xzXRp2O4R+
         LYuPS8yRPj18gwKIl4EyJNZ3JySk1pf8dL+evhMw=
Date:   Thu, 25 Jul 2019 18:58:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Paul Burton <paul.burton@mips.com>, od@zcrc.me,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: dma-jz4780: Break descriptor chains on
 JZ4740
Message-ID: <20190725132809.GW12733@vkoul-mobl.Dlink>
References: <20190714215504.10877-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190714215504.10877-1-paul@crapouillou.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-07-19, 17:55, Paul Cercueil wrote:
> The current driver works perfectly fine on every generation of the
> JZ47xx SoCs, except on the JZ4740.
> 
> There, when hardware descriptors are chained together (with the LINK
> bit set), the next descriptor isn't automatically fetched as it should -
> instead, an interrupt is raised, even if the TIE bit (Transfer Interrupt
> Enable) bit is cleared. When it happens, the DMA transfer seems to be
> stopped (it doesn't chain), and it's uncertain how many bytes have
> actually been transferred.
> 
> Until somebody smarter than me can figure out how to make chained
> descriptors work on the JZ4740, we now disable chained descriptors on
> that particular SoC.

Applied, thanks

-- 
~Vinod
