Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A942AB77A
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 12:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKILsU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 06:48:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgKILsU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 06:48:20 -0500
Received: from localhost (unknown [122.171.147.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD2FF20731;
        Mon,  9 Nov 2020 11:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604922499;
        bh=KB/5M7Ek6j9mHrpKxfGwHZI3YfxY/ZTfMEJGmWZbR38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CO3zpppJSrZ1RYqTJtXywQwZW3+fh7uNK48qB1Edns8rR1DWUI1uuRy1gH2cHx4Gw
         qgo7R1KVly71jrLe27unLKNIcFJCtw3wekbX+SKA9nuGAX+FgbE4bbZwbgNn8fCVzB
         klI6f5ey4f73PrxOkf6qd7DFekNFGP3egKAkIaso=
Date:   Mon, 9 Nov 2020 17:18:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: define table offset multiplier
Message-ID: <20201109114815.GJ3171@vkoul-mobl>
References: <160407311690.839435.6941865731867828234.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160407311690.839435.6941865731867828234.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-10-20, 08:51, Dave Jiang wrote:
> Convert table offset multiplier magic number to a define.

Applied, thanks

-- 
~Vinod
