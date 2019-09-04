Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB39A7B2A
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 08:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfIDGHY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 02:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfIDGHY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 02:07:24 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 420FB2339D;
        Wed,  4 Sep 2019 06:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567577243;
        bh=r/RhtvVdb93jaVY8DOQhpjoQFOoQJyNGJVdtjOEj6z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wrAZDOwbk3KHXZ56Q4xHPABsjIX4K+fVkvbwlFriJx7Eh1HTro1cb5wZitJvZfYy4
         1lAUhfNUKHcUspNrO0xALygwONKNjbhsgMtfCf7qGBW4DnIKctFAbkreP4ISCRIob5
         blCAhdZxRFGPVVBnebhlMUdYtO+A0vg/LRBxpAL0=
Date:   Wed, 4 Sep 2019 11:36:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: rcar-dmac: Fix DMACHCLR handling if iommu
 is mapped
Message-ID: <20190904060614.GF2672@vkoul-mobl>
References: <1567424643-26629-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567424643-26629-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-09-19, 20:44, Yoshihiro Shimoda wrote:
> The commit 20c169aceb45 ("dmaengine: rcar-dmac: clear pertinence
> number of channels") forgets to clear the last channel by
> DMACHCLR in rcar_dmac_init() (and doesn't need to clear the first
> channel) if iommu is mapped to the device. So, this patch fixes it
> by using "channels_mask" bitfield.
> 
> Note that the hardware and driver don't support more than 32 bits
> in DMACHCLR register anyway, so this patch should reject more than
> 32 channels in rcar_dmac_parse_of().

Applied, thanks

-- 
~Vinod
