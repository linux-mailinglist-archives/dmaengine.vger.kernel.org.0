Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0D73C7ED7
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 08:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbhGNHBT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 03:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237948AbhGNHBS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 03:01:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E77B46100C;
        Wed, 14 Jul 2021 06:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626245907;
        bh=7rYn8qhbP5gr0VccdQ6vD/FAZ5ES5/hm8SCvpF8lbiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQjAsrNvA3w7Ky/28cSk2Yj/jOBMl2nCk+QfIFAF7BuRWCacv7apzEZEczCdIdj0a
         rwZAGIEqrozbLJU/RJn5C08JqiRihxeGADwq6cmWCa2BIuNlIl2HU2brRFvirO4MAj
         0zBxjF0KtADnfub2dbXSm23OKe5zGOBcx5J8JtaPVwlqBsAXoLJBGUpVAYezYYk1MC
         KKqFHhWYWIrg+A5rHIQsb5DXOwRd45wIpJ5ZNJkaYYdN+tBsf/N4wwMqf6MM/AlR2O
         JEYKY+O424jz1OssrtOPP2DJ4FHrRSCYy5UOg6cNNLZZS+By/JIrsGB2bWT+dgRCv5
         MwskSETrDt75w==
Date:   Wed, 14 Jul 2021 12:28:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add missing percpu ref put on failure
Message-ID: <YO6LEIJbUSb03c3j@matsya>
References: <162456170168.1121236.7240941044089212312.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162456170168.1121236.7240941044089212312.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-06-21, 12:08, Dave Jiang wrote:
> When enqcmds() fails, exit path is missing a percpu_ref_put(). This can
> cause failure on shutdown path when the driver is attempting to quiesce the
> wq. Add missing percpu_ref_put() call on the error exit path.

Applied, thanks

-- 
~Vinod
