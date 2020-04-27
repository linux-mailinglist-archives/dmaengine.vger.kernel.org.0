Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09091BAA02
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgD0QWM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 12:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgD0QWL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Apr 2020 12:22:11 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E02FC20661;
        Mon, 27 Apr 2020 16:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588004531;
        bh=9LbW4qUtouKNFJozDJIpgj15XYXSCwKEMWQ9rJwXIOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrMrGqcdleGrcpkXBFM5Uc0nxE5xSpARjJCRMxHEaIqSMegQ9xcCebyuj8EmSSZO7
         OF4uk4ArCDiDxTZEcHMLhUKkI5EVySWznaO4BNr1X108gDGpb9o6+/4qpcXulqOEf4
         qGu30VJ92fVHO6yvs5cjj4mfTfvIwhgKSgbnsMA0=
Date:   Mon, 27 Apr 2020 21:52:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v1 6/6] dmaengine: dmatest: Describe members of struct
 dmatest_info
Message-ID: <20200427162207.GP56386@vkoul-mobl.Dlink>
References: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
 <20200424161147.16895-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424161147.16895-6-andriy.shevchenko@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-04-20, 19:11, Andy Shevchenko wrote:
> Kernel documentation validator complains that not all members of
> struct dmatest_info are being described. Describe them all.

Applied, thanks

-- 
~Vinod
