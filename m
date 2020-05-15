Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4291D4688
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 08:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgEOG5n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 02:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgEOG5n (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 02:57:43 -0400
Received: from localhost (unknown [122.178.196.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 504C1206F1;
        Fri, 15 May 2020 06:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589525863;
        bh=jnCPwiqOh+zJ3vviW4gFRvxdkVv56zAejpkrdVS/M1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bd6FrTEISeLwQQsUio8f6e/UuDg4BLKeU+zfDaBnwZsR9usUiKyMVXo/liQopANsf
         rSHYDVg+aMjVYbnaz/GvSxC7slHFAo960hkmom39PtNsKCqpmezYK8hOoOEaCBhznc
         EvvpFShs8ZwXrq33PSr2H6U9Eab0qbSfvqsMroWU=
Date:   Fri, 15 May 2020 12:27:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Robin Gong <yibin.gong@nxp.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: initialize all script addresses
Message-ID: <20200515065732.GK333670@vkoul-mobl>
References: <20200513060405.18685-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513060405.18685-1-s.hauer@pengutronix.de>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-05-20, 08:04, Sascha Hauer wrote:
> The script addresses array increases with each new version. The driver
> initializes the array to -EINVAL initially, but only up to the size
> of the v1 array. Initialize the additional addresses for the newer
> versions as well. Without this unitialized values of the newer arrays
> are treated as valid.

Applied, thanks

-- 
~Vinod
