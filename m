Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E1E484ED4
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jan 2022 08:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiAEHom (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jan 2022 02:44:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44746 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiAEHom (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jan 2022 02:44:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5EFB61476
        for <dmaengine@vger.kernel.org>; Wed,  5 Jan 2022 07:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31B6C36AE9;
        Wed,  5 Jan 2022 07:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641368681;
        bh=OwbeoNoAqXWNmxd5Hcc/5w18PUZZ4shXAJWqs65R2tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwNAwdo/wiTwMNydRE7qtcaKVxIrs6Hqtr8aHV5n/iVXA4zR8GXoqAfTkr12WrVX1
         GQNr+AG8Z1pSGcIL3DO0cchcYJ+LSb+4aJ5dBVCgITQ8KUiPp6OIk3amVCq/8h8l+V
         Q6mtXyOaNi9dq5rHxtsDOUPfphKe3dUzXTOLSqt2HSdyJpKbCWGBvipHqpyJJhYR76
         VmUwx+F8XwF/MoJvw/4kpWnq0qz/9IHM5ZPb8YKMBLhsiU6oUmsslByCt081yEhh+j
         ItyZ1DtNjsnzQs09M0n0LuSAMm/uEWCbd3v8/FOGlAj8RA3sErDNepIUGtu//pW5wb
         22izBIlDs2j2Q==
Date:   Wed, 5 Jan 2022 13:14:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/2] Repalce term 'token' with 'read buffer'
Message-ID: <YdVMZXH0pp+T3u+t@matsya>
References: <163951326835.2988321.1053110337527742301.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163951326835.2988321.1053110337527742301.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-12-21, 13:23, Dave Jiang wrote:
> DSA spec v1.2 has replaced the term 'token' with 'read buffer' to clarify
> the intended usage. Update driver to replace 'token' with 'read buffer' in
> order to be in sync with the spec and remove confusion.
> 
> Old token sysfs attributes is moved to deprecated under documentation and
> will print warning when used.

Applied, thanks

-- 
~Vinod
