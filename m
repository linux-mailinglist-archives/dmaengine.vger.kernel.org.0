Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42DB3D8DC3
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 14:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhG1M1n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 08:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbhG1M1n (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 08:27:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3D5260F9C;
        Wed, 28 Jul 2021 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627475261;
        bh=AvP3Xrjm+28bAqXbEHtVbmdnSbEETUrOtjrtJ1pR7nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ln73SUjLGUyq+sZJ1p1+5rdtjdWEEoP1HCJmx7L9X8VDMOANHbE2Ws8pvgjBj3Rpl
         qVwCvmesa2GjRmcQf0Fecwoqw7lWUUBRXlEepQmXTvC5+Kx770oTFoic53Ji5+SPRB
         Rs6LqV3ag9J1r1yJ8N59dJk3QUkSKLWEa3emhvxUXAOTpkaiF0ccx0rQIBt8mmcdBo
         WkcVEKY2Pb2FUjEXjuVGlHMkW9TNxwm/gcvsXhBzEdhAOagqlXeDgc65/uUu0+h2br
         6RtNPQr5gpYCrfOaZ7KXecadATqNJU6xAc6DHEMkmZNRNoGWSbTjoX6cr0a3ElM7pB
         +71bMpsy66X6Q==
Date:   Wed, 28 Jul 2021 17:57:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Ramesh Thomas <ramesh.thomas@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmanegine: idxd: add software command status
Message-ID: <YQFNOaJaUu9UYQ7z@matsya>
References: <162681373579.1968485.5891788397526827892.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162681373579.1968485.5891788397526827892.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-07-21, 13:42, Dave Jiang wrote:
> Enabling device and wq returns standard errno and that does not provide
> enough details to indicate what exactly failed. The hardware command status
> is only 8bits. Expand the command status to 32bits and use the upper 16
> bits to define software errors to provide more details on the exact
> failure. Bit 31 will be used to indicate the error is software set as the
> driver is using some of the spec defined hardware error as well.

Applied, thanks

-- 
~Vinod
