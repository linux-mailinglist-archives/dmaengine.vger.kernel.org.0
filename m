Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714B6861A2
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2019 14:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfHHM3J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Aug 2019 08:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfHHM3J (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Aug 2019 08:29:09 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B339C204EC;
        Thu,  8 Aug 2019 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565267348;
        bh=6jzux0+2vvckRewHmMdUXtSlDgM4FNrOY4r8OF3oAc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQ2IIjOdyPZYz8p/n9UOdJfzjP5Ie4l9sLrtdN1AbNjOBzXz6Uv6nztj9w/rA+zxe
         CZ5C1s2KkedVvmuGExd9Yj8FSPfYWe+w9BYnxy3qUB3lWuXMqnDMmTyWp6PeqwJyQk
         CtOVSp1HQ0KTpZlA6coKRkcdIXsC9slMOaPApKQI=
Date:   Thu, 8 Aug 2019 17:57:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>, agross@kernel.org,
        dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dma: qcom: hidma_mgmt: Add of_node_put() before goto
Message-ID: <20190808122756.GS12733@vkoul-mobl.Dlink>
References: <20190724081609.9724-1-nishkadg.linux@gmail.com>
 <eab2555a-07ad-9e48-14d4-e34417d52fbb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab2555a-07ad-9e48-14d4-e34417d52fbb@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-07-19, 13:25, Sinan Kaya wrote:
> On 7/24/2019 4:16 AM, Nishka Dasgupta wrote:
> > Each iteration of for_each_available_child_of_node puts the previous
> > node, but in the case of a goto from the middle of the loop, there is
> > no put, thus causing a memory leak. 
> > Hence add an of_node_put under the label that the gotos point to.
> > In order to avoid decrementing an already-decremented refcount, copy the
> > original contents of the label (including the return statement) to just
> > above the label, so that the code under the label is executed only when
> > a goto exit from the loop occurs.
> > Additionally, remove an unnecessary get/put pair from the loop, as the
> > loop itself already keeps track of refcount.
> > Issue found with Coccinelle.
> > 
> > Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> 
> nit: please post v3 with dmaengine:qcom:hidma_mgmt:....
> 
> Vinod doesn't like commit subjectss in this directory to have dma name
> on it. You can keep my acked-by.

That's right but I am okay to hand edit while applying for drive by
contributors :) so applied with you ack

> Acked-by: Sinan Kaya <okaya@kernel.org>
> 

-- 
~Vinod
