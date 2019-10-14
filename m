Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D96CD5CBD
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 09:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfJNHxQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 03:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfJNHxQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 03:53:16 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8B820854;
        Mon, 14 Oct 2019 07:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571039595;
        bh=7ebQ8kTue/iy+/rFQ6iW23VOTWInv0+ZApP4SxVaAYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fr+KavdQrDOvFkyPt3NkhLK5ayBfbpX2bQzkoxok+TVIUuUoDC82MBC5uBVo01LM4
         hci88/NGW3fCtaVm/DaN4Gw/ift+Ek8hO8KElzDK7tFXfX7ahwe3qBvc0ax1BTJCM5
         EFDWog7UuV7m2N7CrRoFoUE7Mx4T7N5bG/vi/MV8=
Date:   Mon, 14 Oct 2019 13:23:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: zx: Use devm_platform_ioremap_resource() in
 zx_dma_probe()
Message-ID: <20191014075311.GJ2654@vkoul-mobl>
References: <85de79fa-1ca5-a1e5-0296-9e8a2066f134@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85de79fa-1ca5-a1e5-0296-9e8a2066f134@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-09-19, 14:37, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 14:32:12 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.

Applied, thanks

-- 
~Vinod
