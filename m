Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B505E3C7ED5
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 08:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhGNHAb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 03:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237948AbhGNHAb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 03:00:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAD26613B2;
        Wed, 14 Jul 2021 06:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626245860;
        bh=L1cy5eHhKewe3yZhJhhNVHmNdL/JfGYL9XQgmRYIfCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B87g0zX7i0Id/fsY+w+vDQl5KKTBDrai0Dbf9zLpbN8qrvV1E8tlJhzJtmJ5hlDFQ
         sqZmf5Ws7ICBxfaXSps+c7YiolCiKgzlHh8RWTNlrsTN/o5a4RjPBhst8SLWqxPSho
         XUNmkkEf0qOrXOX+68B7uFlb1AFsqbXxUGOZfIgO97A26+JCRmfLg7+X8q8hBRN78g
         9jzo0awZM0R5g4P5E9ZuN4kgiJ/FymxOqz43Vsk2chGB8NTP23xmPoNk8NFXGNWo7q
         JDep4Nu7xl/XeeGWkgVCtwYSA2ETdSPlx/N9uZbNvQRGx7xSHi9dpZb3rhhtainXY8
         meS2DW/rZ+4Yw==
Date:   Wed, 14 Jul 2021 12:27:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix array index when int_handles are
 being used
Message-ID: <YO6K4F735rP7Us0J@matsya>
References: <162456176939.1121476.3366256009925001897.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162456176939.1121476.3366256009925001897.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-06-21, 12:09, Dave Jiang wrote:
> The index to the irq vector should be local and has no relation to
> the assigned interrupt handle. Assign the MSIX interrupt index that is
> programmed for the descriptor. The interrupt handle only matters when it
> comes to hardware descriptor programming.

Applied, thanks

-- 
~Vinod
