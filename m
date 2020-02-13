Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6704F15C081
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 15:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgBMOk0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 09:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMOk0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Feb 2020 09:40:26 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7252073C;
        Thu, 13 Feb 2020 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581604825;
        bh=X+nVn/KllRbxZ51X+/sFqxu5WCy0rj3TcHJxSKDPpSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7MseGzl4cyJlD/BjL+JTOZsiZNhdRCypvQe+RcAy0oSLK9TKUHVEgTRi8exKc4j5
         GRVp9ZFeys5w7dYKmNXJH/mlXp11PEZk6PcJEkKPeqThwLAyDX3HIHW6CCH2V/ti7p
         /9XZzcOSEW1j+grY+8fEcoIJWVgBrjp3a2M8F5O0=
Date:   Thu, 13 Feb 2020 20:10:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, jerry.t.chen@intel.com
Subject: Re: [PATCH] dmaengine: idxd: fix runaway module ref count on device
 driver bind
Message-ID: <20200213144021.GJ2618@vkoul-mobl>
References: <158144296730.41381.12134210685456322434.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158144296730.41381.12134210685456322434.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-02-20, 10:42, Dave Jiang wrote:
> idxd_config_bus_probe() calls try_module_get() but never calls module_put()
> when it fails. Thus with every failed attempt, the ref count goes up. Add
> module_put() in failure paths.

Applied, thanks

-- 
~Vinod
