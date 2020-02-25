Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CED416B95B
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2020 06:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgBYF6T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Feb 2020 00:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgBYF6S (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Feb 2020 00:58:18 -0500
Received: from localhost (unknown [122.167.120.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762FE21556;
        Tue, 25 Feb 2020 05:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582610298;
        bh=3x89xgf7xxq4FVLTkmtbaDJFe1Xqyo/RXje3LSgzdEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeEdxlwisUDLy1PjDt8Hghp/Fb59b9al0nD8imAO4f44O69+jObC2K7WMZ04MNrvN
         ctgqI+ZKjjcnBSo1lTyJ/j8hJEMtuLHK3odvGMC8UykvMc8ENLrWYfk/hzi4nKX6lU
         KP6feZ+Cgyl0HoPSL6iL1dzC696lImYDchbx+fyQ=
Date:   Tue, 25 Feb 2020 11:28:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     Ludovic.Desroches@microchip.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] dmaengine: at_hdmac: Substitute kzalloc with
 kmalloc
Message-ID: <20200225055814.GI2618@vkoul-mobl>
References: <20200123140237.125799-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-01-20, 14:03, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> All members of the structure are initialized below in the function,
> there is no need to use kzalloc.

Applied, thanks

Please use cover letter for long series..

-- 
~Vinod
