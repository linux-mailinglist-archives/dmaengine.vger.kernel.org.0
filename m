Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0B33EDFA
	for <lists+dmaengine@lfdr.de>; Wed, 17 Mar 2021 11:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCQKEb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Mar 2021 06:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230255AbhCQKEG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Mar 2021 06:04:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1EF864E27;
        Wed, 17 Mar 2021 10:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615975445;
        bh=QDZydGcTtHUis2/3WI6dsm0emvhCUjMzugPN7PcCtDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYjK9BFrFu5veHYn+z3996REW08FGcefktVWTLQ0WVQUUrfXMTLwcQRUs/m6a0DDB
         hso+VFUpSJg/0lfbrggyogvyszOPF9moCtRRTZudOFOkzbsTg36KlZu/c7ASIFlpPi
         Vkv+k1SJa77oudShQm9Mbvr5QKhtEPaJOYe8eUDeRbsGzCc2chANbvEM5hMd4EPWcZ
         8YQcU7G8prgVocfLMlzqOMs0E5+EY9U956S2qq/WOuunVV16bbj58o0E6qjkG0HqGz
         sixx+pKf3WXbwLrl6CGLVhtRSdtVt/r9qdHMb1T74TrrDSzaZy6fbTPEzj1ho7JTQ6
         rs5Xy7ynHuoVg==
Date:   Wed, 17 Mar 2021 15:34:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Clean-up undocumented compatible strings
Message-ID: <YFHUEVk/F0zoTe7c@vkoul-mobl.Dlink>
References: <20210316194918.3528417-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316194918.3528417-1-robh@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-03-21, 13:49, Rob Herring wrote:

> ---
>  .../clock/allwinner,sun4i-a10-pll1-clk.yaml   |  2 +-
>  .../bindings/clock/milbeaut-clock.yaml        | 12 +++++----
>  .../bindings/display/brcm,bcm2835-dsi0.yaml   |  6 -----
>  .../bindings/display/panel/panel-dpi.yaml     |  2 +-
>  .../devicetree/bindings/dma/qcom,gpi.yaml     |  2 +-

...

>  .../bindings/phy/ti,phy-j721e-wiz.yaml        |  2 +-

Acked-By: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod
