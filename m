Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D712928A
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 08:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfLWHxC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 02:53:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWHxC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Dec 2019 02:53:02 -0500
Received: from localhost (unknown [223.226.34.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D7CC206B7;
        Mon, 23 Dec 2019 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577087582;
        bh=ZDywtafLELZOwgunZ6njALEVERK9QcJfzVci1TRYhoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/LPLi/3mzqScE76JGG4kOKYc70pK5CJ4RsAsaf7vCGWfEYTnR8iJWGDI4XONa2mE
         GGsNvwizK/gTgbi9ks+Kt1fbXImJdcj2yA+4oBsOuHN0nWtLIHUY8tpCUwJc7bwpVU
         znUp8cZYhmIzh2OZM2/x/gK3VVXnj1Q0nR4EDcX4=
Date:   Mon, 23 Dec 2019 13:22:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandru.ardelean@analog.com,
        s.hauer@pengutronix.de
Subject: Re: [PATCH] dmaengine: virt-dma: Fix access after free in
 vcna_complete()
Message-ID: <20191223075257.GD2536@vkoul-mobl>
References: <20191220131100.21804-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220131100.21804-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-12-19, 15:11, Peter Ujfalusi wrote:
> vchan_vdesc_fini() is freeing up 'vd' so the access to vd->tx_result is
> via already freed up memory.
> 
> Move the vchan_vdesc_fini() after invoking the callback to avoid this.

Applied, thanks

-- 
~Vinod
