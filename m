Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB832F2DD2
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 12:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbhALLXa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 06:23:30 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2856 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbhALLXa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jan 2021 06:23:30 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DFSnk3NW1z59m7;
        Tue, 12 Jan 2021 19:21:30 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 12 Jan 2021 19:22:46 +0800
Subject: Re: [PATCH v7 0/4] Enable Hi3559A SOC clock and HiSilicon Hiedma
 Controller
To:     Vinod Koul <vkoul@kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <dan.j.williams@intel.com>,
        <p.zabel@pengutronix.de>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20201215110947.41268-1-gengdongjiu@huawei.com>
 <20210112104010.GN2771@vkoul-mobl>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <cd34cdfd-eee5-b217-a151-9ff7290c112f@huawei.com>
Date:   Tue, 12 Jan 2021 19:22:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20210112104010.GN2771@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021/1/12 18:40, Vinod Koul wrote:
> On 15-12-20, 11:09, Dongjiu Geng wrote:
>> v6->v7:
>> 1. rename hisi,misc-control to hisi,misc-control to hisilicon,misc-control
>>
>> v5->v6:
>> 1. Drop #size-cells and #address-cell in the hisilicon,hi3559av100-clock.yaml
>> 2. Add discription for #reset-cells in the hisilicon,hi3559av100-clock.yaml
>> 3. Remove #clock-cells in hisilicon,hiedmacv310.yaml 
>> 4. Merge property misc_ctrl_base and misc_regmap together for hiedmacv310 driver
>>
>> v4->v5:
>> 1. change the patch author mail name
>>
>> v3->v4:
>> 1. fix the 'make dt_binding_check' issues.
>> 2. Combine the 'Enable HiSilicon Hiedma Controller' series patches to this series.
>> 3. fix the 'make dt_binding_check' issues in 'Enable HiSilicon Hiedma Controller' patchset
>>
>> v2->v3:
>> 1. change dt-bindings documents from txt to yaml format.
>> 2. Add SHUB clock to access the devices of m7
>>
>> Dongjiu Geng (4):
>>   dt-bindings: Document the hi3559a clock bindings
>>   clk: hisilicon: Add clock driver for hi3559A SoC
>>   dt: bindings: dma: Add DT bindings for HiSilicon Hiedma Controller
>>   dmaengine: dma: Add Hiedma Controller v310 Device Driver
> 
> Is there a reason to have dma and clk drivers in a single series..? I am
> sure I have skipping few versions thinking this is clock driver series..
> 
> Unless there is a dependency please split up.. If there is a dependency
> please specify that

Thank you very much for your pointing out.  I will split up.

> 
> 
>>
>>  .../clock/hisilicon,hi3559av100-clock.yaml    |   59 +
>>  .../bindings/dma/hisilicon,hiedmacv310.yaml   |   94 ++
>>  drivers/clk/hisilicon/Kconfig                 |    7 +
>>  drivers/clk/hisilicon/Makefile                |    1 +
>>  drivers/clk/hisilicon/clk-hi3559a.c           |  865 ++++++++++
>>  drivers/dma/Kconfig                           |   14 +
>>  drivers/dma/Makefile                          |    1 +
>>  drivers/dma/hiedmacv310.c                     | 1442 +++++++++++++++++
>>  drivers/dma/hiedmacv310.h                     |  136 ++
>>  include/dt-bindings/clock/hi3559av100-clock.h |  165 ++
>>  10 files changed, 2784 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
>>  create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
>>  create mode 100644 drivers/clk/hisilicon/clk-hi3559a.c
>>  create mode 100644 drivers/dma/hiedmacv310.c
>>  create mode 100644 drivers/dma/hiedmacv310.h
>>  create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h
>>
>> -- 
>> 2.17.1
> 
