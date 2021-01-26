Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CAA304BC2
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 22:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbhAZVvi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 16:51:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbhAZRWj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Jan 2021 12:22:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 865462083E;
        Tue, 26 Jan 2021 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611681719;
        bh=TASZTc/3PIsXIGzQfYoIfGjxvFDnMCxL+YR5dhnOxdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rY70kPhwzGhzX3wkpXcPXTOXTU+h5QgN3te5A0JRcYCtRck2OPXwWj5yk2qkN764u
         g2qGpFOwXjEMFklMrv7EnmR332hBqTb8kP48tzub4CLvUuHhX9mt59FMc7N+36B1Eb
         k5ROUrbQJ60S9cpDGV45VpQ8DMJ85BC8kpoPQOxSfEWuLolCEqNHEFhG6Q6mCdOI/v
         XfygXWSJvHQleMuJwEjCg/TDdKoLU8D3kgbXrfhvsIAez7+uyK4PVw9YbkJZXAEVyi
         2SYNjc5vUp6HRB6ZaWYs51M7aIJGp5L/rzGrX2A+ZRPDbmfJiWQxksecyT7HXfpQgU
         bHrjB6Dk4OlmA==
Date:   Tue, 26 Jan 2021 22:51:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, malliamireddy009@gmail.com
Subject: Re: [PATCH 1/1] dt-bindings: dma: intel-ldma: Fix for JSON pointers
 syntax error
Message-ID: <20210126172155.GU2771@vkoul-mobl>
References: <2c0d0d87352a3af132c4eb18e9e1581e03b03eba.1611202226.git.mallikarjunax.reddy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0d0d87352a3af132c4eb18e9e1581e03b03eba.1611202226.git.mallikarjunax.reddy@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-01-21, 12:12, Amireddy Mallikarjuna reddy wrote:
> There have been some fixes for JSON pointers and tools check now got this is missing a '/'.
> Add missing a '/' in '/schemas/types.yaml#definitions/uint32'

Already applied patch from Bjorn which came before this

-- 
~Vinod
