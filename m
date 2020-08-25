Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB5251696
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgHYKYh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 06:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHYKYg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 06:24:36 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C12D2068F;
        Tue, 25 Aug 2020 10:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598351076;
        bh=nxYs4fpJNAPXWZ2rnNSqCI4wtxqhwqDaF7x8O0WM3WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueq+YdcNgQgDwpW27HnkKqEPUc1lTcbncjdhRQC3zGcmnzb10xXY8q7XXOey+3x5D
         XejtPIzKI0N5l6PMGCTblrxRwbKnc/hqmtpieALT6jaDKjq87ea6ZbYjnaX2Cqnq/B
         icTDKQOXwEOhTf9AD2pLm6L9IzXEx7c8s3jAxVy4=
Date:   Tue, 25 Aug 2020 15:54:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Remove redundant
 is_slave_direction() checks
Message-ID: <20200825102432.GE2639@vkoul-mobl>
References: <20200824120120.9270-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824120120.9270-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-08-20, 15:01, Peter Ujfalusi wrote:
> The direction has been already validated in the main callback and there is
> no need to check it again in the TR mode handlers for slave_sg and cyclic.

Applied, thanks

-- 
~Vinod
