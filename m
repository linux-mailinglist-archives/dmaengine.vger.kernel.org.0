Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2361245BDC
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 07:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgHQFVX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 01:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgHQFVX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 01:21:23 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FD1020758;
        Mon, 17 Aug 2020 05:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597641683;
        bh=0ybDwR+imr95BHoU5d25QzlteuoQ8ZrdxzMMQmxwrWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTIIfTL3trRYQg1LU+PB2bfaB3Z2NBfZv4AUDMf++TJhHyFM6xZfCG1OOX2DWpQiW
         3GOwMiWOieT6xRF0EE8Z4qX9xR0v7UjfSeyiVeZP7HHW/pzqnm2FlT8arcgGyyOTF7
         LA8aSs42Eh+7B3lET+mX/m5f1Bf7cQqmVfgXBbLg=
Date:   Mon, 17 Aug 2020 10:51:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH] dmaengine: ti: k3-psil-j721e: Add entries for 2nd port
 of MCU SA2UL
Message-ID: <20200817052119.GI2639@vkoul-mobl>
References: <20200803100724.19003-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803100724.19003-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-20, 13:07, Peter Ujfalusi wrote:
> The security accelerator within MCU domain supports two ports similarly
> to the SA2UL in MAIN domain.
> 
> Add endpoint configuration for the two ingress and one egress threads of
> the second port.

Applied, thanks

-- 
~Vinod
