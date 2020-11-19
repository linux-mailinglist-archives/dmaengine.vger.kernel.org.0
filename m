Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057982B9140
	for <lists+dmaengine@lfdr.de>; Thu, 19 Nov 2020 12:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgKSLkr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Nov 2020 06:40:47 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2376 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgKSLkr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Nov 2020 06:40:47 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CcHmS0PkXz53nl;
        Thu, 19 Nov 2020 19:40:24 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 19 Nov 2020 19:40:43 +0800
Subject: Re: [PATCH 1/2] dt: bindings: dma: Add DT bindings for HiSilicon
 Hiedma Controller
To:     Rob Herring <robh@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <robh+dt@kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <vkoul@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201114003440.36458-1-gengdongjiu@huawei.com>
 <20201116152725.GB1646380@bogus>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <230b73c0-3240-13ce-a115-6c3bdc1e476a@huawei.com>
Date:   Thu, 19 Nov 2020 19:40:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20201116152725.GB1646380@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/11/16 23:27, Rob Herring wrote:
> On Sat, 14 Nov 2020 00:34:39 +0000, Dongjiu Geng wrote:
>> The Hiedma Controller v310 Provides eight DMA channels, each
>> channel can be configured for one-way transfer. The data can
>> be transferred in 8-bit, 16-bit, 32-bit, or 64-bit mode. This
>> documentation describes DT bindings of this controller.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  .../bindings/dma/hisilicon,hiedmacv310.yaml   | 80 +++++++++++++++++++
>>  1 file changed, 80 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.example.dts:20:18: fatal error: dt-bindings/clock/hi3559av100-clock.h: No such file or directory
>    20 |         #include <dt-bindings/clock/hi3559av100-clock.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1364: dt_binding_check] Error 2

Rob,
  Because it needs to include“#include <dt-bindings/clock/hi3559av100-clock.h>”, so I combine the new modified series patches to this series "[PATCH v4 0/4] Enable Hi3559A SOC clock and HiSilicon Hiedma Controller"

See https://lore.kernel.org/patchwork/cover/1341544/

> 
> 
> See https://patchwork.ozlabs.org/patch/1399915
> 
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
> .
> 
