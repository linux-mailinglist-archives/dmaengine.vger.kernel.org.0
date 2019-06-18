Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 434CB4A608
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 18:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfFRQAd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 12:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbfFRQAd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Jun 2019 12:00:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D449D20873;
        Tue, 18 Jun 2019 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560873632;
        bh=aeNXodnXi36O/klAfsttiGYiQgAFv2Vf36sQFe+u0eY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5LIVr9M8OZSuB1bXNMzm+jfJiRw9O4tPWEMbbNrZUDDtLUCDyA1WhBgwHSoPtb40
         PWcRmjVnAMHMv3AbtlL9s2QwunuNGqfJwSDkfL4RLbq9GA61UJuycuNv/91401cTb1
         e020iCK0MRTinfdSnEbcS0MjrszGsZbbyN89UQZA=
Date:   Tue, 18 Jun 2019 18:00:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dma: amba-pl08x: no need to cast away call to
 debugfs_create_file()
Message-ID: <20190618160029.GA22218@kroah.com>
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
 <20190614054613.GB2962@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614054613.GB2962@vkoul-mobl>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 14, 2019 at 11:16:13AM +0530, Vinod Koul wrote:
> On 12-06-19, 14:25, Greg Kroah-Hartman wrote:
> > No need to check the return value of debugfs_create_file(), so no need
> > to provide a fake "cast away" of the return value either.
> 
> Applied all after fixing the subsystem tag (dmaengine), thanks

Oops, messed that up, sorry.  Thanks for applying them!

greg k-h
