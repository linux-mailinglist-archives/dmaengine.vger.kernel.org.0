Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F103C7D9F
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 06:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhGNEy0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 00:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhGNEy0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 00:54:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EBBD61279;
        Wed, 14 Jul 2021 04:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626238295;
        bh=ZUuKx8JUJUmAx8O6JtJM11rFRkviag38sXcb2U31Y2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVvRo1AP76edOth0nlVVrqbWbIg6NcMriHwPlxW++0vwUIdMjis9TXndtpwJ+lMrs
         UdLmoTljf/bZEY+zIe8vyoRMoGhWjB2+DvMKqDaVPtvnOBCR/9VFJLu4MnxQJ8KkTN
         5OmRul+imMIee/tqpv4G/yizpbmtdrXbZGF2X09X5rej4FvPYzMtMXHG5/wLrq1uaU
         1tc+tqNZgX7eVilU7JY9FkfHPEkLTU3bWvyq2w60Ycn11HLHW+eRagluwBIwPeHygj
         uuTFcJ5VapNXqb86sZaoSjluLGmyRn1X2iPXzPKuP4HmOXFnvHNYRBFhulbwqhFZY9
         6lVGAOidc6g6w==
Date:   Wed, 14 Jul 2021 10:21:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dave.jiang@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Simplify code and axe the use of a
 deprecated API
Message-ID: <YO5tU2KWW1Sabk35@matsya>
References: <70c8a3bc67e41c5fefb526ecd64c5174c1e2dc76.1625720835.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70c8a3bc67e41c5fefb526ecd64c5174c1e2dc76.1625720835.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-07-21, 07:08, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> Replace 'pci_set_dma_mask/pci_set_consistent_dma_mask' by an equivalent
> and less verbose 'dma_set_mask_and_coherent()' call.
> 
> Even if the code may look different, it should have exactly the same
> run-time behavior.
> If pci_set_dma_mask(64) fails and pci_set_dma_mask(32) succeeds, then
> pci_set_consistent_dma_mask(64) will also fail.

Applied, thanks

-- 
~Vinod
