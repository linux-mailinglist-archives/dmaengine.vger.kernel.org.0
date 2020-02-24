Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB516AB9E
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2020 17:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBXQdH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Feb 2020 11:33:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgBXQdH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Feb 2020 11:33:07 -0500
Received: from localhost (unknown [122.182.199.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347322080D;
        Mon, 24 Feb 2020 16:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582561987;
        bh=UsXO/MKJqB6sN35rFEqzu9nCMOuzGGVfVnLKFzBPR6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEsocN0TnHhUwYt7DcNmIQTSvs1ts7DLf7kV2WfMvWjRtVu6dgb1q2V00PxJ+lklX
         x9gqah/d8+QneNoBy8/9ueuxePh7218pcwU1dpQEqAPW7OwqvDYrz1bZoIi6vD19f6
         KaTbv6hjsurDNqMibvhNoFRNGR+ChlLYZLTMZ3CI=
Date:   Mon, 24 Feb 2020 22:03:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, jerry.t.chen@intel.com
Subject: Re: [PATCH] dmaengine: idxd: wq size configuration needs to check
 global max size
Message-ID: <20200224163303.GZ2618@vkoul-mobl>
References: <158213309629.2509.3583411832507185041.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158213309629.2509.3583411832507185041.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-02-20, 10:24, Dave Jiang wrote:
> The current size_store() function for idxd sysfs does not check the total
> wq size. This allows configuration of all wqs with total wq size. Add check
> to make sure the wq sysfs attribute rejects storing of size over the total
> wq size.

Applied, thanks

-- 
~Vinod
