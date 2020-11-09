Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61522AB787
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 12:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgKILwK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 06:52:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgKILwK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 06:52:10 -0500
Received: from localhost (unknown [122.171.147.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95DC6206C0;
        Mon,  9 Nov 2020 11:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604922729;
        bh=9lt1UuaZOd+zk3FkSoJAeGRWeMlALMcN6qWpjRG6t0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZZGsVBn0EHuVMr2iit0C4aYys2F5d1ZdDX1AHCtbOqLzZ/F+/dEcnAQuaUyR1BYB
         TmmHTz2sj5zrz86N8206ShXVX8iqhU6JVcdWbPxzzVx/ujSzcrI5Nf4s8COT1P8377
         JuqLgVZwxzmrE4+f+I7u8JxMZ5XII+VgW0OQPphA=
Date:   Mon, 9 Nov 2020 17:22:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1] dmaengine: idma64: Switch to use __maybe_unused
 instead of ifdeffery
Message-ID: <20201109115205.GL3171@vkoul-mobl>
References: <20201104103131.89907-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104103131.89907-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-11-20, 12:31, Andy Shevchenko wrote:
> ifdeffery is prone to errors and makes code harder to read.
> Switch to use __maybe_unused instead of ifdeffery.


Applied, thanks

-- 
~Vinod
