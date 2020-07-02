Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7459D2123C6
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgGBM5K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 08:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgGBM5J (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 08:57:09 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8994E20772;
        Thu,  2 Jul 2020 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593694629;
        bh=6HAK3qHSIcna6sA8s3JCC4sdkipPIpcQVvedZolZ6N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SS6m+TFQ+N0ptvONAjRaIIHM1ONObKIwCYCWRGIVJyIr+Wqa0NmW4co2Sd5fsxyJj
         YL+r14zbOFWhVyPSl6zJM2FuOIsJJtM0EShKHn9nKVVLsThqQoq7xEP/YCDm4x42pN
         LddZfrGkRb5dx3hyZV6p2H1RH+nLnHsFEDsrwJqY=
Date:   Thu, 2 Jul 2020 18:27:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH next 6/6] dmaengine: ti: k3-udma: Switch to
 k3_ringacc_request_rings_pair
Message-ID: <20200702125705.GB273932@vkoul-mobl>
References: <20200701103030.29684-1-grygorii.strashko@ti.com>
 <20200701103030.29684-7-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701103030.29684-7-grygorii.strashko@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-07-20, 13:30, Grygorii Strashko wrote:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> We only request ring pairs via K3 DMA driver, switch to use the new
> k3_ringacc_request_rings_pair() to simplify the code.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
