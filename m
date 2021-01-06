Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07AF2EB9F9
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jan 2021 07:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbhAFGXW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jan 2021 01:23:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbhAFGXW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 6 Jan 2021 01:23:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A679207B5;
        Wed,  6 Jan 2021 06:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609914162;
        bh=kzLo70rKSW1QqPkPCqpgUW4MYoaMkGuUhUMP5uT4NWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vL0EUErVXr6TvTyUFZzDWPNfLtartivcfV5FAl9rVEf80PWNFBdphSamhQWJryyp3
         j7yE7Vla0SV2Z2C0FiKjgzxPmdohbhDm7ULH5WAG2DwhLfHkG1cuJ5RYIU39HwLXye
         SZyyM8moOR3MlhpUEM/jUYP/A7hcqi+8fHoi24FVzyN4KmT4DDNQJeSYrHH2LJtw8L
         i8DVpjhwyfxTbJnIgDerxxi+Yf+UOovVrqwihVnKtltYzecYQ6W2FI94WBu3bXN6po
         yrJUMrxUc1HW/E0fmkpfHZ23dV4Pp7fOqus3pyZZd7+T4QOcU/pYOytthxpD0loASK
         fffizpnJsMO+g==
Date:   Wed, 6 Jan 2021 11:52:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/13] dmaengine: owl: Add compatible for the Actions
 Semi S500 DMA controller
Message-ID: <20210106062238.GQ2771@vkoul-mobl>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
 <88dc9dc064fd4c71f7ad46f172b05b09b9777e42.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88dc9dc064fd4c71f7ad46f172b05b09b9777e42.1609263738.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-12-20, 23:17, Cristian Ciocaltea wrote:
> The DMA controller present on the Actions Semi S500 SoC is compatible
> with the S900 variant, so add it to the list of devices supported by
> the Actions Semi Owl DMA driver. Additionally, order the entries
> alphabetically.

Applied, thanks

-- 
~Vinod
