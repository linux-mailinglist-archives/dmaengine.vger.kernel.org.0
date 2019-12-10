Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25DA118033
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 07:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfLJGKj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 01:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfLJGKj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Dec 2019 01:10:39 -0500
Received: from localhost (unknown [106.201.45.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AD63206D5;
        Tue, 10 Dec 2019 06:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575958238;
        bh=wss5KOMozwNJ7IbO6/TGR/7JjrGyuf2+4w871VahvrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=epepB2ksfpxtkyioiGrXtZpwdNJQ8Twf2ZngMLYUzpy0Km6MStZYoHSDZqtdCw6WY
         tmkm4S/NyBynSwgJLpK1jfyi5Z0Mc7iGawTLTmXvuGC2x0y+T0zKcZwM45Jxe9qvly
         34H7ZYxKXKz9ZNUUKX+OlBsgBfhBZlm7GQHg0T9s=
Date:   Tue, 10 Dec 2019 11:40:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Remove spaces before TABs
Message-ID: <20191210061034.GT82508@vkoul-mobl>
References: <20191206132435.29139-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206132435.29139-1-geert+renesas@glider.be>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-12-19, 14:24, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/dmaengine.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 8fcdee1c0cf9559f..dfd2d35b64af822a 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -481,7 +481,7 @@ struct dmaengine_unmap_data {
>   * @cookie: tracking cookie for this transaction, set to -EBUSY if
>   *	this tx is sitting on a dependency list
>   * @flags: flags to augment operation preparation, control completion, and
> - * 	communicate status
> + *	communicate status
>   * @phys: physical address of the descriptor
>   * @chan: target channel for this operation
>   * @tx_submit: accept the descriptor, assign ordered cookie and mark the


Applied, thanks

-- 
~Vinod
