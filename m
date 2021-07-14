Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B501C3C7EBB
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 08:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbhGNGyY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 02:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238104AbhGNGyY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 02:54:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6B1D613AF;
        Wed, 14 Jul 2021 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626245493;
        bh=aC8YyFw7g3a24JrV8Copqbnq3nQ8kdn5UOWWkMjj3Q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sD1xA44YubdUkOxcLqoQOpPAIWdwCG56H/2kLARJOopPnqh/n4ESG6Cgwj8MAl/Cw
         qxRP5/8SBDpqzydb6OD44eX7WM8NVQUWtu3sRFzZ7KGXJjhUA8XZ5vGExQFjg6Pwic
         2l6VID+zz6ShQi52l8KN5BGL9v+OWRz0HbjIBCa8iBTWNDvSoGCjL4qAOThfeSVsg7
         Ew4w5pbiFqPsKMlK3JuS44vk8XVwqqsv7U20cG0YK3kA/zYkzYagGhBiTCm7eeDY2q
         JOeezEvW3GzR/xLxIFEuOv6luqK9qc613yKhxIni8VoBxofvZjCPttRrOiV0bWfju0
         ZzVwsi9FLcBRQ==
Date:   Wed, 14 Jul 2021 12:21:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmanegine: idxd: cleanup all device related bits
 after disabling device
Message-ID: <YO6JcTGtr7kxDOY1@matsya>
References: <162285154108.2096632.5572805472362321307.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162285154108.2096632.5572805472362321307.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-06-21, 17:06, Dave Jiang wrote:
> The previous state cleanup patch only performed wq state cleanups. This
> does not go far enough as when device is disabled or reset, the state
> for groups and engines must also be cleaned up. Add additional state
> cleanup beyond wq cleanup. Tie those cleanups directly to device
> disable and reset, and wq disable and reset.

Applied, thanks

-- 
~Vinod
