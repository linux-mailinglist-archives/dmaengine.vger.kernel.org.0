Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C62D346C6
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2019 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfFDMbP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 08:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfFDMbP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 Jun 2019 08:31:15 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE7523E30;
        Tue,  4 Jun 2019 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559651474;
        bh=dQ7XidRn8nhHn/npV7YYlxeNwNQENKUs3m0lmgeliLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6aZDDwIwcsV7ZpXUF9p0gTbtl9CPtGGvvzmIFCtIicHutWFd7sAAmVCb6aG9CWee
         vos9CObhCxqn8vC9hyUlPdDoPQl5eecau9dUJ62eZC51q3PE8jQx/weLKgMLjlMBCm
         jfXgEdP2jI/RtE/Rjlm7hIQ7UDT4hG5P7qbz47oY=
Date:   Tue, 4 Jun 2019 17:58:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v3 3/7] dmaengine: sun6i: Add a quirk for setting DRQ
 fields
Message-ID: <20190604122807.GB15118@vkoul-mobl>
References: <20190527201459.20130-1-peron.clem@gmail.com>
 <20190527201459.20130-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527201459.20130-4-peron.clem@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-05-19, 22:14, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 DMA has more than 32 possible DRQs. That means that current maximum
> of 31 DRQs is not enough anymore.
> 
> Add a quirk which will set source and destination DRQ number.

Applied, thanks

-- 
~Vinod
