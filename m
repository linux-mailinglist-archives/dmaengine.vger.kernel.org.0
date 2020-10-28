Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CACD29D6BD
	for <lists+dmaengine@lfdr.de>; Wed, 28 Oct 2020 23:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbgJ1WSG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 18:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731747AbgJ1WRo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:44 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4968E207DE;
        Wed, 28 Oct 2020 05:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603864339;
        bh=P7c4bOTUqJL1K3sIAdeq9Skrg7YWtzHj1bj36iol3sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HP0BdWTBW0SRlhwiC8W3xnh0G23DSa3UhTs++DhWbFh4ttKkggCPSdzX/jeNrF/nh
         XA6DKIuD5rSgt8JUOiNSwlo7lHZi4nF1jifrIAhHy0jWbrjbyjbEzoYczmbi/aueNG
         JHplevZhmwuBaGqPal8B1iKgMNjRrPBxdNVbIkr8=
Date:   Wed, 28 Oct 2020 11:22:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Yu Kuai <yukuai3@huawei.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma: fix -Wenum-conversion warning
Message-ID: <20201028055214.GG3550@vkoul-mobl>
References: <20201026160123.3704531-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026160123.3704531-1-arnd@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-10-20, 17:01, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about a mismatch argument type when passing
> 'false' into a function that expects an enum:
> 
> drivers/dma/ti/k3-udma-private.c: In function 'xudma_tchan_get':
> drivers/dma/ti/k3-udma-private.c:86:34: warning: implicit conversion from 'enum <anonymous>' to 'enum udma_tp_level' [-Wenum-conversion]
>   86 |  return __udma_reserve_##res(ud, false, id);   \
>      |                                  ^~~~~
> drivers/dma/ti/k3-udma-private.c:95:1: note: in expansion of macro 'XUDMA_GET_PUT_RESOURCE'
>    95 | XUDMA_GET_PUT_RESOURCE(tchan);
>       | ^~~~~~~~~~~~~~~~~~~~~~
> 
> In this case, false has the same numerical value as
> UDMA_TP_NORMAL, so passing that is most likely the correct
> way to avoid the warning without changing the behavior.

Applied, thanks

-- 
~Vinod
