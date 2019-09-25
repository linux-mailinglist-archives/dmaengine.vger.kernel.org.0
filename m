Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF0CBE28F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2019 18:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389326AbfIYQfQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Sep 2019 12:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389320AbfIYQfQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Sep 2019 12:35:16 -0400
Received: from localhost (unknown [12.206.46.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0910B21D7A;
        Wed, 25 Sep 2019 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569429316;
        bh=EQIgfd4Pl8s+2WAjOGkYRfW3VCER4B6mWgrNTVihk1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dE61ORBtVj4kwu+7PGniQ3DCcVo4G0oPaL4sEMfkx6K57ID4iTM7r35gmnRayAlng
         AKR4nHEoqxWhmnuc4xQNtOK56z4WiB1r8bkO0NEy0JuAefyJjJ9AaH4xkfGf3KgzmN
         WC2E8YbFdGK/bWPIBEsu04tJwG0MMaGdXO/sT+1Q=
Date:   Wed, 25 Sep 2019 09:34:14 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [EXT] Re: [V4 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Message-ID: <20190925163414.GH3824@vkoul-mobl>
References: <20190613101341.21169-1-peng.ma@nxp.com>
 <20190613101341.21169-2-peng.ma@nxp.com>
 <20190624164556.GD2962@vkoul-mobl>
 <VI1PR04MB443142772665BB29B909DFF4EDB10@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20190924193446.GF3824@vkoul-mobl>
 <VI1PR04MB44314EF818033EB52D0A591DED870@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB44314EF818033EB52D0A591DED870@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-09-19, 02:27, Peng Ma wrote:

> >Can you please resend me after rc1 is out and I will review it and do the
> >needful
> [Peng Ma] Got it. By the way, when will rc1 out?

It is supposed to be out on coming monday!

-- 
~Vinod
