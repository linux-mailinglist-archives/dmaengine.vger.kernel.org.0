Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC3012662C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2019 16:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfLSPzD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Dec 2019 10:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSPzD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 19 Dec 2019 10:55:03 -0500
Received: from localhost (unknown [122.178.234.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226FA2067C;
        Thu, 19 Dec 2019 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576770902;
        bh=XAe58tWkatLiv8U7yH0Pi/yFrHc9gUQ/cOhT6V93d/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgcM8KNJxpwGrcMVhDHuqC5MbtAT1hNmQzgTKdAfgY0e5JaaUW148Cx5JLbqEMFhs
         WAACX1p3/uI99rrzjaMD4YAPnQyJHakW8rtvrOzwtOzDpNmJCCQk4rcUThtDUdnI5U
         4+/DMZ5Q3yqKJpH+KXnptFP2LRP4KAyH9ufe68Js=
Date:   Thu, 19 Dec 2019 21:24:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [v5 1/3] dmaengine: fsl-edma: Add eDMA support for
 QorIQ LS1028A platform
Message-ID: <20191219155458.GY2536@vkoul-mobl>
References: <20191212033714.4090-1-peng.ma@nxp.com>
 <20191218062636.GS2536@vkoul-mobl>
 <VI1PR04MB44311BE955B863C73DF4CD4CED530@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB44311BE955B863C73DF4CD4CED530@VI1PR04MB4431.eurprd04.prod.outlook.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-12-19, 08:08, Peng Ma wrote:
 >Btw pls send bindings as patch1 and driver changes as patch2.
> [Peng Ma] I don't understand this sentence, Please give me more information.
> As I know patch1 is driver changes, patch2 is dts changes, patch3 is binding changes.
> You accepted patch1 and patch3, I am puzzled for patch2 and your comments.

The order of patches should always be dt-bindings first, followerd by
driver change and the dts changes as the last one in the series.

-- 
~Vinod
