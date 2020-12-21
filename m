Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E512DFCBC
	for <lists+dmaengine@lfdr.de>; Mon, 21 Dec 2020 15:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgLUOXP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 09:23:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgLUOXP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Dec 2020 09:23:15 -0500
Date:   Mon, 21 Dec 2020 19:52:30 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608560554;
        bh=SqtEboAk0qd7ZTX5Jqa9whnweGmlKEOCqrijvdgNhqg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeSf5XtXJsUe6a0O/9Pc20cEAMFQh/AENbDrRZEt7yhefwRNcHz4B53zaW0Pb1Oho
         x0mx6d3Tnrw26tM710ugH6Zne6wSANiIEZF467nXzbxw/gn9UvcrmXIUO1t6ttzFjp
         9TA+v1gWDavb8j4T71V445APgxIGJRPZ5QhExleuk1qIKqXYRAF0OF8FXD0gVAcd/m
         LR1bsaJ7/Cc6njwaDq7lDvbUf9V3Hr4ttunit0blYL/YQlnle/n6ocJw0UeIAPyMmy
         9QnJ58xuT9gIQ3qxQjN1jp1zSo6FbUTlICnFw+bE44cG4/3/KzS7DJcRKAyzlfgnDE
         BIAF9EFuEhX7Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     sean.wang@mediatek.com, dan.j.williams@intel.com,
        matthias.bgg@gmail.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mediatek: mtk-hsdma: Fix a resource leak in
 the error handling path of the probe function
Message-ID: <20201221142230.GD3323@vkoul-mobl>
References: <20201219124718.182664-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201219124718.182664-1-christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-12-20, 13:47, Christophe JAILLET wrote:
> 'mtk_hsdma_hw_deinit()' should be called in the error handling path of the
> probe function to undo a previous 'mtk_hsdma_hw_init()' call, as already
> done in the remove function.

Applied, thanks

-- 
~Vinod
