Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F261595D9F
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 13:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfHTLmS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 07:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfHTLmS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 07:42:18 -0400
Received: from localhost (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201E2214DA;
        Tue, 20 Aug 2019 11:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566301337;
        bh=3hAXI1PeAZZhCXXrvlgihDZlqD2jxXKi7DAm5+kp95Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbFe5xweEkT3MMN6vCPPCTh8ym/rWhrbBLG9rD8I171gzZJb5ZmYNes5gc8lT25tk
         Tvir7XBjTp6KKVBNvlpOE/7H9rX5ivMjeT3OqudnnlAiUSHPa/ocEWCEX4gpABt0BW
         VpS1+7wFKq2foBbwXcaxiZzBumupmjvpTdH7e64g=
Date:   Tue, 20 Aug 2019 17:11:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 linux-next 0/2] change mux_configure32() to static
Message-ID: <20190820114105.GW12733@vkoul-mobl.Dlink>
References: <20190814072105.144107-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814072105.144107-1-maowenan@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-08-19, 15:21, Mao Wenan wrote:
> First patch is to make mux_configure32() static to avoid sparse warning,
> the second patch is to chage alignment of two functions.

The subsystem name is "dmaengine" please use that in future, I have
fixed that and applied

> v2: change subject from "drivers: dma: Fix sparse warning for mux_configure32"
> to "drivers: dma: make mux_configure32 static", and cleanup the log. And add 
> one patch to change alignment of two functions. 
> 
> Mao Wenan (2):
>   drivers: dma: make mux_configure32 static
>   drivers: dma: change alignment of mux_configure32 and
>     fsl_edma_chan_mux
> 
>  drivers/dma/fsl-edma-common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.20.1

-- 
~Vinod
