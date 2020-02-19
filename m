Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B0116440D
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2020 13:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgBSMTD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Feb 2020 07:19:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSMTD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Feb 2020 07:19:03 -0500
Received: from localhost (unknown [106.201.32.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0E8624656;
        Wed, 19 Feb 2020 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582114742;
        bh=zG2lPnCJ0h9HTg/FrJTKsOn5Ck5Pc8USzuemV1tBLgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NaPdJqG8xgOlQXcpMn4VCCORBiW66C3eBtu+Fn4dtIL8+y2mWk1aWHaPW9OpfX0P/
         nu79EQhdJgE8FblwpGhDdEHyRjE6NRtUxnNm3k7zyM3Pm8I+KXE9ztHoTq8/hcXLdl
         EKdQZ4QnUsNcYIPrOEb1kBq3HWT2vP7gJUDVIsTw=
Date:   Wed, 19 Feb 2020 17:48:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmanegine: ioat/dca: Replace zero-length array with
 flexible-array member
Message-ID: <20200219121856.GI2618@vkoul-mobl>
References: <20200214171302.GA20586@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214171302.GA20586@embeddedor>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-02-20, 11:13, Gustavo A. R. Silva wrote:
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
> This issue was found with the help of Coccinelle.

Applied, thanks

-- 
~Vinod
