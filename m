Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D7D86335
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2019 15:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbfHHNdS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Aug 2019 09:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733087AbfHHNdS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Aug 2019 09:33:18 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA1021479;
        Thu,  8 Aug 2019 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565271197;
        bh=ItdyOog//IGZbQXPEDS/rq8kS831yi3bvAZtUvSenv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c46Um6Va7v3CnH2hgePtURNEK1/WTamfNLKJyBSYedEYWEpP7GIVXXbfhIceURtJz
         roB1fS8vKETVoGDhCU7XkpGSH6kdk8JUdHiMNF56bfum4v0LcMUUUZx7bOR4FzrIqc
         bs8PZJIOc/5Lu9mocbm8zL4YHxslJ7pnEsj4O0lg=
Date:   Thu, 8 Aug 2019 19:02:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     dmaengine@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: implement .device_synchronize
 callback
Message-ID: <20190808133206.GB12733@vkoul-mobl.Dlink>
References: <20190731173659.14778-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731173659.14778-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-07-19, 10:36, Andrey Smirnov wrote:
> Implement .device_synchronize callback in order to be able to use
> dmaengine_terminate_sync() and other primitives relying on said
> callback.

Applied, thanks

-- 
~Vinod
