Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537D9F6E73
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 07:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKKGND (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 01:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfKKGND (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Nov 2019 01:13:03 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F12F72067B;
        Mon, 11 Nov 2019 06:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573452782;
        bh=NthoupRoaY5yarrl2arVlGsOeFSOOPS5cv6/FC6a8fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FALGwTePjsC0UkM2Pa/mIRJPHz0f+YjhRPz7DPMOR5l1LVU1xgcB5Ytvx4BLj8Pfo
         hftYoBXw4EKbE81flNNCRus1AGaRYIhuqtzuXvOKSH2OkSDn635soJYFcMSR3l4/vt
         wfCVGCenhiXc5K9pv4td8f7gdywcg3hg75vmZHOg=
Date:   Mon, 11 Nov 2019 11:42:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 15/15] dmaengine: ti: k3-udma: Add glue layer for non
 DMAengine users
Message-ID: <20191111061258.GS952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-16-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101084135.14811-16-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-11-19, 10:41, Peter Ujfalusi wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Certain users can not use right now the DMAengine API due to missing
> features in the core. Prime example is Networking.
> 
> These users can use the glue layer interface to avoid misuse of DMAengine
> API and when the core gains the needed features they can be converted to
> use generic API.

Can you add some notes on what all features does this layer implement..

-- 
~Vinod
