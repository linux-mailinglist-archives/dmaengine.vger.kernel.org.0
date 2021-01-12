Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B32F2F0F
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 13:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbhALM3v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 07:29:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbhALM3v (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Jan 2021 07:29:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C1E522BE9;
        Tue, 12 Jan 2021 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610454550;
        bh=LIsCQTbTPde4ob3CZxrHmTmiyaoceJIArgT8rJ/3efE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+hQnf0S3qagBiYRgCiXIvgQZZ6971so0QrIg+hMYt+ziFBfIBQbZJ1wLPs7hObFk
         8XqhlT9BYLvIBS6ynEe/5/h9VZhvoS/ktw53f9l2c0vr4A0TFzD3uOuQO2KRSldNgY
         LapwQG5Mx2vB7jh5/Si5A2G1ATZ0YL8fw0LawU3DIFQ+Cu0oa81dDXbfH+8XDG9vtv
         r08teePlH42FMsrKLk1sCJQxljSiqUDpot8Xcg2xOjJBuaUYjQ+2lmeB8t/IJjN7Tu
         xtbquNAs1xr6NqHHVrNByaGN2z4XdbIRGVV1yV4hoowp5XVi4TthfBQ49LKiTWeddW
         rht0BDsq/kvQg==
Date:   Tue, 12 Jan 2021 17:59:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: Re: [PATCH v10 0/2] Add Intel LGM SoC DMA support
Message-ID: <20210112122905.GR2771@vkoul-mobl>
References: <cover.1606905330.git.mallikarjunax.reddy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1606905330.git.mallikarjunax.reddy@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-12-20, 12:10, Amireddy Mallikarjuna reddy wrote:
> Add DMA controller driver for Lightning Mountain (LGM) family of SoCs.
> 
> The main function of the DMA controller is the transfer of data from/to any
> peripheral to/from the memory. A memory to memory copy capability can also
> be configured. This ldma driver is used for configure the device and channnels
> for data and control paths.
> 
> These controllers provide DMA capabilities for a variety of on-chip
> devices such as SSC, HSNAND and GSWIP (Gigabit Switch IP).


Applied after fixing tag on driver patch, thanks

-- 
~Vinod
