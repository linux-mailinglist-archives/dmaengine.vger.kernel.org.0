Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEC23C7ECE
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 08:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhGNG5m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 02:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238194AbhGNG5m (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 02:57:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6F7F613AF;
        Wed, 14 Jul 2021 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626245691;
        bh=mcLVo1Zs/TFD21I7ys3fSdZjHbSyZizn8915TOLTjIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjNgcHky1vRpnFgbvMB76GHxg5cHmAagaJ+xoWgG1Kle8c7dRmXHH42a4THWLxSnY
         C5Ek5zZoQiGL2QW/Q7nwc1CNKhVPmG1JS7KBAfcAVf4jA5RcpHufIsEQsEy2U/R20r
         Hn/mdGILAZJ47mkT/nixmJod3wqiIdT7igCgR6iiRDziZkbvbbJXXtDzZpvOBdc78H
         fnM53InkdFqKaA6GMp6n+227G1ftoHQQzEU1uNTsE0O9FR1ooqgQ/b7uRZ0tj2cu52
         CNMdn2kyzRSMYMrWou5u+MAGqN9JIdCfTqRbq8o3dX9/B8BAWA1dnhgms3OPPzDwB5
         fZ3AKbbN2Ap7Q==
Date:   Wed, 14 Jul 2021 12:24:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Add wq occupancy information to sysfs
 attribute
Message-ID: <YO6KN2vl6x3e6yUF@matsya>
References: <162275745546.1857062.8765615879420582018.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162275745546.1857062.8765615879420582018.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-06-21, 14:57, Dave Jiang wrote:
> Add occupancy information to wq sysfs attribute. Attribute will show
> wq occupancy data if "WQ Occupancy Support" field in WQCAP is 1. It
> displays the number of entries currently in this WQ. This is provided
> as an estimate and should not be relied on to determine whether there
> is space in the WQ. The data is to provide information to user apps
> for flow control.

Applied, thanks

-- 
~Vinod
