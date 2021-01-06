Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8DA2EB9F6
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jan 2021 07:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbhAFGWv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jan 2021 01:22:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbhAFGWu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 6 Jan 2021 01:22:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D46B20727;
        Wed,  6 Jan 2021 06:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609914130;
        bh=Aut+AfZpuC4LAkWLnjA5H5xNGL/2OTnjCEP5D3f/cKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwD6oMpraW+C1Bo9Sa9PUKCWHd+sVHzjTBnb+HaPOHADoB3wmJTXFMxuROHc5up3Z
         1YGQ18eFcW9pZo77P6Kp6SuSymHMNMJ309ncX6wD32xB6NeKBsqz/Z1ixB2PvQL7R7
         +R/EJGeu5uFmnFaHv6FBEv3sACt/kQBpBn6WQy9cgTb//sbST1NlHKMu25koBhezPm
         9CMlep1BIXZq+A9fk0Y9x+VThkboSJylbWDJ9syfyswmnNQjxBVCjcLfH+2FRSQUMT
         2khZiIUUkRRjEr3L39jvgGktCAIUXHs6bKz88z9lyXdb113GCMNSMhpHZjygwX4Td9
         s/cWbeG0VqSjg==
Date:   Wed, 6 Jan 2021 11:52:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 04/13] dt-bindings: dma: owl: Add compatible string
 for Actions Semi S500 SoC
Message-ID: <20210106062206.GP2771@vkoul-mobl>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
 <2bd23ef5dad5dd613006c20d714b1be3c4d38e7a.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bd23ef5dad5dd613006c20d714b1be3c4d38e7a.1609263738.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-12-20, 23:17, Cristian Ciocaltea wrote:
> Add a new compatible string corresponding to the DMA controller found
> in the S500 variant of the Actions Semi Owl SoCs family. Additionally,
> order the entries alphabetically.

Applied, thanks

-- 
~Vinod
