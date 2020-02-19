Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90F02164410
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2020 13:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgBSMTW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Feb 2020 07:19:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSMTW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Feb 2020 07:19:22 -0500
Received: from localhost (unknown [106.201.32.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58AAE206EF;
        Wed, 19 Feb 2020 12:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582114762;
        bh=TRqdYvf0Y/OocZGiHSaC6g7JfORCgxGpXUneLxerl7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEYzU+xJZ1mUDGzY+Wk5jX3Ao87PrhkgCkGcwFaNaIcf5f/sex90Bh/KrmfpGmk8W
         qI5UmzzrvAYoFJ//H9EZmMPKud+EdayAbvfuDJKFWwZ13l/2eg0msjL9yKtLrX+VrJ
         cFBMtMW9SdutaDRHM4gjHL4ynT3Lz9ECA0iM8ZNg=
Date:   Wed, 19 Feb 2020 17:49:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sa11x0: Replace zero-length array with
 flexible-array member
Message-ID: <20200219121918.GJ2618@vkoul-mobl>
References: <20200214171435.GA22930@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214171435.GA22930@embeddedor>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-02-20, 11:14, Gustavo A. R. Silva wrote:
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
