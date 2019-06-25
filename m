Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5411952212
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 06:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFYEZI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 00:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfFYEZI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 00:25:08 -0400
Received: from localhost (unknown [106.201.40.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31A6820656;
        Tue, 25 Jun 2019 04:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561436707;
        bh=3T6SKEcFjkbKM6aaALMIK/+Tqx6ODcVS6SWlNzDr09I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BC0wuSSNup5Bw5ED5C9BZVbBzkbRp5GHgp+c7iuY2nV7bs5lyZhjAFzcsv4xucX2w
         h67TQyKHllU5gCt5rqJjhUPqMJch+TtBaEj+WloIcCiCP3a4Ad+HIENLQHB0j9tI76
         N/kcUknAi9tFLtjcuCx+gfXOHdw2EerwAqer7aPs=
Date:   Tue, 25 Jun 2019 09:51:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sh: usb-dmac: Use [] to denote a flexible
 array member
Message-ID: <20190625042157.GH2962@vkoul-mobl>
References: <20190619124555.12701-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619124555.12701-1-geert+renesas@glider.be>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-06-19, 14:45, Geert Uytterhoeven wrote:
> Flexible array members should be denoted using [] instead of [0], else
> gcc will not warn when they are no longer at the end of the structure.

Applied, thanks

-- 
~Vinod
