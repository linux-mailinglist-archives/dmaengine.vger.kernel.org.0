Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CEF3A97C2
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 12:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhFPKlI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 06:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhFPKlI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 06:41:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0AB361245;
        Wed, 16 Jun 2021 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623839942;
        bh=MImfvo4eQR1r8uo+tH8braW8LKg4STkJAk+MyC8vGwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9lbvXtQi8vx+y3JEPjs+IOHgtOc/QcmlZta9fMtY+N99sFo2nH8AN4zMl1rnL9nU
         LccQT8TRjvWTtEcfVdzfIFTc4LRDEcl2CKEju0a1XJkmrfxDzRCWRClnrBK3b+yjbN
         FizReZp32xwWXsrHjhA3S1Cb0vDriJs0hUNVvJ1PyNbR33Q2CRVxFAOwb6phzGRPvW
         zELBnxjNOjjXrkO/pauqLEJqH39X7gVtSquglgsnKtEIxnOXsse/lF1kkMEgvCoAOS
         ZObsg3PeVtHWtZ7DiA2tGW/NQihT/bV5sW+Ak8shZqkBDX1rfaYPyl+drb9TTtk2e5
         fRoeqkvLenJxg==
Date:   Wed, 16 Jun 2021 16:08:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] Remove shdma DT support
Message-ID: <YMnUw80/rUCFtO24@vkoul-mobl>
References: <cover.1623405675.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623405675.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-06-21, 12:18, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> Documentation/devicetree/bindings/dma/renesas,shdma.txt is one of the
> few^W57% of the DT bindings that haven't been converted to json-schema
> yet.  These bindings were originally intended to cover all SH/R-Mobile
> SoCs, but the DMA multiplexer node and one DMA controller instance were
> only ever added to one .dtsi file, for R-Mobile APE6.  Still, DMA
> support for R-Mobile APE6 was never completed to the point that it would
> actually work, cfr. commit a19788612f51b787 ("dmaengine: sh: Remove
> R-Mobile APE6 support").  Later, the mux idea was dropped when
> implementing support for DMA on (very similar) R-Car Gen2, cfr.
> renesas,rcar-dmac.yaml.
> 
> Hence this series removes the Renesas SHDMA Device Tree bindings, the
> SHDMA DMA multiplexer driver, and the corresponding description in the
> R-Mobile APE6 DTS.

Applied 1 & 2, thanks

-- 
~Vinod
