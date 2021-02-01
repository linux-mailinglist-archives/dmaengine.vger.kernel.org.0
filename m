Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A9B30A1B6
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 06:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhBAF55 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 00:57:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231514AbhBAFvV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 00:51:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC1BA64E15;
        Mon,  1 Feb 2021 05:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612158590;
        bh=n1Ftlf0+nz05REHPi3P5OsNAYBNGf584f0+3bCYf448=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Psk+p6iLv4bsId/XCtKOYmxrKwT64Myag18LHge73gr0EPF9DPLaW6pAlg1RAAYyH
         ZkzaOxDXq1p4vgOs7NgDcgOe2tHOpKhs7GnnKnWYQq6jZYADD3dt1xXoR2rVKPzuqT
         lvkcl5EmOkvolo0Q+GMw6IivTcTzBPhUv4jOXUzPiDqgYFM0/8YUKZ9CNo3++BUGti
         RwZgl7ov+m7NNy5ekT2TxFNMXEL4st3FwIf8kfIOiTpFiywTDtS1FT6TVLBl0BHE4B
         7gH33NDZXz+Nwf7GvHJgKWHEA2SNC88jqy8sZSizN5jiri47oxYoNO6omAz5lznFVe
         Hym5rs5960WGQ==
Date:   Mon, 1 Feb 2021 11:19:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Message-ID: <20210201054946.GH2771@vkoul-mobl>
References: <20210128084455.2237256-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128084455.2237256-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-01-21, 09:44, Geert Uytterhoeven wrote:
> 	Hi Vinod,
> 
> This patch series adds support for the Direct Memory Access Controller
> variant in the Renesas R-Car V3U (R8A779A0) SoC, to both DT bindings and
> driver.

Applied all, thanks
-- 
~Vinod
