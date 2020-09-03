Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098A225BB40
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 08:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgICGwr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 02:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgICGwr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 02:52:47 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC2582071B;
        Thu,  3 Sep 2020 06:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599115966;
        bh=P18CZjRD/W4Ew6VMDrHnTNpb37ACkwWG8C0VdoI9qZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuG1YthJcyJlWHnXnWhKvO+lNOmDMinMA5JvV5GfgRJVYAa8Prr/gU0UCnLeYolud
         3QyZ7r+ZhD11rnMxg4tj20OOVL4FUu4PyfacTCqeu40oGtiqwlpbjtp4aIg1/XAXYO
         VNlME2GQW5QwwiRKz0Z15N4+MSAJea74fi2MSAmA=
Date:   Thu, 3 Sep 2020 12:22:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v1] dmaengine: Save few bytes and increase readability of
 dma_request_chan()
Message-ID: <20200903065242.GG2639@vkoul-mobl>
References: <20200828144519.14483-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828144519.14483-1-andriy.shevchenko@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-08-20, 17:45, Andy Shevchenko wrote:
> Split IS_ERR_OR_NULL() check followed by additional conditional
> to two simple conditionals. This increases readability and saves memory:
> 
> Function                                     old     new   delta
> dma_request_chan                             700     697      -3
> Total: Before=10224, After=10221, chg -0.03%

Applied, thanks

-- 
~Vinod
