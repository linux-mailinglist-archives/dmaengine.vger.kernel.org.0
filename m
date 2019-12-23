Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7412913C
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 04:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfLWD5Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 22 Dec 2019 22:57:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfLWD5Y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 22 Dec 2019 22:57:24 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47A3E20709;
        Mon, 23 Dec 2019 03:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577073444;
        bh=HMWmu7fLzjD4zHWaJI1X0iL80kRp1P9VNuoGUhoQRKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xJzoeeF1/dw1fgzu36QaQ97BE8OM0U2I1GejPfCl/ybUsDko7hz9wVs/TpOoKeqXB
         zI8e03xUgf/NVbcZFVre+m7tAV5sDvB0/uxkYHkrxvky6uU+e5I9AztgISvrqW7AIh
         8krSe87z2BpOaWjH4TJVpWzP0qJ2pXGN0A1GxenQ=
Date:   Mon, 23 Dec 2019 11:57:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v5 2/3] arm64: dts: ls1028a: Update edma compatible to fit eDMA
 driver
Message-ID: <20191223035701.GK11523@dragon>
References: <20191212033714.4090-1-peng.ma@nxp.com>
 <20191212033714.4090-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212033714.4090-2-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Dec 12, 2019 at 03:38:15AM +0000, Peng Ma wrote:
> The eDMA of LS1028A soc has a little bit different from others, So we
> should distinguish them in driver by compatible.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

Applied, thanks.
