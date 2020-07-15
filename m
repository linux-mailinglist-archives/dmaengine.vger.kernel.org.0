Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D62204C5
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 08:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGOGHN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 02:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgGOGHN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 02:07:13 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F312065D;
        Wed, 15 Jul 2020 06:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594793233;
        bh=2+xZThBFLxH0R7ycOjaAP6v034IIMkBc6sW2wAJRZto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nm8Zw5DT0awT91HcYcbUOqUbBInuKH8c7osfKHA7qYEE4WxC0h0xPxE9+hU7UCULx
         3H2e8WC2lK7JQ0Pp3dEosnBAhESm+CrmhslHsEnY2ppzxb4G53NlN3/xlyVy/ayKuw
         L6/CzI6/v/w12vRjAvJlvj0nekcBsTMmXZk4SeAs=
Date:   Wed, 15 Jul 2020 11:37:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        grygorii.strashko@ti.com
Subject: Re: [PATCH v2 0/5] dmaengine: ti: k3-udma: cleanups for 5.8
Message-ID: <20200715060709.GY34333@vkoul-mobl>
References: <20200707102352.28773-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707102352.28773-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-07-20, 13:23, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> Changes since v1:
> - drop the check against NULL for uc in the IO functions as pointed out by
>   Grygorii

Applied all, thanks
-- 
~Vinod
