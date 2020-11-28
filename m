Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C157F2C6ECC
	for <lists+dmaengine@lfdr.de>; Sat, 28 Nov 2020 05:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbgK1Eb5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Nov 2020 23:31:57 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2317 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbgK1EbZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Nov 2020 23:31:25 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CjdHN68zHz13NCK;
        Sat, 28 Nov 2020 12:07:12 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 28 Nov 2020 12:07:52 +0800
Subject: Re: [PATCH v5 0/4] Enable Hi3559A SOC clock and HiSilicon Hiedma
 Controller
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20201119200129.28532-1-gengdongjiu@huawei.com>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <bac15a2e-b9db-b7b0-6004-ad76fa8c5be5@huawei.com>
Date:   Sat, 28 Nov 2020 12:07:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20201119200129.28532-1-gengdongjiu@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ping, sorry for the noise.


On 2020/11/20 4:01, Dongjiu Geng wrote:
> v4->v5:
> 1. change the patch author mail name
> 
> v3->v4:
> 1. fix the 'make dt_binding_check' issues.
> 2. Combine the 'Enable HiSilicon Hiedma Controller' series patches to this series.
> 3. fix the 'make dt_binding_check' issues in 'Enable HiSilicon Hiedma Controller' patchset
> 
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
> 
>  .../clock/hisilicon,hi3559av100-clock.yaml    |   66 +
>  .../bindings/dma/hisilicon,hiedmacv310.yaml   |  103 ++
>  drivers/clk/hisilicon/Kconfig                 |    7 +
>  drivers/clk/hisilicon/Makefile                |    1 +
>  drivers/clk/hisilicon/clk-hi3559a.c           |  865 ++++++++++
>  drivers/dma/Kconfig                           |   14 +
>  drivers/dma/Makefile                          |    1 +
>  drivers/dma/hiedmacv310.c                     | 1441 +++++++++++++++++
>  drivers/dma/hiedmacv310.h                     |  136 ++
>  include/dt-bindings/clock/hi3559av100-clock.h |  165 ++
>  10 files changed, 2799 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
>  create mode 100644 drivers/clk/hisilicon/clk-hi3559a.c
>  create mode 100644 drivers/dma/hiedmacv310.c
>  create mode 100644 drivers/dma/hiedmacv310.h
>  create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h
> 
