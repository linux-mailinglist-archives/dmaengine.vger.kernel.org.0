Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5853C7ED6
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 08:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhGNHAn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 03:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237948AbhGNHAn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 03:00:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D5F46100C;
        Wed, 14 Jul 2021 06:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626245872;
        bh=FGm4fJkUZ8hM3Kn8jLZpJQD5fv1LvXH6R9PJwuhr49k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPd9m7tAU9OV6WG1K4OcEP5GmPY9qQClWRqDHwKMa7no0v9xHS4V3neUbaMA5HMmJ
         IMyr0sKUp1Sx3bIrguCQTzm0kiC5jSWaZTcN7TVotDqqnIgrWkqGQQ+a0LnaiH1i5C
         5WUHWg7IuRgRp/4DHaI/v+Ks3FgDZK/95iEyUxHYPPumQ4JfD1gaDF0PE6X+8MNmAK
         FKjl8JNnvdAgQMfkxHl75wtULOXxpNMpNX8iG43npbJextVVIwrnzIO1U5CBPZ9ian
         kuaWZBnS94+4VYx15QN4vvfqbqFA9R/EOqrrwJZdzbmGzTuVqXcEbfDpmGzmLS7ISv
         8kjUBscL169EQ==
Date:   Wed, 14 Jul 2021 12:27:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix setup sequence for MSIXPERM table
Message-ID: <YO6K7CdodqjP758S@matsya>
References: <162456741222.1138073.1298447364671237896.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162456741222.1138073.1298447364671237896.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-06-21, 13:43, Dave Jiang wrote:
> The MSIX permission table should be programmed BEFORE request_irq()
> happens. This prevents any possibility of an interrupt happening before the
> MSIX perm table is setup, however slight.

Applied, thanks

-- 
~Vinod
