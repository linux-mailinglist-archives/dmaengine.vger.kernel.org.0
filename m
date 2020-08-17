Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10A3245BC4
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 06:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgHQEzY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 00:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgHQEzW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 00:55:22 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4BAF206FA;
        Mon, 17 Aug 2020 04:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597640122;
        bh=iExS7r08vYlkhf1hA8mLYx2XkoNV5yAeDFTr75YqvPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDLtpECilYOtMd8bgGwiHKF2hBcPRISFZr11bQ9zyCd202TKZTw0TK8IN8stZG6Th
         ZYcsWnUHJTFgdSDbRo5qrxCjEslpTcOOaTW4RfJQYfgBnhAW/CxKxG8ungmTW2sgTd
         VFeda7eyKXljWCMcHRMZPRAAHIjWQffkiFzBM3iY=
Date:   Mon, 17 Aug 2020 10:25:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Mona Hossain <mona.hossain@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: reset states after device disable or
 reset
Message-ID: <20200817045518.GD2639@vkoul-mobl>
References: <159586777684.27150.17589406415773568534.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159586777684.27150.17589406415773568534.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-07-20, 09:37, Dave Jiang wrote:
> The state for WQs should be reset to disabled when a device is reset or
> disabled.

Applied, thanks

-- 
~Vinod
