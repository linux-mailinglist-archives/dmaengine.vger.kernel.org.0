Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4A12DFCCD
	for <lists+dmaengine@lfdr.de>; Mon, 21 Dec 2020 15:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgLUO1d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 09:27:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgLUO1d (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Dec 2020 09:27:33 -0500
Date:   Mon, 21 Dec 2020 19:56:47 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608560812;
        bh=ousc0HB5M2LANA+2D9XmiqfeA4Fv5wXAoLSnmLycVyQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8EFpzwfmX6LCNBlJI6IJyinGNsLJ8J1aJiyvwCN4peTJmSe5xP/n4uxHR+AD341T
         mUB+6h963039Oyb/j2X+wseaKRso/5Z0qhiN8CNV7JboUjlBdhlEJ6mwd5I2rV0mwn
         SN2Uk0X3ay9vFo1RJkLVJv6hjKh+Ag+8TJ/7JTjLN/EYtUbIj1T0mNbfcgkmJHotwT
         LiLyygZdYXtKZX8uWBvfvIstfbEBCDShn7wMWZJjIRHPpu2nNQji7odTL1vPAQ2pag
         +J5zp+gdaRaGznBDCaXunUWlOjUBFqmQ3mj2S2DGdET5Jy/6hgjRMauBDBbrtbrNOx
         7wDyGfvPXv7ig==
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.j.williams@intel.com, jaswinder.singh@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: milbeaut-xdmac: Fix a resource leak in the
 error handling path of the probe function
Message-ID: <20201221142647.GE3323@vkoul-mobl>
References: <20201219132800.183254-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201219132800.183254-1-christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-12-20, 14:28, Christophe JAILLET wrote:
> 'disable_xdmac()' should be called in the error handling path of the
> probe function to undo a previous 'enable_xdmac()' call, as already
> done in the remove function.

Applied, thanks

-- 
~Vinod
