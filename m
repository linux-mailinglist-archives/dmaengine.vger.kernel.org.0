Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011481BA9EF
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 18:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgD0QS2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 12:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0QS2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Apr 2020 12:18:28 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7394C2064A;
        Mon, 27 Apr 2020 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588004308;
        bh=Pztu+j3amLQDHLkEboGi9hmbEctsEPTpHHmHT4Wt2RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eg57ImbwhZpzrBtcc4ef3ypdYrxL3g98RjCVxmTm+vGmKlerf+M+vM+MDxIWTYwB7
         Yb27BADlHpsggRKOrZY0mGjOlyi4X9e4fBgI79oQuPGAys8rDjNs8MDap0rYnWQ5dU
         PiUi5op7LR0MUJ5npWSLppcwXO669nH/rT84Sl84=
Date:   Mon, 27 Apr 2020 21:48:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Gary Hook <Gary.Hook@amd.com>
Subject: Re: [PATCH v1 4/6] dmaengine: dmatest: Allow negative timeout value
 to specify infinite wait
Message-ID: <20200427161824.GN56386@vkoul-mobl.Dlink>
References: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
 <20200424161147.16895-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424161147.16895-4-andriy.shevchenko@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-04-20, 19:11, Andy Shevchenko wrote:
> The dmatest module parameter 'timeout' is documented as accepting a -1 to mean
> "infinite timeout". However, an infinite timeout is not advised, nor possible
> since the module parameter is an unsigned int, which won't accept a negative
> value. Change the parameter type to be signed integer.

Applied, thanks

-- 
~Vinod
