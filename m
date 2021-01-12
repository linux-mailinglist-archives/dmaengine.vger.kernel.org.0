Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656D12F2D11
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 11:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbhALKk6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 05:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbhALKk6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Jan 2021 05:40:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAEBE222B3;
        Tue, 12 Jan 2021 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610448017;
        bh=g+atqmZrENk93a5WIUGXWtiT154xajgANTB1va5MpgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QOJvX5cB5Viz6F5FxktZZA4jp1ZYXzu2XaG7+WLnlkIWDbbuIxww8NeFNQ8M8c3u1
         h9qM1QAVQzoFHLLmrtYP1yBnBueO+v6r5E6MvLnoPYgLYiHba3gis9prcpgFi1FjSY
         XKTHiXHqjNnTM/GkNFq9boUKUoOxZjZthMu5hpK+FwAC3ICd8kHACFcsl1OArKlnFf
         /1J4OS3Fb0ixvAp/Nd8eyWTOdK2/c5bfHb9rDaAO4RZDBhO3Q/UJXb4Z198PMUHvcU
         NVoKREOzVx53Ht7dpyMsOWAYh48qNy3z6C3iECiQnj2dtvkbVBMZi13yZXTVhY8PRg
         IBQiYo86Ds2Lg==
Date:   Tue, 12 Jan 2021 16:10:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        dan.j.williams@intel.com, p.zabel@pengutronix.de,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 0/4] Enable Hi3559A SOC clock and HiSilicon Hiedma
 Controller
Message-ID: <20210112104010.GN2771@vkoul-mobl>
References: <20201215110947.41268-1-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215110947.41268-1-gengdongjiu@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-12-20, 11:09, Dongjiu Geng wrote:
> v6->v7:
> 1. rename hisi,misc-control to hisi,misc-control to hisilicon,misc-control
> 
> v5->v6:
> 1. Drop #size-cells and #address-cell in the hisilicon,hi3559av100-clock.yaml
> 2. Add discription for #reset-cells in the hisilicon,hi3559av100-clock.yaml
> 3. Remove #clock-cells in hisilicon,hiedmacv310.yaml 
> 4. Merge property misc_ctrl_base and misc_regmap together for hiedmacv310 driver
> 
> v4->v5:
> 1. change the patch author mail name
> 
> v3->v4:
> 1. fix the 'make dt_binding_check' issues.
> 2. Combine the 'Enable HiSilicon Hiedma Controller' series patches to this series.
> 3. fix the 'make dt_binding_check' issues in 'Enable HiSilicon Hiedma Controller' patchset
> 
> v2->v3:
> 1. change dt-bindings documents from txt to yaml format.
> 2. Add SHUB clock to access the devices of m7
> 
> Dongjiu Geng (4):
>   dt-bindings: Document the hi3559a clock bindings
>   clk: hisilicon: Add clock driver for hi3559A SoC
>   dt: bindings: dma: Add DT bindings for HiSilicon Hiedma Controller
>   dmaengine: dma: Add Hiedma Controller v310 Device Driver

Is there a reason to have dma and clk drivers in a single series..? I am
sure I have skipping few versions thinking this is clock driver series..

Unless there is a dependency please split up.. If there is a dependency
please specify that


> 
>  .../clock/hisilicon,hi3559av100-clock.yaml    |   59 +
>  .../bindings/dma/hisilicon,hiedmacv310.yaml   |   94 ++
>  drivers/clk/hisilicon/Kconfig                 |    7 +
>  drivers/clk/hisilicon/Makefile                |    1 +
>  drivers/clk/hisilicon/clk-hi3559a.c           |  865 ++++++++++
>  drivers/dma/Kconfig                           |   14 +
>  drivers/dma/Makefile                          |    1 +
>  drivers/dma/hiedmacv310.c                     | 1442 +++++++++++++++++
>  drivers/dma/hiedmacv310.h                     |  136 ++
>  include/dt-bindings/clock/hi3559av100-clock.h |  165 ++
>  10 files changed, 2784 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
>  create mode 100644 drivers/clk/hisilicon/clk-hi3559a.c
>  create mode 100644 drivers/dma/hiedmacv310.c
>  create mode 100644 drivers/dma/hiedmacv310.h
>  create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h
> 
> -- 
> 2.17.1

-- 
~Vinod
