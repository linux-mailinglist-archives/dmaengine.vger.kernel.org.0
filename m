Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840731B996A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 10:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgD0IKF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 04:10:05 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:59928 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgD0IKE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Apr 2020 04:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587975004; x=1619511004;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Ii4utWJZKx5C6ggFxLHhkB/YHca1PFdjSmjKRJoP2zc=;
  b=LYNheoUMPvvmapOBOulenNF1pP55salR3VTHKRjahT//pKMADXXba0Bw
   +VD39Tnxx5YMc8MwuVE8iUloOy/NqIYqKuQs1+tcCsJkTYuVdEz+wrNlg
   T8twAoEop9coyQ1ag74IsIF7tyxZP/EV8qv8ujbzTzBAUZofgmmek/lUK
   LqR3NeHXW2EXPuvwsFeaaEIQcNcNkBUV6+LtmxfPSbDlV6OKqRqwlK3k2
   xbBb+ghKsMU4Hx9giD10yNn+C/yaDd6NJHS48UA1FMSR3KV/aALB6llWA
   sCUYxjc+nyIS0wn4BYax9EKLRvKIf21gR3gmhdqdi/uXoSa8J3F0k+Jtd
   A==;
IronPort-SDR: SX6vU4nClwnN86DhvVaurxAH0g6FAExyiYwoVRcgGo1oIn7ic9wTn3oefV8kWfzIBvS3eBOOd2
 xMuC+JiL7ztAx5VEWHeXa4tmJE7pyrIsBiKXNMezUhnSrMXHqelMVNtz6dFb9uPdUhHFGAYngO
 pvOsRu9YAqoM9Ct+kjKTVFJvLXPSiOIFVb/dT9L3vLgC/f5DdIL/XIMhmIq+SXIfX6zTEH2AZp
 GPI0YkdvDtbxcEDIAxNEGN78V87Fzelvm5NoEdFDLu53OGKXBBdFOk7slZQalSrlBvlp6Gipvx
 Pwg=
X-IronPort-AV: E=Sophos;i="5.73,323,1583218800"; 
   d="scan'208";a="10479798"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2020 01:10:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 27 Apr 2020 01:10:04 -0700
Received: from [10.205.29.78] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 27 Apr 2020 01:10:01 -0700
Subject: Re: [PATCH v1 1/6] dmaengine: dmatest: Fix iteration non-stop logic
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
References: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <3b031f47-5ebf-4bff-9103-e3b57fa33848@microchip.com>
Date:   Mon, 27 Apr 2020 10:09:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Andy,

On 24/04/2020 at 18:11, Andy Shevchenko wrote:
> Under some circumstances, i.e. when test is still running and about to
> time out and user runs, for example,
> 
>          grep -H . /sys/module/dmatest/parameters/*
> 
> the iterations parameter is not respected and test is going on and on until
> user gives
> 
>          echo 0 > /sys/module/dmatest/parameters/run
> 
> This is not what expected.
> 
> The history of this bug is interesting. I though that the commit
>    2d88ce76eb98 ("dmatest: add a 'wait' parameter")
> is a culprit, but looking closer to the code I think it simple revealed the
> broken logic from the day one, i.e. in the commit
>    0a2ff57d6fba ("dmaengine: dmatest: add a maximum number of test iterations")
> which adds iterations parameter.
> 
> So, to the point, the conditional of checking the thread to be stopped being
> first part of conjunction logic prevents to check iterations. Thus, we have to
> always check both conditions to be able to stop after given iterations.
> 
> Since it wasn't visible before second commit appeared, I add a respective
> Fixes tag.
> 
> Fixes: 2d88ce76eb98 ("dmatest: add a 'wait' parameter")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>

Yes, makes sense indeed:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>


> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/dma/dmatest.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index a2cadfa2e6d78..4993e3e5c5b01 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -662,8 +662,8 @@ static int dmatest_func(void *data)
>                  flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> 
>          ktime = ktime_get();
> -       while (!kthread_should_stop()
> -              && !(params->iterations && total_tests >= params->iterations)) {
> +       while (!(kthread_should_stop() ||
> +              (params->iterations && total_tests >= params->iterations))) {
>                  struct dma_async_tx_descriptor *tx = NULL;
>                  struct dmaengine_unmap_data *um;
>                  dma_addr_t *dsts;
> --
> 2.26.2
> 


-- 
Nicolas Ferre
