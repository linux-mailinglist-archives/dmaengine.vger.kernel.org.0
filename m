Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0013F3D6D1E
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jul 2021 06:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhG0EFy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Jul 2021 00:05:54 -0400
Received: from mx.socionext.com ([202.248.49.38]:3026 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233760AbhG0EFx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Jul 2021 00:05:53 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Jul 2021 13:05:53 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id AE573205902A;
        Tue, 27 Jul 2021 13:05:53 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 27 Jul 2021 13:05:53 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 26887B633F;
        Tue, 27 Jul 2021 13:05:53 +0900 (JST)
Received: from [10.212.29.138] (unknown [10.212.29.138])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id EEA0DA911B;
        Tue, 27 Jul 2021 13:05:52 +0900 (JST)
Subject: Re: [bug report] dmaengine: uniphier-xdmac: Add UniPhier external DMA
 controller driver
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dmaengine@vger.kernel.org
References: <20210726073436.GA9691@kili>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <3e36256e-d7ac-f727-c714-b79f3d1d1da7@socionext.com>
Date:   Tue, 27 Jul 2021 13:05:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726073436.GA9691@kili>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dan,
Thank you for reporting.

On 2021/07/26 16:34, Dan Carpenter wrote:
> Hello Kunihiko Hayashi,
> 
> The patch 667b9251440b: "dmaengine: uniphier-xdmac: Add UniPhier
> external DMA controller driver" from Feb 21, 2020, leads to the
> following static checker warning:
> 
> 	drivers/dma/uniphier-xdmac.c:212 uniphier_xdmac_chan_stop()
> 	warn: sleeping in atomic context
> 
> drivers/dma/uniphier-xdmac.c
>      197 static int uniphier_xdmac_chan_stop(struct uniphier_xdmac_chan *xc)
>      198 {
>      199 	u32 val;
>      200
>      201 	/* disable interrupt */
>      202 	val = readl(xc->reg_ch_base + XDMAC_IEN);
>      203 	val &= ~(XDMAC_IEN_ENDIEN | XDMAC_IEN_ERRIEN);
>      204 	writel(val, xc->reg_ch_base + XDMAC_IEN);
>      205
>      206 	/* stop XDMAC */
>      207 	val = readl(xc->reg_ch_base + XDMAC_TSS);
>      208 	val &= ~XDMAC_TSS_REQ;
>      209 	writel(0, xc->reg_ch_base + XDMAC_TSS);
>      210
>      211 	/* wait until transfer is stopped */
> --> 212 	return readl_poll_timeout(xc->reg_ch_base + XDMAC_STAT, val,
>      213 				  !(val & XDMAC_STAT_TENF), 100, 1000);
>                                                                      ^^^
> This is doing a 100 us sleep but both callers hold a spin lock.

Yes, this waiting code is in spin lock context.
I think that the function needs to be rewritten in tasklet.

Thank you,

---
Best Regards
Kunihiko Hayashi
