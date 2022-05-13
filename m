Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441B45264CC
	for <lists+dmaengine@lfdr.de>; Fri, 13 May 2022 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353062AbiEMOh7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 May 2022 10:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381582AbiEMOgR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 May 2022 10:36:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B7C1D7356;
        Fri, 13 May 2022 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652452236; x=1683988236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1IiINc6RVJg7cdsH+DvfTtXS4rj6TawHCbsFN/TV4tA=;
  b=N6ex+VjK35BCLO7+kI6OsibjiOGUZSOOHMPCr8cn09OdfIV/kMLb2QP0
   fb/x4VJMlIOWMKRNMZGwrc/qALAh4OsRHH0ZxCEi1yj2oxSmCAChs4MDQ
   YxHYclH5OideTnjMDe2oGLKdqcYKU6pQzKlP2B+YpYEd+JQoOH0HKpdo6
   DYRkkMMJfTiahoMpF8/dWUCv18oeSva+L3TmWVBjVKSIWEUXYARJuEoKP
   gxSKH8a2t0Cvt059GVWK8l4JXVEVDJwoI+pk8XdEL5CRQ/4tpxCX7/0iJ
   EcaEBQrxuJpReHaqRlZMwynWZ8tcqbUwCCE4WPk5xwjWXO93bs0hy4Id3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="295576148"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="295576148"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 07:30:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="815397629"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.213.170.28]) ([10.213.170.28])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 07:30:35 -0700
Message-ID: <2470523a-3508-e788-8407-d6142487b355@intel.com>
Date:   Fri, 13 May 2022 07:30:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] dmaengine: idxd: Remove unnecessary synchronize_irq()
 before free_irq()
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220513081622.1631073-1-chi.minghao@zte.com.cn>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220513081622.1631073-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 5/13/2022 1:16 AM, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Calling synchronize_irq() right before free_irq() is quite useless. On one
> hand the IRQ can easily fire again before free_irq() is entered, on the
> other hand free_irq() itself calls synchronize_irq() internally (in a race
> condition free way) before any state associated with the IRQ is freed.

Fair enough. Thanks.

Acked-by: Dave Jiang <dave.jiang@intel.com>


>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>   drivers/dma/idxd/device.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5363fb9218f2..9dd8e6bb21e6 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1179,7 +1179,6 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
>   	struct idxd_device *idxd = wq->idxd;
>   	struct idxd_irq_entry *ie = &wq->ie;
>   
> -	synchronize_irq(ie->vector);
>   	free_irq(ie->vector, ie);
>   	idxd_flush_pending_descs(ie);
>   	if (idxd->request_int_handles)
> --
> 2.25.1
>
>
