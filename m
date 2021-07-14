Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B463C7ECF
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbhGNG6D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 02:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238168AbhGNG6D (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 02:58:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0DF2613AF;
        Wed, 14 Jul 2021 06:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626245712;
        bh=lI+NZGkbkt+jRN15yX+aSkxoPqflnE+/kbr86dBa0uQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMg+3ChgupDKgt673p8jVyZvEFf8b8nzKzTJfolQpbgtQs9LIzr6NhOIQKDlPTgsC
         uWRq6JI6MMUIkeID2rGKtWftSZMNAPtHF6D1zSxD++9uAtraQQeZIsP6K3moOjnQ/9
         7iQVG6yCug5HaoWG1yMlKpigaiDTEOH5BAorLeDQGeNHoEzZ2Ku7NgoJq83bIDtERE
         TUerhofXfxEV5UeSbrsj6GlzdjX1qc+wplYHbC51XCU26repLYamqDOwgWIk7oSpbZ
         8etKb2tk1PsmsKwxvyQ4jQJWNZ4SpC++yzAzMYgrphxlXokEdwrE3qGGA7SNuNp5nh
         oHNuzkKB4fmJA==
Date:   Wed, 14 Jul 2021 12:25:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Ramesh Thomas <ramesh.thomas@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: have command status always set
Message-ID: <YO6KTaeUsvNWHsFf@matsya>
References: <162274329740.1822314.3443875665504707588.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162274329740.1822314.3443875665504707588.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-06-21, 11:01, Dave Jiang wrote:
> The cached command status is only set when the write back status is
> is passed in. Move the variable set outside of the check so it is
> always set.

Applied, thanks

-- 
~Vinod
