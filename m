Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BEA35C284
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 12:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbhDLJpX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 05:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239702AbhDLJo0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 05:44:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 047A16120B;
        Mon, 12 Apr 2021 09:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618220648;
        bh=dUn3RpHAGg64ypL7+r7XbIHX+Y/jL4UbUArvirEgV+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRtnxc5C9AyLKZxt/EGWzKOG0W48kqL8Z/yJEHKwNZ1onNLJvv1x6YZ2loVXy8Oll
         E5lkLtH+MiT2Nx3f72XPbQhRBTRWo342TKckP2ZD5UkY8SVg9hzIT5LSxxX31fxHMC
         ci0KHcp6pmST2AhynRUj7BVpj/kGTB7xjR7oxRLsBRHqRLn3cDZnNz4ddyUIjMyX7E
         VyOppe8O7x9juCytP/ypuPTSmhIcoIjTftsKmmyhtpCzbYyH73QjC7gkfHWCqqx+fT
         0CBPM5PFbNM9mjpXmhtASmmx4jZlm5f44VFhgmCyYcx6jEk0lcXI77tMJ/tRi5oVSS
         SMJKUwPoR7jWw==
Date:   Mon, 12 Apr 2021 15:14:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: plx_dma: add a missing put_device() on error
 path
Message-ID: <YHQWZKTTjum45ucy@vkoul-mobl.Dlink>
References: <YFnq/0IQzixtAbC1@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFnq/0IQzixtAbC1@mwanda>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-03-21, 16:19, Dan Carpenter wrote:
> Add a missing put_device(&pdev->dev) if the call to
> dma_async_device_register(dma); fails.

Applied, thanks

-- 
~Vinod
