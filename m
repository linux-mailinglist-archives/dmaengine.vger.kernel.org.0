Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFFD60156
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 09:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfGEHUF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 03:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfGEHUF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jul 2019 03:20:05 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5DB3218BB;
        Fri,  5 Jul 2019 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562311204;
        bh=1uqDzrpBxZPWMFNSI0wJ4J/DrSHxwiBbUr7CRF8qQxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzKeQy7UmXpxHB9XrFz9e6393jobald8LYWcpIiUCpZyVZQoxiq2MiurlFvuALG5U
         CANHFx7p1T+C976Qv2+5cZeUJi/oI1TLSgya0cpI9yb8EK5yiL+JMlbl53qBuwmPVt
         +h/z+bZ6vmHKW4XE951ywiHsPs7atPkGaZlbLBL4=
Date:   Fri, 5 Jul 2019 12:46:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: jz4780: Fix an endian bug in IRQ handler
Message-ID: <20190705071646.GZ2911@vkoul-mobl>
References: <20190624134940.GC1754@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624134940.GC1754@mwanda>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-06-19, 16:49, Dan Carpenter wrote:
> The "pending" variable was a u32 but we cast it to an unsigned long
> pointer when we do the for_each_set_bit() loop.  The problem is that on
> big endian 64bit systems that results in an out of bounds read.

Applied, thanks

-- 
~Vinod
