Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB401437CB
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 08:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgAUHlX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 02:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgAUHlX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 02:41:23 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B2F2253D;
        Tue, 21 Jan 2020 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579592483;
        bh=qL0bG8t0a29UEckKmtSr4GhjBXsVZzayHhqiBlD7ISY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2VPXr5ZvaJzoURnqhDyGmynma/up6Pi6xhYxTPsDAC9Xla4u+SRJEeYyHQgRYvOr
         Yx7LnZO0Lb5KIAo1ZB5T0v6QKhhVDBZU/8BCNcEQxpuWMaerIM8VLSc8FCs9r/Y/fT
         v0sAdCig0VXhDcDzc2GKgwTa59RaStewP2Ho+YSM=
Date:   Tue, 21 Jan 2020 13:11:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com, vigneshr@ti.com, frowand.list@gmail.com
Subject: Re: [PATCH v8 00/18] dmaengine/soc: Add Texas Instruments UDMA
 support
Message-ID: <20200121074118.GB2841@vkoul-mobl>
References: <20191223110458.30766-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223110458.30766-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-12-19, 13:04, Peter Ujfalusi wrote:
> Hi,
> 
> Vinod, Nishanth, Tero, Santosh: the ti_sci patch in this series was sent
> upstream over a month ago:
> https://lore.kernel.org/lkml/20191025084715.25098-1-peter.ujfalusi@ti.com/
> 
> I'm still waiting on it's fate (Tero has given his r-b).
> The ti_sci patch did not made it to 5.5-rc1, but I included it in the series and
> let the maintainers decide if it can go via DMAengine for 5.6 or to later
> releases (5.6 probably for the ti_sci and 5.7 for the UDMA driver patch).
> 
> Patch 1-11 is the initial DMA support which can be applied as it is.
> Patch 12-13 adds support for j721e tdtype for ti_sci and the UDMAP driver
> Patch 14-15 exports the currently unexported functions:
> 		devm_ti_sci_get_of_resource()
> 		of_msi_get_domain()
> Patch 16-18 makes the ringacc, DMAengine and glue layer buildable as module.
> 
> Changes since v7:
> (https://lore.kernel.org/lkml/20191209094332.4047-1-peter.ujfalusi@ti.com/)

Applied 3-11 after merged tag from Santosh, thanks

-- 
~Vinod
