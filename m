Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184556111FB
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 14:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiJ1Mzn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1Mzm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 08:55:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB68198989;
        Fri, 28 Oct 2022 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666961741; x=1698497741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j6mmci6yqeE9vsqUFPTb1XAq/fXqTEJvQ3kd2FzN0qw=;
  b=yk+D6gvI8d2+K8qKOkyh+IKPekV1BkNLXBDxXu1eePS9oYZKUBDdtalq
   kJW4qwuCNnuTPsZZMOTOfaQv5eS3bWbE51Qn3I4mKCR+1+HO277mZes+2
   ABl8AQzovIAYKhs56/ZqkTePcCNKMiCSs/gzZS8KojJpBF0lxYJLY4XU9
   Rh9SUNyNONxp/TfIS8k9PgsXvh+2Wu5+W6Py0E22kGa/Tk3TBOKc3UMF0
   XSE7OfHRQMt1QD7wmtoxI0AO19wdpuelbqrI1RzPnIw+mkwHRavfASyZb
   HbSFJvE43eqa+G2dDSm0kpP/1B1IQGiHmkDuiZiPpLOo1PYjxOkoKWuyE
   A==;
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="186775063"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2022 05:55:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 28 Oct 2022 05:55:40 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 28 Oct 2022 05:55:38 -0700
Message-ID: <61e54c48-6347-f0ab-e843-ae48d5374903@microchip.com>
Date:   Fri, 28 Oct 2022 14:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 32/32] dmaengine: at_hdmac: Convert driver to use
 virt-dma
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, <vkoul@kernel.org>,
        <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
 <20221025090306.297886-33-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221025090306.297886-33-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25/10/2022 at 11:03, Tudor Ambarus wrote:
> Convert the driver to use the core virt-dma. The driver will be easier to
> maintain as it uses the list handling and the tasklet from virt-dma.
> 
> With the conversion replace the election of a new transfer in the tasklet
> with the election of the new transfer in the interrupt handler. With this
> we have a shorter idle window as we remove the scheduling latency of the
> tasklet. I chose to do this while doing the conversion to virt-dma,
> because if I made a prerequisite patch with the new transfer election in
> the irq handler, I would have to duplicate some virt-dma code in the
> at_hdmac driver that would end up being removed at the virt-dma conversion
> anyway. So do this in a single step.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Even if it's difficult to review, I support the transition:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Tudor, regards,
   Nicolas

[..]

-- 
Nicolas Ferre

