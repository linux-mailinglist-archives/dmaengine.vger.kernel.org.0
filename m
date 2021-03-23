Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453443465A5
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 17:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhCWQsq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Mar 2021 12:48:46 -0400
Received: from ale.deltatee.com ([204.191.154.188]:35984 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhCWQsa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Mar 2021 12:48:30 -0400
X-Greylist: delayed 1607 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Mar 2021 12:48:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=uvFq+Kc5ZBHy3S9lipYlZNBR57AfmiflcCRMDFpDWAw=; b=KL1e3lBgC4m9cW7SgdHDBgaqVI
        WhQyyoiX8DB8RF50zbxPc1W3GoBOkrF3Og5waUB9spSRTigwH1VE72RO8Z7nqybyc2TeNht9wcmcf
        c2CAIl0dEVF9dRZpVNTR0hHEbjwZ7dvyuUv9Gx6MzzfeMK7nMYaHoUls2B1FZeAYt3L8yZnLMwM5U
        bvk3zYfTW03exmO/l8WXys4Cno2XVWuAXXTM/0Dua2xOXbVn/ObETyXcNOm9D9AHrZxctuJBcZvaE
        GSMx3g+7AxW+bC5AbRTonGKg+gtKf+mFEXzDAQcTz4xmaonJJDo5btZBS8PcZua61RlA2EZum8eIU
        8WlkBVPw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lOjmk-0005cx-BB; Tue, 23 Mar 2021 10:21:39 -0600
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YFnq/0IQzixtAbC1@mwanda>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <603f6cf3-ed7b-ae5c-6689-f13390385037@deltatee.com>
Date:   Tue, 23 Mar 2021 10:21:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YFnq/0IQzixtAbC1@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, dan.carpenter@oracle.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] dmaengine: plx_dma: add a missing put_device() on error
 path
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2021-03-23 7:19 a.m., Dan Carpenter wrote:
> Add a missing put_device(&pdev->dev) if the call to
> dma_async_device_register(dma); fails.
> 
> Fixes: 905ca51e63be ("dmaengine: plx-dma: Introduce PLX DMA engine PCI driver skeleton")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch. Thanks Dan!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
