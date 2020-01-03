Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C340912F48A
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jan 2020 07:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgACG0g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jan 2020 01:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgACG0f (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 3 Jan 2020 01:26:35 -0500
Received: from localhost (unknown [223.226.47.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6469D222C3;
        Fri,  3 Jan 2020 06:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578032795;
        bh=I2MPBt/h1Ehhn6LOq+XmZUH2ee6XMf4EzAUU5zX9p8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P1iQpkwWz4rC7feEKdMv3d3uCtNYWHSo83oCvmybwCGJTbPtM24k28etdAGlMALiJ
         2KGH+O3CvFLd05eotoB3kndwKfHrO6/K1h/xd2xVYdNIKxYTV8QutlShzSc7WflLNb
         O7QqGPbYvrNhgtOFmV6zMzeEtIC2580i1XmLA15Q=
Date:   Fri, 3 Jan 2020 11:56:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     kbuild-all@lists.01.org, kbuild test robot <lkp@intel.com>,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        Gary.Hook@amd.com, Nehal-bakulchandra.Shah@amd.com,
        Shyam-sundar.S-k@amd.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dmaengine: ptdma: Initial driver for the AMD
 PassThru DMA engine
Message-ID: <20200103062630.GD2818@vkoul-mobl>
References: <1577458047-109654-1-git-send-email-Sanju.Mehta@amd.com>
 <201912280738.zotyIgEi%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912280738.zotyIgEi%lkp@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-12-19, 07:56, kbuild test robot wrote:
> Hi Sanjay,
> 
> I love your patch! Perhaps something to improve:

Please fix the issues reported and also make sure the patches sent are
threaded, right now they are not and the series is all over my inbox :(

-- 
~Vinod
