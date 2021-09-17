Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC58B40FC19
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242637AbhIQPWX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 11:22:23 -0400
Received: from ale.deltatee.com ([204.191.154.188]:51246 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245612AbhIQPVu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Sep 2021 11:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:To:cc:content-disposition;
        bh=yl9vjgcSxbXyjBnV1ZJmnZ4kxoytLHzu6HHzbfwRuiI=; b=V8pd4DR4PBlkyzm6eQWuZvxqTt
        x7oMKqTNkuQ3geVuTAO7ToGGRCSU0XsXXf0eQP/vfc/vkBMKXa7r12GACogFxoxJ3R1wM2Z1PYi+K
        N2IqGlY9BJf9JWtQdweKT2ahqe6tqISMe+9KuQGGLnyt2fBJ6uQJax/VWKpvPaz26/y8oLdvLSL16
        X8T7OAAHOK8BpoJ8zGeHEhicnfIQyqLO2pXu8GvdHimEwGiiQx6fuTj/esJHrthF9Ydo1XrImI5NX
        5quHxfhObofXLC3C2T0DH7SIcqi1744zkvpZNvH25N1xbWBcpBFdsBIwe+zgEqmmhB85XBY+Ozk8X
        sE3Rer4w==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mRFf8-0001nI-8K; Fri, 17 Sep 2021 09:20:27 -0600
To:     Qing Wang <wangqing@vivo.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1631863081-10231-1-git-send-email-wangqing@vivo.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <eeaee4a8-12d4-fb1d-bd4d-9cb3a60a3432@deltatee.com>
Date:   Fri, 17 Sep 2021 09:20:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1631863081-10231-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, wangqing@vivo.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] dma: plx_dma: switch from 'pci_' to 'dma_' API
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2021-09-17 1:18 a.m., Qing Wang wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below.
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
> 
> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)
> 
> While at it, some 'dma_set_mask()/dma_set_coherent_mask()' have been
> updated to a much less verbose 'dma_set_mask_and_coherent()'.
> 
> This type of patches has been going on for a long time, I plan to 
> clean it up in the near future. If needed, see post from 
> Christoph Hellwig on the kernel-janitors ML:
> https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>

Looks good to me. Thanks.

Reviweed-by: Logan Gunthorpe <logang@deltatee.com>
