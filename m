Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15309CE19C
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2019 14:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfJGM0S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Oct 2019 08:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbfJGM0S (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Oct 2019 08:26:18 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C02C206BB;
        Mon,  7 Oct 2019 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570451177;
        bh=ybZA8uHbH1kUFEz3RAt6H8nUXBLJJ4oQBdCZsGFUanE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdCUeoFTh95l2G0L8i1NKhLH0Wnh8lv5MnNVimQwXGjh72OUjJTcJvjQmmqN7Q7YT
         daD/KCamucT5RNx7sktQUbPia937pyfHR6UJblaXngvMS6DgqAI1ddCsDTh7X5+cGr
         C3xKKJKSRFTZ0W9xT9j4A8R1kx3R8fjUGHzKKsPY=
Date:   Mon, 7 Oct 2019 20:25:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nie <jun.nie@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: zx: Use devm_platform_ioremap_resource() in
 zx_dma_probe()
Message-ID: <20191007122546.GK7150@dragon>
References: <85de79fa-1ca5-a1e5-0296-9e8a2066f134@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85de79fa-1ca5-a1e5-0296-9e8a2066f134@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Sep 22, 2019 at 02:37:13PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 14:32:12 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Shawn Guo <shawnguo@kernel.org>
