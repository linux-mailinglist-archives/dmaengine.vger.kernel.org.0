Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036EF1D17FF
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbgEMO4D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 10:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388167AbgEMO4C (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 10:56:02 -0400
Received: from localhost (unknown [106.200.233.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A79FF21897;
        Wed, 13 May 2020 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589381762;
        bh=TmLJzQWM5J8FyJ9QlgN1qYfCl5hvcrcADs5LgKo6/Jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFtbvYQ69SHBfWqu/xVVJ29wQp9SPqb8sfBFiSSlV88txTzMPGp8+AEySmRnErpew
         Qwbr2HM1l2Wyiw17aBThX2Q2WrNeslml7Yx9L8Gtfnf6XBjRofbaCzfX+uelaL2EMj
         40Yp5m4i/5C1h/SHS8LjfG7puAhzDJp9J0wf73Oc=
Date:   Wed, 13 May 2020 20:25:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Replace zero-length array with
 flexible-array
Message-ID: <20200513145558.GK14092@vkoul-mobl>
References: <20200508210707.GA24136@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508210707.GA24136@embeddedor>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-05-20, 16:07, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Applied, thanks

-- 
~Vinod
