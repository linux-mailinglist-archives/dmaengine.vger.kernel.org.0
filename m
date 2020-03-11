Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1118152A
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 10:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgCKJjz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 05:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgCKJjz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 05:39:55 -0400
Received: from localhost (unknown [106.201.105.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA07F2146E;
        Wed, 11 Mar 2020 09:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583919594;
        bh=lhnzTD/dwZ8nvzuqm+ehmz75guGTEPK5tTN32J+7k7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDkoj+TK5NH7T/fy7e7IGAluEi6vZ2XKOsF7rLd2pt2OoNVlf/GN85c75DwjwYfAJ
         tmqP1lhnOq0OdPF/oFCAfBN93nxlJbHi6VwWCMYgMe28O3QNbYnK73dJkaDzBejypJ
         5gG+N+bNse0CDxxLWjEOm/tpNtA7h8QAHGQU2Gj8=
Date:   Wed, 11 Mar 2020 15:09:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, tony.luck@intel.com
Subject: Re: [PATCH] dmaengine: idxd: Merge definition of dsa_batch_desc into
 dsa_hw_desc
Message-ID: <20200311093950.GR4885@vkoul-mobl>
References: <158387868208.35922.5895104426944263789.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158387868208.35922.5895104426944263789.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-03-20, 15:18, Dave Jiang wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> We don't need a special structure just for batch descriptors. The
> layout matches the general form for other descriptors.
> 
> Merge the desc_list_addr field into the union of other aliases for
> the the third quadword in the structure.
> 
> Create a union to alias "xfer_size" with "desc_count".

Applied, thanks

-- 
~Vinod
