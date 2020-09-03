Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB9E25BB63
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgICHK2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 03:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgICHK1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 03:10:27 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE9182071B;
        Thu,  3 Sep 2020 07:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599117026;
        bh=bZRYAqXkgiT0s+oz2ZdjXapNFmBNr5z1Dj3rLu7IiSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RvT7xd+/rD1ig09623V8sF/yt3G8NmN3Zzpe3Xdg5h95D5OSNri8V0NzqoeI5cH6H
         I1DncGSzwmConUxZ6cgrF/4/qlEoXleDVxV73n3HV2n4sRcLa704DgB0I/GC257Bv5
         XwwlOFQIbC2X+A40RGd+tOwCwq1uuoNtsKjtq87o=
Date:   Thu, 3 Sep 2020 12:40:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: idxd: add support for configurable max
 wq xfer size
Message-ID: <20200903071022.GI2639@vkoul-mobl>
References: <159865265404.29141.3049399618578194052.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159865265404.29141.3049399618578194052.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-08-20, 15:12, Dave Jiang wrote:
> Add sysfs attribute max_xfer_size to wq in order to allow the max xfer
> size configured on a per wq basis. Add support code to configure
> the valid user input on wq enable. This is a performance tuning
> parameter.

Applied, thanks

-- 
~Vinod
