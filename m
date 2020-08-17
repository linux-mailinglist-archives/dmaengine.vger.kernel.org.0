Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717E0245BDD
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 07:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgHQFVf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 01:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgHQFVf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 01:21:35 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4514D2076E;
        Mon, 17 Aug 2020 05:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597641695;
        bh=WMlBOQjOaWYCzN/6U7ezEqZiEQ/cEa/M09nz9NeU/lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuIcKR7gEAMvt5/AINTWwIod8mbEDHMESI2f/IgBtkkLKrTA/CD6vzsvrGAWnIhyC
         9vjrytMg9ltvS97UCOgU2gd4WNSi3VupXRkA5mXSnCkw1rXS6AkNt2zILD3c8J1tUS
         c4gB8gGE4M933vL7pUG/G642s0vfTLAtn3DoM/Rk=
Date:   Mon, 17 Aug 2020 10:51:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        linux-arm-kernel@lists.infradead.org, nm@ti.com,
        grygorii.strashko@ti.com, lokeshvutla@ti.com, nsekhar@ti.com,
        kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] dmaengine: ti: k3-psil: Add support for j7200
Message-ID: <20200817052131.GJ2639@vkoul-mobl>
References: <20200803125713.17829-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803125713.17829-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-20, 15:57, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Drop unrelated empty line change in patch 1 (k3-psil.c)
> 
> j7200 uses the same DMA hardware but have different set of peripherals, needing
> different PSI-L thread map compared to j721e.
> 
> To simplify the runtime PSI-L map selection we will switch to use
> soc_device_match.

Applied, thanks

-- 
~Vinod
